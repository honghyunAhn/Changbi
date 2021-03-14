package forFaith.file;

import java.io.File;

import forFaith.util.StringUtil;

/**
 * @Class Name : FileInfoImpl.java
 * @Description : 파일 정보 인터페이스 구현체
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

public class FileInfoImpl implements FileInfo {

	private File file;
	private String name;
	private String path;
	private String absolutePath;
	private long fileSize;
	private String ext;
	private String urlPath;
	private String originFileName;

	public FileInfoImpl() {}

	public FileInfoImpl(String pathname) {
		if(!StringUtil.isEmpty(pathname)) {
			this.file = MakeFile.getFile(pathname);
		}
	}

	public FileInfoImpl(File file) {
		this.file = file;
	}

	@Override
	public void setFile(File file) {
		this.file = file;
	}

	@Override
	public void setFile(String pathname) {
		if(!StringUtil.isEmpty(pathname)) {
			this.file = MakeFile.getFile(pathname);
		}
	}

	@Override
	public File getFile() {
		return this.file;
	}

	@Override
	public String getName() {
		if(this.file != null) {
			this.name = this.file.getName();
		}

		return this.name;
	}

	@Override
	public String getPath() {
		if(this.file != null) {
			this.path = this.file.getPath();
		}

		return this.path;
	}

	@Override
	public String getAbsolutePath() {
		if(this.file != null) {
			this.absolutePath = this.file.getAbsolutePath();
		}

		return this.absolutePath;
	}

	@Override
	public boolean isDirectory() {
		boolean isDirectory = false;

		if(this.file != null) {
			isDirectory = this.file.isDirectory();
		}

		return isDirectory;
	}

	@Override
	public boolean isFile() {
		boolean isFile = false;

		if(this.file != null) {
			isFile = this.file.isFile();
		}

		return isFile;
	}

	@Override
	public long getFileSize() {
		if(this.file != null) {
			this.fileSize = this.file.length();
		}

		return this.fileSize;
	}

	@Override
	public boolean exists() {
		boolean exists = false;

		if(this.file != null) {
			exists = this.file.exists();
		}

		return exists;
	}

	@Override
	public boolean delete() {
		boolean isDelete = false;

		if(this.file != null) {
			isDelete = this.file.delete();

			if(isDelete) {
				this.file = null;
				this.urlPath = "";
				this.originFileName = "";
			}
		}

		return isDelete;
	}

	@Override
	public String getExt() {
		if(this.file != null) {
			String fileName = this.file.getName();

			if(!StringUtil.isEmpty(fileName) && StringUtil.isContain(fileName, ".")) {
				this.ext = fileName.substring(fileName.lastIndexOf(".")+1);
			}
		}

		return this.ext;
	}

	@Override
	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}

	@Override
	public String getUrlPath() {
		return this.urlPath;
	}

	@Override
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	@Override
	public String getOriginFileName() {
		return this.originFileName;
	}
}
