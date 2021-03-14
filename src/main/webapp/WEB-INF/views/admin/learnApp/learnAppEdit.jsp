<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/learnApp/learnAppReg' />";
	
	var listUrl	= "<c:url value='/admin/pay/payList' />";
	var cardinalListUrl = "<c:url value='/data/course/cardinalList' />";		// 기수리스트 조회
	var courseListUrl = "<c:url value='/data/course/trainProcessList' />";		// 과정리스트 조회
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	// file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	setPaymentArea();
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {    
					if(result.id) { 
						alert("저장되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("저장실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수신청관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = new Object();
		
		data.learnType = "J,S,M";
		
		if($(":hidden[name='groupLearnYn']").val() == "Y") {
			data.learnType = "G";
		}
		
		openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		if(!$("#cardinalId").val()) {
			alert("기수를 먼저 선택해야 합니다.");
		} else {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data.cardinalId = $("#cardinalId").val();
			data.learnTypes = $("#learnType").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
		}
	});
	
	// 실결제금액 변경 이벤트
	// 과정선택 버튼 클릭 시
	$(":text[name='realPayment']").unbind("keyup").bind("keyup", function(e) {
		var event = e || window.event;
		var keycode = event.keyCode || e.which;
		
		if (keycode == 8 || (keycode >= 35 && keycode <= 40) || (keycode >= 46 && keycode <= 57) || (keycode >= 96 && keycode <= 105)) {
			setPoint();
		} else {
			$(this).val($(this).val().slice(0,-1));
		}
	});
	
	// 주교재신청 변경 시
	$("select[name='mainBook']").unbind("change").bind("change", function() {
		setPaymentArea();
	});
	
	// 수강기록조회 버튼 클릭 시
	$("#attLecHistory").unbind("click").bind("click", function() {
		// 수강이력조회 레이어 팝업
		var data = new Object();
		
		data.id = $(":text[name='id']").val();
		
		openLayerPopup("수강이력조회", "/admin/common/popup/attLecHistory", data);
	});
	
	// 수강이력관리
	drawGoogleChart();
});

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);
	
	$(":text[name='learnStartDate']").val(cardinal.learnStartDate);
	$(":text[name='learnEndDate']").val(cardinal.learnEndDate);
	
	// 과정이 없는 상태로 화면을 변경 시킨다.
	setCourse();
}

function setCourse(course) {
	var mainSb = new StringBuilder();
	var subSb = new StringBuilder();
	
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
	
	// 수강과정가격 세팅
	$("#coursePrice").val(course ? course.price : "0");
	$(".course_price_area").html((course && course.price && course.price > 0 ? course.price : 0)+"원");

	// 교재 세팅
	// $("#mainBookId").val(course ? course.mainBookId : "");
	// $("#subBookId").val(course ? course.subBookId : "");
	// $("#mainPrice").val(course ? course.mainPrice : "0");
	
	// 연수구분 세팅
	$(".learn_type").html(course ? ($("#learnType").val() == "J" ? "직무 / "+course.credit+"학점" : ($("#learnType").val() == "G" ? "단체" :($("#learnType").val() == "M" ? "집합" : "자율"))) : "");
	
	// 자율연수인 경우 세팅
	if(course && $("#learnType").val() == "S") {
		$(":text[name='learnStartDate']").val("결제완료일");
		$(":text[name='learnEndDate']").val("결제완료일로부터 "+course.selpPeriod+"일까지");
	}
	
	/*
	$(".main_book").html("교재없음");
	$(".sub_book").html("교구없음");
	
	mainSb.Append("<option value='0'>신청안함</option>");
	subSb.Append("<option value='0'>신청안함</option>");
	
	if(course && course.mainBookId && course.mainBookId != '0') {
		// 교재가 있는 경우
		$(".main_book").html("교재있음("+(course.mainPrice && course.mainPrice > 0 ? course.mainPrice : 0)+"원)");
		
		mainSb.Append("<option value='1'>교재신청</option>");
	}
	
	if(course && course.subBookId && course.subBookId != '0') {
		// 교구가 있는 경우
		$(".sub_book").html("교구있음");
		
		subSb.Append("<option value='1'>교구신청</option>");
	}
	
	$("select[name='mainBook']").html(mainSb.ToString());
	$("select[name='subBook']").html(subSb.ToString());
	*/
	// 결제금액 화면 계산
	setPaymentArea(); 
}

