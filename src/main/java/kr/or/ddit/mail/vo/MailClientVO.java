package kr.or.ddit.mail.vo;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.*;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

// 직원별 정보
@Data
@NoArgsConstructor
@AllArgsConstructor
//@ToString(exclude = {"accessToken"})
public class MailClientVO implements Serializable {
    /**
     * 토큰과 함께 들어오는, 액세스 토큰
     */
    private String accessToken = "";
    /**
     * 토큰과 함께 들어오는, 리프레시 토큰
     */
    private String refreshToken = "";

    @NotNull(groups = {InsertGroup.class, UpdateGroup.class, DeleteGroup.class})
    private String empId = "";

    private String empEmail = "";

    /**
     * 토큰과 함께 들어오는, 액세스 토큰의 유효기간(단위 : 초)
     */
    private String expiresIn = "";

    /**
     * 토큰과 함께 들어오는 권한 범위(scope)
     * 이전에 인가 요청 때, 제출한 권한 범위와 동일
     */
    private String scope ="";

    /**
     * 토큰과 함께 들어오는 토큰 유형
     * 꼭 "Bearer"이 들어와야 함
     */
    private String tokenType = "";

    /**
     * 토큰과 함께 들어오는, 토큰을 받은 날짜시간
     */
    private LocalDateTime responseDateTime;

    /**
     * MailGoogleOAuth 클래스의 getTokens에서 만들어지고 저장되는 액세스 토큰의 만료시간 지점
     * (날짜 데이터)
     */
    private LocalDateTime accessTokenExpiresAt;

    /**
     * MailGoogleOAuth 클래스의 getTokens에서 만들어지고 저장되는 액세스 토큰의 만료시간 지점
     * (날짜 데이터)
     */
    private LocalDateTime refreshTokenExpiresAt;

    /**
     * 리프레시 토큰의 유효기간 (단위 : 일日)
     */
    private int refreshTokenExpiresInDays = 180;

    /**
     * 토큰 발급 흐름 경로 확인 용
     * 재발급 : 1
     */
    private String reqTokenPath = "";


    /**
     * 인가 코드
     */
    private String code="";

    /**
     * state
     */
    private String state="";



}
