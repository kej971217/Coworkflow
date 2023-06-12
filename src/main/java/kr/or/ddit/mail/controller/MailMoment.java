package kr.or.ddit.mail.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import kr.or.ddit.mail.MailDefaultPaginationRenderer;
import kr.or.ddit.mail.service.MailAuthService;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.service.MailStoreGmailService;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailPagination;
import kr.or.ddit.mail.vo.MailSendVO;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

/**
 * 임시 보관 메일 목록 조회
 */
@Slf4j
@Controller
@RequestMapping("/mail/mailDraft")
public class MailMoment {
	@Inject
	MailService mailService;
	@Inject
	MailAuthService mailAuthService;
	@Inject
	MailStoreGmailService mailStoreGmailService;

	/**
	 * Gmail로부터 임시보관함 메일 받기(새로고침)
	 * 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 * @throws MessagingException
	 * @throws IOException
	 * @throws CloneNotSupportedException
	 */
	@GetMapping("/draftListOpen.do")
	public String open(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session)
			throws MessagingException, IOException, CloneNotSupportedException {
//		log.info("임시보관함 메서드 진입");
		// 토큰/DB 정보 뷰로 가져가기
		String empId = authentication.getName();
		String userId = mailService.retrieveEmployeeEmailAddress(empId);
		String accessToken = "";

//		log.info("토큰 존재 확인");
		// 액세스 토큰 유효 확인
		// 토큰 유효 확인 반환 : return "OK";
		String checkTokens = mailAuthService.checkTokens(empId);
		if (checkTokens.equals("OK")) {
			accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//			log.info("임시보관함 새로고침 진입 액세스 토큰 확인 : {}", accessToken);
		} else {
			// 유효하지 않으면 전체 재발급
			session.setAttribute("draft", "redirect:/mail/mailDraft/drafts.do");
			return "redirect:/mail/authorization/authorizationRequest.do";// 내부 URL 리다이렉트
		}

		// -------------------------------- 메세지 목록 받기 From Gmail 시작
		// --------------------------------
		String responseEntityBodyForMessageIdList = mailStoreGmailService.getDraftMessageIdListFromGmail(accessToken);
		ObjectMapper om = new ObjectMapper();
		Map<String, Object> responseSize = om.readValue(responseEntityBodyForMessageIdList,
				new TypeReference<Map<String, Object>>() {
				});
//        log.info("임시보관 draftId 목록 받기 성공 : {}", responseEntityBodyForMessageIdList);

		int resultSize = Integer.parseInt(responseSize.get("resultSizeEstimate").toString());
		if (resultSize < 1) {
			model.addAttribute("level1Menu", "mail");
			model.addAttribute("level2Menu", "mailDraft");
			return "mail/mailDrafts";
		}
		// JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
		ObjectMapper objectMapper = new ObjectMapper();

		Map<String, Object> responseJavaMap;
		try {
			// JSON 문자열을 Map으로 변환
			// 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭
			// 타입)을 명시적으로 지정
			// Jackson 라이브러리 예외 처리
			responseJavaMap = objectMapper.readValue(responseEntityBodyForMessageIdList,
					new TypeReference<Map<String, Object>>() {
					});
		} catch (JsonProcessingException e) {
			throw new RuntimeException(e);
		}

		int messagePagingTotal = mailStoreGmailService.getTotalCountFromList(responseJavaMap);// 페이징용 resultSizeEstimate
																								// 추출
//		log.info("resultSizeEstimate : {}", messagePagingTotal);

		List<Map<String, Object>> draftsList = mailStoreGmailService.getDraftsFromList(responseJavaMap);// draft 추출
		try {
//            log.info("draft 개수 : {}", draftsList.size());
			draftsList.size();
			if (draftsList.size() < 1) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailDraft");
				return "mail/mailDrafts";
			}
		} catch (NullPointerException e) {
			model.addAttribute("level1Menu", "mail");
			model.addAttribute("level2Menu", "mailDraft");
			return "mail/mailDrafts";
		}

