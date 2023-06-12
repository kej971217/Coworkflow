package kr.or.ddit.mail.service;

import com.google.api.services.gmail.model.Message;
import kr.or.ddit.mail.vo.MailBoxVO;
import kr.or.ddit.mail.vo.MailInboxVO;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.List;
import java.util.Map;


public interface MailStoreGmailService {

    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기
     * @param accessToken
     * @return 응답(String)
     */
    public String getMessageIdListFromGmail(String accessToken);

    /**
     * 페이징용 resultSizeEstimate 추출
     * @param responseJavaMap : 메일 응답 목록 -> JSON -> Map
     * @return resultSizeEstimate(int)
     */
    public int getTotalCountFromList(Map<String, Object> responseJavaMap);

    /**
     * 메일 구성 요소 추출
     * @param responseJavaMap : 메일 응답 목록 -> JSON -> Map
     * @return messages(List<Map<String, Object>>)
     */
    public List<Map<String, Object>> getMessagesFromList(Map<String, Object> responseJavaMap);

    //String responseMessageEntityBody


    /**
     * 메세지 식별자를 이용해서 메세지(메일) 요청하기
     * @param accessToken
     * @param messageId
     * @return
     */
    public String getEachEmailFromGmail(String accessToken, String messageId) ;


    /**
     * 첨부 파일 요청하기
     * @return List<MailInboxVO>
     * @throws MessagingException
     * @throws IOException
     */
    public MailBoxVO getAttachFromGmail(String empId, MailBoxVO eachAttachMailBoxVO) throws IOException;


    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기(보낸 메일함)
     *
     * @param accessToken
     * @return 응답(String)
     */
    public String getSendMessageIdListFromGmail(String accessToken);

    /**
     * 지메일 : 메일 식별자 목록 요청하고 응답받기
     * @param accessToken
     * @return 응답(String)
     */
    public String getDraftMessageIdListFromGmail(String accessToken);

    public String getEachDraftFromGmail(String accessToken, String draftId);

    public List<Map<String, Object>> getDraftsFromList(Map<String, Object> responseJavaMap);

    /**
     * 휴지통 목록 받기
     * @param accessToken
     * @return
     */
    public List<String> getTrashMessageIdList(String accessToken);

    /**
     * 휴지통 메일 받기
     * @param accessToken
     * @param trashId
     * @return
     * @throws IOException
     */
    public Message getEachTrashCanFromGmail(String accessToken, String trashId) throws IOException;
}
