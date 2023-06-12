package kr.or.ddit.msg.vo;

import java.io.Serializable;
import java.text.MessageFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
//@EqualsAndHashCode(of = "msgRoomId")
//@Getter
@NoArgsConstructor
@ToString
public class MsgRoomVO implements Serializable {
	
	private Integer msgRoomId;
	
	@DateTimeFormat(iso = ISO.DATE_TIME, pattern = "yy.MM.dd HH:mm") //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING, pattern = "yy.MM.dd HH:mm") // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime msgOpenDate;
	
	private String msgRoomName;
	
	
	@ToString.Exclude
	@JsonIgnore
	private transient SimpMessagingTemplate msgTmpl;
	private String destination;
	
	
	public MsgRoomVO(SimpMessagingTemplate msgTmpl, int msgRoomId, String msgRoomName ) {
		super();
		this.msgTmpl = msgTmpl;
		this.msgRoomName = msgRoomName;
		this.msgRoomId = msgRoomId;
		this.destination = MessageFormat.format("/chatting/{0}", msgRoomId);
	}
	
	public void broadCastInRoom(MessageVO message) {
		msgTmpl.convertAndSend(getDestination(), message);
	}
	
	
	//참여자Id
	private String empInfoId;
	
	//참여자Name
	private String empInfoName; 
	
	//참여자가 다중일 경우 대비.
	private List<MsgInfoVO> chatMemberList;
	
	public List<MsgInfoVO> getChatMemberList(String empInfoId) {
		this.empInfoId = empInfoId;
		if(empInfoId != null) {
			chatMemberList = new ArrayList<MsgInfoVO>();
			String[] empIds = empInfoId.split(",");
			for(String empId : empIds) {
				if(empId.isEmpty()) continue;
				MsgInfoVO emp = new MsgInfoVO();
				emp.setEmpId(empId.trim());
				chatMemberList.add(emp);
			}
		}
		return chatMemberList;
	}
	
	
	private List<MsgInfoVO> msgInfoList;
	
	
	
}