		List<String> draftIdList = new ArrayList<>();
		for (Map<String, Object> drafts : draftsList) {
			String draftId = drafts.get("id").toString();
			draftIdList.add(draftId);
		}
		// -------------------------------- 메세지 목록 받기 From Gmail 종료
		// --------------------------------
		// -------------------------------- 메일 받기 From Gmail 시작
		// --------------------------------
		List<Map<String, Map<String, Object>>> notOrganizeEmailList = new ArrayList<>();
		for (String draftId : draftIdList) {
//            log.info("임시보관 메일 요청 전");
			String anEmail = mailStoreGmailService.getEachDraftFromGmail(accessToken, draftId);
//            log.info("임시보관 메일 : {}", anEmail);

			// JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
			ObjectMapper objectMapperForResponseGmail = new ObjectMapper();
			Map<String, Object> responseJsonMap;
			try {
				// JSON 문자열을 Map으로 변환
				// 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭
				// 타입)을 명시적으로 지정
				// Jackson 라이브러리 예외 처리
				responseJsonMap = objectMapperForResponseGmail.readValue(anEmail,
						new TypeReference<Map<String, Object>>() {
						});

			} catch (JsonProcessingException e) {
				throw new RuntimeException(e);
			}
			Map<String, Map<String, Object>> keyMap = new HashMap<>();
			keyMap.put(draftId, responseJsonMap);
			notOrganizeEmailList.add(keyMap);
//            log.info("임시보관 메일 받기 확인 : {}", notOrganizeEmailList.size());
		}
		// -------------------------------- 메일 받기 From Gmail 종료
		// --------------------------------
		// -------------------------------- 메일 정리 + DB 정리 시작
		// --------------------------------
		List<List<MailBoxVO>> readyForAttachList = mailService.organizeDraftEmail(notOrganizeEmailList, draftIdList,
				empId, accessToken);
//        log.info("임시보관 메일 처리 확인 : {}", readyForAttachList.size());
		// -------------------------------- 메일 정리 + DB 정리종료
		// --------------------------------
		// -------------------------------- 메일 출력 준비 시작 --------------------------------
//        log.info("임시보관 메일 출력 준비 시작");
		List<MailBoxVO> draftIdsList = mailService.retrieveDraftIdFromDBDraft(empId);

		List<MailBoxVO> readyForViewList = new ArrayList<>();
		for (MailBoxVO draftIdVO : draftIdsList) {
			MailBoxVO mailbox = new MailBoxVO();
			String draftId = draftIdVO.getMailDraftId();
			mailbox.setEmpId(empId);
			mailbox.setMailDraftId(draftId);
			List<MailBoxVO> tempList = mailService.retrieveViewFromDBDraft(mailbox);

			if (tempList.size() > 0) {
				List<MailBoxVO> viewList = new ArrayList<>();
				MailBoxVO mailPrint = tempList.get(0);
				LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
				LocalDateTime mailDateTime = mailPrint.getMailSendDate();// DB 저장한 일시 불러오기
				if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
				} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
				}
				readyForViewList.add(mailPrint);
			}
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
//        log.info("임시보관 메일 페이지네이션 시작");
		try {
//            log.info("페이지네이션 적용 전 메일 확인 : {} 개", readyForViewList.size());
//            log.info("페이지네이션 적용 전 메일 확인 : {}", readyForViewList);

		} catch (NullPointerException e) {
		}
		MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
		{
			mailPagination.setCurrentPage(currentPage);
			mailPagination.setSimpleCondition(simpleCondition);

			int totalRows = 0;
			try {
				totalRows = readyForViewList.size();
				if (totalRows < 1) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailDraft");
					return "mail/mailDrafts";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailDraft");
				return "mail/mailDrafts";
			}
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setDataList(readyForViewList);
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}

		Gson gson = new Gson();
		String pagination = gson.toJson(mailPagination);
