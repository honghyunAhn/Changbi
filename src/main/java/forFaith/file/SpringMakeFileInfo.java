package forFaith.file;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import forFaith.domain.SpringFileUpload;
import forFaith.util.FileUtil;

/**
 * @Class Name : SpringMakeFileInfo.java
 * @Description : Spring 에서 업로드 된 파일로 파일 정보를 추출
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

public class SpringMakeFileInfo {

    public static FileInfo getFileInfo(SpringFileUpload springFileUpload) throws IOException {
        return SpringMakeFileInfo.getFileInfo(springFileUpload, springFileUpload.getUploadDir());
    }

    public static FileInfo getFileInfo(SpringFileUpload springFileUpload, String uploadDir) throws IOException {
        return SpringMakeFileInfo.getFileInfo(springFileUpload, uploadDir, FileUtil.UPLOAD_DIR);
    }

    public static FileInfo getFileInfo(SpringFileUpload springFileUpload, String uploadDir, String realPath) throws IOException {
        FileInfo fileInfo = MakeFileInfo.getFileInfo(SpringMakeFile.getFile(springFileUpload, realPath));

        if(fileInfo != null) {
            // 원래 파일 이름도 저장해 둔다.
            fileInfo.setOriginFileName(URLDecoder.decode(springFileUpload.getOriginFileName(), "UTF-8"));
            fileInfo.setUrlPath(uploadDir+FileUtil.SEPARATOR+fileInfo.getName());
        }

        return fileInfo;
    }

    public static List<FileInfo> getFileInfoList(List<SpringFileUpload> springFileUploadList) throws IOException {
        List<FileInfo> fileInfoList = null;

        if(springFileUploadList != null && springFileUploadList.size() > 0) {
            fileInfoList = SpringMakeFileInfo.getFileInfoList(springFileUploadList, springFileUploadList.get(0).getUploadDir());
        }

        return fileInfoList;
    }

    public static List<FileInfo> getFileInfoList(List<SpringFileUpload> springFileUploadList, String uploadDir) throws IOException {
        List<FileInfo> fileInfoList = null;

        if(springFileUploadList != null && springFileUploadList.size() > 0) {
            fileInfoList = SpringMakeFileInfo.getFileInfoList(springFileUploadList, uploadDir, FileUtil.REAL_PATH);
        }

        return fileInfoList;
    }

    public static List<FileInfo> getFileInfoList(List<SpringFileUpload> springFileUploadList, String uploadDir, String realPath) throws IOException {
    	List<FileInfo> fileInfoList = new ArrayList<FileInfo>();

        if(springFileUploadList != null && springFileUploadList.size() > 0) {
            for(int i=0; i< springFileUploadList.size(); ++i) {
                SpringFileUpload springFileUpload = springFileUploadList.get(i);
                FileInfo fileInfo = MakeFileInfo.getFileInfo(SpringMakeFile.getFile(springFileUpload, realPath));

                if(fileInfo != null) {
                    fileInfo.setOriginFileName(URLDecoder.decode(springFileUpload.getOriginFileName(), "UTF-8"));
                    fileInfo.setUrlPath(uploadDir+FileUtil.SEPARATOR+fileInfo.getName());

                    fileInfoList.add(fileInfo);
                }
            }
        }

        return fileInfoList;
    }
}
