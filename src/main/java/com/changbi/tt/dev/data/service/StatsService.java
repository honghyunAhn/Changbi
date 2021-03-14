package com.changbi.tt.dev.data.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.StatsDAO;
import com.changbi.tt.dev.data.vo.StatsVO;

@Service(value="data.statsService")
public class StatsService {

	@Autowired
	private StatsDAO statsDao;
	
	// 기수 / 과정 별 통계 리스트
	public List<Map<String, String>> courseStatsList(StatsVO stats) throws Exception {
		return statsDao.courseStatsList(stats);
	}

	// 회원가입현황 통계
	public List<Map<String, String>> joinStatsList(StatsVO stats) throws Exception {
		return statsDao.joinStatsList(stats);
	}
	
	// 회원현황 및 게시물 통계
	public Map<String, String> userStatsList(StatsVO stats) throws Exception {
		return statsDao.userStatsList(stats);
	}
	
	// 수강현황통계(I)
	public Map<String, String> learnStatsList(StatsVO stats) throws Exception {
		return statsDao.learnStatsList(stats);
	}
	
	// 수강현황통계(II) - 월단위 별 추이분석(25개월)
	public List<Map<String, String>> learnStatsGraph1(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph1(stats);
	}
	
	// 수강현황통계(II) - 연수형태별 분석 (접수유형별)
	public List<Map<String, String>> learnStatsGraph2_1(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph2_1(stats);
	}
	
	// 수강현황통계(II) - 연수형태별 분석 (직무연수 학점별)
	public List<Map<String, String>> learnStatsGraph2_2(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph2_2(stats);
	}
	
	// 수강현황통계(II) - 최다접수과정 TOP 5
	public List<Map<String, String>> learnStatsGraph3_1(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph3_1(stats);
	}
	
	// 수강현황통계(II) - 교원선호과정 TOP 5
	public List<Map<String, String>> learnStatsGraph3_2(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph3_2(stats);
	}
	
	// 수강현황통계(II) - 이수현황(인증건/무료연수제외)
	public Map<String, String> learnStatsGraph4_1(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph4_1(stats);
	}
	
	// 수강현황통계(II) - 결제형태(결제완료건)
	public Map<String, String> learnStatsGraph4_2(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph4_2(stats);
	}
	
	// 수강현황통계(II) - 학점별 이수율 분석
	public List<Map<String, String>> learnStatsGraph5(StatsVO stats) throws Exception {
		return statsDao.learnStatsGraph5(stats);
	}
	
	// 연수설문 통계
	public List<Map<String, String>> surveyStatsDetailList(StatsVO stats) throws Exception {
		return statsDao.surveyStatsDetailList(stats);
	}
	
	// 연수만족도통계 > 기수의 과정 만족도 상위Top5
	public List<Map<String, String>> satisByCourseTop5(StatsVO stats) throws Exception {
		return statsDao.satisByCourseTop5(stats);
	}
	
	// 연수만족도통계 > 기수 만족도분포  
	public List<Map<String, String>> satisByCardinal(StatsVO stats) throws Exception {
		return statsDao.satisByCardinal(stats);
	}
	
	// 연수만족도통계 > 설문자 연령분포
	public Map<String, String> satisByAgeGroup(StatsVO stats) throws Exception {
		return statsDao.satisByAgeGroup(stats);
	}
	
	// 연수만족도통계 > 학교구분에 따른 만족도 통계
	public List<Map<String, String>> satisByClassType(StatsVO stats) throws Exception {
		return statsDao.satisByClassType(stats);
	}

	// sms 발송  총 갯수
	public int smsHistoryTotalCnt(StatsVO stats) throws Exception {
		return statsDao.smsHistoryTotalCnt(stats);
	}
	
	// sms 발송 통계
	public List<Map<String, String>> smsHistoryStats(StatsVO stats) throws Exception {
		return statsDao.smsHistoryStats(stats);
	}
}