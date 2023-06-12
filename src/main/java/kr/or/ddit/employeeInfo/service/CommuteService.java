package kr.or.ddit.employeeInfo.service;

import java.util.List;

import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.vo.TabulatorPagination;

public interface CommuteService {
	
	public int createMyCommute(CommuteVO commute);
	public int modifyMyCommute(CommuteVO commute);
	public CommuteVO retrieveMyCommuteToday(CommuteVO commute);
	public List<CommuteVO> retrieveMyCommuteList(CommuteVO commute);
	
	public void retrieveTeamCommuteList(TabulatorPagination<CommuteVO> tabualatorPagination);
	
	public int modifyMyCommuteMeeting(CommuteVO commute);//회의
	public int modifyMyCommuteOutside(CommuteVO commute);//외근
	public int modifyMyCommuteBusinessTrip(CommuteVO commute);//출장
	public int modifyMyCommuteHome(CommuteVO commute);//재택
	public int modifyMyCommuteOvertime(CommuteVO commute);//야근
	public int modifyMyCommuteVacation(CommuteVO commute);//휴가
	public int modifyMyCommuteHalfVacation(CommuteVO commute);//반차
	
	
//	public List<CommuteVO> retrieveMyCommuteList(Pagination<CommuteVO> pagination);
//	public List<CommuteVO> retrieveTotalMyCommuteList(Pagination<CommuteVO> pagination);
//	
//	public List<CommuteVO> retrieveTeamCommuteList(Pagination<CommuteVO> pagination);
//	public List<CommuteVO> retrieveTotalTeamCommuteList(Pagination<CommuteVO> pagination);
//	
//	public List<CommuteVO> retrieveAllCommuteList(Pagination<CommuteVO> pagination);
//	public List<CommuteVO> retrieveTotalAllCommuteList(Pagination<CommuteVO> pagination);
	
}
