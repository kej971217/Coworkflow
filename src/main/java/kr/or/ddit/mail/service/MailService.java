package kr.or.ddit.mail.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import com.google.api.services.gmail.model.Draft;
import com.google.api.services.gmail.model.Message;

import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailClientVO;
import kr.or.ddit.mail.vo.MailInboxVO;
import kr.or.ddit.mail.vo.MailSendVO;
import kr.or.ddit.mail.vo.MailTrashVO;

public interface MailService {

    /**
     * 최종 사용자의 웹 어플리케이션 ID를 통해,
     * 구글 계정(이메일 주소)을 가져오기
     * @param empId
     * @return 이메일 주소(String) 리턴
     */
    public String retrieveEmployeeEmailAddress(String empId);

    /**
     * 최종 사용자의 웹 어플리케이션 ID를 통해,
     * 메일 기능 최초 접근(구글 인가 서버로부터 토큰 발급) 확인
     * @param empId
     * @return 최초 접근(토큰 없음) : 0, 재 접근(토큰 있음) : 1
     */
    public int retrieveTokenForCheckBeing(String empId);

    /**
     * < 구글 인가 서버의 토큰 최초 발급 >
     * 구글 인가 서버로부터 발급받은 토큰 및 토큰 정보를
     * DB의 MailClient 테이블에 저장
     * @param mailClientVO
     * @return 등록 성공 : 1, 등록 실패 : 0
     */
    public int createEmailTokens(MailClientVO mailClientVO);

    /**
     * 최종 사용자의 웹 어플리케이션 ID를 통해,
     * 최종 사용자에게 발급된 토큰 및 토큰 정보들 가져오기
     * @param empId
     * @return
     */
    public MailClientVO retrieveEmailTokens(String empId);

    /**
     * - 토큰 발급 흐름용 -
     * 액세스 토큰 여부 확인
     * @param empId
     * @return 토큰 있음 : 1, 없음 : 0
     */
    public int retrieveToCheckAccessToken(String empId);

    /**
     * - 토큰 발급 흐름용 -
     * 리프레시 토큰 여부 확인
     * @param empId
     * @return 토큰 있음 : 1, 없음 : 0
     */
    public int retrieveToCheckRefreshToken(String empId);

    /**
     * < 구글 인가 서버의 토큰 재 발급 >
     *  구글 인가 서버로부터 발급받은 토큰 및 토큰 정보를
     *  DB의 MailClient 테이블에 저장
     *   @param mailClientVO
     *   @return 등록 성공 : 1, 등록 실패 : 0
     */
    public int updateEmailTokens(MailClientVO mailClientVO);

    /**
     * 최종 사용자의 이름 가져오기
     * @param empId
     * @return
     */
    public String retrieveEmployeeName(String empId);

    /**
     * - 토큰 흐름용-
     * 리프레시 토큰이 유효한 상태에서 액세스 토큰 재발급 받은 경우
     * 리프레시 토큰, 리프레시 토큰 만료 시간
     *
     * @param empId
     * @return MailClientVO 리프레시 토큰, 리프레시 토큰 만료시간
     */
    public MailClientVO retrieveAllAboutRefreshToken(String empId);


    /**
     * 이메일 계정 전체 불러오기 위한 정보
     * 조건 : 이메일 계정을 클릭으로 선택하는 경우 사용
     *
     * @return Map<String, Object> Object는 MailSendVO
     */
    public Map<String, Object> retrieveClickAllAboutEmailAddressInfo();

    /**
     * 프로젝트 전체 조회
     *
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveProject();

    /**
     * 직원 전체 조회
     *
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveEmp();

    /**
     * 팀 전체 조회
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveTeam();

    /**
     * 이메일을 가진 전체 직원 조회
     * @return empId, empName, infoEmail (List<MailSendVO>)
     */
    public List<MailSendVO> retrieveEmpBeingEmails();

    /**
     * 메일 보내기 할 때 필요한 인가 정보
     * @return
     */
    public Map<String, String> authJsonForSending(String userId) throws IOException;


