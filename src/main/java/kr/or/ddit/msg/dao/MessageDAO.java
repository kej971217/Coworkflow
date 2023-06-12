package kr.or.ddit.msg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.msg.vo.MessageVO;
import kr.or.ddit.msg.vo.MsgInfoVO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;

@Mapper
public interface MessageDAO {
	
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
	
	
	/**
	 * 생성된 roomId 를 가지고 empId 하나당 하나씩 msgInfo을 만들어주는 메서드.
	 * @param msgInfoVO
	 * @return
	 */
	public int insertMsgInfo(MsgInfoVO msgInfoVO);
	
	
	/**
	 *  채팅 만들기에서 팀원들을 팀별로 뽑기위한 메서드 
	 * @return
	 */
	public List<EmployeeDPMTVO> empList(String teamName);
	public List<EmployeeDPMTVO> departList();

	
	/**
	 * messageId를 받아 해당 채팅방에 메세지가 있는지 확인하는 메서드 
	 * @param messageId
	 * @return
	 */
	public List<MessageVO> selectMessageList(Integer messageId);
	
	
	/**
	 * 메세지를 DB에 입력하는 메서드 
	 * @param messageVO
	 * @return
	 */
	public int insertMsg(MessageVO messageVO);
	
	
	/**
	 * 메세지 Id 를 이용하여 Message를 조회하는 메서드 
	 * @param msgId
	 * @return
	 */
	public MessageVO selectMsg(Integer msgId);
	
	/**
	 * msgRoomId 로 msgInfo들의 정보를 가져오는 메서드 
	 * 추후 이것으로 상대와 담겨있는 message 넣어줄 예정.
	 * @param msgRoomId
	 * @return
	 */
	public int updateMsgInfo(MessageVO messageVO);
	
	
}
