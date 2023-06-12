package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

public interface MailCacheEmployeeList {

    /**
     *
     * 직원 목록 저장
     *
     * @param empId
     * @param mailProjectList
     * @return 직원 정보(List<MailSendVO>)
     */
    @Cacheable(cacheNames = "mailEmployeeList", key = "#empId", cacheResolver = "mailCacheEmployeeListResolver")
    public List<MailSendVO> saveEmployeeList(String empId, List<MailSendVO> mailProjectList);
//    public Map<String, Object> saveInfoAboutTeam(String empId, Map<String, Object> addressMap);

    /**
     * 직원 목록 저장 가져오기
     *
     * @param empId
     * @return List<MailSendVO>
     */
    public List<MailSendVO> getEmployeeList(String empId);
//    public Map<String, Object> getInfoAboutTeam(String empId);
}
