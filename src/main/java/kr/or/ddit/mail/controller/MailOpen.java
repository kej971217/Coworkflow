package kr.or.ddit.mail.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.mail.service.MailOpenService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mail")
@Controller
public class MailOpen {

	@Inject
	MailOpenService mailOpenService;
	
	@GetMapping("/firstAccessInbox.do")
	public void openInbox(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
		String result = mailOpenService.accessSent(model, authentication, session);
//		log.info("액세스 결과 받은 메일함 : {}", result);
	}
	
	@GetMapping("/firstAccessSent.do")
	public void openSent(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
		String result = mailOpenService.accessSent(model, authentication, session);
//		log.info("액세스 결과 보낸 메일함 : {}", result);
	}
	
	@GetMapping("/firstAccessDraft.do")
	public void openDraft(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException {
		String result = mailOpenService.accessSent(model, authentication, session);
//		log.info("액세스 결과 임시 메일함 : {}", result);
	}
}
