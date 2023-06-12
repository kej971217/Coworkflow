package kr.or.ddit.alarm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.alarm.vo.AlarmVO;

@Mapper
public interface AlarmDAO {
	/**
	 * empID 를 이용하며 해당 직원의 새로운 알람내역을 가져오는 메서드
	 * @param empId
	 * @return 직원이 가지고 있으면서 확인하지 않은 알람 VO list
	 */
	public List<AlarmVO> selectAlarmList(String empId); 

	
	/**
	 * almNum을 이용하여 해당 알람의 정보를 가져오는 메서드
	 * @param almNum
	 * @return AlarmVO
	 */
	public AlarmVO selectAlarm(Integer almNum);

	
	
	/**
	 * 새로운 알람을 만드는 메서드
	 * @param newAlarm
	 * @return
	 */
	public int insertAlarm(AlarmVO newAlarm);
	
	
	/**
	 * 클릭된 알람의 내용을 읽은 것으로 처리하는 메서드
	 * @param 
	 * @return
	 */
	public int readAlarm(Integer almNum);
	
	
	
	
//	public 
	
	
	
}
