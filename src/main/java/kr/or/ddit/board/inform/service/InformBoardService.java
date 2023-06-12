package kr.or.ddit.board.inform.service;

import java.util.List;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;

public interface InformBoardService {
	
	
	/**
	 * 사내 소식 등록
	 * @param board
	 */
	public int createInformBoard(PostVO post);
	
	
	/**
	 * 사내 소식 목록
	 * @param pagination
	 */
	public List<PostVO> retrieveInformBoardList();
	
	
	/**
	 * 사내 소식 조회
	 * @param boardId
	 * @return
	 */
	public PostVO retrieveInformBoard(int postId);
	
	
	/**
	 * 검색
	 * @param schWord
	 * @return
	 */
	public List<PostVO> searchInformBoard(String schWord);
	
	
	/**
	 * 사내 소식 수정
	 * @param board
	 */
	public int modifyInformBoard(PostVO post);
	
	
	/**
	 * 사내 소식 삭제
	 * @param condition
	 */
	public int removeInformBoard(int postId);
	
	
	/**
	 * 파일 다운로드
	 * @param condition
	 * @return
	 */
	public AttatchFileVO download(AttatchFileVO condition);
}
