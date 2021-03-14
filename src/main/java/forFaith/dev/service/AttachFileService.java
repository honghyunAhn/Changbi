package forFaith.dev.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="forFaith.attachFileService")
public class AttachFileService {

	/**
	 * DB 데이터를 얻기 위한 객체 - MyBatis 자동 객체 생성
	 * author : 섬(김준석 - 2014년 3월 10일)
	 */
	@Autowired
	private AttachFileDAO fileDao;

	// 파일 리스트 가지고 온다. fileId가 존재하면 fileId에 해당하는 1개 파일정보 존재하지 않으면 useYn 이 Y인 모든 파일 정보 리스트
	public List<AttachFileVO> attachFileList(AttachFileVO attachFile) throws Exception {
		return fileDao.attachFileList(attachFile);
	}

	// fileId에 해당하는 파일 정보 useYn이 Y인 경우
	public AttachFileVO attachFileInfo(AttachFileVO attachFile) throws Exception {
		return fileDao.attachFileInfo(attachFile);
	}

	// 파일 등록 시 파일 정보 등록 후 파일 상세 정보 등록
    public void attachFileReg(AttachFileVO attachFile) throws Exception {
        // attach_file insert 후 file_id를 얻어온다.
        fileDao.attachFileReg(attachFile);

        // 생성 된 file_id혹은 기존에 존재하는 file_id로 attach_file_detail에 저장시킨다.
        if(!StringUtil.isEmpty(attachFile.getFileId())) {
            fileDao.attachFileDetailReg(attachFile);
        }
    }

	// 파일 삭제 시 파일 update 날짜 변경 후 상세 파일 삭제
	public int attachFileDel(AttachFileVO attachFile) throws Exception {
		// delete 전에 파일 업데이트(날짜 및 유저) 시키고 삭제 한다.
	    fileDao.attachFileReg(attachFile);

		return fileDao.attachFileDetailDel(attachFile);
	}
	
	public boolean deleteFile(String saved, String path) {
		//리눅스 용도
		path = "/usr/local/"+path;
		
		String fullPath = path + "/" + saved;
		//파일 삭제 여부를 리턴할 변수
		boolean result = false;

		//전달된 전체 경로로 File객체 생성
		File delFile = new File(fullPath);
		
		//해당 파일이 존재하면 삭제
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		
		return result;
	}
	
	public void fileDownload(HttpServletResponse response, String origin, String saved, String path) {
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		//리눅스 용도
		path = "/usr/local/"+path;
		//path = "/upload"+path;
		
		String fullPath = path + "/" + saved;
		
		//서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
