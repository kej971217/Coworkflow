package kr.or.ddit.mail.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailSendVO implements Serializable {

    private String empId;//직원 식별자(웹 어플리케이션 로그인 ID), 보낸 메일함 : 보낸 사람
    private String empName;//직원명(뷰 용)

    private int teamId;//본부, 팀 식별자
    private String teamName;//본부, 팀 이름

    private int projectId;//프로젝트 식별자
    private String projectName;//프로젝트명(뷰 용)

    private String infoEmail;//이메일



    @NotNull
    private String userId;// 이메일 주소

    private String content;// 이메일 내용

    private MultipartFile[] fileList;// 이메일 첨부 파일
    
    private List<String> mailSendToList;// 메일 보내기 : 받는 사람
    private String mailSendSubject;// 메일 보내기 : 제목
    private String mailSendContent;// 메일 보내기 : 내용, 보낸 메일함 : 내용
    
    private String mailDraftId;// 임시보관 중인 메일 보내기
    private String mailMessageId;//메일 식별자




}