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
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/mail/mailSent")
public class MailTo {
    @Inject
    MailAuthService mailAuthService;
    @Inject
    MailService mailService;
    @Inject
    MailStoreGmailService mailStoreGmailService;
    /**
     * Gmail 메일 받은 편지함 : 목록 화면 구성 메서드(새로고침)
     *
     * @param model
     * @param authentication
     * @param session
     */
    @GetMapping("/sentOpen.do")
    public String open(
            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
            , SimpleCondition simpleCondition
            , Model model
            , Authentication authentication
            , HttpSession session
    ) throws MessagingException, IOException {
//        log.info("보낸메일함 요청 메서드 진입");
        // 토큰/DB 정보 뷰로 가져가기
        String empId = authentication.getName();//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 웹 아이디
        String userId = mailService.retrieveEmployeeEmailAddress(empId);// <<<<<<<<<<<<<<<<<<<<<<<<<<< 이메일
        String accessToken = "";


//        log.info("토큰 존재 확인");
     // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("보낸 메일함 새로고침 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
//            log.info("보낸 메일함 새로고침 진입 액세스 토큰 유효하지 않음");
            session.setAttribute("sent", "redirect:/mail/mailSent/sentOpenDB.do" );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }

        // -------------------------------- 메세지 목록 받기 From Gmail 시작 --------------------------------
        String responseEntityBodyForMessageIdList = mailStoreGmailService.getSendMessageIdListFromGmail(accessToken);
//        log.info("메세지 목록 받기 성공");

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

        List<Map<String, Object>> messages = mailStoreGmailService.getMessagesFromList(responseJavaMap);// messages 추출
        int totalRows = 0;

        try {
//            log.info("message 개수 : {}", messages.size());
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
//            log.info("메일 받기 확인 : {}", notOrganizeEmailList.size());
        }
//        log.info("보낸 메일 확인 : {}", notOrganizeEmailList);
        // -------------------------------- 메일 받기 From Gmail 종료 --------------------------------
        // -------------------------------- 메일 정리 + DB 정리 시작 --------------------------------
        List<List<MailBoxVO>> readyForAttachList = mailService.organizeSentEmail(notOrganizeEmailList, messageIdList, empId, accessToken);
//        log.info("메일 처리 확인 : {}", readyForAttachList.size());
        // -------------------------------- 메일 정리 + DB 정리종료 --------------------------------
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDBSent(empId);

        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDBSent(mailbox);

            List<MailBoxVO> viewList = new ArrayList<>();
            MailBoxVO mailPrint = tempList.get(0);
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailSendDate();//DB 저장한 일시 불러오기
            if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
            } else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
            }
            readyForViewList.add(mailPrint);
        }
