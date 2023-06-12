package kr.or.ddit.mail.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.ddit.mail.dao.MailDAO;
import kr.or.ddit.mail.vo.MailAuthVO;
import kr.or.ddit.mail.vo.MailClientVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class MailAuthServiceImpl implements MailAuthService {

    @Inject
    MailAuthService mailAuthService;

    @Inject
    private MailService mailService;

    @Inject
    private MailDAO mailDAO;

    /**
     * 토큰 요청을 하기 위한 데이터 준비
     *
     * @param code
     * @return 토큰 요청 데이터(Map<String, String>)
     */
    @Override
    public Map<String, Object> infoForReqTokens(String code) {
//        log.info("[ MailAuthServiceImpl ] : 토큰 요청 정보 모으기 ──────────────────────────────");

        // ----------------------------------------- 구글 인가 토큰 요청 정보 만들기 시작 ------------------------------------
        String gmailAuthInfoPath = "/kr/or/ddit/mailAuth/client_secret_950837281368-po52i454iv9ttb38gbmp8trg6iud7ukq.apps.googleusercontent.com.json";
        InputStream is = getClass().getClassLoader().getResourceAsStream(gmailAuthInfoPath);
        ObjectMapper om = new ObjectMapper();
        Map<String, Object> test = new HashMap<>();
        try {
            test = om.readValue(is, new TypeReference<Map<String, Object>>() {
            });
        } catch (IOException e) {
        }
//        log.info("JSON 파일 읽어오기 Map : {}", test.toString());
        Map<String, Object> googleAuthInfos = (Map<String, Object>) test.get("web");
//        log.info("구글 인가 정보 Map : {}", googleAuthInfos.toString());

        String clientId = googleAuthInfos.get("client_id").toString();
        String projectId = googleAuthInfos.get("project_id").toString();
        String authUri = googleAuthInfos.get("auth_uri").toString();
        String tokenUri = googleAuthInfos.get("token_uri").toString();
        String certUrl = googleAuthInfos.get("auth_provider_x509_cert_url").toString();
        String clientSecret = googleAuthInfos.get("client_secret").toString();
        List<String> redirectUris = (List<String>) googleAuthInfos.get("redirect_uris");
        List<String> javascriptOrigins = (List<String>) googleAuthInfos.get("javascript_origins");


        Map<String, Object> readyReqTokens = googleAuthInfos;
        readyReqTokens.put("code", code);
        readyReqTokens.put("grantType", "authorization_code");
        // ----------------------------------------- 구글 인가 토큰 요청 정보 만들기 종료 ------------------------------------

//        log.info(" 인가를 받고 토큰을 요청하기 위해 필요한 정보 확인 : {}", readyReqTokens);
        return readyReqTokens;
    }

    /**
     * 토큰 요청-응답
     * <p>
     * 토큰 전체 발급
     *
     * @param datasForTokens 토큰 응답 JSON -> 자바 객체
     * @return 토큰 (MailClientVO)
     */
    @Override
    public MailClientVO reqTokens(Map<String, Object> datasForTokens, HttpServletRequest request, String empId) {
        MailClientVO mailClientVO = new MailClientVO();
//        log.info("[ mailAuthService.reqTokens ] : 토큰 요청-응답 ──────────────────────────────");
//        log.info("1. 요청 URI 만들기");
        // ---------------------------------- 구글 인가 토큰 요청 URI 만들기 시작 -----------------------------------
        String tokenUri = datasForTokens.get("token_uri").toString();
        String clientId = datasForTokens.get("client_id").toString();
        String clientSecret = datasForTokens.get("client_secret").toString();
        String code = datasForTokens.get("code").toString();
        String grantType = datasForTokens.get("grantType").toString();
        List<String> redirectUris = (List<String>) datasForTokens.get("redirect_uris");

//        log.info("서버 포트 확인하기");
        int serverPort = request.getServerPort();// 포트번호 가져오기
//        log.info("서버 포트번호 : {}", serverPort);
        // 일치하는 포트번호를 가진 URI 찾기
        String selectedRedirectUri = null;
        for (String redirectUri : redirectUris) {
//            log.info("확인 URI : {}", redirectUri);
            URI uri = URI.create(redirectUri);// String -> URI
//            log.info("URI의 포트번호 추출 : {}", uri.getPort());
            if ((uri.getPort() == -1 && serverPort == 80) || uri.getPort() == serverPort) {
//                log.info("일치 포트 찾음");
                selectedRedirectUri = redirectUri;
//                log.info("일치 URI : {}", selectedRedirectUri);
                break;//for문 탈출
            }
        }

//        log.info("토큰 요청 uri (추가 전) : {}", tokenUri);
//        log.info("code : {}", code);
//        log.info("client_id : {}", clientId);
//        log.info("client_secret : {}", clientSecret);
//        log.info("redirect_uri : {}", selectedRedirectUri);
//        log.info("grant_type : {}", grantType);


        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(tokenUri)
                .queryParam("code", code)
                .queryParam("client_id", clientId)
                .queryParam("client_secret", clientSecret)
                .queryParam("redirect_uri", selectedRedirectUri)
                .queryParam("grant_type", grantType);
        String finalUri = uriComponentsBuilder.toUriString();// 쿼리 스트링이 있는 URI 완성
//        log.info("최종 URI : {}", finalUri);
        // ---------------------------------- 구글 인가 토큰 요청 URI 만들기 종료 -----------------------------------


//        log.info("2. 요청 Headers 만들기");
        HttpHeaders headers;
        {
            headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);//application/x-www-form-urlencoded
        }
//        log.info("요청 Headers : {}", headers);
//
//        log.info("3. 요청 Body 만들기 : body 없으므로 null");
//
//        log.info("4. 요청 Entity 만들기");
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, headers);//body는 없어서 null
//        log.info("요청 Entity : {}", requestHttpEntity);
//
//        log.info("5. 요청 보내기 - 응답 받기");
        RestTemplate restTemplate = new RestTemplate();
        // 응답 시간 LocalDateTime
        Instant tokenResponseTime = Instant.now();
        // 요청 URI, 메서드, 요청 Entity(바디, 헤더), 응답 클래스(vo로 받으면 vo객체.class)
