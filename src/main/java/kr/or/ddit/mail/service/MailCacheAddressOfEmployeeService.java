package kr.or.ddit.mail.service;

import kr.or.ddit.mail.vo.MailSendVO;

import java.util.List;
import java.util.Map;

public interface MailCacheAddressOfEmployeeService {

    public MailSendVO saveAddressOfEmployee(String empId, MailSendVO emailsInfo);

    public MailSendVO getAddressOfEmployee(String empId);
}
