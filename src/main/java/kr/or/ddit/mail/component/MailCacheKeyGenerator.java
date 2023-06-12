package kr.or.ddit.mail.component;

import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

@Component
public class MailCacheKeyGenerator implements KeyGenerator {
    /**
     * Generate a key for the given method and its parameters.
     *
     * @param target 구현된 캐시 메서드를 호출하여 사용하는 클래스의 인스턴스
     * @param method 구현된 캐시 메서드 자체
     * @param params 구현된 캐시 메서드의 인자로 전달되는 가변 파라미터 (캐시 키를 생성하는 기반) : 배열로 다룸
     * @return 생성된 키(String)
     */
    @Override
    public Object generate(Object target, Method method, Object... params) {
        if(params.length<2) {
            // empId, id (2개)가 있어야 캐시 데이터를 식별하는 키를 생성함
            throw new IllegalArgumentException("empId, id 이 2개의 파라미터가 최소로 있어야 함");
        }

        String empId = params[0].toString();
        String id = params[1].toString();

        // 접두어 -> mailInbox:
        // 키 요소 구분자 -> 콜론 :

        return "mailInbox:" + empId + ":" + id;
    }
}
