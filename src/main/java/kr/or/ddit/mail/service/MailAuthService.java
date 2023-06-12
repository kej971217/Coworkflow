package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailClientVO;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;

import java.io.IOException;
import java.util.Map;

public interface MailAuthService {

    /**
     * 토큰 요청을 하기 위한 데이터 준비
     * @param code
     * @return 토큰 요청 데이터(Map<String, String>)
     */
    public Map<String, Object> infoForReqTokens(String code) throws IOException;

    /**
     * 토큰 요청-응답
     * @param datasForTokens 응답 JSON 직렬화한 자바 객체
     * @return 토큰 (MailClientVO)
     */
    public MailClientVO reqTokens(Map<String, Object> datasForTokens, HttpServletRequest request, String empId);

    /**
     * 토큰 재발급 하면서 기존 정보 제거
     * @param empId
     * @return 성공 1, 실패 0
     */
    public int clearTokensTable(String empId);


    /**
     * 리프레시 토큰으로 액세스 토큰 갱신
     *
     * @param empId
     * @return String 성공 1, 실패 0
     */
    public MailClientVO getAgainAccessToken(String empId) throws IOException;

    /**
     * 토큰 흐름
     *
     * @return String 이동 URL
     */
    public String flowTokens(String empId);

    /**
     * 기능 입장 시 토큰 확인
     *
     * @return String 이동 URL, 토큰 유효 시 null
     */
    public String checkTokens(String empId);


}
