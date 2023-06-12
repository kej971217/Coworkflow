package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;

import java.util.List;
import java.util.Map;

public interface MailCacheAddressService {
    /**
     * 이메일 계정 전체 불러오기
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveAllEmailAddress(List<MailSendVO> info);


    /**
     * 팀 정보 불러오기
     * @param info
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveInfoTeam(List<MailSendVO> info);

    /**
     * 프로젝트 정보 불러오기
     * @param info
     * @return List<MailSendVO>
     */
    public List<MailSendVO> retrieveInfoProject(List<MailSendVO> empEmailsList, List<List<MailSendVO>> info);

    /**
     * 이메일이 존재하여 캐시에 저장된 팀 불러오기
     * @return List<MailSendVO>
     */
    public Map<String, List> retrieveBeingEmailInfos(List<MailSendVO> empEmailsList);
}
