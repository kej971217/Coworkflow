package kr.or.ddit.msg.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.http.MediaType;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.msg.service.MessageService;
import kr.or.ddit.msg.vo.MessageVO;
import kr.or.ddit.msg.vo.MsgInfoVO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/chatting")
public class ChattingController {
	
	@Inject
	private SimpMessagingTemplate msgTmpl;
	
	@Inject
	private MessageService msgService;
	
	@PostMapping(value="makeRoom", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String makeRoom(
			@RequestBody MsgRoomVO msgRoomVO, Authentication authentication
			) {
	
		int res = msgService.insertMsgRoom(msgRoomVO);
		
		MsgInfoVO infoVO = new MsgInfoVO();
		infoVO.setMsgRoomId(msgRoomVO.getMsgRoomId());
		infoVO.setEmpId(authentication.getName());
		
		msgService.insertMsgInfo(infoVO);
		
		MsgRoomVO newRoom = new MsgRoomVO(msgTmpl, msgRoomVO.getMsgRoomId(), msgRoomVO.getMsgRoomName());
		msgTmpl.convertAndSend("/chatting/roomList", newRoom);
		return "jsonView";				
	}
	
	
	
	@RequestMapping("enter/{roomId}")
	public String enterRoom(
			@PathVariable Integer roomId, Authentication authentication,
			Model model
			) {
		
//		해당 채팅방 검색
		MsgRoomVO findedRoom = msgService.selectMsgRoom(roomId);
		
//		log.info("findedRoom 객체 확인 {}", findedRoom );
		
		List<MsgInfoVO> list = findedRoom.getMsgInfoList();
		
		findedRoom = new MsgRoomVO(msgTmpl, roomId, findedRoom.getMsgRoomName());
//		List<MsgInfoVO> list = msgService.selectMsgInfoList(authentication.getName());
		
		List<MessageVO> messageList = msgService.selectMessageList(roomId);
		List<MsgInfoVO> msgInfoList = msgService.selectMsgRoomEmp(roomId);
		model.addAttribute("findedRoom", findedRoom);
		model.addAttribute("messageList", messageList);
		return "jsonView";
	}
	
	@RequestMapping("addMessage")
	public String sendMessage(@RequestBody MessageVO msgVO, Model model) {
		
		msgVO = msgService.insertMsg(msgVO);
		List<MsgInfoVO> thisRoom = msgService.selectMsgRoomEmp(msgVO.getMsgRoomId());
		
//		log.info("리스트 한번 보쟈 {}",thisRoom);
//		log.info("msgVO {} ",msgVO);
		
		
		for(MsgInfoVO roomInfo : thisRoom) {
			roomInfo.setLastMessage(msgVO);
			roomInfo.setLastMsgDate(msgVO.getMsgDate());
			msgService.updateMsgInfo(msgVO);
		}
		
		
		
		
		model.addAttribute("msgVO", msgVO);
		return "jsonView";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}





