package com.changbi.tt.dev.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 파일 관련 유틸
 * 업로드한 파일의 저장 & 서버에 저장된 파일 삭제 등의 기능 제공
 */
public class FileService {
	
	/**
	 * 업로드 된 파일을 지정된 경로에 저장하고, 저장된 파일명을 리턴
	 * @param mfile 업로드된 파일
	 * @param path 저장할 경로
	 * @return 저장된 파일명
	 */
	public static String saveFile(MultipartFile mfile, String uploadPath) {
		//업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}
		//저장 폴더가 없으면 생성
		//리눅스 용도
		uploadPath = "/usr/local/"+uploadPath;
		
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		//원본 파일명
		String originalFilename = mfile.getOriginalFilename();
		
		//저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String savedFilename = sdf.format(new Date());
		
		//원본 파일의 확장자
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		//확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		//확장자가 있는 경우
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		//저장할 전체 경로를 포함한 File 객체
		File serverFile = null;
		
		//같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			//같은 이름의 파일이 없으면 나감.
			if ( !serverFile.isFile()) break;	
			//같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();	
		}		
		
		//파일 저장
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}
		
		return savedFilename + ext;
	}
	
	/**
	 * 서버에 저장된 파일의 전체 경로를 전달받아, 해당 파일을 삭제
	 * @param fullpath 삭제할 파일의 경로
	 * @return 삭제 여부
	 */
	public static boolean deleteFile(String saved,String path) {
		
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
	
	public static HashMap<String, String> temporarilySave(MultipartHttpServletRequest request , String temporarilyPath){
		HashMap<String, String> result = new HashMap<>();
		Iterator<String> itr =  request.getFileNames();
		
        if(itr.hasNext()) {
            MultipartFile mpf = request.getFile(itr.next());
    		if (!mpf.isEmpty()) {
    			String savedfile = FileService.saveFile(mpf, temporarilyPath);
    			result.put("originalfile", mpf.getOriginalFilename());
    			result.put("savedfile", savedfile);
    		}
        } 
		return result;
	}
	
	public static ArrayList<HashMap<String, String>> temporarilySaveAll(MultipartHttpServletRequest request , String temporarilyPath){
		ArrayList<HashMap<String, String>> result=new ArrayList<HashMap<String, String>>();
		
		List<MultipartFile> mps =  request.getFiles("files");
		
		
		for(MultipartFile mp:mps){
			HashMap<String, String> map = new HashMap<>();
			String savedfile =  FileService.saveFile(mp, temporarilyPath);
			map.put("originalfile", mp.getOriginalFilename());
			map.put("savedfile", savedfile);
			result.add(map);
		}
		
		
		return result;
	}
	
	public static void fileDownload(HttpServletResponse response, String origin , String saved, String path){
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		//리눅스 용도
		path = "/usr/local/"+path;
		String fullPath = null;
		if(saved.isEmpty() || saved == null) {
			fullPath = path;
		} else {
			fullPath = path + "/" + saved;
		}
		
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
	
	public static String fileCopy(String origin, String saved, String oldPath, String newPath) {
		
		//리눅스 용도
		oldPath = "/usr/local/"+oldPath;
		newPath = "/usr/local/"+newPath;
		
		String oldFullPath = oldPath + "/" + saved;
		
		File path = new File(newPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		//저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String savedFilename = sdf.format(new Date());
		
		//원본 파일의 확장자
		String ext;
		int lastIndex = origin.lastIndexOf('.');
		//확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		//확장자가 있는 경우
		else {
			ext = "." + origin.substring(lastIndex + 1);
		}

		//저장할 전체 경로를 포함한 File 객체
		File serverFile = null;
		
		//같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(newPath + "/" + savedFilename + ext);
			//같은 이름의 파일이 없으면 나감.
			if ( !serverFile.isFile()) break;	
			//같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();	
		}
		
		
		try {
			fis = new FileInputStream(oldFullPath);
			fos = new FileOutputStream(serverFile);
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(fis,fos);
			
			fis.close();
			fos.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return savedFilename + ext;
	}
	
	
}
