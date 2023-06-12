package kr.or.ddit.schedule.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "schdlId")
public class ScheduleVO implements Serializable{
	private Integer schdlId;
	private String schdlTitle;
	
	@DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonFormat(shape = Shape.STRING)
	private LocalDateTime schdlBgn;
	
	@DateTimeFormat(iso = ISO.DATE_TIME)
    @JsonFormat(shape = Shape.STRING)
	private LocalDateTime schdlEnd;
	
	private String isopen;
	private String schdlDetail;
	private String schdlTypeCode;
	private String alram;
	private String empId; //작성자
	
	private String empInfoId; //참석자Id
	private String empInfoName; //참석자Name
	
	private String schdlMovetime;
	private String schdlPlace;
	
	private List<SchdlMemberVO> schdlMemberList;
	
	
	
	public List<SchdlMemberVO> getSchdlMemberList(String empInfoId) {
		this.empInfoId = empInfoId;
		if(empInfoId != null) {
			schdlMemberList = new ArrayList<SchdlMemberVO>();
			String[] empIds = empInfoId.split(",");
			for(String empId : empIds) {
				if(empId.isEmpty()) continue;
				SchdlMemberVO emp = new SchdlMemberVO();
				emp.setEmpId(empId.trim());
				schdlMemberList.add(emp);
			}
		}
		return schdlMemberList;
	}
	
	
	
	
}
