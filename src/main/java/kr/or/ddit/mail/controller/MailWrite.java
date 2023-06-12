package kr.or.ddit.mail.controller;

import com.google.api.services.gmail.model.Draft;
import com.google.api.services.gmail.model.Message;
import com.google.gson.Gson;
import kr.or.ddit.mail.service.*;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.security.GeneralSecurityException;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/mail/mailForm")
public class MailWrite {

    @Inject
    MailService mailService;
    @Inject
    MailAuthService mailAuthService;

    /**
     * 메일 쓰기 폼으로 이동 메서드
     * @param authentication
     * @param model
     * @return 해당 뷰 경로 (mail/mailForm)
     */
    @GetMapping("/mailWriteForm.do")
    public String open(Authentication authentication
            , Model model
            , HttpSession session
    ) {
        String empId= authentication.getName();
        String accessToken = "";

        // 액세스 토큰 유효 확인
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            // 액세스 토큰 유효함
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("메일 쓰기 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 액세스 토큰 유효하지 않음
//            log.info("메일 쓰기 진입 액세스 토큰 유효하지 않음");
            session.setAttribute("form", "redirect:/mail/mailForm/mailWriteForm.do");
            return "redirect:/mail/authorization/authorizationRequest.do";
        }


        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailCompose");
//        log.info("[MailWrite] [open] 메일 쓰기 페이지로 이동");
        // 비교 용 전체 조회
//        log.info("메일 계정 조회 1 [mailService] 이메일 계정 전체 불러오기");
        List<MailSendVO> totalEmpEmailList = mailService.retrieveEmpBeingEmails();
        model.addAttribute("totalEmpEmailList", totalEmpEmailList);

        return "mail/mailForm";
    }

    /**
     * 메일 전송 (To Gmail) 메서드
     * @param mailSendVO
     * @param authentication
     * @param model
     * @return
     * @throws GeneralSecurityException
     * @throws IOException
     * @throws MessagingException
     */
    @PostMapping("/mailSend.do")
    public String sendMail(
            @ModelAttribute("mailSendVO") MailSendVO mailSendVO
            , Authentication authentication
            , Model model
            , HttpSession session) throws GeneralSecurityException, IOException, MessagingException {
//        log.info(" 메일 보내기 [MailWrite] 진입");
        String empId = authentication.getName();
//        log.info("웹 어플리케이션 : {}", empId);

//        @RequestPart MailBoxVO mailBoxVO
//        @RequestParam("emailAddr") List<String> addressToList
//            , @RequestParam("subject") String subjectParam
//            , @RequestParam("content") String mailContentParam
//            , @RequestPart("file") MultipartFile[] mailFile
        // base64url 문자열로 인코딩된 MIME 이메일 메시지

        // MultipartFile -> 바이트 배열 객체 -> Base64 인코딩
//        List<String> mailSendToList = mailSendVO.getMailSendToList();
//        String mailSendSubject = mailSendVO.getMailSendSubject();
//        String mailSendContent = mailSendVO.getMailSendContent();
//        MultipartFile[] mailFileList = new MultipartFile[0];
//        try {
//            mailFileList = mailSendVO.getFileList();
//        } catch (NullPointerException e) {}
        mailSendVO.setEmpId(empId);

        // 메일 보내기 준비 : Base64 인코딩한 MIME 데이터
//        Message message = mailService.sendReadyWithAttach(mailSendToList, mailSendSubject, mailSendContent, mailFileList, empId);

//        log.info("1. 주소 : {}", mailSendVO.getMailSendToList());
//        log.info("2. 제목 : {}", mailSendVO.getMailSendSubject());
//        log.info("3. 내용 : {}", mailSendVO.getMailSendContent());
//        log.info("4. 첨부파일 : {}", mailSendVO.getFileList());
        // 액세스 토큰 유효 확인
        String accessToken = "";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            // 액세스 토큰 유효함
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("메일 쓰기 - 전송 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 액세스 토큰 유효하지 않음
//            log.info("메일 쓰기 - 전송 진입 액세스 토큰 유효하지 않음");
            session.setAttribute("sentToPath", "redirect:/mail/mailForm/mailSend.do" );
            session.setAttribute("sentToVO", mailSendVO );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }


        Message message = mailService.sendReadyWithAttach(mailSendVO);

        Gson gson = new Gson();
        String messageString = gson.toJson(message);

        Map<String, Object> messageMap = new HashMap<>();
        messageMap = gson.fromJson(messageString, messageMap.getClass());// json 문자열, 변환 객체 타입

        //String id = messageMap.get("id").toString();

        return "redirect:/mail/mailInbox/mailInboxOpen.do";
    }

