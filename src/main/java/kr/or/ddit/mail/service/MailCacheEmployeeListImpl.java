package kr.or.ddit.mail.service;

import kr.or.ddit.mail.component.MailCacheInfoAboutTeamResolver;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Slf4j
@Service
public class MailCacheEmployeeListImpl implements MailCacheEmployeeList{

    @Inject
    private final MailCacheInfoAboutTeamResolver mailCacheInfoAboutTeamResolver;

    public MailCacheEmployeeListImpl(MailCacheInfoAboutTeamResolver mailCacheInfoAboutTeamResolver) {
        this.mailCacheInfoAboutTeamResolver = mailCacheInfoAboutTeamResolver;
    }


    /**
     *
     * 직원 목록 저장
     *
     * @param empId
     * @param mailProjectList
     * @return 직원 정보(List<MailSendVO>)
     */
    @Cacheable(cacheNames = "mailEmployeeList", key = "#empId", cacheResolver = "mailCacheEmployeeListResolver")
    public List<MailSendVO> saveEmployeeList(String empId, List<MailSendVO> mailProjectList) {
//        log.info("프로젝트 목록 정보 캐시 저장");
        return mailProjectList;
    }
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap) {
//        log.info("팀 정보 저장");
//        return addressMap;
//    }

    /**
     * 직원 목록 저장 가져오기
     *
     * @param empId
     * @return List<MailSendVO>
     */
    public List<MailSendVO> getEmployeeList(String empId) {
//        log.info("프로젝트 목록 정보 캐시 가져오기 진입");
        Object teamMap = mailCacheInfoAboutTeamResolver.getMailInfoAboutTeam(empId);
//        log.info("프로젝트 목록 정보 : {}", teamMap);

        if (teamMap != null) {
            return (List<MailSendVO>) teamMap;
        } else {
            return null;
        }
    }
}
