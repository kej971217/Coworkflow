package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

public interface MailCacheProjectList {

    /**
     *
     * 프로젝트 목록 저장
     *
     * @param empId
     * @param mailProjectList
     * @return 팀 정보(List<MailSendVO>)
     */
    @Cacheable(cacheNames = "mailProjectList", key = "#empId", cacheResolver = "mailCacheProjectListResolver")
    public List<MailSendVO> saveProjectList(String empId, List<MailSendVO> mailProjectList);
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap);

    /**
     * 프로젝트 목록 저장 가져오기
     *
     * @param empId
     * @return List<MailSendVO>
     */
    public List<MailSendVO> getProjectList(String empId);
//    public Map<String, Object> getInfoAboutTeam(String empId);
}
