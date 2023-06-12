package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.annotation.Cacheable;

import java.util.Map;

public interface MailCacheInfoAboutTeam {

    /**
     *
     * 팀 : teamId, teamName, empId
     *  Map 키 : empId + "-teamId"
     * Map 키 : empId + "-teamName"
     *
     * @param empId
     * @param addressMap
     * @return 팀 정보(Map<String, String>)
     */
    @Cacheable(cacheNames = "mailInfoAboutTeam", key = "#empId", cacheResolver = "mailCacheInfoAboutTeamResolver")
    public MailSendVO saveInfoAboutTeam(String empId, MailSendVO addressEachEmpTeam);
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap);

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
    public MailSendVO getInfoAboutTeam(String empId);
//    public Map<String, Object> getInfoAboutTeam(String empId);
}
