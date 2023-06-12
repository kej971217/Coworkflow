package kr.or.ddit.msg.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.msg.dao.MessageDAO;
import kr.or.ddit.msg.vo.MessageVO;
import kr.or.ddit.msg.vo.MsgInfoVO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.mypage.vo.MypageVO;
import kr.or.ddit.schedule.vo.SchdlMemberVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	private MessageDAO msgDAO;
	
	@Inject
	private MypageService mypageService;
	
	
	@Override
	public List<MsgInfoVO> selectMsgInfoList(String empId) {
		// 해당 직원이 속한 채팅방 리스트 검색
		List<MsgInfoVO> list = msgDAO.selectMsgInfoList(empId);
		
		for(MsgInfoVO msgInfo  : list ) {
			// 채팅방 리스트중 해당 roomId 에 해당하는 채팅방 정보 검색.
			List<MsgInfoVO> roomInfoList =  msgDAO.selectMsgRoomEmp(msgInfo.getMsgRoomId());
			
			// 그룹 채팅을 대비해서 넣어줄 이름을 리스트로 미리 만들어 두기.
			List<String> nameList = new ArrayList<String>(); 
			for(MsgInfoVO apponentRoomInfo : roomInfoList) {
					
					// 채팅방의 속한 ID가 본인과 같지 않으면
						if(!empId.equals(apponentRoomInfo.getEmpId())){
							
							// 채팅 참여하는 상대방이 1명이면 프로필 사진을 마이페이지에서 불러와서 저장해준다.
							if( msgInfo.getMypage() == null && roomInfoList.size()<=2 )
								msgInfo.setMypage(mypageService.retrieveMypage(apponentRoomInfo.getEmpId()));
							
							// 해당 채팅방의 EMP name을 리스트에 넣어준다. 
							nameList.add(apponentRoomInfo.getEmpName());
							
							// 해당 채팅방의 EMP name 을 name 컬럼에 넣어준다.	
							msgInfo.setApponentName(apponentRoomInfo.getEmpName());
						
						}
				}
				
				
	
				
				
				// 리스트에 넣어주는 것이 끝나면 리스트를 msginfo에 넣어준다.
				msgInfo.setEmpNameList(nameList);
				
				// 상대 이름을 문자열로 만들기 위한 작업.
				String apponent = "";
				for(String name : nameList) {
					apponent = apponent+ ", " + name;
				}
				// 앞에 , 제거.
				apponent = apponent.substring(2,apponent.length());
				msgInfo.setApponentName(apponent);
				
				if(msgInfo.getLastMsgContent() ==null) {
					msgInfo.setLastMsgContent("");
				}
				
		}
		
		return list;
	}
	
	
	@Override
	public MsgRoomVO selectMsgRoom(Integer msgRoomId) {
		
	  MsgRoomVO vo = msgDAO.selectMsgRoom(msgRoomId);

		return vo;
	}

	
	@Override
	public List<MsgInfoVO> selectMsgRoomEmp(Integer msgRoomId) {
		
		List<MsgInfoVO> participants = msgDAO.selectMsgRoomEmp(msgRoomId);
		
		return participants;
	}

	/**
	 *팀원 리스트
	 */
	@Override
	public List<EmployeeDPMTVO> empList(String teamName) {
	
		return msgDAO.empList(teamName);
	}
	/**
	 *팀명 리스트
	 */
	@Override
	public List<EmployeeDPMTVO> departList() {
		
		return msgDAO.departList();
	}

	@Override
	public int insertMsgRoom(MsgRoomVO msgRoomVO) {
		
		int result = msgDAO.insertMsgRoom(msgRoomVO);
		for(MsgInfoVO tmp : msgRoomVO.getChatMemberList( msgRoomVO.getEmpInfoId())) {
			tmp.setMsgRoomId(msgRoomVO.getMsgRoomId());
			result += msgDAO.insertMsgInfo(tmp);
		}
		return result;
		
	}


	@Override
	public int insertMsgInfo(MsgInfoVO msgInfoVO) {
		return msgDAO.insertMsgInfo(msgInfoVO);
	}



	@Override
	public List<MessageVO> selectMessageList(Integer msgRoomId) {
		return msgDAO.selectMessageList(msgRoomId);
	}


	@Override
	public MessageVO insertMsg(MessageVO messageVO) {
		int res = msgDAO.insertMsg(messageVO);
		
		messageVO = msgDAO.selectMsg(messageVO.getMsgId());
		
		return messageVO;
	}


	@Override
	public void updateMsgInfo(MessageVO messageVO) {
		msgDAO.updateMsgInfo(messageVO);
		
	}



}
