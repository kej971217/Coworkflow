package kr.or.ddit.employeeInfo.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "empInfoId")
public class EmployeeInfoVO implements Serializable{
	@NotNull
	private Integer empInfoId;
	@NotBlank
	private String empId;
	private String infoHp;
	private String infoEmail;
	private String infoAddr;
	private String comTel;
	private String infoAddrdetail;
}
