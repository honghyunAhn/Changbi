package forFaith.file;

import java.io.File;
import java.net.URI;

import org.springframework.util.StringUtils;

/**
 * @Class Name : MakeFile.java
 * @Description : 파일 생성 유틸
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

public class MakeFile {

	public static boolean mkdir(String dirPath) {
		File fileDir = new File(dirPath);
		boolean mkdir = false;

		if(!fileDir.exists()) {
			fileDir.mkdirs();
		}

		if(fileDir.exists()) {
			mkdir = true;
		}

		return mkdir;
	}

	public static File getFile(String pathname) {
		File file = null;

		if(!StringUtils.isEmpty(pathname)) {
			String dirPath = "";

			if(pathname.lastIndexOf("/") > 0) {
				dirPath = pathname.substring(0, pathname.lastIndexOf("/"));
			} else if(pathname.lastIndexOf("\\") > 0) {
				dirPath = pathname.substring(0, pathname.lastIndexOf("\\"));
			}

			if(!StringUtils.isEmpty(dirPath)) {
				if(MakeFile.mkdir(dirPath)) {
					file = new File(pathname);
				}
			}
		}

		return file;
    }

    public static File getFile(String parent, String child) {
        return new File(parent, child);
    }

    public static File getFile(File parent, String child) {
        return new File(parent, child);
    }

    public static File getFile(URI uri) {
    	return new File(uri);
    }
}
