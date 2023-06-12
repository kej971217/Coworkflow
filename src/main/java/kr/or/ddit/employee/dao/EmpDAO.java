package kr.or.ddit.employee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.EmployeeVOWrapper;

@Mapper
public interface EmpDAO {
	
//	@Override
//	default UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		EmployeeVO emp = selectEmp(username);
//		return new EmployeeVOWrapper(emp);
//	}
	
	public EmployeeVO selectEmp(String empId);
	
//	public int insertEmp(EmployeeVO emp);
	
	public EmployeeVO selectEmpDetail(String empId);
	
	
	public int updateEmp(EmployeeVO emp);
	
	
	public List<EmployeeVO> allEmpList();

	public List<EmployeeVO> excludedMeEmpList(String empId);

	public List<EmployeeVO> includedNameEmpList(String empName);
	
}
