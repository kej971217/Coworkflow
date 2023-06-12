package kr.or.ddit.schedule.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.commons.service.CommService;
import kr.or.ddit.commons.vo.CommVO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.schedule.service.ScheduleService;
import kr.or.ddit.schedule.vo.SchdlMemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;
import kr.or.ddit.schedule.vo.ScheduleVOWrapperForFullCalendar;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
public class ScheduleListController {
	
	@Inject
	private ScheduleService service;
	@Inject
	private CommService commService;

	
	@GetMapping("calendarList.do")
	public String getUI(Model model
			,Authentication authentication
			) {
		String loginId = authentication.getName();
		model.addAttribute("loginId",loginId);
		model.addAttribute("level1Menu", "calendar");
		
		//셀렉트에 들어갈 목록 vo 받기
//		List<CommVO> alram = commService.retrieveA();
//		model.addAttribute("alramList", alram);
		List<CommVO> schdlType = commService.retrieveS();
		model.addAttribute("schdlTypeList", schdlType);
		List<CommVO> travelTime = commService.retrieveB();
		model.addAttribute("travelTimeList", travelTime);
		List<CommVO> isOpen = commService.retrieveK();
		model.addAttribute("isOpenList", isOpen);
		
		
		
		//셀렉트에 들어갈 직원 목록
		List<EmployeeDPMTVO> departList = service.departList();
		model.addAttribute("departList",departList);
		
		
		return "calendar/calendarList2";
	}
	
	
	@RequestMapping(value="calendarList_FC", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ScheduleVOWrapperForFullCalendar> getJson(Model model) {
		
		//스케줄 리스트 조회할 때 쓰는 wrapping구조
		List<ScheduleVO> scheduleList = service.scheduleList();
		List<ScheduleVOWrapperForFullCalendar> list = new ArrayList<>();
		for (ScheduleVO vo : scheduleList) {
			ScheduleVO schedule =  service.selectAttendees(vo.getSchdlId());
			if(schedule != null) {
				vo.setEmpInfoId(schedule.getEmpInfoId());
				vo.setEmpInfoName(schedule.getEmpInfoName());
			}
			list.add(new ScheduleVOWrapperForFullCalendar(vo));
		}
		
		return list;
	}
	
	@ModelAttribute("schedule")
	public ScheduleVO schedule() {
		return new ScheduleVO();
	}
	
	//스케줄 등록
	@RequestMapping(value="calendarInsert", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String ScheduleInsert(@RequestBody ScheduleVO schedule, Errors errors, Model model, Authentication  authentication) {
//		log.info("스케쥴체킁: {}", schedule);
		schedule.setEmpId(authentication.getName());
		int res = service.insertSchedule(schedule);
		if(res > 0) {
			model.addAttribute("result", true);
		}else {
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	//스케줄 업데이트
	@RequestMapping(value="CalendarUpdate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String ScheduleUpdate(@RequestBody ScheduleVO schedule, Errors errors, Model model, Authentication  authentication) {
//		log.info("스케쥴체킁:{}", schedule);
		schedule.setEmpId(authentication.getName());
		int res = service.updateSchedule(schedule);
		if(res > 0) {
			model.addAttribute("result", true);
		}else{
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	//스케줄 삭제
	@RequestMapping(value="CalendarDelete" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String ScheduleDelete(@RequestParam int schdlId, Model model) {
//		log.info("스케쥴 삭제 체킁!", schdlId);
		int res = service.deleteSchedule(schdlId);
		if(res>0) {
			model.addAttribute("result", true);
		}else {
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	//팀원 리스트
	@RequestMapping(value="empList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String empList(@RequestParam String depart, Model model) {
		List<EmployeeDPMTVO> empList = service.empList(depart);
		if(empList != null && empList.size()>0) {
			model.addAttribute("result", true);
			model.addAttribute("empList", empList);
		}else {
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
		
	}
	
	@RequestMapping(value = "mySchdlList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectMyScheduleList(Model model, Authentication authentication) {
		List<ScheduleVO> mySchdlList = service.selectMyScheduleList(authentication.getName());
		if(mySchdlList != null && mySchdlList.size() > 0) {
			model.addAttribute("result", true);
			model.addAttribute("mySchdlList", mySchdlList);
		}else {
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}

}
