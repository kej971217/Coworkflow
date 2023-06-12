package kr.or.ddit.employee.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employee.dao.OrganizationInfoDAO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;

@Service
public class OrganizationInfoServiceImpl implements OrganizationInfoService{
	
	@Inject
	private OrganizationInfoDAO OrganizationInfoDAO;

	@Override
	public List<OrganizationInfoVO> retrieveOrgInfoDepList() {
		return OrganizationInfoDAO.selectOrgInfoDepList();
	}

	@Override
	public OrganizationInfoVO retrieveEmpInfo(OrganizationInfoVO orgInfo) {
		return OrganizationInfoDAO.selectEmpInfo(orgInfo);
	}

	@Override
	public List<OrganizationInfoVO> retrieveRankCount() {
		return OrganizationInfoDAO.selectRankCount();
	}

	@Override
	public List<OrganizationInfoVO> retrieveDepEmpCount() {
		return OrganizationInfoDAO.selectDepEmpCount();
	}

	@Override
	public List<OrganizationInfoVO> retrieveDepGendRatio() {
		return OrganizationInfoDAO.selectDepGendRatio();
	}

	@Override
	public List<OrganizationInfoVO> retrieveDepAgeGroupCnt() {
		return OrganizationInfoDAO.selectDepAgeGroupCnt();
	}

}
