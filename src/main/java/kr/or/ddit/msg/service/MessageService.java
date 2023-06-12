package kr.or.ddit.msg.service;

import java.util.List;

import kr.or.ddit.msg.vo.MessageVO;
import kr.or.ddit.msg.vo.MsgInfoVO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;

public interface MessageService {
	
	/**
	 * empId를 이용하여 로그인 한 사람이 가지고 있는 모든 채팅방의 대한 정보를 가져오는 메서드
	 * @param empId
	 * @return List<MsgInfoVO> 
	 */
	public List<MsgInfoVO> selectMsgInfoList(String empId);
	
	/**
	 * msgRoomId를 이용하여 해당 채팅방의 정보를 가져오는 메서드
	 * @param msgRoomId
	 * @return MsgRoomVO
	 */
	public MsgRoomVO selectMsgRoom(Integer msgRoomId);
	
	/**
	 * msgRoomId를 이용하여 해당 채팅방의 참여자의 정보를 가져오는 메서드
	 * @param msgRoomId
	 * @return
	 */
	public List<MsgInfoVO> selectMsgRoomEmp(Integer msgRoomId);
	
	/**
	 * 대화방을 생성하는 메서드 - RoomId 는 시퀸스로 자동증가. 생성 날짜는 그 현재 시간. 
	 * @param msgRoomVO
	 * @return
	 */
	public int insertMsgRoom(MsgRoomVO msgRoomVO);

	public int insertMsgInfo(MsgInfoVO msgInfoVO);
	
		
	/**
	 *  채팅 만들기에서 팀원들을 팀별로 뽑기위한 메서드 
	 * @return
	 */
	public List<EmployeeDPMTVO> empList(String teamName);
	public List<EmployeeDPMTVO> departList();
	
	
	/**
	 * msgRoomId 를 이용하여 해당 채팅방에 메세지가 있는지 확인하는 메서드.
	 * @param msgRoomId
	 * @return
	 */
	public List<MessageVO> selectMessageList(Integer msgRoomId);
	
	
	public MessageVO insertMsg(MessageVO messageVO);

	public void updateMsgInfo(MessageVO messageVO);
	
}
