package kr.or.ddit.alarm.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "almNum")
public class AlarmVO implements Serializable {
	
	private Integer almNum;
	private String empId;
	@DateTimeFormat(iso = ISO.DATE_TIME, pattern = "MM-dd HH:mm:ss") //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING, pattern = "MM-dd HH:mm:ss") // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime almDate;
	
	private String almIsread;
	private String almContent;
	//알람을 보내는 상대.
	private String almApponent;
	
	//알람 내용 타입.
	private String almType;
	
	// EMP 이름 이 필요해서 설정한 임시 컬럼.
	private String empName;
	private String almApponentName;
	
	
	
	
}
