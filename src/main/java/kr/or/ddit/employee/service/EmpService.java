package kr.or.ddit.employee.service;

import java.util.List;

import kr.or.ddit.employee.vo.EmployeeVO;

public interface EmpService {
	/**
	 * 값을 입력받아 새롭게 직원을 등록하는 메서드
	 * @param employeeVO
	 * @return 성공한 직원의 수.
	 */
//	public int insertEmp(EmployeeVO employeeVO);
	
	
	
	/**
	 * 직원의 아이디로 직원의 정보를 조회하는 메서드
	 * @param empId
	 * @return 해당 직원의 empVO
	 */
	public EmployeeVO selectEmp(String empId);
	
	
	
	/**
	 * 직원 아이디로 직원 상세정보를 조회하는 메서드
	 * @param empId
	 * @return 해당 직원의 Map
	 */
	public EmployeeVO selectEmpDetail(String empId);
	
	
	/**
	 * 직원 아이디를 이용해서 직원의 비밀번호를 찾기위해 정보를 조회하는 메서드
	 * @param empId
	 * @return
	 */
	public EmployeeVO findPassword(String empId);
	
	
	/**
	 * 자신을 포함한 전 직원을 조회하는 메서드
	 * @param 
	 * @return
	 */
	public List<EmployeeVO> allEmpList();

	/**
	 * 자신을 제외한 전 직원을 조회하는 메서드
	 * @param empId
	 * @return
	 */
	public List<EmployeeVO> excludedMeEmpList(String empId);

	
	public List<EmployeeVO> includedNameEmpList(String empName);
}
