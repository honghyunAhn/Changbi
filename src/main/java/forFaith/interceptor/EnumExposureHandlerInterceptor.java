package forFaith.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @Class Name : EnumExposureHandlerInterceptor.java
 * @Description : Enum 형식의 타입을 인터셉터 후 Enum 타입 명으로 request attr에 저장
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

public class EnumExposureHandlerInterceptor extends HandlerInterceptorAdapter {
private static final Logger logger = LoggerFactory.getLogger(EnumExposureHandlerInterceptor.class);

    @SuppressWarnings("rawtypes")
    private Set<Class<? extends Enum>> enumClasses = new HashSet<Class<? extends Enum>>();

    @SuppressWarnings("rawtypes")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        for (Class<? extends Enum> enumClass : enumClasses) {
            final String enumClassName = enumClass.getSimpleName();     // class of enum : Language
            final Enum[] enums = enumClass.getEnumConstants();          // enum instances : EN, JP,...

            // put them into map, so that we can access like this : Language.EN, Language.JP ...
            Map<String, Enum> map = new HashMap<String, Enum>(enums.length);

            // 리스트 형태로 저장(전체 리스트를 보여주기 위해 사용)
            List<Enum> list = new ArrayList<Enum>();

            for (Enum anEnum : enums) {
                map.put(anEnum.name(), anEnum);
                list.add(anEnum);
            }

            // seting to scope
            request.setAttribute(enumClassName, map);
            request.setAttribute(enumClassName+"List", list);
        }

        return super.preHandle(request, response, handler);
    }

    @SuppressWarnings("rawtypes")
    public void setEnumClasses(Set<Class<? extends Enum>> enumClasses) {
        logger.info("EnumExposureHandlerInterceptor - setEnumClasses");
        this.enumClasses = enumClasses;
    }
}
