package kr.or.ddit.board.project.vo;

import javax.validation.constraints.NotNull;

import kr.or.ddit.board.vo.BoardVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ProjectTeamVO {
	
	// 프로젝트 팀 아이디
	@NotNull
	private String prjtTeamId;
	
	// 프로젝트 투입일
	@NotNull
	private String prjtTeamRegistDate;
	
	// 프로젝트 제외일
	private String prjtTeamWdrwDate;
	
	// 직원 아이디
	@NotNull
	private String empId;
	
	// 사용 여부
	@NotNull
	private Integer isuse;
	
	// 프로젝트 아이디
	@NotNull
	private Integer projectId;

	// 프로젝트 아키텍처
	@NotNull
	private String projectArch;
}
