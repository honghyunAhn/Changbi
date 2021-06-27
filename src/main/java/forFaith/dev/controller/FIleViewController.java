/**
 * 
 */
package forFaith.dev.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.changbi.tt.dev.util.FileService;
import com.lms.student.util.PathConstants;

import forFaith.dev.service.AttachFileService;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 27.
 * @Class 설명 : Soft Engineer Group의 File 관련 View Controller 
 * 
 */
@Controller
public class FIleViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(FIleViewController.class);
	
	@Value("#{props['temporarilyPath']}")
	private String temporarilyPath;
	
	@Value("#{props['edu.apply.ckeditor']}")
	private String eduApplyCkeditor;

	@Autowired
	AttachFileService fileService;
	
	@RequestMapping(value = PathConstants.TEMPORARILY_DOWNLOAD, method = RequestMethod.GET)
	public void temporarilyDownload(HttpServletResponse response, String origin , String saved){
		fileService.fileDownload(response, origin, saved,temporarilyPath);
		fileService.deleteFile(saved,temporarilyPath);
	}
	
	@RequestMapping(value = PathConstants.FILE_DOWNLOAD, method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved, String path){
		fileService.fileDownload(response, origin, saved, path);
	}
	
	/*
	 * CKEditor 이미지 등록
	 */
	@RequestMapping(value = "/board/imageUpload", method = RequestMethod.POST)
	public String communityImageUpload(MultipartHttpServletRequest request, Model model,String CKEditorFuncNum, HttpServletResponse response) {
		logger.info("FAP 기업 메인 페이지 컨트롤러 시작");
		HashMap<String, String> result = FileService.temporarilySave(request,eduApplyCkeditor);
		
		model.addAttribute("file_path", eduApplyCkeditor+"/"+result.get("savedfile"));
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		
		logger.info("FAP 기업 메인 페이지 컨트롤러 시작");
		return "admin/board/board_ckeditor";
	}
}
