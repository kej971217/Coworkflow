//package kr.or.ddit.mail.service;
//
//import kr.or.ddit.mail.vo.MailBoxVO;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.io.File;
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//
//public interface MailCacheService {
//    /**
//     * 캐시 저장하고 저장한 값 반환 받기
//     * @param empId
//     * @param id
//     * @param fromName
//     * @param fromAddr
//     * @param subject
//     * @param receivedLocalDateTime
//     * @param snippet
//     * @param body
//     * @return MailBoxVO 저장한 캐시 데이터
//     */
//    public MailBoxVO saveMailInbox(String empId, String id, String fromName, String fromAddr, String subject, LocalDateTime receivedLocalDateTime, String snippet, String body, List<Map<String, Object>> downloadsList);
//
//
//    /**
//     * 저장한 캐시 가져오기
//     *
//     * @param empId
//     * @param id
//     * @return MailBoxVO 저장한 캐시 데이터
//     */
//    public MailBoxVO getMailBox(String empId, String id);
//}
