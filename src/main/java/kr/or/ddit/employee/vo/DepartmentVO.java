package kr.or.ddit.employee.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "teamId")
@ToString
public class DepartmentVO implements Serializable{
	private Integer teamId;
	private String teamName;
	private String teamGoal;
	private String quartlyGoal;
	private Integer isuse;
	private Integer belongTeam;
	private String empId;
}