function setPaymentArea() { 
	var course_price = Number($("#pay_crc_amount").val());
	// var mainBook = Number($("select[name='mainBook']").val());
	// var mainPrice = Number($("#mainPrice").val());
	var disCoupon = Number($("#disCoupon").val());
	var disPoint = Number($("#disPoint").val());
	var disGroup = Number($("#disGroup").val());
	
	// (수강료 + 교재비) - (쿠폰할인 + 포인트할인 + 그룹할인)
	// $(":text[name='payment']").val((course_price + (mainBook*mainPrice))-(disCoupon + disPoint + disGroup));
	// 수강료 - (쿠폰할인 + 포인트할인 + 그룹할인)
	$(":text[name='payment']").val(course_price);
	$(".course_price").html(course_price);
	// $(".book_price").html(mainBook*mainPrice);
	//$(".dis_coupon").html(disCoupon);
	$(".dis_point").html(disPoint);
	//$(".dis_group").html(disGroup);
	// $(".principal").html(course_price + (mainBook*mainPrice));
	$(".principal").html(course_price);
	$(".discount").html(disCoupon + disPoint + disGroup);
	
	
	 
	// 실납입금액부분에 가격을 넣는다.(실납입금액은 변경 가능)
	/* $(":text[name='realPayment']").val($(":text[name='payment']").val()); */
	 
	// 적립포인트를 변경 시킨다.
	setPoint();
}

function setPoint() {
	// 수강신청 적립 포인트 부분이 Y인 경우만 가능
	var lecturePoint = 0;
	
	if($("#saveLectureUse").val() == "Y") {
		lecturePoint = Number($("#saveLecturePoint").val());
	 
		// 퍼센트로 적용 시
		if($("#saveLectureType").val() == "2") {
			var realPayment = 0;
			
			realPayment = $(":text[name='realPayment']").val() ? Number($(":text[name='realPayment']").val()) : 0;
			
			lecturePoint = realPayment * lecturePoint / 100; 
		}
		
		$(":hidden[name='point.give']").val(lecturePoint);
	 
		$(".give_point").html(lecturePoint+"포인트");
	}
}

