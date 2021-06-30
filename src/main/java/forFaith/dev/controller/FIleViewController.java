/**
 * 
 */
package forFaith.dev.controller;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

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
	public void communityImageUpload(MultipartHttpServletRequest request, Model model,String CKEditorFuncNum, HttpServletResponse response) {
		
		HashMap<String, String> result = FileService.temporarilySave(request,eduApplyCkeditor);
		PrintWriter printWriter = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String fileUrl = eduApplyCkeditor+"/"+result.get("savedfile");
		String callback = CKEditorFuncNum;
		
		try {
			printWriter = response.getWriter();
			printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("+ callback+ ",'"+ fileUrl+"','파일 전송 완료.'"+ ")</script>");
			printWriter.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (printWriter != null) {
				printWriter.close();
			}
		}
	}
}
