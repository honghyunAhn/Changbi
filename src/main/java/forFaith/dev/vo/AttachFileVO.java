package forFaith.dev.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @Class Name : AttachFileVO.java
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

@SuppressWarnings("serial")
public class AttachFileVO extends CommonVO {

    /** 파일 ID */
	private String fileId;

	/** 파일 상세 리스트 */
	private List<AttachFileDetailVO> detailList;

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public List<AttachFileDetailVO> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<AttachFileDetailVO> detailList) {
        this.detailList = detailList;
    }

    public void addDetail(AttachFileDetailVO detail) {
        if(this.detailList == null) {
            this.detailList = new ArrayList<AttachFileDetailVO>();
        }

        this.detailList.add(detail);
    }
}
