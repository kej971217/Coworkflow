package kr.or.ddit.approval.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.approval.vo.DeputyApproverVO;
import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.AuthorizationReferrerVO;
import kr.or.ddit.approval.vo.AuthorizationReplyVO;
import kr.or.ddit.approval.vo.DraftFormVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface ApprovalDAO {
	public int selectTotalRecord(Pagination<ApprovalDocumentVO> pagination);
	// 상신함
	public List<ApprovalDocumentVO> selectTempApprovalList(Pagination<ApprovalDocumentVO> pagination);
		
	// 상신함
	public List<ApprovalDocumentVO> selectApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
//	// 상신함2
	public List<ApprovalDocumentVO> selectAprvList(ApprovalDocumentVO aprvDoc);
//	
	// 수신함
	public List<ApprovalDocumentVO> selectApprovalReceiveList(Pagination<ApprovalDocumentVO> pagination);
	
	// 결재 진행중인 문서
	public List<ApprovalDocumentVO> selectRunApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 본인이 상신한 승인 종결 기안
	public List<ApprovalDocumentVO> selectAprvAtrzEndList(Pagination<ApprovalDocumentVO> pagination);
	
	// 참조함
	public List<ApprovalDocumentVO> selectRfrrApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 미결함
	public List<ApprovalDocumentVO> selectUnsetApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 예결함
	public List<ApprovalDocumentVO> selectPreApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 대결함
	public List<ApprovalDocumentVO> selectDeputyApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 기결함
	public List<ApprovalDocumentVO> selectAtrzApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 반려함
	public List<ApprovalDocumentVO> selectRejectApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	// 결재 문서 조회
	public ApprovalDocumentVO selectApproval(String aprvDocId);
	
	// 결재라인 조횔
	public List<IsapprovalVO> selectAtrzLineList(String aprvDocId);
	
	// 결재 양식리스트 조회
	public List<String> selectDraftFormDPMTList();
	public List<DraftFormVO> selectDraftFormList();
	public DraftFormVO selectDraftForm(int atrzFormId);
	
	// 직원 정보 조회;
	public EmployeeDPMTVO selectDraftEmpInfo(String empId);
	
	// 결재 등록
	public int insertDraft(ApprovalDocumentVO approval);
	
	// 임시문서 등록
	public int insertDraftTemp(ApprovalDocumentVO approval);
	
	// 결재 수정
	public int updateDraft(ApprovalDocumentVO approval);
	
	// 결재 취소
	public int deleteDraft(String aprvDocId);
	
	// aprv doc id check
	public List<Integer> aprvEmpCheck(String aprvDocId);
	public List<Integer> aprvRfrrCheck(String aprvDocId);
	public List<Integer> replyCheck(String aprvDocId);
	
	// 결재자
	public List<IsapprovalVO> aprvEmpList(String aprvDocId);
	
	// 참조자
	public List<AuthorizationReferrerVO> rfrrEmpList(String aprvDocId);
	
	// 참조문서
	public List<ApprovalDocumentVO> rfrcDocList(String aprvDocId); 
	
	// 댓글리스트 조회
	public List<AuthorizationReplyVO> selectReplyList(String aprvDocId); 
	
	// 댓글 등록
	public int insertReply(AuthorizationReplyVO aprvReply);
	
	// 댓글 삭제
	public int deleteReply(int atrzReplyId);
	
	// 댓글 수정
	public int updateReply(AuthorizationReplyVO aprvReply);
	
	// 결재자 지정
	public int insertIsapprovalEmp(IsapprovalVO isapproval);

    // 결재
	public int updateIsapprovalEmp(IsapprovalVO isapproval);
	
	public int insertRfrrEmp(AuthorizationReferrerVO rfrr);
	
	public int insertSignup(IsapprovalVO isapproval);
	
	public int insertDeputySignup(IsapprovalVO isapproval);
	
	public int selectIsapproval(IsapprovalVO isapproval);
	
	public IsapprovalVO nextTurnCheck(IsapprovalVO isapproval);
	
	public IsapprovalVO deputyBtnCheck(IsapprovalVO isapproval);
	
	public ApprovalDocumentVO deleteCheck(ApprovalDocumentVO approval);
	
	public String replyEmpProfile(String empId);
}
