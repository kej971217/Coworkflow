package kr.or.ddit.schedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.commons.vo.CommVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.schedule.vo.SchdlMemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/**
	 * 전체 스케쥴 확인
	 * @return 
	 */
	public List<ScheduleVO> scheduleList();
	
	/**
	 * 스케쥴 하나 상세보기
	 * @param schdlId
	 * @return
	 */
	public ScheduleVO selectSchedule(int schdlId);
	
	/**
	 * 스케줄 추가
	 * @param schedule
	 * @return
	 */
	public int insertSchedule(ScheduleVO schedule);
	public int insertScheduleMember(SchdlMemberVO scheduleMember);
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
	public int deleteScheduleMember(int schdlId);
	
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
