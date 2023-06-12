package kr.or.ddit.employeeInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 인사정보
 * 
 * 메인
 * @author yeeji
 *
 */
@Controller
@RequestMapping("/employeeInfo")
public class EmployeeInfoMainController {

	@GetMapping("main.do")
	public String main(Model model) {
		model.addAttribute("level1Menu","employeeInfo");
		
		return "employeeInfo/main";
	}
}