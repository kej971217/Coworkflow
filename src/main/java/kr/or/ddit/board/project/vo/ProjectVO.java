package kr.or.ddit.board.project.vo;

import java.util.List;

import javax.validation.constraints.NotNull;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PostVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ProjectVO {
	
	// 프로젝트 아이디(PK)
	@NotNull
	private Integer projectId;
	
	// 프로젝트 명
	@NotNull
	private String projectName;
	
	// 프로젝트 목표
	@NotNull
	private String projectGoal;
	
	// 프로젝트 폐쇄 여부
	@NotNull
	private Integer isuse;
	
	// 프로젝트 생성일
	@NotNull
	private String projectCreateDate;
	
	// 프로젝트 착수일
	@NotNull
	private String projectStartDate;
	
	// 프로젝트 마감일
	@NotNull
	private String projectGoalDate;
	
	// 프로젝트 장
	@NotNull
	private String empId;
	
	// 프로젝트 진행률
	@NotNull
	private Integer projectProgress;
	
	// 보드 아이디
	@NotNull
	private String boardId;
	
}
