package kr.or.ddit.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.mypage.vo.EmpAtchFileVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="isapprovalId")
public class IsapprovalVO implements Serializable{
   @NotNull
   private Integer isapprovalId;
   private String isapprovalStatus;
   private String isapprovalReason;
   private String isapprovalDate;
   private String aprvDocId;
   private String empDptId;
   private String empId;
   private Integer aprvTurn;
   
   private String positionName; // 조인
   private String empName; // 조인
   
   private EmpAtchFileVO empSign;

}