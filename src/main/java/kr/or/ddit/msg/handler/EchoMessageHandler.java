package kr.or.ddit.msg.handler;

import java.util.Map;
import java.util.UUID;

import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.msg.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class EchoMessageHandler {
	
	@MessageMapping("/handledEcho")
	@SendTo("/topic/echoed")
	public MessageVO handler(@Payload MessageVO messageVO, @Header String id) {
	log.error("id header : {}", id);
	log.error("sender : {}, message : {}", messageVO.getEmpId(), messageVO.getMsgContent());
	
	return messageVO;
	//messagingTemplate.convertAndSend("/topic/echoed", messageVO);
	} 
	
	// destination 이 /app/handledEcho 인 구독 요청에 대해 동작하며, 
	// 한번의 요청에 한번의 응답만을 처리하게 됨.
	@SubscribeMapping("/handledEcho")
	public String subscribeHandler(
	@Headers Map<String, Object> headers
	) {
	log.info("headers : {}", headers);
	
	// subscription id 를 생성함.
	String sub_id = UUID.randomUUID().toString();
	return sub_id;
	}
}
