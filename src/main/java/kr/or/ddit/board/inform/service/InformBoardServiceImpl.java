package kr.or.ddit.board.inform.service;

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
import kr.or.ddit.board.inform.dao.InformBoardDAO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InformBoardServiceImpl implements InformBoardService {

	@Inject
	private InformBoardDAO boardDAO;
	
	
	@Inject
	private AttatchFileGroupService fileService;
	
	
	@Value("#{appInfo['board.attatchPath']}")
	private File saveFolder;


	
	// 사내 소식 등록
	@Override
	public int createInformBoard(PostVO post) {
		
		return boardDAO.insertInformBoard(post);
	}

	// 사내 소식 게시글 목록 조회
	@Override
	public List<PostVO> retrieveInformBoardList() {
		
		return boardDAO.selectInformBoardList();
	}


	// 사내 게시글 상세 조회
	@Override
	public PostVO retrieveInformBoard(int postId) {
		PostVO post = boardDAO.selectInformBoard(postId);
		if(post.getAtchId() != null) {
			AttatchFileGroupVO atchFileGroup = fileService.retrieveAttatchFileGroup(post.getAtchId(), saveFolder);
			post.setAtchFileGroup(atchFileGroup);
		}
		boardDAO.updateInformPostCNT(postId);
		if(post==null) throw new BoardException(postId);
		return post;
	}

	// 사내 소식 검색	
	@Override
	public List<PostVO> searchInformBoard(String schWord) {
		return boardDAO.searchInformBoard(schWord);
	}

	
	// 사내 소식 수정
	@Override
	public int modifyInformBoard(PostVO post) {
		return boardDAO.updateInformBoard(post);
	}

	
	// 사내 소식 삭제
	@Override
	public int removeInformBoard(int postId) {
		return boardDAO.deleteInformBoard(postId);
	}


	@Override
	public AttatchFileVO download(AttatchFileVO condition) {
		AttatchFileVO atchFile = fileService.retrieveAttatchFile(condition, saveFolder);
		if(atchFile==null) 
			throw new RuntimeException(String.format("%d, %d 번 파일이 없음.", condition.getAtchId(), condition.getAtchSeq()));
		return atchFile;

	}
	
	
}
