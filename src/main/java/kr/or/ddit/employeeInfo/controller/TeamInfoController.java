package kr.or.ddit.employeeInfo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employeeInfo.service.CommuteService;
import kr.or.ddit.employeeInfo.service.VacationService;
import kr.or.ddit.employeeInfo.vo.AnnualLeaveRecordVO;
import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.employeeInfo.vo.VacationVO;
import kr.or.ddit.employeeInfo.vo.VacationVOWrapperForFullCalendar;
import kr.or.ddit.vo.SimpleCondition;
import kr.or.ddit.vo.TabulatorPagination;
import kr.or.ddit.vo.TabulatorSimpleCondition;

/**
 * 인사 정보
 * 
 * 팀 정보 조회 - 팀 근무 현황 workStatus - 팀 휴가 현황 vacationStatus
 * 
 * @author yeeji
 *
 */
@Controller
@RequestMapping("/employeeInfo/teamInfo")
public class TeamInfoController {

	/**
	 * 팀 정보 조회 메인
	 * 
	 * @return
	 */
	@GetMapping("main.do")
	public String myInfoMain(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "teamInfo");
		return "employeeInfo/teamInfo/main";
	}

/////////////////////////////////////////////////////////////////

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
	 * 팀 근무 현황
	 * 
	 * @return
	 */
	@GetMapping("workStatus.do")
	public String workStatus(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "teamInfo");
		model.addAttribute("level3Menu", "teamWorkStatus");
		return "employeeInfo/teamInfo/workStatus";
	}

	/**
	 * 팀 근무 현황 리스트 조회(Tabulator 페이징, 검색 기능 추가)
	 * 
	 * @return
	 */
	@GetMapping(value = "selectTeamCommuteList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public TabulatorPagination<CommuteVO> selectTeamCommuteList(
			@ModelAttribute("commute") CommuteVO commute,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "screenSize", required = false, defaultValue = "10") int screenSize,
			@RequestParam(value = "filter", required = false) List<TabulatorSimpleCondition> tabulatorSimpleCondition ) {
	
		
		TabulatorPagination<CommuteVO> tabulatorPagination = new TabulatorPagination<CommuteVO>();
//		tabulatorPagination.setEntity(commute);
		
		tabulatorPagination.setEmpId(commute.getEmpId());
//		log.info("empId : {}", CommuteVO);
		tabulatorPagination.setCurrentPage(currentPage);
		tabulatorPagination.setScreenSize(screenSize);
		
		if(tabulatorSimpleCondition!=null) {
			tabulatorPagination.setTabulatorSimpleCondition(tabulatorSimpleCondition.get(0));
		}
		
		commuteService.retrieveTeamCommuteList(tabulatorPagination);
		return tabulatorPagination;
	}
	
	
//	@GetMapping(value = "selectTeamCommuteList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public List<CommuteVO> selectTeamCommuteList(
//		@ModelAttribute("commute") CommuteVO commute
//	){
//		commuteService.retrieveTeamCommuteList(commute);
//	}
	
	
	
	
/////////////////////////////////////////////////////////////////
	
	@Inject
	private VacationService vacationService;
	
	@ModelAttribute("vacation")
	public VacationVO evacation(Authentication authentication) {
		EmployeeVOWrapper wrapper = (EmployeeVOWrapper) authentication.getPrincipal();
		VacationVO vacation = new VacationVO();
		vacation.setEmpId(authentication.getName());
		return vacation;
	}
	
	/**
	 * 팀 휴가 현황
	 * 
	 * @return
	 */
	@GetMapping("vacationStatus.do")
	public String vacationStatus(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "teamInfo");
		model.addAttribute("level3Menu", "teamVacationStatus");
		return "employeeInfo/teamInfo/vacationStatus2";  
	}
	
	@GetMapping(value = "selectTeamVacationList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<VacationVOWrapperForFullCalendar> selectTeamVacationList(
		@ModelAttribute("vacation") VacationVO vacation
	){
		List<VacationVO> vacationList = vacationService.retrieveTeamVacationList(vacation);
		List<VacationVOWrapperForFullCalendar> fullCalendarList = new ArrayList<VacationVOWrapperForFullCalendar>();
		for(VacationVO vo :  vacationList) {
			fullCalendarList.add(new VacationVOWrapperForFullCalendar(vo));
		}
		return fullCalendarList;
	}
	
	
	
}
