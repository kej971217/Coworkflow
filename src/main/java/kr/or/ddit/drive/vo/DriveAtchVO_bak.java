//package kr.or.ddit.drive.vo;
//
//import java.io.File;
//import java.io.IOException;
//import java.io.Serializable;
//import java.time.LocalDateTime;
//import java.util.UUID;
//
//import javax.validation.constraints.NotNull;
//
//import org.springframework.format.annotation.DateTimeFormat;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.fasterxml.jackson.annotation.JsonFormat;
//import com.fasterxml.jackson.annotation.JsonIgnore;
//
//import kr.or.ddit.validate.DeleteGroup;
//import kr.or.ddit.validate.UpdateGroup;
//import lombok.Data;
//import lombok.EqualsAndHashCode;
//import lombok.NoArgsConstructor;
//import lombok.ToString;
//
//@Data
//@NoArgsConstructor
//@ToString(exclude = "file")
//public class DriveAtchVO implements Serializable{
//	private int rnum;
//	
//	@JsonIgnore
//	private transient MultipartFile file;
//	
//	
//	
//	public DriveAtchVO(MultipartFile file) {
//		super();
//		this.file = file;
//		driveAtchType = file.getContentType();
//		driveAtchOriginName = file.getOriginalFilename();
//		driveAtchSaveName = UUID.randomUUID().toString();
//		driveAtchSize = file.getSize();
//	}
//
//
//
//	@EqualsAndHashCode.Include
//	private Integer driveAtchNo;//파일번호
//	
//	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
//	private Integer driveId;//드라이브ID
//	private String driveAtchType;//파일종류
//	private String driveAtchOriginName;//파일원본명
//	private String driveAtchSaveName;//파일저장명
//	private String empId;//등록직원ID
//	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	private LocalDateTime driveAtchRgstDate;//등록일자
//	private Integer isopen;//노출여부
//	private long driveAtchSize;//파일크기
//	private String driveFileRoot;//파일경로
//	
//	
//	
//	private File driveAtchFile;
//	
//	public void saveTo(File saveFolder) throws IOException {
//		if(file==null) return;
//		file.transferTo(new File(saveFolder, driveAtchSaveName));
//	}
//
//}
//                                                                                                                                                                                                                                                  