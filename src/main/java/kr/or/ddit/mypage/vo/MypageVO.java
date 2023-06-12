package kr.or.ddit.mypage.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="empId")
public class MypageVO implements Serializable{
	@NotNull(groups = {UpdateGroup.class})
	private String empId;
	private String empName;
	private String empPass;
	private String checkEmpPass;
	private String newPassCheck;
	
	private String empBir;
	private Integer companyId;
	private Integer empAtchId;
	private Integer isuse;
	private String empDate;
	private String departureDate;
	private String empNum;
	private String empGend;
	private Integer empInfoId;
	private String infoHp;
	private String infoEmail;
	private String infoAddr;
	private String comTel;
	private String infoAddrdetail;
	
	private String teamName;
	private String rankName;
	private String positionName;
	private String jobName;
	
	
	
	private List<EmpAtchFileVO> empAtchFileList;

	private MultipartFile empFiles;
//	public void setEmpFiles(MultipartFile empFiles) {
//		if(empFiles==null) return;
//		this.empFiles = empFiles;
//		
//	}
	
	private EmpAtchFileVO profileImage;
	private EmpAtchFileVO signImage;
	
	private int atchCount;
	
	private EmpAtchFileVO addFile;
	
	private EmpAtchFileVO delFile;
	

	private MultipartFile addFiles;
//	public void setAddFiles(MultipartFile addFiles) {
//		if(addFiles==null) return;
//		this.addFiles = addFiles;
//	}
	
	
	
	
	
}

