package kr.or.ddit.employeeInfo.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.employeeInfo.service.CommuteService;
import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.extern.slf4j.Slf4j;

/**
 * 인사정보
 * 
 * 근무관리
 * - 출퇴근관리
 * - 잔업신청
 * @author yeeji
 *
 */
@Slf4j
@Controller
@RequestMapping("/employeeInfo/dutyManagement")
public class DutyManagementController {
	
	@Inject
	private CommuteService commuteService;
	
	@ModelAttribute("commute")
	public CommuteVO commute(Authentication authentication) {
		EmployeeVOWrapper wrapper = (EmployeeVOWrapper) authentication.getPrincipal();
		CommuteVO commute = new CommuteVO();
		commute.setEmpId(authentication.getName());
		return commute;
	}
	
	/**
	 * 근무관리 메인
	 * @return
	 */
	@GetMapping("main.do")
	public String dutyManagementMain(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "dutyManagement");
		return "employeeInfo/dutyManagement/main";
	}
	
	
	
	/**
	 * 내 출퇴근기록 조회
	 */
	@GetMapping(value = "retrieveMyCommuteToday.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public CommuteVO retrieveMyCommuteToday(
		@ModelAttribute("commute") CommuteVO commute
	) {
		return commuteService.retrieveMyCommuteToday(commute);
	}
	
	
	
	/**
	 * 내 출근 체크
	 */
	@PostMapping("createMyCommute.do")
	public String createMyCommute(
		@Validated(value = {InsertGroup.class}) @ModelAttribute("commute") CommuteVO commute
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
			// 오늘 출퇴근 기록 조회
			try {
				if(commuteService.retrieveMyCommuteToday(commute)==null) {
					commuteService.createMyCommute(commute);
				}else {
					model.addAttribute("message", "이미 출근했습니다.");
				}
			}catch (Exception e) {
				model.addAttribute("message", "시스템 오류가 발생했습니다. 관리자에게 문의하세요.");
				log.info("시스템 오류 : {}", e.toString());
			}
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}else {
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}
	}
	
	
	
	/**
	 * 내 퇴근 체크
	 */
	@PostMapping("modifyMyCommute.do")
	public String modifyMyCommute(
		@Validated(value = {UpdateGroup.class}) @ModelAttribute("commute") CommuteVO commute
		, Errors errors
//		, @RequestParam(value="case") String case
	) {
		if(!errors.hasErrors()) {
			try {
				commuteService.modifyMyCommute(commute);
			}catch (Exception e) {
				e.printStackTrace();
			}
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}else {
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}
	}
	
	  
	/**
	 * 내 근무상태 변경
	 */
	@PostMapping("modifyMyCommuteStatus.do")
	public String modifyMyCommuteCase(
		@Validated(value = {UpdateGroup.class}) @ModelAttribute("commute") CommuteVO commute
		, Errors errors
		, @RequestParam("status") String status
	) {
		if(!errors.hasErrors()) {
			try {
				if(status.equals("meeting")) {
					commuteService.modifyMyCommuteMeeting(commute);
				}else if(status.equals("outside")) {
					commuteService.modifyMyCommuteOutside(commute);
				}else if(status.equals("businessTrip")) {
					commuteService.modifyMyCommuteBusinessTrip(commute);
				}else if(status.equals("home")) {
					commuteService.modifyMyCommuteHome(commute);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}else {
			return "redirect:/employeeInfo/dutyManagement/main.do";
		}
	}
	
	
	
	
	/**
	 * 출퇴근체크
	 * @return
	 */
	@GetMapping("checkCommute.do")
	public String checkCommute(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "dutyManagement");
		model.addAttribute("level3Menu", "checkCommute");
		return "employeeInfo/dutyManagement/checkCommute";
	}
	
	
	
	/**
	 * 잔업신청
	 * @return
	 */
	@GetMapping("applyNightDuty.do")
	public String applyNightDuty(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "dutyManagement");
		model.addAttribute("level3Menu", "applyNightDuty");
		return "employeeInfo/dutyManagement/applyNightDuty";
	}
}