//        log.info("제이슨 확인 : {}", pagination);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailDraft");
		model.addAttribute("mailList", pagination);
		model.addAttribute("rendererPagination", rendererPagination);

//        log.info("임시보관 새로 불러오기 메서드 종료");
		return "mail/mailDrafts";

	}// 임시 보관함 open() 종료 (새로고침 용)

	/**
	 * Gmail로부터 임시보관함 메일 받기(DB)
	 * 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 * @throws MessagingException
	 * @throws IOException
	 * @throws CloneNotSupportedException
	 */
	@GetMapping("/drafts.do")
	public String openDrafts(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session)
			throws MessagingException, IOException, CloneNotSupportedException {
//		log.info("임시보관함 메서드 진입");
		// 토큰/DB 정보 뷰로 가져가기
		String empId = authentication.getName();
		String userId = mailService.retrieveEmployeeEmailAddress(empId);
		String accessToken = "";

		// 액세스 토큰 유효 확인
		// 토큰 유효 확인 반환 : return "OK";
		String checkTokens = mailAuthService.checkTokens(empId);
		if (checkTokens.equals("OK")) {
			accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//			log.info("받은 메일함 진입 액세스 토큰 확인 : {}", accessToken);
		} else {
			// 유효하지 않으면 전체 재발급
			session.setAttribute("draft", "redirect:/mail/mailDraft/drafts.do");
			return "redirect:/mail/authorization/authorizationRequest.do";// 내부 URL 리다이렉트
		}

		// -------------------------------- 메일 출력 준비 시작 --------------------------------
//        log.info("임시보관 메일 출력 준비 시작");
		List<MailBoxVO> draftIdsList = mailService.retrieveDraftIdFromDBDraft(empId);

		List<MailBoxVO> readyForViewList = new ArrayList<>();
		for (MailBoxVO draftIdVO : draftIdsList) {
			MailBoxVO mailbox = new MailBoxVO();
			String draftId = draftIdVO.getMailDraftId();
			mailbox.setEmpId(empId);
			mailbox.setMailDraftId(draftId);
			List<MailBoxVO> tempList = mailService.retrieveViewFromDBDraft(mailbox);

			if (tempList.size() > 0) {
				List<MailBoxVO> viewList = new ArrayList<>();
				MailBoxVO mailPrint = tempList.get(0);
				LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
				LocalDateTime mailDateTime = mailPrint.getMailSendDate();// DB 저장한 일시 불러오기
				if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
				} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
				}
				readyForViewList.add(mailPrint);
			}
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
//        log.info("임시보관 메일 페이지네이션 시작");
		try {
//            log.info("페이지네이션 적용 전 메일 확인 : {} 개", readyForViewList.size());
//            log.info("페이지네이션 적용 전 메일 확인 : {}", readyForViewList);

		} catch (NullPointerException e) {
		}
		MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
		{
			mailPagination.setCurrentPage(currentPage);
			mailPagination.setSimpleCondition(simpleCondition);

			int totalRows = 0;
			try {
				totalRows = readyForViewList.size();
				if (totalRows < 1) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailDraft");
					return "mail/mailDrafts";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailDraft");
				return "mail/mailDrafts";
			}
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setDataList(readyForViewList);
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}

		Gson gson = new Gson();
		String pagination = gson.toJson(mailPagination);
//        log.info("제이슨 확인 : {}", pagination);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailDraft");
		model.addAttribute("mailList", pagination);
		model.addAttribute("rendererPagination", rendererPagination);

