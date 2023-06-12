package kr.or.ddit.employeeInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employeeInfo.dao.VacationDAO;
import kr.or.ddit.employeeInfo.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class VacationServiceImpl implements VacationService{
	
	@Inject
	private VacationDAO vacationDAO;
	
	
	
	@Override
	public List<VacationVO> retrieveMyVacationList(VacationVO vacation) {
		return vacationDAO.selectMyVacationList(vacation);
	}

	@Override
	public List<VacationVO> retrieveTeamVacationList(VacationVO vacation) {
		return vacationDAO.selectTeamVacationList(vacation);
	}

	@Override
	public List<VacationVO> retrieveTodayTeamVacationList(VacationVO vacation) {
		return vacationDAO.selectTodayTeamVacationList(vacation);
	}

}
