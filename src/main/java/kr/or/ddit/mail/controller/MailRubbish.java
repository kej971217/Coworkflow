package kr.or.ddit.mail.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.services.gmail.model.Message;
import com.google.gson.Gson;

import kr.or.ddit.mail.MailDefaultPaginationRenderer;
import kr.or.ddit.mail.service.MailAuthService;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.service.MailStoreGmailService;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailPagination;
import kr.or.ddit.mail.vo.MailSendVO;
import kr.or.ddit.mail.vo.MailTrashVO;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

@Slf4j
@Controller
@RequestMapping("/mail/mailTrash")
public class MailRubbish {
	@Inject
	MailService mailService;

	@Inject
	MailAuthService mailAuthService;

	@Inject
	MailStoreGmailService mailStoreGmailService;

	/**
	 * 휴지통 불러오기(From Gmail) (새로고침)
	 * 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/mailTrashOpen.do")
	public String open(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session)
			throws IOException, MessagingException {
//		log.info("휴지통 새로고침 메서드 진입");
		// 토큰/DB 정보 뷰로 가져가기
		String empId = authentication.getName();
		String userId = mailService.retrieveEmployeeEmailAddress(empId);
		String accessToken = "";

		// 액세스 토큰 유효 확인
		// 토큰 유효 확인 반환 : return "OK";
		String checkTokens = mailAuthService.checkTokens(empId);
		if (checkTokens.equals("OK")) {
			accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//					log.info("임시보관함 새로고침 진입 액세스 토큰 확인 : {}", accessToken);
		} else {
			// 유효하지 않으면 전체 재발급
			session.setAttribute("trash", "redirect:/mail/mailTrash/mailTrashOpen.do");
			return "redirect:/mail/authorization/authorizationRequest.do";// 내부 URL 리다이렉트
		}

		// -------------------------------- 메세지 목록 받기 From Gmail 시작
		// --------------------------------
		List<String> trashMessageIdList = mailStoreGmailService.getTrashMessageIdList(accessToken);// 휴지통 라벨 가진
																									// messageId 목록 받기
		log.info("휴지통 라벨 가진 messaageId 목록 : {}", trashMessageIdList);

		// -------------------------------- 메세지 목록 받기 From Gmail 종료
		// --------------------------------
		// -------------------------------- 메세지 DB 저장하기 시작
		// --------------------------------
		List<Message> responseList = new ArrayList<>();
		for (String trashMessageId : trashMessageIdList) {
			Message trash = mailStoreGmailService.getEachTrashCanFromGmail(accessToken, trashMessageId);// 휴지통 메일 목록 받기
//			log.info("받아온 메일 : {}", trash);
			responseList.add(trash);
		}

//		log.info("DB 저장 전 개수 : {}", responseList.size());
//		log.info("DB 저장 전 확인 : {}", responseList);
		List<MailTrashVO> readyTrashList = mailService.organizeTrash(responseList, empId);
//		log.info("추출 확인 : {}", readyTrashList);

		// -------------------------------- 메세지 DB 저장하기 종료
		// --------------------------------

		// -------------------------------- 메일 출력 준비 시작 --------------------------------
//		log.info("휴지통 메일 출력 준비 시작");
		List<MailTrashVO> readyTrashIdList = mailService.retrieveTrashIdListFromDB(empId);
		List<MailTrashVO> readyForViewList = new ArrayList<>();
		for (MailTrashVO mailTrashVO : readyTrashIdList) {
//			log.info("휴지통 메일 뽑기 for문 진입 : {}", readyTrashIdList.size());
			MailBoxVO mailT = new MailBoxVO();
			mailT.setEmpId(empId);
			mailT.setMailMessageId(mailTrashVO.getMailMessageId());
			List<MailTrashVO> tempList = mailService.retrieveViewFromDBTrash(mailT);
//			log.info("휴지통 메일 DB 결과 : {}", tempList.size());
			if (tempList.size() > 0) {
				List<MailBoxVO> viewList = new ArrayList<>();
				try {
//					log.info("휴지통 메일 DB 결과 : {}", tempList.size());
					MailTrashVO mailPrint = tempList.get(0);
//					log.info("어디야 1");
					LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
//					log.info("어디야 2");
					LocalDateTime mailDateTime = mailPrint.getMailDate();// DB 저장한 일시 불러오기
//					log.info("어디야 3 : {}", mailDateTime);
					if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
//						log.info("어디야 4-1", mailDateTime);
						mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
					} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
//						log.info("어디야 4-2", mailDateTime);
						mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
					}
					readyForViewList.add(mailPrint);
				} catch (NullPointerException e) {
//					log.info("여긴 안돼 오지마");
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailTrash");
					return "mail/mailTrash";
				}
			}
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
//		log.info("휴지통 메일 페이지네이션 시작");

//		log.info("페이지네이션 적용 전 메일 확인 : {} 개", readyForViewList.size());
//		log.info("페이지네이션 적용 전 메일 확인 : {}", readyForViewList);

		MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
		{
			mailPagination.setCurrentPage(currentPage);
			mailPagination.setSimpleCondition(simpleCondition);

			int totalRows = 0;
			try {
				totalRows = readyForViewList.size();
				if (totalRows < 1) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailTrash");
					return "mail/mailTrash";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailTrash");
				return "mail/mailTrash";
			}
//			log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setTrashDataList(readyForViewList);
//			log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}

//		log.info("제이슨 이전 : {}", mailPagination);
		Gson gson = new Gson();
		String paginationJSON = gson.toJson(mailPagination);
//		log.info("제이슨 확인 : {}", paginationJSON);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailTrash");
		model.addAttribute("mailList", paginationJSON);
		model.addAttribute("rendererPagination", rendererPagination);

//		log.info("휴지통 새로 불러오기 메서드 종료");

		return "mail/mailTrash";
	}

	/**
	 * 휴지통 불러오기(From DB) (목록)
	 * 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/mailTrash.do")
	public String openTrash(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			SimpleCondition simpleCondition, Model model, Authentication authentication, HttpSession session)
			throws IOException, MessagingException {
//		log.info("휴지통 DB 목록 메서드 진입");
		// 토큰/DB 정보 뷰로 가져가기
		String empId = authentication.getName();
		String userId = mailService.retrieveEmployeeEmailAddress(empId);
		String accessToken = "";

		// 액세스 토큰 유효 확인
		// 토큰 유효 확인 반환 : return "OK";
		String checkTokens = mailAuthService.checkTokens(empId);
		if (checkTokens.equals("OK")) {
			accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//							log.info("임시보관함 새로고침 진입 액세스 토큰 확인 : {}", accessToken);
		} else {
			// 유효하지 않으면 전체 재발급
			session.setAttribute("trash", "redirect:/mail/mailTrash/mailTrash.do");
			return "redirect:/mail/authorization/authorizationRequest.do";// 내부 URL 리다이렉트
		}

		// -------------------------------- 메세지 목록 받기 From Gmail 시작
		// --------------------------------
		List<String> trashMessageIdList = mailStoreGmailService.getTrashMessageIdList(accessToken);
//		log.info("휴지통 라벨을 가진 메일 식별자 목록 확인 : {}", trashMessageIdList);
		
		List<Message> trashList = new ArrayList<>();
		for (String trashMessageId : trashMessageIdList) {
			Message trash = mailStoreGmailService.getEachTrashCanFromGmail(accessToken, trashMessageId);
			trashList.add(trash);
		}
		log.info("휴지통 메일 목록 확인 : {}", trashList);
		// -------------------------------- 메세지 목록 받기 From Gmail 종료
		// --------------------------------
		// -------------------------------- 메일 정리 + DB 정리 시작 --------------------------------
		List<Message> responseList = new ArrayList<>();
		for (Message trashMessage : trashList) {
			MailSendVO mailSendVO = new MailSendVO();
			mailSendVO.setEmpId(empId);
			mailSendVO.setMailMessageId(trashMessage.getId());

			Message message = mailService.sendReadyTrash(mailSendVO);
			responseList.add(message);
		}
		log.info("DB 정리할 휴지통 메일 목록 확인 : {}", responseList);
		
        List<MailTrashVO> readyForAttachList = mailService.organizeTrash(responseList, empId);
        log.info("휴지통 메일 처리 확인 : {}", readyForAttachList.size());
        // -------------------------------- 메일 정리 + DB 정리종료 --------------------------------

		// -------------------------------- 메일 출력 준비 시작 --------------------------------
//		log.info("휴지통 메일 출력 준비 시작");
		List<MailTrashVO> readyTrashList = mailService.retrieveTrashIdListFromDB(empId);
		log.info("휴지통 메일 목록 출력 준비 : {}", readyTrashList);

		List<MailTrashVO> readyForViewList = new ArrayList<>();
		for (MailTrashVO mailTrashVO : readyTrashList) {
			MailBoxVO mailT = new MailBoxVO();
			mailT.setEmpId(mailTrashVO.getEmpId());
			mailT.setMailMessageId(mailTrashVO.getMailMessageId());
			List<MailTrashVO> tempList = mailService.retrieveViewFromDBTrash(mailT);

			if (tempList.size() > 0) {
				List<MailBoxVO> viewList = new ArrayList<>();
				try {
					MailTrashVO mailPrint = tempList.get(0);
					LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
					LocalDateTime mailDateTime = mailPrint.getMailDate();// DB 저장한 일시 불러오기
					if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
						mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
					} else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
						mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
					}
					readyForViewList.add(mailPrint);
				} catch (NullPointerException e) {
					model.addAttribute("level1Menu", "mail");
					model.addAttribute("level2Menu", "mailTrash");
					return "mail/mailTrash";
				}
			}
		}
//        log.info("출력용 순서 확인 : {}", readyForViewList);

		// -------------------------------- 메일 출력 준비 종료 --------------------------------

		// ------------------------------------ 페이지네이션 시작
		// -----------------------------------
//		log.info("휴지통 메일 페이지네이션 시작");
		try {
//			log.info("페이지네이션 적용 전 메일 확인 : {} 개", readyForViewList.size());
//			log.info("페이지네이션 적용 전 메일 확인 : {}", readyForViewList);

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
					model.addAttribute("level2Menu", "mailTrash");
					return "mail/mailTrash";
				}
			} catch (NullPointerException e) {
				model.addAttribute("level1Menu", "mail");
				model.addAttribute("level2Menu", "mailTrash");
				return "mail/mailTrash";
			}
//			log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
			mailPagination.setTotalRows(totalRows);
			mailPagination.setTrashDataList(readyForViewList);
//			log.info("임시보관함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
		}
		
		Gson gson = new Gson();
        String pagination = gson.toJson(mailPagination);

		/* 페이지네이션 렌더러 UI 적용 */
		MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
		String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

