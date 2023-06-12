package kr.or.ddit.employee.service;

import java.security.SecureRandom;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.mypage.service.MypageService;

@Service
public class EmpServiceImpl implements EmpService {
	
	@Inject
	private EmpDAO empDAO;
	
	@Inject
	private MypageService mypageService;

	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
//	@Override
//	public int insertEmp(EmployeeVO employeeVO) {
//		return empDAO.;
//	}

	@Override
	public EmployeeVO selectEmp(String empId) {
		return empDAO.selectEmp(empId);
	}

	@Override
	public EmployeeVO selectEmpDetail(String empId) {
		return empDAO.selectEmpDetail(empId);
	}

	@Override
	public EmployeeVO findPassword(String empId) {
	 EmployeeVO emp = empDAO.selectEmpDetail(empId);
	 
	String empHp =emp.getInfoHp();
	// 핸드폰 번호에서 - 제거.
 	empHp.replaceAll("-", "");
 	
 	String newPassword = getRamdomPassword(4);
 	String plain = newPassword;
	// encrypt(암호화)/decrypt vs encode(부호화)/decode
	String encoded = encoder.encode(plain);
//	log.info("encoded password : {}", encoded);
	
	emp.setEmpPass(encoded);
	empDAO.updateEmp(emp);
//	log.info("인증 성공 여부 : {}", encoder.matches(plain, saved));
	
 	emp.setInfoHp(empHp);
 	emp.setEmpPass(newPassword);
	 
	return emp;
	}

	
	 public String getRamdomPassword(int size) {
	        char[] charSet = new char[] {
	                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
//	                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
//	                ,
//	                '!', '@', '#', '$', '%', '^', '&' 
	                };

	        StringBuffer sb = new StringBuffer();
	        SecureRandom sr = new SecureRandom();
	        sr.setSeed(new Date().getTime());

	        int idx = 0;
	        int len = charSet.length;
	        for (int i=0; i<size; i++) {
	            // idx = (int) (len * Math.random());
	            idx = sr.nextInt(len);    // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
	            sb.append(charSet[idx]);
	        }

	        return sb.toString();
	    }

	 
	@Override
	public List<EmployeeVO> excludedMeEmpList(String empId) {
		
		List<EmployeeVO> empList =	empDAO.excludedMeEmpList(empId);
		// 마이페이지 프로필을 뷰에서 불러오기 위해 for문 돌려서 저장해준 뒤 반환
		/*for(EmployeeVO emp : empList) {
			emp.setMypage(mypageService.retrieveMypage(emp.getEmpId()));  
		}*/ 
		return empList;
		
	}

	@Override
	public List<EmployeeVO> includedNameEmpList(String empName) {
		
		List<EmployeeVO> empList =	empDAO.includedNameEmpList(empName);
		return empList;
		
	}

	@Override
	public List<EmployeeVO> allEmpList() {
		List<EmployeeVO> empList =	empDAO.allEmpList();
		return empList;
	}
	
}
