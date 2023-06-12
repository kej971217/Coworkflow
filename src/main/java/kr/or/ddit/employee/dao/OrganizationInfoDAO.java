package kr.or.ddit.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.OrganizationInfoVO;

@Mapper
public interface OrganizationInfoDAO {

	/**
	 * 조직 정보 조회
	 * @return
	 */
	public List<OrganizationInfoVO> selectOrgInfoDepList();
	
	
	/**
	 * empId 를 이용하여 한명의 조직원의 정보를 가져오는 메서드
	 * @param empId
	 * @return 1명의 직원의 OrganizationInfoVO
	 */
	public OrganizationInfoVO selectOrgInfo(String empId);
	
	
	public OrganizationInfoVO selectEmpInfo(OrganizationInfoVO organizationInfo);
	
	
	
	public List<OrganizationInfoVO> selectRankCount();
	
	public List<OrganizationInfoVO> selectDepEmpCount();
	
	public List<OrganizationInfoVO> selectDepGendRatio();
	
	public List<OrganizationInfoVO> selectDepAgeGroupCnt();
	
}
