package kr.or.ddit.approval.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString.Exclude;

@Data
@EqualsAndHashCode(of="atrzFormId")
public class DraftFormVO implements Serializable{
	@NotNull
	private Integer atrzFormId;
	@Exclude
	private String atrzFormContent;
	@NotNull
	private String atrzFormName;
	@NotNull
	private String isuse;
	private String atrzFormDate;
	
	private List<String> formDPMTList;
}
