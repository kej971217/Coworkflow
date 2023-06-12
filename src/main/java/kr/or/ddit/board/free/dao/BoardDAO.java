package kr.or.ddit.board.free.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface BoardDAO {
	public int insertBoard(BoardVO board);
	public List<BoardVO> selectBoardList(Pagination<BoardVO> pagination);
	public int selectTotalRecord(Pagination<BoardVO> pagination);
	public BoardVO selectBoard(int boNo);
	public int updateBoHit(int boNo);
	public int updateBoard(BoardVO board);
	public int deleteBoard(BoardVO condition);
}
