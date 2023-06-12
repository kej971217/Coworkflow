package kr.or.ddit.schedule.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.vo.CommVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.schedule.vo.ScheduleVO;


public interface ScheduleService {
	/**
	 * 전체 스케쥴 확인
	 * @return
	 */
	public List<ScheduleVO> scheduleList();
	
	/**
	 * 스케줄 추가
	 * @param schedule
	 * @return
	 */
	public int insertSchedule(ScheduleVO schedule);
	
	/**
	 * 스케쥴 하나 상세보기
	 * @param schdlId
	 * @return
	 */
	public ScheduleVO selectSchedule(int schdlId);
	
	/**
	 * 스케쥴 수정
	 * @param schedule
	 * @return
	 */
	public int updateSchedule(ScheduleVO schedule);
	
	/**
	 * 스케쥴 삭제
	 * @param schedlId
	 * @return
	 */
	public int deleteSchedule(int schedlId);
	
	/**
	 * 스케쥴 참석자 팀원 리스트
	 * @return
	 */
	public List<EmployeeDPMTVO> empList(String teamName);
	public List<EmployeeDPMTVO> departList();
	
	/**
	 * 내 미래 스케줄 리스트 조회
	 * @param empId
	 * @return
	 */
	public List<ScheduleVO> selectMyScheduleList(String empId);
	
	/**
	 * 스케줄 참석자 불러오기
	 * @param schdlId
	 * @return
	 */
	public ScheduleVO selectAttendees(int schdlId);

}
