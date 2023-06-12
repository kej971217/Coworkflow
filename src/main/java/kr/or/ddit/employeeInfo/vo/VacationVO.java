package kr.or.ddit.employeeInfo.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.mypage.vo.MypageVO;
import kr.or.ddit.validate.DeleteGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class VacationVO implements Serializable{
	private int rnum;
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {DeleteGroup.class})
	private Integer empAnnualLeaveId;//직원연차정보ID
	
	@NotBlank
	private String empId;//직원ID
	private Integer annualLeaveTotal;//발생연차갯수
	private Integer annualLeaveUsed;//사용갯수
	
	@NotNull
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime annualLeaveYear;//발생년월일
	
	
	
	
	
	//ANNUAL_LEAVE_RECORD
	private Integer leaveRecordId;
	
//	@DateTimeFormat(pattern = "yyyy-MM-DD HH:MM:SS")
//    @JSONFORMAT(PATTERN = "YYYY-MM-DD HH:MM:SS")
	@DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonFormat(shape = Shape.STRING)
	private LocalDateTime leaveStart;//휴가시작일
	
//	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonFormat(shape = Shape.STRING)
	private LocalDateTime leaveEnd;//휴가종료일
	
	private Integer leaveOccurrence;//발생일수
	private String leaveReason;//휴가사유
	private Integer leaveDocNum;//신청기안번호
//	private String empId;//직원ID
	private String leaveKind;//휴가기록ID
	
	
	
	
	//SPECIAL_LEAVE
	private Integer specialLeaveId;//특별휴가ID
	private String specialLeaveReason;//사유
	private String specialLeaveType;//특별휴가종류
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String specialLeavePayDate;//지급일시
	
//	private String empId;//직원ID
	
	
	
	
	
	
	//EMPLOYEE
//	private String empId;//직원ID
	private String empName;//직원명
	
	@JsonIgnore
	private transient String empPass;//비밀번호
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String empBir;//생년월일
	
	private Integer companyId;//회사ID
	private Integer empAtchId;//직원파일ID
//	private Integer isuse;//사용여부
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String empDate;//입사일
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String departureDate;//퇴사일
	
	private String empNum;//사원번호
	private String empGend;//성별
	
	
	
	
	//DEPARTMENT
	private Integer teamId;//본부ID
	private String teamName;//본부명
	private String teamGoal;//본부목표
	private String quartlyGoal;//본부분기복표
//	private Integer isuse;//사용여부
	private Integer belongTeam;//상위본부ID
//	private String empId;//직원ID
	
	
	
	//ORGANIZATION_INFO
	//private Integer ognztId;//소속정보ID
//	private String empId;//소속직원
//	private Integer teamId;//소속본부
//	private Integer isuse;//사용여부
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String appointmentDate;//발령일자
	
	private String rankId;//직급
	private String positionId;//직책
	private String jobId;//직무
	
	
	
	
	private String rankName;
	private String positionName;
	private String jobName;
	
	
	
	private MypageVO mypage;
}






