package kr.or.ddit.mail.service;

import kr.or.ddit.mail.component.MailCacheInfoOfProjectResolver;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class MailCacheInfoAboutProjectImpl implements MailCacheInfoAboutProject{

    @Inject
    private  final MailCacheInfoOfProjectResolver mailCacheInfoOfProjectResolver;

    public MailCacheInfoAboutProjectImpl(MailCacheInfoOfProjectResolver mailCacheInfoOfProjectResolver) {
        this.mailCacheInfoOfProjectResolver = mailCacheInfoOfProjectResolver;
    }


    /**
     * 팀 : projectId, projectName, empId
     * Map 키 : empId + "-projectId"
     * Map 키 : empId + "-projectName"
     *
     * @param empId
     * @return 프로젝트 정보(Map<String, String>)
     */
    @Cacheable(cacheNames = "mailInfoAboutTeam", key = "#empId", cacheResolver = "mailCacheInfoOfProjectResolver")
    @Override
    public MailSendVO saveInfoAboutProject(String empId, MailSendVO addressEachEmpP) {
//        log.info("프로젝트 정보 캐시 저장 진입");
        return addressEachEmpP;
    }

    @Override
    public MailSendVO getInfoAboutProject(String empId, int projectId) {
//        log.info("프로젝트 정보 캐시 가져오기 진입");

        Object projectMap = mailCacheInfoOfProjectResolver.getMailInfoAboutProject(empId, projectId);
//        log.info("프로젝트 정보 : {}", projectMap);

        if (Optional.ofNullable(projectMap).isPresent()) {
            return (MailSendVO) projectMap;
        } else {
            return null;
        }
    }
}
