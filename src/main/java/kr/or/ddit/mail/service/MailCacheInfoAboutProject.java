package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.annotation.Cacheable;

import java.util.Map;

public interface MailCacheInfoAboutProject {

    /**
     * 팀 : projectId, projectName, empId
     * Map 키 : empId + "projectId"
     * Map 키 : empId + "projectName"
     *
     * @param empId
     * @param addressEachEmpP
     * @return 프로젝트 정보(Map<String, String>)
     */
    @Cacheable(cacheNames = "mailInfoAboutTeam", key = "#empId", cacheResolver = "mailCacheInfoOfProjectResolver")
    public MailSendVO saveInfoAboutProject(String empId, MailSendVO addressEachEmpP);
//    public Map<String, Object> saveInfoAboutProject(String empId, Map<String, Object> addressMap);

    public MailSendVO getInfoAboutProject(String empId, int projectId) ;
}
