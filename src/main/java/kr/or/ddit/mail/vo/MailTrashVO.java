package kr.or.ddit.mail.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailTrashVO implements Serializable {
    private String empId = "";

    // 다른 테이블에 해당되는지 유무 표시 :  해당 1, 해당 안됨 0
    private int mailInbox = 0;
    private int mailSend = 0;//issend 값이 1
    private int mailDraft = 0;//issend 값이 0

    private String mailMessageId = ""; // 메일 고유 식별자
    private String mailDraftId = ""; // 임시보관 중인 메일 고유 식별자
    private LocalDateTime mailDate;// 해당 테이블에 있는 date 값 보관 용
    private String mailTrashFrom;// 보낸 사람 전체 정보
    private String mailTrashTo;// 받는 사람 전체 정보
    private String mailTrashSnippet;//
    private String mailTrashSubject;//
    private String mailTrashTitle;//
    private String mailTrashContent;//
    private String mailAttachmentId;//
    private String mailAttachmentName;//
    private String mailAttachmentMimeType;//
    private int mailAttachmentSize;//
    private byte[] MailAttachment;//

    private List<String> mailSendToList;// 받는 사람 목록 (보낸 메일)
    private List<MailTrashVO> mailAttachList;// 첨부파일 정보 목록

    private String fromName = "";// 출력용
    private String fromAddr = "";// 출력용

    private String toName = "";// 출력용
    private String toAddr = "";// 출력용

    private LocalTime receivedLocalTime;// 출력용
    private LocalDate receivedLocalDate;// 출력용

}
