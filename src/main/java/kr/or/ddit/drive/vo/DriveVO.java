package kr.or.ddit.drive.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class DriveVO implements Serializable{
	private int rnum;
	
	
	@EqualsAndHashCode.Include
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private Integer driveId;//드라이브ID

	private String driveRoot;//폴더이름
	
	private Integer driveIsopen;//노출여부
	
	private Integer teamId;//팀ID
	
	private Integer driveId2;//드라이브ID
	
	private String drivePath;//폴더경로
	
}




