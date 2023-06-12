package kr.or.ddit.mail.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.model.Draft;
import com.google.api.services.gmail.model.Message;
import com.google.api.services.gmail.model.MessagePart;
import com.google.api.services.gmail.model.MessagePartHeader;
import kr.or.ddit.mail.dao.MailDAO;
import kr.or.ddit.mail.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.*;
import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Service
public class MailServiceImpl implements MailService {
	@Inject
	MailDAO mailDAO;

	@Inject
	MailService mailService;

	@Inject
	MailStoreGmailService mailStoreGmailService;

	@Inject
	MailCacheAddressOfEmployeeService mailCacheAddressOfEmployeeService;

	@Inject
	MailCacheInfoAboutTeam mailCacheInfoAboutTeam;

	@Inject
	MailCacheInfoAboutProject mailCacheInfoAboutProject;

	/**
	 * DB에서 해당 최종 사용자에게 발급된 토큰들을 가져오기.
	 *
	 * @param empId
	 * @return
	 */
	public int retrieveEmployeeToken(String empId) {
//        MailClientVO clientVO = new MailClientVO();
		// sql에서 가져와야 함 // 아직 EmployeeInfoVO 가 생성 안됨 2023.05.06
		int token = 0;
		// 토큰을 최초 발급해야 하는지, 재 발급받아야 하는지 확인
		int result = mailDAO.selectToCheckFirstAccess(empId);
		if (result == 1) {
			// 토큰 존재
			MailClientVO mailClientVO = mailDAO.selectAllAboutTokens(empId);

			String clientAccessToken = mailClientVO.getAccessToken();
			String clientRefreshToken = mailClientVO.getRefreshToken();

			Map<String, String> employeeTokens = new HashMap<>();
			employeeTokens.put("accessToken", clientAccessToken);
			employeeTokens.put("refreshToken", clientRefreshToken);

			String employeeAccessToken = employeeTokens.get("accessToken");
			String employeeRefreshToken = employeeTokens.get("refreshToken");

			// 액세스 토큰이 없음 : 인가 처음부터 받으러 가기
			if (employeeAccessToken == null || employeeAccessToken == "") {
//                log.info("액세스 토큰 : {}", employeeAccessToken);
				token = 0;
				return token;
			} else if (employeeRefreshToken == null || employeeRefreshToken == "") {
				// 액세스 토큰은 있지만, 리프레시 토큰이 없음 : 인가 처음부터 받으러 가기
//                log.info("액세스 토큰 : {} │ 리프레시 토큰 : {}", employeeAccessToken, employeeRefreshToken);
				token = 0;
				return token;
				// } else if () {

			} else {
				// 토큰 발급까지 테스트한 뒤 작성 필요
				// 1. 만료기간 확인하고 만료되었으면, 인가 처음부터 받으러가기 token = 0;
				// 2. 만료기간 확인하고 유효하면, 페이지로 넘어가기; token = 1;
				return token;
			}

		}
		return token;
	}

	/**
	 * 최종 사용자의 웹 어플리케이션 ID를 입력하여, 최종 사용자의 구글 계정(이메일 주소)를 리턴 받는다.
	 *
	 * @param empId
	 * @return String 타입, 이메일 주소
	 */
	@Override
	public String retrieveEmployeeEmailAddress(String empId) {
//        log.info("ServiceImpl : 이메일 주소 조회");
		MailClientVO mailClientVO = new MailClientVO();
		mailClientVO.setEmpEmail(mailDAO.selectEmployeeEmailAddress(empId));
		return mailClientVO.getEmpEmail();
	}

	/**
	 * 최종 사용자의 웹 어플리케이션 ID를 통해, 메일 기능 최초 접근(구글 인가 서버로부터 토큰 발급) 확인
	 *
	 * @param empId
	 * @return 최초 접근(토큰 없음) : 0, 재 접근(토큰 있음) : 1
	 */
	@Override
	public int retrieveTokenForCheckBeing(String empId) {
		int result = 0;
		result = mailDAO.selectToCheckFirstAccess(empId);
		return result;
	}

	/**
	 * < 구글 OAuth 서버로부터 받은 최초 토큰(인가) 처리 > 최종 사용자의 웹 어플리케이션 ID과 함께, 액세스 토큰, 리프레시 토큰을
	 * 비롯한 토큰 관련 정보를 MailClientVO에 담아서 DB의 해당 테이블(MAIL_CLIENT)에 저장한다.
	 *
	 * @param mailClientVO
	 * @return
	 */
	@Override
	public int createEmailTokens(MailClientVO mailClientVO) {
		// 해당 테이블에 직원의 웹 어플리케이션 ID 자체가 등록되어있지 않다는 점은,
		// 토큰 발급 흐름에서 확인함.
		return mailDAO.insertEmployeeTokens(mailClientVO);
	}

	/**
	 * 최종 사용자의 웹 어플리케이션 ID를 통해, 최종 사용자에게 발급된 토큰 및 토큰 정보들 가져오기
	 *
	 * @param empId
	 * @return
	 */
	@Override
	public MailClientVO retrieveEmailTokens(String empId) {
//        log.info(" 토큰 정보 가져오기 MailServiceImpl : retrieveEmailTokens");
		MailClientVO mailClientVO = mailDAO.selectAllAboutTokens(empId);

		if (Optional.ofNullable(mailClientVO).isPresent()) {
//            log.info("DB에 토큰 정보 있음");
			return mailClientVO;
		} else {
//            log.info("DB에 토큰 정보 없음");
			return null;
		}

	}

	/**
	 * - 토큰 발급 흐름용 - 액세스 토큰 여부 확인
	 *
	 * @param empId
	 * @return 토큰 있음 : 1, 없음 : 0
	 */
	@Override
	public int retrieveToCheckAccessToken(String empId) {
		return mailDAO.selectAccessToken(empId);
	}

	/**
	 * - 토큰 발급 흐름용 - 리프레시 토큰 여부 확인
	 *
	 * @param empId
	 * @return 토큰 있음 : 1, 없음 : 0
	 */
	@Override
	public int retrieveToCheckRefreshToken(String empId) {
		return mailDAO.selectRefreshToken(empId);
	}

	/**
	 * < 구글 인가 서버의 토큰 재 발급 > 구글 인가 서버로부터 발급받은 토큰 및 토큰 정보를 DB의 MailClient 테이블에 저장
	 *
	 * @param mailClientVO
	 * @return 등록 성공 : 1, 등록 실패 : 0
	 */
	@Override
	public int updateEmailTokens(MailClientVO mailClientVO) {
//        log.info("토큰 재발급 Service : Update 진입");
//        log.info("파라미터 확인 : {}", mailClientVO);

		String empId = mailClientVO.getEmpId();
//        log.info("삭제 전 empId 확인 : {}", empId);
		if (empId != null && !empId.equals("")) {
			if (mailDAO.deleteEmployeeTokens(empId) == 1) {
//                log.info("기존 토큰 정보(a Record) 삭제 성공");
				if (mailDAO.selectToCheckFirstAccess(empId) == 0) {
//                    log.info("MailClient 테이블에 정보 없음을 확인");
					if (mailDAO.insertEmployeeTokens(mailClientVO) == 1) {
//                        log.info("MailClient 테이블에 정보 입력 확인");
						return 1;
					} else {
//                        log.info("MailClient 테이블에 정보 입력 실패");
						return 0;
					}
				} else {
//                    log.info("MailClient 테이블에 정보 있음을 확인");
					return 0;
				}
			} else {
//                log.info("기존 토큰 정보(a Record) 삭제 실패");
				return 0;
			}
		} else {
//            log.info("empId null");
			return 0;
		}

	}

	/**
	 * 최종 사용자의 이름 가져오기
	 *
	 * @param empId
	 * @return
	 */
	@Override
	public String retrieveEmployeeName(String empId) {
		return mailDAO.selectEmployeeName(empId);
	}

	/**
	 * - 토큰 흐름용- 리프레시 토큰이 유효한 상태에서 액세스 토큰 재발급 받은 경우 리프레시 토큰, 리프레시 토큰 만료 시간
	 *
	 * @param empId
	 * @return MailClientVO 리프레시 토큰, 리프레시 토큰 만료시간
	 */
	@Override
	public MailClientVO retrieveAllAboutRefreshToken(String empId) {
		return mailDAO.selectAllAboutRefreshToken(empId);
	}

	/**
	 * 이메일 계정 전체 불러오기
	 *
	 * @return MailSendVO
	 */
	@Override
	public Map<String, Object> retrieveClickAllAboutEmailAddressInfo() {
//        log.info("[MailServiceImpl] 이메일 조회 진입");
		List<MailSendVO> employeeInfo = mailDAO.selectAllEmployeeInfo();// 모든 직원 조회

		// 반환용
		List<MailSendVO> empInfoList = new ArrayList<>();
		List<MailSendVO> teamInfo = new ArrayList<>();
		List<List<MailSendVO>> projectInfo = new ArrayList<>();
		for (MailSendVO emp : employeeInfo) {// 직원 전체 조회
			String empId = emp.getEmpId();
			MailSendVO temp = mailDAO.selectEmailOfEmp(empId);
			empInfoList.add(temp);
		}
		for (MailSendVO temp : employeeInfo) {// 계정 있는 직원 전체 for문
			if (temp.getInfoEmail() != null) {
				MailSendVO empBeingVO = new MailSendVO();
				empBeingVO.setEmpId(temp.getEmpId());
				empBeingVO.setEmpName(temp.getEmpName());
				empBeingVO.setInfoEmail(temp.getInfoEmail());
				empInfoList.add(empBeingVO);

				// 이메일 있는 팀 조회
				MailSendVO teamVO = mailDAO.selectEmailOfTeam(temp.getEmpId());
				teamInfo.add(teamVO);

				// empId 하나 당, 프로젝트 여러 개인 경우 있으므로 List
				List<MailSendVO> projects = mailDAO.selectEmailOfProject(temp.getEmpId());
				projectInfo.add(projects);
			}
		}
//        log.info("직원 정보 조회 : {}", empInfoList);
//        log.info("본부 및 팀 정보 조회 : {}", teamInfo);
//        log.info("프로젝트 정보 조회: {}", projectInfo);

		Map<String, Object> mailMap = new HashMap<>();
		mailMap.put("empEmails", empInfoList);
		mailMap.put("teamEmails", teamInfo);
		mailMap.put("projectEmails", projectInfo);

		return mailMap;
	}

	/**
	 * 프로젝트 전체 조회
	 *
	 * @return List<MailSendVO>
	 */
	@Override
	public List<MailSendVO> retrieveProject() {
		return mailDAO.selectAllProjectInfo();
	}

	/**
	 * 직원 전체 조회
	 *
	 * @return List<MailSendVO>
	 */
	@Override
	public List<MailSendVO> retrieveEmp() {
		return mailDAO.selectAllEmployeeInfo();
	}

	/**
	 * 팀 전체 조회
	 *
	 * @return List<MailSendVO>
	 */
	@Override
	public List<MailSendVO> retrieveTeam() {
		return mailDAO.selectAllTeamInfo();
	}

	/**
	 * 이메일을 가진 전체 직원 조회
	 *
	 * @return empId, empName, infoEmail (List<MailSendVO>)
	 */
	@Override
	public List<MailSendVO> retrieveEmpBeingEmails() {
		return mailDAO.selectEmpBeingEmail();
	}

	/**
	 * @return 인가정보 JSON 문자열
	 */
	@Override
	public Map<String, String> authJsonForSending(String userId) throws IOException {
		MailAuthVO mailAuth = new MailAuthVO();
		Map<String, Object> jsonMap = new HashMap<>();
		// ----------------------------------------- 구글 인가 요청 URI 만들기 시작
		// ------------------------------------
		String gmailAuthInfoPath = "/kr/or/ddit/mailAuth/manifest-craft-386423-12b1b1bde967.json";
		InputStream is = getClass().getClassLoader().getResourceAsStream(gmailAuthInfoPath);
		ObjectMapper om = new ObjectMapper();
		Map<String, String> apiAuthInfo = om.readValue(is, new TypeReference<Map<String, String>>() {
		});
//        log.info("JSON 파일 읽어오기 Map : {}", apiAuthInfo.toString());

		String type = apiAuthInfo.get("type");
		String projectId = apiAuthInfo.get("project_id");
		String privateKeyId = apiAuthInfo.get("private_key_id");
		String privateKey = apiAuthInfo.get("private_key");
		String clientEmail = apiAuthInfo.get("client_email");
		String clientId = apiAuthInfo.get("client_id");
		String authUri = apiAuthInfo.get("auth_uri");
		String tokenUri = apiAuthInfo.get("token_uri");
		String certUrl = apiAuthInfo.get("auth_provider_x509_cert_url");
		String clientX509CertUrl = apiAuthInfo.get("client_x509_cert_url");
		String universeDomain = apiAuthInfo.get("universe_domain");

		// ----------------------------------------- 구글 인가 요청 URI 만들기 종료
		// ------------------------------------

		return apiAuthInfo;
	}

	/**
	 * 메일 전송
	 *
	 * @return 성공 후 이동 경로
	 */
	@Override
	public Message sendReadyWithAttach(MailSendVO mailSendVO) throws MessagingException, IOException {
//        List<String> addressToList, String subjectParam, String mailContentParam, MultipartFile[] mailFile, String empId
		List<String> addressToList = mailSendVO.getMailSendToList();
		String mailSendSubject = mailSendVO.getMailSendSubject();
		String mailSendContent = mailSendVO.getMailSendContent();
		MultipartFile[] mailFileList = mailSendVO.getFileList();
		String empId = mailSendVO.getEmpId();

//        log.info("[MailService] [sendReadyWithAttach] 메일 전송 메서드 진입");
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
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		MimeMessage emailMimeMessage = new MimeMessage(session);// (3) MIME 형식으로, 이메일의 주요 구성 요소인 발신자, 수신자, 제목, 본문 등을
		// 설정하는 객체

		// (3)-1. 발신자 설정
		emailMimeMessage.setFrom(new InternetAddress("me"));
		// (3)-2. 수신자 설정
		for (String address : addressToList) {
			// 파라미터 2개 : 수신 유형, 이메일 계정
			emailMimeMessage.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(address));
		}

		// (InternetAddress) : 이메일 주소 나타내는 객체 : 이메일 주소가 올바른 형식인지 확인 기능, 이름+이메일로 처리하는 기능.

		// (3)-3. 제목 설정
		emailMimeMessage.setSubject(mailSendSubject);

		// (3)-4. 본문 설정
		MimeBodyPart mimeBodyPart = new MimeBodyPart();// 메시지 일부분 : 본문, 첨부파일
		// 파라미터 2개 : 본문, 본문의 MIME 유형
		mimeBodyPart.setContent(mailSendContent, "text/html;charset=UTF-8");

		// 본문을 Multipart에 담기
		Multipart multipart = new MimeMultipart();// 이메일 메시지에 포함되는 여러 개의 본문 부분을 포함하는 객체
		multipart.addBodyPart(mimeBodyPart); // 본문 설정한 mimeBodyPart 객체 추가

		// (3)-5. 첨부 파일 설정
		List<DataSource> dataSourceList = new ArrayList<>();
		for (MultipartFile multipartFile : mailFileList) {
			if (!multipartFile.isEmpty()) {
				// MultipartFile -> File 변환
				File file = new File(multipartFile.getOriginalFilename());// 업로드된 파일의 원본명 가져오기(확장자 포함)

				// File 객체로 변환하기
				multipartFile.transferTo(file);
				DataSource dataSource = new FileDataSource(file);// 첨부파일
				dataSourceList.add(dataSource);
			}
		}

