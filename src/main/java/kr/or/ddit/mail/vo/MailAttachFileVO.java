package kr.or.ddit.mail.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.File;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailAttachFileVO implements Serializable {

    private String messageId;
    private String partId;

    private String filename;
    private String attachmentId;

    private int attachmentSize;


    private File attachmentFile;
}
