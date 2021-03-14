package forFaith.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.function.BiConsumer;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.changbi.tt.dev.util.CommonUtil;
import com.fasterxml.jackson.core.JsonProcessingException;

import forFaith.dev.vo.MemberVO;
import forFaith.util.UrlToTitle;

//개인정보 조회관련 내역을 기록하는 interceptor 2021-02-24 김나영
@Intercepts(@Signature(
		type = Executor.class
		, method = "query"
		, args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}))
public class CommonLogInterceptor implements Interceptor{
	
	private String uri;
	private static String LOG_PATH = "/var/log/tomcat7";
	private static String LOG_NAME = "sercurity_log_";
	
	private static final Logger logger = LoggerFactory.getLogger(CommonLogInterceptor.class);

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		
		logger.debug("전체활동 로그찍기 intercept 메소드 시작");
		
		//로그찍는데와 무관하게 DB 작업은 계속돼야 함
		Object result =  invocation.proceed();
		List<?> list = CommonUtil.objToList(result);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		//호출된 url와 sql문을 확인하고 로그를 찍는 대상이면 로그를 찍음
		//로그찍기 대상: UrlToTitle enum에 등록되어 있는 주소
		uri = request.getRequestURI();
		
		if(UrlToTitle.getTitle(uri) != null && list.size() != 0) {
			//현재 날짜
			Date date = new Date();
			//로그 생성
			String log = getLog(invocation, request, result, date, list);
			//로그 기록
			if(log != null) writeLog(log, date);
		}
		
		logger.debug("전체활동 로그찍기 intercept 메소드 종료");
		
		
		return result;
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {
	}
	
	//찍어야 되는 로그 만들어주는 메소드
	private String getLog(Invocation invocation, HttpServletRequest request, Object result, Date date, List<?> list) {
		String log = "";
		
		MappedStatement ms = (MappedStatement)invocation.getArgs()[0];
		
//		logger.debug("getLog path: " + UrlToTitle.getTitle(uri).getTitle());
		
		//호출된 query
		BoundSql boundSql = ms.getSqlSource().getBoundSql(invocation.getArgs()[1]);
		String sql = "";
		
		try {
			sql = getParameterBindingSQL(boundSql, invocation.getArgs()[1]).replaceAll("\n", "").replaceAll("\t", " ");
			logger.debug("파라미터 바인딩 SQL : {}", getParameterBindingSQL(boundSql, invocation.getArgs()[1]));
		} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException
				| JsonProcessingException e) {
			return "로그작성중 에러발생" + e.getLocalizedMessage();
		}
		
		if(sql.contains("(*)")) return null;
		
		//접속id -> 로그인이 되어있는 경우에는 세션값, 아닌 경우에는 파라미터에서 가져옴
		MemberVO user = (MemberVO) request.getSession().getAttribute("loginUser");
		String userId;
		if(user != null) userId = user.getId();
		else userId = ((MemberVO)invocation.getArgs()[1]).getId();
		
		//접속ip
		String userIp = CommonUtil.getClientIp(request);
		//업무내용
		String title = UrlToTitle.getTitle(uri).getTitle();
		
				//날짜					관리자ID			IP				작업내역	sql문
		log = date.toString() + " | " + userId + " | " + userIp + " | " + title + " | " + sql;
		
