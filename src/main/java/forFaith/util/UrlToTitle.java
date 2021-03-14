package forFaith.util;

public enum UrlToTitle {

	LEARNAPP_LIST_DATA("/data/learnApp/learnAppList", "조회(개별신청관리)"),
	
	LEARNMAN_LIST_DATA("/data/learnApp/learnManList", "조회(수강관리)"),
	
	LEARNCANCEL_LIST_DATA("/data/learnApp/learnCancelList","조회(수강취소관리)"),
	
	LEARNAPP_INSERT("/data/learnApp/learnAppInsert", "추가(입과관리)"),
	LEARNAPP_DELETE("/data/learnApp/learnAppSelectDel","삭제(입과관리)"),
	
	TOEFLPAY_LIST_DATA("/data/toefl/toeflPayList", "조회(토플개별신청관리)"),
	
	COMPLETE_LIST("/data/complete/completeListAll", "조회(성적관리)"),
	TESTUSER_INFO("/student/TestManagement/searchtUserTestInfo", "조회(성적관리)"),
	SELECTTABLE_USER("/student/TestManagement/selectableUser", "조회(성적관리)"),
	
	COUNSEL_STUDENT_LIST("/student/Counsel/counselStudentList", "조회(상담관리)"),
	
	TABLE_STUDENT("/student/studentTb/studentList","조회(학적부관리)"),
	
	COMPLETE_PROC_DATA("/data/complete/completeProc", "조회(개별이수관리)"),
	COMPLETE_PROC_LIST("/data/complete/completeProcList", "조회(개별이수관리)"),
	
	MEMBER_LIST_DATA("/data/member/memberList", "조회(회원관리)"),
	
	MEMOUT_LIST_DATA("/data/member/memberOutList", "조회(탈퇴회원관리)"),
	
	PAYLIST_TEST("/data/pay/payListTest", "조회(결제관리)"),
	PAYLIST_DATA("/data/pay/payList", "조회(결제관리)"),
	
	POINTLIST("/data/pay/pointList","조회(포인트관리)"),
	
	APPLY_LIST("/admin/apply/applyList","조회(지원자관리)"),
	
	SMS_HISTORY_LIST("/admin/common/smsList","조회(SMS전송결과)"),
	
	SEND_MESSAGE("/data/learnApp/sendMessage", "SMS/이메일 발송"),
	EMAIL_LIST("/admin/common/emailList", "조회(EMAIL전송결과)");
	
	private String url;
	private String title;
	
	private UrlToTitle() {}
	
	private UrlToTitle(String url, String title) {
		this.url = url;
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public static UrlToTitle getTitle(String uri) {
		UrlToTitle[] arr = UrlToTitle.values();
		
		for(UrlToTitle ut : arr) {
			if(ut.getUrl().equals(uri)) {
				return ut;
			}
		}
		return null;
	}
}
