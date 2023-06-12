package kr.or.ddit.mail.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.services.gmail.model.Message;
import kr.or.ddit.mail.MailDefaultPaginationRenderer;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailPagination;
import kr.or.ddit.mail.vo.MailSendVO;
import kr.or.ddit.mail.vo.MailTrashVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
@Slf4j
public class MailOpenServiceImpl implements MailOpenService{

    @Inject
    MailAuthService mailAuthService;
    @Inject
    MailService mailService;
    @Inject
    MailStoreGmailService mailStoreGmailService;

    @Async
    public String accessInbox(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
    	// 토큰/DB 정보 뷰로 가져가기
        String empId = authentication.getName();//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 웹 아이디
        String userId = mailService.retrieveEmployeeEmailAddress(empId);// <<<<<<<<<<<<<<<<<<<<<<<<<<< 이메일
        String accessToken = "";


     // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("받은 메일함 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
//        	log.info("받은 메일함 진입 액세스 토큰 유효하지 않음");
        	session.setAttribute("access", "access" );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }

        // ---------------------- 메세지 목록 받기 From Gmail 시작 ------------------------
        String responseEntityBodyForMessageIdList = mailStoreGmailService.getMessageIdListFromGmail(accessToken);
//      메세지 목록 받기 성공

        // JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
        ObjectMapper objectMapper = new ObjectMapper();

