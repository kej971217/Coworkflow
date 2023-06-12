package kr.or.ddit.board.free.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.board.free.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.validate.InsertGroup;

@Controller
@RequestMapping("/board/free/boardInsert.do")
public class BoardInsertController {
	@Inject
	private BoardService service;
	
	@ModelAttribute("freeboard")
	public BoardVO board() {
		return new BoardVO();
	}
	
	@GetMapping
	public String insertForm() {
		return "board/free/boardForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("freeboard") BoardVO board
		, BindingResult errors
	) {
		if(!errors.hasErrors()) {
			service.createBoard(board);
			return "redirect:/board/free/boardList.do";
		}else {
			return "board/free/boardForm";
		}
	}
}












