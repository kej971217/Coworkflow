package kr.or.ddit.approval.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.ApprovalDocumentVO;
import kr.or.ddit.approval.vo.DraftFormVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

/**
 * 기안 목록 
 * 기안목록은 전체목록을 기본으로 시간순으로 가져오고, 
 * 왼쪽 nav 바의 조건에 따라 기안함, 수신함, 참조함과 관련된 조건 sqld에 포함되어 list 출력
 * @author 82105
 *
 */
@Slf4j
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Inject
	private ApprovalService service;
	
	/**
	 * 결재 리스트 UI
	 * @param model
	 * @return
	 */
	@GetMapping("/approvalSetting.do")
	public String getApprovalSettingUI(Model model) {
		model.addAttribute("level1Menu", "approval");
		return "approval/approvalSetting";
	}
	
	/**
	 * 결재 리스트 UI
	 * @param model
	 * @return
	 */
	@GetMapping("/approvalList.do")
	public String getApprovalListUI(Model model) {
		model.addAttribute("level1Menu", "approval");
		return "approval/approvalList";
	}
	

	
	/**
	 * 상신함List
	 * @param currentPage
	 * @param simpleCondition
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/approvalListJson",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> reciveListGetJson(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Authentication  authentication
		) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		service.retrieveApprovalList(pagination);
		return pagination;

}
	
	
	/**
	 * 결재 수신함 List
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/approvalReciveList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> approvalReciveList(
		@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
		, SimpleCondition simpleCondition, Model model, Authentication  authentication
	) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveApprovalReceiveList(pagination);
		return pagination;
	}
	
	/**
	 * 임시저장
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tempApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> tempAprvListGetJson(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveTempApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 미결함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/unsetApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> unsetApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveUnsetApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 예결함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/preApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> preApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrievePreApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 대결함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/deputyApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> deputyApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveDeputyApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 참조함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/rfrrApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> rfrrApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveRfrrApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 기결함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/atrzApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> atrzApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveAtrzApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 반려함
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/rejectApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> rejectApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveRejectApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 진행중인 문서 
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/runApprovalList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> runApprovalList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveRunApprovalList(pagination);
		return pagination;
	}
	
	/**
	 * 
	 *  승인 종결된 문서
	 * @param currentPage
	 * @param simpleCondition
	 * @param model
	 * @param authentication
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/retrieveAprvAtrzEndList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Pagination<ApprovalDocumentVO> retrieveAprvAtrzEndList(
			@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
			, SimpleCondition simpleCondition, Model model, Authentication  authentication
			) {
		Pagination<ApprovalDocumentVO> pagination = new Pagination<ApprovalDocumentVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		pagination.setEmpId(authentication.getName());
		model.addAttribute("level1Menu", "approval");
		service.retrieveAprvAtrzEndList(pagination);
		return pagination;
	}
	/**
	 * 기안 작성을 위해 양식을 선택하기 위한, 양식 선택 화면
	 * 
	 * @return
	 */
//	@GetMapping("/draftFormList.do")
//	public String draftFormList(Model model) {
//		List<DraftFormVO> draftVO = service.retrieveDraftFormList();
//		model.addAttribute("level1Menu", "approval");
//		model.addAttribute("draftVO", draftVO);
//		
//		return "approval/draftFormList";
//	}
	
	@ResponseBody
	@RequestMapping(value="/draftFormList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<DraftFormVO> draftFormList( Model model) {
		List<DraftFormVO> draftVO = service.retrieveDraftFormList();
		model.addAttribute("level1Menu", "approval");
		model.addAttribute("draftList", draftVO);
		return draftVO;
	}
	
	
}