function drawGoogleChart() {
	google.charts.load('current', {packages: ['corechart', 'bar']});
	google.charts.setOnLoadCallback(drawBasic);
	
	var totalPerson = Number($("#totalPerson").val());		// 수강인원
	var totalChapterCount = Number('<c:out value="${fn:length(attLecList)}" default="0" />');	// 총 챕터수
	var avgChapterCount = 0;	// 평균 진도
	var myChapterCount = 0;		// 나의 진도
	var avgLearnTime = 0;		// 평균 수강 시간
	var myLearnTime = 0;		// 나의 수강 시간
	var startDate = "";			// 최초 수강일
	var finalDate = "";			// 최종 수강일
	var checkDate = "";			// 체크 수강일

	var sb = new StringBuilder();
	
	// 평균진도 평균수강시간 구하기
	<c:forEach items="${attLecTotalList}" var="chapter">
		<c:forEach items="${chapter.attLecList}" var="attLec">
			// 평균 진도
			<c:if test="${attLec.progYn eq 'Y'}">
				++avgChapterCount;
			</c:if>
			
			// 평균 수강 시간
			avgLearnTime += Number('<c:out value="${attLec.learnTime}" default="0" />');
		</c:forEach>
		
		// 빨간줄 안나오게 하는 용도로 사용--
		var test = "";
		
	</c:forEach>
	
	// 나의진도 및 나의수강시간 구하기
	<c:forEach items="${attLecList}" var="chapter">
		var myProc = "×";
		var stringBuilder = "<li><span class='list-label'><c:out value="${chapter.orderNum}" default="0" />강</span><strong class='list-value'>";
	
		<c:forEach items="${chapter.attLecList}" var="attLec">
			// 나의 진도
			<c:if test="${attLec.progYn eq 'Y'}">
				++myChapterCount;
				myProc = "●";
			</c:if>
			
			// 나의 수강 시간
			myLearnTime += Number('<c:out value="${attLec.learnTime}" default="0" />');
			
			// 최초 최종 접속일 구하기
			<c:forEach items="${attLec.historyList}" var="history" varStatus="status">
				checkDate = "<c:out value="${history.startDate}" default="" />";
				
				finalDate = !finalDate || finalDate < checkDate ? checkDate : finalDate;
				startDate = !startDate || startDate > checkDate ? checkDate : startDate; 
			</c:forEach>
		</c:forEach>
		
		stringBuilder += myProc;
		stringBuilder += "</strong></li>";
		
		sb.Append(stringBuilder);
	</c:forEach>

	function drawBasic() {
		// 나의 수강시간을 분단위로 변경(반올림)
		myLearnTime = Math.round(myLearnTime / 60);
		
		// 수강자 평균 수강시간을 구한다(반올림)
		avgLearnTime = Math.round(avgLearnTime / totalPerson / 60);
		
		var data1 = google.visualization.arrayToDataTable([
			['구분', '진도율(강)', { role: 'style'}],
			['나의 진도', myChapterCount, '#0068b7'],
			['전체 진도', totalChapterCount, '#c39d5f'],
		]);
		
		var view1 = new google.visualization.DataView(data1);
		view1.setColumns([0, 1,
										{ calc: "stringify",
											sourceColumn: 1,
											type: "string",
											role: "annotation" },
										2]);
		var options1 = {
			title: { position: "none" },
			fontSize: 14,
			chartArea:{left:'15%',top:0,width:'80%',height:'75%'},
			bar: { groupWidth: "70%"},
			legend: { position: "none" },
			height: 110,
			hAxis: {
				title: { position: "none" },
				gridlines: { count: (totalChapterCount > 0 ? (totalChapterCount/5)+1 : 7)}, // (총 강의수/5) + 1
				format: 'decimal',
				viewWindow: {
					min: 0,
					max: totalChapterCount > 0 ? totalChapterCount : 30  // 총 강의수
				}
			}
		};
		var data2 = google.visualization.arrayToDataTable([
			['구분', '학습 시간(분)', { role: 'style'}],
			['나의 수강', myLearnTime, '#0068b7'],
			['수강자 평균', avgLearnTime, '#c39d5f']
		]);
		var view2 = new google.visualization.DataView(data2);
		view2.setColumns([0, 1,
										{ calc: "stringify",
											sourceColumn: 1,
											type: "string",
											role: "annotation" },
										2]);
		var options2 = {
			title: { position: "none" },
			fontSize: 14,
			chartArea:{left:'15%',top:0,width:'80%',height:'75%'},
			bar: { groupWidth: "70%"},
			legend: { position: "none" },
			height: 110,
			hAxis: {
				title: { position: "none" },
				gridlines: { count: 6}, 
				format: 'decimal',
				viewWindow: {
					min: 0
				}
			}
		};
		var chart1 = new google.visualization.BarChart(document.getElementById('chart-CourseProgress'));
		chart1.draw( view1, options1);
		var chart2 = new google.visualization.BarChart(document.getElementById('chart-LearningTime'));
		chart2.draw(view2, options2);
		
		// 수강이력관리
		$(".ox-list").html(sb.ToString());
		$(".learn_time").html(myLearnTime+"분 (전체 평균 "+avgLearnTime+"분)");
		$(".chasi").html((totalChapterCount > 0 ? (myLearnTime / totalChapterCount) : 0)+"분");
		$(".prog_ratio").html(	( totalChapterCount > 0 
								? (myChapterCount+"/"+totalChapterCount+", "+(myChapterCount / totalChapterCount * 100)+"%")
								+ " (전체평균 : "+(avgChapterCount / totalPerson / totalChapterCount * 100)+"%)"
								: "0% (전체평균 : 0%)"));
		$(".fisrt_date").html(startDate);
		$(".final_date").html(finalDate);
	}
}

</script>
		
