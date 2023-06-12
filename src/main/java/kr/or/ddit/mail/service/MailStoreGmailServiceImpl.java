package kr.or.ddit.mail.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.model.ListMessagesResponse;
import com.google.api.services.gmail.model.Message;
import com.google.api.services.gmail.model.MessagePartBody;
import com.google.auth.oauth2.GoogleCredentials;
import kr.or.ddit.mail.vo.MailAuthVO;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailClientVO;
import kr.or.ddit.mail.vo.MailInboxVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.inject.Inject;
import javax.mail.MessagingException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Slf4j
@Service
public class MailStoreGmailServiceImpl implements MailStoreGmailService {

    @Inject
    MailService mailService;

    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기 (받은 메일함)
     *
     * @param accessToken
     * @return 응답(String)
     */
    @Override
    public String getMessageIdListFromGmail(String accessToken) {
        // 메세지 목록  : Gmail에 요청
        String url = "https://gmail.googleapis.com/gmail/v1/users/{userId}/messages?q=in:inbox";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("userId", "me");
        String finalUrl = builder.toUriString();//쿼리 스트링이 있는 URL 완성

        // Gmail API 요청 시 기본 헤더 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(accessToken);// 엑세스 토큰 설정 헤더 //헤더 값 : `Bearer ${accessToken}`
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));// "Accept", "text/html;charset=UTF-8"
        httpHeaders.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));


        // 요청 Entity (바디, 헤더) 지정
        // 보내는 바디는 없고, 헤더만 있음
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, httpHeaders);

        // 요청-응답 보내기
        RestTemplate restTemplate = new RestTemplate();
        // 요청 보낼 url, 메서드 상수, 바디+헤더, 응답 데이터 타입
        ResponseEntity<String> responseEntity = restTemplate.exchange(finalUrl, HttpMethod.GET, requestHttpEntity, String.class);


        // 응답 바디에서 필요한 값 추출 : JSON 문자열
        String responseEntityBody = responseEntity.getBody();

        return responseEntityBody;
    }

    /**
     * 페이징용 resultSizeEstimate 추출
     *
     * @param responseJavaMap : 메일 응답 목록 -> JSON -> Map
     * @return resultSizeEstimate(int)
     */
    @Override
    public int getTotalCountFromList(Map<String, Object> responseJavaMap) {
        // 페이징용 resultSizeEstimate 추출
        int messagePagingTotal = Integer.parseInt(responseJavaMap.get("resultSizeEstimate").toString());
        return messagePagingTotal;
    }

    /**
     * 메일 구성 요소 추출
     *
     * @param responseJavaMap : 메일 응답 목록 -> JSON -> Map
     * @return messages(List < Map < String, Object > >)
     */
    @Override
    public List<Map<String, Object>> getMessagesFromList(Map<String, Object> responseJavaMap) {
        // 메일 응답 목록으로 부터 message 추출
        List<Map<String, Object>> messages = (List<Map<String, Object>>) responseJavaMap.get("messages");
        return messages;
    }

    /**
     * 메세지 식별자를 이용해서 메세지(메일) 요청하기
     *
     * @param accessToken
     * @param messageId
     * @return
     */
    @Override
    public String getEachEmailFromGmail(String accessToken, String messageId) {
        String messageUrl = "https://gmail.googleapis.com/gmail/v1/users/{userId}/messages/{id}";
        UriComponentsBuilder messagePathBuilder = UriComponentsBuilder.fromHttpUrl(messageUrl)
                .queryParam("userId", "me")
                .queryParam("id", messageId);
        String finalMessageUrl = messagePathBuilder.toUriString();//쿼리 스트링이 있는 URL 완성 ----메일 요청 경로 만들기 3 (완성)
//        log.info("○ Gmail 메일 요청 URI 만들기 : {}", finalMessageUrl);

        // Gmail API 요청 시 기본 헤더 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(accessToken);// 엑세스 토큰 설정 헤더 //헤더 값 : `Bearer ${accessToken}`
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));// "Accept", "text/html;charset=UTF-8"
        httpHeaders.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));


        // 요청 Entity (바디, 헤더) 지정
        // 보내는 바디는 없고, 헤더만 있음
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, httpHeaders);

        // 요청-응답 보내기
        RestTemplate restTemplate = new RestTemplate();
        // 요청 보낼 url, 메서드 상수, 바디+헤더, 응답 데이터 타입
        ResponseEntity<String> responseEntity = restTemplate.exchange(finalMessageUrl, HttpMethod.GET, requestHttpEntity, String.class);


        // 응답 바디에서 필요한 값 추출 : JSON 문자열
        String responseEntityBody = responseEntity.getBody();