        Map<String, Object> responseJavaMap;
        try {
            // JSON 문자열을 Map으로 변환
            // 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭 타입)을 명시적으로 지정
            // Jackson 라이브러리 예외 처리
            responseJavaMap = objectMapper.readValue(responseEntityBodyForMessageIdList, new TypeReference<Map<String, Object>>() {
            });
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        int messagePagingTotal = mailStoreGmailService.getTotalCountFromList(responseJavaMap);// 페이징용 resultSizeEstimate 추출
//        log.info("resultSizeEstimate : {}", messagePagingTotal);

        if(messagePagingTotal < 1) {
            model.addAttribute("level1Menu", "mail");
            model.addAttribute("level2Menu", "mailInbox");
            return "mail/mailInbox";
        }


        List<Map<String, Object>> messages = mailStoreGmailService.getMessagesFromList(responseJavaMap);// messages 추출
//        log.info("message 개수 : {}", messages.size());
        List<String> messageIdList = new ArrayList<String>();
        for (Map<String, Object> message : messages) {
            String messageId = message.get("id").toString();
            messageIdList.add(messageId);
        }
        // -------------------------------- 메세지 목록 받기 From Gmail 종료 --------------------------------
        // -------------------------------- 메일 받기 From Gmail 시작 --------------------------------
        List<Map<String, Map<String, Object>>> notOrganizeEmailList = new ArrayList<>();
        for (String messageId : messageIdList) {
            String anEmail = mailStoreGmailService.getEachEmailFromGmail(accessToken, messageId);

            // JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
            ObjectMapper objectMapperForResponseGmail = new ObjectMapper();
            Map<String, Object> responseJsonMap;
            try {
                // JSON 문자열을 Map으로 변환
                // 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭 타입)을 명시적으로 지정
                // Jackson 라이브러리 예외 처리
                responseJsonMap = objectMapperForResponseGmail.readValue(anEmail, new TypeReference<Map<String, Object>>() {
                });

            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
            Map<String, Map<String, Object>> keyMap = new HashMap<>();
            keyMap.put(messageId, responseJsonMap);
            notOrganizeEmailList.add(keyMap);
//            log.info("메일 받기 확인 : {}", notOrganizeEmailList.size());
//            log.info("메일 받기 확인 : {}", notOrganizeEmailList);
        }
        // -------------------------------- 메일 받기 From Gmail 종료 --------------------------------
        // -------------------------------- 메일 정리 + DB 정리 시작 --------------------------------
        List<List<MailBoxVO>> readyForAttachList = mailService.organizeEmail(notOrganizeEmailList, messageIdList, empId, accessToken);
//        log.info("메일 처리 확인 : {}", readyForAttachList.size());
        // -------------------------------- 메일 정리 + DB 정리종료 --------------------------------
        return "OK";
    }// 받은 편지함 : open() 메서드 종료

    @Async
    @Override
    public String accessSent(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
//      log.info("보낸메일함 요청 메서드 진입");
      // 토큰/DB 정보 뷰로 가져가기
      String empId = authentication.getName();//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 웹 아이디
      String userId = mailService.retrieveEmployeeEmailAddress(empId);// <<<<<<<<<<<<<<<<<<<<<<<<<<< 이메일
      String accessToken = "";


//      log.info("토큰 존재 확인");
   // 액세스 토큰 유효 확인
      // 토큰 유효 확인 반환 : return "OK";
      String checkTokens = mailAuthService.checkTokens(empId);
      if (checkTokens.equals("OK")) {
          accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//          log.info("보낸 메일함 새로고침 진입 액세스 토큰 확인 : {}", accessToken);
      } else {
          // 유효하지 않음
//          log.info("보낸 메일함 새로고침 진입 액세스 토큰 유효하지 않음");
          session.setAttribute("access", "access" );
          return "redirect:/mail/authorization/authorizationRequest.do";
      }

      // -------------------------------- 메세지 목록 받기 From Gmail 시작 --------------------------------
      String responseEntityBodyForMessageIdList = mailStoreGmailService.getSendMessageIdListFromGmail(accessToken);
//      log.info("메세지 목록 받기 성공");

      // JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
      ObjectMapper objectMapper = new ObjectMapper();

      Map<String, Object> responseJavaMap;
      try {
          // JSON 문자열을 Map으로 변환
          // 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭 타입)을 명시적으로 지정
          // Jackson 라이브러리 예외 처리
          responseJavaMap = objectMapper.readValue(responseEntityBodyForMessageIdList, new TypeReference<Map<String, Object>>() {
          });
      } catch (JsonProcessingException e) {
          throw new RuntimeException(e);
      }

      int messagePagingTotal = mailStoreGmailService.getTotalCountFromList(responseJavaMap);// 페이징용 resultSizeEstimate 추출
//      log.info("resultSizeEstimate : {}", messagePagingTotal);

      List<Map<String, Object>> messages = mailStoreGmailService.getMessagesFromList(responseJavaMap);// messages 추출
      int totalRows = 0;

      try {
//          log.info("message 개수 : {}", messages.size());
          messages.size();
          if(messages.size() < 1) {
              model.addAttribute("level1Menu", "mail");
              model.addAttribute("level2Menu", "mailSent");
              return "mail/mailSent";
          }
      } catch (NullPointerException e) {
          model.addAttribute("level1Menu", "mail");
          model.addAttribute("level2Menu", "mailSent");
          return "mail/mailSent";
      }

      List<String> messageIdList = new ArrayList<>();
      for (Map<String, Object> message : messages) {
          String messageId = message.get("id").toString();
          messageIdList.add(messageId);
      }
      // -------------------------------- 메세지 목록 받기 From Gmail 종료 --------------------------------
      // -------------------------------- 메일 받기 From Gmail 시작 --------------------------------
      List<Map<String, Map<String, Object>>> notOrganizeEmailList = new ArrayList<>();
      for (String messageId : messageIdList) {
          String anEmail = mailStoreGmailService.getEachEmailFromGmail(accessToken, messageId);

          // JSON 파싱용 ObjectMapper 객체 생성 (Jackson 라이브러리)
          ObjectMapper objectMapperForResponseGmail = new ObjectMapper();
          Map<String, Object> responseJsonMap;
          try {
              // JSON 문자열을 Map으로 변환
              // 인자 : Json 문자열, Jackson 라이브러리가 JSON 문자열 <-직렬화-> Java 객체 할때 변환할 Java 객체의 타입(저네릭 타입)을 명시적으로 지정
              // Jackson 라이브러리 예외 처리
              responseJsonMap = objectMapperForResponseGmail.readValue(anEmail, new TypeReference<Map<String, Object>>() {
              });

          } catch (JsonProcessingException e) {
              throw new RuntimeException(e);
          }
          Map<String, Map<String, Object>> keyMap = new HashMap<>();
          keyMap.put(messageId, responseJsonMap);
          notOrganizeEmailList.add(keyMap);
//          log.info("메일 받기 확인 : {}", notOrganizeEmailList.size());
      }
//      log.info("보낸 메일 확인 : {}", notOrganizeEmailList);
      // -------------------------------- 메일 받기 From Gmail 종료 --------------------------------
      // -------------------------------- 메일 정리 + DB 정리 시작 --------------------------------
      List<List<MailBoxVO>> readyForAttachList = mailService.organizeSentEmail(notOrganizeEmailList, messageIdList, empId, accessToken);
//      log.info("메일 처리 확인 : {}", readyForAttachList.size());
      // -------------------------------- 메일 정리 + DB 정리종료 --------------------------------
      return "OK";
    }

    @Async
    public String accessDraft(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
//    	log.info("임시보관함 메서드 진입");
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
			session.setAttribute("access", "access" );
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
		// -------------------------------- 메일 받기 From Gmail 종료 --------------------------------
		// -------------------------------- 메일 정리 + DB 정리 시작 --------------------------------
		List<List<MailBoxVO>> readyForAttachList = mailService.organizeDraftEmail(notOrganizeEmailList, draftIdList,
				empId, accessToken);
//        log.info("임시보관 메일 처리 확인 : {}", readyForAttachList.size());
		// -------------------------------- 메일 정리 + DB 정리종료--------------------------------
		return "OK";
    }// 임시 보관함 open() 종료 (새로고침 용)

    /*
    @Async
    @Override
    public String accessTrash(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
//        log.info("휴지통 새로고침 메서드 진입");
        // 토큰/DB 정보 뷰로 가져가기
        String empId = authentication.getName();
        String userId = mailService.retrieveEmployeeEmailAddress(empId);
        String accessToken = "";


        // 액세스 토큰 유효 확인
        String checkTokens = mailAuthService.checkTokens(empId);
        if (!Optional.ofNullable(checkTokens).isPresent()) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();
        } else {
            // 유효하지 않으면 전체 재발급
            return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
        }

        // -------------------------------- 메세지 목록 받기 From Gmail 시작 --------------------------------
        List<String> trashMessageIdList = mailStoreGmailService.getTrashMessageIdList(accessToken);
        List<Message> trashList = new ArrayList<>();
        for(String trashMessageId : trashMessageIdList) {
            Message trash = mailStoreGmailService.getEachTrashCanFromGmail(accessToken, trashMessageId);
            trashList.add(trash);
        }
        // -------------------------------- 메세지 목록 받기 From Gmail 종료 --------------------------------
        // -------------------------------- 메세지 DB 저장하기 시작 --------------------------------
        List<Message> responseList = new ArrayList<>();
        for (Message trashMessage : trashList) {
            MailSendVO mailSendVO = new MailSendVO();
            mailSendVO.setEmpId(empId);
            mailSendVO.setMailMessageId(trashMessage.getId());

            Message message = mailService.sendReadyTrash(mailSendVO);
            responseList.add(message);
        }
        List<MailBoxVO> readyTrashList = mailService.organizeTrash(responseList, empId);
        // -------------------------------- 메세지 DB 저장하기 종료 --------------------------------

        return "redirect:/";
    }
    */
}