<div class="content_wraper">
	<h3>연수신청관리상세</h3>   
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='groupLearnYn' value='<c:out value="${search.groupLearnYn}" default="" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='region.code' value='<c:out value="${search.region.code}" default="" />' />
			<input type='hidden' name='paymentState' value='<c:out value="${search.paymentState}" default="" />' />
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" name="cardinal.name" value='<c:out value="${search.cardinal.name}" default="" />' />
			<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="" />' />
			
			<input type="hidden" name="searchStartDate"  value='<c:out value="${search.searchStartDate}" />' />
			<input type="hidden" name="searchEndDate" value='<c:out value="${search.searchEndDate}" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- 사용자 정보를 HIDDEN으로 가지고 간다. -->
			<input type="hidden" name="user.id" value='<c:out value="${learnApp.user.id}" default="" />' />
			
			<!-- 그룹 ID세팅 -->
			<input type="hidden" name="groupLearn.id" value='<c:out value="${learnApp.groupLearn.id}" default="0" />' />
			
			<!-- 기수와 과정 ID 세팅 -->
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${learnApp.cardinal.id}" default="" />' />
			<input type="hidden" id="learnType" value='<c:out value="${learnApp.cardinal.learnType}" default="" />' />
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${learnApp.course.id}" default="" />' />
        	
        	<!-- 과정 가격 세팅 -->
        	<input type="hidden" id="coursePrice" value='<c:out value="${payInfo.pay_crc_amount}" default="0" />' />
        	
        	<!-- 해당 기수, 과정을 신청한 인원 인원 중 결제 완료 및 연기, 취소가 없는 인원 -->
        	<input type="hidden" id="totalPerson" value='<c:out value="${learnApp.totalPerson}" default="0" />' />
        	
        	<!-- 교재정보 및 가격 세팅 -->
        	<%--
        	<input type="hidden" id="mainBookId" value='<c:out value="${learnApp.course.mainBook.id}" default="" />' />
        	<input type="hidden" id="subBookId" value='<c:out value="${learnApp.course.subBook.id}" default="" />' />
        	<input type="hidden" id="mainPrice" value='<c:out value="${learnApp.course.mainPrice}" default="0" />' />
        	 --%>
        	
        	<!-- 교재신청 데이터 세팅(당분간은 없이 사용 로직을 구체화 시키고 진행할 예정) -->
        	<%-- 
        	<input type="hidden" name="bookApp.courseId" value='<c:out value="${learnApp.course.id}" default="" />' />
        	<input type="hidden" name='bookApp.userId' value='<c:out value="${learnApp.user.id}" default="" />' />
        	<input type="hidden" name='bookApp.learnAppId' value='<c:out value="${learnApp.id}" default="0" />' />
        	<input type="hidden" name='bookApp.recName' value='<c:out value="${learnApp.user.name}" default="" />' />
        	<input type="hidden" name='bookApp.tel' value='<c:out value="${learnApp.tel}" default="" />' />
        	<input type="hidden" name='bookApp.phone' value='<c:out value="${learnApp.phone}" default="" />' />
        	<input type="hidden" name='bookApp.email' value='<c:out value="${learnApp.email}" default="" />' />
        	<input type="hidden" name='bookApp.delivType' value='<c:out value="${learnApp.postType}" default="O" />' />
        	<input type="hidden" name='bookApp.postCode' value='<c:choose><c:when test="${learnApp.postType eq 'H'}"><c:out value="${learnApp.user.postCode}" default="" /></c:when><c:otherwise><c:out value="${learnApp.user.schoolPostCode}" default="" /></c:otherwise></c:choose>' />
        	<input type="hidden" name='bookApp.addr1' value='<c:choose><c:when test="${learnApp.postType eq 'H'}"><c:out value="${learnApp.user.addr1}" default="" /></c:when><c:otherwise><c:out value="${learnApp.user.schoolAddr1}" default="" /></c:otherwise></c:choose>' />
        	<input type="hidden" name='bookApp.addr2' value='<c:choose><c:when test="${learnApp.postType eq 'H'}"><c:out value="${learnApp.user.addr2}" default="" /></c:when><c:otherwise><c:out value="${learnApp.user.schoolAddr2}" default="" /></c:otherwise></c:choose>' />
    		<input type="hidden" name='bookApp.remarks' value='' />
    		<input type="hidden" name='bookApp.paymentType' value='<c:choose><c:when test="${learnApp.paymentType eq '4'}">C</c:when><c:otherwise>A</c:otherwise></c:choose>' />
			<input type="hidden" name='bookApp.amount' value='<c:out value="${learnApp.mainBook}" default="0" />' />
			<input type="hidden" name='bookApp.price' value='<c:out value="${learnApp.course.mainPrice}" default="0" />' />
			<input type="hidden" name='bookApp.paymentYn' value='<c:out value="${learnApp.course.mainPrice}" default="0" />' />
		    private String paymentYn; 	// 결제유무(Y/N)
		    private String paymentDate; // 결제일자
		    private String issueNum; 	// 결제발급번호
		    private String delivYn; 	// 배송유무
		    private String delivDate; 	// 배송일
		    private String delivNum; 	// 배송번호 
		    --%>
        	
        	<!-- 할인정보 세팅 -->
        	<input type="hidden" id="disCoupon" value='<c:out value="${learnApp.disCoupon}" default="0" />' />
        	<input type="hidden" id="disPoint" value='<c:out value="${payInfo.dis_point}" default="0" />' />
        	<input type="hidden" id="disGroup" value='<c:out value="${learnApp.disGroup}" default="0" />' />
        	
        	<!-- 수강신청 적립 포인트 정책에 따른 포인트 산정 공식  -->
        	<c:if test="${policyPoint.saveLectureUse eq 'Y'}">
				<c:choose>
					<c:when test="${policyPoint.saveLectureType eq '1'}">
						<c:set var="lecturePoint" value="${policyPoint.saveLecturePoint}" />
					</c:when>
					<c:otherwise>
						<fmt:parseNumber var="lecturePoint" type="number" value="${learnApp.realPayment * policyPoint.saveLecturePoint / 100}" />
					</c:otherwise>
				</c:choose>
			</c:if>
			<!-- 수강신청 적립 포인트 정책 -->
			<input type="hidden" id="saveLectureUse" value='<c:out value="${policyPoint.saveLectureUse}" default="N" />' />
			<input type="hidden" id="saveLectureType" value='<c:out value="${policyPoint.saveLectureType}" default="1" />' />
			<input type="hidden" id="saveLecturePoint" value='<c:out value="${policyPoint.saveLecturePoint}" default="0" />' />
			
			<!-- 적립포인트  정보 -->
        	<input type="hidden" name='point.userId' value='<c:out value="${learnApp.user.id}" default="" />' />
        	<input type="hidden" name='point.learnAppId' value='<c:out value="${learnApp.id}" default="0" />' />
        	<input type="hidden" name='point.name' value='<c:out value="${learnApp.user.name}" default="" />' />
        	<input type="hidden" name='point.give' value='<c:out value="${lecturePoint+((lecturePoint%1>0.5)?(1-(lecturePoint%1))%1:-(lecturePoint%1))}" default="0" />' />
        	<input type="hidden" name='point.withdraw' value='0' />
        	<input type="hidden" name='point.note' value='[관리자]수강신청 결제완료 처리에 따른 포인트적립' />
        	
        	<!-- 이전 결제상태를 저장해서 포인트 적립 및 사용으로 처리 -->
        	<!-- 결제대기 or 환불 -> 결제완료 시 포인트 적립, 결제완료 ->결제대기 or 환불 시 포인트 사용 -->
        	<input type="hidden" name='prevPaymentState' value='<c:out value="${learnApp.paymentState}" default="" />' />
			 
			<!-- view start -->
			<h4>기본신청정보</h4>    
			<dl> 
				<dt>번호</dt>
				<dd class="half"><input type='text' name='id' value='<c:out value="${learnApp.id}" default="0" />' style="border:none;" readonly="readonly" /></dd>
				<dt>신청일자</dt>
				<dd class="half">
					<fmt:parseDate var="dateString" value="${learnApp.regDate}" pattern="yyyyMMddHHmmss" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" />
				</dd>
				<dt>회원구분</dt>
				<dd class="half">
					<c:choose>
						<c:when test="${learnApp.user.grade eq 1}">교원회원</c:when>
						<c:otherwise>일반회원</c:otherwise>
					</c:choose>
				</dd>
				<dt>아이디</dt>
				<dd class="half">
					<c:out value="${learnApp.user.id}" default="" />
				</dd>
				<dt>성명</dt>
				<dd class="half">
					<c:out value="${learnApp.user.name}" default="" />
				</dd>
				<!--  
				<dt>학교(기관명)</dt>
				<dd class="half">
					<input type='text' name='schoolName' value='<c:out value="${learnApp.schoolName}" default="" />' />
				</dd>
				<dt>연수구분</dt>
				<dd class='learn_type'>
					<c:choose>
						<c:when test="${learnApp.cardinal != null and learnApp.cardinal.learnType eq 'J'}">직무 / <c:out value="${learnApp.course.credit}" default="" />학점</c:when>
						<c:when test="${learnApp.cardinal != null and learnApp.cardinal.learnType eq 'G'}">단체</c:when>
						<c:when test="${learnApp.cardinal != null and learnApp.cardinal.learnType eq 'M'}">집합</c:when>
						<c:otherwise>자율</c:otherwise>
					</c:choose>
				</dd>
				<dt>직위</dt>
				<dd class="half">
					<c:out value="${learnApp.user.position}" default="" />/<c:out value="${learnApp.user.positionEtc}" default="" />
				</dd>
				-->
				<dt>일반전화</dt>
				<dd class="half">
					<input type='text' name='tel' value='<c:out value="${learnApp.tel}" default="" />' />
				</dd>
				<dt>휴대 전화</dt>
				<dd class="half">
					<input type='text' name='phone' value='<c:out value="${learnApp.phone}" default="" />' />
				</dd>
				<dt>전자메일</dt>
				<dd class="half">
					<input type='text' name='email' value='<c:out value="${learnApp.email}" default="" />' />
				</dd>
				<%--  
				<dt>소속교육청</dt>
				<dd class="half">
					<!-- 지역 선택 -->
					<select name="region.code">
						<c:forEach items="${region}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq learnApp.region.code}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
					/
					<input type='text' name='jurisdiction' value='<c:out value="${learnApp.jurisdiction}" default="" />' />
				</dd>
				<dt>학교(업무)구분</dt>
				<dd class="half">
					<!-- 학교구분 -->
					<select name="sType">
						<option value='1' <c:if test="${'1' eq learnApp.sType}">selected</c:if>>초등</option>
						<option value='2' <c:if test="${'2' eq learnApp.sType}">selected</c:if>>중학교</option>
						<option value='3' <c:if test="${'3' eq learnApp.sType}">selected</c:if>>고등학교</option>
						<option value='4' <c:if test="${'4' eq learnApp.sType}">selected</c:if>>유치원</option>
						<option value='5' <c:if test="${'5' eq learnApp.sType}">selected</c:if>>특수학교</option>
						<option value='6' <c:if test="${'6' eq learnApp.sType}">selected</c:if>>기관</option>
					</select>
					/
					<!-- 설립구분 -->
					<select name="eType">
						<option value='1' <c:if test="${'1' eq learnApp.eType}">selected</c:if>>국립</option>
						<option value='2' <c:if test="${'2' eq learnApp.eType}">selected</c:if>>공립</option>
						<option value='3' <c:if test="${'3' eq learnApp.eType}">selected</c:if>>사립</option>
					</select>
				</dd>
				<dt>임용년도</dt>
				<dd class="half">
					<c:out value="${learnApp.user.appYear}" default="" />년도
				</dd>
				<dt>담당과목</dt>
				<dd class="half">
					<c:out value="${learnApp.user.subject}" default="" />
				</dd>
				
				<dt>우편수령지</dt>
				<dd class="half">
					<!-- 학교구분 -->
					<select name="postType">
						<option value='H' <c:if test="${'H' eq learnApp.postType}">selected</c:if>>자택</option>
						<option value='O' <c:if test="${'O' eq learnApp.postType}">selected</c:if>>학교/사무실</option>
					</select>
				</dd>
				--%>
				<dt>자택주소</dt>
				<dd >
					[<c:out value="${learnApp.user.postCode}" default="" />]<c:out value="${learnApp.user.addr1}" default="" /><c:out value="${learnApp.user.addr2}" default="" />
				</dd>
				<dt>이수번호</dt>
				<dd ><input type='text' name='issueNum' value='<c:out value="${learnApp.issueNum}" default="" /> 'style="border:none;" readonly="readonly" /></dd>
				<!-- 
				<dt>학교주소</dt>
				<dd class="half">
					[<c:out value="${learnApp.user.schoolPostCode}" default="" />]<c:out value="${learnApp.user.schoolAddr1}" default="" /><c:out value="${learnApp.user.schoolAddr2}" default="" />
					(tel:<c:out value="${learnApp.user.schoolTel}" default="" />/fax:<c:out value="${learnApp.user.schoolFax}" default="" />)
				</dd>
				 -->
				<dt>기수</dt>
				<dd class="half">
					<!-- 기수 선택 -->
					<input type='text' id='cardinalName' value='<c:out value="${learnApp.cardinal.name}" default="기수선택" />' readonly="readonly" />
				</dd>
				<dt>연수 과정명</dt>
				<dd class="half">
					<!-- 과정 선택 -->
					<input type='text' id='courseName' value='<c:out value="${learnApp.course.name}" default="과정선택" />' readonly="readonly"  />
				</dd>
				<dt>연수과정 수강금액</dt>
				<dd class='course_price_area'>
					<c:out value="${payInfo.pay_crc_amount}" default="0" />원
				</dd>
				<dt>연수 기간</dt>
				<dd>
					<input type='text'  name='learnStartDate' value='<c:out value="${learnApp.cardinal.learnStartDate}" />'  readonly="readonly" />~
					<input type='text' name='learnEndDate' value='<c:out value="${learnApp.cardinal.learnEndDate}" />'   readonly="readonly" />
				</dd>
				<dt>실수강 종료 기간</dt>
				<dd class='half'>
					<div class='input-group date datetimepicker w70' id='realEndDate'>
	                    <input type='text' name='realEndDate' class='form-control' value='<c:out value="${learnApp.realEndDate}" default="${learnApp.cardinal.learnEndDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<%--
				<dt>주교재여부</dt>
				<dd class="main_book half">
					<c:choose>
						<c:when test="${empty learnApp.course.mainBook.id or learnApp.course.mainBook.id eq '0'}">
							교재없음
						</c:when>
						<c:otherwise>
							교재있음(<c:out value="${learnApp.course.mainPrice}" default="0" />원)
						</c:otherwise>
					</c:choose>
				</dd>
				<dt>주교재신청</dt>
				<dd class="half">
					<select name='mainBook'>
						<option value='0'>신청안함</option>
						<c:if test="${!empty learnApp.course.mainBook.id and learnApp.course.mainBook.id ne '0'}">
						<option value='1' <c:if test="${'1' eq learnApp.mainBook}">selected</c:if>>교재신청</option>
						</c:if>
					</select>
				</dd>
				<dt>교구여부</dt>
				<dd class="sub_book half">
					<c:choose>
						<c:when test="${empty learnApp.course.subBook.id or learnApp.course.subBook.id eq '0'}">
							교구없음
						</c:when>
						<c:otherwise>
							교구있음
						</c:otherwise>
					</c:choose>
				</dd>
				<dt>교구신청</dt>
				<dd class="half">
					<select name='subBook'>
						<option value='0'>신청안함</option>
						<c:if test="${!empty learnApp.course.subBook.id and learnApp.course.subBook.id ne '0'}">
						<option value='1' <c:if test="${'1' eq learnApp.subBook}">selected</c:if>>교구신청</option>
						</c:if>
					</select>
				</dd>
				
				<dt>NEIS 개인 번호</dt>
				<dd>(관리자모드에서는 NEIS개인번호를 변경할 수 없습니다. 개인회원별 개인정보수정페이지에서 수정 후 나의강의실에 입장하시면 자동변경됩니다.)</dd>
				<dt>연수 지명 번호</dt>
				<dd class='half'><input type='text' name='desNum' value='<c:out value="${learnApp.desNum}" default="" />' /></dd>
				--%>
				<dt>추천인ID</dt>
				<dd class='half'><input type='text' name='recommend.id' value='<c:out value="${learnApp.recommend.id}" default="" />' /></dd>
			</dl>
			
			<c:if test="${payInfo ne null}">
				<h4>결제 정보</h4>
				<dl>
					<dt>결제 확인일시</dt>
					<dd>
						<fmt:parseDate var="dateString" value="${payInfo.pay_ins_dt}" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
					</dd>
					<dt>결제 수단</dt>
					<dd class="half">
					<input type="hidden" id="annyong" value="${payInfo.pay_user_method}" />
						<c:choose>
							<c:when test="${'Card' eq payInfo.pay_user_method}">
								<input type="text" value="신용카드" disabled/>
							</c:when>
							<c:when test="${'VBank' eq payInfo.pay_user_method}">
								<input type="text" value="가상계좌" disabled/>
							</c:when>
						</c:choose>
						
						<%-- <select name="paymentType">
							<option value="1" <c:if test="${'1' eq learnApp.paymentType}">selected</c:if>>무통장입금</option>
							<option value="2" <c:if test="${'2' eq learnApp.paymentType}">selected</c:if>>계좌이체</option>
							<option value="4" <c:if test="${'Card' eq payInfo.pay_user_method}">selected</c:if>>신용카드</option>
							<option value="3" <c:if test="${'VBank' eq payInfo.pay_user_method}">selected</c:if>>가상계좌</option>
							<option value="5" <c:if test="${'5' eq learnApp.paymentType}">selected</c:if>>지난연기결제</option>
							<option value="6" <c:if test="${'6' eq learnApp.paymentType}">selected</c:if>>무료</option>
							<option value="7" <c:if test="${'7' eq learnApp.paymentType}">selected</c:if>>단체연수결제</option>
						</select> --%>
					</dd>
					<dt>결제 상태</dt>
					<dd class="half">
						<select name="edu.pay_user_status">	
							<option value="F0000" <c:if test="${'F0000' eq payInfo.pay_user_status}">selected</c:if>>결제대기</option>
							<option value="F0001" <c:if test="${'F0001' eq payInfo.pay_user_status}">selected</c:if>>결제완료</option>
							<%-- <option value="3" <c:if test="${'3' eq payInfo.pay_user_status}">selected</c:if>>일부결제</option> --%>
							<option value="F0002" <c:if test="${'F0002' eq payInfo.pay_user_status}">selected</c:if>>환불요청중</option>
							<option value="F0004" <c:if test="${'F0003' eq payInfo.pay_user_status}">selected</c:if>>환불완료</option>
						</select>
					</dd>
					<%-- <dt>상점 주문번호</dt>
					<dd >
						<input type='text' class="w50" name='pay_user_tid' value='<c:out value="${learnApp.pay!=null? learnApp.pay.pay_user_tid:'0'}" default="" />' style="border:none;" readonly="readonly" />
					</dd>
					<dt>거래 번호</dt>
					<dd>
						<input type='text' class="w50" name='pay_user_moid' value='<c:out value="${learnApp.pay!=null? learnApp.pay.pay_user_moid :'0'}" default="" />'  style="border:none;" readonly="readonly" />
					</dd> --%>
					<dt>결제 금액</dt>
					<dd>
						<input type='hidden' name='edu.pay_user_seq' value='${payInfo.pay_user_seq}'/>
						<input type='hidden' id="pay_crc_amount" value='${payInfo.pay_crc_amount}'>
						결제금액 : <input type='text' name='payment' value='<c:out value="${payInfo.pay_crc_amount}" default="0" />'   readonly="readonly" />원
						( 수강료 : <span class='course_price'><c:out value="${payInfo.pay_crc_amount}" default="0" /></span>원 )
						- 
						( 	포인트할인 : <span class='dis_point'><c:out value="${ payInfo.dis_point }" default="0" /></span>원 )<br />
						원금합계 : <span class='principal'><c:out value="${payInfo.pay_crc_amount}" default="0" /></span>원<br/>
						할인합계 : <span class='discount'><c:out value="${payInfo.dis_point}" default="0" /></span>원
					</dd>
					<dt>실납입금액</dt>
					<dd class="half">
						 <input type='text' name='edu.real_pay_amount' value='<c:out value="${payInfo.real_pay_amount }" default="0" />' /><!-- 확인 --> 
						 
					</dd>
					<dt>적립포인트</dt>
					<dd class="half">
						<span class='give_point'>
							<c:out value="${payInfo.dis_point }" default="0" />포인트
						</span>
					</dd>
				</dl>
			</c:if>
			<c:if test="${payInfo eq null}">
				<dt><span>결제정보가 없습니다.</span></dt>
			</c:if>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<c:if test="${refundInfo ne null}">
			<div>
				<h4>환불 정보</h4>
				<dl>
					<dt>환불계좌 은행</dt>
					<dd>${refundInfo.pay_refund_bank}</dd>
					<dt>환불계좌번호</dt>
					<dd class="half">${refundInfo.pay_refund_accnum}</dd>
					<dt>환불금액</dt>
					<dd class="half">${refundInfo.real_pay_amount}</dd>
				</dl>
			</div>
		</c:if>
		<c:if test="${refundInfo eq null}">
			<dt>환불 정보가 없습니다.</dt>
		</c:if>
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if  test="${loginUser != null && loginUser.grade != 1}">
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">수정</a>
			</c:if>
		</div>
		
		<div class="columns x2">
			<h4>수강이력관리</h4>
			
			<div class="column w-fix">
				<div class="section box">
					<div class="section-header">
						<h5>학습 진도</h5>
						<p class="side-legend">(차시/%)</p>
					</div>
					<div id="chart-CourseProgress" class="section-body"></div>
				</div><!--//.section-->
				<div class="section box">
					<div class="section-header">
						<h5>학습 시간</h5>
						<p class="side-legend">(분)</p>
					</div>
					<div id="chart-LearningTime" class="section-body"></div>
				</div><!--//.section-->
			</div><!--//.column-body-->
			<div class="column">
				<ul class="ox-list"></ul>
				
				<p><a id="attLecHistory" class="btn primary" href="javascript:void(0);">수강기록조회</a></p>
				
				<dl>
					<dt>총 학습시간</dt>
					<dd class="learn_time half">2분 (전체 평균 2분)</dd>
					<dt>차시당 평균</dt>
					<dd class="chasi half">0분</dd>
					<dt>학습 진도율</dt>
					<dd class='prog_ratio'>1/60강, 1.7% (전체평균: 1.00%)</dd>
					<dt>최초 접속일</dt>
					<dd class="fisrt_date half">2018-03-21 21:26:08</dd>
					<dt>최종 접속일</dt>
					<dd class="final_date half">2018-03-27 18:49:01</dd>
					<dt>수강 접속수</dt>
					<dd class="learn_joint half"><c:out value="${learnApp.accCnt}" default="0" />회</dd>
					<dt>게시 활동수</dt><dd class="board half"><c:out value="${learnApp.boardCnt+learnApp.commentCnt}" default="0" />회</dd>
				</dl><!--section-->
			</div>
		</div><!--//.group-->
	</div>
</div>