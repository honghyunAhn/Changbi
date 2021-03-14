package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.SubChapVO;

/**
 * @Class Name : LearnAppVO.java
 * @Description : 수강신청관리
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ ------- -------- --------------------------- @ 2017.03.21
 *   김준석 최초 생성

 * @author kjs
 * @since 2017.03.21
 * @version 1.0
 * @see
 *
 */

@SuppressWarnings("serial")
public class LearnAppVO extends CommonVO {
	// 검색조건
	private LearnAppVO search;

	// 검색조건으로 그룹연수 여부 체크하기 위한 변수 추가
	private String groupLearnYn; // 단지 그룹 연수인지만 체크하기 위해서 사용
	private String serviceType; // PC 모바일 구분(P : PC, M : MOBILE) - 수강이력시 필요
	private String attLecType; // 수강이력 타입(A : 전체, P : 개인)

	// 검색 조건중에 ids 리스트 - 이수처리 후 검색 조건
	private String ids;
	private List<LearnAppVO> learnAppList; // ids로 받아온 string을 리스트화 시킴

	// 메일 발송 또는 SMS 발송 관련 기능 파라미터
	private String sendType; // 1이면 이메일 발송, 2이면 SMS 발송
	private int progType; // 진도율 발송 타입(1:10프로미만 ~ 9:90프로미만)
	private String sendTarget; // 발송 대상(1 : 진도율, 2 : 온라인평가 미참여, 3 : 온라인 과제 미참여);

	// 이전 결제 상태를 저장(포인트 처리를 위해 필요)
	private String prevPaymentState; // 이전 결제 상태

	// 테이블 항목
	private int id; // seq id
	private String neisNum; // neis number
	private String desNum; // 연수지명번호
	private String schoolName; // 학교/기관명
	private String tel; // 연락처
	private String phone; // 핸드폰
	private String email; // email
	private String jurisdiction; // 관할교육청
	private String sType; // 학교구분(1:초등, 2:중학교, 3:고등학교, 4:유치원, 5:특수학교, 6:기관)
	private String eType; // 설립구분(1:국립, 2:공립, 3:사립)
	private String postType; // 우편수령지(H:집, O:학교/사무실)
	private String paymentType; // 결제방식(1:무통장입금, 2:계좌이체, 3:가상계좌, 4:신용카드,
								// 5:지난연기결제, 6:무료, 7:단체연수결제)
	private String paymentState; // 결제상태(1:미결제, 2:결제완료, 3:일부결제, 4:환불)
	private String paymentDate; // 결제확인일시
	private String appNum; // 결제승인번호(카드??)
	private int disCoupon; // 쿠폰할인금액
	private int disPoint; // 포인트할인금액
	private int disGroup; // 그룹할인금액
	private int payment; // 결제금액
	private int realPayment; // 실납입금액
	private String realEndDate; // 실제 종료
	private String reqType; // 요청구분(1:연기요청, 2:취소요청, 3:수강연기, 4:수강취소)
	private String reqMemo; // 요청사유
	private String reqDate; // 요청일자(연기 및 취소 요청일자)
	private String orderIdx; // 주문번호
	private int partScore; // 학습참여점수
	private int totalScore; // 최종성적(진도율+온라인평가+온라인과제+출석평가(4학점이상)을 집계
	private String issueDate; // 이수처리일자
	private String issueNum; // 이수번호(이수시 이수번호 발급)
	private char issueYn; // 19-12-31 추가 이수처리 여부

	// 수강관리를 위해 필요한 데이터 추가
	private int totalPerson; // 총 신청자 수(해당 기수와 해당 과정에 지원한 결제완료 된 신청자수)
	private int chapterCnt; // 과정 수강 갯수
	private int progCnt; // 나의 수강 갯수
	private int learnTime; // 나의 학습시간(초)
	private int accCnt; // 나의 접속 횟수
	private int objCnt; // 온라인 평가 응시수
	private int subCnt; // 온라인 과제 응시수
	private int boardCnt; // 글쓰기 참여 수
	private int commentCnt; // 댓글 참여 수
	private int objScore; // 온라인 평가 점수
	private int subScore; // 온라인 과제 점수
	private int attScore; // 출석평가 점수
	
//	private String interview_result; // 면접 결과 'P' 	OR 'F'
//	private String apply_result;	// 	지원 결과 'P'	OR 'F'
	private String acceptance_yn;	// 	등교 여부 'Y' 	OR 'N'
	private String admin_add_yn;	//  관리자 추가 여부 'Y' or 'N' 

	private UserVO user; // 사용자
	private UserVO recommend; // 추천인
	private GroupLearnVO groupLearn; // 단체연수
	private CardinalVO cardinal; // 기수
	private CourseVO course; // 과정
	private CodeVO region; // 지역코드
	private BookAppVO bookApp; // 교재신청
	private PointVO point; // 수강신청 시 적립 포인트
	private PaymentVO pay; // 결제관리 관련 (모집홍보 DB연결)
	private AttendanceVO attend; // 출결관련
	private SubChapVO subchap;
	private EduUserPayVO edu;
	
