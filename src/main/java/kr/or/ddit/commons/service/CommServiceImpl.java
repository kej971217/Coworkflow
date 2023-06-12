package kr.or.ddit.commons.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.dao.CommDAO;
import kr.or.ddit.commons.vo.CommVO;

@Service
public class CommServiceImpl implements CommService {
	
	@Inject
	private CommDAO commDAO;
	

	/**
	 * 프로파일 구분
	 */
	@Override
	public List<CommVO> retrieveF() {
		return commDAO.selectF();
	}

	/**
	 * 직급
	 */
	@Override
	public List<CommVO> retrieveG() {
		return commDAO.selectG();
	}

	/**
	 * 직책
	 */
	@Override
	public List<CommVO> retrieveH() {
		return commDAO.selectH();
	}

	/**
	 * 직무
	 */
	@Override
	public List<CommVO> retrieveI() {
		return commDAO.selectI();
	}

	/**
	 * 자원분류
	 */
	@Override
	public List<CommVO> retrieveD() {
		return commDAO.selectD();
	}

	/**
	 * 알림시점
	 */
	@Override
	public List<CommVO> retrieveA() {
		return commDAO.selectA();
	}

	/**
	 * 이동시간
	 */
	@Override
	public List<CommVO> retrieveB() {
		return commDAO.selectB();
	}

	/**
	 * 스케줄분류
	 */
	@Override
	public List<CommVO> retrieveS() {
		return commDAO.selectS();
	}

	/**
	 * 공개여부
	 */
	@Override
	public List<CommVO> retrieveK() {
		return commDAO.selectK();
	}

	/**
	 * 게시판분류
	 */
	@Override
	public List<CommVO> retrieveC() {
		return commDAO.selectC();
	}

	/**
	 * 메일분류
	 */
	@Override
	public List<CommVO> retrieveM() {
		return commDAO.selectM();
	}

	/**
	 * 근무형태
	 */
	@Override
	public List<CommVO> retrieveE() {
		return commDAO.selectE();
	}

	/**
	 * 휴가분류
	 */
	@Override
	public List<CommVO> retrieveJ() {
		return commDAO.selectJ();
	}


}
