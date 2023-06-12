package kr.or.ddit.employeeInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.service.OrganizationInfoService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.employeeInfo.vo.OrganizationInfoVOWrpperForJstree;
import kr.or.ddit.mypage.service.MypageService;

/**
 * 인사정보
 * 
 * 조직도
 * 
 * @author yeeji
 *
 */
@Controller
@RequestMapping("organizationChart")
public class OrganizationChartController {
	
	@Inject
	private OrganizationInfoService orgInfoService;
	
	@Inject
	private EmpService empService;
	
	@Inject
	private MypageService mypageService;
	
	/**
	 * 조직도 메인
	 * @return
	 */
	@GetMapping("main.do")
	public String organizationChartUI(Model model) {
		model.addAttribute("level1Menu", "organizationChart");
		return "organizationChart/main";      
	}
	
	
	
	@RequestMapping(value="jstree", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
//	public List<OrganizationInfoVOWrpperForJstree> getJson(){
	public List<Map<String, String>> getJson(){
		List<OrganizationInfoVO> orgInfoList = orgInfoService.retrieveOrgInfoDepList();
		List jsTreeList = new ArrayList<>();
		
		for(OrganizationInfoVO orgInfo : orgInfoList) {
			Map<String, String> jsTreeMap = new HashMap<>();
			jsTreeMap.put("id", orgInfo.getTeamId().toString());
			if(orgInfo.getBelongTeam().toString().equals("0")) { // CEO실
				jsTreeMap.put("parent", "#");
				jsTreeMap.put("text", orgInfo.getEmpName().toString());
				jsTreeMap.put("icon", "fa-solid fa-sitemap");
				
			}else if(orgInfo.getBelongTeam().toString().equals("1")) { // 본부
				jsTreeMap.put("parent", orgInfo.getBelongTeam().toString());
				jsTreeMap.put("text", orgInfo.getEmpName().toString());
				jsTreeMap.put("icon", "fa-solid fa-hotel");
			}else {
				jsTreeMap.put("parent", orgInfo.getBelongTeam().toString());
				jsTreeMap.put("icon", "fa-solid fa-flag");
			}
			jsTreeMap.put("text", orgInfo.getTeamName().toString());
			jsTreeList.add(jsTreeMap);
			
//			if(!orgInfo.getBelongTeam().toString().equals("0") 
//					&& !orgInfo.getBelongTeam().toString().equals("1")) {
				jsTreeMap = new HashMap<>();
				jsTreeMap.put("id", orgInfo.getEmpId().toString());
				jsTreeMap.put("parent", orgInfo.getTeamId().toString());
				jsTreeMap.put("text", orgInfo.getEmpName().toString());
				jsTreeMap.put("icon", "fa-solid fa-user");
				jsTreeList.add(jsTreeMap);
				
//			}
		
			
		}
		
		// 리스트 중복제거를 위해 해쉬셋으로 바꿨다가 리스트로 다시 리턴
		HashSet<Map<String, String>> jsTreeListSet = new HashSet<Map<String,String>>(jsTreeList);
		List<Map<String, String>> jsTreeList2 = new ArrayList<Map<String,String>>(jsTreeListSet);
		
		return jsTreeList2;
	}
	
	
	@GetMapping(value = "empDetail.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmployeeVO selectEmpDetail(String empId) {
		EmployeeVO emp = empService.selectEmpDetail(empId);
		emp.setMypage(mypageService.retrieveMypage(empId));
		return emp;
	}
	
	
}



//$(function () {
//	$('#jstree1').jstree();
//	$('#jstree2').jstree({'plugins':["wholerow","checkbox"], 'core' : {
//		'data' : [
//			{
//				"text" : "Same but with checkboxes",
//				"children" : [
//					{ "text" : "initially selected", "state" : { "selected" : true } },
//					{ "text" : "custom icon URL", "icon" : "//jstree.com/tree-icon.png" },
//					{ "text" : "initially open", "state" : { "opened" : true }, "children" : [ "Another node" ] },
//					{ "text" : "custom icon class", "icon" : "glyphicon glyphicon-leaf" }
//				]
//			},
//			"And wholerow selection"
//		]
//	}});
//});

