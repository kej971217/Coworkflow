package kr.or.ddit.board.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.project.vo.ProjectTeamVO;
import kr.or.ddit.board.project.vo.ProjectVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;


@Mapper
public interface ProjectBoardDAO {
	
	
	/**
	 * 프로젝트 등록
	 * @param projectId
	 * @return
	 */
	public int insertProjectBoard(ProjectVO projectId);
	
	
	
	/**
	 * 보드아이디 삽입
	 * @param boardId
	 * @return
	 */
	public int insertBoardId(String boardId);
	
	
	/**
	 * 프로젝트 아이디 보드에 등록
	 * @param ProjectId
	 * @return
	 */
	public int insertTeamId(int ProjectId);
	
	
	/**
	 * 프로젝트 목록 조회
	 * @param pagination
	 * @return
	 */
//	public ProjectVO selectProjectBoardList(Pagination<ProjectVO> pagination); 페이징 처리
	public List<ProjectVO> selectProjectBoardList(String empId);
	
	
	
	/**
	 * 프로젝트 팀원 등록
	 * @param projectTeam
	 * @return
	 */
	public ProjectTeamVO insertProjectTeam(ProjectTeamVO projectTeam);
	
	
	/**
	 * 프로젝트 팀원 제외
	 * @param projectTeam
	 * @return
	 */
	public ProjectTeamVO deleteProjectTeam(ProjectTeamVO projectTeam);
	
	
	/**
	 * 검색 조건에 맞는 레코드수 조회
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<ProjectVO> pagination);
	
	
	/**
	 * 프로젝트 검색
	 * @param schWord
	 * @return
	 */
	public List<ProjectVO> searchProjectBoard(String schWord);

	
	/**
	 * 프로젝트 보기
	 * @param projectId
	 * @return
	 */
	public ProjectVO selectProjectBoard(ProjectVO projectId);
	
	
	/**
	 * 프로젝트 수정
	 * @param projectId
	 * @return
	 */
	public int updateProjectBoard(ProjectVO projectId);
	
	
	/**
	 * 프로젝트 완료
	 * @param projectId
	 * @return
	 */
	public int completeProject(int projectId);
	
	
	/**
	 * 프로젝트 삭제
	 * @param projectId
	 * @return
	 */
	public int deleteProject(int projectId);
	
	
	
	
	
	
	// 프로젝트 내의 게시글	
	
	/**
	 * 프로젝트 게시글 조회
	 * @param pagination
	 * @return
	 */
//	public BoardVO selectProjectPostList(Pagination<PostVO> pagination); 페이징 처리
	public List<PostVO> selectProjectPostList(String boardId);
	
	
	/**
	 * 프로젝트 게시글 상세 조회
	 * @param postID
	 * @return
	 */
	public PostVO selectProjectPost(int postID);
	
	
	/**
	 * 프로젝트 게시글 조회수 증가
	 * @param postId
	 * @return
	 */
	public int updateProjectPostCNT(int postId);

	
	/**
	 * 프로젝트 게시글 등록
	 * @param post
	 * @return
	 */
	public int insertProjectPost(PostVO post);
	
	
	/**
	 * 프로젝트 게시글 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchProjectPost(String schWord);
	
	
	/**
	 * 프로젝트 게시글 수정
	 * @param post
	 * @return
	 */
	public int updateProjectPost(PostVO post);
	
	
	/**
	 * 프로젝트 게시글 삭제
	 * @param postId
	 * @return
	 */
	public int deleteProjectPost(int postId);
	
	
}
