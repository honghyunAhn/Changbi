package com.changbi.tt.dev.util;


import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.Charset;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.FileAttribute;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.UrlPathHelper;

@Component
public class CommonUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	
	/**
	 * url path 가져오기
	 *
	 * @param
	 * @return	string
	 * @exception
	 * @see
	 */
	public String getUrlPath(HttpServletRequest request) {
		UrlPathHelper urlPathHelper = new UrlPathHelper();
		String originalURL = urlPathHelper.getOriginatingRequestUri(request);
		return originalURL;
	}
	
	/**
	 * createDirectory
	 * 
	 * @param path, permition, os, newdir
	 */
	public static boolean createDirectory(String... param) {

		boolean rst = false;

		String path = param[0];
		String permition = param[1];
		String os = param[2];
		String newdir = param[3];

		File d = new File(path + newdir);
		Path newDir = FileSystems.getDefault().getPath(path + newdir);

		Set<PosixFilePermission> permis = PosixFilePermissions.fromString(permition);
		FileAttribute<Set<PosixFilePermission>> attrib = PosixFilePermissions.asFileAttribute(permis);

		try {
			if (!d.isDirectory()) {
				if ("win".equals(os)) {
					Files.createDirectory(newDir);
				} else {
					Files.createDirectory(newDir, attrib);
				}
				logger.debug(newdir+" 생성완료!!");
			} else {
				logger.debug(newdir+" 이미생성됨!!");
			}
			rst = true;
		} catch (IOException e) {
			logger.debug(newdir+" 생성실패!!");
			rst = false;
			e.printStackTrace();
		}
		return rst;
	}
	
	public static List<String> readAllLines(byte[] bytes, Charset string) {
		if (bytes == null || bytes.length == 0)
			return new ArrayList<String>();
	
		try (ByteArrayInputStream is = new ByteArrayInputStream(bytes);
				Reader in = new InputStreamReader(is, string);
				BufferedReader br = new BufferedReader(in)) {
	
			List<String> lines = new ArrayList<String>();
			while (true) {
				String line = br.readLine();
				if (line == null)
					break;
				lines.add(line);
			}
			return lines;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static String getClientIp(HttpServletRequest request) {
		request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
		
		return ip;
	}
	
	//Object를 List로 바꿔주는 메소드
	public static List<?> objToList(Object obj) {
		List<?> list = new ArrayList<>();
		if(obj.getClass().isArray()) {
			list = Arrays.asList((Object[]) obj);
		} else if(obj instanceof Collection) {
			list = new ArrayList<>((Collection<?>) obj);
		}
		return list;
	}
	
//	숫자인지 판단해주는 메소드
	public static boolean isStringDouble(String str) {
		try {
			Double.parseDouble(str);
		} catch (Exception e) {
			return false;
		}
		return true;
	}
}
