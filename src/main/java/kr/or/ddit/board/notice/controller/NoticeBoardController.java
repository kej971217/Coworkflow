package kr.or.ddit.board.notice.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.board.BoardInvalidPasswordException;
import kr.or.ddit.board.notice.service.NoticeBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board/notice")
@Slf4j
public class NoticeBoardController {
	
	@Inject
	private NoticeBoardService service;

	//	공지 글 목록
	@GetMapping("/noticeBoardList.do")
	public String getUI(Model model, SimpleCondition simpleCondition ) {
		Pagination<PostVO> pagination = new Pagination<PostVO>();
		pagination.setCurrentPage(1);
		pagination.setSimpleCondition(simpleCondition);
		BoardVO board = service.retrieveNoticeBoardList(pagination);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","noticeBoard");
		model.addAttribute("noticeBoard", board);
		return "board/notice/noticeBoardList";
	}
	
	

	//	공지 글 검색
	@GetMapping(value = "/noticeBoardSearch.do",produces = "application/json;charset=utf-8")
//	@GetMapping(value = "/noticeBoardSearch.do/{schWord}",produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<PostVO> boardSearch(@RequestParam String schWord) {
//	public List<PostVO> boardSearch(@PathVariable String schWord) {
		 return service.searchNoticeBoard(schWord);		
	}

	
	
	//	공지 글 상세 조회
	@GetMapping("/noticeBoardView.do")
	public String boardView(@RequestParam("what") int postId, Model model) {
		PostVO board = service.retrieveNoticeBoard(postId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","noticeBoard");
		model.addAttribute("noticeBoard", board);
		return "board/notice/noticeBoardView";
	}
	
	// 공지 글 상세 조회
	@ResponseBody
	@GetMapping("/noticeBoardViewJSon")
	public PostVO boardViewJson(@RequestParam("what") int postId, Model model) {
		PostVO board = service.retrieveNoticeBoard(postId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","noticeBoard");
		return board;
	}
	
	
	
	// 미리보기
	@RequestMapping(value = "/noticeBoardPreView.do", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	public String boardPreView(PostVO post, Model model) {
		post.setEmpId("a100005");
		LocalDateTime currentDateTime = LocalDateTime.now(); // 현재 날짜와 시간을 가져옵니다.
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); // 원하는 형식으로 포맷터를 생성합니다.
		String dateTimeString = currentDateTime.format(formatter); // 날짜와 시간을 원하는 형식으로 포맷팅합니다.
		post.setPostDate(dateTimeString);

		model.addAttribute("noticeBoard", post);
		return "jsonView";
	}

	
	
	//	공지 글 등록(UI)
	@GetMapping("/noticeBoardInsert.do")
	public String getInsertUI(Model model)
	{
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","noticeBoard");
		return "board/notice/noticeBoardForm";
	}
	
	// 공지 글 등록(POST)
	@PostMapping("/noticeBoardInsert.do")
	@ResponseBody  // AJAX 쓰는 건 요게 필요!(항상 데이터만 주고받는 걸로)
	public String postInsert(PostVO post ) {
//		log.info("체킁: " + post);
		return Integer.toString(service.createNoticeBoard(post));
	}
	
	
	
	//	공지 글 수정(UI)
	@GetMapping("/noticeBoardUpdate.do")
	public String updateForm(@RequestParam("what") int postId, Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","noticeBoard");
		model.addAttribute("noticeVO",service.retrieveNoticeBoard(postId));
		return "board/notice/noticeBoardEdit";
	}
	
	// 공지 글 수정(POST)
	@PostMapping(value = "/{postId}", produces = "application/json;charset=utf-8")
	public String updatePost(@PathVariable(name = "postId") int postId, @RequestBody PostVO post, Model model) {
		post.setPostId(postId);
		int res = service.modifyNoticeBoard(post);
		if (res > 0) {
			model.addAttribute("result", true);
			model.addAttribute("message", "수정이 완료 되었습니다.");
		} else {
			model.addAttribute("message", "서버 오류로 인해 수정 실패, 잠시 뒤 다시 시도해주세요.");
			model.addAttribute("result", false);
		}
		return "jsonView";
	}

	
	
	//	공지 글 삭제
	@DeleteMapping(value = "/{postId}", produces = "application/json;charset=utf-8")
	public String deleteBoard(@PathVariable(name = "postId") int postId,  Model model) {
		try {
			service.removeNoticeBoard(postId);
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
