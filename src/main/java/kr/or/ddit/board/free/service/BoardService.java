package kr.or.ddit.board.free.service;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.vo.Pagination;

public interface BoardService {
	public void createBoard(BoardVO board);
	public void retrieveBoardList(Pagination<BoardVO> pagination);
	public BoardVO retrieveBoard(int boNo);
	public void modifyBoard(BoardVO board);
	public void removeBoard(BoardVO condition);
	public AttatchFileVO download(AttatchFileVO condition);
}