    /**
     * 메일 임시보관 요청 (To Gmail) 메서드
     * @param mailSendVO
     * @param authentication
     * @param model
     * @return
     * @throws GeneralSecurityException
     * @throws IOException
     * @throws MessagingException
     */
    @PostMapping("/draftSend.do")
    public String sendDraft(
            @ModelAttribute("mailSendVO") MailSendVO mailSendVO
            , Authentication authentication
            , Model model
            , HttpSession session) throws GeneralSecurityException, IOException, MessagingException {
//        log.info(" 메일 임시보관함 보내기 [MailWrite] 진입");
        String empId = authentication.getName();

        String accessToken = "";
        // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("임시보관함 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
            session.setAttribute("draftToPath", "redirect:/mail/mailForm/draftSend.do" );
            session.setAttribute("draftToVO", mailSendVO );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }

        String address = mailService.retrieveEmployeeEmailAddress(empId);
//        log.info("웹 어플리케이션 : {}", empId);
        mailSendVO.setEmpId(empId);

        // 메일 보내기 준비 : Base64 인코딩한 MIME 데이터
//        log.info("1. 주소 : {}", mailSendVO.getMailSendToList());
//        log.info("2. 제목 : {}", mailSendVO.getMailSendSubject());
//        log.info("3. 내용 : {}", mailSendVO.getMailSendContent());
//        log.info("4. 첨부파일 : {}", mailSendVO.getFileList());

        Draft draft = mailService.sendReadyDraft(mailSendVO);

        Gson gson = new Gson();
        String draftString = gson.toJson(draft);

        Map<String, Object> messageMap = new HashMap<>();
        messageMap = gson.fromJson(draftString, messageMap.getClass());// json 문자열, 변환 객체 타입

        String draftId = messageMap.get("id").toString();
//        log.info("임시보관 결과 : {}", draftId);

        //String id = messageMap.get("id").toString();

        return "redirect:/mail/mailInbox/mailInboxOpen.do";
    }


    /**
     * 임시 보관한 메일을 다시 임시 보관하기
     * @param mailSendVO
     * @param authentication
     * @param model
     * @return
     * @throws GeneralSecurityException
     * @throws IOException
     * @throws MessagingException
     */
    @PostMapping("/draftUpdate.do")
    public String sendDraftAgain(
            @ModelAttribute("mailSendVO") MailSendVO mailSendVO
            , Authentication authentication
            , Model model
            , HttpSession session) throws GeneralSecurityException, IOException, MessagingException {
//        log.info(" 임시보관 메일 재차 임시보관 메서드 진입");
        String empId = authentication.getName();
//        log.info("들어온 값 확인 : {}", mailSendVO);

        String accessToken = "";
        // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("임시보관 메일 열람 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
            session.setAttribute("draftUpdateToPath", "redirect:/mail/mailForm/draftUpdate.do" );
            session.setAttribute("draftUpdateToVO", mailSendVO );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }

//        log.info("웹 어플리케이션 : {}", empId);
        String address = mailService.retrieveEmployeeEmailAddress(empId);
     // ------- 뷰에서 서버로 넘어오면 Draft 식별자에 쉼표 , 가 추가되는 현상 처리 시작 -------
        String originalDraftId = mailSendVO.getMailDraftId();
        String draftId = originalDraftId.replace(",", "");
     // ------- 뷰에서 서버로 넘어오면 Draft 식별자에 쉼표 , 가 추가되는 현상 처리 종료 -------
//        log.info("draftId : {}", draftId);
        mailSendVO.setMailDraftId(draftId);
        mailSendVO.setEmpId(empId);

        // 메일 보내기 준비 : Base64 인코딩한 MIME 데이터
