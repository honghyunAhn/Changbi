/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.changbi.tt.dev.data.service.QuizService;
import com.changbi.tt.dev.data.vo.ExamSpotVO;
import com.changbi.tt.dev.data.vo.QuizBankVO;
import com.changbi.tt.dev.data.vo.QuizItemVO;
import com.changbi.tt.dev.data.vo.QuizPoolVO;
import com.changbi.tt.dev.data.vo.QuizVO;
import com.changbi.tt.dev.data.vo.ReportVO;

import forFaith.dev.excel.ExcelUpLoad;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.file.FileInfo;
import forFaith.file.MakeFileInfo;
import forFaith.file.SpringMakeFile;
import forFaith.util.DataList;

@Controller(value="data.quizController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/quiz")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class QuizController {

	@Autowired
	private QuizService quizService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(QuizController.class);

    /**
     * 시험지 풀 정보 리스트
     */
    @RequestMapping(value = "/quizPoolList", method = RequestMethod.POST)
    public @ResponseBody DataList<QuizPoolVO> quizPoolList(QuizPoolVO quizPool) throws Exception {
    	DataList<QuizPoolVO> result = new DataList<QuizPoolVO>();
    	
    	result.setPagingYn(quizPool.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(quizPool.getNumOfNums());
			result.setNumOfRows(quizPool.getNumOfRows());
			result.setPageNo(quizPool.getPageNo());
			result.setTotalCount(quizService.quizPoolTotalCnt(quizPool));
		}

		// 결과 리스트를 저장
		result.setList(quizService.quizPoolList(quizPool));

		return result;
    }
    
    /**
     * 시험지 풀 정보 저장
     */
    @RequestMapping(value="/quizPoolReg", method=RequestMethod.POST)
    public @ResponseBody QuizPoolVO quizPoolReg(QuizPoolVO quizPool) throws Exception {
        if(quizPool != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quizPool.setRegUser(loginUser);
        	quizPool.setUpdUser(loginUser);

        	quizService.quizPoolReg(quizPool);
        }

        return quizPool;
    }
    
    /**
     * 시험지 풀 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/quizPoolDel", method=RequestMethod.POST)
    public @ResponseBody int quizPoolDel(QuizPoolVO quizPool) throws Exception {
    	int result = quizService.quizPoolDel(quizPool);
        
        return result;
    }
    
    /**
     * 시험 정보 리스트
     */
    @RequestMapping(value = "/quizList", method = RequestMethod.POST)
    public @ResponseBody DataList<QuizVO> quizList(QuizVO quiz) throws Exception {
    	DataList<QuizVO> result = new DataList<QuizVO>();
    	
    	result.setPagingYn(quiz.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(quiz.getNumOfNums());
			result.setNumOfRows(quiz.getNumOfRows());
			result.setPageNo(quiz.getPageNo());
			result.setTotalCount(quizService.quizTotalCnt(quiz));
		}

		// 결과 리스트를 저장
		result.setList(quizService.quizList(quiz));

		return result;
    }
    
    /**
     * 시험 정보 저장 
     */
    @RequestMapping(value="/quizReg", method=RequestMethod.POST)
    public @ResponseBody QuizVO quizReg(QuizVO quiz) throws Exception {
        if(quiz != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quiz.setRegUser(loginUser);
        	quiz.setUpdUser(loginUser);

        	quizService.quizReg(quiz);
        }

        return quiz;
    }
    
    /**
     * 시험 정보 수정 
     */
    @RequestMapping(value="/quizUpd", method=RequestMethod.POST)
    public @ResponseBody Integer quizUpd(QuizVO quiz) throws Exception {
    	int result = 0;
    	
        if(quiz != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quiz.setUpdUser(loginUser);

        	result = quizService.quizUpd(quiz);
        }

        return result;
    }
    
    /**
	 * 시험 문제 리스트 조회
	 */
	@RequestMapping(value="/quizItemList", method=RequestMethod.POST)
	public @ResponseBody DataList<QuizItemVO> quizItemList(QuizItemVO quizItem, ModelMap model) throws Exception {
		DataList<QuizItemVO> result = new DataList<QuizItemVO>();
    	
		// 결과 리스트를 저장
		result.setList(quizService.quizItemList(quizItem));

		return result;
	}
	
	/**
     * 시험문제 저장 및 수정
     */
    @RequestMapping(value="/quizItemReg", method=RequestMethod.POST)
    public @ResponseBody QuizItemVO quizItemReg(QuizItemVO quizItem) throws Exception {
        if(quizItem != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quizItem.setRegUser(loginUser);
        	quizItem.setUpdUser(loginUser);

        	quizService.quizItemReg(quizItem);
        }

        return quizItem;
    }
    
    /**
     * 문제은행에서 시험문제로 저장
     */
    @RequestMapping(value="/quizItemListReg", method=RequestMethod.POST)
    public @ResponseBody Integer quizItemListReg(QuizItemVO quizItem) throws Exception {
    	int result = 0;
        if(quizItem != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quizItem.setRegUser(loginUser);
        	quizItem.setUpdUser(loginUser);

        	result = quizService.quizItemListReg(quizItem);
        }

        return result;
    }
    
    /**
     * 시험문제 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/quizItemDel", method=RequestMethod.POST)
    public @ResponseBody int quizItemDel(QuizItemVO quizItem) throws Exception {
    	int result = quizService.quizItemDel(quizItem);
        
        return result;
    }
    
    /**
	 * 문제은행 리스트 조회
	 */
	@RequestMapping(value="/quizBankList", method=RequestMethod.POST)
	public @ResponseBody DataList<QuizBankVO> quizBankList(QuizBankVO quizBank, ModelMap model) throws Exception {
		DataList<QuizBankVO> result = new DataList<QuizBankVO>();
    	
		// 결과 리스트를 저장
		result.setList(quizService.quizBankList(quizBank));

		return result;
	}
	
	/**
     * 첨삭 등록
     */
    @RequestMapping(value="/popup/correctReg", method=RequestMethod.POST)
    public @ResponseBody int popupCorrectReg(ReportVO report) throws Exception {
    	return quizService.correctReg(report);
    }
	
	/**
     * 점수 채점 저장 정보 수정 
     */
    @RequestMapping(value="/reportUpd", method=RequestMethod.POST)
    public @ResponseBody Integer reportUpd(QuizVO quiz) throws Exception {
    	int result = 0;
    	
        if(quiz != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
        	/*logger.info("score = " + quiz.getReportList().get(0).getScore());*/
    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quiz.setUpdUser(loginUser);

        	result = quizService.reportUpd(quiz);
        }

        return result;
    }
	
	/**
     * 문제은행 저장 및 수정
     */
    @RequestMapping(value="/quizBankReg", method=RequestMethod.POST)
    public @ResponseBody QuizBankVO quizBankReg(QuizBankVO quizBank) throws Exception {
        if(quizBank != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	quizBank.setRegUser(loginUser);
        	quizBank.setUpdUser(loginUser);

        	quizService.quizBankReg(quizBank);
        }

        return quizBank;
    }
    
    /**
     * 문제은행 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/quizBankDel", method=RequestMethod.POST)
    public @ResponseBody int quizBankDel(QuizBankVO quizBank) throws Exception {
    	int result = quizService.quizBankDel(quizBank);
        
        return result;
    }
    
    /**
     * 출석평가 고사장 정보 리스트
     */
    @RequestMapping(value = "/examSpotList", method = RequestMethod.POST)
    public @ResponseBody DataList<ExamSpotVO> examSpotList(ExamSpotVO examSpot) throws Exception {
    	DataList<ExamSpotVO> result = new DataList<ExamSpotVO>();
    	
    	result.setPagingYn(examSpot.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(examSpot.getNumOfNums());
			result.setNumOfRows(examSpot.getNumOfRows());
			result.setPageNo(examSpot.getPageNo());
			result.setTotalCount(quizService.examSpotTotalCnt(examSpot));
		}

		// 결과 리스트를 저장
		result.setList(quizService.examSpotList(examSpot));

		return result;
    }
    
    /**
     * 출석평가 고사장 정보 저장 
     */
    @RequestMapping(value="/examSpotReg", method=RequestMethod.POST)
    public @ResponseBody ExamSpotVO examSpotReg(ExamSpotVO examSpot) throws Exception {
        if(examSpot != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	examSpot.setRegUser(loginUser);
        	examSpot.setUpdUser(loginUser);

        	quizService.examSpotReg(examSpot);
        }

        return examSpot;
    }
    
    /**
     * 출석평가 고사장 정보 수정 
     */
    @RequestMapping(value="/examSpotUpd", method=RequestMethod.POST)
    public @ResponseBody Integer examSpotUpd(ExamSpotVO examSpot) throws Exception {
    	int result = 0;
    	
        if(examSpot != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	examSpot.setUpdUser(loginUser);

        	result = quizService.examSpotUpd(examSpot);
        }

        return result;
    }
    
    /**
     * 출석평가 고사장 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/examSpotDel", method=RequestMethod.POST)
    public @ResponseBody int examSpotDel(ExamSpotVO examSpot) throws Exception {
    	int result = quizService.examSpotDel(examSpot);
        
        return result;
    }
    
    /**
     * 기념품 파일 업로드 후 데이터 전송
     * @param springFileUpload
     * @param session
     * @return AttachFileVO
     * @throws IOException
     */
    @RequestMapping(value = "/excel/upload/attScore", method = RequestMethod.POST)
    public @ResponseBody String excelUploadAttScore(ReportVO report, HttpSession session, RedirectAttributes redirectAttr) throws Exception {
    	String result = "";
    	
        if(report.getSpringFileUpload() != null && report.getSpringFileUpload().getMultipartFile() != null) {
            MultipartFile multipartFile = report.getSpringFileUpload().getMultipartFile();
            String uploadDir = report.getSpringFileUpload().getUploadDir();
            String ext = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".")+1);

            if(ext.equals("xls") || ext.equals("xlsx") || ext.equals("xlsm")) {
                // 실제 파일 저장 경로를 지정해준다.
                String realPath = session.getServletContext().getRealPath(uploadDir);
                //String realPath = "D:\\eGovFrameDev-3.5.1-64bit\\workspace\\jejuolle_admin\\src\\main\\webapp\\upload\\partner\\images";

                // 등록하는 파일당 한번씩 파일 생성
                FileInfo fileInfo = MakeFileInfo.getFileInfo(SpringMakeFile.getFile(multipartFile, realPath));

                if(fileInfo == null || fileInfo.getFile() == null || fileInfo.getFile().isFile()) {
                    List<Map<Integer, String>> dataList = ExcelUpLoad.getDataList(fileInfo);

                    List<ReportVO> reportList = new ArrayList<ReportVO>();

                    for(int i=0; i<dataList.size(); ++i) {
                    	ReportVO temp = new ReportVO();
                        Map<Integer, String> data = dataList.get(i);

                        temp.setCardinal(report.getCardinal());
                        temp.setCourse(report.getCourse());
                        temp.setExamNum(data.get(4));
                        temp.setScore(Integer.parseInt(data.get(5)));
                        temp.setAnswer(data.get(6));
                        
                        reportList.add(temp);
                    }

                    result = quizService.attScoreReg(reportList)+"";
                } else {
                	result = "파일 생성 실패!!";
                }
            } else {
                result = "잘못된 파일 형식입니다.";
            }
        } else {
        	result = "업로드된 파일이 없습니다.";
        }

        return result;
    }

    /**
     * Exception 처리
     * @param Exception
     * @return ModelAndView
     * @author : 김준석 - (2015-06-03)
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
}