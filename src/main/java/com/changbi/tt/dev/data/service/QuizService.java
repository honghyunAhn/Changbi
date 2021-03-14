package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.changbi.tt.dev.data.dao.QuizDAO;
import com.changbi.tt.dev.data.vo.ExamSpotVO;
import com.changbi.tt.dev.data.vo.QuizBankVO;
import com.changbi.tt.dev.data.vo.QuizItemVO;
import com.changbi.tt.dev.data.vo.QuizPoolVO;
import com.changbi.tt.dev.data.vo.QuizVO;
import com.changbi.tt.dev.data.vo.ReportVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="data.quizService")
public class QuizService {

	@Autowired
	private QuizDAO quizDao;
	
	@Autowired
    private AttachFileDAO fileDao;
	
	// 시험지 풀 리스트 조회
	public List<QuizPoolVO> quizPoolList(QuizPoolVO quizPool) throws Exception {
		return quizDao.quizPoolList(quizPool);
	}

	// 시험지 풀 리스트 총 갯수
	public int quizPoolTotalCnt(QuizPoolVO quizPool) throws Exception {
		return quizDao.quizPoolTotalCnt(quizPool);
	}

	// 시험지 풀 상세 조회
	public QuizPoolVO quizPoolInfo(QuizPoolVO quizPool) throws Exception {
		return quizDao.quizPoolInfo(quizPool);
	}
	
	// 시험지 풀 등록
	public void quizPoolReg(QuizPoolVO quizPool) throws Exception { 
		quizDao.quizPoolReg(quizPool);
	}
	
	// 시험지 풀 삭제
    public int quizPoolDel(QuizPoolVO quizPool) throws Exception {
    	return quizDao.quizPoolDel(quizPool);
    }
	
	// 시험 리스트 조회
	public List<QuizVO> quizList(QuizVO quiz) throws Exception {
		return quizDao.quizList(quiz);
	}

	// 시험 리스트 총 갯수
	public int quizTotalCnt(QuizVO quiz) throws Exception {
		return quizDao.quizTotalCnt(quiz);
	}

	// 시험 상세 조회
	public QuizVO quizInfo(QuizVO quiz) throws Exception {
		return quizDao.quizInfo(quiz);
	}
	
	// 시험 등록
	public void quizReg(QuizVO quiz) throws Exception { 
		quizDao.quizReg(quiz);
	}
	
	// 시험 수정
	public int quizUpd(QuizVO quiz) throws Exception { 
		return quizDao.quizUpd(quiz);
	}
	
	// 시험 삭제
    public int quizDel(QuizVO quiz) throws Exception {
    	return quizDao.quizDel(quiz);
    }
	
	// 시험 문제 리스트 조회
	public List<QuizItemVO> quizItemList(QuizItemVO quizItem) throws Exception {
		return quizDao.quizItemList(quizItem);
	}
	
	// 시험 문제 리스트 총 갯수
	public int quizItemTotalCnt(QuizItemVO quizItem) throws Exception {
		return quizDao.quizItemTotalCnt(quizItem);
	}
	
	// 시험 문제 상세 조회
	public QuizItemVO quizItemInfo(QuizItemVO quizItem) throws Exception {
		return quizDao.quizItemInfo(quizItem);
	}
	
    // 시험문제 저장 및 수정
    public void quizItemReg(QuizItemVO quizItem) throws Exception {
    	// 시험 문제 생성 시 먼저 문제 은행 생성
    	quizDao.quizItemBankReg(quizItem);
    	
    	// 퀴즈 뱅크 생성 후 
    	if(quizItem.getQuizBank() != null && quizItem.getQuizBank().getId() > 0) {
    		quizDao.quizItemReg(quizItem);
    	}
    }
    
    // 문제은행에서 대량으로 시험문제로 저장
    public int quizItemListReg(QuizItemVO quizItem) throws Exception {
    	int result = 0;
    	
    	// 대량으로 for문 처리
    	if(quizItem.getQuizBankList() != null && quizItem.getQuizBankList().size() > 0) {
    		for(int i=0; i<quizItem.getQuizBankList().size(); ++i) {
    			QuizBankVO quizBank = quizItem.getQuizBankList().get(i);
    			
    			// 체크 되어 넘어간 값만 저장 체크되지 않은 경우는 값이 없으므로 저장 안함.
    			if(quizBank.getId() > 0) {
	    			// 여러개의 문제은행을 순차적으로 저장 
	    			quizItem.setQuizBank(quizBank);
	    			
	    			result += quizDao.quizItemListReg(quizItem);
    			}
    		}
    	}
    	
    	return result; 
    }
    
