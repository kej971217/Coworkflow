package kr.or.ddit.mail.controller;

import kr.or.ddit.mail.service.MailAuthService;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.vo.MailAuthVO;

import kr.or.ddit.mail.vo.MailClientVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Optional;


@Slf4j
@Controller
@RequestMapping("/mail/start")
public class MailAuthValidCheck {

    @Inject
    MailService mailService;

    @Inject
    MailAuthService mailAuthService;

    /**
     * 메일 기본 화면 ( 사용자 프로필 ) 이동 버튼
     *
     * @param request
     * @param response
     * @param authentication
     * @param model
     * @return
     * @throws IOException
     */
    @GetMapping("/first.do")
    public String validateCheck(
            HttpServletRequest request, HttpServletResponse response
            , Authentication authentication
            , Model model
    ) throws IOException {
//        log.debug("메일 첫 경로 진입");

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailUser");

        String empId = authentication.getName();

        String nullIsMoving = mailAuthService.flowTokens(empId);

        if(!Optional.ofNullable(nullIsMoving).isPresent()) {
//            log.debug("[MailAuthValidCheck.validateCheck] 토큰 흐름 결과 null 인 경우");
            return "redirect:/mail/mailInbox/infoOfEndUser.do";
        }

        return nullIsMoving;
    }

    /**
     * 메일 받은 편지함 이동
     *
     * @param request
     * @param response
     * @param authentication
     * @param model
     * @return
     * @throws IOException
     */
    @GetMapping("/firstInbox.do")
    public String validateCheckBeforeInbox(
            HttpServletRequest request, HttpServletResponse response
            , Authentication authentication
            , Model model
    ) throws IOException {
//        log.debug("메일 첫 경로 진입");

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailUser");

        String empId = authentication.getName();

        String nullIsMoving = mailAuthService.flowTokens(empId);

        if(!Optional.ofNullable(nullIsMoving).isPresent()) {
//            log.debug("[MailAuthValidCheck.validateCheck] 토큰 흐름 결과 null 인 경우");
            return "redirect:/mail/mailInbox/mailInboxOpen.do";
        }

        return nullIsMoving;
    }




    /**
     * 메일 보낸 편지함 이동
     *
     * @param authentication
     * @param model
     * @return
     * @throws IOException
     */
    @GetMapping("/firstSent.do")
    public String validateCheckSentBeforeInbox(
            Authentication authentication
            , Model model
    ) throws IOException {
//        log.debug("보낸 메일 첫 경로 진입");

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailUser");

        String empId = authentication.getName();

        String nullIsMoving = mailAuthService.flowTokens(empId);

        if(!Optional.ofNullable(nullIsMoving).isPresent()) {
//            log.debug("[MailAuthValidCheck.validateCheck] 토큰 흐름 결과 null 인 경우");
            return "redirect:/mail/mailSent/sentOpen.do";
        }

        return nullIsMoving;
    }


    /**
     * 메일 임시보관함 이동
     *
     * @param authentication
     * @param model
     * @return
     * @throws IOException
     */
    @GetMapping("/firstDraft.do")
    public String validateCheckDraftBeforeInbox(
            Authentication authentication
            , Model model
    ) throws IOException {
//        log.debug("임시보관함 메일 첫 경로 진입");

        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailUser");

        String empId = authentication.getName();

        String nullIsMoving = mailAuthService.flowTokens(empId);

        if(!Optional.ofNullable(nullIsMoving).isPresent()) {
//            log.debug("[MailAuthValidCheck.validateCheck] 토큰 흐름 결과 null 인 경우");
            return "redirect:/mail/mailDraft/draftListOpen.do";
        }

        return nullIsMoving;
    }


}