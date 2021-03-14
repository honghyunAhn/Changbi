package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : QuizItemVO.java
 * @Description : 시험문제
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class QuizItemVO extends CommonVO {
	// 검색조건
    private QuizItemVO search;
    
    // 문제 은행에서 대량으로 저장하기 위해 문제은행 ID를 LIST로 받음
    private List<QuizBankVO> quizBankList;
    
	private int id;	    						// 시험 문제 ID
	
	private QuizPoolVO quizPool;				// 시험지 풀 ID
	private QuizBankVO quizBank;				// 문제 은행 ID
	
    public QuizItemVO getSearch() {
        return search;
    }

    public void setSearch(QuizItemVO search) {
        this.search = search;
    }

	public List<QuizBankVO> getQuizBankList() {
		return quizBankList;
	}

	public void setQuizBankList(List<QuizBankVO> quizBankList) {
		this.quizBankList = quizBankList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public QuizPoolVO getQuizPool() {
		return quizPool;
	}

	public void setQuizPool(QuizPoolVO quizPool) {
		this.quizPool = quizPool;
	}

	public QuizBankVO getQuizBank() {
		return quizBank;
	}

	public void setQuizBank(QuizBankVO quizBank) {
		this.quizBank = quizBank;
	}
}