		if (!dataSourceList.isEmpty()) {
			for (DataSource dataSource : dataSourceList) {
				MimeBodyPart mimeBodyPartAttachment = new MimeBodyPart();// 첨부 파일 설정을 위해 재생성

				// 파라미터 : 데이터를 처리-변환하는 DataHandler에 담긴 첨부 파일
				mimeBodyPartAttachment.setDataHandler(new DataHandler(dataSource));
				// 첨부 파일 이름 설정
				mimeBodyPartAttachment.setFileName(dataSource.getName());
				multipart.addBodyPart(mimeBodyPartAttachment);// MultiPart 에 추가
			}
		}

		emailMimeMessage.setContent(multipart); // MIME 형식의 이메일 메시지 완료

		// 4. MIME 메시지를 인코딩하고, Gmail 메시지로 Wrapping 하기
		// (1) 이메일 내용 : MIME 메시지 -> 바이트 배열
		ByteArrayOutputStream buffer = new ByteArrayOutputStream(); // 바이트 데이터를 저장하는 출력 스트림 생성
		emailMimeMessage.writeTo(buffer); // MIME 메시지를 ByteArrayOutputStream에 쓰기
		byte[] rawMessageBytes = buffer.toByteArray(); // ByteArrayOutputStream에 담긴 내용을 바이트 배열에 담기

		// (2) 바이트 배열 -> Base64 인코딩
		String encodedMessage = Base64Utils.encodeToUrlSafeString(rawMessageBytes);
//        log.info("마임 Base64 인코딩 완료");

		// (3) Gmail API에서 이메일 메시지를 나타내는 객체, Message 생성
		com.google.api.services.gmail.model.Message message = new com.google.api.services.gmail.model.Message();
		message.setRaw(encodedMessage // Base64 로 인코딩된 메시지(String)
		);
		// raw : 원본 이메일 데이터
		// 형식 : MIME 형식으로 표현. 이메일의 모든 부분을 포함하는 데이터(헤더, 본문, 첨부파일 등)
//        log.info("raw 데이터 완성");
//		log.info("전송 전 메세지 확인 : {}", message);

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		message = gmailAPIService.users().messages().send("me", message).execute();// 작업을 실제로 수행하는 메서드

//        log.info("전송 결과 : {}", message);
		return message;
	}

	@Override
	public int createEmailDB(MailInboxVO mailInboxVO) {
		return mailDAO.insertMailNoneAttachment(mailInboxVO);
	}

	@Override
	public int createEmailWithAttachmentDB(MailInboxVO mailInboxVO) {
		return mailDAO.insertMailWithAttachment(mailInboxVO);
	}

	@Override
	public List<MailBoxVO> retrieveEmailNoneAttachment(MailBoxVO mailBoxVO) {
		return mailDAO.selectMailNoneAttachment(mailBoxVO);
	}

	@Override
	public List<MailBoxVO> retrieveEmailWithAttachment(MailBoxVO mailBoxVO) {
		return mailDAO.selectMailWithAttachment(mailBoxVO);
	}

	@Override
	public List<String> retrieveMessageIdList(String empId) {
		return mailDAO.selectMessageIdList(empId);
	}

	/**
	 * 이메일 목록 조회
	 *
	 * @param empId
	 * @return List<String>
	 */
	@Override
	public List<MailBoxVO> retrieveEmailsList(String empId) {
		return mailDAO.selectEmalsList(empId);
	}

	@Override
	public int retrieveOneCntWithAttach(MailBoxVO mailBoxVO) {
		return mailDAO.selectCountOneWithAttach(mailBoxVO);
	}

	@Override
	public MailBoxVO retrieveOneWithAttach(MailBoxVO mailBoxVO) {
		return mailDAO.selectOneWithAttach(mailBoxVO);
	}

	@Override
	public int retrieveEmailTotalCntFromDB(MailBoxVO mailBoxVO) {
		return mailDAO.selectEmailTotalCountDB(mailBoxVO);
	}

	@Override
	public List<MailBoxVO> retrieveOne(MailBoxVO mailBoxVO) {
		return mailDAO.selectOne(mailBoxVO);
	}

	/**
	 * 받은 메일 추출
	 *
	 * @param notOrganizeEmailList
	 * @param messageIdList
	 * @param empId
	 * @param accessToken
	 * @return
	 * @throws IOException
	 */
	@Override
	public List<List<MailBoxVO>> organizeEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList,
			List<String> messageIdList, String empId, String accessToken) throws IOException {
//        log.info("메일 식별자 목록 : {}", messageIdList);
		List<MailBoxVO> nowEmailListFromDB = mailService.retrieveEmailsList(empId);// 기존 DB 데이터
		List<List<MailBoxVO>> finalSaveList = new ArrayList<>();
		List<List<MailBoxVO>> mailList = new ArrayList<>();

		String empEmail = mailService.retrieveEmployeeEmailAddress(empId);

		String fromName = "";
		String fromAddr = "";
		int total = 1;
		int saveCnt = 1;
		int reqCnt = 1;
		int count = 1;

		for (String messageId : messageIdList) {

			List<MailBoxVO> attachSaveList = new ArrayList<>();

//          ========================== 메일 추출 시작 =================================
			MailBoxVO checkInfo = new MailBoxVO();// DB 등록용
			checkInfo.setReceiverInfo(empId);
//            log.info("(1) MailBoxVO 저장 │ 웹 애플리케이션 회원 식별 ID = 받는 사람 : {}", checkInfo.getReceiverInfo());
			checkInfo.setMailMessageId(messageId);
//            log.info("(2) MailBoxVO 저장 │ Gmail messageId : {}", messageId);
//            log.info("해당 messageId가 기존 DB에 있는지 확인");
			int beingCnt = mailService.retrieveEmailTotalCntFromDB(checkInfo);// 메일 존재 확인
			if (beingCnt > 0) {
//                log.info("기존 DB에 포함된 메일이므로 다음 메서드로 넘어가기");
//                log.info("종료 messageId : {}", messageId);
				continue;
			}
//            log.info(" ******************************* 메일 추출 messageId : {} ******************************* ", messageId);

//          메일 추출 리스트 : notOrganizeEmailList
			Map<String, Object> eachMailInfoBeforeExtraction = new HashMap<>();
			for (Map<String, Map<String, Object>> takeMap : notOrganizeEmailList) {
				eachMailInfoBeforeExtraction = takeMap.get(messageId);
				if (eachMailInfoBeforeExtraction != null) {
					break;
				}
			}
//			log.info("파트 확인 : {}", notOrganizeEmailList);

			String snippet = (String) eachMailInfoBeforeExtraction.get("snippet"); // payload와 동일 위치
			checkInfo.setMailSnippet(snippet);
			Map<String, Object> payloadMap = (Map<String, Object>) eachMailInfoBeforeExtraction.get("payload");
			List<Map<String, String>> headersList = (List<Map<String, String>>) payloadMap.get("headers");
			for (Map<String, String> headerMap : headersList) { // "payload": { "headers": []
				if ("From".equals(headerMap.get("name"))) {
					String from = headerMap.get("value");// 보내는 사람 정보 전체 : "홍세진" <sejinhon@gmail.com>
					checkInfo.setSender(from);
//                    log.info("(4) MailBoxVO 저장 │ 보낸 사람 전체 정보 : {}", checkInfo.getSender());
					// 출력용 (NOT DB)
					String fromPattern = "\"([^\"]*)\"\\s<([^>]*)>";
					Pattern pattern = Pattern.compile(fromPattern);
					Matcher matcher = pattern.matcher(from);
					if (matcher.find()) {
						fromName = matcher.group(1);
						fromAddr = matcher.group(2);
//                        log.info("fromName : {}", fromName);
//                        log.info("fromAddr : {}", fromAddr);
						checkInfo.setFromName(fromName);
						checkInfo.setFromAddr(fromAddr);
					} else {
						checkInfo.setFromAddr(from);
					}
					// 구분 할 수 없으면 전체 정보로 출력
				} else if ("Subject".equals(headerMap.get("name"))) {
					// 제목 추출
					String subject = headerMap.get("value");
					checkInfo.setMailInboxTitle(subject);
				} else if ("Date".equals(headerMap.get("name"))) {
					String date = headerMap.get("value");
					// String -> LocalDateTime

					ZonedDateTime zonedDateTime;

//                        log.info("date : {}", date);
					// String -> LocalDateTime
					if (date.contains("GMT")) {
						Instant instant = Instant.from(DateTimeFormatter.RFC_1123_DATE_TIME.parse(date));
						zonedDateTime = instant.atZone(ZoneId.systemDefault());
					} else {
						try {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						} catch (DateTimeParseException e) {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, d MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						}
					}

					LocalDateTime receivedDateTime = zonedDateTime.toLocalDateTime();// ----------------
					// <<<<<<<<<<<<<<<< 받은 일시 추출
					checkInfo.setMailInboxDate(receivedDateTime);
//                    log.info("(6)  MailBoxVO 저장 │ 메일 받은 날짜시간 정보 : {}", checkInfo.getMailInboxDate());
				}
			} // 헤더 부분 추출 종료 (보내는 사람, 제목, 받은 일시)// "payload": { "headers": []

			int partCnt = 1;
			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
			List<Map<String, Object>> partsList = (List<Map<String, Object>>) payloadMap.get("parts");
//			log.info("파트 : {}", payloadMap);
			for (Map<String, Object> partMap : partsList) {
				// 내용 뽑기
				{
					String mimeType = partMap.get("mimeType").toString().trim();
//					log.info("mimeType : {}", mimeType);

					List<Map<String, Object>> partsHeaders = (List<Map<String, Object>>) partMap.get("headers");
					List<Map<String, Object>> partsParts = (List<Map<String, Object>>) partMap.get("parts");

//					log.info("partMap : {}", partMap);
//					log.info("partsHeaders : {}", partsHeaders);
//					log.info("partsParts : {}", partsParts);
					// -------------------------------------------------- 본문 : HTML 타입 : body 반환 첫번째
					// 우선 값
					if (mimeType.equals("text/html")) {
//						log.info("마임 타입 : text/html = {}", mimeType);
						for (Map<String, Object> header : partsHeaders) {
							String headersName = header.get("name").toString();
							if (headersName.equals("Content-Transfer-Encoding")) {
//                                String encodingType = header.get("value").toString();
//                                if ("quoted-printable".equals(encodingType)) {
								// quoted-printable 인코딩이라고 되어있으나 실질적으로 Base64 인코딩 상태
								Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
								// body의 size로 본문 존재 여부 확인
								if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
									// ---------------------------------------------------------- 본문 없음
//                                    log.info("HTML 본문 없음");
								} else {
									// Base64Utils로 디코딩 -> byte[] -> String
									String quotedPrintableEncoded = partsBody.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(quotedPrintableEncoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);// DB 저장용 변수 저장
									checkInfo.setMailInboxContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (HTML) : {}", checkInfo.getMailInboxContent());
								}
//                                } else {

//                                }
							}
						}
					} else if (mimeType.equals("text/plain")) {
//						log.info("마임 타입 : text/plain = {}", mimeType);
						// ---------------------------------------------- 본문 : 텍스트 타입 : body 반환 두번째 우선 값
						if (partMap.get("filename").toString().isEmpty()) {
							for (Map<String, Object> header : partsHeaders) {
								String headersName = header.get("name").toString();
								if (headersName.equals("Content-Transfer-Encoding")) {
									String encodingType = header.get("value").toString();
//									log.info("헤더 {}", encodingType);
									if ("base64".equals(encodingType)) {
										Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
//										log.info("본문 담긴 파트 내부 바디 : {}", partsBody);
										// body size로 본문 존재 여부 확인
										if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
											// base64 본문 없음
//                                        log.info("plain 본문 없음");
										} else {
											// base64 본문(문자열) - 디코딩 진입 -> byty[] -> 문자열
//											log.info("본문 크기 : {}", Integer.parseInt(partsBody.get("size").toString()));
//											log.info("파트 바디 : {}", partsBody);
											String base64Encoded = partsBody.get("data").toString();
											byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
											String body = new String(dataBytes, StandardCharsets.UTF_8);
											checkInfo.setMailInboxContent(body);
//                                        log.info("(7)  MailBoxVO 저장 │ 메일 내용 (text/plain) : {}", checkInfo.getMailInboxContent());
										}
									}
								}
							}
						} else {
//							log.info("txt 파일");
							List<MailBoxVO> attachList = new ArrayList<>();
							Object checkFilename = partMap.get("filename");
							List<Map<String, Object>> checkHeaders = (List<Map<String, Object>>) partMap.get("headers");

//							for(Map<String, Object> header : checkHeaders) {
//								if(header.get("name").equals("Content-Type")) {
//									mimeType = header.get("value").toString();
//									log.info("txt 파일 마임타입 : {}", mimeType);
//									break;
//								}
//							} 

							if (checkFilename != null) {
//			                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
								MailBoxVO attachVO = new MailBoxVO();
								String filename = checkFilename.toString();
								if ((checkFilename != null) && (filename.length() > 0)) {
//			                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
									Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
									String attachmentId = partBody.get("attachmentId").toString();
									int partSize = Integer.parseInt(partBody.get("size").toString());

									attachVO.setMailAttachmentName(filename);
									attachVO.setMailAttachmentId(attachmentId);
									attachVO.setMailAttachmentSize(partSize);
									attachVO.setMailAttachmentMimeType(mimeType);
//			                        log.info("(8) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//			                        log.info("(9) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//			                        log.info("(10) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//			                        log.info("(11) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
									attachList.add(attachVO);
								}
							} // 첨부파일 존재 종료

							List<MailBoxVO> attachMoveList = new ArrayList<>();
							// 첨부 파일 여부
							if (attachList.size() > 0) {
//				                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());

								for (MailBoxVO save : attachList) {
									MailBoxVO anAttach = new MailBoxVO();
									checkInfo.setMailAttachmentId(save.getMailAttachmentId());
									checkInfo.setMailAttachmentName(save.getMailAttachmentName());
									checkInfo.setMailAttachmentSize(save.getMailAttachmentSize());
									checkInfo.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//				                    log.info("첨부파일 요청");
									anAttach = mailStoreGmailService.getAttachFromGmail(empId, checkInfo);
									checkInfo.setMailAttachmentFile(anAttach.getMailAttachmentFile());
									attachMoveList.add(checkInfo);
//				                    log.info("메일 확인 : {} 개", attachMoveList);
								}

								for (MailBoxVO infos : attachMoveList) {
									// 등록 대상 : 메일 (첨부파일 없음)
									int result = mailService.retrieveOneCntWithAttach(infos);
//				                    log.info("DB 중복 확인 하기 : {}", result);
									if (result > 0) {
//				                        log.info("DB 중복 저장 안함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
									} else {
//				                        log.info("DB 없음 저장함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
//				                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
										attachSaveList.add(infos);

									}
								}
							} else {
								// 첨부 파일 없음
								int result = mailService.retrieveOneCntWithAttach(checkInfo);
//				                log.info("DB 중복 확인 하기 : {}", result);
								if (result > 0) {
//				                    log.info("DB 중복 저장 안함 ");
								} else {
//				                    log.info("DB 없음 저장함 ");
									attachSaveList.add(checkInfo);

								}
							}
//				            log.info("{} 번째 메일 : {}", total++, attachSaveList.size());

							finalSaveList.add(attachSaveList);

						}
					} else if (mimeType.equals("multipart/alternative")) {
//						log.info("마임 타입 : multipart/alternative = {}", mimeType);
						// ---------------------------------------------- 본문 : 멀티파트 타입 : body 반환 세번째 우선
						// 값
						for (Map<String, Object> part : partsParts) {
							String partMimeType = part.get("mimeType").toString();
//							log.info("멀티파트 마임 타입 : {}", partMimeType);
							Map<String, Object> partBodyMap = (Map<String, Object>) part.get("body");
							if (partMimeType.equals("text/html")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailInboxContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/html) : {}", checkInfo.getMailInboxContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							} else if (partMimeType.equals("text/plain")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//									log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailInboxContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/plain) : {}", checkInfo.getMailInboxContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							}
						}
					} // body 본문 추출 - DB 저장용 변수에 저장 종료
				} // 내용 종료
			}

			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
