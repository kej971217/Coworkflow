package kr.or.ddit.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="authorizationTurnId")
public class AuthorizationTurnVO implements Serializable{
	@NotNull
	private Integer authorizationTurnId;
	@NotNull
	private String empId;
	private Integer authorizationTurn;
	private Integer authorizationLineId; // 결재선
}
