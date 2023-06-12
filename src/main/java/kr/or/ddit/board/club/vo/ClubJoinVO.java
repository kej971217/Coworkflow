package kr.or.ddit.board.club.vo;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ClubJoinVO {
	
	// 동호회 ID(PK)
	@NotNull
	private Integer clubJoinId;
	
	// 동호회 ID(외래키)
	@NotNull
	private Integer clubId;
	
	// 가입 신청 직원
	@NotNull
	private String empId;
	
	// 신청 일자
	@NotNull
	private String clupJoinDate;
	
	// 승인 여부
	@NotNull
	private Integer isaccess;

	// 동호회장
	private String clubManager;
}
