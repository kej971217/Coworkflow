package kr.or.ddit.alarm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.alarm.service.AlarmService;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/alarm")
public class AlarmController {
	
	@Inject
	private AlarmService almService;
	
	@Inject
	private EmpService empService;
	
	@Inject
	private SimpMessagingTemplate messagingTmpl;

	// 알람을 리스트로 뽑아서 보내주는 메서드
	@RequestMapping("checkAlarmList")
	public String checkAlarmList(
			@RequestBody Map<String,String> mapData, Model model,  Authentication authentication
			) {
		List<AlarmVO> DBalarmList = new ArrayList<AlarmVO>();
	if(mapData.get("empId")!=null) {
		// 알람 리스트 확인해야지.
		DBalarmList = almService.selectAlarmList(mapData.get("empId"));
		
	}else {
		DBalarmList = almService.selectAlarmList(authentication.getName());
		
	}
	
	List<AlarmVO> alarmList = new ArrayList<AlarmVO>();
	
	for(AlarmVO vo : DBalarmList) {
		//알람보내는 상대 직원 이름 검색.
	 String empName = empService.selectEmp(vo.getAlmApponent()).getEmpName();
	 String myName = empService.selectEmp(vo.getEmpId()).getEmpName();
	 String content = myName +" "+ vo.getAlmContent();
	
	 vo.setAlmContent(content);
	 if(vo.getAlmType().equals("NOTICE")) {
		 empName = "관리자";
	 }
	 vo.setAlmApponentName(empName);
	 vo.setEmpName(myName);
	 alarmList.add(vo);
	}
	
	model.addAttribute("alarmList", alarmList);
		
		return "jsonView";
	}
	
	
	
	// 알람을 새롭게 추가하는 메서드	
	@RequestMapping("insertAlarm")
	public String enterRoom(
			@RequestBody AlarmVO alarmVO, Model model) {
		
//입력된 해당 알람 받아서 DB에 담기.
		AlarmVO newAlarm = almService.insertAlarm(alarmVO);
		
		newAlarm.setAlmApponentName(empService.selectEmp(alarmVO.getAlmApponent()).getEmpName());
		newAlarm.setEmpName(empService.selectEmp(alarmVO.getEmpId()).getEmpName());
		
		model.addAttribute("newAlarm", newAlarm);
		
		return "jsonView";
	}
	
	
	@RequestMapping("readAlarm")
	public String readAlarm(
			@RequestBody Integer almNum, Model model	) {
		
		almService.readAlarm(almNum);
		
		return "jsonView";
	}
	
	
	@RequestMapping("allEmpAlarm")
	public String allEmpAlarm(
		  @RequestBody AlarmVO alarmVO, Model model ) {
		List<EmployeeVO> empList = empService.allEmpList();
		List<AlarmVO> newAlarmList = new ArrayList<AlarmVO>();
		
		for(EmployeeVO emp : empList) {
		   alarmVO.setEmpId(emp.getEmpId());
		   AlarmVO newAlarm = almService.insertAlarm(alarmVO);
		   newAlarm.setEmpName(empService.selectEmp(alarmVO.getEmpId()).getEmpName());
		   
		   newAlarmList.add(newAlarm);
		}
		
		   messagingTmpl.convertAndSend("/topic/alarm/reset", "메세지갑니다");
		model.addAttribute("newAlarmList", newAlarmList);
		
		return "jsonView";
	}
	
	
	
}
