package kr.or.ddit.board.inform.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.board.BoardInvalidPasswordException;
import kr.or.ddit.board.inform.service.InformBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/inform")
public class InformBoardController {
	
	@Inject
	private InformBoardService service;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['board.attatchPath']}")
	private File saveFolder;
	
	
// 사내 소식 글 목록
	@GetMapping("/informBoard.do")
	public String getUI(Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","informBoard");
		return "board/inform/chahyun";
	}
	
	@GetMapping(value="/informBoardList.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<PostVO> getUI() {
//		Pagination<PostVO> pagination = new Pagination<PostVO>();
		List<PostVO> board = service.retrieveInformBoardList();
		return board;
	}
	
	
	
	
	//	사내 소식 글 등록(UI)
	@GetMapping("/informBoardInsert.do")
	public String getInsertUI(Model model){
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","informBoard");
		return "board/inform/informBoardForm";
	}
	
	// 사내 소식 글 등록(POST)
	@PostMapping("/informBoardInsert.do")
	@ResponseBody 
	public String postInsert(PostVO post, MultipartHttpServletRequest req) {
		AttatchFileGroupVO atchFileGroup = post.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
		.ifPresent((afg)->{
			log.error("afg {}",afg);
			fileService.createAttatchFileGroup(afg, saveFolder);
			log.error("atchId:" + afg.getAtchId());
			post.setBoAtch(afg.getAtchId());
			
		});
	
		post.setAtchId(atchFileGroup.getAtchId());
		return Integer.toString(service.createInformBoard(post));
	}
	
	

	//	사내 소식 글 검색
	@GetMapping(value = "/informBoardSearch.do",produces = "application/json;charset=utf-8")
//	@GetMapping(value = "/informBoardSearch.do/{schWord}",produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<PostVO> boardSearch(@RequestParam String schWord) {
//	public List<PostVO> boardSearch(@PathVariable String schWord) {
		 return service.searchInformBoard(schWord);		
	}

	
	
	//	사내 소식 글 상세 조회
	@GetMapping("/informBoardView.do")
	public String boardView(@RequestParam("what") int postId, Model model) {
		PostVO post = service.retrieveInformBoard(postId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","informBoard");
		model.addAttribute("informBoard", post);
		return "board/inform/informBoardView";
	}
	
	// 사내 소식 글 상세 조회
	@ResponseBody
	@GetMapping("/informBoardViewJson")
	public PostVO boardViewJson(@RequestParam("what") int postId, Model model) {
		PostVO post = service.retrieveInformBoard(postId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","informBoard");
		return post;
	}
	
	
	
	// 미리보기
	@GetMapping(value = "/informBoardPreView.do",produces = "application/json;charset=utf-8")
	public String boardPreView(PostVO post, Model model) {
		post.setEmpId("a100005");
		LocalDateTime currentDateTime = LocalDateTime.now(); // 현재 날짜와 시간을 가져옵니다.
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); // 원하는 형식으로 포맷터를 생성합니다.
		String dateTimeString = currentDateTime.format(formatter); // 날짜와 시간을 원하는 형식으로 포맷팅합니다.
		post.setPostDate(dateTimeString);

		model.addAttribute("informBoard", post);
		return "jsonView";
	}

	
	
	//	사내 소식 글 수정(UI)
	@GetMapping("/informBoardUpdate.do")
	public String updateForm(@RequestParam("what") int postId, Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","informBoard");
		model.addAttribute("informVO",service.retrieveInformBoard(postId));
		return "board/inform/informBoardEdit";
	}
	
	
	
	// 사내 소식 글 수정(POST)
	@PostMapping(value = "/informBoardUpdate.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int updatePost(@RequestBody PostVO post) {
		
		log.info("qqq {}",post);
		
		int updatePost = service.modifyInformBoard(post);

		return updatePost;
	}

	
	
	//	사내 소식 글 삭제
	@DeleteMapping(value = "/{postId}", produces = "application/json;charset=utf-8")
	public String deleteBoard(@PathVariable(name = "postId") int postId,  Model model) {
		try {
			service.removeInformBoard(postId);
			model.addAttribute("result", true);
			model.addAttribute("message", "삭제가 완료 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "서버 오류로 인해 삭제 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	
}
