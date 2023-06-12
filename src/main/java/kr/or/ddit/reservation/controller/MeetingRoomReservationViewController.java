package kr.or.ddit.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/reservation/meetingRoomReserveView.do")
public class MeetingRoomReservationViewController  {
	
	@GetMapping
	public String getUI(Model model) {
		model.addAttribute("level1Menu", "asset");
		model.addAttribute("level2Menu", "reservation");
		model.addAttribute("level3Menu", "meetingRoom");
		return "reservation/meetingRoomReserveView";
	}
	
}
