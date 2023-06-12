package kr.or.ddit.board.project.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.project.service.ProjectBoardService;
import kr.or.ddit.board.project.vo.ProjectVO;
import kr.or.ddit.board.vo.PostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/project")
public class ProjectController {
	
	@Inject
	private ProjectBoardService service;
	
	
	// 프로젝트 목록(UI)
	@GetMapping("/projectBoardList.do")
	public String getBoardListUI(Model model) {
		model.addAttribute("level1Menu", "board");
		model.addAttribute("level2Menu", "projectBoard");
		return "board/project/projectBoardList";
	}
	
	// 프로젝트 목록(DATA)
	@GetMapping(value="/projectBoardListJSON", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<ProjectVO> getUI(Authentication auth) {
		log.info("로그인 한 ID 체킁: {}",auth.getName());
		String empId = auth.getName();
		List<ProjectVO> project = service.retrieveProjectBoardList(empId);
		return project;
	}
	
	
	
	// 프로젝트 등록(UI)
	@GetMapping("/projectBoardInsert.do")
	public String getInsertUI(Model model, Authentication auth) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		model.addAttribute("empId",auth.getName());
		return "board/project/projectBoardForm";
	}
	
	// 프로젝트 등록(DATA)
	@PostMapping("/projectBoardInsert.do")
	@ResponseBody
	public String insertProject(@RequestBody ProjectVO project) {
		int cnt = service.createProjectBoard(project);
		log.info("boardId여기야 ~  = {}", project.getBoardId());
		service.insertBoardId(project.getBoardId());
//		service.insertTeamId(project.getProjectId());
		return Integer.toString(cnt);
	}
	
	
	// 프로젝트 보드 아이디 등록
	@GetMapping("/projectBoardId.do")
	public String getBoardId(@RequestParam("boardId") String boardId, Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		return"";
	}
	
 	
	
	// 프로젝트 검색
	@GetMapping(value = "/projectBoardSearch.do",produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<ProjectVO> boardSearch(@RequestParam String schWord) {
		 return service.searchProjectBoard(schWord);		
	}
	

	// 프로젝트 조회(UI)
	@GetMapping("/projectBoardView.do")
	public String projectBoardView(@RequestParam("projectId") int projectId, @RequestParam("boardId") String boardId, Model model) {
		ProjectVO projectProgress = new ProjectVO();
		projectProgress.setBoardId(boardId);
		log.info("보드아이디 어디갔냐고!!!!!={}",boardId );
		projectProgress.setProjectId(projectId);
		ProjectVO project = service.retrieveProjectBoard(projectProgress);
		model.addAttribute("projectBoard", project);
		log.info("projectProgress={}",project );
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		return "board/project/projectBoardView";
	}
	
	
	//프로젝트 조회(DATA)
	@GetMapping("/projectBoardViewJson")
	@ResponseBody
	public ProjectVO projectBoardViewJson(@RequestParam("projectId") ProjectVO projectId, Model model) {
		ProjectVO project = service.retrieveProjectBoard(projectId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		model.addAttribute("projectBoard", project);
		return project;
	}

	
	
	
	
	
	// 프로젝트 게시글 목록(data)
	@GetMapping(value="/projectPostListJSON", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<PostVO> getProjectPostList(@RequestParam String boardId){
		List<PostVO> post = service.retrieveProjectPostList(boardId);
		return post;
	}
	
	
	// 프로젝트 완료
	@GetMapping(value="/projectFinal", produces = "application/json; charset=utf-8")
	public String projectFinal(@RequestParam int projectId){
		int res = service.finallyProject(projectId);
		return "jsonView"; 
	}

	
	
	
	// 프로젝트 게시글 등록(UI)
	@GetMapping("/projectPostInsert.do")
	public String getPostInsertUI(Model model
			, @RequestParam("boardId") String boardId, @RequestParam("projectId") int projectId ) {
		log.info("컨트롤러에서 받은 값 boardId= {} projectId={}",boardId,projectId );
		model.addAttribute("projectId", projectId);
		model.addAttribute("boardId", boardId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		return "board/project/projectPostForm";
	}
	
	
	// 프로젝트 게시글 등록(POST)
	@PostMapping("/projectPostInsert.do")
	@ResponseBody  // AJAX 쓰는 건 요게 필요!(항상 데이터만 주고받는 걸로)
	public String insertProjectPost(@RequestBody PostVO post, Authentication auth) {
		log.info(" 체킁: {}", post);
		post.setEmpId(auth.getName());
		return Integer.toString(service.createProjectPost(post));
	}
	
	
	// 프로젝트 게시글 검색
	@GetMapping(value = "/projectPostSearch.do",produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<PostVO> postSearch(@RequestParam String schWord) {
		 return service.searchProjectPost(schWord);		
	}
	
	
	// 프로젝트 게시글 조회
	@GetMapping("/projectPostView.do")
	public String postView(@RequestParam("postId") int postId, @RequestParam("projectId") int projectId, Model model) {
		PostVO post = service.retrieveProjectPost(postId);
		model.addAttribute("projectId", projectId);
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		model.addAttribute("projectBoard", post);
		log.info("우선순위:{}",post.getPostAsap());
		return "board/project/projectPostView";
	}
	
	
	// 프로젝트 게시글 수정(UI)
	@GetMapping("/projectPostUpdate.do")
	public String updateForm(@RequestParam("postId") int postId, @RequestParam("projectId") int projectId, Model model) {
		model.addAttribute("level1Menu","board");
		model.addAttribute("level2Menu","projectBoard");
		model.addAttribute("projectId", projectId);
		model.addAttribute("projectBoard", service.retrieveProjectPost(postId));
		return "board/project/projectPostEdit";
	}
	
	// 프로젝트 게시글 수정(DATA)
	@PostMapping(value ="/projectPostUpdate.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int updatePost(@RequestBody PostVO post) {
		log.info("수정 post 내용:{}", post);
		
		int updateProjectPost = service.modifyProjectPost(post);
		
		return updateProjectPost;
	}
	
	
	
	// 프로젝트 게시글 삭제
	@GetMapping("/deleteProjectPost.do")
	public int deletePost() {
		
		return 0;
	}
	
}