		// model에 저장
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailTrash");
		model.addAttribute("mailList", pagination);
		model.addAttribute("rendererPagination", rendererPagination);

//		log.info("휴지통 DB 목록 메서드 종료");

		return "mail/mailTrash";
	}
	
	/**
     * 메일 받은 편지함 : 페이지 선택 시 목록 화면 구성 메서드
     *
     * @param currentPage
     * @param simpleCondition
     * @param model
     * @param authentication
     * @param session
     * @return
     */
    @GetMapping("/choicePage.do")
    public String openMail(
            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
            , SimpleCondition simpleCondition
            , Model model
            , Authentication authentication
            , HttpSession session
    ) {
        String empId = authentication.getName();
//        log.info("선택 페이지 : {}", currentPage);
        // messageId 목록 가져오기
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDB(empId);
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDB(mailbox);//DB에 저장한 메일 조회
            MailBoxVO mailPrint = tempList.get(0);// 첫번째 VO을 출력 대상으로 만들기
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailInboxDate();//DB 저장한 일시 불러오기
            if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
            } else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
            }
            readyForViewList.add(mailPrint);
        }
//        log.info("출력용 순서 확인 : {}", readyForViewList)
        // -------------------------------- 메일 출력 준비 종료 --------------------------------


        // ------------------------------------ 페이지네이션 시작 -----------------------------------
        MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
        {
            mailPagination.setCurrentPage(currentPage);
            mailPagination.setSimpleCondition(simpleCondition);

            int totalRows = 0;
            try {
                totalRows = readyForViewList.size();// 메세지(메일) 개수
                if(totalRows < 1) {
                    model.addAttribute("level1Menu", "mail");
                    model.addAttribute("level2Menu", "mailTrash");
                    return "mail/mailInbox";
                }
            } catch (NullPointerException e) {
                model.addAttribute("level1Menu", "mail");
                model.addAttribute("level2Menu", "mailTrash");
                return "mail/mailInbox";
            }
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }
        
        
        Gson gson = new Gson();
        String pagination = gson.toJson(mailPagination);
