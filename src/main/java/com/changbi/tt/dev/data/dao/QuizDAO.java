package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.ExamSpotVO;
import com.changbi.tt.dev.data.vo.QuizBankVO;
import com.changbi.tt.dev.data.vo.QuizItemVO;
import com.changbi.tt.dev.data.vo.QuizPoolVO;
import com.changbi.tt.dev.data.vo.QuizVO;
import com.changbi.tt.dev.data.vo.ReportVO;

public interface QuizDAO {

	// 시험지 풀 리스트 조회
	List<QuizPoolVO> quizPoolList(QuizPoolVO quizPool) throws Exception;

	// 시험지 풀 리스트 총 갯수
	int quizPoolTotalCnt(QuizPoolVO quizPool) throws Exception;

	// 시험지 풀 상세 조회
	QuizPoolVO quizPoolInfo(QuizPoolVO quizPool) throws Exception;
	
	// 시험지 풀 등록
	void quizPoolReg(QuizPoolVO quizPool) throws Exception;
	
	// 시험지 풀 삭제
    int quizPoolDel(QuizPoolVO quizPool) throws Exception;
    
	// 시험 리스트 조회
	List<QuizVO> quizList(QuizVO quiz) throws Exception;

	// 시험 리스트 총 갯수
	int quizTotalCnt(QuizVO quiz) throws Exception;

	// 시험 상세 조회
	QuizVO quizInfo(QuizVO quiz) throws Exception;
	
	// 시험 등록
	void quizReg(QuizVO quiz) throws Exception;
	
	// 시험 수정
	int quizUpd(QuizVO quiz) throws Exception;
	
	// 시험 삭제
    int quizDel(QuizVO quiz) throws Exception;
	
	// 시험 문제 리스트 조회
	List<QuizItemVO> quizItemList(QuizItemVO quizItem) throws Exception;
	
	// 시험 문제 리스트 총 갯수
	int quizItemTotalCnt(QuizItemVO quizItem) throws Exception;
	
	// 시험 문제 상세 조회
	QuizItemVO quizItemInfo(QuizItemVO quizItem) throws Exception;
	
	// 시험문제 저장 시에만 문제은행에 저장
    void quizItemBankReg(QuizItemVO quizItem) throws Exception;
	
    // 시험문제 저장 및 수정
    void quizItemReg(QuizItemVO quizItem) throws Exception;
    
    // 문제은행에서 대량으로 시험문제로 저장
    public int quizItemListReg(QuizItemVO quizItem) throws Exception;
    
    // 시험문제 삭제
    int quizItemDel(QuizItemVO quizItem) throws Exception;
    
    // 레포트 리스트 조회
  	List<ReportVO> reportList(ReportVO report) throws Exception;
  	
  	// 레포트 상세 조회
  	ReportVO reportInfo(ReportVO report) throws Exception;
  	
  	// 첨삭 지도 저장
  	int correctReg(ReportVO report) throws Exception;
  	
  	// 레포트 채점 수정
  	int reportUpd(ReportVO report) throws Exception;
  	
    // 문제은행 리스트 조회
	List<QuizBankVO> quizBankList(QuizBankVO quizBank) throws Exception;
 	
	// 문제은행 리스트 총 갯수
	int quizBankTotalCnt(QuizBankVO quizBank) throws Exception;
	
	// 문제은행 상세 조회
	QuizBankVO quizBankInfo(QuizBankVO quizBank) throws Exception;
  	
	// 문제은행 저장 및 수정
	void quizBankReg(QuizBankVO quizBank) throws Exception;
  
	// 문제은행 삭제
	int quizBankDel(QuizBankVO quizBank) throws Exception;
	
	// 출석 고사장 리스트 조회
 	List<ExamSpotVO> examSpotList(ExamSpotVO examSpot) throws Exception;

 	// 출석 고사장 리스트 총 갯수
 	int examSpotTotalCnt(ExamSpotVO examSpot) throws Exception;

 	// 출석 고사장 상세 조회
 	ExamSpotVO examSpotInfo(ExamSpotVO examSpot) throws Exception;
 	
 	// 출석 고사장 등록
 	void examSpotReg(ExamSpotVO examSpot) throws Exception;
 	
 	// 출석 고사장 수정
 	int examSpotUpd(ExamSpotVO examSpot) throws Exception;
 	
 	// 출석 고사장 삭제
  	int examSpotDel(ExamSpotVO examSpot) throws Exception;
  	
  	// 출석 성적 적용
  	int attScoreReg(ReportVO report)  throws Exception;
  	
  	// 응답 리스트 조회
  	List<HashMap<String, Object>> selectExamReplyList(HashMap<String, Object> params);
}