package kr.or.ddit.approval.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.approval.dao.ApprovalDAO;
import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.AuthorizationReferrerVO;
import kr.or.ddit.approval.vo.AuthorizationReplyVO;
import kr.or.ddit.approval.vo.DraftFormVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.mypage.dao.MypageDAO;
import kr.or.ddit.mypage.service.EmpAtchFileService;
import kr.or.ddit.mypage.vo.EmpAtchFileVO;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.mypage.vo.MypageVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalServiceImpl implements ApprovalService{
	
	@Inject
	private ApprovalDAO approvalDAO;
	
	@Inject
	private MypageDAO mypageDAO;
	
	@Inject
	private EmpAtchFileService empFileService;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['approval.attatchPath']}")
	private File saveFolder;
	
	@Value("#{appInfo['mypage.attatchPath']}")
	private File mypageSaveFolder;
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 상신함 LIST
	 */
	@Override
	public void retrieveApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectApprovalList(pagination);
		
		pagination.setDataList(dataList);
	}
	
	@Override
	public List<ApprovalDocumentVO> retrieveAprvList(ApprovalDocumentVO aprvDoc) {
		List<ApprovalDocumentVO> dataList = approvalDAO.selectAprvList(aprvDoc);
		return dataList;
		
	}
	
	@Override
	public ApprovalDocumentVO retrieveApproval(String aprvDocId) {
		log.info("service.1={}",aprvDocId);
		ApprovalDocumentVO approval = approvalDAO.selectApproval(aprvDocId);
		
		if(approval==null) throw new NullPointerException("결과가 없습니다.");
		
		List<Integer> existId = approvalDAO.aprvEmpCheck(aprvDocId);
		List<Integer> existRfrr = approvalDAO.aprvRfrrCheck(aprvDocId);
		List<Integer> existReply = approvalDAO.replyCheck(aprvDocId);
		log.info("existReply 값 ={}",existReply);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		IsapprovalVO isapproval = new IsapprovalVO();
		isapproval.setAprvDocId(aprvDocId);
		isapproval.setEmpId(authentication.getName());
		
		int next = nextTurnCheck(isapproval);
		log.info("next 값 ={}",next);
		int delete = deleteCheck(approval);
		
		if(next > 0 ) {
			approval.setNextAprvCheck(0);
			log.info("여기야 ? 1={}",next);
		}else {
			approval.setNextAprvCheck(1);
			log.info("여기야 ? 2={}",next);
			
		}
		if(delete>0) {
			approval.setDeleteCheck(0);
		}else {
			approval.setDeleteCheck(1);
		}
		
		
		if (existId !=null) {
			approval.setAtrzLineList(approvalDAO.aprvEmpList(aprvDocId));
			
		}
		if(existRfrr !=null) {
			approval.setAtrzRfrrList(approvalDAO.rfrrEmpList(aprvDocId));
			}
		
		log.info("existReply.contains(approval.getAprvDocId())={}",existReply.contains(approval.getAprvDocId()));
		if(existReply !=null) {
			log.info("service.2={}",aprvDocId);
			List<AuthorizationReplyVO> reply = approvalDAO.selectReplyList(aprvDocId);
				for(AuthorizationReplyVO emp : reply) {
					String saveName = approvalDAO.replyEmpProfile(emp.getEmpId());
					if(saveName != null) {
						emp.setEmpAtchSaveName(saveName);
					}else {
						emp.setEmpAtchSaveName("profile-12.jpg");
					}
				}
			log.info("reply.2={}",reply);
			approval.setAprvReplyList(reply);
		}
//		if(approval.getAprvDocReference() != null) {
//			approval.setReferenceDoc(approvalDAO.aprv(approval.getAprvDocReference()));
//		}
		if(approval.getAtchId() != null) {
			AttatchFileGroupVO atchFileGroup = fileService.retrieveAttatchFileGroup(approval.getAtchId(), saveFolder);
			approval.setAtchFileGroup(atchFileGroup);
		}
		
		return approval;
		
	}

	@Override
	public List<DraftFormVO> retrieveDraftFormList() {
		List<DraftFormVO> draftFormList = approvalDAO.selectDraftFormList();
		return draftFormList;
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 수신함 LIST
	 */
	@Override
	public void retrieveApprovalReceiveList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectApprovalReceiveList(pagination);
		pagination.setDataList(dataList);
		
	}
	

	@Override
	public DraftFormVO retrieveDraftForm(int atrzFormId) {
		DraftFormVO draftForm = approvalDAO.selectDraftForm(atrzFormId);
		return draftForm;
	}
	@Override
	public EmployeeDPMTVO retrieveDraftEmpInfo(String empId) {
		EmployeeDPMTVO empDptmt = approvalDAO.selectDraftEmpInfo(empId);
		return empDptmt;
	}
	
	/**
	 * 
	 * 결재에 포함된 인원 LIST
	 */
	@Override
	public List<IsapprovalVO> retrieveAtrzLineList(String aprvDocId) {
		List<IsapprovalVO> atrzLineList = approvalDAO.selectAtrzLineList(aprvDocId);
		for(IsapprovalVO atrzLine : atrzLineList) {
			EmpAtchFileVO empAtchFile = new EmpAtchFileVO();
			MypageVO mypage = mypageDAO.selectEmployee(atrzLine.getEmpId());
			if(mypage.getEmpAtchId() != null) {
				empAtchFile.setEmpAtchId(mypage.getEmpAtchId());
				empAtchFile.setEmpAtchClasfct(1);
				atrzLine.setEmpSign(empFileService.retrieveAttatchFile(empAtchFile, mypageSaveFolder));
			
			}
		}
		return atrzLineList;
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 참조 LIST
	 */
	@Override
	public void retrieveRfrrApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectRfrrApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 미결함 LIST
	 */
	@Override
	public void retrieveUnsetApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectUnsetApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 예결함 LIST
	 */
	@Override
	public void retrievePreApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectPreApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 대결함 LIST
	 */
	@Override
	public void retrieveDeputyApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectDeputyApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 기결함 LIST
	 */
	@Override
	public void retrieveAtrzApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectAtrzApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * 결재 진행중인 문서
	 */
	@Override
	public void retrieveRunApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectRunApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	

	/**
	 * 승인 종결된 문서 List
	 */
	@Override
	public void retrieveAprvAtrzEndList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectAprvAtrzEndList(pagination);
		pagination.setDataList(dataList);
		
	}
	
	/**
	 * /approval/approvalList.do >> approvalListJson 
	 * 결재 반려함 LIST
	 */
	@Override
	public void retrieveRejectApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectRejectApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}
	@Override
	public List<String> retrieveDraftFormDPMTList() {
		List<String> formDPMTList = approvalDAO.selectDraftFormDPMTList();
		return formDPMTList;
	}
	
	@Override
	public void createDraft(ApprovalDocumentVO approval) {
		
		if(approval.getAtchFileGroup()!=null) {
			AttatchFileGroupVO atchFileGroup = approval.getAtchFileGroup();
			Optional.ofNullable(atchFileGroup)
					.ifPresent((afg)->{
						fileService.createAttatchFileGroup(afg, saveFolder);
						approval.setAtchId(afg.getAtchId());
					});
			approval.setAtchId(atchFileGroup.getAtchId());
		}
		
		approvalDAO.insertDraft(approval);
		
		
		if(approval.getAtrzLineList()!= null) {
			for(IsapprovalVO isapproval : approval.getAtrzLineList()) {
				isapproval.setAprvDocId(approval.getAprvDocId());
				createIsapprovalEmp(isapproval);
			}
		}
		if(approval.getAtrzRfrrList() != null) {
			for( AuthorizationReferrerVO rfrr : approval.getAtrzRfrrList()) {
				rfrr.setAprvDocId(approval.getAprvDocId());
				createRfrrEmp(rfrr);
			}
			IsapprovalVO isapproval = new IsapprovalVO();
			isapproval.setAprvDocId(approval.getAprvDocId());
			isapproval.setEmpId(approval.getEmpId());
			isapproval.setIsapprovalStatus("1");
			isapproval.setIsapprovalReason("");
			approvalDAO.insertSignup(isapproval);
		}
	}
	
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) 
			throw new RuntimeException(String.format("%d, %d 번 파일이 없음.", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}
	
	
	@Override
	public void removeDraft(String aprvDocId) {
		ApprovalDocumentVO approval = approvalDAO.selectApproval(aprvDocId);
		AttatchFileGroupVO atchFileGroup = approval.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.removeAttatchFileGroup(afg, saveFolder);
					approval.setAtchId(afg.getAtchId());
				});
		approvalDAO.deleteDraft(aprvDocId);
		
	}
	@Override
	public void createDraftTemp(ApprovalDocumentVO approval) {
		AttatchFileGroupVO atchFileGroup = approval.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(afg, saveFolder);
					approval.setAtchId(afg.getAtchId());
				});
		approvalDAO.insertDraftTemp(approval);
		
	}
	@Override
	public void createAprvReply(AuthorizationReplyVO aprvReply) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		aprvReply.setEmpId(authentication.getName());
		approvalDAO.insertReply(aprvReply);
	}
	@Override
	public void modifyAprvReply(AuthorizationReplyVO aprvReply) {
		approvalDAO.updateReply(aprvReply);
		
	}
	@Override
	public void removeAprvReply(int atrzReplyId) {
		approvalDAO.deleteReply(atrzReplyId);
		
	}

	@Override
	public void retrieveTempApprovalList(Pagination<ApprovalDocumentVO> pagination) {
		int totalRecord = approvalDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<ApprovalDocumentVO> dataList = approvalDAO.selectTempApprovalList(pagination);
		pagination.setDataList(dataList);
		
	}

	@Override
	public void modifyDraft(ApprovalDocumentVO approval) {
		ApprovalDocumentVO saved = approvalDAO.selectApproval(approval.getAprvDocId());
		
		// 지우고
		int rowcnt = Optional.ofNullable(approval.getDelFileGroup())
							.map((dfg)->{
								dfg.setAtchId(approval.getAtchId());
								return fileService.removeAttatchFileGroup(dfg, saveFolder);
							}).orElse(0);
		// 업로드
		AttatchFileGroupVO addFileGroup = approval.getAddFileGroup();
		addFileGroup.setAtchId(approval.getAtchId());
		rowcnt += Optional.ofNullable(approval.getAtchId())
							.map((ba)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
							.orElseGet(()->{
								int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
								approval.setAtchId(addFileGroup.getAtchId());
								return cnt;
							});
		rowcnt += approvalDAO.updateDraft(approval);
		
	}

	@Override
	public int createIsapprovalEmp(IsapprovalVO isapproval) {
		int cnt = approvalDAO.insertIsapprovalEmp(isapproval);
		return cnt;
	}


	@Override
	public int createRfrrEmp(AuthorizationReferrerVO rfrr) {
		int cnt = approvalDAO.insertRfrrEmp(rfrr);
		return cnt;
	}

	@Override
	public int createSignup(IsapprovalVO isapproval) {

		return approvalDAO.insertSignup(isapproval);
	}

	@Override
	public int createDeputySignup(IsapprovalVO isapproval) {
		return approvalDAO.insertDeputySignup(isapproval);
	}

	@Override
	public int selectIsapproval(IsapprovalVO isapproval) {
		return approvalDAO.selectIsapproval(isapproval);
	}

	@Override
	public int nextTurnCheck(IsapprovalVO isapproval) {
		log.info("isapproval 에 값이 있는지 ={}",isapproval);
		int cnt = 0;
		if(approvalDAO.nextTurnCheck(isapproval)!=null || approvalDAO.deputyBtnCheck(isapproval)!=null) {
			
			log.info("넥스트 버튼의 반환 값을 확인 ={}",approvalDAO.nextTurnCheck(isapproval));
			log.info("데퓨티 버튼의 반환 값을 확인 ={}",approvalDAO.deputyBtnCheck(isapproval));
			cnt = 1;
		}
			
		return cnt;
	}

	@Override
	public int deleteCheck(ApprovalDocumentVO approval) {
		int cnt = 0;
		if(approvalDAO.deleteCheck(approval)!=null) {
			cnt = 1;
		}
		return cnt;
	}



}
