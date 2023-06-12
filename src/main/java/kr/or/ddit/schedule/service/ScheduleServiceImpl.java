package kr.or.ddit.schedule.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.vo.CommVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.schedule.dao.ScheduleDAO;
import kr.or.ddit.schedule.vo.SchdlMemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Inject
	private ScheduleDAO scheduleDAO;
	
	/**
	 *스케쥴 리스트 보기
	 */
	@Override
	public List<ScheduleVO> scheduleList() {
		List<ScheduleVO> list = scheduleDAO.scheduleList();
		return list;
	}
	
	
	
	/**
	 *스케쥴 등록
	 */
	@Override
	public int insertSchedule(ScheduleVO schedule) {
		
		int result = scheduleDAO.insertSchedule(schedule);
		for(SchdlMemberVO tmp : schedule.getSchdlMemberList( schedule.getEmpInfoId()  )) {
			tmp.setSchdlId(schedule.getSchdlId());
			result += scheduleDAO.insertScheduleMember(tmp);
		}
		return result;
		
	}
	/**
	 *스케쥴 업데이트
	 */
	@Override
	public int updateSchedule(ScheduleVO schedule) {
		int result = scheduleDAO.updateSchedule(schedule);
		scheduleDAO.deleteScheduleMember(schedule.getSchdlId());
		for(SchdlMemberVO tmp : schedule.getSchdlMemberList( schedule.getEmpInfoId()  )) {
			tmp.setSchdlId(schedule.getSchdlId());
			result += scheduleDAO.insertScheduleMember(tmp);
		}
		return result;
	}
	/**
	 *스케쥴 삭제
	 */
	@Override
	public int deleteSchedule(int schedlId) {
		int result = scheduleDAO.deleteScheduleMember(schedlId);
		result += scheduleDAO.deleteSchedule(schedlId);
		return result;
	}
	/**
	 *스케쥴 하나 상세보기
	 */
	@Override
	public ScheduleVO selectSchedule(int schdlId) {
		return scheduleDAO.selectSchedule(schdlId);
	}
	/**
	 *팀원 리스트
	 */
	@Override
	public List<EmployeeDPMTVO> empList(String teamName) {
	
		return scheduleDAO.empList(teamName);
	}
	/**
	 *팀명 리스트
	 */
	@Override
	public List<EmployeeDPMTVO> departList() {
		
		return scheduleDAO.departList();
	}



	/**
	 * 내 미래 스케줄 3개 불러오기
	 */
	@Override
	public List<ScheduleVO> selectMyScheduleList(String empId) {
		return scheduleDAO.selectMyScheduleList(empId);
	}


	/**
	 * 스케줄 참석자 불러오기
	 */
	@Override
	public ScheduleVO selectAttendees(int schdlId) {
		return scheduleDAO.selectAttendees(schdlId);
	}
	
	
}
