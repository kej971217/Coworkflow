package kr.or.ddit.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/mail/mailArchive.do")
public class MailKeep {

    @GetMapping
    public String open(Model model){
        model.addAttribute("level1Menu", "mail");
        model.addAttribute("level2Menu", "mailArchive");

        return "mail/mailArchive";
    }
}
