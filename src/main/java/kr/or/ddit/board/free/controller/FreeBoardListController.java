package kr.or.ddit.board.free.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.free.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.vo.Pagination;
import kr.or.ddit.vo.SimpleCondition;

@Controller
@RequestMapping("/board/free/freeBoardList.do")
public class FreeBoardListController {
	
	@Inject
	private BoardService service;
	
	@RequestMapping
	public String getUI(Model model) {
		model.addAttribute("level1Menu", "board");
		model.addAttribute("level2Menu", "freeboard");
		return "board/free/freeBoardList";
	}
	
	@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Pagination<BoardVO> getJson(
		@RequestParam(value="page", required = false, defaultValue = "1") int currentPage
		, SimpleCondition simpleCondition
	) {
		Pagination<BoardVO> pagination = new Pagination<BoardVO>();
		pagination.setCurrentPage(currentPage);
		pagination.setSimpleCondition(simpleCondition);
		service.retrieveBoardList(pagination);
		return pagination;
	}
}