//        log.info("요청전 확인 uri : {}", finalUri);
//        log.info("요청전 확인 entity : {}", requestHttpEntity);
        ResponseEntity<String> responseEntity = null;
        try {
            responseEntity = restTemplate.exchange(finalUri, HttpMethod.POST, requestHttpEntity, String.class);
        } catch(NullPointerException e) {return null;}
//        log.info("응답 상태 코드 : {}", responseEntity.getStatusCode());
//        log.info("응답 클래스 : {}", responseEntity.getClass());
//        log.info("유효 시간 : {}", responseEntity.getBody());
//        log.info("응답 상태 코드 : {}", responseEntity.getStatusCode());

        // 응답 시간 저장
        mailClientVO.setResponseDateTime(LocalDateTime.ofInstant(tokenResponseTime, ZoneId.systemDefault()));

//        log.info("6. 응답 상태 분류");
        if (responseEntity.getStatusCode() == HttpStatus.OK) {
//            log.info("6-1. 응답 상태 코드 : 200");
//            log.info("mailAuthService.reqTokens 요청 성공");
//
//            log.info("7. 응답 데이터 처리");
            String responseEntityBodyString = responseEntity.getBody().toString();
//            log.info("응답 데이터 : {}", responseEntity.getBody());


//            log.info("응답 데이터에서 body 부분 추출 : {}", responseEntityBodyString);
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> responseJsonMap;
            try {
                // readValue(자바 객체로 변환할 대상 데이터, 자바 객체 타입) 자바 객체로 변환
                // Map과 같은 저네릭 타입은 타입 정보를 컴파일러에게 알리기 위해 TypeReference 객체 사용 해야 함
                responseJsonMap = objectMapper.readValue(responseEntityBodyString, new TypeReference<Map<String, Object>>() {
                });
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
//            log.info("Map 객체로 변환한 JSON : {}", responseJsonMap);

//            log.info("8. 전달할 데이터 MailClientVO로 정리");
            String accessToken = responseJsonMap.get("access_token").toString();
            String expiresIn = responseJsonMap.get("expires_in").toString();
            String scope = responseJsonMap.get("scope").toString();
            String tokenType = responseJsonMap.get("token_type").toString();
            String refreshToken = "";
            try {
            refreshToken = responseJsonMap.get("refresh_token").toString();
            } catch(NullPointerException e) {
//            	log.info("리프레시 토큰 확인 에러 : {}", e);
            }
//            log.info("액세스 토큰 : {}", accessToken);
//            log.info("유효기간 : {}", expiresIn);
//            log.info("scope : {}", scope);
//            log.info("tokenType : {}", tokenType);
//            log.info("refreshToken : {}", refreshToken);
//            log.info("9. 리프레시 토큰 여부 확인");
            if (refreshToken == null && refreshToken == "") {
//                log.info("[mailAuthService.reqTokens] 9-1. 리프레시 토큰이 유효한 상태에서 토큰 재발급");
                mailClientVO.setAccessToken(accessToken);
                mailClientVO.setExpiresIn(expiresIn);
                mailClientVO.setScope(scope);
                mailClientVO.setTokenType(tokenType);
                return mailClientVO;
            } else {
//                log.info("[mailAuthService.reqTokens] 9-2. 모든 토큰 재발급");
                mailClientVO.setAccessToken(accessToken);
                mailClientVO.setExpiresIn(expiresIn);
                mailClientVO.setRefreshToken(refreshToken);
                mailClientVO.setScope(scope);
                mailClientVO.setTokenType(tokenType);
                return mailClientVO;
            }
        } else if (responseEntity.getStatusCode() == HttpStatus.UNAUTHORIZED) {
//            log.info("6-2. 응답 상태 코드 : 401");
//            log.info("액세스 토큰 만료");
            return null;
        } else {
//            log.info("6-3. 기타 상태 코드");
            return null;
        }

    }

    /**
     * 토큰 재발급 하면서 기존 정보 제거
     *
     * @param empId
     * @return 성공 1, 실패 0
     */
    @Override
    public int clearTokensTable(String empId) {
        return mailDAO.deleteEmployeeTokens(empId);
    }


    /**
     * 리프레시 토큰으로 액세스 토큰 갱신
     *
     * @param empId
     * @return String 성공 1, 실패 0
     */
    public MailClientVO getAgainAccessToken(String empId) {
//        log.info("1. 리프레시 토큰으로 액세스 토큰 재발급 메서드 진입 MailAuthServiceImpl : getAgainAccessToken()");
        String oauthInfosPath = "/kr/or/ddit/mailAuth/client_secret_950837281368-po52i454iv9ttb38gbmp8trg6iud7ukq.apps.googleusercontent.com.json";
        Map<String, Object> oauthInfosMap = new HashMap<>();
        InputStream oauthInfosInputStream = getClass().getClassLoader().getResourceAsStream(oauthInfosPath);
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            oauthInfosMap = objectMapper.readValue(oauthInfosInputStream, new TypeReference<Map<String, Object>>() {
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        Map<String, Object> readyReqTokens = new HashMap<>();
        readyReqTokens = (Map<String, Object>) oauthInfosMap.get("web");
        String tokenUri = readyReqTokens.get("token_uri").toString();
        String clientId = readyReqTokens.get("client_id").toString();
        String clientSecret = readyReqTokens.get("client_secret").toString();


        MailClientVO mailClientVO = mailDAO.selectAllAboutTokens(empId);// 이전에 토큰 발급 받으면서 DB에 등록한 정보
        String refreshToken =  mailClientVO.getRefreshToken();

        

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, Object> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("client_id", clientId);
        requestBody.add("client_secret", clientSecret);
        requestBody.add("refresh_token", refreshToken);
        requestBody.add("grant_type", "refresh_token");

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);
        LocalDateTime currentTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
        ResponseEntity<String> responseEntity = restTemplate.exchange(tokenUri, HttpMethod.POST, requestEntity, String.class);

        if (responseEntity.getStatusCode() == HttpStatus.OK) {
//            log.info("액세스 토큰 갱신 성공");
            String responseEntityBody = responseEntity.getBody();

//            log.info("2-1. 응답 JSON -> 자바객체 직렬화 하기");
            ObjectMapper objJson = new ObjectMapper();
            Map<String, Object> responseJsonMap;
            try {
                responseJsonMap = objJson.readValue(responseEntityBody, new TypeReference<Map<String, Object>>() {
                });
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }

//            log.info("자바 객체로 변환한 JSON 문자열 : {}", responseJsonMap);
//            log.info("해당 VO 객체에 담기");

            String accessToken = responseJsonMap.get("access_token").toString();
            String expiresIn = responseJsonMap.get("expires_in").toString();
            String scope = responseJsonMap.get("scope").toString();
            String tokenType = responseJsonMap.get("token_type").toString();

            mailClientVO.setAccessToken(accessToken);
            mailClientVO.setExpiresIn(expiresIn);
            mailClientVO.setScope(scope);
            mailClientVO.setTokenType(tokenType);
            mailClientVO.setResponseDateTime(currentTime);

//            log.info("vo 확인 : {}", mailClientVO);


            // 토큰 만료시간 구하기
            LocalDateTime responseDateTime = mailClientVO.getResponseDateTime();// 토큰 응답 시간
            int accessValidSec = Integer.parseInt(mailClientVO.getExpiresIn());// 액세스 토큰 유효 시간(단위 : 초)
            int refreshValidDay = mailClientVO.getRefreshTokenExpiresInDays();// 리프레시 토큰 유효 시간(단위 : 일)

//            log.info("토큰 만료시간 구하기");
            LocalDateTime accessTokenExpiresAtTime = responseDateTime.plusSeconds(accessValidSec);
//            log.info("액세스 토큰 만료일시 : {}", accessTokenExpiresAtTime);
            mailClientVO.setAccessTokenExpiresAt(accessTokenExpiresAtTime);
            LocalDateTime refreshTokenExpiresAt = responseDateTime.plusDays(refreshValidDay);
//            log.info("리프레시 토큰 만료일시 : {}", refreshTokenExpiresAt);
            mailClientVO.setRefreshTokenExpiresAt(refreshTokenExpiresAt);

            mailClientVO.setEmpId(empId);
            mailClientVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));

//            log.info(" DB 등록 전 VO 확인 : {}", mailClientVO);
           

            return mailClientVO;

        } else {
//            log.info("액세스 토큰 갱신 실패");
            return null;
        }
    }

    /**
     * 토큰 흐름
     *
     * @return String 이동 URL
     */
    public String flowTokens(String empId) {
        MailClientVO mailClientVO = new MailClientVO();
        MailAuthVO mailAuthVO = new MailAuthVO();

        // DB 토큰 흐름
//        log.info("─────────────── 토큰 흐름 시작 ───────────────");
//        log.info("(1) 해당 직원의 웹 어플리케이션 ID 여부 확인 - MailClient 테이블(토큰 정보 가짐)");
        int being = mailService.retrieveTokenForCheckBeing(empId);
        if (being == 0) {
//            log.info("(1-1) none : EmpId 없음 = 최초 발급");
//            log.info("토큰이 없으므로 발급 받으러 가기");
            return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
        } else {
//            log.info("(1-2) one : 최초 발급이 아닌 경우");
            int accessTokenResult = mailService.retrieveToCheckAccessToken(empId);
//            log.info("(2) 액세스 토큰 확인");
            MailClientVO tokenVO = new MailClientVO();
            if (accessTokenResult == 0) {
//                log.info("(2-1) none : 직원 ID는 있지만 액세스 토큰이 없는 경우");
//                log.info("(3) 리프레시 토큰 확인");
                int refreshTokenResult = mailService.retrieveToCheckRefreshToken(empId);
                if (refreshTokenResult == 0) {
//                    log.info("(3-1) none : 리프레시 토큰이 없는 경우");
//                    log.info("토큰이 없으므로 발급 받으러 가기");

                    return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                } else {
//                    log.info("(3-2) one : 리프레시 토큰이 있는 경우");

                    Instant instant = Instant.now();
                    LocalDateTime currentDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());//현재 시스템 기반 시간
                    mailClientVO = mailService.retrieveEmailTokens(empId);
                    LocalDateTime refreshTokenExpiresAt = mailClientVO.getRefreshTokenExpiresAt();
                    LocalDateTime accessTokenExpiresAt = mailClientVO.getAccessTokenExpiresAt();

//                    log.info("(4) 리프레시 토큰 시간 확인");

                    if (
                            refreshTokenExpiresAt.equals(currentDateTime)
                                    || refreshTokenExpiresAt.isBefore(currentDateTime)
                    ) {
//                        log.info("(4-1) none : 리프레시 토큰의 만료시간이 되었거나, 지난 경우");
//                        log.info("토큰 재발급 받으러 가기");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else if (refreshTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                        log.info("(4-2) none : 리프레시 토큰 유효기간이 1일 이내로 남은 경우");
//                        log.info("리프레시 토큰을 재발급 받으러 가기 = 액세스 토큰까지 재발급 필요");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else {
//                        log.info("(4-3) one : 리프레시 토큰 유효기간이 1일 이상으로 남은 경우");
//                        log.info("(5) 액세스 토큰 시간 확인");


                        if (
                                accessTokenExpiresAt.equals(currentDateTime)
                                        || accessTokenExpiresAt.isAfter(currentDateTime)
                        ) {
//                            log.info("(5-1) none : 액세스 토큰의 만료시간이 되었거나, 지난 경우");
//                            log.info("액세스 토큰 재발급");
                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);
                            // DB 저장 필요
                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");

                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else if (accessTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                            log.info("(5-2) none : 유효기간이 10분 이내로 남은 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-2)-1.액세스 토큰 성공 -> 이동 필요");
                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-2)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else {
//                            log.info("(5-3) one : 유효기간이 10분 이상으로 남은 경우");

                            return "OK";//내부 URL 리다이렉트
                        }
                    }
                }
            } else {
//                log.info("(2-2) one : 직원 ID는 있고, 액세스 토큰이 있는 경우");
//                log.info("(3) 리프레시 토큰 확인");
                int refreshTokenResult = mailService.retrieveToCheckRefreshToken(empId);
                if (refreshTokenResult == 0) {
//                    log.info("(3-1) none : 리프레시 토큰이 없는 경우");
//                    log.info("토큰이 없으므로 발급 받으러 가기");

                    return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                } else {
//                    log.info("(3-2) one : 리프레시 토큰이 있는 경우");

                    Instant instant = Instant.now();
                    LocalDateTime currentDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());//현재 시스템 기반 시간
                    mailClientVO = mailService.retrieveEmailTokens(empId);

//                    log.info("null 확인 : {}", mailClientVO);

                    LocalDateTime refreshTokenExpiresAt = mailClientVO.getRefreshTokenExpiresAt();
                    LocalDateTime accessTokenExpiresAt = mailClientVO.getAccessTokenExpiresAt();
//                    log.info("(4) 리프레시 토큰 시간 확인");
                    if (
                            refreshTokenExpiresAt.equals(currentDateTime)
                                    || refreshTokenExpiresAt.isBefore(currentDateTime)
                    ) {
//                        log.info("(4-1) none : 리프레시 토큰의 만료시간이 되었거나, 지난 경우");
//                        log.info("토큰 재발급 받으러 가기");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else if (refreshTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                        log.info("(4-2) none : 리프레시 토큰 유효기간이 1일 이내로 남은 경우");
//                        log.info("리프레시 토큰을 재발급 받으러 가기 = 액세스 토큰까지 재발급 필요");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else {
//                        log.info("(4-3) one : 리프레시 토큰 유효기간이 1일 이상으로 남은 경우");
//                        log.info("(5) 액세스 토큰 시간 확인");

                        if (
                                accessTokenExpiresAt.equals(currentDateTime)
                                        || accessTokenExpiresAt.isBefore(currentDateTime)
                        ) {
//                            log.info("(5-1) none : 액세스 토큰의 만료시간이 되었거나, 지난 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");

                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else if (accessTokenExpiresAt.isEqual(currentDateTime.plusMinutes(10))) {
//                            log.info("(5-2) none : 액세스 토큰 유효기간이 10분 이내로 남은 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-2)-1.액세스 토큰 성공 -> 이동 필요");
                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                ``````og.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }
                        } else {
//                            log.info("(5-3) one : 유효기간이 10분 이상으로 남은 경우");

                            return "OK";//내부 URL 리다이렉트
                        }
                    }
                }
            }
        }
    }

    ;

    /**
     * 기능 입장 시 토큰 확인
     *
     * @return String 이동 URL, 토큰 유효 시 null
     */
    public String checkTokens(String empId) {
        MailClientVO mailClientVO = new MailClientVO();
        MailAuthVO mailAuthVO = new MailAuthVO();

        // DB 토큰 흐름
//        log.info("─────────────── 토큰 흐름 시작 ───────────────");
//        log.info("(1) 해당 직원의 웹 어플리케이션 ID 여부 확인 - MailClient 테이블(토큰 정보 가짐)");
        int being = mailService.retrieveTokenForCheckBeing(empId);
//        log.info("토큰 존재 확인 : {}", being);
        if (being == 0) {
//            log.info("(1-1) none : EmpId 없음 = 최초 발급");
//            log.info("토큰이 없으므로 발급 받으러 가기");
            return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
        } else {
//            log.info("(1-2) one : 최초 발급이 아닌 경우");
            int accessTokenResult = mailService.retrieveToCheckAccessToken(empId);
//            log.info("(2) 액세스 토큰 확인");
            MailClientVO tokenVO = new MailClientVO();
            if (accessTokenResult == 0) {
//                log.info("(2-1) none : 직원 ID는 있지만 액세스 토큰이 없는 경우");
//                log.info("(3) 리프레시 토큰 확인");
                int refreshTokenResult = mailService.retrieveToCheckRefreshToken(empId);
                if (refreshTokenResult == 0) {
//                    log.info("(3-1) none : 리프레시 토큰이 없는 경우");
//                    log.info("토큰이 없으므로 발급 받으러 가기");

                    return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                } else {
//                    log.info("(3-2) one : 리프레시 토큰이 있는 경우");

                    Instant instant = Instant.now();
                    LocalDateTime currentDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());//현재 시스템 기반 시간
                    mailClientVO = mailService.retrieveEmailTokens(empId);
                    LocalDateTime refreshTokenExpiresAt = mailClientVO.getRefreshTokenExpiresAt();
                    LocalDateTime accessTokenExpiresAt = mailClientVO.getAccessTokenExpiresAt();

//                    log.info("(4) 리프레시 토큰 시간 확인");

                    if (
                            refreshTokenExpiresAt.equals(currentDateTime)
                                    || refreshTokenExpiresAt.isBefore(currentDateTime)
                    ) {
//                        log.info("(4-1) none : 리프레시 토큰의 만료시간이 되었거나, 지난 경우");
//                        log.info("토큰 재발급 받으러 가기");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else if (refreshTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                        log.info("(4-2) none : 리프레시 토큰 유효기간이 1일 이내로 남은 경우");
//                        log.info("리프레시 토큰을 재발급 받으러 가기 = 액세스 토큰까지 재발급 필요");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else {
//                        log.info("(4-3) one : 리프레시 토큰 유효기간이 1일 이상으로 남은 경우");
//                        log.info("(5) 액세스 토큰 시간 확인");


                        if (
                                accessTokenExpiresAt.equals(currentDateTime)
                                        || accessTokenExpiresAt.isAfter(currentDateTime)
                        ) {
//                            log.info("(5-1) none : 액세스 토큰의 만료시간이 되었거나, 지난 경우");
//                            log.info("액세스 토큰 재발급");
                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);
                            // DB 저장 필요
                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");

                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else if (accessTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                            log.info("(5-2) none : 유효기간이 10분 이내로 남은 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");
                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else {
//                            log.info("(5-3) one : 유효기간이 10분 이상으로 남은 경우");

                            return "OK";//내부 URL 리다이렉트
                        }
                    }
                }
            } else {
//                log.info("(2-2) one : 직원 ID는 있고, 액세스 토큰이 있는 경우");
//                log.info("(3) 리프레시 토큰 확인");
                int refreshTokenResult = mailService.retrieveToCheckRefreshToken(empId);
//                log.info("리프레시 토큰 존재 : {}", refreshTokenResult);
                if (refreshTokenResult == 0) {
//                    log.info("(3-1) none : 리프레시 토큰이 없는 경우");
//                    log.info("토큰이 없으므로 발급 받으러 가기");

                    return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                } else {
//                    log.info("(3-2) one : 리프레시 토큰이 있는 경우");

                    Instant instant = Instant.now();
                    LocalDateTime currentDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());//현재 시스템 기반 시간
                    mailClientVO = mailService.retrieveEmailTokens(empId);

//                    log.info("null 확인 : {}", mailClientVO);

                    LocalDateTime refreshTokenExpiresAt = mailClientVO.getRefreshTokenExpiresAt();
                    LocalDateTime accessTokenExpiresAt = mailClientVO.getAccessTokenExpiresAt();
//                    log.info("(4) 리프레시 토큰 시간 확인");
                    if (
                            refreshTokenExpiresAt.equals(currentDateTime)
                                    || refreshTokenExpiresAt.isBefore(currentDateTime)
                    ) {
//                        log.info("(4-1) none : 리프레시 토큰의 만료시간이 되었거나, 지난 경우");
//                        log.info("토큰 재발급 받으러 가기");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else if (refreshTokenExpiresAt.isEqual(currentDateTime.plusDays(1))) {
//                        log.info("(4-2) none : 리프레시 토큰 유효기간이 1일 이내로 남은 경우");
//                        log.info("리프레시 토큰을 재발급 받으러 가기 = 액세스 토큰까지 재발급 필요");

                        return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                    } else {
//                        log.info("(4-3) one : 리프레시 토큰 유효기간이 1일 이상으로 남은 경우");
//                        log.info("(5) 액세스 토큰 시간 확인");

                        if (
                                accessTokenExpiresAt.equals(currentDateTime)
                                        || accessTokenExpiresAt.isBefore(currentDateTime)
                        ) {
//                            log.info("(5-1) none : 액세스 토큰의 만료시간이 되었거나, 지난 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");

                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }

                        } else if (accessTokenExpiresAt.isEqual(currentDateTime.plusMinutes(10))) {
//                            log.info("(5-2) none : 액세스 토큰 유효기간이 10분 이내로 남은 경우");
//                            log.info("액세스 토큰 재발급");

                            try {
                                tokenVO = mailAuthService.getAgainAccessToken(empId);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            tokenVO.setEmpEmail(mailService.retrieveEmployeeEmailAddress(empId));
                            tokenVO.setEmpId(empId);
//                            log.info(" 액세스 토큰 재발급 후 DB 등록 전 VO 확인 : {}", tokenVO);

                            if (Optional.ofNullable(tokenVO).isPresent()) {
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 아닌 경우");
//                                log.info("(5-1)-1.액세스 토큰 성공 -> 이동 필요");
                                int result = mailService.updateEmailTokens(tokenVO);
                                if (result == 1) {
                                    return "OK";
                                } else {
                                    return "redirect:/";
                                }
                            } else {
//                                log.info("(5-1)-2.액세스 토큰 실패 -> 인가 발급");
//                                log.info("[MailAuthServiceImpl.flowTokens] 액세스 토큰 요청 결과 null 인 경우");
                                return "redirect:/mail/authorization/authorizationRequest.do";//내부 URL 리다이렉트
                            }
                        } else {
//                            log.info("(5-3) one : 유효기간이 10분 이상으로 남은 경우");

                            return "OK";
                        }
                    }
                }
            }
        }
    }


}
