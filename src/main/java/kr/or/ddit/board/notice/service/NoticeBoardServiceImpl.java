package kr.or.ddit.board.notice.service;

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
import kr.or.ddit.board.notice.dao.NoticeBoardDAO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {

	@Inject
	private NoticeBoardDAO boardDAO;
	
	
	@Inject
	private AttatchFileGroupService fileService;
	
	
	@Value("#{appInfo['board.attatchPath']}")
	private File saveFolder;
	
	
	/**
	 * 공지 등록
	 */
	@Override
	public int createNoticeBoard(PostVO post) {
		AttatchFileGroupVO atchFileGroup = post.getAtchFileGroup();
		Optional.ofNullable(atchFileGroup)
				.ifPresent((afg)->{
					fileService.createAttatchFileGroup(afg, saveFolder);
					post.setBoAtch(afg.getAtchId());
				});
		return boardDAO.insertNoticeBoard(post);
	}
	

	
	/**
	 * 공지 목록 조회
	 */
	@Override
	public BoardVO retrieveNoticeBoardList(Pagination<PostVO> pagination) {
		int totalRecord = boardDAO.selectTotalRecord(pagination);
		pagination.setTotalRecord(totalRecord);
		BoardVO board = boardDAO.selectNoticeBoardList(pagination);
		if(board!=null) {
			pagination.setDataList(board.getPostList());
			return board;
		}  
		return null;
	}


	
	/**
	 * 공지 게시글 상세 보기
	 */
	@Override
	public PostVO retrieveNoticeBoard(int postId) {
		PostVO board = boardDAO.selectNoticeBoard(postId);
		boardDAO.updateNoticePostCNT(postId);
		if(board==null) throw new BoardException(postId);
//		AttatchFileGroupVO atchFileGroup = fileService.retrieveAttatchFileGroup(board.getBoAtch(), saveFolder);
//		board.setAtchFileGroup(atchFileGroup);
//		boardDAO.updateNoticeBoHit(postId);
		return board;
	}
	

	
	/**
	 * 공지 수정
	 */
	@Override
	public int modifyNoticeBoard(PostVO post) {
		int result = boardDAO.updateNoticeBoard(post);
		
//		boardAuthenticated(board, saved.getBoPass());
//		// 지우고
//		int rowcnt = Optional.ofNullable(board.getDelFileGroup())
//							.map((dfg)->{
//								dfg.setAtchId(board.getBoAtch());
//								return fileService.removeAttatchFileGroup(dfg, saveFolder);
//							}).orElse(0);
//		// 업로드
//		AttatchFileGroupVO addFileGroup = board.getAddFileGroup();
//		addFileGroup.setAtchId(board.getBoAtch());
//		rowcnt += Optional.ofNullable(board.getBoAtch())
//							.map((ba)->fileService.modifyAttatchFileGroup(addFileGroup, saveFolder))
//							.orElseGet(()->{
//								int cnt = fileService.createAttatchFileGroup(addFileGroup, saveFolder);
//								board.setBoAtch(addFileGroup.getAtchId());
//								return cnt;
//							});
//		rowcnt += boardDAO.updateBoard(board);
		
		return result;
	}
	
	
	/**
	 * 공지 삭제
	 
	@Override
	public void removeNoticeBoard(PostVO condition) {
		BoardVO saved = retrieveNoticeBoard(condition.getBoardId());
		
		int rowcnt = boardDAO.deleteNoticeBoard(condition);
		if(rowcnt>0) {
			Optional.ofNullable(saved.getBoAtch())
					.ifPresent((boAtch)->{
						fileService.removeAttatchFileGroup(boAtch, saveFolder);
					});
		}else {
			throw new BoardInvalidPasswordException(condition.getBoardId());
		}
	}
	 */

	
	
	/**
	 * 파일 다운로드
	 */
	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) 
			throw new RuntimeException(String.format("%d, %d 번 파일이 없음.", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;
	}


	




	/**
	 * 공지 사항 삭제
	 */
	@Override
	public int removeNoticeBoard(int postId) {
		return boardDAO.deleteNoticeBoard(postId);
	}


	
	/**
	 * 공지 사항 검색
	 */
	@Override
	public List<PostVO> searchNoticeBoard(String schWord) {
		return boardDAO.searchNoticeBoard(schWord);
	}

	
}













