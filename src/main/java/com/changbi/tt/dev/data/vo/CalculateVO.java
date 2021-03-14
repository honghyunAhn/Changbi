package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.MemberVO;

/**
 * 정산정보
 * @author Maestro
 *
 */
@SuppressWarnings("serial")
public class CalculateVO extends CommonVO {
	
	private String calType;		// 유형 (업체, 강사, 튜터)
	
	private String id; 			// 기준ID (업체ID, 강사ID, 튜터ID)
	private String name; 		// 기준명 (업체명, 강사명, 튜터명)
	private int cntCal; 		// 정산건수
	private int sumPayment; 	// 원금액계
	private int sumDisPayment; 	// 할인금액
	private int sumDisPoint; 	// 사용포인트
	private int sumRealPayment; // 실결제금액
	private int sumCommPayment; // 금융수수료
	private int sumCalPayment; 	// 정산금액
	private int sumCompanyPayment;	// 본사금액
	
	private CardinalVO cardinal; // 기수정보
	private MemberVO company; // 업체정보
	private MemberVO tutor; // 튜터정보
	private MemberVO teacher; // 강사정보
	
	public String getCalType() {
		return calType;
	}
	public void setCalType(String calType) {
		this.calType = calType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCntCal() {
		return cntCal;
	}
	public void setCntCal(int cntCal) {
		this.cntCal = cntCal;
	}
	public int getSumPayment() {
		return sumPayment;
	}
	public void setSumPayment(int sumPayment) {
		this.sumPayment = sumPayment;
	}
	public int getSumDisPayment() {
		return sumDisPayment;
	}
	public void setSumDisPayment(int sumDisPayment) {
		this.sumDisPayment = sumDisPayment;
	}
	public int getSumCompanyPayment() {
		return sumCompanyPayment;
	}
	public void setSumCompanyPayment(int sumCompanyPayment) {
		this.sumCompanyPayment = sumCompanyPayment;
	}
	public int getSumRealPayment() {
		return sumRealPayment;
	}
	public void setSumRealPayment(int sumRealPayment) {
		this.sumRealPayment = sumRealPayment;
	}
	public int getSumCommPayment() {
		return sumCommPayment;
	}
	public void setSumCommPayment(int sumCommPayment) {
		this.sumCommPayment = sumCommPayment;
	}
	public int getSumCalPayment() {
		return sumCalPayment;
	}
	public void setSumCalPayment(int sumCalPayment) {
		this.sumCalPayment = sumCalPayment;
	}
	public int getSumDisPoint() {
		return sumDisPoint;
	}
	public void setSumDisPoint(int sumDisPoint) {
		this.sumDisPoint = sumDisPoint;
	}
	public CardinalVO getCardinal() {
		return cardinal;
	}
	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}
	public MemberVO getCompany() {
		return company;
	}
	public void setCompany(MemberVO company) {
		this.company = company;
	}
	public MemberVO getTutor() {
		return tutor;
	}
	public void setTutor(MemberVO tutor) {
		this.tutor = tutor;
	}
	public MemberVO getTeacher() {
		return teacher;
	}
	public void setTeacher(MemberVO teacher) {
		this.teacher = teacher;
	}
}