//            log.info("파트 개수 : {}", partsList.size());
//            log.info("파트 확인 : {}", partsList);
			List<MailBoxVO> attachList = new ArrayList<>();
			for (Map<String, Object> partMap : partsList) {
				// 첨부파일 뽑기 + DB 저장
//                log.info("첨부파일 확인하기 + DB 저장 준비");
				Object checkFilename = partMap.get("filename");
				String mimeType = partMap.get("mimeType").toString();
				if (checkFilename != null) {
//                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
					MailBoxVO attachVO = new MailBoxVO();
					String filename = checkFilename.toString();
					if ((checkFilename != null) && (filename.length() > 0)) {
//                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
						Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
						String attachmentId = partBody.get("attachmentId").toString();
						int partSize = Integer.parseInt(partBody.get("size").toString());

						attachVO.setMailAttachmentName(filename);
						attachVO.setMailAttachmentId(attachmentId);
						attachVO.setMailAttachmentSize(partSize);
						attachVO.setMailAttachmentMimeType(mimeType);
//                        log.info("(8) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//                        log.info("(9) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//                        log.info("(10) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//                        log.info("(11) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
						attachList.add(attachVO);
					}
				} // 첨부파일 존재 종료
			}

			List<MailBoxVO> attachMoveList = new ArrayList<>();
			// 첨부 파일 여부
			if (attachList.size() > 0) {
//                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());

				for (MailBoxVO save : attachList) {
					MailBoxVO anAttach = new MailBoxVO();
					checkInfo.setMailAttachmentId(save.getMailAttachmentId());
					checkInfo.setMailAttachmentName(save.getMailAttachmentName());
					checkInfo.setMailAttachmentSize(save.getMailAttachmentSize());
					checkInfo.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//                    log.info("첨부파일 요청");
					anAttach = mailStoreGmailService.getAttachFromGmail(empId, checkInfo);
					checkInfo.setMailAttachmentFile(anAttach.getMailAttachmentFile());
					attachMoveList.add(checkInfo);
//                    log.info("메일 확인 : {} 개", attachMoveList);
				}

				for (MailBoxVO infos : attachMoveList) {
					// 등록 대상 : 메일 (첨부파일 없음)
					int result = mailService.retrieveOneCntWithAttach(infos);
//                    log.info("DB 중복 확인 하기 : {}", result);
					if (result > 0) {
//                        log.info("DB 중복 저장 안함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
					} else {
//                        log.info("DB 없음 저장함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
//                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
						attachSaveList.add(infos);

					}
				}
			} else {
				// 첨부 파일 없음
				int result = mailService.retrieveOneCntWithAttach(checkInfo);
//                log.info("DB 중복 확인 하기 : {}", result);
				if (result > 0) {
//                    log.info("DB 중복 저장 안함 ");
				} else {
//                    log.info("DB 없음 저장함 ");
					attachSaveList.add(checkInfo);

				}
			}
//            log.info("{} 번째 메일 : {}", total++, attachSaveList.size());

			finalSaveList.add(attachSaveList);

		} // 메일 추출 종료
//        log.info("메일 총 개수 : {}", finalSaveList.size());
//        mailList.add(emailWithSomeFiles);

//        // DB 저장하기
//        {
//            // 등록 대상 : 메일 + 첨부파일
//            int result = mailService.retrieveOneCntWithAttach(checkInfo);
//            log.info("DB 중복 확인 하기 : {}", result);
//            if (result > 0) {
//                log.info("DB 중복되므로 저장하지 않음");
//            } else {
//
//                log.info("DB 중복되지 않으므로 저장하기");
//                log.info("첨부파일 요청하기");
//                byte[] fileBytes = mailService.organizeAttachment(checkInfo, empId);
//                checkInfo.setMailAttachmentFile(fileBytes);
//
//
//                emailWithSomeFiles.add(checkInfo);
//            }
//
//        }
		int saveDB = 1;
		for (List<MailBoxVO> f : finalSaveList) {
			for (MailBoxVO vo : f) {
				int result = mailService.retrieveOneCntWithAttach(vo);
				if (result < 1) {
					int saveResult = mailService.createEmail(vo);
//                    log.info(" {} DB 저장 : {}", saveDB++, saveResult);
				}
			}
		}

		return mailList;
	}

	@Override
	public int createEmail(MailBoxVO mailBoxVO) {
		return mailDAO.insertJustEmail(mailBoxVO);
	}

	@Override
	public int createSentEmail(MailBoxVO mailBoxVO) {
		return mailDAO.insertJustEmailSent(mailBoxVO);
	}

	@Override
	public List<MailBoxVO> retrieveMessageIdFromDB(String empId) {
		return mailDAO.selectMessageIdFromDB(empId);
	}

	@Override
	public List<MailBoxVO> retrieveViewFromDB(MailBoxVO mailBoxVO) {
		return mailDAO.selectViewFromDB(mailBoxVO);
	}

	@Override
	public int updateFile(MailBoxVO mailBoxVO) {
		return mailDAO.updateAttachmentFileBytes(mailBoxVO);
	}

	/**
	 * 보낸 메일 추출
	 *
	 * @param notOrganizeEmailList
	 * @param messageIdList
	 * @param empId
	 * @param accessToken
	 * @return
	 * @throws IOException
	 */
	@Override
	public List<List<MailBoxVO>> organizeSentEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList,
			List<String> messageIdList, String empId, String accessToken) throws IOException {
//        log.info("메일 식별자 목록 : {}", messageIdList);
		List<List<MailBoxVO>> finalSaveList = new ArrayList<>();
		List<List<MailBoxVO>> mailList = new ArrayList<>();

		String fromName = "";
		String fromAddr = "";
		int total = 1;
		int saveCnt = 1;
		int reqCnt = 1;
		int count = 1;

		for (String messageId : messageIdList) {

			List<MailBoxVO> attachSaveList = new ArrayList<>();

//            log.info("========================== 메일 추출 시작 {} =================================", total++);
			MailBoxVO checkInfo = new MailBoxVO();// DB 등록용
			checkInfo.setEmpId(empId);
//            log.info("(1) MailBoxVO 저장 │ 웹 애플리케이션 회원 식별 ID = 보낸 사람 : {}", checkInfo.getEmpId());
			checkInfo.setMailMessageId(messageId);
//            log.info("(2) MailBoxVO 저장 │ Gmail messageId : {}", messageId);
//            log.info("해당 messageId가 기존 DB에 있는지 확인");
			int beingCnt = mailService.retrieveCountSentMail(checkInfo);// 메일 존재 확인
			if (beingCnt > 0) {
//                log.info("기존 DB에 포함된 메일이므로 다음 메서드로 넘어가기");
//                log.info("종료 messageId : {}", messageId);
				continue;
			}
//            log.info(" ******************************* 메일 추출 messageId : {} ******************************* ", messageId);

//            log.info(" 메일 추출 리스트 : {}", notOrganizeEmailList.size());
			Map<String, Object> eachMailInfoBeforeExtraction = new HashMap<>();
			for (Map<String, Map<String, Object>> takeMap : notOrganizeEmailList) {
				eachMailInfoBeforeExtraction = takeMap.get(messageId);
				if (eachMailInfoBeforeExtraction != null) {
					break;
				}
			}
//            log.info("확인 : {}", eachMailInfoBeforeExtraction);
//            log.info("[카운트 체크] 메일 응답으로부터 {} 번째 추출", count++);
			String snippet = (String) eachMailInfoBeforeExtraction.get("snippet"); // payload와 동일 위치
			checkInfo.setMailSnippet(snippet);
//            log.info("(3)  MailBoxVO 저장 │ 메일 짧은 정보 Snippet : {}", checkInfo.getMailSnippet());
			Map<String, Object> payloadMap = (Map<String, Object>) eachMailInfoBeforeExtraction.get("payload");
			List<Map<String, String>> headersList = (List<Map<String, String>>) payloadMap.get("headers");
			for (Map<String, String> headerMap : headersList) { // "payload": { "headers": []
				if ("From".equals(headerMap.get("name"))) {
					String from = headerMap.get("value");// 보내는 사람 정보 전체 : "홍세진" <sejinhon@gmail.com>
					checkInfo.setMailSendSender(from);
//                    log.info("(4) MailBoxVO 저장 │ 보낸 사람 전체 정보 : {}", checkInfo.getMailSendSender());
					// 출력용 (NOT DB)
					String fromPattern = "\"([^\"]*)\"\\s<([^>]*)>";
					Pattern pattern = Pattern.compile(fromPattern);
					Matcher matcher = pattern.matcher(from);
					if (matcher.find()) {
						fromName = matcher.group(1);
						fromAddr = matcher.group(2);
//                        log.info("fromName : {}", fromName);
//                        log.info("fromAddr : {}", fromAddr);
						checkInfo.setFromName(fromName);
						checkInfo.setFromAddr(fromAddr);
					}
					// 구분 할 수 없으면 전체 정보로 출력
				} else if ("Subject".equals(headerMap.get("name"))) {
					// --------------------------------------------------
					// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 제목 추출
					String subject = headerMap.get("value");
					checkInfo.setMailSendTitle(subject);
//                    log.info("(5)  MailBoxVO 저장 │ 제목 : {}", checkInfo.getMailSendTitle());
				} else if ("Date".equals(headerMap.get("name"))) {
					String date = headerMap.get("value");

//                        log.info("date : {}", date);
					// String -> LocalDateTime

					ZonedDateTime zonedDateTime;

//                        log.info("date : {}", date);
					// String -> LocalDateTime
					if (date.contains("GMT")) {
						Instant instant = Instant.from(DateTimeFormatter.RFC_1123_DATE_TIME.parse(date));
						zonedDateTime = instant.atZone(ZoneId.systemDefault());
					} else {
						try {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						} catch (DateTimeParseException e) {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, d MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						}
					}

					LocalDateTime receivedDateTime = zonedDateTime.toLocalDateTime();// ----------------
					// <<<<<<<<<<<<<<<< 받은 일시 추출
					checkInfo.setMailSendDate(receivedDateTime);
//					log.info("(6)  MailBoxVO 저장 │ 메일 받은 날짜시간 정보 : {}", checkInfo.getMailSendDate());
				} else if ("To".equals(headerMap.get("name"))) {
					String to = headerMap.get("value");
					checkInfo.setMailSendReceiver(to);
//					log.info("(7) MailBoxVO 저장 │ 받는사람 전체 정보 : {}", checkInfo.getMailSendSender());
				}
			} // 헤더 부분 추출 종료 (보내는 사람, 제목, 받은 일시)// "payload": { "headers": []

			int partCnt = 1;
			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
			List<Map<String, Object>> partsList = (List<Map<String, Object>>) payloadMap.get("parts");
//			log.info("파트 확인 : {}", partsList);
			for (Map<String, Object> partMap : partsList) {
//				log.info("파트 내용 뽑기 횟수 확인 : {}", partCnt);
				// 내용 뽑기
				{
//					log.info("내용 확인");
					String mimeType = partMap.get("mimeType").toString();
					List<Map<String, Object>> partsHeaders = (List<Map<String, Object>>) partMap.get("headers");
					List<Map<String, Object>> partsParts = (List<Map<String, Object>>) partMap.get("parts");
					// -------------------------------------------------- 본문 : HTML 타입 : body 반환 첫번째
					// 우선 값
					if (mimeType.equals("text/html")) {
						for (Map<String, Object> header : partsHeaders) {
							String headersName = header.get("name").toString();
							if (headersName.equals("Content-Transfer-Encoding")) {
//                                String encodingType = header.get("value").toString();
//                                if ("quoted-printable".equals(encodingType)) {
								// quoted-printable 인코딩이라고 되어있으나 실질적으로 Base64 인코딩 상태
								Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
								// body의 size로 본문 존재 여부 확인
								if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
									// ---------------------------------------------------------- 본문 없음
//                                    log.info("HTML 본문 없음");
								} else {
									// Base64Utils로 디코딩 -> byte[] -> String
									String quotedPrintableEncoded = partsBody.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(quotedPrintableEncoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);// DB 저장용 변수 저장
									checkInfo.setMailSendContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (HTML) : {}", checkInfo.getMailSendContent());
								}
//                                } else {

//                                }
							}
						}
					} else if (mimeType.equals("text/plain")) {
						if (partMap.get("filename").toString().isEmpty()) {
							// ---------------------------------------------- 본문 : 텍스트 타입 : body 반환 두번째 우선 값
							for (Map<String, Object> header : partsHeaders) {
								String headersName = header.get("name").toString();
								if (headersName.equals("Content-Transfer-Encoding")) {
									String encodingType = header.get("value").toString();
									if ("base64".equals(encodingType)) {
										Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
										// body size로 본문 존재 여부 확인
										if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
											// base64 본문 없음
//                                        log.info("plain 본문 없음");
										} else {
											// base64 본문(문자열) - 디코딩 진입 -> byty[] -> 문자열
											String base64Encoded = partsBody.get("data").toString();
											byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
											String body = new String(dataBytes, StandardCharsets.UTF_8);
											checkInfo.setMailSendContent(body);
//                                        log.info("(7)  MailBoxVO 저장 │ 메일 내용 (text/plain) : {}", checkInfo.getMailSendContent());
										}
									}
								}
							}
						} else {
//							log.info("txt 파일");
							List<MailBoxVO> attachList = new ArrayList<>();
							Object checkFilename = partMap.get("filename");
							List<Map<String, Object>> checkHeaders = (List<Map<String, Object>>) partMap.get("headers");

//							for(Map<String, Object> header : checkHeaders) {
//								if(header.get("name").equals("Content-Type")) {
//									mimeType = header.get("value").toString();
//									log.info("txt 파일 마임타입 : {}", mimeType);
//									break;
//								}
//							} 

							if (checkFilename != null) {
//			                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
								MailBoxVO attachVO = new MailBoxVO();
								String filename = checkFilename.toString();
								if ((checkFilename != null) && (filename.length() > 0)) {
//			                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
									Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
									String attachmentId = partBody.get("attachmentId").toString();
									int partSize = Integer.parseInt(partBody.get("size").toString());

									attachVO.setMailAttachmentName(filename);
									attachVO.setMailAttachmentId(attachmentId);
									attachVO.setMailAttachmentSize(partSize);
									attachVO.setMailAttachmentMimeType(mimeType);
//			                        log.info("(8) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//			                        log.info("(9) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//			                        log.info("(10) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//			                        log.info("(11) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
									attachList.add(attachVO);
								}
							} // 첨부파일 존재 종료

							List<MailBoxVO> attachMoveList = new ArrayList<>();
							// 첨부 파일 여부
							if (attachList.size() > 0) {
//				                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());

								for (MailBoxVO save : attachList) {
									MailBoxVO anAttach = new MailBoxVO();
									checkInfo.setMailAttachmentId(save.getMailAttachmentId());
									checkInfo.setMailAttachmentName(save.getMailAttachmentName());
									checkInfo.setMailAttachmentSize(save.getMailAttachmentSize());
									checkInfo.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//				                    log.info("첨부파일 요청");
									anAttach = mailStoreGmailService.getAttachFromGmail(empId, checkInfo);
									checkInfo.setMailAttachmentFile(anAttach.getMailAttachmentFile());
									attachMoveList.add(checkInfo);
//				                    log.info("메일 확인 : {} 개", attachMoveList);
								}

								for (MailBoxVO infos : attachMoveList) {
									// 등록 대상 : 메일 (첨부파일 없음)
									int result = mailService.retrieveOneCntWithAttach(infos);
//				                    log.info("DB 중복 확인 하기 : {}", result);
									if (result > 0) {
//				                        log.info("DB 중복 저장 안함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
									} else {
//				                        log.info("DB 없음 저장함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
//				                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
										attachSaveList.add(infos);

									}
								}
							} else {
								// 첨부 파일 없음
								int result = mailService.retrieveOneCntWithAttach(checkInfo);
//				                log.info("DB 중복 확인 하기 : {}", result);
								if (result > 0) {
//				                    log.info("DB 중복 저장 안함 ");
								} else {
//				                    log.info("DB 없음 저장함 ");
									attachSaveList.add(checkInfo);

								}
							}
//				            log.info("{} 번째 메일 : {}", total++, attachSaveList.size());

							finalSaveList.add(attachSaveList);

						}
					} else if (mimeType.equals("multipart/alternative")) {
						// ---------------------------------------------- 본문 : 멀티파트 타입 : body 반환 세번째 우선
						// 값
						for (Map<String, Object> part : partsParts) {
							String partMimeType = part.get("mimeType").toString();
							Map<String, Object> partBodyMap = (Map<String, Object>) part.get("body");
							if (partMimeType.equals("text/html")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailSendContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/html) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							} else if (partMimeType.equals("text/plain")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailSendContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/plain) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							}
						}
					} else if (mimeType.equals("multipart/alternative")) {
						// ---------------------------------------------- 본문 : 멀티파트 타입 : body 반환 세번째 우선
						// 값
						for (Map<String, Object> part : partsParts) {
							String partMimeType = part.get("mimeType").toString();
							Map<String, Object> partBodyMap = (Map<String, Object>) part.get("body");
							if (partMimeType.equals("text/html")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailSendContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/html) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							} else if (partMimeType.equals("text/plain")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailSendContent(body);
//                                    log.info("(7)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/plain) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							}
						}
					} // body 본문 추출 - DB 저장용 변수에 저장 종료
				} // 내용 종료
			}

			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