    /**
     * 첨부 파일 있는 경우 메일 전송 준비
     *
     * @return
     */
    public Message sendReadyWithAttach(MailSendVO mailSendVO) throws MessagingException, IOException;



    /**
     * 이메일 DB에 저장 (첨부파일 없음)
     * @param mailInboxVO
     * @return 성공 1, 실패 0
     */
    public int createEmailDB(MailInboxVO mailInboxVO);

    /**
     * 이메일 DB에 저장 (첨부파일 있음)
     * @param mailInboxVO
     * @return 성공 1, 실패 0
     */
    public int createEmailWithAttachmentDB(MailInboxVO mailInboxVO);

    /**
     * DB에 저장된 이메일 (첨부파일 없음)
     * @param mailBoxVO
     * @return
     */
    public List<MailBoxVO> retrieveEmailNoneAttachment(MailBoxVO mailBoxVO);

    /**
     * DB에 저장된 이메일 (첨부파일 있음)
     * @param mailBoxVO
     * @return
     */
    public List<MailBoxVO> retrieveEmailWithAttachment(MailBoxVO mailBoxVO);

    /**
     * 이메일 식별자 목록 조회
     * @param empId
     * @return List<String>
     */
    public List<String> retrieveMessageIdList(String empId);

    /**
     * 이메일 목록 조회
     * @param empId
     * @return List<String>
     */
    public List<MailBoxVO> retrieveEmailsList(String empId);


    /**
     * empId, messageId, attachmentId 모두 가진 DB 행 존재
     * @param mailBoxVO
     * @return 존재 1, 없음 0
     */
    public int retrieveOneCntWithAttach(MailBoxVO mailBoxVO);

    /**
     * empId, messageId, attachmentId 모두 가진 DB 행 구하기
     * @param mailBoxVO
     * @return 해당 행 MailBoxVO
     */
    public MailBoxVO retrieveOneWithAttach(MailBoxVO mailBoxVO);

    /**
     * empId, messageId 모두 가진 DB 행 존재
     * @param mailBoxVO
     * @return 존재 1, 없음 0
     */
    public int retrieveEmailTotalCntFromDB(MailBoxVO mailBoxVO);

    /**
     * empId, messageId 모두 가진 DB 행 구하기
     * @param mailBoxVO
     * @return 해당 행 MailBoxVO
     */
    public List<MailBoxVO> retrieveOne(MailBoxVO mailBoxVO);




