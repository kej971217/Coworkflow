package kr.or.ddit.mail.service;

import kr.or.ddit.mail.component.MailCacheAddressOfEmployeeResolver;
import kr.or.ddit.mail.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class MailCacheAddressOfEmployeeServiceImpl implements MailCacheAddressOfEmployeeService {

    @Inject
    private final MailCacheAddressOfEmployeeResolver mailCacheAddressResolver;

    public MailCacheAddressOfEmployeeServiceImpl(MailCacheAddressOfEmployeeResolver mailCacheAddressResolver) {
        this.mailCacheAddressResolver = mailCacheAddressResolver;
    }


    /**
     *  save.setEmpId(empId);
     *                         save.setInfoEmail(address);
     *                         save.setEmpName(mailSendVO.getEmpName());
     * @param empId
     * @param  emailsInfo (List<MailSendVO>)
     * @return List<MailSendVO> emailsInfo
     */
    @Cacheable(cacheNames = "mailAddressOfEmployee", key = "#empId", cacheResolver = "mailCacheAddressOfEmployeeResolver")
    @Override
    public MailSendVO saveAddressOfEmployee(String empId, MailSendVO emailsInfo) {
//        log.info("메일 계정 직원 저장");
        return emailsInfo;
    }

    @Override
    public MailSendVO getAddressOfEmployee(String empid) {
//        log.info("캐시 직원 메일 계정 가져오기");
        Object addressMap = mailCacheAddressResolver.getMailAddressOfEmployee(empid);
//        log.info(" 계정 목록 : {}", addressMap);

        if (Optional.ofNullable(addressMap).isPresent()) {
            return (MailSendVO) addressMap;
        } else {
            return null;
        }
    }
}
