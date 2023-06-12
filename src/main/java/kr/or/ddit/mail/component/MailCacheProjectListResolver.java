package kr.or.ddit.mail.component;

import kr.or.ddit.mail.vo.MailSendVO;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.interceptor.CacheOperationInvocationContext;
import org.springframework.cache.interceptor.CacheResolver;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Component
public class MailCacheProjectListResolver implements CacheResolver {
    private final CacheManager cacheManager;

    public MailCacheProjectListResolver(CacheManager cacheManager) {
        this.cacheManager = cacheManager;
    }

    /**
     * Return the cache(s) to use for the specified invocation.
     *
     * @param context the context of the particular invocation
     * @return the cache(s) to use (never {@code null})
     * @throws IllegalStateException if cache resolution failed
     */
    @Override
    public Collection<? extends Cache> resolveCaches(CacheOperationInvocationContext<?> context) {
        Cache mailAddressCache = cacheManager.getCache("mailProjectList");
        return Collections.singletonList(mailAddressCache);
    }

    public Object getMailAddressOfEmployee(String empId) {
        Cache mailAddressCache = cacheManager.getCache("mailProjectList");

        // 캐시 키에 해당하는 캐시 가져오기
        Cache.ValueWrapper cacheValueWrapper = mailAddressCache.get(empId);

        if(cacheValueWrapper != null && cacheValueWrapper.get() != null) {
            return cacheValueWrapper.get();//캐시 데이터 반환
        } else {
            return null;
        }
    }
}
