package kr.or.ddit.board.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

import kr.or.ddit.board.project.vo.ProjectVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class BoardVO implements Serializable{
	
	//게시판 아이디
	@NotNull
	private String boardId;
	
	// 게시판 이름
	@NotNull
	private String boardName;
	
	// 개설일
	@NotNull
	private String boardOpenDate;
	
	// 폐쇄일
	private String boardCloseDate;
	
	// 사용 여부
	@NotNull
	private Integer isuse;
	
	// 게시판 분류
	@NotNull
	private String boardClassification;
	
	// 소속
	private Integer teamId;
	
	
	// 글 목록
	private List<PostVO> postList;
	
}




















