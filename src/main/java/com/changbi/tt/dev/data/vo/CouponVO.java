package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : BookVO.java
 * @Description : 교재정보
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
public class CouponVO extends CommonVO {
	// 검색조건
    private CouponVO search;
    
    private int id; 			// COUPON ID
    private String couponNum;	// 쿠폰번호
    private String userId; 		// 수강자ID
    private String courseId; 	// 적용과정ID
    private int cond; 			// 쿠폰조건(50000원 이상 신청 시)
    private int coupon; 		// 신청금액 또는 신청 %
    private String couponType; 	// 적용 단위(1:원 할인, 2:% 할인)
    private String useDate; 	// 사용일자
    private String expDate; 	// 만료기간
   
    private String[] userIds;	// 등록수강자ID
    private String[] delCouponIds;	// 삭제쿠폰ID

    // 확장 멤버
    private String name; 		// 수강자명
    private int issue;			// 발급매수
    
	public CouponVO getSearch() {
		return search;
	}
	public void setSearch(CouponVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCouponNum() {
		return couponNum;
	}
	public void setCouponNum(String couponNum) {
		this.couponNum = couponNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public int getCond() {
		return cond;
	}
	public void setCond(int cond) {
		this.cond = cond;
	}
	public int getCoupon() {
		return coupon;
	}
	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}
	public String getCouponType() {
		return couponType;
	}
	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}
	public String getUseDate() {
		return useDate;
	}
	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	public String[] getUserIds() {
		return userIds;
	}
	public void setUserIds(String[] userIds) {
		this.userIds = userIds;
	}
	public String[] getDelCouponIds() {
		return delCouponIds;
	}
	public void setDelCouponIds(String[] delCouponIds) {
		this.delCouponIds = delCouponIds;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getIssue() {
		return issue;
	}
	public void setIssue(int issue) {
		this.issue = issue;
	}
}
