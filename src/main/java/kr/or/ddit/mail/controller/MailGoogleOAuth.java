package kr.or.ddit.mail.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.mail.dao.MailDAO;
import kr.or.ddit.mail.service.MailAuthService;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.vo.MailAuthVO;
import kr.or.ddit.mail.vo.MailClientVO;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.net.URI;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.*;

/**
 * 메일 기능을 최초로 사용하는 경우, 1. 구글 OAuth 서버의 인가코드를 요청 2. 구글 OAuth 서버로부터 인가코드를 받아서 토큰
 * 요청 뷰 jsp 페이지로 이동 3. 토큰 요청 뷰 jsp 로부터 토큰 및 토큰 관련 정보를 받아와서 DB에 저장
 */
@Slf4j
@Controller
@RequestMapping("/mail/authorization")
public class MailGoogleOAuth {

	@Inject
	MailService mailService;

	// 암호화
	@Inject
	private PasswordEncoder encoder;

	@Inject
	private MailAuthService mailAuthService;
	
	@Inject
	private MailDAO mailDao;

	/**
	 * 구글 OAuth 서버로 인가 코드를 요청하는 메서드
	 *
	 * @param request  : 세션에 state 값 저장 (인가 코드 받은 후 다시 동일성 체크를 위해 필요함)
	 * @param response : 외부 URL로 리다이렉트
	 * @throws IOException
	 */
	@GetMapping("/authorizationRequest.do")
	public void authorizationRequest(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException {
//        log.info("인가 흐름 시작");
		String empId = authentication.getName();
		String employeeEmailAddress = mailService.retrieveEmployeeEmailAddress(empId);

		if (!employeeEmailAddress.equals(null) && !employeeEmailAddress.equals("")) {
//            log.info("1. 인가 받으러 가기 진입");
			HttpSession session = request.getSession();
			MailAuthVO authVO = new MailAuthVO();
			authVO.setEmployeeMailAddress(employeeEmailAddress);// 인가 대상 계정

			// state 토큰 값 만들기
			String state = new BigInteger(130, new SecureRandom()).toString(32);
			// String state = UUID.randomUUID().toString();
			session.setAttribute("state", state);

			// ----------------------------------------- 구글 인가 요청 URI 만들기 시작
			// ------------------------------------
			String gmailAuthInfoPath = "/kr/or/ddit/mailAuth/client_secret_950837281368-po52i454iv9ttb38gbmp8trg6iud7ukq.apps.googleusercontent.com.json";
			InputStream is = getClass().getClassLoader().getResourceAsStream(gmailAuthInfoPath);
			ObjectMapper om = new ObjectMapper();
			Map<String, Object> test = om.readValue(is, new TypeReference<Map<String, Object>>() {
			});
//            log.info("JSON 파일 읽어오기 Map : {}", test.toString());
			Map<String, Object> googleAuthInfos = (Map<String, Object>) test.get("web");
//            log.info("구글 인가 정보 Map : {}", googleAuthInfos.toString());

			String clientId = googleAuthInfos.get("client_id").toString();
			String projectId = googleAuthInfos.get("project_id").toString();
			String authUri = googleAuthInfos.get("auth_uri").toString();
			String tokenUri = googleAuthInfos.get("token_uri").toString();
			String certUrl = googleAuthInfos.get("auth_provider_x509_cert_url").toString();
			String clientSecret = googleAuthInfos.get("client_secret").toString();
			List<String> redirectUris = (List<String>) googleAuthInfos.get("redirect_uris");
			List<String> javascriptOrigins = (List<String>) googleAuthInfos.get("javascript_origins");

//            포트번호에 따라 맞는 URI 사용
//            http://localhost:8880/
//            http://localhost/
//            http://localhost:8080/

//            log.info("서버 포트 확인하기");
			int serverPort = request.getServerPort();// 포트번호 가져오기
//            log.info("서버 포트번호 : {}", serverPort);
			// 일치하는 포트번호를 가진 URI 찾기
			String selectedRedirectUri = null;
			for (String redirectUri : redirectUris) {
//                log.info("확인 URI : {}", redirectUri);
				URI uri = URI.create(redirectUri);// String -> URI
//                log.info("URI의 포트번호 추출 : {}", uri.getPort());
				if ((uri.getPort() == -1 && serverPort == 80) || uri.getPort() == serverPort) {
//                    log.info("일치 포트 찾음");
					selectedRedirectUri = redirectUri;
//                    log.info("일치 URI : {}", selectedRedirectUri);
					break;// for문 탈출
				}
			}

			// 구글 인가 서버로 리다이렉트할 URL 만들기
            String authorizationRequestURL = "https://accounts.google.com/o/oauth2/auth?scope={scope}&access_type={accessType}&redirect_uri={redirectUri}&client_id={clientId}&response_type={responseType}&state={state}&login_hint={loginHint}&prompt={prompt}";
//			String authorizationRequestURL = "https://accounts.google.com/o/oauth2/auth?scope={scope}&access_type={accessType}&redirect_uri={redirectUri}&client_id={clientId}&response_type={responseType}&state={state}&login_hint={loginHint}";
			String finalAuthorizationRequestURL = UriComponentsBuilder.fromUriString(authorizationRequestURL)
					.buildAndExpand(authVO.getScope(), "offline", selectedRedirectUri, clientId,
							authVO.getResponseType(), state, authVO.getEmployeeMailAddress(), "consent")
					.toUriString();
//                            , "consent"

			// ----------------------------------------- 구글 인가 요청 URI 만들기 종료
			// ------------------------------------

//            log.info("구글 인가 서버 authorizationRequestURL 확인 : {}", finalAuthorizationRequestURL);
//            log.info("구글 인가 서버로 리다이렉트");
			response.sendRedirect(finalAuthorizationRequestURL);// 외부 URL 리다이렉트
		} else {
//            log.info("최종 사용자의 이메일 주소가 없음");
			response.sendRedirect("/");
		}

	}

	/**
	 * 구글 인가 서버가 해당 웹 어플리케이션을 확인하여 인가한 뒤(웹 어플리케이션 측에서 다루지 않음), 해당 웹 어플리케이션은 구글 인가
	 * 서버로부터 인가 코드를 받는다.
	 * <p>
	 * 그 인가 코드에 담긴 state 정보를 세션에 저장해놓은 state 정보와 동일성 체크를 하여, 중간에 인가 요청이 위조되지 않았는지
	 * 확인한다.
	 * <p>
	 * 위조 여부를 통과하면 그 인가 코드로 최종 사용자의 메일 계정에 부여되는 액세스 토큰과 리프레시 토큰을 받기 위한 요청을 보내는 뷰
	 * jsp로 이동한다.
	 * <p>
	 * code : 구글 인가 서버로부터 받은 인가 코드 state : 인가 요청 당시 웹 어플리케이션이 생성하여 세션에 저장해놓은 state와
	 * 동일해야 함 scope : 인가 요청 당시 웹 어플리케이션이 요청한 권한 범위
	 *
	 * @param model    : 토큰 요청 뷰 jsp에 보낼 (토큰 요청에 필요한) 정보를 담음
	 * @param request  : 세션으로 부터 state 데이터 가져오기 용
	 * @param response : 인가 코드가 위조된 경우 오류 정보 반환용
	 * @return
	 */
	@GetMapping(value = "/oauth2callback.do")
	public String authorizationCodeHandleCallback(@RequestParam(value = "code") String code,
			@RequestParam(value = "state") String state, @RequestParam(value = "scope") String scope, Model model,
			HttpServletRequest request, HttpServletResponse response, Authentication authentication,
			HttpSession session) {
//        log.debug("[MailGoogleOAuth] : authorizationCodeHandleCallback 진입 : /mail/authorization/oauth2callback.do");
		model.addAttribute("level1Menu", "mail");
		model.addAttribute("level2Menu", "mailInbox");
		String empId = authentication.getName();// 웹 어플리케이션 ID

		if (!code.equals(null) && !code.equals("")) {
//            log.info("인가 코드 발급 확인 : {}", code);
//            log.debug("----------------------------------");
//            log.debug("1.5 구글 로그인 완료");
//            log.debug("2. 인가 코드 받음");

			{
				// 인가 요청에 위조 체크
				if (!state.equals(session.getAttribute("state"))) {
					response.setStatus(401);
					model.addAttribute("message", "유효하지 않은  state 파라미터");
					// return "redirect:/";
				}
			}

			// 오류 응답
			// String deniedResponse =
			// "https://oauth2.example.com/auth?error=access_denied";
			// 승인 응답
			// String okResponse =
			// "https://oauth2.example.com/auth?code=4/P7q7W91a-oMsCeLvIaQm6bTrgtp7";

			Map<String, Object> datasForTokens = new HashMap<>();
			{
				// 토큰 요청 자료 만들기
				try {
					datasForTokens = mailAuthService.infoForReqTokens(code);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//                log.debug("[MailGoogleOAuth] 토큰 요청 자료 : {}", datasForTokens);
			}

			MailClientVO mailClientVO = new MailClientVO();

//            log.info("3. 리프레시 토큰 여부 확인");
			MailClientVO refreshCheckVO = new MailClientVO();
			refreshCheckVO = mailService.retrieveAllAboutRefreshToken(empId);

			try {
//            log.info(" 리프레시 토큰 DB : {}", refreshCheckVO.getRefreshToken());
			} catch (NullPointerException e) {
			}

			String empEmail = mailService.retrieveEmployeeEmailAddress(empId);
			mailClientVO.setEmpId(empId);

//            log.info(" 리프레시 토큰 여부 확인 전, mailClientVO 확인 : {}", mailClientVO);
			String accessToken;
			String refreshToken;

			try {
				refreshCheckVO.getRefreshTokenExpiresAt();

				{
//                    log.info("refreshCheckVO.getRefreshTokenExpiresAt() 가 null이 아닌 경우 : {}", refreshCheckVO.getRefreshTokenExpiresAt());
//                    log.info("3-1. 리프레시 토큰 만료시간 존재");
					try {
						refreshCheckVO.getRefreshToken();

//                        log.debug("[MailGoogleOAuth] 4-1. 리프레시 토큰 존재");
//                        log.debug(" 리프레시 토큰을 제외한 액세스 토큰 요청");

						// 액세스 토큰 유효 확인
						// 토큰 유효 확인 반환 : return "OK";
						String checkTokens = mailAuthService.checkTokens(empId);
						if (checkTokens.equals("OK")) {
							accessToken = mailService.retrieveEmailTokens(empId).getAccessToken();// 액세스

//							log.info("액세스 토큰 확인 : {}", accessToken);
							if (accessToken != null || accessToken != "") {
								mailClientVO = mailAuthService.getAgainAccessToken(empId);
//								log.info("토큰 조회 : {}", mailClientVO);
							}
						} else {
							// 유효하지 않음
//							log.info("받은 메일함 진입 액세스 토큰 유효하지 않음");
							session.setAttribute("inbox", "redirect:/mail/mailInbox/mailInboxOpen.do");
							return "redirect:/mail/authorization/authorizationRequest.do";
						}

//                        log.info(" 액세스 토큰 요청 결과 : {}", mailClientVO);

						// 토큰 만료시간 구하기
						LocalDateTime responseDateTime = mailClientVO.getResponseDateTime();// 토큰 응답 시간
						int accessValidSec = Integer.parseInt(mailClientVO.getExpiresIn());// 액세스 토큰 유효 시간(단위 : 초)

//                        log.debug("토큰 만료시간 구하기");
						LocalDateTime accessTokenExpiresAtTime = responseDateTime.plusSeconds(accessValidSec);
//                        log.debug("액세스 토큰 만료일시 : {}", accessTokenExpiresAtTime);
						mailClientVO.setAccessTokenExpiresAt(accessTokenExpiresAtTime);

						accessToken = mailClientVO.getAccessToken();

						MailClientVO refreshCheckAfterVO = new MailClientVO();

						refreshCheckAfterVO = mailService.retrieveAllAboutRefreshToken(empId);

						mailClientVO.setRefreshToken(refreshCheckAfterVO.getRefreshToken());
						refreshToken = mailClientVO.getRefreshToken();
						mailClientVO.setRefreshTokenExpiresAt(refreshCheckAfterVO.getRefreshTokenExpiresAt());

						// DB 저장 필요
						int result = mailService.updateEmailTokens(mailClientVO);
//						log.info("업데이트 결과 : {}", result);

						if (result == 1) {
//                            log.debug("DB 토큰 저장 성공");
							// ------------------- 다른 기능 진행 중 온 경우 돌아가기 시작 -------------------
							String sessionForm = "";// 메일 쓰기 폼 진행 중에 온 경우
							String sessionInbox = "";// 받은 메일함 진행 중에 온 경우
							String sessionSent = "";// 보낸 메일함 진행 중에 온 경우
							String sessionDraft = "";// 임시 보관함 진행 중에 온 경우
							String sessionSentToPath = "";// 메일 쓰기 - 전송 진행 중에 온 경우
							String sessionTrash = "";// 휴지통 진행 중에 온 경우
							int db = 0;// DB 입력 결과
							try {
								sessionForm = (String) session.getAttribute("form");
								if (sessionForm != null && sessionForm != "") {
//									MailClientVO mcvo = new MailClientVO();
//									mcvo.setEmpId(empId);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 메일 쓰기 폼 재진입 : {}", sessionForm);
									return sessionForm;
								} else if (session.getAttribute("inbox") != null
										&& session.getAttribute("inbox") != "") {
									sessionInbox = (String) session.getAttribute("inbox");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 받은 메일함 재진입 : {}", sessionInbox);
									return sessionInbox;
								} else if (session.getAttribute("sent") != null && session.getAttribute("sent") != "") {
									sessionSent = (String) session.getAttribute("sent");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 보낸 메일함 재진입 : {}", sessionSent);
									return sessionSent;
								} else if (session.getAttribute("draft") != null
										&& session.getAttribute("draft") != "") {
									sessionDraft = (String) session.getAttribute("draft");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시보관함 재진입 : {}", sessionDraft);
									return sessionDraft;
								} else if (session.getAttribute("sentToPath") != null
										&& session.getAttribute("sentToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("sentToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("sentToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 메일 쓰기 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftToPath") != null
										&& session.getAttribute("draftToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftUpdateToPath") != null
										&& session.getAttribute("draftUpdateToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftUpdateToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftUpdateToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 다시 임시 보관 요청 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftFinalToPath") != null
										&& session.getAttribute("draftFinalToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftFinalToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftFinalToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if(session.getAttribute("access") != null
										&& session.getAttribute("access") != "") {									
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 로그인 후 최초 접근 완료");
									return null;
								} else if(session.getAttribute("trash") != null
										&& session.getAttribute("trash") != "") {									
									sessionTrash = (String) session.getAttribute("sessionTrash");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
									return sessionTrash;
								}
							} catch (NullPointerException e) {
							}
							// ------------------- 다른 기능 진행 중 온 경우 돌아가기 종료 -------------------

							return "redirect:/mail/mailInbox/mailInboxOpen.do";
						} else {
//                            log.debug("DB 토큰 저장 실패");
							return "redirect:/";
						}
					} catch (NullPointerException e) {
						throw new RuntimeException(e);
					} finally {

//                        log.info("[MailGoogleOAuth] 4-2. 리프레시 토큰 없음");
//                        log.debug(" 전체 재발급");
						mailClientVO = mailAuthService.reqTokens(datasForTokens, request, empId);
						mailClientVO.setEmpId(empId);
//                        log.info(" 전체 토큰 요청 결과 : {}", mailClientVO);
						LocalDateTime responseDateTime = mailClientVO.getResponseDateTime();// 토큰 응답 시간
						int accessValidSec = Integer.parseInt(mailClientVO.getExpiresIn());// 액세스 토큰 유효 시간(단위 : 초)
						int refreshValidDay = mailClientVO.getRefreshTokenExpiresInDays();// 리프레시 토큰 유효 시간(단위 : 일)

//                        log.debug("토큰 만료시간 구하기");
						LocalDateTime accessTokenExpiresAtTime = responseDateTime.plusSeconds(accessValidSec);
//                        log.debug("액세스 토큰 만료일시 : {}", accessTokenExpiresAtTime);
						mailClientVO.setAccessTokenExpiresAt(accessTokenExpiresAtTime);
						LocalDateTime refreshTokenExpiresAt = responseDateTime.plusDays(refreshValidDay);
//                        log.debug("리프레시 토큰 만료일시 : {}", refreshTokenExpiresAt);
						mailClientVO.setRefreshTokenExpiresAt(refreshTokenExpiresAt);
//                        log.debug(" 전체 토큰 확인 : {}", mailClientVO);

						// DB 저장 필요
//                        log.debug("DB 토큰 저장");
						int result = mailService.updateEmailTokens(mailClientVO);

						if (result == 1) {
//                            log.debug("DB 토큰 저장 성공");
							// ------------------- 다른 기능 진행 중 온 경우 돌아가기 시작 -------------------
							String sessionForm = "";// 메일 쓰기 폼 진행 중에 온 경우
							String sessionInbox = "";// 받은 메일함 진행 중에 온 경우
							String sessionSent = "";// 보낸 메일함 진행 중에 온 경우
							String sessionDraft = "";// 임시 보관함 진행 중에 온 경우
							String sessionSentToPath = "";// 메일 쓰기 - 전송 진행 중에 온 경우
							String sessionTrash = "";// 휴지통 진행 중에 온 경우
							int db = 0;// DB 입력 결과
							try {
								sessionForm = (String) session.getAttribute("form");
								if (sessionForm != null && sessionForm != "") {
//									MailClientVO mcvo = new MailClientVO();
//									mcvo.setEmpId(empId);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 메일 쓰기 폼 재진입 : {}", sessionForm);
									return sessionForm;
								} else if (session.getAttribute("inbox") != null
										&& session.getAttribute("inbox") != "") {
									sessionInbox = (String) session.getAttribute("inbox");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 받은 메일함 재진입 : {}", sessionInbox);
									return sessionInbox;
								} else if (session.getAttribute("sent") != null && session.getAttribute("sent") != "") {
									sessionSent = (String) session.getAttribute("sent");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 보낸 메일함 재진입 : {}", sessionSent);
									return sessionSent;
								} else if (session.getAttribute("draft") != null
										&& session.getAttribute("draft") != "") {
									sessionDraft = (String) session.getAttribute("draft");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시보관함 재진입 : {}", sessionDraft);
									return sessionDraft;
								} else if (session.getAttribute("sentToPath") != null
										&& session.getAttribute("sentToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("sentToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("sentToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 메일 쓰기 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftToPath") != null
										&& session.getAttribute("draftToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftUpdateToPath") != null
										&& session.getAttribute("draftUpdateToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftUpdateToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftUpdateToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 다시 임시 보관 요청 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if (session.getAttribute("draftFinalToPath") != null
										&& session.getAttribute("draftFinalToPath") != "") {
									sessionSentToPath = (String) session.getAttribute("draftFinalToPath");
									MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftFinalToVO");
									model.addAttribute("mailSendVO", mailSendVO);
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
									return sessionSentToPath;
								} else if(session.getAttribute("access") != null
										&& session.getAttribute("access") != "") {									
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 로그인 후 최초 접근 완료");
									return null;
								} else if(session.getAttribute("trash") != null
										&& session.getAttribute("trash") != "") {									
									sessionTrash = (String) session.getAttribute("sessionTrash");
									db = mailDao.updateEmployeeTokens(mailClientVO);
//									log.info("DB 저장 결과 : {}", db);
									session.invalidate();
//									log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
									return sessionTrash;
								}
							} catch (NullPointerException e) {
							}
							// ------------------- 다른 기능 진행 중 온 경우 돌아가기 종료 -------------------

							return "redirect:/mail/mailInbox/mailInboxOpen.do";
						} else {
//                            log.debug("DB 토큰 저장 실패");
							return "redirect:/";
						}
					}
				}

			} catch (NullPointerException e) {
				throw new RuntimeException(e);
			} finally {
//                log.debug("[MailGoogleOAuth] 3-2. 리프레시 토큰 만료시간 없음");
//                log.debug("[MailGoogleOAuth] 전체 재발급 요청");
				// datasForTokens : 토큰 요청 자료
				mailClientVO = mailAuthService.reqTokens(datasForTokens, request, empId);

//                log.debug("[MailGoogleOAuth] 전체 토큰 요청 결과 : {}", mailClientVO);

				LocalDateTime responseDateTime = mailClientVO.getResponseDateTime();// 토큰 응답 시간
				int accessValidSec = Integer.parseInt(mailClientVO.getExpiresIn());// 액세스 토큰 유효 시간(단위 : 초)
				int refreshValidDay = mailClientVO.getRefreshTokenExpiresInDays();// 리프레시 토큰 유효 시간(단위 : 일)

//                log.debug("토큰 만료시간 구하기");
				LocalDateTime accessTokenExpiresAtTime = responseDateTime.plusSeconds(accessValidSec);
//                log.debug("액세스 토큰 만료일시 : {}", accessTokenExpiresAtTime);
				mailClientVO.setAccessTokenExpiresAt(accessTokenExpiresAtTime);
				LocalDateTime refreshTokenExpiresAt = responseDateTime.plusDays(refreshValidDay);
//                log.debug("리프레시 토큰 만료일시 : {}", refreshTokenExpiresAt);
				mailClientVO.setRefreshTokenExpiresAt(refreshTokenExpiresAt);
//                log.debug(" 전체 토큰 확인 : {}", mailClientVO);
				// DB 저장 조건 (6가지 입력) : ① EMP_ID, ② ACCESS_TOKEN, ③REFRESH_TOKEN, ④ EXPIRES_IN, ⑤
				// ACCESS_TOKEN_EXPIRES_AT, ⑥ REFRESH_TOKEN_EXPIRES_AT

				mailClientVO.setEmpId(empId);
//                log.debug("[MailGoogleOAuth] DB 토큰 저장 전, DB 확인");
				if (Optional.ofNullable(mailService.retrieveEmailTokens(empId)).isPresent()) {
//                    log.debug("DB null 아닌 경우");
//                    log.debug("[MailGoogleOAuth] DB 업데이트");
					int result = mailService.updateEmailTokens(mailClientVO);
					if (result == 1) {
//                        log.debug("[MailGoogleOAuth] DB 토큰 저장 성공");
						// ------------------- 다른 기능 진행 중 온 경우 돌아가기 시작 -------------------
						String sessionForm = "";// 메일 쓰기 폼 진행 중에 온 경우
						String sessionInbox = "";// 받은 메일함 진행 중에 온 경우
						String sessionSent = "";// 보낸 메일함 진행 중에 온 경우
						String sessionDraft = "";// 임시 보관함 진행 중에 온 경우
						String sessionSentToPath = "";// 메일 쓰기 - 전송 진행 중에 온 경우
						String sessionTrash = "";// 휴지통 진행 중에 온 경우
						int db = 0;// DB 입력 결과
						try {
							sessionForm = (String) session.getAttribute("form");
							if (sessionForm != null && sessionForm != "") {
//								MailClientVO mcvo = new MailClientVO();
//								mcvo.setEmpId(empId);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 메일 쓰기 폼 재진입 : {}", sessionForm);
								return sessionForm;
							} else if (session.getAttribute("inbox") != null
									&& session.getAttribute("inbox") != "") {
								sessionInbox = (String) session.getAttribute("inbox");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 받은 메일함 재진입 : {}", sessionInbox);
								return sessionInbox;
							} else if (session.getAttribute("sent") != null && session.getAttribute("sent") != "") {
								sessionSent = (String) session.getAttribute("sent");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 보낸 메일함 재진입 : {}", sessionSent);
								return sessionSent;
							} else if (session.getAttribute("draft") != null
									&& session.getAttribute("draft") != "") {
								sessionDraft = (String) session.getAttribute("draft");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시보관함 재진입 : {}", sessionDraft);
								return sessionDraft;
							} else if (session.getAttribute("sentToPath") != null
									&& session.getAttribute("sentToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("sentToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("sentToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 메일 쓰기 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftToPath") != null
									&& session.getAttribute("draftToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftUpdateToPath") != null
									&& session.getAttribute("draftUpdateToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftUpdateToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftUpdateToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 다시 임시 보관 요청 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftFinalToPath") != null
									&& session.getAttribute("draftFinalToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftFinalToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftFinalToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if(session.getAttribute("access") != null
									&& session.getAttribute("access") != "") {									
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 로그인 후 최초 접근 완료");
								return null;
							} else if(session.getAttribute("trash") != null
									&& session.getAttribute("trash") != "") {									
								sessionTrash = (String) session.getAttribute("sessionTrash");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
								return sessionTrash;
							}
						} catch (NullPointerException e) {
						}
						// ------------------- 다른 기능 진행 중 온 경우 돌아가기 종료 -------------------
						return "redirect:/mail/mailInbox/mailInboxOpen.do";
					} else {
//                        log.debug("[MailGoogleOAuth] DB 토큰 저장 실패");
						return "redirect:/";
					}
				} else {
//                    log.debug("DB null인 경우");
//                    log.debug("[MailGoogleOAuth] DB CREATE");
					int result = mailService.createEmailTokens(mailClientVO);
					if (result == 1) {
//                        log.debug("[MailGoogleOAuth] DB 토큰 저장 성공");
						// ------------------- 다른 기능 진행 중 온 경우 돌아가기 시작 -------------------
						String sessionForm = "";// 메일 쓰기 폼 진행 중에 온 경우
						String sessionInbox = "";// 받은 메일함 진행 중에 온 경우
						String sessionSent = "";// 보낸 메일함 진행 중에 온 경우
						String sessionDraft = "";// 임시 보관함 진행 중에 온 경우
						String sessionSentToPath = "";// 메일 쓰기 - 전송 진행 중에 온 경우
						String sessionTrash = "";// 휴지통 진행 중에 온 경우
						int db = 0;// DB 입력 결과
						try {
							sessionForm = (String) session.getAttribute("form");
							if (sessionForm != null && sessionForm != "") {
//								MailClientVO mcvo = new MailClientVO();
//								mcvo.setEmpId(empId);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 메일 쓰기 폼 재진입 : {}", sessionForm);
								return sessionForm;
							} else if (session.getAttribute("inbox") != null
									&& session.getAttribute("inbox") != "") {
								sessionInbox = (String) session.getAttribute("inbox");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 받은 메일함 재진입 : {}", sessionInbox);
								return sessionInbox;
							} else if (session.getAttribute("sent") != null && session.getAttribute("sent") != "") {
								sessionSent = (String) session.getAttribute("sent");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 보낸 메일함 재진입 : {}", sessionSent);
								return sessionSent;
							} else if (session.getAttribute("draft") != null
									&& session.getAttribute("draft") != "") {
								sessionDraft = (String) session.getAttribute("draft");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시보관함 재진입 : {}", sessionDraft);
								return sessionDraft;
							} else if (session.getAttribute("sentToPath") != null
									&& session.getAttribute("sentToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("sentToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("sentToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 메일 쓰기 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftToPath") != null
									&& session.getAttribute("draftToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftUpdateToPath") != null
									&& session.getAttribute("draftUpdateToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftUpdateToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftUpdateToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 다시 임시 보관 요청 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if (session.getAttribute("draftFinalToPath") != null
									&& session.getAttribute("draftFinalToPath") != "") {
								sessionSentToPath = (String) session.getAttribute("draftFinalToPath");
								MailSendVO mailSendVO = (MailSendVO) session.getAttribute("draftFinalToVO");
								model.addAttribute("mailSendVO", mailSendVO);
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
								return sessionSentToPath;
							} else if(session.getAttribute("access") != null
									&& session.getAttribute("access") != "") {									
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 로그인 후 최초 접근 완료");
								return null;
							} else if(session.getAttribute("trash") != null
									&& session.getAttribute("trash") != "") {									
								sessionTrash = (String) session.getAttribute("sessionTrash");
								db = mailDao.updateEmployeeTokens(mailClientVO);
//								log.info("DB 저장 결과 : {}", db);
								session.invalidate();
//								log.info("토큰 흐름 후 임시 보관 최종 전송 재진입 : {}", sessionSentToPath);
								return sessionTrash;
							}
						} catch (NullPointerException e) {
						}
						// ------------------- 다른 기능 진행 중 온 경우 돌아가기 종료 -------------------

						return "redirect:/mail/mailInbox/mailInboxOpen.do";
					} else {
//                        log.debug("[MailGoogleOAuth] DB 토큰 저장 실패");
						return "redirect:/";
					}
				}
			}
		} else {
//            log.debug("인가 코드를 발급받지 못함");
			model.addAttribute("message", "인가 코드를 발급받지 못했습니다.");
			return "redirect:/";
		}

	}

}