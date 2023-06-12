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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.service.OrganizationInfoService;
import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employeeInfo.service.AnnualLeaveRecordService;
import kr.or.ddit.employeeInfo.service.CommuteService;
import kr.or.ddit.employeeInfo.service.PayrollRecordsService;
import kr.or.ddit.employeeInfo.service.VacationService;
import kr.or.ddit.employeeInfo.vo.AnnualLeaveRecordVO;
import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.employeeInfo.vo.PayrollRecordsVO;
import kr.or.ddit.employeeInfo.vo.VacationVO;

/**
 * 인사 정보
 * 
 * 내 정보 조회
 * - 내 근무 현황 workStatus
 * - 내 휴가 내역 vacationStatus
 * - 내 근무 조건 workingCodition
 * - 내 급여내역서 salaryStatement
 * @author yeeji
 *
 */
@Controller
@RequestMapping("/employeeInfo/myInfo")
public class MyInfoController {
	
	/**
	 * 내 정보 조회 메인
	 * @return
	 */
	@GetMapping("main.do")
	public String myInfoMain(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "myInfo");
		return "employeeInfo/myInfo/main";
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
	 * 내 근무 현황
	 * @return
	 */
	@GetMapping("workStatus.do")
	public String workStatus(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "myInfo");
		model.addAttribute("level3Menu", "workStatus");
		return "employeeInfo/myInfo/workStatus";
	}
	
	/**
	 * 내 근무 현황 리스트 조회
	 * @return
	 */
	@GetMapping(value = "selectMyCommuteList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CommuteVO> selectMyCommuteList(
		@ModelAttribute("commute") CommuteVO commute
	){
		return commuteService.retrieveMyCommuteList(commute);
	}
	
	
	
	
/////////////////////////////////////////////////////////////////
	
	@Inject
	private VacationService vacationService;
	
	@ModelAttribute("vacation")
	public VacationVO vacation(Authentication authentication) {
		EmployeeVOWrapper wrapper = (EmployeeVOWrapper) authentication.getPrincipal();
		VacationVO vacation = new VacationVO();
		vacation.setEmpId(authentication.getName());
		return vacation;
	}
	
	/**
	 * 내 휴가 내역
	 * @return
	 */
	@GetMapping("vacationStatus.do")
	public String vacationStatus(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "myInfo");
		model.addAttribute("level3Menu", "vacationStatus");
		return "employeeInfo/myInfo/vacationStatus";
	}
	
	@GetMapping(value = "selectMyVacationList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<VacationVO> selectMyVacationList(
		@ModelAttribute("vacation") VacationVO vacation
	){
		return vacationService.retrieveMyVacationList(vacation);
	}
	
/////////////////////////////////////////////////////////////////
	
	@Inject
	private OrganizationInfoService orgInfoService;
	
	@ModelAttribute("orgInfo")
	public OrganizationInfoVO orgInfo(Authentication authentication) {
		EmployeeVOWrapper wrapper = (EmployeeVOWrapper) authentication.getPrincipal();
		OrganizationInfoVO orgInfo = new OrganizationInfoVO();
		orgInfo.setEmpId(authentication.getName());
		return orgInfo;
	}
	
	/**
	 * 내 근무 조건
	 * @return
	 */
	@GetMapping("workingCodition.do")
	public String workingCodition(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "myInfo");
		model.addAttribute("level3Menu", "workingCodition");
		return "employeeInfo/myInfo/workingCodition";
	}
	
	
	/**
	 * 내 근무 조건 조회
	 * @param annualLeaveRecord
	 * @return
	 */
	@GetMapping(value = "selectMyWorkingCondition.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<OrganizationInfoVO> selectMyWorkingCondition(
		@ModelAttribute("orgInfo") OrganizationInfoVO orgInfo
	){
		List<OrganizationInfoVO> orgInfoList = new ArrayList<OrganizationInfoVO>();
		orgInfoList.add(orgInfoService.retrieveEmpInfo(orgInfo));
		return orgInfoList;
	}
	
/////////////////////////////////////////////////////////////////
	
	@Inject
	private PayrollRecordsService payrollRecordsService;
	
	@ModelAttribute("payrollRecord")
	public PayrollRecordsVO payrollRecord(Authentication authentication) {
		EmployeeVOWrapper wrapper = (EmployeeVOWrapper) authentication.getPrincipal();
		PayrollRecordsVO payrollRecord = new PayrollRecordsVO();
		payrollRecord.setEmpId(authentication.getName());
		return payrollRecord;
	}
	
	/**
	 * 내 급여내역서
	 * @return
	 */
	@GetMapping("salaryStatement.do")
	public String salaryStatement(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "myInfo");
		model.addAttribute("level3Menu", "salaryStatement");
		return "employeeInfo/myInfo/salaryStatement";
	}
	
	/**
	 * 내 급여내역서 리스트 조회
	 * @return
	 */
	@GetMapping(value = "selectMyPayrollRecordsList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<PayrollRecordsVO> selectMyPayrollRecordsList(
		@ModelAttribute("payrollRecord") PayrollRecordsVO payrollRecord
	){
		return payrollRecordsService.retrieveMyPayrollRecordsList(payrollRecord);
	}
}