//            log.info("파트 개수 : {}", partsList.size());
//            log.info("파트 확인 : {}", partsList);
			List<MailBoxVO> attachList = new ArrayList<>();
			for (Map<String, Object> partMap : partsList) {
				// 첨부파일 뽑기 + DB 저장
//                log.info("첨부파일 확인하기 + DB 저장 준비");
				Object checkFilename = partMap.get("filename");
				String mimeType = partMap.get("mimeType").toString();
				if (checkFilename != null) {
//                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
					MailBoxVO attachVO = new MailBoxVO();
					String filename = checkFilename.toString();
					if ((checkFilename != null) && (filename.length() > 0)) {
//                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
						Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
						String attachmentId = partBody.get("attachmentId").toString();
						int partSize = Integer.parseInt(partBody.get("size").toString());

						attachVO.setMailAttachmentName(filename);
						attachVO.setMailAttachmentId(attachmentId);
						attachVO.setMailAttachmentSize(partSize);
						attachVO.setMailAttachmentMimeType(mimeType);
//                        log.info("(8) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//                        log.info("(9) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//                        log.info("(10) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//                        log.info("(11) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
						attachList.add(attachVO);
					}
				} // 첨부파일 존재 종료
			}

			List<MailBoxVO> attachMoveList = new ArrayList<>();
			// 첨부 파일 여부
			if (attachList.size() > 0) {
//                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());

				for (MailBoxVO save : attachList) {
					MailBoxVO anAttach = new MailBoxVO();
					checkInfo.setMailAttachmentId(save.getMailAttachmentId());
					checkInfo.setMailAttachmentName(save.getMailAttachmentName());
					checkInfo.setMailAttachmentSize(save.getMailAttachmentSize());
					checkInfo.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//                    log.info("첨부파일 요청");
					anAttach = mailStoreGmailService.getAttachFromGmail(empId, checkInfo);
					checkInfo.setMailAttachmentFile(anAttach.getMailAttachmentFile());
					attachMoveList.add(checkInfo);
//                    log.info("메일 확인 : {} 개", attachMoveList);
				}

				for (MailBoxVO infos : attachMoveList) {
					// 등록 대상 : 메일 (첨부파일 없음)

					int result = mailService.retrieveCountSentMailDB(infos);

//                    log.info("DB 중복 확인 하기 : {}", result);
					if (result > 0) {
//                        log.info("DB 중복 저장 안함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
					} else {
//                        log.info("DB 없음 저장함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
//                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
						attachSaveList.add(infos);

					}
				}
			} else {
				// 첨부 파일 없음
				int result = mailService.retrieveCountSentMailDB(checkInfo);
//                log.info("DB 중복 확인 하기 : {}", result);
				if (result > 0) {
//                    log.info("DB 중복 저장 안함 ");
				} else {
//                    log.info("DB 없음 저장함 ");
					attachSaveList.add(checkInfo);

				}
			}
//            log.info("{} 번째 메일 : {}", total, attachSaveList.size());

			finalSaveList.add(attachSaveList);

		} // 메일 추출 종료
//        log.info("메일 총 개수 : {}", finalSaveList.size());
//        mailList.add(emailWithSomeFiles);

//        // DB 저장하기
//        {
//            // 등록 대상 : 메일 + 첨부파일
//            int result = mailService.retrieveOneCntWithAttach(checkInfo);
//            log.info("DB 중복 확인 하기 : {}", result);
//            if (result > 0) {
//                log.info("DB 중복되므로 저장하지 않음");
//            } else {
//
//                log.info("DB 중복되지 않으므로 저장하기");
//                log.info("첨부파일 요청하기");
//                byte[] fileBytes = mailService.organizeAttachment(checkInfo, empId);
//                checkInfo.setMailAttachmentFile(fileBytes);
//
//
//                emailWithSomeFiles.add(checkInfo);
//            }
//
//        }
		int saveDB = 1;
		for (List<MailBoxVO> f : finalSaveList) {
			for (MailBoxVO vo : f) {
				int before = mailService.retrieveBeingDraftIdFromDBDraft(vo);
				if (before < 1) {
					int saveResult = mailService.createSentEmail(vo);
//                    log.info(" {} DB 저장 : {}", saveDB++, saveResult);
				}
			}
		}

		return mailList;
	}

	public int retrieveCountSentMail(MailBoxVO mailBoxVO) {
		return mailDAO.selectCntSentMail(mailBoxVO);
	}

	public int retrieveCountSentMailDB(MailBoxVO mailBoxVO) {
		return mailDAO.selectCntWithAttachSent(mailBoxVO);
	}

	public List<MailBoxVO> retrieveViewFromDBSent(MailBoxVO mailBoxVO) {
		return mailDAO.selectViewFromDBSent(mailBoxVO);
	}

	public List<MailBoxVO> retrieveMessageIdFromDBSent(String empId) {
		return mailDAO.selectMessageIdFromDBSent(empId);
	}

	/**
	 * 메일 임시보관 요청 (To Gmail)
	 *
	 * @return 성공 후 이동 경로
	 */
	@Override
	public Draft sendReadyDraft(MailSendVO mailSendVO) throws MessagingException, IOException {
		List<String> addressToList = mailSendVO.getMailSendToList();
		String mailSendSubject = mailSendVO.getMailSendSubject();
		String mailSendContent = mailSendVO.getMailSendContent();
		MultipartFile[] mailFileList = mailSendVO.getFileList();
		String empId = mailSendVO.getEmpId();

//        log.info("[MailService] [sendReadyWithAttach] 메일 전송 메서드 진입");
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
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		MimeMessage emailMimeMessage = new MimeMessage(session);// (3) MIME 형식으로, 이메일의 주요 구성 요소인 발신자, 수신자, 제목, 본문 등을
		// 설정하는 객체

		// (3)-1. 발신자 설정
		emailMimeMessage.setFrom(new InternetAddress("me"));

		// (3)-2. 수신자 설정
		for (String address : addressToList) {
			// 파라미터 2개 : 수신 유형, 이메일 계정
			emailMimeMessage.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(address));
		}

		// (InternetAddress) : 이메일 주소 나타내는 객체 : 이메일 주소가 올바른 형식인지 확인 기능, 이름+이메일로 처리하는 기능.

		// (3)-3. 제목 설정
		emailMimeMessage.setSubject(mailSendSubject);

		// (3)-4. 본문 설정
		MimeBodyPart mimeBodyPart = new MimeBodyPart();// 메시지 일부분 : 본문, 첨부파일
		// 파라미터 2개 : 본문, 본문의 MIME 유형
		mimeBodyPart.setContent(mailSendContent, "text/html;charset=UTF-8");
//        log.info("본문 파람 확인 : {}", mailSendContent);
//        log.info("본문 마임 바디 파트 확인 : {}", mimeBodyPart);

		// 본문을 Multipart에 담기
		Multipart multipart = new MimeMultipart();// 이메일 메시지에 포함되는 여러 개의 본문 부분을 포함하는 객체
		multipart.addBodyPart(mimeBodyPart); // 본문 설정한 mimeBodyPart 객체 추가

		// (3)-5. 첨부 파일 설정
		List<DataSource> dataSourceList = new ArrayList<>();
		for (MultipartFile multipartFile : mailFileList) {
			if (!multipartFile.isEmpty()) {
				// MultipartFile -> File 변환
				File file = new File(multipartFile.getOriginalFilename());// 업로드된 파일의 원본명 가져오기(확장자 포함)

				// File 객체로 변환하기
				multipartFile.transferTo(file);
				DataSource dataSource = new FileDataSource(file);// 첨부파일
				dataSourceList.add(dataSource);
			}
		}

		if (!dataSourceList.isEmpty()) {
			for (DataSource dataSource : dataSourceList) {
				MimeBodyPart mimeBodyPartAttachment = new MimeBodyPart();// 첨부 파일 설정을 위해 재생성

				// 파라미터 : 데이터를 처리-변환하는 DataHandler에 담긴 첨부 파일
				mimeBodyPartAttachment.setDataHandler(new DataHandler(dataSource));

				// 첨부 파일 이름 설정
				mimeBodyPartAttachment.setFileName(dataSource.getName());

//                log.info("첨부 파일 확인 : {}", mimeBodyPartAttachment);

				multipart.addBodyPart(mimeBodyPartAttachment);// MultiPart 에 추가
			}
		}

		emailMimeMessage.setContent(multipart); // MIME 형식의 이메일 메시지 완료
		// (MimeMessage emailMimeMessage) 본문 + 첨부파일들 담김
//        log.info(" 발신자 확인 : {} ", emailMimeMessage.getFrom());
//        log.info(" 수신자 확인 : {}", emailMimeMessage.getRecipients(javax.mail.Message.RecipientType.TO));
//        log.info(" 제목 확인 : {}", emailMimeMessage.getSubject());

		// 4. MIME 메시지를 인코딩하고, Gmail 메시지로 Wrapping 하기
		// (1) 이메일 내용 : MIME 메시지 -> 바이트 배열
		ByteArrayOutputStream buffer = new ByteArrayOutputStream(); // 바이트 데이터를 저장하는 출력 스트림 생성
		emailMimeMessage.writeTo(buffer); // MIME 메시지를 ByteArrayOutputStream에 쓰기
		byte[] rawMessageBytes = buffer.toByteArray(); // ByteArrayOutputStream에 담긴 내용을 바이트 배열에 담기

		// (2) 바이트 배열 -> Base64 인코딩
		String encodedMessage = Base64Utils.encodeToUrlSafeString(rawMessageBytes);
//        log.info("마임 Base64 인코딩 완료");

		// (3) Gmail API에서 이메일 메시지를 나타내는 객체, Message 생성
		com.google.api.services.gmail.model.Message message = new com.google.api.services.gmail.model.Message();
		message.setRaw(encodedMessage // Base64 로 인코딩된 메시지(String)
		);
		// raw : 원본 이메일 데이터
		// 형식 : MIME 형식으로 표현. 이메일의 모든 부분을 포함하는 데이터(헤더, 본문, 첨부파일 등)
//        log.info("raw 데이터 완성");

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		Draft draft = new Draft();
		draft.setMessage(message);

		try {
			draft = gmailAPIService.users().drafts().create("me", draft).execute();// 작업을 실제로 수행하는 메서드
		} catch (NullPointerException e) {
			Draft draftNull = new Draft();
			return draftNull;
		}

