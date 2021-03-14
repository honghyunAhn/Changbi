package com.changbi.tt.dev.data.dao;

import java.util.List;
import java.util.Map;

import com.changbi.tt.dev.data.vo.StatsVO;

public interface StatsDAO {

	// 기수 / 과정 별 통계 리스트
	List<Map<String, String>> courseStatsList(StatsVO stats) throws Exception;

	// 회원가입현황 통계
	List<Map<String, String>> joinStatsList(StatsVO stats) throws Exception;
	
	// 회원현황 및 게시물 통계
	Map<String, String> userStatsList(StatsVO stats) throws Exception;
	
	// 수강현황통계(I)
	Map<String, String> learnStatsList(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 월단위 별 추이분석(25개월)
	List<Map<String, String>> learnStatsGraph1(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 연수형태별 분석 (접수유형별)
	List<Map<String, String>> learnStatsGraph2_1(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 연수형태별 분석 (직무연수 학점별)
	List<Map<String, String>> learnStatsGraph2_2(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 최다접수과정 TOP 5
	List<Map<String, String>> learnStatsGraph3_1(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 교원선호과정 TOP 5
	List<Map<String, String>> learnStatsGraph3_2(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 이수현황(인증건/무료연수제외)
	Map<String, String> learnStatsGraph4_1(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 결제형태(결제완료건)
	Map<String, String> learnStatsGraph4_2(StatsVO stats) throws Exception;
	
	// 수강현황통계(II) - 학점별 이수율 분석
	List<Map<String, String>> learnStatsGraph5(StatsVO stats) throws Exception;
	
	// 연수설문 통계상세
	List<Map<String, String>> surveyStatsDetailList(StatsVO stats) throws Exception;
	
	// 연수만족도통계 > 기수의 과정 만족도 상위Top5
	List<Map<String, String>> satisByCourseTop5(StatsVO stats) throws Exception;
	
	// 연수만족도통계 > 기수 만족도분포  
	List<Map<String, String>> satisByCardinal(StatsVO stats) throws Exception;
	
	// 연수만족도통계 > 설문자 연령분포
	Map<String, String> satisByAgeGroup(StatsVO stats) throws Exception;
	
	// 연수만족도통계 > 학교구분에 따른 만족도 통계
	List<Map<String, String>> satisByClassType(StatsVO stats) throws Exception;
	
	// sms 발송  총 갯수
	int smsHistoryTotalCnt(StatsVO stats) throws Exception;
	
	// sms 발송 통계
	List<Map<String, String>> smsHistoryStats(StatsVO stats) throws Exception;
}