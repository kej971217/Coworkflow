package kr.or.ddit.employeeInfo.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class PayrollRecordsVO implements Serializable{
	private int rnum;
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer payrollRecordId;//급여기록ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime payrollRecordDate;//지급년월
	
	@NotBlank(groups = {UpdateGroup.class, DeleteGroup.class})
	private String empId;//직원ID
	private Integer seniorityBasedWage;//호봉
	private Integer baseSalary;//기본급
	private Integer positionAllowance;//직책수당
	private Integer overtimePay;//시간외근무수당
	private Integer bonus;//상여금
	private Integer meals;//식대
	private Integer transAllowance;//교통비
	private Integer totalPayment;//지급액총계
	private Integer incomeTax;//소득세
	private Integer residenceTax;//주민세
	private Integer nationalPension;//국민연금
	private Integer longTermCareInsurance;//장기요양
	private Integer healthInsurance;//건강보험
	private Integer totalDeduction;//공제액합계
	private Integer netSalary;//실지급액
	
	
}