//        log.info("출력용 순서 확인 : {}", readyForViewList);

        // -------------------------------- 메일 출력 준비 종료 --------------------------------


        // ------------------------------------ 페이지네이션 시작 -----------------------------------
        MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
        {
            mailPagination.setCurrentPage(currentPage);
            mailPagination.setSimpleCondition(simpleCondition);

            try { totalRows = readyForViewList.size();// 메세지(메일) 개수
                if(totalRows < 1) {
                    model.addAttribute("level1Menu", "mail");
                    model.addAttribute("level2Menu", "mailSent");
                    return "mail/mailSent";
                }
            } catch (NullPointerException e) {
                model.addAttribute("level1Menu", "mail");
                model.addAttribute("level2Menu", "mailSent");
                return "mail/mailSent";
            }

//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }

        Gson gson = new Gson();
        String pagination = gson.toJson(mailPagination);


        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailSent");
        model.addAttribute("mailList", pagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "mail/mailSent"; // ------------------- 최초로 메일 받고, 최초로 메일 등록 종료  --------------------- 경로 1
    }

    /**
     * 메일 보낸 편지함 : 목록 화면 구성 메서드(DB)
     *
     * @param model
     * @param authentication
     * @param session
     */
    @GetMapping("/sentOpenDB.do")
    public String openSent(
            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
            , SimpleCondition simpleCondition
            , Model model
            , Authentication authentication
            , HttpSession session
    ) throws MessagingException, IOException {
//        log.info("기존 DB로 보낸 메일함 열기 메서드 진입");
        // 토큰/DB 정보 뷰로 가져가기
        String empId = authentication.getName();

        // --------------------------- 액세스 토큰 유효 확인 시작 ---------------------------
        String accessToken = "";
        // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("보낸 메일함 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
//            log.info("보낸 메일함 진입 액세스 토큰 유효하지 않음");
            session.setAttribute("sent", "redirect:/mail/mailSent/sentOpenDB.do" );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }
        // --------------------------- 액세스 토큰 유효 확인 종료 ---------------------------
        
        
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDBSent(empId);

        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDBSent(mailbox);

            List<MailBoxVO> viewList = new ArrayList<>();
            MailBoxVO mailPrint = tempList.get(0);
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailSendDate();//DB 저장한 일시 불러오기
            if (localDateTime.toLocalDate().isEqual(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalTime(mailDateTime.toLocalTime());
            } else if (localDateTime.toLocalDate().isAfter(mailDateTime.toLocalDate())) {
                mailPrint.setReceivedLocalDate(mailDateTime.toLocalDate());
            }
            readyForViewList.add(mailPrint);
        }
//        log.info("출력용 순서 확인 : {}", readyForViewList);

        // -------------------------------- 메일 출력 준비 종료 --------------------------------


        // ------------------------------------ 페이지네이션 시작 -----------------------------------
        MailPagination<List<MailBoxVO>> mailPagination = new MailPagination<>();
        {
            mailPagination.setCurrentPage(currentPage);
            mailPagination.setSimpleCondition(simpleCondition);


            int totalRows = 0;

            try { totalRows = readyForViewList.size();// 메세지(메일) 개수
                if(totalRows < 1) {
                    model.addAttribute("level1Menu", "mail");
                    model.addAttribute("level2Menu", "mailSent");
                    return "mail/mailSent";
                }
            } catch (NullPointerException e) {
                model.addAttribute("level1Menu", "mail");
                model.addAttribute("level2Menu", "mailSent");
                return "mail/mailSent";
            }


//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("보낸 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }

        Gson gson = new Gson();
        String pagination = gson.toJson(mailPagination);
//        log.info("json 변환 확인 : {}", pagination);

        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailSent");
        model.addAttribute("mailList", pagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "mail/mailSent"; // ------------------- 최초로 메일 받고, 최초로 메일 등록 종료  --------------------- 경로 1


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
//        log.info("보낸 편지함 선택 페이지 : {}", currentPage);
        // messageId 목록 가져오기
        List<MailBoxVO> messageIdsList = mailService.retrieveMessageIdFromDBSent(empId);
        // -------------------------------- 메일 출력 준비 시작 --------------------------------
        List<MailBoxVO> readyForViewList = new ArrayList<>();
        for (MailBoxVO messageIdVO : messageIdsList) {
            MailBoxVO mailbox = new MailBoxVO();
            String messageId = messageIdVO.getMailMessageId();
            mailbox.setReceiverInfo(empId);
            mailbox.setMailMessageId(messageId);
            List<MailBoxVO> tempList = mailService.retrieveViewFromDBSent(mailbox);//DB에 저장한 메일 조회
            MailBoxVO mailPrint = tempList.get(0);// 첫번째 VO을 출력 대상으로 만들기
            LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
            LocalDateTime mailDateTime = mailPrint.getMailSendDate();//DB 저장한 일시 불러오기
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
                    model.addAttribute("level2Menu", "mailInbox");
                    return "mail/mailSent";
                }
            } catch (NullPointerException e) {
                model.addAttribute("level1Menu", "mail");
                model.addAttribute("level2Menu", "mailInbox");
                return "mail/mailSent";
            }
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", totalRows);
            mailPagination.setTotalRows(totalRows);
            mailPagination.setDataList(readyForViewList);
//            log.info("받은 메일함 첫 접근 - 전체 데이터 레코드(행의 개수) : {}", mailPagination);
        }

        Gson gson = new Gson();
        String pagination = gson.toJson(mailPagination);

        /* 페이지네이션 렌더러 UI 적용*/
        MailDefaultPaginationRenderer mailPaginationRenderer = new MailDefaultPaginationRenderer();
        String rendererPagination = mailPaginationRenderer.renderMailPagination(mailPagination);

        // model에 저장
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailSent");
        model.addAttribute("mailList", pagination);
        model.addAttribute("rendererPagination", rendererPagination);

        return "mail/mailSent";
    }// 보낸 편지함 : openMail() 메서드 :/choicePage.do 종료

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
        List<MailBoxVO> getEmailList = mailService.retrieveViewDetailSent(temp);// DB에서 메일 정보 가져오기\
//        log.info("getEmailList: {}", getEmailList);

        Gson gson = new Gson();
        String readList = gson.toJson(getEmailList);

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailView");
        model.addAttribute("getEmailList", readList);
        return "mail/mailSentView";
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
        List<MailBoxVO> getEmailList = mailService.retrieveDownSent(temp);// DB에서 첨부파일 포함 모든 메일 정보 가져오기
//        log.info("첨부파일 다운로드 전 정보 확인 : {}", getEmailList);
        for (MailBoxVO mailBoxVO : getEmailList) {
            if (mailBoxVO.getMailAttachmentId().equals(attachmentId)) {
                filename = mailBoxVO.getMailAttachmentName();
                mimetype = mailBoxVO.getMailAttachmentMimeType();
                fileBytes = mailBoxVO.getMailAttachmentFile();
                size = mailBoxVO.getMailAttachmentSize();
                break;
            }
        }

//        log.info("첨부파일 다운로드 마임타입 : {}",mimetype);

		ByteArrayResource byteResource = new ByteArrayResource(fileBytes);

		HttpHeaders headers = new HttpHeaders();

		if(mimetype.trim().equals("text/plain")) {
        
//			log.info("txt 파일 다운로드");
			try {
			    String encodedFilename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");
			    headers.add("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFilename);
			} catch (UnsupportedEncodingException e) {
			    // UTF-8 인코딩이 지원되지 않는 경우 처리
			    e.printStackTrace();
			}

			// MIME 타입을 text/plain으로, 캐릭터 셋을 UTF-8로 설정합니다.
			MediaType mediaType = new MediaType("text", "plain", StandardCharsets.UTF_8);
			headers.setContentType(mediaType);
			headers.setContentLength(size);

			return ResponseEntity.ok().headers(headers).body(byteResource);
			
		} else {
			headers.setContentDispositionFormData("attachment", filename);
			headers.setContentType(MediaType.parseMediaType(mimetype));
			headers.setContentLength(size);

			return ResponseEntity.ok().headers(headers).body(byteResource);
		}
    }

}
