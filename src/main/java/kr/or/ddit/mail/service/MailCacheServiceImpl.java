//package kr.or.ddit.mail.service;
//
//import kr.or.ddit.mail.component.MailCacheIdResolver;
//import kr.or.ddit.mail.component.MailCacheKeyGenerator;
//import kr.or.ddit.mail.component.MailCacheResolver;
//import kr.or.ddit.mail.vo.MailBoxVO;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.cache.annotation.Cacheable;
//import org.springframework.stereotype.Service;
//import org.springframework.web.multipart.MultipartFile;
//
//import javax.inject.Inject;
//import java.io.File;
//import java.time.LocalDateTime;
//import java.util.List;
//import java.util.Map;
//import java.util.Optional;
//
//@Slf4j
//@Service
//public class MailCacheServiceImpl implements MailCacheService{
//
//    @Inject
//    private MailCacheKeyGenerator mailCacheKeyGenerator;
//
//    @Inject
//    private MailCacheResolver mailCacheResolver;
//
//    @Inject
//    public MailCacheServiceImpl(MailCacheKeyGenerator mailCacheKeyGenerator) {
//        this.mailCacheKeyGenerator = mailCacheKeyGenerator;
//    }
//
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
//    @Cacheable(cacheNames = "mailInbox", keyGenerator = "mailCacheKeyGenerator", cacheResolver = "mailCacheResolver")
//    @Override
//    public MailBoxVO saveMailInbox(String empId, String id, String fromName, String fromAddr, String subject, LocalDateTime receivedLocalDateTime, String snippet, String body, List<Map<String, Object>> downloadsList) {
//        log.info("[ MailCacheServiceImpl] 캐시 저장 진입");
//
//        // 반환하기 위해 VO에 저장
//        MailBoxVO mailBox = new MailBoxVO();
//        mailBox.setEmpId(empId);
//        mailBox.setId(id);
//        mailBox.setFromName(fromName);
//        mailBox.setFromAddr(fromAddr);
//        mailBox.setSubject(subject);
//        mailBox.setReceivedLocalDateTime(receivedLocalDateTime);
//        mailBox.setSnippet(snippet);
//        mailBox.setBody(body);
//        mailBox.setDownloadsList(downloadsList);
//
//        log.info("[ MailCacheServiceImpl] 캐시에 저장한 메일 : {}", mailBox);
//
//        // 캐시에 저장된 메일 정보 반환
//        return mailBox;
//    }
//
//    /**
//     * 저장한 캐시 가져오기
//     *
//     * @param empId
//     * @param id
//     * @return MailBoxVO 저장한 캐시 데이터
//     */
//    @Override
//    public MailBoxVO getMailBox(String empId, String id) {
//        log.info("[ MailCacheServiceImpl] 캐시 가져오기 진입");
//        Object mails = mailCacheResolver.getMailCacheData(empId, id);
//
//        if(Optional.ofNullable(mails).isPresent()) {
//            return (MailBoxVO) mails;
//        } else {
//            return null;
//        }
//    }
//
//
//}
