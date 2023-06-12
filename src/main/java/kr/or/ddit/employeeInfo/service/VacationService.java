package kr.or.ddit.employeeInfo.service;

import java.util.List;

import kr.or.ddit.employeeInfo.vo.VacationVO;

public interface VacationService {
	
	public List<VacationVO> retrieveMyVacationList(VacationVO vacation);
	public List<VacationVO> retrieveTeamVacationList(VacationVO vacation);
	public List<VacationVO> retrieveTodayTeamVacationList(VacationVO vacation);
}
