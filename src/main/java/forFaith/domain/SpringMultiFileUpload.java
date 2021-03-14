package forFaith.domain;

import java.util.List;

import javax.xml.bind.annotation.XmlTransient;

/**
 * @Class Name : SpringMultiFileUpload.java
 * @Description : 스프링 사용중 여러개의 파일 업로드 시 리스트 형태의 업로드 파일 정보
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

public class SpringMultiFileUpload {

	private List<SpringFileUpload> fileList;

	@XmlTransient
	public List<SpringFileUpload> getFileList() {
		return fileList;
	}

	public void setFileList(List<SpringFileUpload> fileList) {
		this.fileList = fileList;
	}
}
