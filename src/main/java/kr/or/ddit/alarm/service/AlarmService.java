package kr.or.ddit.alarm.service;

import java.util.List;

import kr.or.ddit.alarm.vo.AlarmVO;

public interface AlarmService {
	/**
	 * empID 를 이용하며 해당 직원의 새로운 알람내역을 가져오는 메서드
	 * @param empId
	 * @return
	 */
	public List<AlarmVO> selectAlarmList(String empId); 
	
	/**
	 * 새로운 알람을 만드는 메서드
	 * @param newAlarm
	 * @return
	 */
	public AlarmVO insertAlarm(AlarmVO newAlarm);
	
	
	/**
	 * 클릭된 알람의 내용을 읽은 것으로 처리하는 메서드
	 * @param 
	 * @return
	 */
	public int readAlarm(Integer almNum);
}
