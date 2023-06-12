package kr.or.ddit.employeeInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employeeInfo.dao.CommuteDAO;
import kr.or.ddit.employeeInfo.vo.CommuteVO;
import kr.or.ddit.vo.TabulatorPagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommuteServiceImpl implements CommuteService {
	
	@Inject
	private CommuteDAO commuteDAO;

	/**
	 * 출근 등록
	 */
	@Override
	public int createMyCommute(CommuteVO commute) {
		return commuteDAO.insertMyCommute(commute);
	}

	/**
	 * 퇴근 업데이트
	 */
	@Override
	public int modifyMyCommute(CommuteVO commute) {
		return commuteDAO.updateMyCommute(commute);
	}

	/**
	 * 오늘 내 출퇴근기록 조회
	 */
	@Override
	public CommuteVO retrieveMyCommuteToday(CommuteVO commute) {
		return commuteDAO.selectMyCommuteToday(commute);
	}

	/**
	 * 내 근무 현황 리스트 조회
	 */
	@Override
	public List<CommuteVO> retrieveMyCommuteList(CommuteVO commute) {
		return commuteDAO.selectMyCommuteList(commute);
	}

	/**
	 * 팀 근무 현황 리스트 조회 (Tabulator Pagination 추가)
	 */
	@Override
	public void retrieveTeamCommuteList(TabulatorPagination<CommuteVO> tabulatorPagination) {
		int totalRecord = commuteDAO.selectTotalTeamCommuteRecord(tabulatorPagination);
		tabulatorPagination.setTotalRecord(totalRecord);
		List<CommuteVO> data = commuteDAO.selectTeamCommuteList(tabulatorPagination);
		tabulatorPagination.setData(data);
	}

	@Override
	public int modifyMyCommuteMeeting(CommuteVO commute) {
		return commuteDAO.updateMyCommuteMeeting(commute);
	}

	@Override
	public int modifyMyCommuteOutside(CommuteVO commute) {
		return commuteDAO.updateMyCommuteOutside(commute);
	}

	@Override
	public int modifyMyCommuteBusinessTrip(CommuteVO commute) {
		return commuteDAO.updateMyCommuteBusinessTrip(commute);
	}

	@Override
	public int modifyMyCommuteHome(CommuteVO commute) {
		return commuteDAO.updateMyCommuteHome(commute);
	}

	@Override
	public int modifyMyCommuteOvertime(CommuteVO commute) {
		return commuteDAO.updateMyCommuteOvertime(commute);
	}

	@Override
	public int modifyMyCommuteVacation(CommuteVO commute) {
		return commuteDAO.updateMyCommuteVacation(commute);
	}

	@Override
	public int modifyMyCommuteHalfVacation(CommuteVO commute) {
		return commuteDAO.updateMyCommuteHalfVacation(commute);
	}



}
