package kr.or.ddit.employeeInfo.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employeeInfo.vo.EmployeeInfoVO;

@Mapper
public interface EmployeeInfoDAO {
	
	/**
	 * emp id 로 개인정보를 모두 조회하는 메서드
	 * @param empId
	 * @return 개인정보들을 가지고있는 empInfoVO
	 */
	public EmployeeInfoVO selectEmpInfo(String empId);
	
}
