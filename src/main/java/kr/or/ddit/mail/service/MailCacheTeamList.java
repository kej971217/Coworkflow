package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

public interface MailCacheTeamList {

    /**
     *
     * 팀 목록 저장
     *
     * @param empId
     * @param mailProjectList
     * @return 직원 정보(List<MailSendVO>)
     */
    @Cacheable(cacheNames = "mailTeamList", key = "#empId", cacheResolver = "mailCacheTeamListResolver")
    public List<MailSendVO> saveTeamList(String empId, List<MailSendVO> mailProjectList);
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap);

    /**
     * 팀 목록 저장 가져오기
     *
     * @param empId
     * @return List<MailSendVO>
     */
    public List<MailSendVO> getTeamList(String empId);
//    public Map<String, Object> getInfoAboutTeam(String empId);
}