//        log.info("1. 주소 : {}", mailSendVO.getMailSendToList());
//        log.info("2. 제목 : {}", mailSendVO.getMailSendSubject());
//        log.info("3. 내용 : {}", mailSendVO.getMailSendContent());
//        log.info("4. 첨부파일 : {}", mailSendVO.getFileList());

        Draft draft = mailService.sendReadyDraftAgain(mailSendVO);
//        log.info(" 임시보관중인 메일 전송 완료 : {}", draft);

        Gson gson = new Gson();
        String draftString = gson.toJson(draft);

        Map<String, Object> messageMap = new HashMap<>();
        messageMap = gson.fromJson(draftString, messageMap.getClass());// json 문자열, 변환 객체 타입

        String draftIdAgain = messageMap.get("id").toString();
//        log.info("임시보관 업데이트 결과 : {}", draftIdAgain);

        //String id = messageMap.get("id").toString();

        return "redirect:/mail/mailDraft/drafts.do";
    }

    /**
     * 임시보관한 메일을 완전히 전송 (To Gmail) 메서드
     * @param mailSendVO
     * @param authentication
     * @param model
     * @return
     * @throws GeneralSecurityException
     * @throws IOException
     * @throws MessagingException
     */
    @PostMapping("/mailDraftFinalSend.do")
    public String sendDraftFinal(
            @ModelAttribute("mailSendVO") MailSendVO mailSendVO
            , Authentication authentication
            , Model model
            , HttpSession session) throws GeneralSecurityException, IOException, MessagingException {
//        log.info(" 임시 메일 보내기 [MailWrite] 진입");
        String empId = authentication.getName();


        String accessToken = "";
        // 액세스 토큰 유효 확인
        // 토큰 유효 확인 반환 : return "OK";
        String checkTokens = mailAuthService.checkTokens(empId);
        if (checkTokens.equals("OK")) {
            accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스 토큰
//            log.info("받은 메일함 진입 액세스 토큰 확인 : {}", accessToken);
        } else {
            // 유효하지 않음
            session.setAttribute("draftFinalToPath", "redirect:/mail/mailForm/mailDraftFinalSend.do" );
            session.setAttribute("draftFinalToVO", mailSendVO );
            return "redirect:/mail/authorization/authorizationRequest.do";
        }


//        log.info("웹 어플리케이션 : {}", empId);
        String address = mailService.retrieveEmployeeEmailAddress(empId);
     // ------- 뷰에서 서버로 넘어오면 Draft 식별자에 쉼표 , 가 추가되는 현상 처리 시작 -------
        String originalDraftId = mailSendVO.getMailDraftId();
        String draftId = originalDraftId.replace(",", "");
     // ------- 뷰에서 서버로 넘어오면 Draft 식별자에 쉼표 , 가 추가되는 현상 처리 종료 -------
//        log.info("draftId : {}", draftId);
        mailSendVO.setEmpId(empId);
        mailSendVO.setMailDraftId(draftId);
//        log.info("저장 확인 : {}", mailSendVO.getMailDraftId());

        // 메일 보내기 준비 : Base64 인코딩한 MIME 데이터
//        log.info("1. 주소 : {}", mailSendVO.getMailSendToList());
//        log.info("2. 제목 : {}", mailSendVO.getMailSendSubject());
//        log.info("3. 내용 : {}", mailSendVO.getMailSendContent());
//        log.info("4. 첨부파일 : {}", mailSendVO.getFileList());

        Message message = mailService.sendReadyDraftFinal(mailSendVO);
//        log.info(" 임시보관중인 메일 전송 완료 : {}", message);

        Gson gson = new Gson();
        String draftString = gson.toJson(message);

        Map<String, Object> messageMap = new HashMap<>();
        messageMap = gson.fromJson(draftString, messageMap.getClass());// json 문자열, 변환 객체 타입


//        String draftId = messageMap.get("id").toString();
//        log.info("임시보관 중인 메일 최종 전송 결과 : {}", messageMap);

        //String id = messageMap.get("id").toString();

        return "redirect:/mail/mailDraft/drafts.do";
    }

}