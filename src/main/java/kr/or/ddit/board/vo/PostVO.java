package kr.or.ddit.board.vo;

import java.util.Arrays;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class PostVO {
	
	// 게시물 ID
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer postId;
	
	// 이전 게시글 번호
//	private Integer prePost;
//	// 다음 게시글 번호
//	private Integer postPost;
//	// 이전 게시글 제목
//	private String prePostTitle;
//	// 다음 게시글 제목
//	private String postPostTitle;

	private PostVO prePost;
	private PostVO nextPost;
	
	
	// 제목
	@NotBlank
	private String postTitle;
	
	//말머리(사내소식)
	private String postHeader;
	
	// 우선순위(프로젝트)
	private String postAsap;
	
	// 내용
	@NotBlank
	private String postContent;
	
	//조회수
	@NotNull
	private Integer postCnt;
	
	// 작성일자
	@NotNull
	private String postDate;
	
	// 노출 여부(삭제 여부)
	@NotNull
	private Integer postIsopen;
	
	// 게시판 첨부 파일
	private Integer atchId;
	
	//게시판 ID (외래키)
	@NotNull
	private String boardId;
	
	// 직원 ID - 작성자 (외래키)
	@NotNull
	private String empId;
	
	private String empName;
	
	// 시작일
	private String postSday;
	// 마감일
	private String postFday;
	
	// 프로젝트 진척도
	private String postProgress;
	
	
	// 추가 보드 조인 (projectVO)
	private Integer projectId; 
	
	private AttatchFileGroupVO atchFileGroup;
	
	private Integer boAtch;
	
	private int atchCount;
	
	private MultipartFile[] addFiles;
	public void setAddFiles(MultipartFile[] addFiles) {
		if(addFiles==null || addFiles.length==0) return;
		this.addFiles = addFiles;
		this.atchFileGroup = new AttatchFileGroupVO();
		atchFileGroup.setAtchFileList(
			Arrays.stream(addFiles)
					.filter((mf)->!mf.isEmpty())
					.map((mf)->new AttatchFileVO(mf))
					.collect(Collectors.toList())
		);
	}
	
	private AttatchFileGroupVO addFileGroup;
	
	private AttatchFileGroupVO delFileGroup;
	
}
