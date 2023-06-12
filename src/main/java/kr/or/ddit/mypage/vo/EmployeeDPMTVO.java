package kr.or.ddit.mypage.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class EmployeeDPMTVO implements Serializable{
   
   private String empId;
   
   private String empName;
   
   private String teamName;
   
   private String positionName;
   
   private MypageVO mypage;
}