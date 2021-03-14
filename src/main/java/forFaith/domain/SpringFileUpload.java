package forFaith.domain;

import javax.xml.bind.annotation.XmlTransient;

import org.springframework.web.multipart.MultipartFile;

import forFaith.util.StringUtil;

/**
 * @Class Name : SpringFileUpload.java
 * @Description : Spring에서 파일업로드 시 정보 저장
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

public class SpringFileUpload {

    private MultipartFile multipartFile;        // 스프링 파일 Upload 저장
    private String originFileName;              // 원본 파일 명

    // 업로드 파일 저장 시 필요한 정보
    private String fileId;
    private String uploadDir;                   // 업로드 파일 저장 경로
    private String fixFileName;					// 고정 파일 이름(이 이름이 있으면 이 이름으로 파일 명을 생성한다.)
    private String removeFileName;				// 업로드 시 삭제 시킬 파일명(1개씩 업로드 시 기존에 사용중이던 파일 삭제용도)

    private String thumbnail;                   // 썸네일 생성 여부 Y or all

    // 업로드 창으로 보내줄 정보
    private int fileIndex;                      // 몇번째 index의 파일을 제어하는지 체크
    private int uploadCount;                    // 이미 업로드 된 파일 갯수
    private long uploadSize;                    // 이미 업로드 된 파일 사이즈
    private int maxSize;                        // 1개 파일 최대 크기(MB)
    private int maxTotalSize;                   // 모든 파일 최대 크기(MB)
    private int maxCount;                       // 파일 업로드 최대 수
    private String accept;                      // 파일 종류(image : 이미지, video : 비디오)
    private String callback;                    // 콜백함수 등록(파일 업로드 완료 후 호출 되는 함수)

    @XmlTransient
    public MultipartFile getMultipartFile() {
        return multipartFile;
    }

    public void setMultipartFile(MultipartFile multipartFile) {
        this.multipartFile = multipartFile;
    }

    @XmlTransient
    public String getOriginFileName() {
        return originFileName;
    }

    public void setOriginFileName(String originFileName) {
        this.originFileName = originFileName;
    }

    @XmlTransient
    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

	@XmlTransient
    public String getUploadDir() {
        return this.uploadDir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public String getFixFileName() {
		return fixFileName;
	}

	public void setFixFileName(String fixFileName) {
		this.fixFileName = fixFileName;
	}

	public String getRemoveFileName() {
		return removeFileName;
	}

	public void setRemoveFileName(String removeFileName) {
		this.removeFileName = removeFileName;
	}

	@XmlTransient
    public int getUploadCount() {
        return uploadCount;
    }

    public void setUploadCount(int uploadCount) {
        this.uploadCount = uploadCount;
    }

    @XmlTransient
    public long getUploadSize() {
        return uploadSize;
    }

    public void setUploadSize(long uploadSize) {
        this.uploadSize = uploadSize;
    }

    @XmlTransient
    public int getMaxSize() {
        return maxSize;
    }

    public void setMaxSize(int maxSize) {
        this.maxSize = maxSize;
    }

    @XmlTransient
    public int getFileIndex() {
        return fileIndex;
    }

    public void setFileIndex(int fileIndex) {
        this.fileIndex = fileIndex;
    }

    @XmlTransient
    public int getMaxTotalSize() {
        return maxTotalSize;
    }

    public void setMaxTotalSize(int maxTotalSize) {
        this.maxTotalSize = maxTotalSize;
    }

    @XmlTransient
    public int getMaxCount() {
        return maxCount;
    }

    public void setMaxCount(int maxCount) {
        this.maxCount = maxCount;
    }

    @XmlTransient
    public String getAccept() {
        return accept;
    }

    public void setAccept(String accept) {
        this.accept = accept;
    }

    @XmlTransient
    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    @XmlTransient
    public String getThumbnail() {
        return StringUtil.isEmpty(this.thumbnail) ? "N" : this.thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
}
