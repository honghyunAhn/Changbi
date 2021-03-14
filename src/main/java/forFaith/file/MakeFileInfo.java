package forFaith.file;

import java.io.File;

import forFaith.util.StringUtil;

/**
 * @Class Name : MakeFileInfo.java
 * @Description : 파일 정보 만드는 유틸
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

public class MakeFileInfo {

	public static FileInfo getFileInfo(String pathname) {
		FileInfo fileInfo = null;

		if(!StringUtil.isEmpty(pathname)) {
			fileInfo = new FileInfoImpl(pathname);
		}

		return fileInfo;
	}

	public static FileInfo getFileInfo(File file) {
		FileInfo fileInfo = null;

		if(file != null) {
			fileInfo = new FileInfoImpl(file);
		}

		return fileInfo;
	}
}