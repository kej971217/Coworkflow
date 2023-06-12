package kr.or.ddit.mail;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCache;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
@EnableCaching
public class MailCacheConfig {
    @Bean
    public CacheManager cacheManager () {
        SimpleCacheManager simpleCacheManager = new SimpleCacheManager();
        simpleCacheManager.setCaches(
                // Cache 구현체
                // 메모리에 저장 new ConcurrentMapCache("mailInbox")
                Arrays.asList(
                        new ConcurrentMapCache("mailInbox")
                        , new ConcurrentMapCache("mailInboxId")
                        , new ConcurrentMapCache("mailAddressOfEmployee")
                        , new ConcurrentMapCache("mailInfoAboutTeam")
                        , new ConcurrentMapCache("mailInfoAboutProject")
                        , new ConcurrentMapCache("mailProjectList")
                        , new ConcurrentMapCache("mailEmployeeList")
                        , new ConcurrentMapCache("mailTeamList")

                )//나중에 저장소를 추가할 수 있음
        );
        return simpleCacheManager;
    }
}