    // 시험문제 삭제
    public int quizItemDel(QuizItemVO quizItem) throws Exception {
    	return quizDao.quizItemDel(quizItem);
    }
    
    // 레포트 리스트 조회
 	public List<ReportVO> reportList(ReportVO report) throws Exception {
 		return quizDao.reportList(report);
 	}
 	
 	// 레포트 상세 조회
 	public ReportVO reportInfo(ReportVO report) throws Exception {
 		return quizDao.reportInfo(report);
 	}
 	
 	// 첨삭 지도 저장
 	public int correctReg(ReportVO report) throws Exception {
 		return quizDao.correctReg(report);
 	}
 	
 	// 레포트 채점 수정
 	public int reportUpd(QuizVO quiz) throws Exception {
 		int result = 0;
 		
 		if(quiz.getReportList() != null) {
	 		for(int i=0; i<quiz.getReportList().size(); ++i) {
	 			ReportVO report = quiz.getReportList().get(i);
	 			
	 			report.setUpdUser(quiz.getUpdUser());
	 			
	 			result += quizDao.reportUpd(report);
	 		}
 		}
 		
 		return result;
 	}
    
    // 문제은행 리스트 조회
 	public List<QuizBankVO> quizBankList(QuizBankVO quizBank) throws Exception {
 		return quizDao.quizBankList(quizBank);
 	}
 	
 	// 문제은행 리스트 총 갯수
 	public int quizBankTotalCnt(QuizBankVO quizBank) throws Exception {
 		return quizDao.quizBankTotalCnt(quizBank);
 	}
 	
 	// 문제은행 상세 조회
 	public QuizBankVO quizBankInfo(QuizBankVO quizBank) throws Exception {
 		return quizDao.quizBankInfo(quizBank);
 	}
 	
 	// 문제은행 저장 및 수정
 	public void quizBankReg(QuizBankVO quizBank) throws Exception {
 		quizDao.quizBankReg(quizBank);
 	}
     
 	// 문제은행 삭제
 	public int quizBankDel(QuizBankVO quizBank) throws Exception {
 		return quizDao.quizBankDel(quizBank);
 	}
     
 	// 출석 고사장 리스트 조회
 	public List<ExamSpotVO> examSpotList(ExamSpotVO examSpot) throws Exception {
 		return quizDao.examSpotList(examSpot);
 	}

 	// 출석 고사장 리스트 총 갯수
 	public int examSpotTotalCnt(ExamSpotVO examSpot) throws Exception {
 		return quizDao.examSpotTotalCnt(examSpot);
 	}

 	// 출석 고사장 상세 조회
 	public ExamSpotVO examSpotInfo(ExamSpotVO examSpot) throws Exception {
 		return quizDao.examSpotInfo(examSpot);
 	}
 	
 	// 출석 고사장 등록
 	public void examSpotReg(ExamSpotVO examSpot) throws Exception { 
 		quizDao.examSpotReg(examSpot);
 		
 		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(!StringUtil.isEmpty(examSpot.getId())) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(examSpot.getMap() != null && !StringUtil.isEmpty(examSpot.getMap().getFileId())) {
 				attachFileList.add(examSpot.getMap());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
 	}
 	
 	// 출석 고사장 수정
 	public int examSpotUpd(ExamSpotVO examSpot) throws Exception { 
 		int result = quizDao.examSpotUpd(examSpot);
 		
 		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(result > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
            if(examSpot.getMap() != null && !StringUtil.isEmpty(examSpot.getMap().getFileId())) {
 				attachFileList.add(examSpot.getMap());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
        
        return result;
 	}
 	
 	// 출석 고사장 삭제
 	public int examSpotDel(ExamSpotVO examSpot) throws Exception {
 		return quizDao.examSpotDel(examSpot);
    }
 	
 	// 출석 성적 적용
 	public int attScoreReg(List<ReportVO> reportList)  throws Exception {
 		int result = 0;
 		
 		for(int i=0; i<reportList.size(); ++i) {
 			result += quizDao.attScoreReg(reportList.get(i));
 		}
 		
 		return result;
    }
 	
	public List<HashMap<String, Object>> selectExamReplyList(@RequestParam HashMap<String, Object> params) {
		return quizDao.selectExamReplyList(params);
	}
}