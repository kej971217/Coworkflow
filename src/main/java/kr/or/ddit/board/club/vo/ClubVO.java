package kr.or.ddit.board.club.vo;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ClubVO {
	
	// 동호회 ID (PK)
	@NotNull
	private Integer clubId;
	
	// 동호회명
	@NotNull
	private String clubName;
	
	// 동호회 목표
	@NotNull
	private String clubGoal;
	
	// 사용 여부(폐쇄 여부)
	@NotNull
	private Integer isuse;
	
	// 생성일자
	private String clubCreateDate;
	
	// 폐쇄일자
	private String clubCloseDate;
	
	// 동호회장(PK)
	@NotNull
	private String empId;
}
