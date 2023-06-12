package kr.or.ddit.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.mypage.vo.MypageVO;

@Mapper
public interface MypageDAO {
	// 직원 조회
	public MypageVO selectEmployee(String empId);
	
	// 직원 개인정보 수정
	public int updateMypage(MypageVO mypage);
	
	// 직원 AtchID 등록
	public int insertAtchId(MypageVO mypage);
	
	// 비밀번호 수정
	public int updatePass(MypageVO mypage);
	
	// 상위부서 조회
	public List<DepartmentVO> selectUpperDPMT();
	
	// 팀정보 조회
	public List<DepartmentVO> selectTeamInfo();
	
	// 팀의 직원 조회
	public List<OrganizationInfoVO> selectTeamEmpList();

	// 대결자 지정
	public int insertDeputyApprover(DeputyApproverVO deputy);
	
	// 대결자 조회
	public List<DeputyApproverVO> selectDeputyApprover(DeputyApproverVO deputy);
	
	// 대결자 수정
	public int updateDeputyApprover(DeputyApproverVO deputy);
	
}