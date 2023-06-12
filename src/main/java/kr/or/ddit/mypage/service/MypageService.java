package kr.or.ddit.mypage.service;

import java.util.List;

import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.mypage.vo.MypageVO;

public interface MypageService {
	// 마이페이지 조회
	public MypageVO retrieveMypage(String empId);
	
	// 개인정보 조회
	public void modifyMypage(MypageVO emp);
	
	// 비밀번호 수정
	public void changePass(MypageVO mypage);
	
	// 프로필 이미지 수정
	public void modifyProfileImg(MypageVO mypage);
	
	public void modifySignImg(MypageVO mypage);
	
	// 직원 atchID 등록
	public int createAtchId(MypageVO mypage);
	
	// 상위 부서 조회
	public List<DepartmentVO> retrieveUpperDPMT();
	
	// 팀 조회
	public List<DepartmentVO> retrieveTeamInfo();
	
	// 팀에 속한 직원 조회
	public List<OrganizationInfoVO> retrieveTeamEmpList();
	
	// 대결자 지정
	public int createDeputyApprover(DeputyApproverVO deputy);
	
	// 대결자 조회
	public List<DeputyApproverVO> retrieveDeputyApprover(DeputyApproverVO deputy);
	
	// 대결자 수정
	public int modifyDeputyApprover(DeputyApproverVO deputy);

}
