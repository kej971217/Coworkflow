package kr.or.ddit.board.inform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;

/**
 * @author PC-01
 *
 */
@Mapper
public interface InformBoardDAO {
	
	
	/**
	 * 사내 소식 등록
	 * @param board
	 * @return
	 */
	public int insertInformBoard(PostVO post);
	
	
	/**
	 * 사내 소식 목록 조회
	 * @param pagination
	 * @return
	 */
//	public BoardVO selectInformBoardList(Pagination<PostVO> pagination); 페이징 처리
	public List<PostVO> selectInformBoardList();
	
	
	/**
	 * 페이징 처리
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<PostVO> pagination);
	
	
	/**
	 * 사내 소식 게시글 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchInformBoard(String schWord);
	
	
	/**
	 * 사내 소식 글 보기
	 * @param boardId
	 * @return
	 */
	public PostVO selectInformBoard(int postId);
	
	
	/**
	 * 조회수 증가
	 * @param boardId
	 * @return
	 */
	public int updateInformPostCNT(int postId);
	
	
	/**
	 * 사내 소식 수정
	 * @param board
	 * @return
	 */
	public int updateInformBoard(PostVO post);
	
	
	
	/**
	 * 사내 소식 삭제
	 * @param board
	 * @return
	 */
	public int deleteInformBoard(int postId);
}
