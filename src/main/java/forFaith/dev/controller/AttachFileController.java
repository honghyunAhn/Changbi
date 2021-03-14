/**
 * File Controller
 * @author : kjs(2016-10-10)
 */

package forFaith.dev.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import forFaith.dev.service.AttachFileService;
import forFaith.dev.vo.AttachFileDetailVO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.domain.NaverSmartEditor;
import forFaith.domain.SpringFileUpload;
import forFaith.domain.SpringMultiFileUpload;
import forFaith.file.FileInfo;
import forFaith.file.MakeFile;
import forFaith.file.SpringMakeFileInfo;
import forFaith.util.FileUtil;
import forFaith.util.StringUtil;

@Controller(value="forFaith.attachFileController")	// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/forFaith/file")		// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class AttachFileController {

	/**
	 * log를 남기는 객체 생성
	 * @author : 김준석(2016-10-10)
	 */
	private static final Logger logger = LoggerFactory.getLogger(AttachFileController.class);

	@Autowired
	private AttachFileService fileService;

	// 팝업 용 파일 업로드
	@RequestMapping(value = "/fileUploadPopup")
	public void fileUploadPopup(SpringFileUpload springFileUpload, Model model) throws Exception {
		model.addAttribute("uploadFile", springFileUpload);
	}

	/**
	 * 파일 업로드 후 데이터 전송(한번에 전송받는다)
	 * @param springFileUpload
	 * @param session
	 * @return AttachFileVO
	 * @throws IOException
	 */
	@RequestMapping(value = "/attachFileReg", method = RequestMethod.POST)
	public @ResponseBody AttachFileVO attachFileReg(SpringMultiFileUpload uploadFileList, HttpSession session) throws Exception {
		AttachFileVO attachFile = new AttachFileVO();

		if(uploadFileList != null && uploadFileList.getFileList() != null && uploadFileList.getFileList().size() > 0) {
			SpringFileUpload springFileUpload = uploadFileList.getFileList().get(0);

			String fileId = springFileUpload.getFileId();
			String uploadDir = springFileUpload.getUploadDir();
			
			// 실제 파일 저장 경로를 지정해준다.
			//String realPath = session.getServletContext().getRealPath(uploadDir);
			//String realPath = "D:\\eGovFrameDev-3.5.1-64bit\\workspace\\jejuolle_admin\\src\\main\\webapp\\upload\\partner\\images";
			String realPath = "/usr/local/uploadImage";		
			//String realPath = "/home/changbi/service/admin"+uploadDir;
			//String realPath = "/home/changbi/uploadImage/";
			
			logger.info("realPath ==> "+realPath);
			logger.info("removeFileName ==> "+springFileUpload.getRemoveFileName());
			
			// 등록하는 파일당 한번씩 파일 생성
			List<FileInfo> fileInfoList = SpringMakeFileInfo.getFileInfoList(uploadFileList.getFileList(), uploadDir, realPath);

			// 기본 정보 저장
			if(fileInfoList != null && fileInfoList.size() > 0) {
				// 삭제 시킬 파일이 존재하면 삭제 시킴 
				if(!StringUtil.isEmpty(springFileUpload.getRemoveFileName())) {
					File fileDir	= new File(realPath);
	                File removeFile	= new File(fileDir+FileUtil.SEPARATOR+springFileUpload.getRemoveFileName());

	                if(removeFile != null && removeFile.exists()) {
	                	removeFile.delete();
	                }
				}
				
				for(int i=0; i<fileInfoList.size(); ++i) {
					FileInfo fileInfo = fileInfoList.get(i);

					AttachFileDetailVO attachFileDetail = new AttachFileDetailVO();

					attachFileDetail.setFilePath(fileInfo.getPath());
					attachFileDetail.setFileExt(fileInfo.getExt());
					attachFileDetail.setFileName(fileInfo.getName());
					attachFileDetail.setFileSize(fileInfo.getFileSize());
					attachFileDetail.setUrlPath(fileInfo.getUrlPath());
					attachFileDetail.setOriginFileName(fileInfo.getOriginFileName());

					attachFile.addDetail(attachFileDetail);
				}
			}

			// 파일 ID가 비어 있으면 랜덤으로 생성한 후에 저장
			if(StringUtil.isEmpty(fileId)) {
				fileId = "FILE_";
                int randomNumber = 1000000;
                
                // 한글 파일 처리를 위해 파일 명을 랜덤함수를 이용해서 저장하고 original 이름을 따로 저장시킨다.
                // FILE_현재 날짜_랜덤 8자리 수 형태의 파일로 생성함.
                Random random = new Random();

                // 현재 시간 저장(같은 이름 중복인 경우 기존 파일에 날짜를 붙여서 저장시킴)
                String currDate = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

                // 랜덤 숫자 발생 기본은 1000000에서 9999999사이
                randomNumber = random.nextInt(9000000)+randomNumber;
                
                //20자리 FILE_오늘날짜+랜덤숫자(7) 로 이루어진 파일명 생성
                fileId += currDate+randomNumber;
			}
			
			attachFile.setFileId(fileId);

			// 파일 DB 처리(파일 상세가 생성 되지 않아도 파일 ID만 저장해도 됨.)
			fileService.attachFileReg(attachFile);
		}

		return attachFile;
	}

	/**
	 * 파일 삭제 후 데이터 전송
	 * @param attachFile
	 * @return Integer
	 * @throws IOException
	 */
	@RequestMapping(value = "/attachFileDel", method = RequestMethod.POST)
	public @ResponseBody Integer attachFileDel(@RequestBody AttachFileVO attachFile) throws Exception {
		int result = 0;

		if(!StringUtil.isEmpty(attachFile.getFileId()) && attachFile.getDetailList() != null && attachFile.getDetailList().size() > 0) {
			for(int i=0; i<attachFile.getDetailList().size(); ++i) {
				AttachFileDetailVO detail = attachFile.getDetailList().get(i);
				
				/*첨부파일이 처음 학적부에 저장될 때 등록된 파일과 동일한 경우 즉, 학적부에서 따로 수정하지 않은 경우에는
				 * 첨부파일에 filePath가 없으므로 DB에서만 삭제되고 실제 파일은 삭제되지 않는다. 따라서 관리자 지원관리 페이지나 smtp사용자 페이지에서는 계속 파일을 확인할 수 있다.*/

				if(!StringUtil.isEmpty(detail.getFilePath())) {
					// 파일 생성 후 DB에서 데이터 삭제 후 삭제가 정상인 경우에 실제 파일을 삭제 한다.
					File file = MakeFile.getFile(detail.getFilePath());

					// 파일 삭제
					if(file != null && file.exists()) {
						file.delete();
					}
				}
			}

			// DB 삭제
			result = fileService.attachFileDel(attachFile);
		}

		return result;
	}

	/**
	 * 파일 리스트 조회
	 * @param fileData
	 * @param request
	 * @param session
	 * @return NaverSmartEditor
	 * @throws IOException
	 */
	@RequestMapping(value = "/attachFileList", method = RequestMethod.POST)
	public @ResponseBody List<AttachFileVO> attachFileList(AttachFileVO attachFile) throws Exception {
		return fileService.attachFileList(attachFile);
	}

	@RequestMapping(value = "/file_download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved, String path){
		
		fileService.fileDownload(response, origin, saved, path);
	}
	
	/**
	 * 업로드된  파일 삭제 후 데이터 전송
	 * @param saved
	 * @param path
	 */
	
	@ResponseBody
	@RequestMapping(value = "/deleteCertiFile", method = RequestMethod.POST)
	public void deleteCertiFile(String saved, String path){
		
		fileService.deleteFile(saved, path);
	}
	
	/**
	 * 네이버 Edit 사용 시 Edit 파일 업로드 후 데이터 전송
	 * @param fileData
	 * @param request
	 * @param session
	 * @return NaverSmartEditor
	 * @throws IOException
	 */
	@RequestMapping(value = "/naverSmartEditor", method = RequestMethod.POST)
	public @ResponseBody NaverSmartEditor naverSmartEditor(SpringFileUpload springFileUpload, HttpSession session) throws Exception {
		
		logger.info("네이버 스마트 에디터 사진 업로드 컨트롤러 시작");

		NaverSmartEditor naverEditor = new NaverSmartEditor();

//		springFileUpload.setUploadDir("/se2/editorImage");		set 안하는 경우는 default로 생성되는 urlPath 사용함.
		springFileUpload.setUploadDir("D:/uploadImage");		// set 안하는 경우는 default로 생성되는 urlPath 사용함.
		//	springFileUpload.setUploadDir("/home/changbi/uploadImage");		// set 안하는 경우는 default로 생성되는 urlPath 사용함.

		
		// 실제 파일 저장 경로를 지정해준다.
		String realPath = session.getServletContext().getRealPath(springFileUpload.getUploadDir());
		System.out.println("!!!!!!!!!!!!!!!!");
		logger.info("uploadDir ==> "+springFileUpload.getUploadDir());
		logger.info("realPath ==> "+realPath);
		logger.info("originalFileName ==> "+URLDecoder.decode(springFileUpload.getOriginFileName(), "UTF-8"));

		// 등록하는 이미지당 한번씩 파일 생성
		FileInfo editorFileInfo = SpringMakeFileInfo.getFileInfo(springFileUpload, springFileUpload.getUploadDir(), realPath);

		logger.info("fileName ==> "+editorFileInfo.getOriginFileName());
		logger.info("fileUrl ==> "+editorFileInfo.getUrlPath());

		naverEditor.setbNewLine("true");
		naverEditor.setsFileName(editorFileInfo.getOriginFileName());
		//이미지 파일 경로를 배너 경로와 공유하기 때문에 URL 설정 또한 동일.
		//editorFileInfo에서 변경된 파일명만 불러오는 메서드가 존재하지 않기 때문에 substring을 통해 변경된 파일명만 뽑고, 경로에 연결한다.
		naverEditor.setsFileURL("/upload/banner/files/" + editorFileInfo.getUrlPath().substring(editorFileInfo.getUrlPath().lastIndexOf("/")+1, editorFileInfo.getUrlPath().length()));
		naverEditor.setCallbackFunc("test");

		logger.info("네이버 스마트 에디터 사진 업로드 컨트롤러 끝");
		
		return naverEditor;
	}
		
	
	@ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
}