	public PaymentVO getPay() {
		return pay;
	}

	public void setPay(PaymentVO pay) {
		this.pay = pay;
	}

	public EduUserPayVO getEdu() {
		return edu;
	}
	
	public void setEdu(EduUserPayVO edu) {
		this.edu = edu;
	}
	
	public LearnAppVO getSearch() {
		return search;
	}

	public void setSearch(LearnAppVO search) {
		this.search = search;
	}

	public String getGroupLearnYn() {
		return groupLearnYn;
	}

	public void setGroupLearnYn(String groupLearnYn) {
		this.groupLearnYn = groupLearnYn;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getAttLecType() {
		return attLecType;
	}

	public void setAttLecType(String attLecType) {
		this.attLecType = attLecType;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public List<LearnAppVO> getLearnAppList() {
		return learnAppList;
	}

	public void setLearnAppList(List<LearnAppVO> learnAppList) {
		this.learnAppList = learnAppList;
	}

	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	public int getProgType() {
		return progType;
	}

	public void setProgType(int progType) {
		this.progType = progType;
	}

	public String getSendTarget() {
		return sendTarget;
	}

	public void setSendTarget(String sendTarget) {
		this.sendTarget = sendTarget;
	}

	public String getPrevPaymentState() {
		return prevPaymentState;
	}

	public void setPrevPaymentState(String prevPaymentState) {
		this.prevPaymentState = prevPaymentState;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNeisNum() {
		return neisNum;
	}

	public void setNeisNum(String neisNum) {
		this.neisNum = neisNum;
	}

	public String getDesNum() {
		return desNum;
	}

	public void setDesNum(String desNum) {
		this.desNum = desNum;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
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

	public String getJurisdiction() {
		return jurisdiction;
	}

	public void setJurisdiction(String jurisdiction) {
		this.jurisdiction = jurisdiction;
	}

	public String getsType() {
		return sType;
	}

	public void setsType(String sType) {
		this.sType = sType;
	}

	public String geteType() {
		return eType;
	}

	public void seteType(String eType) {
		this.eType = eType;
	}

	public String getPostType() {
		return postType;
	}

	public void setPostType(String postType) {
		this.postType = postType;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getPaymentState() {
		return paymentState;
	}

	public void setPaymentState(String paymentState) {
		this.paymentState = paymentState;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getAppNum() {
		return appNum;
	}

	public void setAppNum(String appNum) {
		this.appNum = appNum;
	}

	public int getDisCoupon() {
		return disCoupon;
	}

	public void setDisCoupon(int disCoupon) {
		this.disCoupon = disCoupon;
	}

	public int getDisPoint() {
		return disPoint;
	}

	public void setDisPoint(int disPoint) {
		this.disPoint = disPoint;
	}

	public int getDisGroup() {
		return disGroup;
	}

	public void setDisGroup(int disGroup) {
		this.disGroup = disGroup;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public int getRealPayment() {
		return realPayment;
	}

	public void setRealPayment(int realPayment) {
		this.realPayment = realPayment;
	}

	public String getRealEndDate() {
		return realEndDate;
	}

	public void setRealEndDate(String realEndDate) {
		this.realEndDate = realEndDate;
	}

	public String getReqType() {
		return reqType;
	}

	public void setReqType(String reqType) {
		this.reqType = reqType;
	}

	public String getReqMemo() {
		return reqMemo;
	}

	public void setReqMemo(String reqMemo) {
		this.reqMemo = reqMemo;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public int getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}

	public String getIssueNum() {
		return issueNum;
	}

	public void setIssueNum(String issueNum) {
		this.issueNum = issueNum;
	}

	public int getTotalPerson() {
		return totalPerson;
	}

	public void setTotalPerson(int totalPerson) {
		this.totalPerson = totalPerson;
	}

	public int getChapterCnt() {
		return chapterCnt;
	}

	public void setChapterCnt(int chapterCnt) {
		this.chapterCnt = chapterCnt;
	}

	public int getProgCnt() {
		return progCnt;
	}

	public void setProgCnt(int progCnt) {
		this.progCnt = progCnt;
	}

	public int getLearnTime() {
		return learnTime;
	}

	public void setLearnTime(int learnTime) {
		this.learnTime = learnTime;
	}

	public int getAccCnt() {
		return accCnt;
	}

	public void setAccCnt(int accCnt) {
		this.accCnt = accCnt;
	}

	public int getObjCnt() {
		return objCnt;
	}

	public void setObjCnt(int objCnt) {
		this.objCnt = objCnt;
	}

	public int getSubCnt() {
		return subCnt;
	}

	public void setSubCnt(int subCnt) {
		this.subCnt = subCnt;
	}

	public int getBoardCnt() {
		return boardCnt;
	}

	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getObjScore() {
		return objScore;
	}

	public void setObjScore(int objScore) {
		this.objScore = objScore;
	}

	public int getSubScore() {
		return subScore;
	}

	public void setSubScore(int subScore) {
		this.subScore = subScore;
	}

	public int getAttScore() {
		return attScore;
	}

	public void setAttScore(int attScore) {
		this.attScore = attScore;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	public UserVO getRecommend() {
		return recommend;
	}

	public void setRecommend(UserVO recommend) {
		this.recommend = recommend;
	}

	public GroupLearnVO getGroupLearn() {
		return groupLearn;
	}

	public void setGroupLearn(GroupLearnVO groupLearn) {
		this.groupLearn = groupLearn;
	}

	public CardinalVO getCardinal() {
		return cardinal;
	}

	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public CodeVO getRegion() {
		return region;
	}

	public void setRegion(CodeVO region) {
		this.region = region;
	}

	public String getOrderIdx() {
		return orderIdx;
	}

	public void setOrderIdx(String orderIdx) {
		this.orderIdx = orderIdx;
	}

	public int getPartScore() {
		return partScore;
	}

	public void setPartScore(int partScore) {
		this.partScore = partScore;
	}

	public String getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	public BookAppVO getBookApp() {
		return bookApp;
	}

	public void setBookApp(BookAppVO bookApp) {
		this.bookApp = bookApp;
	}

	public PointVO getPoint() {
		return point;
	}

	public void setPoint(PointVO point) {
		this.point = point;
	}

	public char getIssueYn() {
		return issueYn;
	}

	public void setIssueYn(char issueYn) {
		this.issueYn = issueYn;
	}

	public AttendanceVO getAttend() {
		return attend;
	}

	public void setAttend(AttendanceVO attend) {
		this.attend = attend;
	}
	
//	public String getApply_result() {
//		return apply_result;
//	}
//
//	public void setApply_result(String apply_result) {
//		this.apply_result = apply_result;
//	}

	public String getAcceptance_yn() {
		return acceptance_yn;
	}

	public void setAcceptance_yn(String acceptance_yn) {
		this.acceptance_yn = acceptance_yn;
	}

	public String getAdmin_add_yn() {
		return admin_add_yn;
	}

	public void setAdmin_add_yn(String admin_add_yn) {
		this.admin_add_yn = admin_add_yn;
	}
	
//	public String getInterview_result() {
//		return interview_result;
//	}
//
//	public void setInterview_result(String interview_result) {
//		this.interview_result = interview_result;
//	}

	public SubChapVO getSubchap() {
		return subchap;
	}

	public void setSubchap(SubChapVO subchap) {
		this.subchap = subchap;
	}

	@Override
	public String toString() {
		return "LearnAppVO [admin_add=" + admin_add_yn + ", search=" + search + ", groupLearnYn=" + groupLearnYn + ", serviceType=" + serviceType
				+ ", attLecType=" + attLecType + ", ids=" + ids + ", learnAppList=" + learnAppList + ", sendType="
				+ sendType + ", progType=" + progType + ", sendTarget=" + sendTarget + ", prevPaymentState="
				+ prevPaymentState + ", id=" + id + ", neisNum=" + neisNum + ", desNum=" + desNum + ", schoolName="
				+ schoolName + ", tel=" + tel + ", phone=" + phone + ", email=" + email + ", jurisdiction="
				+ jurisdiction + ", sType=" + sType + ", eType=" + eType + ", postType=" + postType + ", paymentType="
				+ paymentType + ", paymentState=" + paymentState + ", paymentDate=" + paymentDate + ", appNum=" + appNum
				+ ", disCoupon=" + disCoupon + ", disPoint=" + disPoint + ", disGroup=" + disGroup + ", payment="
				+ payment + ", realPayment=" + realPayment + ", realEndDate=" + realEndDate + ", reqType=" + reqType
				+ ", reqMemo=" + reqMemo + ", reqDate=" + reqDate + ", orderIdx=" + orderIdx + ", partScore="
				+ partScore + ", totalScore=" + totalScore + ", issueDate=" + issueDate + ", issueNum=" + issueNum
				+ ", issueYn=" + issueYn + ", totalPerson=" + totalPerson + ", chapterCnt=" + chapterCnt + ", progCnt="
				+ progCnt + ", learnTime=" + learnTime + ", accCnt=" + accCnt + ", objCnt=" + objCnt + ", subCnt="
				+ subCnt + ", boardCnt=" + boardCnt + ", commentCnt=" + commentCnt + ", objScore=" + objScore
				+ ", subScore=" + subScore + ", attScore=" + attScore + ", user=" + user + ", recommend=" + recommend
				+ ", groupLearn=" + groupLearn + ", cardinal=" + cardinal + ", course=" + course + ", region=" + region
				+ ", bookApp=" + bookApp + ", point=" + point + ", pay=" + pay + ", attend=" + attend + ", edu=" + edu + ", subchap=" + subchap + "]";
	}

	

}