//        log.info("메일함 요청 완료");
        return responseEntityBody;
    }


    /**
     * 첨부 파일 요청하기
     *
     * @return List<MailInboxVO>
     * @throws MessagingException
     * @throws IOException
     */
    @Override
    public MailBoxVO getAttachFromGmail(String empId, MailBoxVO eachAttachMailBoxVO) throws IOException {
        // 첨부파일 가져오기 메서드 진입
        String userId = "me";// 지메일 특수 키 : 요청 당사자 이메일 계정 필요 없음
        // 인가 키 설정
        String jsonAuthPath = "/kr/or/ddit/mailAuth/manifest-craft-386423-12b1b1bde967.json";
        InputStream jsonAuthInputStream = getClass().getClassLoader().getResourceAsStream(jsonAuthPath);

        // 1. 구글로부터 자격 얻기 + HTTP 요청 초기화
        // (1) 구글 서비스를 사용하는 애플리케이션 자격 증명 가져오기
//            GoogleCredentials credentials = GoogleCredentials.fromStream(jsonAuthInputStream).createScoped(GmailScopes.MAIL_GOOGLE_COM);
        // Gmail API를 통해 이메일 보내는 권한 얻기
        MailClientVO mailClientVO = mailService.retrieveEmailTokens(empId);
        String accessToken = mailClientVO.getAccessToken();
        GoogleCredential credentials = new GoogleCredential().setAccessToken(accessToken);
        // (2) Google의 서비스를 호출하는 HTTP 요청을 초기화 하고 구성 : 인터페이스 HttpRequestInitializer
        //HttpRequestInitializer requestInitializer = new HttpCredentialsAdapter(credentials);

        // 2. Gmail API로 Gmail 서비스를 생성
        MailAuthVO mailAuthVO = new MailAuthVO();
        Gmail gmailAPIService = new Gmail.Builder(
                new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
                GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
                credentials // HTTP 요청의 구성을 가진 객체
        )
                .setApplicationName(mailAuthVO.getOAuthApplicationName())
                .build();// Gmail 서비스 생성 완료

        // 첨부파일 요청하기 ------------------
        String messageId = eachAttachMailBoxVO.getMailMessageId();
        String attachmentId = eachAttachMailBoxVO.getMailAttachmentId();

        MessagePartBody attachPart = gmailAPIService.users().messages().attachments().get(userId, messageId, attachmentId).execute();
        String encodedString = attachPart.getData();
        byte[] fileBytes = Base64Utils.decodeFromUrlSafeString(encodedString);
        eachAttachMailBoxVO.setMailAttachmentFile(fileBytes);
//        fileList.add(eachAttachMailBoxVO);
//        }

        return eachAttachMailBoxVO;
    }


    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기(보낸 메일함)
     *
     * @param accessToken
     * @return 응답(String)
     */
    @Override
    public String getSendMessageIdListFromGmail(String accessToken) {
//        log.info("보낸메일함 message Id 요청 메서드 진입");
        // 메세지 목록  : Gmail에 요청
        String url = "https://gmail.googleapis.com/gmail/v1/users/{userId}/messages?q=in:sent";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("userId", "me");
        String finalUrl = builder.toUriString();//쿼리 스트링이 있는 URL 완성

        // Gmail API 요청 시 기본 헤더 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(accessToken);// 엑세스 토큰 설정 헤더 //헤더 값 : `Bearer ${accessToken}`
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));// "Accept", "text/html;charset=UTF-8"
        httpHeaders.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));


        // 요청 Entity (바디, 헤더) 지정
        // 보내는 바디는 없고, 헤더만 있음
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, httpHeaders);

        // 요청-응답 보내기
        RestTemplate restTemplate = new RestTemplate();
        // 요청 보낼 url, 메서드 상수, 바디+헤더, 응답 데이터 타입
        ResponseEntity<String> responseEntity = restTemplate.exchange(finalUrl, HttpMethod.GET, requestHttpEntity, String.class);


        // 응답 바디에서 필요한 값 추출 : JSON 문자열
        String responseEntityBody = responseEntity.getBody();

        return responseEntityBody;
    }

    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기
     *
     * @param accessToken
     * @return 응답(String)
     */
    @Override
    public String getDraftMessageIdListFromGmail(String accessToken) {
//        log.info("임시보관함 draft Id 요청 메서드 진입");
        // 메세지 목록  : Gmail에 요청
        String url = "https://gmail.googleapis.com/gmail/v1/users/{userId}/drafts";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("userId", "me");
        String finalUrl = builder.toUriString();//쿼리 스트링이 있는 URL 완성

        // Gmail API 요청 시 기본 헤더 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(accessToken);// 엑세스 토큰 설정 헤더 //헤더 값 : `Bearer ${accessToken}`
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));// "Accept", "text/html;charset=UTF-8"
        httpHeaders.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));


        // 요청 Entity (바디, 헤더) 지정
        // 보내는 바디는 없고, 헤더만 있음
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, httpHeaders);

        // 요청-응답 보내기
        RestTemplate restTemplate = new RestTemplate();
        // 요청 보낼 url, 메서드 상수, 바디+헤더, 응답 데이터 타입
        ResponseEntity<String> responseEntity = restTemplate.exchange(finalUrl, HttpMethod.GET, requestHttpEntity, String.class);


        // 응답 바디에서 필요한 값 추출 : JSON 문자열
        String responseEntityBody = responseEntity.getBody();

        return responseEntityBody;
    }


    /**
     * 임시보관 : 메일 구성 요소 추출
     *
     * @param responseJavaMap : 메일 응답 목록 -> JSON -> Map
     * @return messages(List < Map < String, Object > >)
     */
    @Override
    public List<Map<String, Object>> getDraftsFromList(Map<String, Object> responseJavaMap) {
        // 메일 응답 목록으로 부터 message 추출
        List<Map<String, Object>> drafts = (List<Map<String, Object>>) responseJavaMap.get("drafts");
//         임시보관 messageId 목록 받기 성공 : {
//  "drafts": [
//    {
//      "id": "r4632357381381077671",
//      "message": {
//        "id": "1886cb14d2ac274a",
//        "threadId": "1886cb1199c184b7"
//      }
//    }
//  ],
//  "resultSizeEstimate": 1
//}
        return drafts;
    }



    /**
     * 메세지 식별자를 이용해서 메세지(메일) 요청하기
     *
     * @param accessToken
     * @param draftId
     * @return
     */
    @Override
    public String getEachDraftFromGmail(String accessToken, String draftId) {
        //쿼리 스트링이 있는 URL 완성 ----메일 요청 경로 만들기 3 (완성)
        String draftUrl = "https://gmail.googleapis.com/gmail/v1/users/{userId}/drafts/{draftId}";
        String finalDraftUrl = UriComponentsBuilder.fromUriString(draftUrl).buildAndExpand("me", draftId).toUriString();
//        log.info("○ Gmail 임시보관 메일 요청 URI 만들기 : {}", finalDraftUrl);

        // Gmail API 요청 시 기본 헤더 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(accessToken);// 엑세스 토큰 설정 헤더 //헤더 값 : `Bearer ${accessToken}`
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));// "Accept", "text/html;charset=UTF-8"
        httpHeaders.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));


        // 요청 Entity (바디, 헤더) 지정
        // 보내는 바디는 없고, 헤더만 있음
        HttpEntity<?> requestHttpEntity = new HttpEntity<>(null, httpHeaders);

        // 요청-응답 보내기
        RestTemplate restTemplate = new RestTemplate();
        // 요청 보낼 url, 메서드 상수, 바디+헤더, 응답 데이터 타입
        ResponseEntity<String> responseEntity = restTemplate.exchange(finalDraftUrl, HttpMethod.GET, requestHttpEntity, String.class);


        // 응답 바디에서 필요한 값 추출 : JSON 문자열
        String responseEntityBody = responseEntity.getBody();
