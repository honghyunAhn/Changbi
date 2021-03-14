package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class BookAppVO extends CommonVO {
	// 검색조건
    private BookAppVO search;
    
    private int id; 			// 교재신청ID
    private String courseId; 	// 과정ID
    private String userId; 		// 멤버 ID
    private int learnAppId; 	// 연수신청ID
    private String recName; 	// 수령자
    private String tel; 		// 일반전화
    private String phone; 		// 핸드폰
    private String email; 		// 이메일
    private String delivType; 	// 배송지 타입(H : 집, O : 사무실)
    private String postCode; 	// 우편번호(신:5자리, 구:6자리)
    private String addr1; 		// 주소1: 우편번호에 연결된 주소
    private String addr2; 		// 주소2: 상세주소 (사용자 입력)
    private String remarks; 	// 요청사항
    private String paymentType; // 지불형태(C : 신용카드, A : 계좌이체)
    private int amount; 		// 구매수량
    private int price; 			// 교재가격
    private String paymentYn; 	// 결제유무(Y/N)
    private String paymentDate; // 결제일자
    private String issueNum; 	// 결제발급번호
    private String delivYn; 	// 배송유무
    private String delivDate; 	// 배송일
    private String delivNum; 	// 배송번호
    private String orderIdx;	// 주문번호
    
    private UserVO user;		// 회원 정보
    private CourseVO course;	// 연수과정 정보
    private LearnAppVO learnApp;// 연수과정 정보

	public BookAppVO getSearch() {
		return search;
	}

	public void setSearch(BookAppVO search) {
		this.search = search;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getLearnAppId() {
		return learnAppId;
	}

	public void setLearnAppId(int learnAppId) {
		this.learnAppId = learnAppId;
	}

	public String getRecName() {
		return recName;
	}

	public void setRecName(String recName) {
		this.recName = recName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDelivType() {
		return delivType;
	}

	public void setDelivType(String delivType) {
		this.delivType = delivType;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPaymentYn() {
		return paymentYn;
	}

	public void setPaymentYn(String paymentYn) {
		this.paymentYn = paymentYn;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getIssueNum() {
		return issueNum;
	}

	public void setIssueNum(String issueNum) {
		this.issueNum = issueNum;
	}

	public String getDelivYn() {
		return delivYn;
	}

	public void setDelivYn(String delivYn) {
		this.delivYn = delivYn;
	}

	public String getDelivDate() {
		return delivDate;
	}

	public void setDelivDate(String delivDate) {
		this.delivDate = delivDate;
	}

	public String getDelivNum() {
		return delivNum;
	}

	public void setDelivNum(String delivNum) {
		this.delivNum = delivNum;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public String getOrderIdx() {
		return orderIdx;
	}

	public void setOrderIdx(String orderIdx) {
		this.orderIdx = orderIdx;
	}
	
	public LearnAppVO getLearnApp() {
		return learnApp;
	}

	public void setLearnApp(LearnAppVO learnApp) {
		this.learnApp = learnApp;
	}
}
