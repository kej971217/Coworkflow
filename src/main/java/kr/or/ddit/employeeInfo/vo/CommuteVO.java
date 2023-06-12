package kr.or.ddit.employeeInfo.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.validate.DeleteGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class CommuteVO implements Serializable{
	private int rnum;
	
	
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {DeleteGroup.class})
	private Integer commuteId;//기록ID
	
	@NotBlank
	private String empId;//직원ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime commuteStart;//출근시간
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime commuteEnd;//퇴근시간
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime commuteDate;//날짜
	
	private String commuteStatus;//근무상태
	
	
	
	
	private String commuteStatusValue;//근무상태값
	
	private String empName;//직원이름
	
	private String rankName;//직급명
	private String positionName;//직책명
	private String jobName;//직무명
	
	
	
	
	
//	private CommVO comm;
//	private OrganizationInfoVO orgInfo;
//	private DepartmentVO dep;
//	private EmployeeVO emp;
	
	
	
}





