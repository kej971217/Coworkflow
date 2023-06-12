package kr.or.ddit.dao;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.msg.dao.MessageDAO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import kr.or.ddit.mypage.dao.MypageDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class msgTest extends AbstractModelLayerTest {
	
	@Inject
	private MessageDAO msgDAO;
	
	@Test
	public void testSelectRoomInfoList()  {
		
		assertNotNull(msgDAO.selectMsgInfoList("a100001"));
		
	}

	@Test
	public void selectMsgRoomEmp()  {
		
		assertNotNull(msgDAO.selectMsgRoomEmp(314));
		
	}
	

	@Test
	public void selectMsgRoom()  {
		
		assertNotNull(msgDAO.selectMsgRoom(314));
		
	}
	
	
	
	

	@Test
	public void insertMsgRoomEmp()  {
		
		MsgRoomVO vo = new MsgRoomVO();
		vo.setMsgRoomName("김민준, 조욱제");
		
		assertNotNull(msgDAO.insertMsgRoom(vo));
		
	}

	
	@Test
	public void insertMsgInfoEmp()  {
		
		MsgRoomVO vo = new MsgRoomVO();
		vo.setMsgRoomName("김민준, 조욱제");
		
		assertNotNull(msgDAO.insertMsgRoom(vo));
		
	}
	
	@Test
	public void selectMessage() {
		
	assertNotNull(msgDAO.selectMessageList(3));
		
	}
	

	
	
}
