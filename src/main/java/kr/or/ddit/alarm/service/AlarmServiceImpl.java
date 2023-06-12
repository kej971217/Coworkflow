package kr.or.ddit.alarm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Inject
	private AlarmDAO almDAO;
	
	
	@Override
	public List<AlarmVO> selectAlarmList(String empId) {
		return almDAO.selectAlarmList(empId);
	}

	@Override
	public AlarmVO insertAlarm(AlarmVO newAlarm) {
		
		almDAO.insertAlarm(newAlarm);
		
		return almDAO.selectAlarm(newAlarm.getAlmNum());
	}

	@Override
	public int readAlarm(Integer almNum) {
		return almDAO.readAlarm(almNum);
	}

}
