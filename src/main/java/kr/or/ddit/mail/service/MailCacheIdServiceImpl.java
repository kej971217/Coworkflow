package kr.or.ddit.mail.service;

import kr.or.ddit.mail.component.MailCacheIdResolver;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class MailCacheIdServiceImpl implements MailCacheIdService{

    @Inject
    private final MailCacheIdResolver mailCacheIdResolver;

    public MailCacheIdServiceImpl(MailCacheIdResolver mailCacheIdResolver) {
        this.mailCacheIdResolver = mailCacheIdResolver;
    }

    @Cacheable(cacheNames = "mailInboxId", key = "#empId", cacheResolver = "mailCacheIdResolver")
    @Override
    public List<String> saveCacheId(String empId, List<String> idsList) {
//        log.info("[MailCacheIdServiceImpl] saveCacheId 진입");
//        log.info("id 리스트 저장 : {}", idsList);
        return idsList;
    }

    @Override
    public List<String> getCacheId(String empId) {
//        log.info("[MailCacheIdServiceImpl] getCacheId 진입");
//        log.info("empId : {}",empId);


        // 캐시에서 특정 key에 해당하는 데이터 가져오기
        Object cacheIds = mailCacheIdResolver.getMailCacheId(empId);

        if(Optional.ofNullable(cacheIds).isPresent()) {
            return (List<String>) cacheIds;
        } else {
            return null;
        }
    }
}
