package kr.or.ddit.approval.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.AuthorizationReferrerVO;
import kr.or.ddit.approval.vo.AuthorizationReplyVO;
import kr.or.ddit.approval.vo.DraftFormVO;
import kr.or.ddit.approval.vo.IsapprovalVO;
import kr.or.ddit.employee.vo.DepartmentVO;
import kr.or.ddit.employee.vo.OrganizationInfoVO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.vo.EmployeeDPMTVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
public class DraftController {

	@Inject
	private ApprovalService service;

	@Inject
	private MypageService mypageService;

	/**
	 * 댓글 모델
	 * 
	 * @param authentication
	 * @return
	 */
	@ModelAttribute("aprvReply")
	public AuthorizationReplyVO aprvReply(Authentication authentication) {
		AuthorizationReplyVO aprvReply = new AuthorizationReplyVO();
		return aprvReply;
	}

//	/**
//	 * 기안 작성을 위해 양식을 선택하기 위한, 양식 선택 화면
//	 * 
//	 * @return
//	 */
//	@GetMapping("/draftFormList.do")
//	public String draftFormList(Model model) {
//		List<DraftFormVO> draftVO = service.retrieveDraftFormList();
//		model.addAttribute("level1Menu", "approval");
//		model.addAttribute("draftVO", draftVO);
//		
//		return "approval/draftFormList";
//	}

	/**
	 * 결재 상세보기
	 * 
	 * @return
	 */
	@GetMapping("/draftView.do")
	public String draftView(@RequestParam("what") String aprvDocId, Model model, Authentication authentication) {

		List<DepartmentVO> dpmtName = mypageService.retrieveUpperDPMT();
		List<DepartmentVO> teamInfo = mypageService.retrieveTeamInfo();
		List<OrganizationInfoVO> teamEmpList = mypageService.retrieveTeamEmpList();

		model.addAttribute("teamEmpList", teamEmpList);
		model.addAttribute("dpmtName", dpmtName);
		model.addAttribute("teamInfo", teamInfo);

		ApprovalDocumentVO approval = service.retrieveApproval(aprvDocId);
		EmployeeDPMTVO empDpmt = service.retrieveDraftEmpInfo(authentication.getName());
		List<IsapprovalVO> atrzLineList = service.retrieveAtrzLineList(aprvDocId);
		approval.setAtrzLineList(atrzLineList);

		// 현재 사용자가 작성자와 동일한 경우 권한을 부여
		boolean canEdit = approval.getEmpId().equals(authentication.getName());
		
		model.addAttribute("myId", authentication.getName());
		model.addAttribute("canEdit", canEdit);
		model.addAttribute("approval", approval);
		model.addAttribute("empDpmt", empDpmt);

		String viewName = null;
		if (!approval.getAprvDocId().contains("temp")) {
			viewName = "draft/draftView";

		} else {

			viewName = "draft/tempForm";
		}
		return viewName;
	}

	/**
	 * 결재문서 삭제
	 * 
	 * @return
	 */
	@PostMapping("/draftDelete.do")
	public String draftDelete(@Validated(DeleteGroup.class) ApprovalDocumentVO aprv, Errors errors, Model model) {
		String viewName = null;
		if (!errors.hasErrors()) {
			service.removeDraft(aprv.getAprvDocId());
			model.addAttribute("level1Menu", "approval");
			viewName = "redirect:/approval/approvalList.do";
		} else {
			viewName = "redirect:/approval/draftView.do?what=" + aprv.getAprvDocId();
		}
		return viewName;
	}

	/**
	 * 댓글등록
	 * 
	 * @return
	 */
	@PostMapping("/aprvReplyInsert.do")
	public String aprvReplyInsert(
			@Validated(InsertGroup.class) @ModelAttribute("aprvReply") AuthorizationReplyVO aprvReply, Errors errors,
			Authentication authentication) {
		String viewName = null;
		if (!errors.hasErrors()) {
			aprvReply.setEmpId(authentication.getName());
			service.createAprvReply(aprvReply);
			viewName = "redirect:/approval/draftView.do?what=" + aprvReply.getAprvDocId();
		} else {
			viewName = "redirect:/approval/draftView.do?what=" + aprvReply.getAprvDocId();
		}
		return viewName;
	}

