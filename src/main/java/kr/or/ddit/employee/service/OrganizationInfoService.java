package kr.or.ddit.employee.service;

import java.util.List;

import kr.or.ddit.employee.vo.OrganizationInfoVO;

public interface OrganizationInfoService {
	
	/**
	 * 조직 정보 조회
	 * @return
	 */
	public List<OrganizationInfoVO> retrieveOrgInfoDepList();
	
	/**
	 * 내 근무조건 조회
	 * @param orgInfo
	 * @return
	 */
	public OrganizationInfoVO retrieveEmpInfo(OrganizationInfoVO orgInfo);
	
	public List<OrganizationInfoVO> retrieveRankCount();
	
	public List<OrganizationInfoVO> retrieveDepEmpCount();
	
	public List<OrganizationInfoVO> retrieveDepGendRatio();
	
	public List<OrganizationInfoVO> retrieveDepAgeGroupCnt();
	
}
