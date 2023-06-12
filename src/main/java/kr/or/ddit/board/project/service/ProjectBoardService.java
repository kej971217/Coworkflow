package kr.or.ddit.board.project.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.board.project.vo.ProjectTeamVO;
import kr.or.ddit.board.project.vo.ProjectVO;
import kr.or.ddit.vo.Pagination;

public interface ProjectBoardService {
	
	
	// 프로젝트 
	
	/**
	 * 프로젝트 등록
	 * @param projectId
	 * @return
	 */
	public int createProjectBoard(ProjectVO projectId);
	
	
	/**
	 * 보드아이디 삽입
	 * @param boardId
	 * @return
	 */
	public int insertBoardId(String boardId);
	
	
	
	/**
	 * 프로젝트아이디 보드에 삽입
	 * @param projectId
	 * @return
	 */
	public int insertTeamId(int projectId);
	
	
	
	/**
	 * 프로젝트 팀원 등록
	 * @param projectTeam
	 * @return
	 */
	public ProjectTeamVO createProjectTeam(ProjectTeamVO projectTeam);
	
	
	
	/**
	 * 프로젝트 팀원 제외
	 * @param projectTeam
	 * @return
	 */
	public ProjectTeamVO removeProjectTeam(ProjectTeamVO projectTeam);
	
	
	/**
	 * 프로젝트 목록
	 * @param pagination
	 */
//	public ProjectVO retrieveProjectBoardList(Pagination<ProjectVO> pagination); 페이징
	public List<ProjectVO> retrieveProjectBoardList(String empId);
	
	
	/**
	 * 프로젝트 검색
	 * @param schWord
	 * @return
	 */
	public List<ProjectVO> searchProjectBoard(String schWord);
	
	
	/**
	 * 프로젝트 상세 조회
	 * @param projectId
	 * @return
	 */
	public ProjectVO retrieveProjectBoard(ProjectVO projectId);
	
	
	/**
	 * 프로젝트 수정
	 * @param project
	 */
	public int modifyProjectBoard(ProjectVO project);
	
	
	/**
	 * 프로젝트 완료
	 * @param projectId
	 * @return
	 */
	public int finallyProject(int projectId);
	
	
	/**
	 * 프로젝트 삭제
	 * @param condition
	 */
	public int removeProjectBoard(int projectId);
	
	
	/**
	 * 파일 다운로드
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);
	
	

	
	// 프로젝트 게시글
	
	/**
	 * 프로젝트 게시글 등록
	 * @param post
	 * @return
	 */
	public int createProjectPost(PostVO post);

	
	/**
	 * 프로젝트 게시글 목록
	 * @return
	 */
	public List<PostVO> retrieveProjectPostList(String boardId);

	
	/**
	 * 프로젝트 게시글 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchProjectPost(String schWord);
	
	
	/**
	 * 프로젝트 게시글 상세 조회
	 * @param projectId
	 * @return
	 */
	public PostVO retrieveProjectPost(int postId);
	
	
	/**
	 * 프로젝트 게시글 수정
	 * @param project
	 */
	public int modifyProjectPost(PostVO post);
	
	
	/**
	 * 프로젝트 게시글 삭제
	 * @param condition
	 */
	public int removeProjectPost(int postId);

	
	
}
