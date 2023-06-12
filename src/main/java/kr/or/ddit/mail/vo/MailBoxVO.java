package kr.or.ddit.mail.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * 받은 메일함, 보낸 메일함
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailBoxVO implements Serializable {
    /* 받은 편지함 목록 */

    /**
     * 직원의 웹 어플리케이션 ID
     */
    private String empId;// 보낸 메일함 : 보낸 사람 웹어플리케이션 ID

    private String mailInboxTitle;//메일 제목
    private String mailInboxContent;//메일 내용
    private LocalDateTime mailInboxDate;//메일 받은 일시

    private String sender;//메일 보낸 사람
    private String receiverInfo;//메일 받은 사람

    
    private String mailMessageId;//메일 식별자
    private String mailSnippet;//메일 스니펫

    private String mailAttachmentId;//메일 첨부파일 식별자
    private String mailAttachmentName;//메일 첨부파일명
    @ToString.Exclude
    private byte[] mailAttachmentFile;//메일 첨부파일
    private int mailAttachmentSize;//메일 첨부파일 크기
    private String mailAttachmentMimeType;// 메일 마임 타입



    private String fromName;// 메일을 보낸 사람의 이름
    private String fromAddr;// 메일을 보낸 사람의 이메일 계정

    private String toName;// 메일을 보낸 사람의 이름
    private String toAddr;// 메일을 보낸 사람의 이메일 계정




    private LocalTime receivedLocalTime;
    private LocalDate receivedLocalDate;



    private String mailSendTitle;// 보낸 메일함 : 제목
    private String mailSendContent;// 보낸 메일함 : 내용
    private String mailSendSender;// 보낸 메일함 : 보낸 사람 계정
    private LocalDateTime mailSendDate;//보낸 메일함 : 보낸 날짜 시간
    private String mailSendReceiver;// 보낸 메일함 : 받은 사람(이메일 계정)

    private String mailDraftId;// 임시보관함 : 임시보관 메일 식별자 ID

    
}
