package kr.or.ddit.mail.service;

import kr.or.ddit.mail.component.MailCacheInfoAboutTeamResolver;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class MailCacheInfoAboutTeamImpl implements MailCacheInfoAboutTeam{

    @Inject
    private final MailCacheInfoAboutTeamResolver mailCacheInfoAboutTeamResolver;

    public MailCacheInfoAboutTeamImpl(MailCacheInfoAboutTeamResolver mailCacheInfoAboutTeamResolver) {
        this.mailCacheInfoAboutTeamResolver = mailCacheInfoAboutTeamResolver;
    }


    /**
     * 팀 : teamId, teamName, empId
     * Map 키 : empId + "-teamId"
     * Map 키 : empId + "-teamName"
     *
     * @param empId
     * @return 팀 정보(Map<String, String>)
     */
    @Cacheable(cacheNames = "mailInfoAboutTeam", key = "#empId", cacheResolver = "mailCacheInfoAboutTeamResolver")
    @Override
    public MailSendVO saveInfoAboutTeam(String empId, MailSendVO addressEachEmpTeam) {
//        log.info("팀 정보 저장");
        return addressEachEmpTeam;
    }
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap) {
//        log.info("팀 정보 저장");
//        return addressMap;
//    }

    /**
     *
     *
     * 팀 : teamId, teamName, empId
     * Map 키 : empId + "-teamId"
     * Map 키 : empId + "-teamName"
     *
     * @param empId
     * @return Map<String, Object>
     */
    @Override
    public MailSendVO getInfoAboutTeam(String empId) {
//        log.info("팀 정보 캐시 가져오기 진입");
        Object teamMap = mailCacheInfoAboutTeamResolver.getMailInfoAboutTeam(empId);
//        log.info("팀 정보 : {}", teamMap);

        if (teamMap != null) {
            return (MailSendVO) teamMap;
        } else {
            return null;
        }
    }
}
