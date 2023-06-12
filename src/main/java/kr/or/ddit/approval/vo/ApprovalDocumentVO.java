package kr.or.ddit.approval.vo;

import java.io.Serializable;
import java.sql.Timestamp;
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
@EqualsAndHashCode(of="aprvDocId")
public class ApprovalDocumentVO implements Serializable{
	
	private int rnum;
	
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private String aprvDocId;
	private String tempAprvDocId;
	private String empId;
	private String empName;
	
	private String teamName;
	
	private String aprvDocTitle;
	
	private String aprvContent;
	
	private Integer isurgent; // 응급여부
	
	private Integer atrzFormId; // 양식 데이터ID
	private String atrzFormName; // 양식 데이터ID
	
	private Integer aprvDocReference; // 참조문서 테이블의 데이터ID
	private ApprovalDocumentVO referenceDoc; // 참조문서 테이블의 데이터ID
	
	private String receiver; // 수신자 Id
	private String receiverId; // 수신자 Id
	private String receiverName; // 수신자 이름
	private String receiverDpmt; // 수신자 부서
	
	private String aprvDocDate;
	
	// 결재자
	private List<IsapprovalVO> atrzLineList;
	
	// 참조자
	private List<AuthorizationReferrerVO> atrzRfrrList;
	
	// 참조문서
	private List<ApprovalDocumentVO> aprvDocList; 
	
	// 결재 첨부
	private Integer atchId;
	
	private MultipartFile[] atrzFiles;
	public void setAtrzFiles(MultipartFile[] atrzFiles) {
		if(atrzFiles==null || atrzFiles.length==0) return;
		this.atrzFiles = atrzFiles;
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchFileList(
			Arrays.stream(atrzFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}
	
	private AttatchFileGroupVO atchFileGroup;
	
	private Integer approvalAtch;
	
	private int atchCount;
	
	private MultipartFile[] addFiles;
	public void setAddFiles(MultipartFile[] addFiles) {
		if(addFiles==null || addFiles.length==0) return;
		this.addFiles = addFiles;
		this.addFileGroup = new AttatchFileGroupVO();
		addFileGroup.setAtchFileList(
			Arrays.stream(addFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}
	
	private AttatchFileGroupVO addFileGroup;
	
	private AttatchFileGroupVO delFileGroup;
	
	private List<AuthorizationReplyVO> aprvReplyList;
	
	
	private int nextAprvCheck;
	
	private int deleteCheck;
	
}
