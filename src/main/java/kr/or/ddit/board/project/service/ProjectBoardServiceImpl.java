package kr.or.ddit.board.project.service;

import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.BoardException;
import kr.or.ddit.board.free.dao.BoardDAO;
import kr.or.ddit.board.project.dao.ProjectBoardDAO;
import kr.or.ddit.board.project.vo.ProjectTeamVO;
import kr.or.ddit.board.project.vo.ProjectVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectBoardServiceImpl implements ProjectBoardService {

	@Inject
	private ProjectBoardDAO boardDAO;
	
	
	@Inject
	private AttatchFileGroupService fileService;
	
	
	@Value("#{appInfo['board.attatchPath']}")
	private File saveFolder;


	
	// 프로젝트
	
	// 프로젝트 등록
	@Override
	public int createProjectBoard(ProjectVO projectId) {
		return boardDAO.insertProjectBoard(projectId);
	}

	// 보드 아이디 등록
	@Override
	public int insertBoardId(String boardId) {
		return boardDAO.insertBoardId(boardId);
	}
	
	// 프로젝트 아이디 보드에 등록
	@Override
	public int insertTeamId(int projectId) {
		return boardDAO.insertTeamId(projectId);
	}

	

	// 프로젝트 팀원 등록
	@Override
	public ProjectTeamVO createProjectTeam(ProjectTeamVO projectTeam) {
		return boardDAO.insertProjectTeam(projectTeam);
	}
	
	
	// 프로젝트 팀원 제외
	@Override
	public ProjectTeamVO removeProjectTeam(ProjectTeamVO projectTeam) {
		return null;
	}
	
	
	// 프로젝트 목록
	@Override
	public List<ProjectVO> retrieveProjectBoardList(String empId) {
		return boardDAO.selectProjectBoardList(empId);
	}


	// 프로젝트 검색
	@Override
	public List<ProjectVO> searchProjectBoard(String schWord) {
		return null;
	}


	// 프로젝트 상세 조회
	@Override
	public ProjectVO retrieveProjectBoard(ProjectVO projectId) {
		return boardDAO.selectProjectBoard(projectId);
	}


	// 프로젝트 수정
	@Override
	public int modifyProjectBoard(ProjectVO project) {
		return 0;
	}

	
	// 프로젝트 완료
	@Override
	public int finallyProject(int projectId) {
		return boardDAO.completeProject(projectId);
	}


	//프로젝트 삭제
	@Override
	public int removeProjectBoard(int projectId) {
		return 0;
	}


	//파일 다운로드
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		return null;
	}



	
	// 프로젝트 내 게시글
	
	// 프로젝트 게시글 생성
	@Override
	public int createProjectPost(PostVO post) {
		return boardDAO.insertProjectPost(post);
	}

	
	// 프로젝트 게시글 목록
	@Override
	public List<PostVO> retrieveProjectPostList(String boardId) {
		return boardDAO.selectProjectPostList(boardId);
	}

	
	// 프로젝트 게시글 검색
	@Override
	public List<PostVO> searchProjectPost(String schWord) {
		return null;
	}


	// 프로젝트 게시글 상세 조회
	@Override
	public PostVO retrieveProjectPost(int postId) {
		return boardDAO.selectProjectPost(postId);
	}


	// 프로젝트 게시글 수정
	@Override
	public int modifyProjectPost(PostVO post) {
		return boardDAO.updateProjectPost(post);
	}


	// 프로젝트 게시글 삭제
	@Override
	public int removeProjectPost(int postId) {
		return boardDAO.deleteProjectPost(postId);
	}

	
	
}
