package kr.or.ddit.schedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calendar/calendarDelete.do")
public class ScheduleDeleteController {
	@GetMapping
	public String getUI(Model model) {
		model.addAttribute("level1Menu", "calendar");
		return "calendar/calendarSelectList";
	}
}
