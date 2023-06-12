package kr.or.ddit.employee.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.commons.vo.CommVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class OrganizationInfoVO implements Serializable{
	
	private int rnum;
	
	
	@EqualsAndHashCode.Include
	@NotNull
	private Integer ognztId; //소속정보ID
	@NotBlank
	private String empId; //소속직원ID
	private Integer teamId; //소속본부
	@NotNull
	private Integer isuse; //사용여부
	@NotBlank
	private String appointmentDate; //발령일자
	private String rankId; //직급
	private String positionId; //직책
	private String jobId; //직무
	
	
//	private DepartmentVO department;
//	
//	private List<CommVO> commList;
//	
//	private EmployeeVO employee;
	
	
	
	
	
	
//	private Integer teamId;
	private String teamName;
	private String teamGoal;
	private String quartlyGoal;
//	private Integer isuse;
	private Integer belongTeam;
//	private String empId;
	
			
	private String empName;
	
	private String rankName;
	private String positionName;
	private String jobName;
	
	
	private Integer rankCnt;
	private Integer teamCnt;
	
	private Integer maleCnt;
	private Integer femaleCnt;
	private float malePercent;
	private float femalePercent;
	
	private Integer ageGroup;
	private Integer empCnt;
	
	private Integer positionCnt;
	private Integer jobCnt;
	
	
	private List<EmployeeVO> empList;
}
