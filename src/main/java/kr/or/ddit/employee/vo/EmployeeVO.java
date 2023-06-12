package kr.or.ddit.employee.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.employeeInfo.vo.EmployeeInfoVO;
import kr.or.ddit.mypage.vo.MypageVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "empId")
@ToString(exclude = "empPass")
public class EmployeeVO implements Serializable{
	
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String empId;
	@NotBlank
	private String empName;
	@NotBlank
	@JsonIgnore
	private transient String empPass;
	private String empBir;
	private Integer companyId;
	private Integer empAtchId;
	private String isuse;
	
	@DateTimeFormat(iso = ISO.DATE_TIME, pattern = "yyyy-MM-dd") //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING , pattern = "yyyy-MM-dd") // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime empDate;
	
	@DateTimeFormat(iso = ISO.DATE_TIME) //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING) // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime departureDate;
	
	private OrganizationInfoVO organizationInfo;   // 직원이 회사 내에서 가지는 모든 정보
	
	private EmployeeInfoVO employeeInfo; // 직원의 개인 정보들
	
	private RankVO rank;  // 직급, 임원(MANAGER), 사원(USER), 책임, 선임, 대표(ADMIN),
	
	private String memRole;

	private PositionVO position;
	
	private DepartmentVO department; // 직원의 부서 정보
	
	private MypageVO mypage;
	
	// EMPLOYEE_INFO
	private Integer empInfoId;
	private String infoHp;
	private String infoEmail;
	private String infoAddr;
	private String comTel;
	private String infoAddrdetail;
	private String infoEmailPass;
	
	// ORGANIZATION_INFO
	private Integer ognztId;
	private Integer teamId;
	private String appointmentDate;
	private String rankId;
	private String positionId;
	private String jobId;
	
	private String rankName;
	private String positionName;
	private String jobName;
	
	// DEPARTMENT
	private String teamName;
	private String teamGoal;
	private String quartlyGoal;
	private Integer belongTeam;
	
	// MYPAGE - EMP_ATCH_SAVE_NAME
	private String empAtchSaveName; // 프로필 저장명
	
}