//        log.info("임시보관함 전송 결과 : {}", draft);
		return draft;
	}

	@Override
	public int createJustEmailDraft(MailBoxVO mailBoxVO) {
		return mailDAO.insertJustEmailDraft(mailBoxVO);
	}

	@Override
	public int deleteDraftBeforeSend(MailBoxVO mailBoxVO) {
		return mailDAO.deleteDraft(mailBoxVO);
	}

	@Override
	public int deleteDraftAttachBeforeSend(MailBoxVO mailBoxVO) {
		return mailDAO.deleteDraftAttach(mailBoxVO);
	}

	/**
	 * 임시보관 요청한 메일 데이터를 DB에 저장하기전 이미 있는지 체크
	 *
	 * @param mailBoxVO
	 * @return 있음 1, 없음 0
	 */
	@Override
	public int retrieveBeingDraftIdFromDBDraft(MailBoxVO mailBoxVO) {
		return mailDAO.selectDraftIdBeingDraft(mailBoxVO);
	}

	/**
	 * 임시보관 메일 추출 + DB 저장
	 *
	 * @param notOrganizeEmailList
	 * @param empId
	 * @param accessToken
	 * @return
	 * @throws IOException
	 */
	@Override
	public List<List<MailBoxVO>> organizeDraftEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList,
			List<String> draftIdList, String empId, String accessToken) throws IOException {
//        log.info("메일 식별자 목록 : {}", draftIdList);
		List<List<MailBoxVO>> finalSaveList = new ArrayList<>();
		List<List<MailBoxVO>> mailList = new ArrayList<>();

		String fromName = "";
		String fromAddr = "";
		int total = 1;
		int saveCnt = 1;
		int reqCnt = 1;
		int count = 1;

		for (String draftId : draftIdList) {
			List<MailBoxVO> attachSaveList = new ArrayList<>();

//            log.info("========================== 메일 추출 시작 {} =================================", total);
			MailBoxVO checkInfo = new MailBoxVO();// DB 등록용
			checkInfo.setEmpId(empId);
//            log.info("(1) MailBoxVO 저장 │ 웹 애플리케이션 회원 식별 ID = 보낸 사람 : {}", checkInfo.getEmpId());
			checkInfo.setMailDraftId(draftId);
//            log.info("(2) MailBoxVO 저장 │ Gmail draftId : {}", draftId);
//            log.info("해당 draftId가 기존 DB에 있는지 확인");

//            log.info(" ******************************* 메일 추출 draftId : {} ******************************* ", draftId);

//            log.info(" {} 번째 임시보관 메일 추출 리스트 : {}", total, notOrganizeEmailList.size());
			Map<String, Object> eachDraftMap = new HashMap<>();
			Map<String, Object> eachMailInfoBeforeExtraction = new HashMap<>();
//            for (Map<String, Map<String, Object>> takeMap : notOrganizeEmailList) {
//                eachMailInfoBeforeExtraction = takeMap.get(messageId);
//                if (eachMailInfoBeforeExtraction != null) {
//                    break;
//                }
//            }
			for (Map<String, Map<String, Object>> takeMap : notOrganizeEmailList) {
//                log.info("임시보관 목록 풀기 진입");
				if (takeMap.size() > 0) {
//                    log.info("각 임시보관 메일 : {}", takeMap);
// {r-8086321970770509358={id=r-8086321970770509358, message={id=1886cdfdcfffd2f4, threadId=1886cdf9839b6b51, labelIds=[DRAFT, IMPORTANT], snippet=hghg, payload={partId=, mimeType=multipart/mixed, filename=, headers=[{name=MIME-Version, value=1.0}, {name=Date, value=Tue, 30 May 2023 22:36:31 +0900}, {name=Message-ID, value=<CAJOvdEk8cC_yiD2LfeeHphzOHZ9Fquqqi98E0N5UZnENYLsUjw@mail.gmail.com>}, {name=Subject, value=oooopop}, {name=From, value="홍세진" <sejinhon@gmail.com>}, {name=To, value="홍세진" <sejinhon@gmail.com>}, {name=Content-Type, value=multipart/mixed; boundary="00000000000078dd4905fce94a6b"}], body={size=0}, parts=[{partId=0, mimeType=multipart/alternative, filename=, headers=[{name=Content-Type, value=multipart/alternative; boundary="00000000000078dd4605fce94a69"}], body={size=0}, parts=[{partId=0.0, mimeType=text/plain, filename=, headers=[{name=Content-Type, value=text/plain; charset="UTF-8"}], body={size=6, data=aGdoZw0K}}, {partId=0.1, mimeType=text/html, filename=, headers=[{name=Content-Type, value=text/html; charset="UTF-8"}], body={size=27, data=PGRpdiBkaXI9Imx0ciI-aGdoZzwvZGl2Pg0K}}]}, {partId=1, mimeType=image/png, filename=Java.png, headers=[{name=Content-Type, value=image/png; name="Java.png"}, {name=Content-Disposition, value=attachment; filename="Java.png"}, {name=Content-Transfer-Encoding, value=base64}, {name=X-Attachment-Id, value=f_liabnzsz0}, {name=Content-ID, value=<f_liabnzsz0>}], body={attachmentId=ANGjdJ-Ajo5iZSOAJ2psIPmssCCWJv5CamKwdz5H3X65B3Ug-UNSDl97q8RU8ZaJWQV5SuTB5PjGCh68ekLmfU45fK6-PrQUAoTw_TlJnWbLk7rVEC59Sn6KFQNIOTLb2QgvyV8EsMSjejKAXchXzVHPsPO1XG2iY2-oUy0PXOxdH5RF9q6HkZwq86ykOqYoO8yYU-Zfz1dNc9FrHAtKuLlBHI6Ga0Mz472G_pWnweBUzRbw_lcNYa-xLoAwnNGq4VJppk9TBXcGiHeccnnS5F6u0OI2TBRIoPIQSzfLpdloJeVHlHe6WJ8-gs2OtrY, size=6219}}, {partId=2, mimeType=image/png, filename=0.png, headers=[{name=Content-Type, value=image/png; name="0.png"}, {name=Content-Disposition, value=attachment; filename="0.png"}, {name=Content-Transfer-Encoding, value=base64}, {name=X-Attachment-Id, value=f_liabo2q31}, {name=Content-ID, value=<f_liabo2q31>}], body={attachmentId=ANGjdJ8Bi7a4U, size=75555}}]}, sizeEstimate=113046, historyId=5726, internalDate=1685453791000}}}
					eachDraftMap = takeMap.get(draftId);
					if (eachDraftMap == null) {
						continue;
					}
//                    log.info("임시보관 메일 분해 : {}", eachDraftMap);
//                    log.info("message 밸류 추출 = 메일 하나의 값 : {}", eachDraftMap.get("message"));
					eachMailInfoBeforeExtraction = (Map<String, Object>) eachDraftMap.get("message");
				}
			}
//            log.info("임시보관 메일 확인 : {}", eachMailInfoBeforeExtraction);
//            log.info("[카운트 체크] 메일 응답으로부터 {} 번째 추출", count++);

			String messageId = eachMailInfoBeforeExtraction.get("id").toString();// 임시보관 메일에 포함된 첨부파일 요청을 위해 필요함
			if (messageId != null && messageId.length() > 0) {
//                log.info("첨부파일이 있는 경우 messageId : {}", messageId);
				checkInfo.setMailMessageId(messageId);
//                log.info("(3)  MailBoxVO 저장 │ 메일 고유 식별자 messageId: {}", checkInfo.getMailMessageId());
			}
			String snippet = (String) eachMailInfoBeforeExtraction.get("snippet"); // payload와 동일 위치
			checkInfo.setMailSnippet(snippet);
//            log.info("(3)  MailBoxVO 저장 │ 메일 짧은 정보 Snippet : {}", checkInfo.getMailSnippet());
			Map<String, Object> payloadMap = (Map<String, Object>) eachMailInfoBeforeExtraction.get("payload");
			List<Map<String, String>> headersList = (List<Map<String, String>>) payloadMap.get("headers");
			for (Map<String, String> headerMap : headersList) { // "payload": { "headers": []
				if ("From".equals(headerMap.get("name"))) {
					String from = headerMap.get("value");// 보내는 사람 정보 전체 : "홍세진" <sejinhon@gmail.com>
					checkInfo.setMailSendSender(from);
//                    log.info("(4) MailBoxVO 저장 │ 보낸 사람 전체 정보 : {}", checkInfo.getMailSendSender());
					// 출력용 (NOT DB)
					String fromPattern = "\"([^\"]*)\"\\s<([^>]*)>";
					Pattern pattern = Pattern.compile(fromPattern);
					Matcher matcher = pattern.matcher(from);
					if (matcher.find()) {
						fromName = matcher.group(1);
						fromAddr = matcher.group(2);
//                        log.info("fromName : {}", fromName);
//                        log.info("fromAddr : {}", fromAddr);
						checkInfo.setFromName(fromName);
						checkInfo.setFromAddr(fromAddr);
					}
					// 구분 할 수 없으면 전체 정보로 출력
				} else if ("Subject".equals(headerMap.get("name"))) {
					// --------------------------------------------------
					// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 제목 추출
					String subject = headerMap.get("value");
					checkInfo.setMailSendTitle(subject);
//                    log.info("(5)  MailBoxVO 저장 │ 제목 : {}", checkInfo.getMailSendTitle());
				} else if ("Date".equals(headerMap.get("name"))) {
					String date = headerMap.get("value");
					ZonedDateTime zonedDateTime;

//                        log.info("date : {}", date);
					// String -> LocalDateTime
					if (date.contains("GMT")) {
						Instant instant = Instant.from(DateTimeFormatter.RFC_1123_DATE_TIME.parse(date));
						zonedDateTime = instant.atZone(ZoneId.systemDefault());
					} else {
						try {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						} catch (DateTimeParseException e) {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, d MMM yyyy HH:mm:ss Z",
									Locale.ENGLISH);
							zonedDateTime = ZonedDateTime.parse(date, formatter);
						}
					}

					LocalDateTime receivedDateTime = zonedDateTime.toLocalDateTime();// ----------------
					// <<<<<<<<<<<<<<<< 받은 일시 추출
					checkInfo.setMailSendDate(receivedDateTime);
//                    log.info("(6)  MailBoxVO 저장 │ 메일 받은 날짜시간 정보 : {}", checkInfo.getMailSendDate());
				} else if ("To".equals(headerMap.get("name"))) {
					String to = headerMap.get("value");
					checkInfo.setMailSendReceiver(to);
//                    log.info("(7) MailBoxVO 저장 │ 받는사람 전체 정보 : {}", checkInfo.getMailSendSender());
				}
			} // 헤더 부분 추출 종료 (보내는 사람, 제목, 받은 일시)// "payload": { "headers": []

			int partCnt = 1;
			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
			List<Map<String, Object>> partsList = (List<Map<String, Object>>) payloadMap.get("parts");
//            log.info("파트 확인 : {}", partsList);
			for (Map<String, Object> partMap : partsList) {
//                log.info("파트 내용 뽑기 횟수 확인 : {}", partCnt);
				// 내용 뽑기
				{
//                    log.info("내용 확인");
					String mimeType = partMap.get("mimeType").toString();
					List<Map<String, Object>> partsHeaders = (List<Map<String, Object>>) partMap.get("headers");
					List<Map<String, Object>> partsParts = (List<Map<String, Object>>) partMap.get("parts");
					// -------------------------------------------------- 본문 : HTML 타입 : body 반환 첫번째
					// 우선 값
					if (mimeType.equals("text/html")) {
						for (Map<String, Object> header : partsHeaders) {
							String headersName = header.get("name").toString();
							if (headersName.equals("Content-Transfer-Encoding")) {
//                                String encodingType = header.get("value").toString();
//                                if ("quoted-printable".equals(encodingType)) {
								// quoted-printable 인코딩이라고 되어있으나 실질적으로 Base64 인코딩 상태
								Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
								// body의 size로 본문 존재 여부 확인
								if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
									// ---------------------------------------------------------- 본문 없음
//                                    log.info("HTML 본문 없음");
								} else {
									// Base64Utils로 디코딩 -> byte[] -> String
									try {
										String quotedPrintableEncoded = partsBody.get("data").toString();
										byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(quotedPrintableEncoded);
										String body = new String(dataBytes, StandardCharsets.UTF_8);// DB 저장용 변수 저장
										checkInfo.setMailSendContent(body);
									} catch (NullPointerException e) {
									}
//                                    log.info("(8)  MailBoxVO 저장 │ 메일 내용 (HTML) : {}", checkInfo.getMailSendContent());
								}
//                                } else {

//                                }
							}
						}
					} else if (mimeType.equals("text/plain")) {
						if (partMap.get("filename").toString().isEmpty()) {

							// ---------------------------------------------- 본문 : 텍스트 타입 : body 반환 두번째 우선 값
							for (Map<String, Object> header : partsHeaders) {
								String headersName = header.get("name").toString();
								if (headersName.equals("Content-Transfer-Encoding")) {
									String encodingType = header.get("value").toString();
									if ("base64".equals(encodingType)) {
										Map<String, Object> partsBody = (Map<String, Object>) partMap.get("body");
										// body size로 본문 존재 여부 확인
										if (Integer.parseInt(partsBody.get("size").toString()) == 0) {
											// base64 본문 없음
//                                        log.info("plain 본문 없음");
										} else {
											// base64 본문(문자열) - 디코딩 진입 -> byty[] -> 문자열
											try {
												String base64Encoded = partsBody.get("data").toString();
												byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
												String body = new String(dataBytes, StandardCharsets.UTF_8);
												checkInfo.setMailSendContent(body);
											} catch (NullPointerException e) {
											}

//                                        log.info("(8)  MailBoxVO 저장 │ 메일 내용 (text/plain) : {}", checkInfo.getMailSendContent());
										}
									}
								}
							}
						} else {
							log.info("txt 파일");
							List<MailBoxVO> attachList = new ArrayList<>();
							Object checkFilename = partMap.get("filename");
							List<Map<String, Object>> checkHeaders = (List<Map<String, Object>>) partMap.get("headers");

//							for(Map<String, Object> header : checkHeaders) {
//								if(header.get("name").equals("Content-Type")) {
//									mimeType = header.get("value").toString();
//									log.info("txt 파일 마임타입 : {}", mimeType);
//									break;
//								}
//							} 

							if (checkFilename != null) {
//			                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
								MailBoxVO attachVO = new MailBoxVO();
								String filename = checkFilename.toString();
								if ((checkFilename != null) && (filename.length() > 0)) {
//			                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
									Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
									String attachmentId = partBody.get("attachmentId").toString();
									int partSize = Integer.parseInt(partBody.get("size").toString());

									attachVO.setMailAttachmentName(filename);
									attachVO.setMailAttachmentId(attachmentId);
									attachVO.setMailAttachmentSize(partSize);
									attachVO.setMailAttachmentMimeType(mimeType);
//			                        log.info("(8) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//			                        log.info("(9) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//			                        log.info("(10) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//			                        log.info("(11) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
									attachList.add(attachVO);
								}
							} // 첨부파일 존재 종료

							List<MailBoxVO> attachMoveList = new ArrayList<>();
							// 첨부 파일 여부
							if (attachList.size() > 0) {
//				                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());

								for (MailBoxVO save : attachList) {
									MailBoxVO anAttach = new MailBoxVO();
									checkInfo.setMailAttachmentId(save.getMailAttachmentId());
									checkInfo.setMailAttachmentName(save.getMailAttachmentName());
									checkInfo.setMailAttachmentSize(save.getMailAttachmentSize());
									checkInfo.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//				                    log.info("첨부파일 요청");
									anAttach = mailStoreGmailService.getAttachFromGmail(empId, checkInfo);
									checkInfo.setMailAttachmentFile(anAttach.getMailAttachmentFile());
									attachMoveList.add(checkInfo);
//				                    log.info("메일 확인 : {} 개", attachMoveList);
								}

								for (MailBoxVO infos : attachMoveList) {
									// 등록 대상 : 메일 (첨부파일 없음)
									int result = mailService.retrieveOneCntWithAttach(infos);
//				                    log.info("DB 중복 확인 하기 : {}", result);
									if (result > 0) {
//				                        log.info("DB 중복 저장 안함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
									} else {
//				                        log.info("DB 없음 저장함 ");
//				                        log.info("메일 개수 : {}", attachMoveList.size());
//				                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
										attachSaveList.add(infos);

									}
								}
							} else {
								// 첨부 파일 없음
								int result = mailService.retrieveOneCntWithAttach(checkInfo);
//				                log.info("DB 중복 확인 하기 : {}", result);
								if (result > 0) {
//				                    log.info("DB 중복 저장 안함 ");
								} else {
//				                    log.info("DB 없음 저장함 ");
									attachSaveList.add(checkInfo);

								}
							}
//				            log.info("{} 번째 메일 : {}", total++, attachSaveList.size());

							finalSaveList.add(attachSaveList);

						}
					} else if (mimeType.equals("multipart/alternative")) {
						// ---------------------------------------------- 본문 : 멀티파트 타입 : body 반환 세번째 우선
						// 값
						for (Map<String, Object> part : partsParts) {
							String partMimeType = part.get("mimeType").toString();
							Map<String, Object> partBodyMap = (Map<String, Object>) part.get("body");
							if (partMimeType.equals("text/html")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									String base64Encoded = partBodyMap.get("data").toString();
									byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
									String body = new String(dataBytes, StandardCharsets.UTF_8);
									checkInfo.setMailSendContent(body);
//                                    log.info("(8)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/html) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							} else if (partMimeType.equals("text/plain")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									try {
										String base64Encoded = partBodyMap.get("data").toString();
										byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
										String body = new String(dataBytes, StandardCharsets.UTF_8);
										checkInfo.setMailSendContent(body);
									} catch (NullPointerException e) {
									}
//                                    log.info("(8)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/plain) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							}
						}
					} else if (mimeType.equals("multipart/alternative")) {
						// ---------------------------------------------- 본문 : 멀티파트 타입 : body 반환 세번째 우선
						// 값
						for (Map<String, Object> part : partsParts) {
							String partMimeType = part.get("mimeType").toString();
							Map<String, Object> partBodyMap = (Map<String, Object>) part.get("body");
							if (partMimeType.equals("text/html")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									try {
										String base64Encoded = partBodyMap.get("data").toString();
										byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
										String body = new String(dataBytes, StandardCharsets.UTF_8);
										checkInfo.setMailSendContent(body);
									} catch (NullPointerException e) {
									}
//                                    log.info("(8)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/html) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							} else if (partMimeType.equals("text/plain")) {
								int size = Integer.parseInt(partBodyMap.get("size").toString());
								if (size > 0) {
//                                    log.info("멀티파트 본문 있음");
									try {
										String base64Encoded = partBodyMap.get("data").toString();
										byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(base64Encoded);
										String body = new String(dataBytes, StandardCharsets.UTF_8);
										checkInfo.setMailSendContent(body);
									} catch (NullPointerException e) {
									}
//                                    log.info("(8)  MailBoxVO 저장 │ 메일 내용 (멀티파트 - text/plain) : {}", checkInfo.getMailSendContent());
								} else {
//                                    log.info("멀티파트 본문 없음");
								}
							}
						}
					} // body 본문 추출 - DB 저장용 변수에 저장 종료
				} // 내용 종료
			}

			// "payload": { (Map<String, Object>) -> obj = "parts": [ { (List<Map<String,
			// Object>>) -> obj = "filename": "", "body": { (Map<String, Object>) -> obj =
			// "attachmentId": " ", "size": 75555