//        log.info("제이슨 확인 : {}", pagination);
        
        

        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailInbox");
        model.addAttribute("mailList", pagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "mail/mailTrash";
    }// 휴지통 : openMail() 메서드 :/choicePage.do 종료
    
    
 // 메일 상세 보기
    @GetMapping("/choiceMail.do")
    public String viewMail(
            @RequestParam(value = "what") String messageId
            , Authentication authentication
            , Model model
    ) {
        String empId = authentication.getName();
        MailBoxVO temp = new MailBoxVO();
        temp.setReceiverInfo(empId);
        temp.setMailMessageId(messageId);
        List<MailBoxVO> getEmailList = mailService.retrieveEmailWithAttachment(temp);// DB에서 메일 정보 가져오기
//        log.info("getEmailList: {}", getEmailList);
        Gson gson = new Gson();
        String mailList = gson.toJson(getEmailList);

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailView");
        model.addAttribute("getEmailList", mailList);
        return "mail/mailTrashView";
    }

    @GetMapping("/attachDown.do")
    public ResponseEntity<ByteArrayResource> attachments(
            @RequestParam("what") String messageId
            , @RequestParam("for") String attachmentId
            , Authentication authentication
    ) throws IOException {
//        log.info("첨부파일 다운로드 메서드 진입");
//        log.info("파라미터 확인 : messageId : {}, attachmentId : {}",messageId, attachmentId);
        String empId = authentication.getName();

        // MailBoxVO mailBoxVO = mailCacheService.getMailBox(empId, messageId);
        String filename = "";
        String mimetype = "";
        byte[] fileBytes = new byte[0];
        int size = 0;

        MailBoxVO temp = new MailBoxVO();
        temp.setMailAttachmentId(attachmentId);
        temp.setMailMessageId(messageId);
        temp.setReceiverInfo(empId);
        List<MailBoxVO> getEmailList = mailService.retrieveDownTrash(temp);// DB에서 첨부파일 포함 모든 메일 정보 가져오기
        for (MailBoxVO mailBoxVO : getEmailList) {
            if (mailBoxVO.getMailAttachmentId().equals(attachmentId)) {
                filename = mailBoxVO.getMailAttachmentName();
                mimetype = mailBoxVO.getMailAttachmentMimeType();
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

        return ResponseEntity.ok()
                .headers(headers)
                .body(byteResource);
    }

}
