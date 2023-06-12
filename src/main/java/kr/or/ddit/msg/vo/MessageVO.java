package kr.or.ddit.msg.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@EqualsAndHashCode(of = "msgId")
@ToString(exclude = "msgContent")
public class MessageVO implements Serializable {
	
	public enum MessageType { NOTIFY, DIALOG }
	@Builder.Default
	private MessageType msgType = MessageType.DIALOG;
	
	private Integer msgId;
	private String msgContent;
	@DateTimeFormat(iso = ISO.DATE_TIME, pattern = "yy.MM.dd HH:mm") //parsing 설정 String -> LocalDateTime 설정.
	@JsonFormat(shape = Shape.STRING, pattern = "yy.MM.dd HH:mm") // 포맷팅할때 문자열로 포맷팅해줄꺼임.
	private LocalDateTime msgDate;
	private String msgIsread;
	private Integer msgRoomId;
	private String empId;
	private String empAtchSaveName; 

	
	@Builder.Default
	private MessageType messageType = MessageType.DIALOG;
	private String sender;
	private String receiver;
	private String message;
	private String roomId;
	
//	public String getColor() {
//		return messageType.getColor();
//	}
//	
//	public String getBackgroundColor() {
//		return messageType.getBackgroundColor();
//	}	
//	
	
	public MessageVO(String sender, String realMsg, LocalDateTime msgDate) {
		this.empId = sender;
		this.msgContent = realMsg;
		this.msgDate = msgDate;
//		this.empAtchSaveName = empAtchSaveName;
	}


//	public enum MessageType{
//		INFO, SUCCESS, QUESTION, CHATTING, ALARM, WARNING("yellow", "white"), ERROR("red", "yellow");
//		private MessageType() {
//			this("black", "white");
//		}
//		private MessageType(String color, String backgroundColor) {
//			this.color = color;
//			this.backgroundColor = backgroundColor;
//		}
//		private String color;
//		private String backgroundColor;
//		public String getColor() {
//			return color;
//		}
//		public String getBackgroundColor() {
//			return backgroundColor;
//		}
//	}

}
