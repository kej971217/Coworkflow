package kr.or.ddit.msg.vo;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.mypage.vo.MypageVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"msgRoomId","empId"})
public class MsgInfoVO {
	private Integer msgRoomId;
	private String empId;
	
	// 이름이 필요해서 가져옴.
	private String empName;
	
	private String msgContent;

		// 마지막 메세지를 보내거나 받은 시간.
	@DateTimeFormat(iso = ISO.DATE_TIME, pattern = "yy.MM.dd HH:mm") //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING, pattern = "yy.MM.dd HH:mm") // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime lastMsgDate;
	
	
	// has a 관계 맺어줌.
	private MsgRoomVO msgRoom;
	
	// 마지막으로 채팅한 채팅VO
	private MessageVO lastMessage;

	// 마지막으로 채팅한 메세지
	private String lastMsgContent;
	
	// 대화 상대를 나타내기 위한 컬럼.
	private List<String> empNameList;
	
	private String apponentName;
	
	private MypageVO mypage;
	
	private String empAtchSaveName;
}
