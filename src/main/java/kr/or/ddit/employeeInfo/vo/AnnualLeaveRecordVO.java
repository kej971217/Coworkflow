package kr.or.ddit.employeeInfo.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class AnnualLeaveRecordVO implements Serializable{
	private int rnum;
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer leaveRecordId;//휴가기록ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String leaveStart;//휴가시작일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String leaveEnd;//휴가종료일
	
	private Integer leaveOccurrence;//발생일수
	private String leaveReason;//휴가사유
	private Integer leaveDocNum;//신청기안번호
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String empId;//직원ID
	private String leaveKind;//휴가종류
}









