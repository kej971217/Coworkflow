package kr.or.ddit.board.club.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.board.club.service.ClubBoardSerivce;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/board/club")
public class ClubBoardController {
	
	@Inject
	private ClubBoardSerivce service;
	
	@GetMapping("/clubBoardList.do")
	public String getUI(Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","clubBoard");
		return "board/club/clubBoardList";
	}
	
}
