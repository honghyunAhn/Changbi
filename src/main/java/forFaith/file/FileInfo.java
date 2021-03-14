package forFaith.file;

import java.io.File;

/**
 * @Class Name : FileInfo.java
 * @Description : 파일 정보
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

public interface FileInfo {
    // 한개씩 파일을 저장할 때 사용 호출 할때 마다 기존 저장 된 파일에 추가로 저장
    void setFile(File file);

    // 한개씩 파일 저장할때 사용 파일명을 이용해서 파일 생성
    void setFile(String pathname);

    // 해당 파일 가져오기
    File getFile();

    // 파일 이름 가져오기
    String getName();

    // 파일 상대경로 가져오기
    String getPath();

    // 파일 절대경로 가져오기
    String getAbsolutePath();

    // 디렉토리 여부 확인
    boolean isDirectory();

    // 파일 여부 확인
    boolean isFile();

    // 파일 사이즈 가져오기
    long getFileSize();

    // 파일이 존재하는지 체크
    boolean exists();

    // 해당 파일을 Info에서 삭제
    boolean delete();

    // 확장자 가져오기
    String getExt();

    // 파일을 url로 접근하는 경우 urlPath를 지정해준다.
    void setUrlPath(String urlPath);

    String getUrlPath();

    // 파일의 원래 이름을 저장해둔다. 파일에 저장될때 이름을 바꿀수 있기 때문에 따로 관리한다.
    void setOriginFileName(String originFileName);

    String getOriginFileName();
}
