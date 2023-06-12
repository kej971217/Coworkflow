package kr.or.ddit.mail.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 웹 어플리케이션을 인가받기 위하여 OAuth 2.0 서버에 보내는 공통 요소 매개변수 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = {"oAuthClientId", "oAuthClientSecret", "scope"})
public class MailAuthVO implements Serializable {
    /**
     * The O auth application name.
     */
    private String oAuthApplicationName = "Coworkflow";
    /**
     * The O auth client id. 인가 정보. oAuthClientId와 함께 사용하여 보안 확보.
     */
    @JsonIgnore
    @NotNull
    private String oAuthClientId = "950837281368-po52i454iv9ttb38gbmp8trg6iud7ukq.apps.googleusercontent.com";
    /**
     * The O auth client secret. 인가 정보. oAuthClientSecret과 함께 사용하여 보안 확보.
     */
    @JsonIgnore
    @NotNull
    private String oAuthClientSecret = "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";
    /**
     * The Web client uri. 기본 홈페이지 주소
     */
    @NotNull
    private String webClientURI = "http://localhost:8880";
    /**
     * Scope : 권한 범위.
     * 메일에 대한 모든 권한이 필요함.
     */
    @JsonIgnore
    @NotNull
    private String scope = "https://mail.google.com/";

    /**
     * 최초 인가 요청하러 시작하는 경로
     */
//    @NotNull
    //String redirectUrlAuthReq = "http://localhost:8880/Coworkflow/mail/authorization/authorizationRequest.do";

    /**
     * 인가 코드 받고 토큰 요청하러 가는 경로
     */
//    @NotNull
//    private String redirectUrlAuthCodeTokenReq =  "http://localhost:8880/Coworkflow/mail/authorization/oauth2callback.do";

    /**
     * 토큰 받고 Gmail에 접근하러 가는 경로
     */
//    @NotNull
    //String redirectUrlGetTokenToGmail = "http://localhost:8880/Coworkflow/mail/authorization/tokenCallback.do";


    /**
     * authorization(인가)을 요청하기 위한 주소
     * 구글 인가 서버 URL
     */
    @NotNull
    private String authUri = "https://accounts.google.com/o/oauth2/auth";

    /**
     * authorization(인가) 이후 토큰 발급을 위해 이동할 주소
     */
    @NotNull
    private String tokenUri = "https://oauth2.googleapis.com/token";

    /**
     * Google API 인증 서비스로부터 인증 공급자의 인증서를 가져오기 위한 URL
     * - 인증서 : 서비스 계정의 공개 키를 인증하기 목적
     */
//    @NotNull
//    private String certs = "https://www.googleapis.com/oauth2/v1/certs";


    @NotNull
    private String accessType = "offline";

    @NotNull
    private String responseType = "code";

    /*yubaekdan@gmail.com

            asdfqwer=09


            --------------
            coworkflow2023@gmail.com

            testtest@33

            */
    @NotNull
    private String employeeMailAddress;

}
