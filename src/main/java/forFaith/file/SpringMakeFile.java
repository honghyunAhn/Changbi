package forFaith.file;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Random;

import org.springframework.web.multipart.MultipartFile;

import forFaith.domain.SpringFileUpload;
import forFaith.util.FileUtil;
import forFaith.util.StringUtil;

/**
 * @Class Name : SpringMakeFile.java
 * @Description : 스프링에서 MultipartFile 객체를 이용해서 업로드 된 파일 생성
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

public class SpringMakeFile {

    public static File getFile(MultipartFile multipartFile) throws IOException {
        return getFile(multipartFile, FileUtil.REAL_PATH, multipartFile.getOriginalFilename(), "");
    }

    public static File getFile(MultipartFile multipartFile, String realPath) throws IOException {
        return getFile(multipartFile, realPath, multipartFile.getOriginalFilename(), "");
    }

    public static File getFile(MultipartFile multipartFile, String realPath, String originFileName, String fixFileName) throws IOException {
        File newFile = null;
        File oldFile = null;
        File fileDir = null;

        if(multipartFile != null) {

            if(StringUtil.isEmpty(realPath)) {
                realPath = FileUtil.REAL_PATH;
            }

            if(multipartFile != null && !StringUtil.isEmpty(originFileName)) {
            	String newFileName = "";
                int randomNumber = 10000000;
                
                if(!StringUtil.isEmpty(fixFileName)) {
                	// 고정이면 고정 파일 명으로
                	newFileName = fixFileName;
                } else {
	                // 한글 파일 처리를 위해 파일 명을 랜덤함수를 이용해서 저장하고 original 이름을 따로 저장시킨다.
	                // FILE_현재 날짜_랜덤 8자리 수 형태의 파일로 생성함.
	                Random random = new Random();
	
	                // 현재 시간 저장(같은 이름 중복인 경우 기존 파일에 날짜를 붙여서 저장시킴)
	                String currDate = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	                // 랜덤 숫자 발생 기본은 10000000에서 99999999사이
	                randomNumber = random.nextInt(90000000)+randomNumber;
	                
	                if(StringUtil.isContain(originFileName, ".")) {
	                    String name = originFileName.substring(0, originFileName.lastIndexOf("."));
	                    String ext = originFileName.substring(originFileName.lastIndexOf(".")+1);

	                    // 파일 명이 10자 이상으로 10자로 자른다.
	                    if(name.length() > 10) {
	                        name = name.substring(0, 10);
	                    }

	                    newFileName = currDate+randomNumber+"."+ext;
	                }
                }

                fileDir = new File(realPath);
                newFile = new File(fileDir+FileUtil.SEPARATOR+newFileName);
                oldFile = new File(fileDir+FileUtil.SEPARATOR+newFileName);

                if(!fileDir.exists()) {
                    fileDir.mkdirs();
                }

                if(oldFile != null && oldFile.exists()) {
                    // String name = fileName.substring(0, fileName.lastIndexOf("."));
                    // String ext = fileName.substring(fileName.lastIndexOf(".")+1);

                    // String newFileName = name+"_"+currDate+"."+ext;

                    // 이전 파일을 백업한다.
                    // oldFile.renameTo(new File(fileDir+File.separator+newFileName));

                    // 신규 파일 이름을 바꾼다.
                    // newFile = new File(fileDir+File.separator+newFileName);
                }

                // 신 파일 생성 방법
                if(newFile != null) {
                    multipartFile.transferTo(newFile);

                    /* 구 파일 생성 방법
                    InputStream is = multipartFile.getInputStream();
                    FileOutputStream fos = new FileOutputStream(dir+File.separator+multipartFile.getOriginalFilename());

                    int bytesRead = 0;

                    try {
                        byte[] buffer = new byte[1024];

                        while((bytesRead = is.read(buffer,0,1023)) != -1) {
                            fos.write(buffer, 0, bytesRead);
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    }

                    fos.close();
                    is.close();
                    */
                }
            }
        }

        return newFile;
    }

    public static File getFile(SpringFileUpload springFileUpload) throws IOException {
        String realPath = FileUtil.REAL_PATH;

        return getFile(springFileUpload, realPath);
    }
    
    public static File getFile(SpringFileUpload springFileUpload, String realPath) throws IOException {
        String originFileName = "";
        String fixFileName = "";
        MultipartFile multipartFile = null;

        if(springFileUpload != null) {
            multipartFile = springFileUpload.getMultipartFile();

            if(StringUtil.isEmpty(realPath)) {
                realPath = FileUtil.REAL_PATH;
            }

            if(!StringUtil.isEmpty(springFileUpload.getOriginFileName())) {
                originFileName = URLDecoder.decode(springFileUpload.getOriginFileName(), "UTF-8");
            }
            
            if(!StringUtil.isEmpty(springFileUpload.getFixFileName())) {
            	fixFileName = URLDecoder.decode(springFileUpload.getFixFileName(), "UTF-8");
            }
        }

        return getFile(multipartFile, realPath, originFileName, fixFileName);
    }
}