		return log;
	}
	//로그파일에 getLog에서 만든 로그를 저장하는 메소드
	private void writeLog(String log, Date date) throws IOException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		File logFile = new File(LOG_PATH + "/" + LOG_NAME + today + ".log");
		
		logger.debug("writeLog FileName: " + logFile.getName());
		
		//없으면 새로 만든다
		if(!logFile.exists()) {
			logFile.createNewFile();
		}
		//해당 파일에 작성한다
		FileWriter fw = new FileWriter(LOG_PATH + "/" + logFile.getName(), true);
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(log + "\r\n");
		bw.flush();
		bw.close();
		fw.close();
	}
	
	// 파라미터 sql 바인딩 처리
	public String getParameterBindingSQL(BoundSql boundSql, Object parameterObject) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException, JsonProcessingException {

		StringBuilder sqlStringBuilder = new StringBuilder(boundSql.getSql());
		// stringBuilder 파라미터 replace 처리
		BiConsumer<StringBuilder, Object> sqlObjectReplace = (sqlSb, value) -> {
			int questionIdx = sqlSb.indexOf("?");
			
			if(questionIdx == -1) {
				return;
			}
			
			if(value == null) {
				sqlSb.replace(questionIdx, questionIdx + 1, "null");
			} else if (value instanceof String) {
				sqlSb.replace(questionIdx, questionIdx + 1, "'" + (value != null ? value.toString() : "") + "'");
			} else if(value instanceof Integer || value instanceof Long || value instanceof Float || value instanceof Double) {	
				sqlSb.replace(questionIdx, questionIdx + 1, value.toString());
			} else if(value instanceof LocalDate || value instanceof LocalDateTime) {
				sqlSb.replace(questionIdx, questionIdx + 1, "'" + (value != null ? value.toString() : "") + "'");
			} else if(value instanceof Enum<?>) {
				sqlSb.replace(questionIdx, questionIdx + 1, "'" + (value != null ? value.toString() : "") + "'");
			} else {
				sqlSb.replace(questionIdx, questionIdx + 1, value.toString());
			}
		};
		
		if(parameterObject == null) {
			sqlObjectReplace.accept(sqlStringBuilder, null);
		} else {
			
			if(parameterObject instanceof Integer || parameterObject instanceof Long || parameterObject instanceof Float || parameterObject instanceof Double || parameterObject instanceof String) {
				sqlObjectReplace.accept(sqlStringBuilder, parameterObject);
			} else if(parameterObject instanceof Map) {
				
				Map paramterObjectMap = (Map)parameterObject;
				List<ParameterMapping> paramMappings = boundSql.getParameterMappings();
				
				for (ParameterMapping parameterMapping : paramMappings) {
					String propertyKey = parameterMapping.getProperty();
					
					try {
						Object paramValue = null;
						if(boundSql.hasAdditionalParameter(propertyKey)) { 
							// 동적 SQL로 인해 __frch_item_0 같은 파라미터가 생성되어 적재됨, additionalParameter로 획득
							paramValue = boundSql.getAdditionalParameter(propertyKey);
						} else {
							paramValue = paramterObjectMap.get(propertyKey);	
						}
						
						sqlObjectReplace.accept(sqlStringBuilder, paramValue);	
					} catch (Exception e) {
						sqlObjectReplace.accept(sqlStringBuilder, "[cannot binding : " + propertyKey+ "]");
					}
						 
				}
			} else {
	
				List<ParameterMapping> paramMappings = boundSql.getParameterMappings();
				Class< ? extends Object> paramClass = parameterObject.getClass();
				
				for (ParameterMapping parameterMapping : paramMappings) {
					String propertyKey = parameterMapping.getProperty();
					
					try {
						
						Object paramValue = null;
						if(boundSql.hasAdditionalParameter(propertyKey)) {
							// 동적 SQL로 인해 __frch_item_0 같은 파라미터가 생성되어 적재됨, additionalParameter로 획득
							paramValue = boundSql.getAdditionalParameter(propertyKey);
						} else {
							java.lang.reflect.Field field = ReflectionUtils.findField(paramClass, propertyKey);
							field.setAccessible(true);
							paramValue = field.get(parameterObject);	
						}
						
						sqlObjectReplace.accept(sqlStringBuilder, paramValue);
					} catch (Exception e) {
						sqlObjectReplace.accept(sqlStringBuilder, "[cannot binding : " + propertyKey+ "]");
					}
				}
			}
		}
		
		return sqlStringBuilder.toString();
	}
}