    /**
     * 메일
     * @param notOrganizeEmailList
     * @param messageIdList
     * @param empId
     * @param accessToken
     * @return
     */
    public List<List<MailBoxVO>> organizeEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList, List<String> messageIdList, String empId, String accessToken) throws IOException;


    /**
     * 받은 메일함 DB 저장
     * @param mailBoxVO
     * @return 성공 1, 실패 0
     */
    public int createEmail(MailBoxVO mailBoxVO);

    /**
     * 보낸 메일함 DB 저장
     * @param mailBoxVO
     * @return 성공 1, 실패 0
     */
    public int createSentEmail(MailBoxVO mailBoxVO);

    /**
     * DB에 존재하는 messageId 목록 조회
     * @param empId
     * @return messageId 목록 List<MailBoxVO>
     */
    public List<MailBoxVO> retrieveMessageIdFromDB(String empId);

    /**
     *  뷰 용 목록 조회
     * @return 첨부파일 요청 대상 목록 List<MailBoxVO>
     */
    public List<MailBoxVO> retrieveViewFromDB(MailBoxVO mailBoxVO);
    public int updateFile(MailBoxVO mailBoxVO);

    public List<List<MailBoxVO>> organizeSentEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList, List<String> messageIdList, String empId, String accessToken) throws IOException;

    public int retrieveCountSentMail(MailBoxVO mailBoxVO);
    public int retrieveCountSentMailDB(MailBoxVO mailBoxVO);

    public List<MailBoxVO> retrieveViewFromDBSent(MailBoxVO mailBoxVO);

    public List<MailBoxVO> retrieveMessageIdFromDBSent(String empId);

    public Draft sendReadyDraft(MailSendVO mailSendVO) throws MessagingException, IOException;

    public int createJustEmailDraft(MailBoxVO mailBoxVO);

    public int deleteDraftBeforeSend(MailBoxVO mailBoxVO);
    public int deleteDraftAttachBeforeSend(MailBoxVO mailBoxVO);

    /**
     * 임시보관 요청한 메일 데이터를 DB에 저장하기전 이미 있는지 체크
     * @param mailBoxVO
     * @return 있음 1, 없음 0
     */
    public int retrieveBeingDraftIdFromDBDraft(MailBoxVO mailBoxVO);


    /**
     *
     * @param notOrganizeEmailList
     * @param empId
     * @param accessToken
     * @return
     * @throws IOException
     */
    public List<List<MailBoxVO>> organizeDraftEmail(List<Map<String, Map<String, Object>>> notOrganizeEmailList, List<String> draftIdList, String empId, String accessToken) throws IOException;

    /**
     * messageId 목록 조회
     * @param empId
     * @return List<MailBoxVO>
     */
    public List<MailBoxVO> retrieveMessageIdFromDBDraft(String empId);
    public List<MailBoxVO> retrieveDraftIdFromDBDraft(String empId);

    public List<MailBoxVO> retrieveViewFromDBDraft(MailBoxVO mailBoxVO);

    public List<MailBoxVO> retrieveRewriteDraftFromDB(MailBoxVO mailBoxVO);

    public int retrieveCountDraftFromDB(MailBoxVO mailBoxVO);

    public Draft sendReadyDraftAgain(MailSendVO mailSendVO) throws MessagingException, IOException;
    public com.google.api.services.gmail.model.Message sendReadyDraftFinal(MailSendVO mailSendVO) throws MessagingException, IOException;

    /**
     * 받은 메일 존재 조회(휴지통 입력 전)
     * @param mailbox
     * @return 있음 1, 없음 0
     */
    public int retrieveBeingMailInbox(MailBoxVO mailbox);

    /**
     * 보낸 메일 존재 조회(휴지통 입력 전)
     * @param mailbox
     * @return 있음 1, 없음 0
     */
    public int retrieveBeingMailSent(MailBoxVO mailbox);

    /**
     * 임시보관 중인 메일 존재 조회(휴지통 입력 전)
     * @param mailbox
     * @return 있음 1, 없음 0
     */
    public int retrieveBeingMailDraft(MailBoxVO mailbox);

    /**
     * 받은 메일함에 있던 정보 휴지통 테이블에 저장
     * @param mailTrashVO
     * @return 성공 1, 실패 0
     */
    public int createTrashFromInbox(MailTrashVO mailTrashVO);

    public Message sendReadyTrash(MailSendVO mailSendVO) throws MessagingException, IOException;
    public List<MailTrashVO> organizeTrash(List<Message> trashList, String empId);
    public void sendReadyDelete (MailSendVO mailSendVO) throws MessagingException, IOException;
    public int createTrash(MailTrashVO mailTrashVO);
    public int createTrashFromSent(MailTrashVO mailTrashVO);
    public int createTrashFromDraft(MailTrashVO mailTrashVO);
    public List<MailTrashVO> retrieveViewFromDBTrash(MailBoxVO mailBoxVO);
    public List<MailTrashVO> retrieveTrashIdListFromDB(String empId);
    public int retreiveCountTrashBeing(MailTrashVO mailTrashVO);

    public List<MailBoxVO> retrieveViewDetailSent(MailBoxVO mailBoxVO);

    public List<MailBoxVO> retrieveADraftFromDB(MailBoxVO mailBoxVO);
    
    public List<MailBoxVO> retrieveDownSent(MailBoxVO mailBoxVO);
    
    public List<MailBoxVO> retrieveDownInbox(MailBoxVO mailBoxVO);
    public List<MailBoxVO> retrieveDownTrash(MailBoxVO mailBoxVO);
}
