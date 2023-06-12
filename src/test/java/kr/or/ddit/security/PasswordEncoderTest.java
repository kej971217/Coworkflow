package kr.or.ddit.security;

import javax.inject.Inject;

import org.junit.Test;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.or.ddit.AbstractModelLayerTest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordEncoderTest extends AbstractModelLayerTest{
//	@Inject
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
	@Test
	public void encodeTest() {
		String plain = "a100016";
		// encrypt(암호화)/ decrypt vs encode(부호화) / decode
		// 인크립트 누군가가 읽을 수 없게 하기 위한것. 권한이 있는 사람만이 읽을수 있도록 하는것. 키를 소유하고 있지 않은 사람은 데이터에 접근 못함.
		// vs 인코드 누군가가 읽을 수 있게 하는것.  인코드 누구나 할수 있음.
		String encoded = encoder.encode(plain);
		log.info("encoded password : {}", encoded);
		
		String saved = "{bcrypt}$2a$10$BRQwuH2kZf991kZ6LqsvoeHMnzAEaU9Sp4rRnufWTtDPAIZGcxkkO";
		log.info("인증 성공 여부 : {}", encoder.matches(plain, saved));
	}
}