//        log.info("임시보관 새로 불러오기 메서드 종료");
		return "mail/mailDrafts";

	}// 임시 보관함 open() 종료 (새로고침 용)

	/**
	 * Gmail로부터 임시보관함 메일 받기(새로고침)
	 * 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 * @throws MessagingException
	 * @throws IOException
	 * @throws CloneNotSupportedException
	 */
	@GetMapping("/draftViewOpen.do")
	public String openDraft(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session)
			throws MessagingException, IOException, CloneNotSupportedException {
//        log.info("임시보관함 기존 DB 등록 메일 열기 메서드 진입");
		String empId = authentication.getName();
		// -------------------------------- 메일 출력 준비 시작 --------------------------------
//        log.info("임시보관 메일 출력 준비 시작");
		List<MailBoxVO> draftIdsList = mailService.retrieveDraftIdFromDBDraft(empId);

		List<MailBoxVO> readyForViewList = new ArrayList<>();
		for (MailBoxVO draftIdVO : draftIdsList) {
			MailBoxVO mailbox = new MailBoxVO();
			String draftId = draftIdVO.getMailDraftId();
			mailbox.setEmpId(empId);
			mailbox.setMailDraftId(draftId);
			List<MailBoxVO> tempList = mailService.retrieveViewFromDBDraft(mailbox);

			if (tempList.size() > 0) {
				List<MailBoxVO> viewList = new ArrayList<>();
				MailBoxVO mailPrint = tempList.get(0);
				LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
				LocalDateTime mailDateTime = mailPrint.getMailSendDate();// DB 저장한 일시 불러오기
				if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
				} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
					mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
				}
				readyForViewList.add(mailPrint);
			}
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
//        log.info("임시보관 메일 페이지네이션 시작");
		try {
//            log.info("페이지네이션 적용 전 메일 확인 : {} 개", readyForViewList.size());
//            log.info("페이지네이션 적용 전 메일 확인 : {}", readyForViewList);

		} catch (NullPointerException e) {
		}
		MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
		{
			mailPagination.setCurrentPage(currentPage);
			mailPagination.setSimpleCondition(simpleCondition);

			int totalRows = 0;
			try {
				totalRows = readyForViewList.size();
				if (totalRows < 1) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailDraft");
					return "mail/mailDrafts";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailDraft");
				return "mail/mailDrafts";
			}
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setDataList(readyForViewList);
//            log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}

		Gson gson = new Gson();
		String pagination = gson.toJson(mailPagination);
//        log.info("제이슨 확인 : {}", pagination);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailDraft");
		model.addAttribute("mailList", pagination);
		model.addAttribute("rendererPagination", rendererPagination);

//        log.info("임시보관 새로 불러오기 메서드 종료");
		return "mail/mailDrafts";

	}// 임시 보관함 open() 종료 (새로고침 용)

	/**
	 * 임시보관함 페이지 선택 시, 목록 화면 구성 메서드
	 *
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 */
	@GetMapping("/choicePage.do")
	public String openMail(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session) {
		String empId = authentication.getName();
//        log.info("임시보관 선택 페이지 : {}", currentPage);
//        log.info("회원 정보 : {}", empId);
		// -------------------------------- 메일 출력 준비 시작 --------------------------------
		// messageId 목록 가져오기
		List<MailBoxVO> messageIdsList = mailService.retrieveDraftIdFromDBDraft(empId);

		List<MailBoxVO> readyForViewList = new ArrayList<>();
		for (MailBoxVO messageIdVO : messageIdsList) {
			MailBoxVO mailbox = new MailBoxVO();
			String draftId = messageIdVO.getMailDraftId();
			mailbox.setEmpId(empId);
			mailbox.setMailDraftId(draftId);
			List<MailBoxVO> tempList = mailService.retrieveViewFromDBDraft(mailbox);

			List<MailBoxVO> viewList = new ArrayList<>();
			MailBoxVO mailPrint = tempList.get(0);
			LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
			LocalDateTime mailDateTime = mailPrint.getMailSendDate();// DB 저장한 일시 불러오기
			if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
				mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
			} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
				mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
			}
			readyForViewList.add(mailPrint);
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
		MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
		{
			mailPagination.setCurrentPage(currentPage);
			mailPagination.setSimpleCondition(simpleCondition);

			int totalRows = 0;
			try {
				totalRows = readyForViewList.size();// 메세지(메일) 개수
				if (totalRows < 1) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailDraft");
					return "mail/mailDrafts";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailDraft");
				return "mail/mailDrafts";
			}
//            log.info("임시보관함 선택 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setDataList(readyForViewList);
//            log.info("임시보관함 선택 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}

		Gson gson = new Gson();
		String pagination = gson.toJson(mailPagination);
//        log.info("제이슨 확인 : {}", pagination);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailDraft");
		model.addAttribute("mailList", pagination);
		model.addAttribute("rendererPagination", rendererPagination);

		return "mail/mailDrafts";
	}// 임시보관함 : 페이지 선택 메서드 종료

	/**
	 * 임시보관함 메일 개별 선택 시 이동 메서드
	 * 
	 * @param draftId
	 * @param authentication
	 * @param model
	 * @return
	 */
	@GetMapping("/choiceMail.do")
	public String viewMail(@RequestParam(value = "what") String draftId, Authentication authentication, Model model) {
//        log.info("임시보관함 메일 선택 메서드 진입");
		String empId = authentication.getName();
		MailBoxVO temp = new MailBoxVO();
		temp.setEmpId(empId);
		temp.setMailDraftId(draftId);
		List<MailBoxVO> getEmailList = mailService.retrieveRewriteDraftFromDB(temp);// DB에서 메일 정보 가져오기
//		log.info("getEmailList: {}", getEmailList);
		Gson gson = new Gson();
		String mailList = gson.toJson(getEmailList);
//        log.info("제이슨 확인 : {}", pagination);

		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailView");
		// 이메일 목록 추출
		List<MailSendVO> totalEmpEmailList = mailService.retrieveEmpBeingEmails();

		// 이메일 목록 전달
		model.addAttribute("totalEmpEmailList", totalEmpEmailList);
		model.addAttribute("getEmailList", mailList);
		return "mail/mailDraftView";
	}

	@GetMapping("/attachDown.do")
	public ResponseEntity<ByteArrayResource> attachments(@RequestParam("what") String draftId,
			@RequestParam("for") String attachmentId, Authentication authentication) throws IOException {
//        log.info("첨부파일 다운로드 메서드 진입");
//        log.info("파라미터 확인 : messageId : {}, attachmentId : {}",messageId, attachmentId);
		String empId = authentication.getName();

		// MailBoxVO mailBoxVO = mailCacheService.getMailBox(empId, messageId);
		String filename = "";
		String mimetype = "";
		byte[] fileBytes = new byte[0];
		int size = 0;

		MailBoxVO temp = new MailBoxVO();
		temp.setMailDraftId(draftId);
		temp.setReceiverInfo(empId);
		List<MailBoxVO> getEmailList = mailService.retrieveADraftFromDB(temp);// DB에서 첨부파일 포함 모든 메일 정보 가져오기
//		log.info("확인 : {}", getEmailList);
		for (MailBoxVO mailBoxVO : getEmailList) {
			if (mailBoxVO.getMailAttachmentId().equals(attachmentId)) {
				filename = mailBoxVO.getMailAttachmentName();
				mimetype = mailBoxVO.getMailAttachmentMimeType();
//				log.info("마임 타입: {}", mimetype);
				fileBytes = mailBoxVO.getMailAttachmentFile();
				size = mailBoxVO.getMailAttachmentSize();
				break;
			}
		}

		ByteArrayResource byteResource = new ByteArrayResource(fileBytes);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentDispositionFormData("attachment", filename);
		headers.setContentType(MediaType.parseMediaType(mimetype));
		headers.setContentLength(size);

		return ResponseEntity.ok().headers(headers).body(byteResource);
	}
}
