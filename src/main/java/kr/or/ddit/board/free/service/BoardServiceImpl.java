package kr.or.ddit.board.free.service;

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
import kr.or.ddit.board.BoardInvalidPasswordException;
import kr.or.ddit.board.free.dao.BoardDAO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.vo.Pagination;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;
	
	@Inject
	private AttatchFileGroupService fileService;
	
	@Value("#{appInfo['board.attatchPath']}")
	private File saveFolder;
	
	/*
	@Override
	public void createBoard(BoardVO board) {
		AttatchFileGroupVO atchFileGroup = board.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(afg, saveFolder);
					board.setBoAtch(afg.getAtchId());
				});
		boardDAO.insertBoard(board);
	}
	*/
	
	@Override
	public void retrieveBoardList(Pagination<BoardVO> pagination) {
		int totalRecord = boardDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		List<BoardVO> dataList = boardDAO.selectBoardList(pagination);
		pagination.setDataList(dataList);
	}

	@Override
	public BoardVO retrieveBoard(int boNo) {
		BoardVO board = boardDAO.selectBoard(boNo);
		if(board==null) throw new BoardException(boNo);
//		AttatchFileGroupVO atchFileGroup = fileService.retrieveAttatchFileGroup(board.getBoAtch(), saveFolder);
//		board.setAtchFileGroup(atchFileGroup);
		boardDAO.updateBoHit(boNo);
		return board;
	}
	
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) 
			throw new RuntimeException(String.format("%d, %d 번 파일이 없음.", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}

	@Override
	public void createBoard(BoardVO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void modifyBoard(BoardVO board) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeBoard(BoardVO condition) {
		// TODO Auto-generated method stub
		
	}

	/*
	private void boardAuthenticated(BoardVO inputBoard, String savedPass) {
		if(! inputBoard.getBoPass().equals(savedPass)) {
			throw new BoardInvalidPasswordException(inputBoard.getBoNo());
		}
	}
	*/

	/*
	@Override
	public void modifyBoard(BoardVO board) {
		// 게시글 수정 절차 ???
		BoardVO saved = retrieveBoard(board.getBoNo());
		boardAuthenticated(board, saved.getBoPass());
		// 지우고
		int rowcnt = Optional.ofNullable(board.getDelFileGroup())
							.map((dfg)->{
								dfg.setAtchId(board.getBoAtch());
								return fileService.removeAttatchFileGroup(dfg, saveFolder);
							}).orElse(0);
		// 업로드
		AttatchFileGroupVO addFileGroup = board.getAddFileGroup();
		addFileGroup.setAtchId(board.getBoAtch());
		rowcnt += Optional.ofNullable(board.getBoAtch())
							.map((ba)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
							.orElseGet(()->{
								int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
								board.setBoAtch(addFileGroup.getAtchId());
								return cnt;
							});
		rowcnt += boardDAO.updateBoard(board);
		
		
	}
	*/
	
	
	/*
	@Override
	public void removeBoard(BoardVO condition) {
		BoardVO saved = retrieveBoard(condition.getBoNo());
		
		int rowcnt = boardDAO.deleteBoard(condition);
		if(rowcnt>0) {
			Optional.ofNullable(saved.getBoAtch())
					.ifPresent((boAtch)->{
						fileService.removeAttatchFileGroup(boAtch, saveFolder);
					});
		}else {
			throw new BoardInvalidPasswordException(condition.getBoNo());
		}
	}
	*/
}














