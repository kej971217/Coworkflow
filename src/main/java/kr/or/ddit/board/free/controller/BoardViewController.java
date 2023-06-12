package kr.or.ddit.board.free.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.board.free.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;

@Controller
public class BoardViewController {
	@Inject
	private BoardService service;
	
	@RequestMapping("/board/free/boardView.do")
	public String boardView(@RequestParam("what") int boNo, Model model) {
		BoardVO board = service.retrieveBoard(boNo);
		model.addAttribute("freeboard", board);
		return "board/free/boardView";
	}
}
