package kr.or.ddit.board.notice.dao;

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
public interface NoticeBoardDAO {
	
	
	/**
	 * 공지 등록
	 * @param post
	 * @return
	 */
	public int insertNoticeBoard(PostVO post);
	
	
	/**
	 * 공지 목록 조회
	 * @param pagination
	 * @return
	 */
	public BoardVO selectNoticeBoardList(Pagination<PostVO> pagination);
	
	
	/**
	 * 검색 조건에 맞는 레코드수 조회
	 * @param pagination
	 * @return
	 */
	public int selectTotalRecord(Pagination<PostVO> pagination);
	
	
	/**
	 * 공지 게시판 게시글 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchNoticeBoard(String schWord);
	
	
	/**
	 * 공지 글 보기
	 * @param postId
	 * @return
	 */
	public PostVO selectNoticeBoard(int postId);
	
	
	/**
	 * 조회수 증가
	 * @param postId
	 * @return
	 */
	public int updateNoticePostCNT(int postId);
	
	
	/**
	 * 공지 수정
	 * @param post
	 * @return
	 */
	public int updateNoticeBoard(PostVO post);
	
	
	
	/**
	 * 공지 삭제
	 * @param postId
	 * @return
	 */
	public int deleteNoticeBoard(int postId);
	
	
}
