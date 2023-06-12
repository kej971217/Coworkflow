package kr.or.ddit.mail.component;

import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.interceptor.CacheOperationInvocationContext;
import org.springframework.cache.interceptor.CacheResolver;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Collections;

@Component
public class MailCacheResolver implements CacheResolver {
    // 외부에서 객체 상속(확정, 수정) 못함
    private final CacheManager cacheManager;

    // 외부에서 CachManager를 주입하면 사용 가능
    // 모든 전역변수를 파라미터로 가지는 생성자 : 의존성 안 가지기, 직접 객체 생성 안 하기


    public MailCacheResolver(CacheManager cacheManager) {
        this.cacheManager= cacheManager;
    }

    /**
     * 지정된 호출에 사용하는 캐시를 반환
     * (캐시 연산에 사용할 캐시 객체를 결정하는 로직)
     * 캐시 객체 : 캐시 메서드에서 반환하는 '캐시 데이터를 담고 있는 객체'
     *
     * @param context 특정 호출의 컨텍스트 : 호출되는 캐시 메서드로부터 자동으로 넘어감
     * @return 사용할 캐시 (절대 null 반환 안함)
     * @throws IllegalStateException 캐시 resolution을 실패한 경우 예외
     */
    @Override
    public Collection<? extends Cache> resolveCaches(CacheOperationInvocationContext<?> context) {
        // 캐시 매니저에서 "mailInbox"라는 cacheName으로 캐시 가져오기
        Cache mailInboxCache = cacheManager.getCache("mailInbox");
        return Collections.singletonList(mailInboxCache);
    }

    /**
     * Object 타입인 (캐시에 저장된) 데이터 가져오기
     *
     * @param empId 캐시 찾기 키 1
     * @param id 캐시 찾기 키 2
     * @return (Object 타입) 캐시에 저장된 실질 데이터
     */
    public Object getMailCacheData(String empId, String id) {
        // 캐시 매니저에서 "mailInbox" 캐시 가져오기
        Cache mailInboxCache = cacheManager.getCache("mailInbox");

        // 캐시에서 특정 key에 해당하는 데이터 가져오기
        Cache.ValueWrapper valueWrapper = mailInboxCache.get("mailInbox:" + empId + ":" + id);
        if (valueWrapper != null) {
            // 가져온 캐시 데이터 반환하기
            return valueWrapper.get();//Object 타입
        } else {
            return null;
        }
    }
}
