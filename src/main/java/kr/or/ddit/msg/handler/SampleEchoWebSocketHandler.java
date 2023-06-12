package kr.or.ddit.msg.handler;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.messaging.simp.stomp.StompHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import kr.or.ddit.employee.vo.EmployeeVOWrapper;
import kr.or.ddit.msg.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SampleEchoWebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("연결 수립 : {}", session);
		sessionList.add(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("연결 종료 : {}", session);
		sessionList.remove(session);
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.error(exception.getMessage(), exception);
	}
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String realMsg = message.getPayload();
		Authentication authentication = (Authentication) session.getPrincipal();
		
		String sender = authentication.getName();
		LocalDateTime msgDate = LocalDateTime.now();
		MessageVO messageVO = new MessageVO(sender, realMsg, msgDate);
		String jsonPayload = new ObjectMapper().registerModules(new JavaTimeModule()).writeValueAsString(messageVO);
		
		 // STOMP 헤더 처리
        StompHeaders stompHeaders = new StompHeaders();
        stompHeaders.setDestination("/topic/messages");
        stompHeaders.setSession(session.getId());

        // STOMP 페이로드 처리
        TextMessage stompMessage = new TextMessage(jsonPayload);

        // STOMP 메시지 전송
        for (WebSocketSession session1 : sessionList) {
            session1.sendMessage(stompMessage);
        }
		
//		sessionList.forEach((ws)->{
//			try {
//				ws.sendMessage(new TextMessage(jsonPayload));
//			} catch (IOException e) {
//				throw new RuntimeException(e);
//			}
//		});
	}
}


















