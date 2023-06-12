package kr.or.ddit.mail.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 받은 메일 DB 등록용 VO 객체
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailInboxVO implements Serializable {
    private String mailInboxTitle;//메일 제목
    private String mailInboxContent;//메일 내용
    private LocalDateTime mailInboxDate;//메일 받은 일시

    private String sender;//메일 보낸 사람
    private String receiverInfo;//메일 받은 사람

    private String mailMessageId;//메일 식별자
    private String mailSnippet;//메일 스니펫

    private String mailAttachmentId;//메일 첨부파일 식별자
    private String mailAttachmentName;//메일 첨부파일명
    private byte[] mailAttachmentFile;//메일 첨부파일
    private int mailAttachmentSize;//메일 첨부파일 크기
}