	/**
	 * 댓글삭제
	 * 
	 * @return
	 */
	@PostMapping("/aprvReplyDelete.do")
	public String aprvReplyDelete(@Validated(DeleteGroup.class) AuthorizationReplyVO replyVO, Errors errors,
			Authentication authentication, Model model) {
//		   log.info("controller atrzReplyId = {}", atrzReplyId);
		service.removeAprvReply(replyVO.getAtrzReplyId());
		model.addAttribute("level1Menu", "approval");
		log.info("aprvDocId={}", replyVO);
		return "redirect:/approval/draftView.do?what=" + replyVO.getAprvDocId();
	}

	/**
	 * 결재직원선택
	 * 
	 * @return
	 */
//	@GetMapping("/atrzSelectForm.do")
//	public String atrzSelectForm(Model model) {
//
//		List<DepartmentVO> dpmtName = mypageService.retrieveUpperDPMT();
//		List<DepartmentVO> teamInfo = mypageService.retrieveTeamInfo();
//		List<OrganizationInfoVO> teamEmpList = mypageService.retrieveTeamEmpList();
//
//		model.addAttribute("teamEmpList", teamEmpList);
//		model.addAttribute("dpmtName", dpmtName);
//		model.addAttribute("teamInfo", teamInfo);
//		return "draft/atrzEmpSelectForm";
//	}

	/**
	 * 결재직원선택폼
	 * 
	 * @return
	 */
	@GetMapping("/atrzForm.do")
	public String atrzForm() {

		return "draft/atrzForm";
	}

	@ModelAttribute("approval")
	public ApprovalDocumentVO approval() {
		List<IsapprovalVO> atrzLineList = null;
		List<AuthorizationReferrerVO> atrzRfrrList = null;
		List<ApprovalDocumentVO> aprvDocList = null;

		ApprovalDocumentVO approval = new ApprovalDocumentVO();

		approval.setAtrzLineList(atrzLineList);
		approval.setAtrzRfrrList(atrzRfrrList);
		approval.setAprvDocList(aprvDocList);

		return approval;
	}

	@ModelAttribute("empDpmt")
	public EmployeeDPMTVO empDpmt(Authentication authentication) {
		return service.retrieveDraftEmpInfo(authentication.getName());
	}

	@GetMapping("/draft.do")
	public String draft(@RequestParam("what") int atrzFormId, Model model, Authentication authentication) {
		log.info("여긴 겟");
		List<DepartmentVO> dpmtName = mypageService.retrieveUpperDPMT();
		List<DepartmentVO> teamInfo = mypageService.retrieveTeamInfo();
		List<OrganizationInfoVO> teamEmpList = mypageService.retrieveTeamEmpList();

		model.addAttribute("teamEmpList", teamEmpList);
		model.addAttribute("dpmtName", dpmtName);
		model.addAttribute("teamInfo", teamInfo);

		DraftFormVO draftForm = service.retrieveDraftForm(atrzFormId);
		EmployeeDPMTVO empDpmt = service.retrieveDraftEmpInfo(authentication.getName());
		ApprovalDocumentVO aprvDoc = new ApprovalDocumentVO();
		aprvDoc.setEmpId(authentication.getName());
		List<ApprovalDocumentVO> rfrrDocList = service.retrieveAprvList(aprvDoc);

		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String nowDate = now.format(formatter);

		model.addAttribute("rfrrDocList", rfrrDocList);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("atrzFormId", atrzFormId);
		model.addAttribute("level1Menu", "approval");
		model.addAttribute("draftForm", draftForm);
		model.addAttribute("empDpmt", empDpmt);
		return "draft/defaultForm";
	}

