package kr.or.ddit.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservation/vehicleReserve.do")
public class VehicleReservationController {
		
		@GetMapping
		public String getUI( Model model ) {
			model.addAttribute("level1Menu", "asset");
			model.addAttribute("level2Menu", "reservation");
			model.addAttribute("level3Menu", "vehicle");
			return "reservation/vehicleReserve";
			
		
	}
}