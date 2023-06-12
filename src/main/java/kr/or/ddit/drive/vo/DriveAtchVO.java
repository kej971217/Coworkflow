package kr.or.ddit.drive.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class DriveAtchVO implements Serializable{
	private int rnum;
	
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer driveAtchNo;//파일번호
	
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer driveId;//드라이브ID
	
	private String driveAtchType;//파일종류
	
	private String driveAtchOriginName;//파일원본명
	
	private String driveAtchSaveName;//파일저장명
	
	private String empId;//등록직원ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime driveAtchRgstDate;//등록일자
	
	private Integer isopen;//노출여부
	
	private long driveAtchSize;//파일크기
	
	private String driveFileRoot;//파일경로
	
	
	private String filterType; //jsp 파라미터 이름

}
                                                                                                                                                                                                                                                  