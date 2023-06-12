package kr.or.ddit.approval.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.mypage.service.MypageService;

/**
 * 기안 view에서 signup을 할 수 있도록 함
 * 
 * @author 82105
 *
 */
@Controller
@RequestMapping("/approval/signup.do")
public class SignupController {
	
	@Inject
	private ApprovalService aprvService;
	
	@Inject
	private MypageService mypageService;
	
	@GetMapping
	public String getUI(@RequestParam("what") String aprvDocId, Model model) {
		model.addAttribute("aprvDocId",aprvDocId);
		model.addAttribute("level1Menu", "approval");
		return "draft/atrzForm";
	}
	@PostMapping
	@ResponseBody
	public String signup(@RequestBody IsapprovalVO isapproval ,Model model,
			Authentication authentication) {
		
		List<IsapprovalVO> saved = aprvService.retrieveAtrzLineList(isapproval.getAprvDocId());
		List<String> atrzEmpList = new ArrayList<>();
		for (IsapprovalVO atrzLineVO : saved) {
			atrzEmpList.add(atrzLineVO.getEmpId());
		}
		
		if(atrzEmpList.contains(authentication.getName())){
			isapproval.setEmpId(authentication.getName());
			aprvService.createSignup(isapproval);
		}else {
			DeputyApproverVO deputyCheck = new DeputyApproverVO();
			deputyCheck.setEmpId(authentication.getName());
			List<DeputyApproverVO> deputyCheckList = mypageService.retrieveDeputyApprover(deputyCheck);
			
			LocalDateTime now = LocalDateTime.now();
			
			for (DeputyApproverVO deputyVO : deputyCheckList) {
			    String bgnString = deputyVO.getDeputyApproverBgn();
			    String endString = deputyVO.getDeputyApproverEnd();
			    LocalDate bgnDate = LocalDate.parse(bgnString, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			    LocalDate endDate = LocalDate.parse(endString, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			    LocalDateTime deputyBgn = bgnDate.atStartOfDay();
			    LocalDateTime deputyEnd = endDate.atStartOfDay();
			    String empId = deputyVO.getEmpId();

			    if (deputyBgn.isBefore(now) && now.isBefore(deputyEnd) && atrzEmpList.contains(empId)) {
			    	isapproval.setEmpDptId(authentication.getName());
			    	isapproval.setEmpId(empId);
			    	aprvService.createDeputySignup(isapproval);
			    	
			    }
			}
		}
		
		model.addAttribute("level1Menu", "approval");
		return "success";
	}
}
