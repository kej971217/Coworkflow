package kr.or.ddit.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.DeleteGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "deputyApproverId")
public class DeputyApproverVO implements Serializable{
	@NotNull(groups = {DeleteGroup.class})
	private Integer deputyApproverId;
	
	private String deputyApproverEmp;
	private String deputyEmpName;
	private String deputyApproverEmpDPMT;
	private String deputyTeamName;
	private String deputyPositionName;
	
	private String deputyApproverBgn;
	private String deputyApproverEnd;
	
	private String deputyApproverReason;
	
	private String empId;
	private String empName;
	

}
