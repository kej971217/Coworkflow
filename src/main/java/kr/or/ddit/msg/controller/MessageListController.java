package kr.or.ddit.msg.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.msg.service.MessageService;
import kr.or.ddit.msg.vo.MsgInfoVO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 채팅 메인.  대부분의 기능은 모달이나 창 내부에서 직접 실현할 예정.
 * @author raccoon
 *
 */
@Slf4j
@Controller
@RequestMapping("/msg")
public class MessageListController {

	@Inject
	private MessageService msgService;
	
	@Inject
	private EmpService empService;
	
	@Inject
	private MypageService mypageService;
	
	/**
	 * UI 제공
	 * @param model 템플릿의 구조상 계속 넣어줘야하는 것.
	 * @return
	 */
	@GetMapping("messageList.do")
	public String getUI(Model model, Authentication authentication) {
	
	 String	loginId = authentication.getName();
//	 List<MsgInfoVO> msgInfoList =	msgService.selectMsgInfoList(loginId);
	 
	 

	 
		model.addAttribute("level1Menu", "msg");
//		model.addAttribute("msgInfoList",msgInfoList);
		model.addAttribute("loginId",loginId);
		
		//셀렉트에 들어갈 직원 목록
		List<EmployeeDPMTVO> departList = msgService.departList();
		model.addAttribute("departList",departList);
		
		return "msg/msgMain";
	}

	@RequestMapping(value = "empData", produces = MediaType.APPLICATION_JSON_VALUE)
	public String empdata(
			Authentication authentication, Model model) {
		EmployeeVO empData= empService.selectEmp(authentication.getName());
		
			model.addAttribute("empData",empData);
		
		return "jsonView";
	}
	
	/**
	 * 채팅방을 추가하고 나서 다시 새롭게 채팅방 리스트를 조회하기 위한 메서드.
	 * @param model
	 * @param authentication
	 * @return
	 */
	@RequestMapping(value = "messageResetList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public String resetList(Model model, Authentication authentication) {
		List<MsgInfoVO> msgInfoList = msgService.selectMsgInfoList(authentication.getName());
		 EmployeeVO employee = empService.selectEmpDetail(authentication.getName());
	
		 log.info("msginfolist 값 {}", msgInfoList); 
		 
		if(msgInfoList != null && msgInfoList.size()>0) {
			model.addAttribute("msgInfoList",msgInfoList);
			model.addAttribute("employee",employee);
			
			//셀렉트에 들어갈 직원 목록
			List<EmployeeDPMTVO> departList = msgService.departList();
			model.addAttribute("departList",departList);
		}else {
			model.addAttribute("message", "서버 오류로 인해 등록 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}


	/**
	 * 직원 채팅 목록을 나타내기 위한 메서드
	 * @param model
	 * @param authentication
	 * @return
	 */
	@RequestMapping(value = "excludedMeEmpList", produces = MediaType.APPLICATION_JSON_VALUE)
	public String empList(Model model, Authentication authentication) {
		
		List<EmployeeVO> msgEmpList= empService.excludedMeEmpList(authentication.getName());
		if(msgEmpList != null && msgEmpList.size()>0) {
			model.addAttribute("msgEmpList",msgEmpList);
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value = "includedName", produces = MediaType.APPLICATION_JSON_VALUE)
	public String includedNameSearch(
			@RequestBody EmployeeVO employee, Model model) {
		log.info("EmployeeVO 는 어떻게 나오는가? {}",employee);
		List<EmployeeVO> msgEmpList= empService.includedNameEmpList(employee.getEmpName());
		if(msgEmpList != null && msgEmpList.size()>0) {
			model.addAttribute("msgEmpList",msgEmpList);
		}
		
		return "jsonView";
	}
	

	
	
	
	
}
