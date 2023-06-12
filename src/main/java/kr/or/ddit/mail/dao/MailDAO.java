package kr.or.ddit.mail.dao;


import kr.or.ddit.mail.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MailDAO {

    /**
     * 최종 사용자의 웹 어플리케이션 ID를 입력하여,
     * 최종 사용자의 구글 계정(이메일 주소)을 가져오기
     *
     * @param employeeId
     * @return 이메일 주소(String)
     */
    public String selectEmployeeEmailAddress(String employeeId);

    /**
     * 최종 사용자의 웹 어플리케이션 ID을 통해,
     * 최종 사용자의 구글 계정(이메일)을 대상으로 발급된 토큰 및 토큰 관련 정보 가져오기
     *
     * @param empId
     * @return 토큰 및 토큰 관련 정보(MailClientVO)
     */
    public MailClientVO selectAllAboutTokens(String empId);

    /**
     * 최종 사용자의 웹 어플리케이션 ID를 통해,
     * 최초 액세스 토큰 발급여부 확인
     *
     * @param empId
     * @return 최초 발급 : 0, 재발급 : 1
     */
    public int selectToCheckFirstAccess(String empId);

    /**
     * < 구글 OAuth 서버로부터 받은 최초 토큰(인가) 처리 >
     * 최종 사용자의 웹 어플리케이션 ID와 함께,
     * DB의 MAIL_CLIENT 테이블에
     * 구글 인가 서버로부터 발급 받은 토큰 및 토큰 정보를 저장
     *
     * @param mailClientVO
     * @return 성공 : 1, 실패 : 0
     */
    public int insertEmployeeTokens(MailClientVO mailClientVO);

    /**
     * - 토큰 발급 흐름용 -
     * 액세스 토큰 여부 확인
     *
     * @param empId
     * @return 토큰 있음 : 1, 없음 : 0
     */
    public int selectAccessToken(String empId);

    /**
     * - 토큰 발급 흐름용 -
     * 리프레시 토큰 여부 확인
     *
     * @param empId
     * @return 토큰 있음 : 1, 없음 : 0
     */
    public int selectRefreshToken(String empId);

    /**
     * < 구글 OAuth 서버로부터 받은 토큰(인가) 처리 >
     * 최종 사용자의 웹 어플리케이션 ID을 기준으로,
     * DB의 MAIL_CLIENT 테이블에
     * 구글 인가 서버로부터 발급 받은 토큰 및 토큰 정보를 저장
     *
     * @param mailClientVO
     * @return 성공 : 1, 실패 : 0
     */
    public int updateEmployeeTokens(MailClientVO mailClientVO);

    /**
     * 토큰 전체 재발급으로, 이전에 등록된 DB 정보 삭제
     *
     * @param empId
     * @return
     */
    public int deleteEmployeeTokens(String empId);

    /**
     * 최종 사용자의 이름을 가져오기
     *
     * @param empId
     * @return 이름(String)
     */
    public String selectEmployeeName(String empId);

    /**
     * - 토큰 흐름용-
     * 리프레시 토큰이 유효한 상태에서 액세스 토큰 재발급 받은 경우
     * 리프레시 토큰, 리프레시 토큰 만료 시간
     *
     * @param empId
     * @return MailClientVO 리프레시 토큰, 리프레시 토큰 만료시간
     */
    public MailClientVO selectAllAboutRefreshToken(String empId);

    /**
     * 전체 직원 조회
     *
     * @return 직원 id(식별자), 직원명(MailSendVO)
     */
    public List<MailSendVO> selectAllEmployeeInfo();

    /**
     * 전체 본부, 팀 조회
     *
     * @return id(식별자), 본부 및 팀 이름(MailSendVO)
     */
    public List<MailSendVO> selectAllTeamInfo();

    /**
     * 전체 프로젝트 조회
     *
     * @return 프로젝트 id(식별자), 프로젝트명 (MailSendVO)
     */
    public List<MailSendVO> selectAllProjectInfo();

    /**
     * 조건 없는 전체 직원 및 이메일
     *
     * @return
     */
    public List<MailSendVO> selectEmpEmails();

    /**
     * 전체 직원 이메일 조회
     *
     * @param empId
     * @return 이메일 계정(String), 식별자
     */
    public MailSendVO selectEmailOfEmp(String empId);

    /**
     * 이메일 있는 전체 팀 조회
     *
     * @param empId
     * @return id(식별자), 본부 및 팀 이름(MailSendVO)
     */
    public MailSendVO selectEmailOfTeam(String empId);


    /**
     * 이메일 있는 전체 프로젝트 조회
     *
     * @param empId
     * @return id(식별자), 프로젝트 이름(MailSendVO)
     */
    public List<MailSendVO> selectEmailOfProject(String empId);

    /**
     * 이메일이 존재하는 모든 직원 조회
     *
     * @return empId, empName, infoEmail (List<MailSendVO>)
     */
    public List<MailSendVO> selectEmpBeingEmail();


    /**
     * 이메일 정보 저장 (첨부파일 없는 경우)
     *
     * @param mailInboxVO
     * @return 성공 1, 실패 0
     */
    public int insertMailNoneAttachment(MailInboxVO mailInboxVO);

    /**
     * 이메일 정보 저장 (첨부파일 있는 경우)
     *
     * @param mailInboxVO
     * @return 성공 1, 실패 0
     */
    public int insertMailWithAttachment(MailInboxVO mailInboxVO);

    /**
     * 이메일 정보 조회 (첨부파일 없는 경우)
     *
     * @param mailBoxVO
     * @return MailBoxVO
     */
    public List<MailBoxVO> selectMailNoneAttachment(MailBoxVO mailBoxVO);

    /**
     * 이메일 정보 조회 (첨부파일 있는 경우)
     *
     * @param mailBoxVO
     * @return MailBoxVO
     */
    public List<MailBoxVO> selectMailWithAttachment(MailBoxVO mailBoxVO);

    /**
     * 이메일 식별자 목록 조회
     *
     * @param empId
     * @return List<String>
     */
    public List<String> selectMessageIdList(String empId);

    /**
     * 이메일 첨부 파일 등록
     *
     * @param mailBoxVO
     * @return 성공 1, 실패 0
     */
    public int insertAttachmentFile(MailInboxVO mailBoxVO);

    /**
     * @param empId
     * @return
     */
    public List<MailBoxVO> selectEmalsList(String empId);


    /**
     * empId, messageId, attachmentId 모두 가진 DB 행 존재
     *
     * @param mailBoxVO
     * @return 존재 1, 없음 0
     */
    public int selectCountOneWithAttach(MailBoxVO mailBoxVO);


    /**
     * empId, messageId, attachmentId 모두 가진 DB 행 구하기
     *
     * @param mailBoxVO
     * @return 해당 행 MailBoxVO
     */
    public MailBoxVO selectOneWithAttach(MailBoxVO mailBoxVO);


    /**
     * empId, messageId 모두 가진 DB 행 존재
     *
     * @param mailBoxVO
     * @return 존재 1, 없음 0
     */
    public int selectEmailTotalCountDB(MailBoxVO mailBoxVO);

    /**
     * empId, messageId 모두 가진 DB 행 구하기
     *
     * @param mailBoxVO
     * @return 해당 행 MailBoxVO
     */
    public List<MailBoxVO> selectOne(MailBoxVO mailBoxVO);

    /**
     * 받은 메일 DB에 저장
     * @param mailBoxVO
     * @return 성공 1, 실패 0
     */
    public int insertJustEmail(MailBoxVO mailBoxVO);


    /**
     * 보낸 메일 DB에 저장
     * @param mailBoxVO
     * @return 성공 1, 실패 0
     */
    public int insertJustEmailSent(MailBoxVO mailBoxVO);

    /**
     * 첨부파일 등록할 때, 이미 등록된 동일한 messageID가 중복, attchemntId가  null인 경우
     *
     * @param mailBoxVO
     * @return
     */
    public int selectCntNullForDel(MailBoxVO mailBoxVO);


    /**
     * DB에 존재하는 messageId 목록 조회
     *
     * @param empId
     * @return messageId 목록 List<MailBoxVO>
     */
    public List<MailBoxVO> selectMessageIdFromDB(String empId);

    /**
     * 뷰 용 목록 조회
     *
     * @return 첨부파일 요청 대상 목록 List<MailBoxVO>
     */
    public List<MailBoxVO> selectViewFromDB(MailBoxVO mailBoxVO);

    /**
     * DB, 기존에 존재하는 행의 특정 컬럼에 저장
     *
     * @param mailBoxVO
     * @return
     */
    public int updateAttachmentFileBytes(MailBoxVO mailBoxVO);

    public int selectCntSentMail(MailBoxVO mailBoxVO);

    public int selectCntWithAttachSent(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectViewFromDBSent(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectMessageIdFromDBSent(String empId);
    
    
    public List<MailBoxVO> selectDownloadSent(MailBoxVO mailBoxVO);

    public int insertJustEmailDraft(MailBoxVO mailBoxVO);

    public int deleteDraftAttach(MailBoxVO mailBoxVO);
    public int deleteDraft(MailBoxVO mailBoxVO);

    public int selectMessageIdBeingDraft(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectMessageIdDraft(String empId);

    public List<MailBoxVO> selectViewFromDBDraft(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectADraftFromDB(MailBoxVO mailBoxVO);

    public int selectCntDraft(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectDraftId(String empId);

    /**
     * 임시보관 요청한 메일 데이터를 DB에 저장하기전 이미 있는지 체크
     * @param mailBoxVO
     * @return 있음 1, 없음 0
     */
    public int selectDraftIdBeingDraft(MailBoxVO mailBoxVO);

    /**
     * 휴지통에서 사용하는 보낸 메일 존재 확인
     * @param mailBoxVO
     * @return
     */
    public int selectSentBeing(MailBoxVO mailBoxVO);
    /**
     * 휴지통에서 사용하는 보낸 메일 존재 확인
     * @param mailBoxVO
     * @return
     */
    public int selectDraftBeing(MailBoxVO mailBoxVO);

    public int insertTrashFromInbox(MailTrashVO mailTrashVO);

    public int deleteInboxBeforeTrashDB(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectSentBeforeTrashDB(MailBoxVO mailBoxVO);
    public int deleteSentBeforeTrashDB(MailBoxVO mailBoxVO);

    public List<MailBoxVO> selectDraftBeforeTrashDB(MailBoxVO mailBoxVO);

    public int deleteDraftBeforeTrashDB(MailBoxVO mailBoxVO);

    public int insertTrashFromSent(MailTrashVO mailTrashVO);
    public int insertTrashFromDraft(MailTrashVO mailTrashVO);
    public List<MailTrashVO> selectTrashList(MailBoxVO mailBoxVO);
    public List<MailTrashVO> selectViewFromDBTrash(MailBoxVO mailBoxVO);
    public List<MailTrashVO> selectTrashIdListFromDB(String empId);
    public int selectCountTrashBeingInbox(MailTrashVO mailTrashVO);
    public int selectCountTrashBeingSent(MailTrashVO mailTrashVO);
    public int selectCountTrashBeingDraft(MailTrashVO mailTrashVO);
    public int insertTrash(MailTrashVO mailTrashVO);
    public int selectCountTrashBeing(MailTrashVO mailTrashVO);
    public List<MailBoxVO> selectViewDetailSent(MailBoxVO mailBoxVO);
    public List<MailBoxVO> selectDownloadInbox(MailBoxVO mailBoxVO);
    public List<MailBoxVO> selectDownloadTrash(MailBoxVO mailBoxVO);
}
