package kr.or.ddit.dao;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.dao.PositionDAO;
import kr.or.ddit.msg.dao.MessageDAO;
import kr.or.ddit.msg.vo.MsgRoomVO;
import kr.or.ddit.mypage.dao.MypageDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class alarmTest2 extends AbstractModelLayerTest {
	
	@Inject
	private AlarmDAO dao;
	
	@Test
	public void selectAlarmList()  {
		
		assertNotNull(dao.selectAlarmList("a100001"));
		
	}

	@Test
	public void selectAlarm()  {
		
		assertNotNull(dao.selectAlarm(4));
		
	}

	@Test
	public void insertAlarm()  {
		
		AlarmVO vo = new AlarmVO();
		vo.setEmpId("a100001");
		vo.setAlmContent("아 그만하고싶다");
		
		assertNotNull(dao.insertAlarm(vo));
		
	}

	
	@Test
	public void updateAlarm()  {
		
		assertNotNull(dao.readAlarm(124));
		
	}

	
	
	
}
