package kr.or.ddit.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="authorizationLineId")
public class AuthorizationLineVO implements Serializable{
	
	@NotNull
	private Integer authorizationLineId;

	@NotNull
	private String authorizationLineName;
	
	@NotNull
	private String atrzLineEmpId;
	
	@NotNull
	private String aprvDocId;
	
	// 조인
	private String atrzLineEmpName; // ATRZLINE >< EMP
	private String atrzLineEmpDpmt; // EPMT >< EMP
	
	
}
