package forFaith.dev.dao;

import java.util.List;

import forFaith.dev.vo.AttachFileVO;

public interface AttachFileDAO {

	// fileId에 해당 하는 파일 정보를 list 형태로 가지고 온다.(파일 ID가 0인 경우에는 useYn이 Y 전체 파일 리스트를 가지고 온다)
	List<AttachFileVO> attachFileList(AttachFileVO attachFile) throws Exception;

	// fileId에 해당 하는 파일 정보 조회(useYn = 'Y' 인 경우만 조회) fileId가 0이면 조회 불가
	AttachFileVO attachFileInfo(AttachFileVO attachFile) throws Exception;

	// 파일 정보 등록 및 수정(unique 값 중복 시 수정)
    void attachFileReg(AttachFileVO attachFile) throws Exception;

    // 파일 상세 정보 등록
    int attachFileDetailReg(AttachFileVO attachFile) throws Exception;

	// 파일상세 정보 삭제
	int attachFileDetailDel(AttachFileVO attachFile) throws Exception;

	// 파일 사용 가능으로 변경(여러 파일 동시에 Y로 바꿈)
	int attachFileUse(List<AttachFileVO> attachFileList) throws Exception;

	// 파일 사용 여부 변경 관리 기능 제공시
	int attachFileUseChange(List<AttachFileVO> attachFileList) throws Exception;
}