//            log.info("임시보관 파트(본문, 첨부파일) 개수 : {}", partsList.size());
//            log.info("임시보관 파트(본문, 첨부파일) 확인 : {}", partsList);
			List<MailBoxVO> attachList = new ArrayList<>();
			for (Map<String, Object> partMap : partsList) {
				// 첨부파일 뽑기 + DB 저장
//                log.info("첨부파일 확인하기 + DB 저장 준비");
				Object checkFilename = partMap.get("filename");
				String mimeType = partMap.get("mimeType").toString();
				if (checkFilename != null) {
//                    log.info("파트 첨부파일 뽑기 횟수 확인 : {}", partCnt);
					MailBoxVO attachVO = new MailBoxVO();
					String filename = checkFilename.toString();
					if ((checkFilename != null) && (filename.length() > 0)) {
//                        log.info("첨부파일이 존재함 : 파일 명 : {}", filename);
						Map<String, Object> partBody = (Map<String, Object>) partMap.get("body");// 파트의 바디
						String attachmentId = partBody.get("attachmentId").toString();
						int partSize = Integer.parseInt(partBody.get("size").toString());

						attachVO.setMailAttachmentName(filename);
						attachVO.setMailAttachmentId(attachmentId);
						attachVO.setMailAttachmentSize(partSize);
						attachVO.setMailAttachmentMimeType(mimeType);
//                        log.info("(9) MailBoxVO 저장 │ 첨부파일명 : {} ", attachVO.getMailAttachmentName());
//                        log.info("(10) MailBoxVO 저장 │ 첨부파일 식별자 : {}", attachVO.getMailAttachmentId());
//                        log.info("(11) MailBoxVO 저장 │ 첨부파일 크기 : {}", attachVO.getMailAttachmentSize());
//                        log.info("(12) MailBoxVO 저장 │ 첨부파일 마임타입 : {}", attachVO.getMailAttachmentMimeType());
						attachList.add(attachVO);
					}
				} // 첨부파일 존재 종료
			}

			List<MailBoxVO> attachMoveList = new ArrayList<>();
			// 첨부 파일 여부
			if (attachList.size() > 0) {
//                log.info("메일 당 첨부파일 요청 가능 개수 확인 : {} 개", attachList.size());
//                log.info("메일 당 첨부파일 요청 가능 목록 확인 : {}", attachList);// 첨부파일 식별자 서로 다름 확인 함

				for (MailBoxVO save : attachList) {
					MailBoxVO anAttach = new MailBoxVO();
					anAttach.setEmpId(checkInfo.getEmpId());
					anAttach.setMailDraftId(checkInfo.getMailDraftId());
					anAttach.setMailMessageId(checkInfo.getMailMessageId());
					anAttach.setMailSnippet(checkInfo.getMailSnippet());
					anAttach.setMailSendDate(checkInfo.getMailSendDate());
					anAttach.setMailSendTitle(checkInfo.getMailSendTitle());
					anAttach.setSender(checkInfo.getSender());
					anAttach.setMailSendReceiver(checkInfo.getMailSendReceiver());
					anAttach.setMailSendContent(checkInfo.getMailSendContent());

					anAttach.setMailAttachmentId(save.getMailAttachmentId());
					anAttach.setMailAttachmentName(save.getMailAttachmentName());
					anAttach.setMailAttachmentSize(save.getMailAttachmentSize());
					anAttach.setMailAttachmentMimeType(save.getMailAttachmentMimeType());
//                    log.info("첨부파일 요청");
					anAttach = mailStoreGmailService.getAttachFromGmail(empId, anAttach);
					anAttach.setMailAttachmentFile(anAttach.getMailAttachmentFile());
					attachMoveList.add(anAttach);
				}
				try {
//                    log.info(" 임시보관함 첨부파일 요청 이후 메일 목록 개수 : {} 개", attachMoveList.size());
				} catch (NullPointerException e) {
				}
//                log.info(" 임시보관함 첨부파일 요청 이후, 저장 전 확인 : {}", attachMoveList);

				int attachDB = 1;
				for (MailBoxVO infos : attachMoveList) {
//                    log.info(" 임시보관함 DB 저장 전 {} 번째 메일, {} 번째 첨부파일 ", total, attachDB++);
					// 등록 대상 : 메일 (첨부파일 없음)

					int result = mailService.retrieveCountDraftFromDB(infos);

//                    log.info("DB 중복 확인 하기 : {}", result);
					if (result > 0) {
//                        log.info("DB 중복 저장 안함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
					} else {
//                        log.info("DB 없음 저장함 ");
//                        log.info("메일 개수 : {}", attachMoveList.size());
//                        log.info(" {} DB 저장 : {}", saveCnt++, attachMoveList.size());
						attachSaveList.add(infos);
					}
				}
//                log.info("임시보관함 첨부파일까지 담은 목록 : {}", attachSaveList);
			} else {
				// 첨부 파일 없음
//                log.info("임시보관함 첨부파일 없는 메일 확인");
				int result = mailService.retrieveCountDraftFromDB(checkInfo);
//                log.info("DB 중복 확인 하기 : {}", result);
				if (result > 0) {
//                    log.info("DB 중복 저장 안함 ");
				} else {
//                    log.info("DB 없음 저장함 ");
					attachSaveList.add(checkInfo);
				}
			}
//            log.info("{} 번째 메일 : {}개 준비됨", total++, attachSaveList.size());
//            log.info("--------------------------------------------------------------------");

			finalSaveList.add(attachSaveList);
		} // 메일 추출 종료
//        log.info("메일 총 개수 : {}", finalSaveList.size());
//        log.info("메일 총 확인 : {}", finalSaveList.toString());

		int saveDB = 1;
		for (List<MailBoxVO> f : finalSaveList) {
			for (MailBoxVO vo : f) {
				int beingCnt = mailService.retrieveBeingDraftIdFromDBDraft(vo);// 메일 존재 확인
//                log.info("vo 첨부파일 존재 확인 : {}", vo.getMailAttachmentId());
//                log.info(" 존재 카운트 : {}", beingCnt);
				if (beingCnt < 1) {
					int saveResult = mailService.createJustEmailDraft(vo);
//                    log.info(" 임시보관함 {} DB 저장 : {} 번째", saveDB++, saveResult);
				}
			}
		}

		return mailList;
	}

	/**
	 * messageId 목록 조회
	 *
	 * @param empId
	 * @return List<MailBoxVO>
	 */
	@Override
	public List<MailBoxVO> retrieveMessageIdFromDBDraft(String empId) {
		return mailDAO.selectMessageIdDraft(empId);
	}

	@Override
	public List<MailBoxVO> retrieveDraftIdFromDBDraft(String empId) {
		return mailDAO.selectDraftId(empId);
	}

	@Override
	public List<MailBoxVO> retrieveViewFromDBDraft(MailBoxVO mailBoxVO) {
		List<MailBoxVO> finalViewInfos = new ArrayList<>();
		List<MailBoxVO> viewInfos = mailDAO.selectViewFromDBDraft(mailBoxVO);
		for (MailBoxVO view : viewInfos) {
			try {
				String addressBefore = view.getMailSendReceiver();
				String addressAfter = "";
				Pattern pattern = Pattern.compile("([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+)");
				Matcher matcher = pattern.matcher(addressBefore);
				if (matcher.find()) {
					addressAfter = matcher.group(1);
				} else {
					addressAfter = addressBefore;
				}
				view.setMailSendReceiver(addressAfter);
			} catch (NullPointerException e) {
			}
			finalViewInfos.add(view);
		}
		return finalViewInfos;
	}

	@Override
	public List<MailBoxVO> retrieveRewriteDraftFromDB(MailBoxVO mailBoxVO) {

		List<MailBoxVO> finalViewInfos = new ArrayList<>();
		List<MailBoxVO> viewInfos = mailDAO.selectADraftFromDB(mailBoxVO);
		for (MailBoxVO view : viewInfos) {
			try {
				String addressAfter = "";
				String addressBefore = view.getMailSendReceiver();
				Pattern pattern = Pattern.compile("([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+)");
				Matcher matcher = pattern.matcher(addressBefore);
				if (matcher.find()) {
					addressAfter = matcher.group(1);
				} else {
					addressAfter = addressBefore;
				}
				view.setMailSendReceiver(addressAfter);
			} catch (NullPointerException e) {
			}
			finalViewInfos.add(view);
		}
		return finalViewInfos;
	}

	@Override
	public int retrieveCountDraftFromDB(MailBoxVO mailBoxVO) {
		return mailDAO.selectCntDraft(mailBoxVO);
	}

	/**
	 * 임시보관 중인 메일 다시 임시보관 요청 (To Gmail)
	 *
	 * @return 성공 후 이동 경로
	 */
	@Override
	public Draft sendReadyDraftAgain(MailSendVO mailSendVO) throws MessagingException, IOException {
//		log.info("임시보관 재차 임시보관 요청 메서드 진입");
		List<String> addressToList = mailSendVO.getMailSendToList();
		String mailSendSubject = mailSendVO.getMailSendSubject();
		String mailSendContent = mailSendVO.getMailSendContent();
		MultipartFile[] mailFileList = mailSendVO.getFileList();
		String empId = mailSendVO.getEmpId();
		String draftId = mailSendVO.getMailDraftId();
		log.info("draftId: {}", draftId);

		List<MailBoxVO> mailBoxList = new ArrayList<>();
		for (String addr : addressToList) {
			MailBoxVO mailBox = new MailBoxVO();
			mailBox.setMailSendReceiver(addr);
			mailBox.setMailSendTitle(mailSendVO.getMailSendSubject());
			mailBox.setMailSendContent(mailSendContent);
			mailBox.setMailDraftId(draftId);
			mailBox.setEmpId(empId);
			mailBoxList.add(mailBox);
		}

//        log.info("[MailService] [sendReadyDraftAgain] 임시보관 중인 메일 다시 임시보관 요청하기 메서드 진입");
		// 인가 키 설정
//        String jsonAuthPath = "/kr/or/ddit/mailAuth/manifest-craft-386423-12b1b1bde967.json";
//        InputStream jsonAuthInputStream = getClass().getClassLoader().getResourceAsStream(jsonAuthPath);

		// 1. 구글로부터 자격 얻기 + HTTP 요청 초기화
		// (1) 구글 서비스를 사용하는 애플리케이션 자격 증명 가져오기
//            GoogleCredentials credentials = GoogleCredentials.fromStream(jsonAuthInputStream).createScoped(GmailScopes.MAIL_GOOGLE_COM);
		// Gmail API를 통해 이메일 보내는 권한 얻기
		MailClientVO mailClientVO = mailService.retrieveEmailTokens(empId);
		String accessToken = mailClientVO.getAccessToken();
		GoogleCredential credentials = new GoogleCredential().setAccessToken(accessToken);
		// (2) Google의 서비스를 호출하는 HTTP 요청을 초기화 하고 구성 : 인터페이스 HttpRequestInitializer
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		MimeMessage emailMimeMessage = new MimeMessage(session);// (3) MIME 형식으로, 이메일의 주요 구성 요소인 발신자, 수신자, 제목, 본문 등을
		// 설정하는 객체

		// (3)-1. 발신자 설정
		emailMimeMessage.setFrom(new InternetAddress("me"));

		// (3)-2. 수신자 설정
		for (String address : addressToList) {
			// 파라미터 2개 : 수신 유형, 이메일 계정
			emailMimeMessage.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(address));
		}

		// (InternetAddress) : 이메일 주소 나타내는 객체 : 이메일 주소가 올바른 형식인지 확인 기능, 이름+이메일로 처리하는 기능.

		// (3)-3. 제목 설정
		emailMimeMessage.setSubject(mailSendSubject);

		// (3)-4. 본문 설정
		MimeBodyPart mimeBodyPart = new MimeBodyPart();// 메시지 일부분 : 본문, 첨부파일
		// 파라미터 2개 : 본문, 본문의 MIME 유형
		mimeBodyPart.setContent(mailSendContent, "text/html;charset=UTF-8");
//        log.info("본문 파람 확인 : {}", mailSendContent);
//        log.info("본문 마임 바디 파트 확인 : {}", mimeBodyPart);

		// 본문을 Multipart에 담기
		Multipart multipart = new MimeMultipart();// 이메일 메시지에 포함되는 여러 개의 본문 부분을 포함하는 객체
		multipart.addBodyPart(mimeBodyPart); // 본문 설정한 mimeBodyPart 객체 추가

		// (3)-5. 첨부 파일 설정
		List<DataSource> dataSourceList = new ArrayList<>();
		for (MultipartFile multipartFile : mailFileList) {
			if (!multipartFile.isEmpty()) {
				// MultipartFile -> File 변환
				File file = new File(multipartFile.getOriginalFilename());// 업로드된 파일의 원본명 가져오기(확장자 포함)

				// File 객체로 변환하기
				multipartFile.transferTo(file);
				DataSource dataSource = new FileDataSource(file);// 첨부파일
				dataSourceList.add(dataSource);
			}
		}

		if (!dataSourceList.isEmpty()) {
			for (DataSource dataSource : dataSourceList) {
				MimeBodyPart mimeBodyPartAttachment = new MimeBodyPart();// 첨부 파일 설정을 위해 재생성

				// 파라미터 : 데이터를 처리-변환하는 DataHandler에 담긴 첨부 파일
				mimeBodyPartAttachment.setDataHandler(new DataHandler(dataSource));

				// 첨부 파일 이름 설정
				mimeBodyPartAttachment.setFileName(dataSource.getName());

//                log.info("첨부 파일 확인 : {}", mimeBodyPartAttachment);

				multipart.addBodyPart(mimeBodyPartAttachment);// MultiPart 에 추가
			}
		}

		emailMimeMessage.setContent(multipart); // MIME 형식의 이메일 메시지 완료
		// (MimeMessage emailMimeMessage) 본문 + 첨부파일들 담김
//        log.info(" 발신자 확인 : {} ", emailMimeMessage.getFrom());
//        log.info(" 수신자 확인 : {}", emailMimeMessage.getRecipients(javax.mail.Message.RecipientType.TO));
//        log.info(" 제목 확인 : {}", emailMimeMessage.getSubject());

		// 4. MIME 메시지를 인코딩하고, Gmail 메시지로 Wrapping 하기
		// (1) 이메일 내용 : MIME 메시지 -> 바이트 배열
		ByteArrayOutputStream buffer = new ByteArrayOutputStream(); // 바이트 데이터를 저장하는 출력 스트림 생성
		emailMimeMessage.writeTo(buffer); // MIME 메시지를 ByteArrayOutputStream에 쓰기
		byte[] rawMessageBytes = buffer.toByteArray(); // ByteArrayOutputStream에 담긴 내용을 바이트 배열에 담기

		// (2) 바이트 배열 -> Base64 인코딩
		String encodedMessage = Base64Utils.encodeToUrlSafeString(rawMessageBytes);
