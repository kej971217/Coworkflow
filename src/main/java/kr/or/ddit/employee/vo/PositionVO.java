package kr.or.ddit.employee.vo;


import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"teamId","positionId"})
public class PositionVO implements Serializable {
	
//	private String empId;
	
	// 직책에는 여러가지가 올 수 있음. 
	
	// 팀 정보 가져오기 위함
	private Integer teamId;
	private String teamName;
	
	// 직책 정보 가져오기 위함
	private String positionId;
	private String positionName;

	
}