	/**
	 * 결재문서 상신 action값으로 임시저장, 상신 구분
	 * 
	 * @return
	 */
	@PostMapping("/draftInsert.do")
	@ResponseBody
	public String draftInsert(Model model, Authentication authentication,
			@RequestPart("approval") ApprovalDocumentVO approval, Errors errors,
			@RequestPart("ejFile") MultipartFile[] ejFile) {

		log.info("approval 확인 ={}", approval);
		log.info("ejFile 확인 ={}", ejFile[0]);
		approval.setAtrzFiles(ejFile);

		model.addAttribute("level1Menu", "approval");
//		String viewName = null;
		log.info("approval Info = {}", approval);
		approval.setEmpId(authentication.getName());
//		if (action.equals("temp")) {
//			if (!errors.hasErrors()) {
//				service.createDraftTemp(approval);
//				approval.getAtrzRfrrList();
//				viewName = String.format("{redirect:%s}", "/approval/draftView.do?what=" + approval.getAprvDocId()) ;
//			} else {
//				viewName = String.format("{redirect:%s}", "/draft/defaultForm");
//			}
//		} else {
//			if (!errors.hasErrors()) {
		service.createDraft(approval);
//				viewName = String.format("{redirect:%s}", "/approval/approvalList.do");
//			} else {
//				viewName = String.format("{redirect:%s}", "/draft/defaultForm");
//			}
//		}

		return "success";
	}

	@GetMapping("/draftEdit.do")
	public String draftEdit(@RequestParam("what") String aprvDocId, Model model, Authentication authentication) {
		List<DepartmentVO> dpmtName = mypageService.retrieveUpperDPMT();
		List<DepartmentVO> teamInfo = mypageService.retrieveTeamInfo();
		List<OrganizationInfoVO> teamEmpList = mypageService.retrieveTeamEmpList();

		model.addAttribute("teamEmpList", teamEmpList);
		model.addAttribute("dpmtName", dpmtName);
		model.addAttribute("teamInfo", teamInfo);

		log.info("controller={}", aprvDocId);
		ApprovalDocumentVO approval = service.retrieveApproval(aprvDocId);
		DraftFormVO draftForm = service.retrieveDraftForm(approval.getAtrzFormId());
		EmployeeDPMTVO empDpmt = service.retrieveDraftEmpInfo(authentication.getName());
		List<IsapprovalVO> atrzLineList = service.retrieveAtrzLineList(aprvDocId);
		approval.setAtrzLineList(atrzLineList);

		model.addAttribute("draftForm", draftForm);
		model.addAttribute("approval", approval);
		model.addAttribute("empDpmt", empDpmt);

		return "draft/editForm";
	}

	@PostMapping("/draftUpdate.do")
	@ResponseBody
	public String draftUpdate(@RequestBody ApprovalDocumentVO approval, Errors errors, Model model,
			Authentication authentication) {

		model.addAttribute("level1Menu", "approval");
		String viewName = null;

		if (!errors.hasErrors()) {
			service.modifyDraft(approval);
			viewName = String.format("{redirect:%s}", "/approval/approvalList.do");
		} else {
			viewName = String.format("{redirect:%s}", "/draft/editForm");
		}
		return viewName;
	}

	/**
	 * 참조문서 선택 폼
	 * 
	 * @return
	 */
	@GetMapping("/rfrcDocSelectForm.do")
	public String rfrcDocSelectForm(Authentication authentication, Model model) {
		ApprovalDocumentVO aprvDoc = new ApprovalDocumentVO();
		aprvDoc.setEmpId(authentication.getName());
		List<ApprovalDocumentVO> returnDoc = service.retrieveAprvList(aprvDoc);
		model.addAttribute("rfrrDocList", returnDoc);
		return "draft/rfrcDocSelectForm";
	}

	@PostMapping("/draftSign.do")
	public void draftSign() {

	}

}