//        log.info("마임 Base64 인코딩 완료");

		// (3) Gmail API에서 이메일 메시지를 나타내는 객체, Message 생성
		com.google.api.services.gmail.model.Message message = new com.google.api.services.gmail.model.Message();
		message.setRaw(encodedMessage // Base64 로 인코딩된 메시지(String)
		);
		// raw : 원본 이메일 데이터
		// 형식 : MIME 형식으로 표현. 이메일의 모든 부분을 포함하는 데이터(헤더, 본문, 첨부파일 등)
//        log.info("raw 데이터 완성");

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		Draft draft = gmailAPIService.users().drafts().get("me", draftId).execute();// 기존 draft 가져오기
		draft.setMessage(message);
		Draft updateDraft = gmailAPIService.users().drafts().update("me", draftId, draft).execute();// 기존 draft
		// update(수정)

		try {
			if (updateDraft.size() > 0) {
				for (MailBoxVO box : mailBoxList) {
					try {
						box.getMailAttachmentId();
						int result = mailService.deleteDraftBeforeSend(box);
//                        log.info("임시보관 업데이트한 임시보관 메일 DB에서 삭제(첨부파일) : {}", result);
					} catch (NullPointerException e) {
						int result = mailService.deleteDraftAttachBeforeSend(box);
//                        log.info("임시보관 업데이트한 임시보관 메일 DB에서 삭제(첨부파일) : {}", result);
					}
				}
			}
		} catch (NullPointerException e) {
		}

//        log.info("전송 결과 : {}", updateDraft);
		return updateDraft;
	}

	/**
	 * 임시보관 중인 메일 전송 요청 (To Gmail)
	 *
	 * @return 성공 후 이동 경로
	 */
	@Override
	public com.google.api.services.gmail.model.Message sendReadyDraftFinal(MailSendVO mailSendVO)
			throws MessagingException, IOException {
//		log.info("임시보관 최종 전송 메서드 진입");
		List<String> addressToList = mailSendVO.getMailSendToList();
		String mailSendSubject = mailSendVO.getMailSendSubject();
		String mailSendContent = mailSendVO.getMailSendContent();
		MultipartFile[] mailFileList = mailSendVO.getFileList();
		String empId = mailSendVO.getEmpId();
		String draftId = mailSendVO.getMailDraftId();
//        log.info("draftId: {}", draftId);

		List<MailBoxVO> mailBoxList = new ArrayList<>();
		for (String addr : addressToList) {
			MailBoxVO mailBox = new MailBoxVO();
			mailBox.setMailSendReceiver(addr);
			mailBox.setMailSendTitle(mailSendVO.getMailSendSubject());
			mailBox.setMailSendContent(mailSendContent);
			mailBox.setMailDraftId(draftId);
			mailBox.setEmpId(empId);
			mailBoxList.add(mailBox);
		}

//        log.info("[MailService] [sendReadyDraftFinal] 임시보관 중인 메일 전송 메서드 진입");
		// 인가 키 설정
//        String jsonAuthPath = "/kr/or/ddit/mailAuth/manifest-craft-386423-12b1b1bde967.json";
//        InputStream jsonAuthInputStream = getClass().getClassLoader().getResourceAsStream(jsonAuthPath);

		// 1. 구글로부터 자격 얻기 + HTTP 요청 초기화
		// (1) 구글 서비스를 사용하는 애플리케이션 자격 증명 가져오기
//            GoogleCredentials credentials = GoogleCredentials.fromStream(jsonAuthInputStream).createScoped(GmailScopes.MAIL_GOOGLE_COM);
		// Gmail API를 통해 이메일 보내는 권한 얻기
		MailClientVO mailClientVO = mailService.retrieveEmailTokens(empId);
		String accessToken = mailClientVO.getAccessToken();
		GoogleCredential credentials = new GoogleCredential().setAccessToken(accessToken);
		// (2) Google의 서비스를 호출하는 HTTP 요청을 초기화 하고 구성 : 인터페이스 HttpRequestInitializer
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		MimeMessage emailMimeMessage = new MimeMessage(session);// (3) MIME 형식으로, 이메일의 주요 구성 요소인 발신자, 수신자, 제목, 본문 등을
		// 설정하는 객체

		// (3)-1. 발신자 설정
		emailMimeMessage.setFrom(new InternetAddress("me"));

		// (3)-2. 수신자 설정
		for (String address : addressToList) {
			// 파라미터 2개 : 수신 유형, 이메일 계정
			emailMimeMessage.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(address));
		}

		// (InternetAddress) : 이메일 주소 나타내는 객체 : 이메일 주소가 올바른 형식인지 확인 기능, 이름+이메일로 처리하는 기능.

		// (3)-3. 제목 설정
		emailMimeMessage.setSubject(mailSendSubject);

		// (3)-4. 본문 설정
		MimeBodyPart mimeBodyPart = new MimeBodyPart();// 메시지 일부분 : 본문, 첨부파일
		// 파라미터 2개 : 본문, 본문의 MIME 유형
		mimeBodyPart.setContent(mailSendContent, "text/html;charset=UTF-8");
//        log.info("본문 파람 확인 : {}", mailSendContent);
//        log.info("본문 마임 바디 파트 확인 : {}", mimeBodyPart);

		// 본문을 Multipart에 담기
		Multipart multipart = new MimeMultipart();// 이메일 메시지에 포함되는 여러 개의 본문 부분을 포함하는 객체
		multipart.addBodyPart(mimeBodyPart); // 본문 설정한 mimeBodyPart 객체 추가

		// (3)-5. 첨부 파일 설정
		List<DataSource> dataSourceList = new ArrayList<>();
		for (MultipartFile multipartFile : mailFileList) {
			if (!multipartFile.isEmpty()) {
				// MultipartFile -> File 변환
				File file = new File(multipartFile.getOriginalFilename());// 업로드된 파일의 원본명 가져오기(확장자 포함)

				// File 객체로 변환하기
				multipartFile.transferTo(file);
				DataSource dataSource = new FileDataSource(file);// 첨부파일
				dataSourceList.add(dataSource);
			}
		}

		if (!dataSourceList.isEmpty()) {
			for (DataSource dataSource : dataSourceList) {
				MimeBodyPart mimeBodyPartAttachment = new MimeBodyPart();// 첨부 파일 설정을 위해 재생성

				// 파라미터 : 데이터를 처리-변환하는 DataHandler에 담긴 첨부 파일
				mimeBodyPartAttachment.setDataHandler(new DataHandler(dataSource));

				// 첨부 파일 이름 설정
				mimeBodyPartAttachment.setFileName(dataSource.getName());

//                log.info("첨부 파일 확인 : {}", mimeBodyPartAttachment);

				multipart.addBodyPart(mimeBodyPartAttachment);// MultiPart 에 추가
			}
		}

		emailMimeMessage.setContent(multipart); // MIME 형식의 이메일 메시지 완료
		// (MimeMessage emailMimeMessage) 본문 + 첨부파일들 담김
//        log.info(" 발신자 확인 : {} ", emailMimeMessage.getFrom());
//        log.info(" 수신자 확인 : {}", emailMimeMessage.getRecipients(javax.mail.Message.RecipientType.TO));
//        log.info(" 제목 확인 : {}", emailMimeMessage.getSubject());

		// 4. MIME 메시지를 인코딩하고, Gmail 메시지로 Wrapping 하기
		// (1) 이메일 내용 : MIME 메시지 -> 바이트 배열
		ByteArrayOutputStream buffer = new ByteArrayOutputStream(); // 바이트 데이터를 저장하는 출력 스트림 생성
		emailMimeMessage.writeTo(buffer); // MIME 메시지를 ByteArrayOutputStream에 쓰기
		byte[] rawMessageBytes = buffer.toByteArray(); // ByteArrayOutputStream에 담긴 내용을 바이트 배열에 담기

		// (2) 바이트 배열 -> Base64 인코딩
		String encodedMessage = Base64Utils.encodeToUrlSafeString(rawMessageBytes);
//        log.info("마임 Base64 인코딩 완료");

		// (3) Gmail API에서 이메일 메시지를 나타내는 객체, Message 생성
		com.google.api.services.gmail.model.Message message = new com.google.api.services.gmail.model.Message();
		message.setRaw(encodedMessage // Base64 로 인코딩된 메시지(String)
		);
		// raw : 원본 이메일 데이터
		// 형식 : MIME 형식으로 표현. 이메일의 모든 부분을 포함하는 데이터(헤더, 본문, 첨부파일 등)
//        log.info("raw 데이터 완성");

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		Draft draft = gmailAPIService.users().drafts().get("me", draftId).execute();// 기존 draft 가져오기
		draft.setMessage(message);
		Draft updateDraft = gmailAPIService.users().drafts().update("me", draftId, draft).execute();// 기존 draft
		// update(수정)
		com.google.api.services.gmail.model.Message sentMessage = gmailAPIService.users().drafts()
				.send("me", updateDraft).execute();// draft를 실제로 전송 & draft 자동 삭제

		try {
			if (sentMessage.size() > 0) {
				for (MailBoxVO box : mailBoxList) {
					try {
						box.getMailAttachmentId();
						int result = mailService.deleteDraftBeforeSend(box);
//                        log.info("전송한 임시보관 메일 DB에서 삭제(첨부파일) : {}", result);
					} catch (NullPointerException e) {
						int result = mailService.deleteDraftAttachBeforeSend(box);
//                        log.info("전송한 임시보관 메일 DB에서 삭제(첨부파일) : {}", result);
					}
				}
			}
		} catch (NullPointerException e) {
		}
