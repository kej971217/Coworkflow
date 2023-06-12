package kr.or.ddit.employeeInfo.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.vo.TabulatorPagination;

@Mapper
public interface CommuteDAO {
	
	public int insertMyCommute(CommuteVO commute);//출근
	public int updateMyCommute(CommuteVO commute);//퇴근
	public CommuteVO selectMyCommuteToday(CommuteVO commute);
	public List<CommuteVO> selectMyCommuteList(CommuteVO commute);
	
	public List<CommuteVO> selectTeamCommuteList(TabulatorPagination<CommuteVO> tabulatorPagination);
	public int selectTotalTeamCommuteRecord(TabulatorPagination<CommuteVO> tabulatorPagination);
	
	public int updateMyCommuteMeeting(CommuteVO commute);//회의
	public int updateMyCommuteOutside(CommuteVO commute);//외근
	public int updateMyCommuteBusinessTrip(CommuteVO commute);//출장
	public int updateMyCommuteHome(CommuteVO commute);//재택
	public int updateMyCommuteOvertime(CommuteVO commute);//야근
	public int updateMyCommuteVacation(CommuteVO commute);//휴가
	public int updateMyCommuteHalfVacation(CommuteVO commute);//반차
	
//	public List<CommuteVO> selectMyCommuteList(Pagination<CommuteVO> pagination);
//	public int selectTotalMyCommuteList(Pagination<CommuteVO> pagination);
//	
//	public List<CommuteVO> selectTeamCommuteList(Pagination<CommuteVO> pagination);
//	public int selectTotalTeamCommuteList(Pagination<CommuteVO> pagination);
//	
//	public List<CommuteVO> selectAllCommuteList(Pagination<CommuteVO> pagination);
//	public int selectTotalAllCommuteList(Pagination<CommuteVO> pagination);
	
}
