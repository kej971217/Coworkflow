package kr.or.ddit.employeeInfo.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.service.OrganizationInfoService;
import kr.or.ddit.employee.vo.OrganizationInfoVO;

/**
 * 인사 정보
 * 
 * 인사 정보 관리
 * @author yeeji
 *
 */
@Controller
@RequestMapping("/employeeInfo/reports")
public class ReportsController {
	
	@Inject
	private OrganizationInfoService orgInfoService;
	
	@GetMapping("main.do")
	public String employeeInfoReports(Model model) {
		model.addAttribute("level1Menu", "employeeInfo");
		model.addAttribute("level2Menu", "reports");
		return "employeeInfo/reports/main";
	}
	
	//	직급별 인원
	@PostMapping(value = "rankCnt.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectRankCnt(
		Model model
	) {
		List<OrganizationInfoVO> rankCntList = orgInfoService.retrieveRankCount();
		model.addAttribute("rankCntList", rankCntList);
		return "jsonView";  
	}
	
	
	// 부서별 인원
	@PostMapping(value = "depEmpCnt.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectDepEmpCnt(
		Model model	
	) {
		List<OrganizationInfoVO> depEmpCntList = orgInfoService.retrieveDepEmpCount();
		model.addAttribute("depEmpCntList", depEmpCntList);
		return "jsonView";  
	}
	
	// 부서별 성별
	@PostMapping(value = "depGendRatio.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectDepGendRatio(
		Model model
	) {
		List<OrganizationInfoVO> depGendRatioList = orgInfoService.retrieveDepGendRatio();
		model.addAttribute("depGendRatioList", depGendRatioList);
		return "jsonView";
	}
	
	// 부서별 연령대
	@PostMapping(value = "depAgeGroupCnt.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String selectdepAgeGroupCnt(
		Model model
	) {
		List<OrganizationInfoVO> depAgeGroupCntList = orgInfoService.retrieveDepAgeGroupCnt();
		model.addAttribute("depAgeGroupCntList", depAgeGroupCntList);
		return "jsonView";
	}
	
	
	
}
