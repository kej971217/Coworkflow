package kr.or.ddit.mail.component;

import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.interceptor.CacheOperationInvocationContext;
import org.springframework.cache.interceptor.CacheResolver;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Collections;

@Component
public class MailCacheIdResolver implements CacheResolver {
    private final CacheManager cacheManager;

    public MailCacheIdResolver(CacheManager cacheManager) {
        this.cacheManager = cacheManager;
    }

    @Override
    public Collection<? extends Cache> resolveCaches(CacheOperationInvocationContext<?> context) {
        // 캐시 매니저에서 "mailInbox"라는 cacheName으로 캐시 가져오기
        Cache mailInboxIdCache = cacheManager.getCache("mailInboxId");
        return Collections.singletonList(mailInboxIdCache);
    }

    public Object getMailCacheId(String empId) {
        // 캐시 매니저에서 "mailInboxId" 캐시 가져오기
        Cache mailInboxIdCache = cacheManager.getCache("mailInboxId");

        // 캐시에서 특정 key에 해당하는 데이터 가져오기
        Cache.ValueWrapper valueWrapper = mailInboxIdCache.get(empId);
        if (valueWrapper != null) {
            // 가져온 캐시 데이터 반환하기
            return valueWrapper.get();//Object 타입
        } else {
            return null;
        }
    }


}
