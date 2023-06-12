package kr.or.ddit.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="referrerId")
public class AuthorizationReferrerVO implements Serializable{
	@NotNull
	private Integer referrerId;
	@NotNull
	private String empId;
	@NotNull
	private String aprvDocId;
	
	
	// 조인
	private String atrzRfrrEmpName; // ATRZLINE >< EMP
	private String atrzRfrrEmpDpmt; // EPMT >< EMP

}