//        log.info("임시보관 최종 전송 결과 : {}", sentMessage);

		return sentMessage;
	}

	public Message sendReadyTrash(MailSendVO mailSendVO) throws MessagingException, IOException {
		String empId = mailSendVO.getEmpId();
		String messageId = mailSendVO.getMailMessageId();

//		log.info("[MailService] [sendReadyTrash] 'messageId로 휴지통에 있는 메일 요청'하기 메서드 진입");

		// 1. 구글로부터 자격 얻기 + HTTP 요청 초기화
		// (1) 구글 서비스를 사용하는 애플리케이션 자격 증명 가져오기
//            GoogleCredentials credentials = GoogleCredentials.fromStream(jsonAuthInputStream).createScoped(GmailScopes.MAIL_GOOGLE_COM);
		// Gmail API를 통해 이메일 보내는 권한 얻기
		MailClientVO mailClientVO = mailService.retrieveEmailTokens(empId);
		String accessToken = mailClientVO.getAccessToken();
		GoogleCredential credentials = new GoogleCredential().setAccessToken(accessToken);
		// (2) Google의 서비스를 호출하는 HTTP 요청을 초기화 하고 구성 : 인터페이스 HttpRequestInitializer
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		Message message = gmailAPIService.users().messages().trash("me", messageId).execute();// 작업을 실제로 수행하는 메서드

//		log.info("휴지통 메일 요청 전송 결과 : {}", message);
		return message;
	}

	public List<MailTrashVO> organizeTrash(List<Message> trashList, String empId) {
		log.info("기존 DB 정리하고 휴지통에 저장하기 메서드 진입");
		List<MailTrashVO> trashOrgList = new ArrayList<>();
		MailBoxVO inboxTrashVO = new MailBoxVO();
		List<MessagePartHeader> headers = new ArrayList<>();
		String messageId = "";
		String snippet = "";
		String from = "";
		String to = "";
		String subject = "";
		int mailSize = 0;
		LocalDateTime mailDate;
		String empEmail = mailDAO.selectEmployeeEmailAddress(empId);
//        List<MailTrashVO> trashList = new ArrayList<>();

		List<MailBoxVO> mailBeforeTransList = new ArrayList<>();
		for (Message message : trashList) {
			if (message != null) {

				MailTrashVO trashDB = new MailTrashVO();
				messageId = message.getId();
				log.info("휴지통 메일 식별자 : {}", messageId);
				trashDB.setEmpId(empId);
				trashDB.setMailMessageId(messageId);

				// ------------------- 받은 메일, 보낸 메일, 임시보관 메일 어느쪽인지 확인하기 시작 -------------------
				MailBoxVO checkTable = new MailBoxVO();
				checkTable.setEmpId(empId);
				checkTable.setReceiverInfo(empId);// 받는 메일 조회용
				checkTable.setMailMessageId(messageId);

				MailBoxVO inboxTrans = new MailBoxVO();
				int inboxBeing = mailService.retrieveBeingMailInbox(checkTable);
				int sentBeing = mailService.retrieveBeingMailSent(checkTable);
				int draftBeing = mailService.retrieveBeingMailDraft(checkTable);
				log.info("기존 메일 확인 : 받은 메일 : {}", inboxBeing);
				log.info("기존 메일 확인 : 보낸 메일 : {}", sentBeing);
				log.info("기존 메일 확인 : 임시보관함 : {}", draftBeing);
				int what = 0;// 받은 메일 1, 보낸 메일 2, 임시보관 메일 3
				if (inboxBeing > 0) {
//				log.info("받은 메일 진입");
					// 받는 메일인 경우
					mailBeforeTransList = mailService.retrieveEmailWithAttachment(checkTable);// DB에서 받은 메일 데이터 가져오기
					int result = mailDAO.deleteInboxBeforeTrashDB(checkTable);// DB에 있는 받은 메일 데이터 삭제하기
					log.info("휴지통 이전에 DB 받은 메일 삭제 : {}", result);

					for (MailBoxVO mailBox : mailBeforeTransList) {
						trashDB.setEmpId(mailBox.getReceiverInfo());
						trashDB.setMailMessageId(inboxTrans.getMailMessageId());
						trashDB.setMailDate(inboxTrans.getMailInboxDate());
						trashDB.setMailTrashFrom(mailBox.getSender());
						trashDB.setMailTrashTo(mailDAO.selectEmployeeEmailAddress(empId));
						trashDB.setMailTrashSnippet(mailBox.getMailSnippet());
						trashDB.setMailTrashSubject(mailBox.getMailInboxTitle());
						trashDB.setMailTrashContent(mailBox.getMailInboxContent());
						trashDB.setMailAttachmentId(mailBox.getMailAttachmentId());
						trashDB.setMailAttachmentName(mailBox.getMailAttachmentName());
						trashDB.setMailAttachmentMimeType(mailBox.getMailAttachmentMimeType());
						int insertTrashFromInbox = mailDAO.insertTrashFromInbox(trashDB);
						log.info(" 받은 메일 -> 휴지통 DB에 입력 준비 : {}", insertTrashFromInbox);
						int is = mailDAO.selectCountTrashBeingInbox(trashDB);
						if (is < 1) {
							what = 1;

						}
					}
				} else if (sentBeing > 0) {

//				log.info("보낸 메일 진입");
					// 보낸 메일인 경우
					mailBeforeTransList = mailDAO.selectSentBeforeTrashDB(checkTable);// DB에서 보낸 메일 데이터 가져오기
					int result = mailDAO.deleteSentBeforeTrashDB(checkTable);// DB에 있는 보낸 메일 데이터 삭제하기
//				log.info("휴지통 이전에 DB 보낸 메일 삭제 : {}", result);

					for (MailBoxVO mailBox : mailBeforeTransList) {
						trashDB.setEmpId(mailBox.getReceiverInfo());
						trashDB.setMailMessageId(inboxTrans.getMailMessageId());
						trashDB.setMailDate(inboxTrans.getMailInboxDate());
						trashDB.setMailTrashFrom(mailBox.getSender());
						trashDB.setMailTrashTo(mailDAO.selectEmployeeEmailAddress(empId));
						trashDB.setMailTrashSnippet(mailBox.getMailSnippet());
						trashDB.setMailTrashSubject(mailBox.getMailInboxTitle());
						trashDB.setMailTrashContent(mailBox.getMailInboxContent());
						trashDB.setMailAttachmentId(mailBox.getMailAttachmentId());
						trashDB.setMailAttachmentName(mailBox.getMailAttachmentName());
						trashDB.setMailAttachmentMimeType(mailBox.getMailAttachmentMimeType());
						int insertTrashFromInbox = mailDAO.insertTrashFromInbox(trashDB);
						log.info(" 보낸 메일 -> 휴지통 DB에 입력 준비 : {}", insertTrashFromInbox);
						int is = mailDAO.selectCountTrashBeingSent(trashDB);
						if (is < 1) {
							what = 2;

						}
					}
				} else if (draftBeing > 0) {

//				log.info("임시보관 메일 진입");
					// 임시 보관 중인 메일인 경우
					draftBeing = mailService.retrieveBeingMailDraft(checkTable);
					mailBeforeTransList = mailDAO.selectDraftBeforeTrashDB(checkTable);// DB에서 임시보관 중인 메일 데이터 가져오기
					int result = mailDAO.deleteDraftBeforeTrashDB(checkTable);// DB에 있는 임시보관 중인 메일 데이터 삭제하기
					log.info("휴지통 이전에 DB 임시보관 중 메일 삭제 : {}", result);
					for (MailBoxVO mailBox : mailBeforeTransList) {
						trashDB.setEmpId(mailBox.getReceiverInfo());
						trashDB.setMailMessageId(inboxTrans.getMailMessageId());
						trashDB.setMailDate(inboxTrans.getMailInboxDate());
						trashDB.setMailTrashFrom(mailBox.getSender());
						trashDB.setMailTrashTo(empEmail);
						trashDB.setMailTrashSnippet(mailBox.getMailSnippet());
						trashDB.setMailTrashSubject(mailBox.getMailInboxTitle());
						trashDB.setMailTrashContent(mailBox.getMailInboxContent());
						trashDB.setMailAttachmentId(mailBox.getMailAttachmentId());
						trashDB.setMailAttachmentName(mailBox.getMailAttachmentName());
						trashDB.setMailAttachmentMimeType(mailBox.getMailAttachmentMimeType());
						int insertTrashFromInbox = mailDAO.insertTrashFromInbox(trashDB);
//					log.info(" 보낸 메일 -> 휴지통 DB에 입력 준비 : {}", insertTrashFromInbox);
						int is = mailDAO.selectCountTrashBeingDraft(trashDB);
						if (is < 1) {
							what = 3;
						}
					}

				} else {
					log.info("기존 DB에 등록된 어느 메일에도 속하지 않는 경우");
					log.info("휴지통 메일 종류 what : {}", what);
				}
				// ------------------- 받은 메일, 보낸 메일, 임시보관 메일 어느쪽인지 확인하기 종료 -------------------
				snippet = message.getSnippet();

				try {
					MessagePart payload = message.getPayload();
					log.info("페이로드 확인 : {}", payload);

					if (payload != null) {

						headers = message.getPayload().getHeaders();
						trashDB.setMailTrashSnippet(snippet);
						List<MessagePart> parts = message.getPayload().getParts();
						mailSize = message.getSizeEstimate();

						long internalDate = message.getInternalDate();
						Instant instant = Instant.ofEpochMilli(internalDate);
						mailDate = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
						trashDB.setMailDate(mailDate);

						// 보내는 사람, 받는 사람, 제목
						for (MessagePartHeader header : headers) {
							log.info("헤더 추출 이전 : {}", header);
							if ("From".equals(header.getName())) {
								from = header.getValue();
								trashDB.setMailTrashFrom(from);
								log.info("보내는 사람 : {}", from);

								String fromName = "";
								String fromAddr = "";
								String fromPattern = "\"([^\"]*)\"\\s<([^>]*)>";
								Pattern pattern = Pattern.compile(fromPattern);
								Matcher matcher = pattern.matcher(from);
								if (matcher.find()) {
									fromName = matcher.group(1);
									fromAddr = matcher.group(2);
//							log.info("fromName : {}", fromName);
//							log.info("fromAddr : {}", fromAddr);
									trashDB.setFromName(fromName);
									trashDB.setFromAddr(fromAddr);
								}
							}
							if ("To".equals(header.getName())) {
								to = header.getValue();
								trashDB.setMailTrashTo(to);
//						log.info("받는 사람 : {}", to);

								String toName = "";
								String toAddr = "";
								String fromPattern = "\"([^\"]*)\"\\s<([^>]*)>";
								Pattern pattern = Pattern.compile(fromPattern);
								Matcher matcher = pattern.matcher(to);
								if (matcher.find()) {
									toName = matcher.group(1);
									toAddr = matcher.group(2);
//							log.info("toName : {}", toName);
//							log.info("toAddr : {}", toAddr);
									trashDB.setFromName(toName);
									trashDB.setFromAddr(toAddr);
								}
							}
							if ("Subject".equals(header.getName())) {
								subject = header.getValue();
								trashDB.setMailTrashSubject(subject);
//						log.info("제목 : {}", subject);
							}
						}

						String content = "";
						// 내용
						for (MessagePart part : parts) {
							if ("text/html".equals(part.getMimeType())) {
								content = part.getBody().getData();
							} else if ("text/plain".equals(part.getMimeType())) {
								content = part.getBody().getData();
							} else if ("multipart/alternative".equals(part.getMimeType())) {
								List<MessagePart> contentMulti = part.getParts();
								for (MessagePart messagePart : contentMulti) {
									if ("text/html".equals(messagePart.getMimeType())) {
										content = messagePart.getBody().getData();
										break;
									} else if ("text/plain".equals(messagePart.getMimeType())) {
										content = messagePart.getBody().getData();
										break;
									}
								}
							}

							byte[] dataBytes = Base64Utils.decodeFromUrlSafeString(content);
							String body = new String(dataBytes, StandardCharsets.UTF_8);

							inboxTrashVO.setMailSendContent(body);
							trashDB.setMailTrashContent(body);
//					log.info("메일 내용 확인 : {}", body);
							break;
						}

						trashOrgList.add(trashDB);

						// 첨부파일
						List<MailTrashVO> attachMoveList = new ArrayList<>();
						for (MessagePart part : parts) {
							MailTrashVO attachMove = new MailTrashVO();
							try {
//						log.info("첨부파일 존재 확인 : {}", part.getFilename().getBytes());
								byte[] bytes = part.getFilename().getBytes();
								if (bytes.length > 0) {
									String filename = part.getFilename();
									String fileMimeType = part.getMimeType();
									String fileId = part.getBody().getAttachmentId();
									int fileSize = part.getBody().getSize();

									attachMove.setMailMessageId(trashDB.getMailMessageId());
									attachMove.setMailAttachmentId(fileId);
									attachMove.setMailAttachmentName(filename);
									attachMove.setMailAttachmentMimeType(fileMimeType);
									attachMove.setMailAttachmentSize(fileSize);

									MailBoxVO reqAttach = new MailBoxVO();
									reqAttach.setMailMessageId(inboxTrashVO.getMailMessageId());
									reqAttach.setMailAttachmentId(fileId);

									MailBoxVO respAttach = new MailBoxVO();
									respAttach = mailStoreGmailService.getAttachFromGmail(empId, reqAttach);

									attachMove.setMailAttachment(respAttach.getMailAttachmentFile());
									attachMoveList.add(attachMove);

//							log.info("첨부파일 데이터 확인 : {}", attachMove);

									MailBoxVO ready = new MailBoxVO();
									ready.setMailMessageId(inboxTrashVO.getMailMessageId());
									ready.setMailAttachmentId(fileId);
									ready.setEmpId(empId);
									ready.setMailSnippet(inboxTrashVO.getMailSnippet());
								}
							} catch (NullPointerException e) {
							} catch (IOException e) {
								throw new RuntimeException(e);
							}

						}

//				for (MailTrashVO vo1 : trashOrgList) {
//					for (MailTrashVO vo : attachMoveList) {
//						if (vo1.getMailMessageId().equals(vo.getMailMessageId())) {
//							trashDB.setMailAttachmentId(vo.getMailAttachmentId());
//							trashDB.setMailAttachmentName(vo.getMailAttachmentName());
//							trashDB.setMailAttachmentMimeType(vo.getMailAttachmentMimeType());
//							trashDB.setMailAttachmentSize(vo.getMailAttachmentSize());
//							trashDB.setMailAttachment(vo.getMailAttachment());
//							trashOrgList.add(trashDB);
//						}
//					}
//				}

						int trash = 0;
//				log.info("what : {}", what);
						int duplicate = mailService.retreiveCountTrashBeing(trashDB);
						if (duplicate < 1) {
							switch (what) {
							case 0:
								trash = mailService.createTrash(trashDB);
//								log.info("메일 휴지통 행 : {}", trash);
								break;
							case 1:
								trash = mailService.createTrashFromInbox(trashDB);
//								log.info("받은 메일 휴지통 행 : {}", trash);
								break;
							case 2:
								trash = mailService.createTrashFromSent(trashDB);
//								log.info("보낸 메일 휴지통 행 : {}", trash);
								break;

							case 3:
								trash = mailService.createTrashFromDraft(trashDB);
//								log.info("임시보관 메일 휴지통 행 : {}", trash);
								break;
							}
						}

						trashOrgList.add(trashDB);
						log.info("행 확인 : {}", trashOrgList);
					}
				} catch (NullPointerException e) {
				}

			}
		}

		log.info("DB 저장 : {}", trashOrgList);
		log.info("기존 DB 정리하고 휴지통에 저장하기 메서드 종료");
		return trashOrgList;
	}

	public void sendReadyDelete(MailSendVO mailSendVO) throws MessagingException, IOException {
		String empId = mailSendVO.getEmpId();
		String messageId = mailSendVO.getMailMessageId();

//		log.info("[MailService] [sendReadyTrash] '메일을 휴지통으로 보내기 요청'하기 메서드 진입");

		// 1. 구글로부터 자격 얻기 + HTTP 요청 초기화
		// (1) 구글 서비스를 사용하는 애플리케이션 자격 증명 가져오기
//            GoogleCredentials credentials = GoogleCredentials.fromStream(jsonAuthInputStream).createScoped(GmailScopes.MAIL_GOOGLE_COM);
		// Gmail API를 통해 이메일 보내는 권한 얻기
		MailClientVO mailClientVO = mailService.retrieveEmailTokens(empId);
		String accessToken = mailClientVO.getAccessToken();
		GoogleCredential credentials = new GoogleCredential().setAccessToken(accessToken);
		// (2) Google의 서비스를 호출하는 HTTP 요청을 초기화 하고 구성 : 인터페이스 HttpRequestInitializer
		// HttpRequestInitializer requestInitializer = new
		// HttpCredentialsAdapter(credentials);

		// 2. Gmail API로 Gmail 서비스를 생성
		MailAuthVO mailAuthVO = new MailAuthVO();
		Gmail gmailAPIService = new Gmail.Builder(new NetHttpTransport(), // HTTP 요청 생성-보내기-응답 받기
				GsonFactory.getDefaultInstance(), // JSON 데이터를 생성-파싱 (Gmail API의 송수신 데이터 형식 : JSON)
				credentials // HTTP 요청의 구성을 가진 객체
		).setApplicationName(mailAuthVO.getOAuthApplicationName()).build();// Gmail 서비스 생성 완료

		// 3. MIME 형식의 이메일 메시지 생성 (전송을 MIME만으로 함) = 편지봉투+편지지 작성
		Properties props = new Properties(); // (1) '이메일 송수신할 때, 그 설정과 속성을 저장할 메일 세션'을 설정하기 위한 객체 (키-값 쌍(String)으로 저장)
		Session session = Session.getDefaultInstance(props, null); // (2) Properties, Authenticator 입력
		// (Authenticator 객체) : Gmail 서버에 접근할 때 필요한 인증 정보를 제공하는 객체
		// Session : 이메일을 보내는 데 필요한 정보, 설정을 가지는 JavaMail 세션 (여기에서는 기본 설정 사용)

		// 5. 이메일 메세지를 Gmail 서버에 보내고 응답 받기
		// Gmail 서비스로 이메일 메시지를 보내기 : 구글 제공 Message로 보내고 받음
		// send() 파라미터 2개 : 보내는 사람 계정, 메시지
		gmailAPIService.users().messages().delete("me", messageId).execute();// 작업을 실제로 수행하는 메서드

//		log.info("삭제 성공");
	}

	@Override
	public int createTrashFromSent(MailTrashVO mailTrashVO) {
		return mailDAO.insertTrashFromSent(mailTrashVO);
	}

	@Override
	public int createTrashFromDraft(MailTrashVO mailTrashVO) {
		return mailDAO.insertTrashFromDraft(mailTrashVO);
	}

	/**
	 * 받은 메일에 존재 확인
	 *
	 * @param mailbox
	 * @return 있음 1, 없음 0
	 */
	public int retrieveBeingMailInbox(MailBoxVO mailbox) {
		return mailDAO.selectCntNullForDel(mailbox);
	}

	public int retrieveBeingMailSent(MailBoxVO mailbox) {
		return mailDAO.selectSentBeing(mailbox);
	}

	public int retrieveBeingMailDraft(MailBoxVO mailbox) {
		return mailDAO.selectDraftBeing(mailbox);
	}

	public int createTrashFromInbox(MailTrashVO mailTrashVO) {
		return mailDAO.insertTrashFromInbox(mailTrashVO);
	}

	public List<MailTrashVO> retrieveViewFromDBTrash(MailBoxVO mailBoxVO) {
		List<MailTrashVO> viewList = mailDAO.selectViewFromDBTrash(mailBoxVO);
		return viewList;
	}

	public List<MailTrashVO> retrieveTrashIdListFromDB(String empId) {
		List<MailTrashVO> viewList = mailDAO.selectTrashIdListFromDB(empId);
		return viewList;
	}

	@Override
	public int retreiveCountTrashBeing(MailTrashVO mailTrashVO) {
		return mailDAO.selectCountTrashBeing(mailTrashVO);
	}

	public int createTrash(MailTrashVO mailTrashVO) {
		return mailDAO.insertTrash(mailTrashVO);
	}

	public List<MailBoxVO> retrieveViewDetailSent(MailBoxVO mailBoxVO) {
		return mailDAO.selectViewDetailSent(mailBoxVO);
	}

	public List<MailBoxVO> retrieveADraftFromDB(MailBoxVO mailBoxVO) {
		return mailDAO.selectADraftFromDB(mailBoxVO);
	}

	public List<MailBoxVO> retrieveDownSent(MailBoxVO mailBoxVO) {
		return mailDAO.selectDownloadSent(mailBoxVO);
	}

	public List<MailBoxVO> retrieveDownInbox(MailBoxVO mailBoxVO) {
		return mailDAO.selectDownloadInbox(mailBoxVO);
	}

	public List<MailBoxVO> retrieveDownTrash(MailBoxVO mailBoxVO) {
		return mailDAO.selectDownloadTrash(mailBoxVO);
	}
}
