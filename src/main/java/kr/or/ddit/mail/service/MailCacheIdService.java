package kr.or.ddit.mail.service;

import java.util.List;

public interface MailCacheIdService {

    public List<String> saveCacheId(String empId, List<String> idsList);

    public List<String> getCacheId(String empId);
}
