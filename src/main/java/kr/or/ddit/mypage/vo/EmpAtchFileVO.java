package kr.or.ddit.mypage.vo;

import java.io.File;

import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.attatch.vo.AttatchFileVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@EqualsAndHashCode(of = {"empAtchId", "empAtchClasfct"})
@NoArgsConstructor
@ToString(exclude = "file")
public class EmpAtchFileVO implements Serializable {
	@JsonIgnore
	private transient MultipartFile file;
	
	public EmpAtchFileVO(MultipartFile file) {
		super();
		this.file = file;
		empAtchMime = file.getContentType();
		empAtchOriginName = file.getOriginalFilename();
		empAtchSaveName = UUID.randomUUID().toString();
		empAtchSize = file.getSize();
	}
	
	private Integer empAtchId;
	private Integer empAtchClasfct; // 0 기본 1 결재
	private String empAtchMime;
	private String empAtchOriginName;
	private String empAtchSaveName;
	private Long empAtchSize;
	private String empAtchDate;
	private String empAtchRoot;
	
	private File atchFile;
	
	
	public void saveTo(File saveFolder) throws IOException {
		if(file==null) return;
		log.info("saveTo 확인 ={}",saveFolder + empAtchSaveName);
		file.transferTo(new File(saveFolder, empAtchSaveName));
	}
}