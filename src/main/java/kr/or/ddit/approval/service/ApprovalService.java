package kr.or.ddit.approval.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.AuthorizationReferrerVO;
import kr.or.ddit.approval.vo.AuthorizationReplyVO;
import kr.or.ddit.approval.vo.DraftFormVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.vo.Pagination;

public interface ApprovalService {
	
	/**
	 * 임시저장된 결재문서의 리스트를 출력하는 리스트 일단 기안함 
	 * @param pagination
	 */
	public void retrieveTempApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 기안함 
	 * @param pagination
	 */
	public void retrieveApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	public List<ApprovalDocumentVO> retrieveAprvList(ApprovalDocumentVO aprvDoc);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 수신함
	 * @param pagination
	 */
	public void retrieveApprovalReceiveList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 참조함
	 * @param pagination
	 */
	public void retrieveRfrrApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 미결함
	 * @param pagination
	 */
	public void retrieveUnsetApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 예결함
	 * @param pagination
	 */
	public void retrievePreApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 일단 대결함
	 * @param pagination
	 */
	public void retrieveDeputyApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 기결함
	 * @param pagination
	 */
	public void retrieveAtrzApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트; 결재 진행중인 문서
	 * @param pagination
	 * @return
	 */
	public void retrieveRunApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트; 승인 종결된 문서
	 * @param pagination
	 * @return
	 */
	public void retrieveAprvAtrzEndList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 결재문서의 리스트를 출력하는 리스트 반려함
	 * @param pagination
	 */
	public void retrieveRejectApprovalList(Pagination<ApprovalDocumentVO> pagination);
	
	/**
	 * 리스트에서 선택 된 결재 문서를 팝업으로 띄워 출력해줄때 사용되는 서비스로, 
	 * 결재문서 내용을 불러온다.
	 * @param aprvDocId
	 * @return
	 */
	public ApprovalDocumentVO retrieveApproval(String aprvDocId);
	
	public List<IsapprovalVO> retrieveAtrzLineList(String aprvDocId);
	
	//-------------------------------------------------------------------------
	// ■ draft List (draftFormVO 사용)
	/**
	 * 기안 작성 전 양식 선택할 수 있도록 리스트를 출력 
	 * @param pagination
	 */
	public List<String> retrieveDraftFormDPMTList();
	
	public List<DraftFormVO> retrieveDraftFormList();
	
	public DraftFormVO retrieveDraftForm(int atrzFormId);
	
	public EmployeeDPMTVO retrieveDraftEmpInfo(String empId);
	
	public void createDraft(ApprovalDocumentVO approval);
	
	public void createDraftTemp(ApprovalDocumentVO approval);
	
	public void modifyDraft(ApprovalDocumentVO approval);
	
	public AttatchFileVO download(AttatchFileVO condition);
	
	public void removeDraft(String approval);
	
	public void createAprvReply(AuthorizationReplyVO aprvReply);
	
	public void removeAprvReply(int atrzReplyId);
	
	public void modifyAprvReply(AuthorizationReplyVO aprvReply);
	
	// 결재자 지정
	public int createIsapprovalEmp(IsapprovalVO isapproval);
	

	public int createRfrrEmp(AuthorizationReferrerVO rfrr);
	
	public int createSignup(IsapprovalVO isapproval);
	
	public int selectIsapproval(IsapprovalVO isapproval);
	
	public int nextTurnCheck(IsapprovalVO isapproval);
	
	public int createDeputySignup(IsapprovalVO isapproval);
	
	public int deleteCheck(ApprovalDocumentVO approval);
}
