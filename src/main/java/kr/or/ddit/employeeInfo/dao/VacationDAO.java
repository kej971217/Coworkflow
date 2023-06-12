package kr.or.ddit.employeeInfo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employeeInfo.vo.VacationVO;

@Mapper
public interface VacationDAO {
	
	public List<VacationVO> selectMyVacationList(VacationVO vacation);
	public List<VacationVO> selectTeamVacationList(VacationVO vacation);
	public List<VacationVO> selectTodayTeamVacationList(VacationVO vacation);
}
