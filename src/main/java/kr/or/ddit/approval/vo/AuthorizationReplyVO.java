package kr.or.ddit.approval.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="atrzReplyId")
public class AuthorizationReplyVO {
	
	private Integer atrzReplyId;
	private String empId;
	private String empName;
	
	private String atrzReplyDate;
	private Integer isopen;
	private String aprvDocId;
	private String atrzReplyContent;
	
	private String empAtchSaveName;
	
}