//        log.info("임시보관 메일 요청 완료");
        return responseEntityBody;
    }


    public List<String> getTrashMessageIdList(String accessToken) {
//        log.info("휴지통 라벨을 가진 messageId 목록 받기 메서드 진입");
        GoogleCredential googleCredential = new GoogleCredential().setAccessToken(accessToken);


//        String gmailAuthInfoPath = "/kr/or/ddit/mailAuth/client_secret_950837281368-po52i454iv9ttb38gbmp8trg6iud7ukq.apps.googleusercontent.com.json";
//        InputStream is = getClass().getClassLoader().getResourceAsStream(gmailAuthInfoPath);
//        ObjectMapper om = new ObjectMapper();
//        Map<String, String> apiAuthInfo = om.readValue(is, new TypeReference<Map<String, String>>() {
//        });
//        log.info("JSON 파일 읽어오기 Map : {}", apiAuthInfo.toString());
//        String type = apiAuthInfo.get("type");

        MailAuthVO mailAuthVO = new MailAuthVO();
        String applicationName = mailAuthVO.getOAuthApplicationName();


        // 2. Gmail API로 Gmail 서비스를 생성
        Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
                    GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
                    googleCredential // HTTP 요청의 구성을 가진 객체
                ).setApplicationName(applicationName)
                .build();// Gmail 서비스 생성 완료

        ListMessagesResponse googleResponseList = new ListMessagesResponse();// 구글 제공 객체

        List<String> trashIdList = new ArrayList<>();
        String trashMessageId = "";
        try {
            googleResponseList = gmailAPIService.users().messages().list("me").setLabelIds(Arrays.asList("TRASH")).execute();
            List<Message> messages = googleResponseList.getMessages();
            for (Message message : messages) {
                trashMessageId = message.getId();
                trashIdList.add(trashMessageId);
            }
        } catch (Exception e) {}
//        log.info("라벨 목록 : {}", trashIdList);
//        log.info("라벨 목록 : {}", trashIdList.size());


        return trashIdList;
    }


    public Message getEachTrashCanFromGmail(String accessToken, String trashId) throws IOException {
//        log.info("휴지통 메일 받기 메서드 진입");
        GoogleCredential googleCredential = new GoogleCredential().setAccessToken(accessToken);

        MailAuthVO mailAuthVO = new MailAuthVO();
        String applicationName = mailAuthVO.getOAuthApplicationName();

        // 2. Gmail API로 Gmail 서비스를 생성
        Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
                GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
                googleCredential // HTTP 요청의 구성을 가진 객체
        ).setApplicationName(applicationName)
                .build();// Gmail 서비스 생성 완료

        Message message = new Message();
        message = gmailAPIService.users().messages().get("me", trashId).execute();

//        log.info("휴지통 메일 가져오기 요청 완료 : {}", message);
        return message;
    }

}
