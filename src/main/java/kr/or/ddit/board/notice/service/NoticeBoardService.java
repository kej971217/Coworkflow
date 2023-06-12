package kr.or.ddit.board.notice.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;

public interface NoticeBoardService {
	
	
	/**
	 * 공지 등록
	 * @param post
	 */
	public int createNoticeBoard(PostVO post);
	
	
	/**
	 * 공지 목록
	 * @param pagination
	 */
	public BoardVO retrieveNoticeBoardList(Pagination<PostVO> pagination);
	
	
	/**
	 * 공지 조회
	 * @param postId
	 * @return
	 */
	public PostVO retrieveNoticeBoard(int postId);
	
	
	/**
	 * 공지 수정
	 * @param post
	 */
	public int modifyNoticeBoard(PostVO postId);
	
	
	/**
	 * 공지 삭제
	 * @param condition
	 */
	public int removeNoticeBoard(int postId);
	
	
	/**
	 * 파일 다운로드
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);
	
	
	/**
	 * 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchNoticeBoard(String schWord);
}
