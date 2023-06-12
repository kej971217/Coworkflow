package kr.or.ddit.mail.service;

import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public interface MailOpenService {
    public String accessInbox(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException;

    public String accessSent(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException;

    public String accessDraft(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException;

//    public String accessTrash(Model model, Authentication authentication, HttpSession session) throws MessagingException, IOException;
}
