package forFaith.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;


//import jjtkiosk.interf.web.KioskRestfulInterfaceController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import forFaith.file.MakeFile;

/**
 * @Class Name : FileUtil.java
 * @Description : 파일 관련 기능
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

public class FileUtil {

	private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);

	public static String SEPARATOR		= "/";
	public static String UPLOAD_DIR		= "/upload";
	//public static String REAL_PATH		= "D:\\jejuolle\\upload";
	public static String REAL_PATH		= "D:\\uploadImage";
	private static List<String[]> extList = new ArrayList<String[]>();
    private static String[] imageFileExtList = new String[]{"bmp","jpeg","jpg","gif","png","tif"};
    private static String[] aviFileExtList = new String[]{"avi","mov","dvd","mpeg","wmv","skm","asf","asx"};
    private static String[] pdfFileExtList = new String[]{"pdf"};
    private static String[] excelFileExtList = new String[]{"xlsx","xls","csv"};
    private static String[] wordFileExtList = new String[]{"doc"};
    private static String[] hangleFileExtList = new String[]{"hwp"};
    private static String[] pptFileExtList = new String[]{"ppt"};
    private static String[] textFileExtList = new String[]{"txt"};

    static {
        FileUtil.extList.add(FileUtil.imageFileExtList);
        FileUtil.extList.add(FileUtil.aviFileExtList);
        FileUtil.extList.add(FileUtil.pdfFileExtList);
        FileUtil.extList.add(FileUtil.excelFileExtList);
        FileUtil.extList.add(FileUtil.wordFileExtList);
        FileUtil.extList.add(FileUtil.hangleFileExtList);
        FileUtil.extList.add(FileUtil.pptFileExtList);
        FileUtil.extList.add(FileUtil.textFileExtList);
    }

	public static void deleteFile(File file) {
		if (file.exists() && file.isFile() && !file.isHidden()) {
			file.delete();
		}
	}

	public static long copy(InputStream input, OutputStream output) throws IOException {
		byte[] buffer = new byte[4096];
		long count = 0L;
		int n = 0;
		while (-1 != (n = input.read(buffer))) {
			output.write(buffer, 0, n);
			count += n;
		}
		return count;
	}

	public static void save(byte [] binary, String storePath, String fileNm) throws IOException  {
		File saveFolder = new File(storePath);

		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		File file = new File(storePath + fileNm);
		FileOutputStream fos = new FileOutputStream(file);
		try {
			fos.write(binary);
		} finally {
			try {
				if (fos != null) fos.close();
			} catch (Exception ex) {
				logger.warn("FileUtil.save", ex);
			}
		}
	}

	// 파일을 넣어서 확장자를 가져오는 기능
	// 기본 기능과는 별개의 파일 관리 기능
	public static String getExt(String filePath) {
		return getExt(MakeFile.getFile(filePath));
	}

	public static String getExt(File file) {
		String ext = "";

		if(file != null && file.exists()) {
			String fileName = file.getName();

			if(!StringUtil.isEmpty(fileName) && StringUtil.isContain(fileName, ".")) {
				ext = fileName.substring(fileName.lastIndexOf(".")+1);
			}
		}

		return ext;
	}

	public static boolean isImageFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.imageFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.imageFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isAviFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.aviFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.aviFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isPdfFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.pdfFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.pdfFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isExcelFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.excelFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.excelFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isWordFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.wordFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.wordFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isHangleFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.hangleFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.hangleFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isPptFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.pptFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.pptFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isTextFile(String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt)) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<FileUtil.textFileExtList.length; ++i) {
                if(fileExt.equals(FileUtil.textFileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }

    public static boolean isExistExt(String[] fileExtList, String fileExt) {
        boolean isCheck = false;

        if(!StringUtil.isEmpty(fileExt) && fileExtList != null && fileExtList.length > 0) {
            fileExt = fileExt.toLowerCase();

            for(int i=0; i<fileExtList.length; ++i) {
                if(fileExt.equals(fileExtList[i])) {
                    isCheck = true;
                    break;
                }
            }
        }

        return isCheck;
    }
}
