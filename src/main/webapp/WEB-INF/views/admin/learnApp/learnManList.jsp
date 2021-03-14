<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/learnApp/learnManList' />";
	var learnAppEditUrl	= "<c:url value='/admin/learnApp/learnAppEdit' />";
	var memberEditUrl = "<c:url value='/admin/member/memberEdit' />";
	var cardinalListUrl = "<c:url value='/data/course/cardinalList' />";		// 기수리스트 조회
	var courseListUrl = "<c:url value='/data/course/trainProcessList' />";		// 과정리스트 조회
	var sendMsgUrl = "<c:url value='/data/learnApp/sendMessage' />";			// 수강 관리 이메일 또는 SMS 발송 기능
	var excelUrl = "";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList 	= result.list; // result.list는 LearnAppVO 
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					var today = new Date();
					var startDate = null;
					var endDate = null;
					var learnProg = 0;		// 연수진행률
					var progRate = 0;		// 진도률
					
					// 오늘 날짜를 00:00:00 시간으로 세팅함
					today = new Date(today.getFullYear(), today.getMonth(), today.getDate());

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var cardinalName	= (dataInfo.cardinal && dataInfo.cardinal.name) ? dataInfo.cardinal.name : "";	// 기수명
						var courseName		= (dataInfo.course && dataInfo.course.name) ? dataInfo.course.name : "";	// 과정명
						var startDateArr	= dataInfo.cardinal.learnStartDate.split("-");		// 연수시작일
						var endDateArr		= dataInfo.cardinal.learnEndDate.split("-");		// 연수종료일
						var memo = "";			// 결시내역
						
						cardinalName = cardinalName.length > 10 ? cardinalName.substr(0, 10)+"..." : cardinalName;
						courseName = courseName.length > 10 ? courseName.substr(0, 10)+"..." : courseName;
						
						startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2]);
						endDate = new Date(endDateArr[0], endDateArr[1]-1, endDateArr[2]);
						
						//연수진행률
						//오늘 일자가 연수시작일보다 작으면 0% 오늘 일자가 마지막 일자보다 크면 100% 그렇지 않으면 (오늘일자 - 연수시작일) / (마지막일자 - 연수시작일)
						if(today < startDate) {
							learnProg = 0;
						} else if(today >= endDate) {
							learnProg = 100;
						} else {
							learnProg = (today - startDate) / (endDate - startDate) * 100;
						}
						
						if(dataInfo.paymentState == '2' && dataInfo.reqType != '3' && dataInfo.reqType != '4') {
							var tempRate = 0;
							
							progRate = (dataInfo.chapterCnt == 0 ? 0 : (dataInfo.progCnt/dataInfo.chapterCnt*100));
							
							// 10단위로 끊어지는 경우 진도율은 10단위가 더 증가해야함.
							tempRate = (progRate != 0 && progRate % 10 == 0) ? progRate + 1 : progRate;

							if(dataInfo.objCnt == 0) {
								memo += "온라인시험미참여<br />";
							}
							if(dataInfo.subCnt == 0) {
								memo += "온라인과제미참여<br />";
							}
							if(today >= startDate && today <= endDate && tempRate < 90) {
								memo += "진도율 "+(tempRate == 0 ? 10 : Math.ceil(tempRate/10)*10)+"%미만<br />";
							}
						}
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append("		<input type='hidden' name='sendPhone' value='"+dataInfo.user.phone+"' />");
						sb.Append("		<input type='hidden' name='sendEmail' value='"+dataInfo.user.email+"' />");
						sb.Append("		<input type='hidden' name='sendId' value='"+dataInfo.user.id+"' />");
						sb.Append("		<input type='hidden' name='sendName' value='"+dataInfo.user.name+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+cardinalName+"</td>");
						sb.Append("	<td>"+courseName+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td class='manage' style='cursor: pointer; color: #0000ff'>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
						sb.Append("	<td>"+learnProg.toFixed(2)+"%</td>");
						sb.Append(" <td>"+progRate.toFixed(2)+"%</td>");
						//sb.Append(" <td>"+dataInfo.progCnt+"</td>");
						//sb.Append(" <td>"+(dataInfo.objCnt+"/"+dataInfo.subCnt)+"</td>");
						//sb.Append(" <td>"+dataInfo.accCnt+"번</td>");
						//sb.Append(" <td>"+(dataInfo.learnTime/60).toFixed(1)+"분</td>");
						//sb.Append(" <td>0회</td>");
						//sb.Append(" <td>"+(dataInfo.attScore)+"점</td>");
						sb.Append(" <td>"+(dataInfo.totalScore)+"점</td>");
						sb.Append(" <td>"+memo+"</td>");

						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='16'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 단체 SMS 또는 이메일 발송 기능
	function sendMessage() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: sendMsgUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				alert(result+"명 발송처리되었습니다.");
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}

	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("개별신청관리", learnAppEditUrl, $("form[name='searchForm']").serialize());
	});
	
	// 클릭 시 회원 상세 페이지 이동
	$("#dataListBody").on("click", ".manage", function() {
		
		var list = new Array();
		
		var idx = $("#dataListBody .manage").index($(this));
		// SMS, EMAIL 레이어 팝업
		var obj = new Object();

		obj.stu_app_phone	= $(":hidden[name='sendPhone']").eq(idx).val();
		obj.stu_app_email	= $(":hidden[name='sendEmail']").eq(idx).val();
		obj.user_id		= $(":hidden[name='sendId']").eq(idx).val();
		obj.stu_app_nm	= $(":hidden[name='sendName']").eq(idx).val();
		list.push(obj);
		
		var data = new Object();
		data.list = JSON.stringify(list);
		// EMAIL인 경우 1, SMS 인 경우 2(default로 EMAIL)
		
		openLayerPopup("SMS 발송", "/admin/common/popup/smsMail", data);
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {
		if(!$("#courseId").val()) {
			alert("과정을 먼저 선택해야 합니다.");
		} else {
			// 기수선택 레이어 팝업
			var data = new Object();
			data.learnTypes = "J,S,M";
			data.id = $("#courseId").val();
			
			if($(":hidden[name='groupLearnYn']").val() == "Y") {
				data.learnTypes = "G";
			}
			openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
		}
	});
	
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		// 과정선택 레이어 팝업
		var data = new Object();
		
		data.cardinalId = $("#cardinalId").val();
		data.learnTypes = $("#learnType").val();
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// SMS 진도율 발송 버튼
	$("#progSmsBtn").unbind("click").bind("click", function() {
		if($("#smsProgType").val() == "0") {
			alert("진도율을 선택하세요");
		} else if(confirm("진도율 독려 SMS 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("2");
			$(":hidden[name='progType']").val($("#smsProgType").val());
			$(":hidden[name='sendTarget']").val("1");
			
			sendMessage();
		}
	});
	
	// SMS 온라인평가 참여독려 버튼
	$("#objSmsBtn").unbind("click").bind("click", function() {
		if(confirm("온라인시험 참여 독려 SMS 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("2");
			$(":hidden[name='progType']").val($("#smsProgType").val());
			$(":hidden[name='sendTarget']").val("2");
			
			sendMessage();
		}
	});
	
	// SMS 온라인과제 참여독려 버튼
	$("#subSmsBtn").unbind("click").bind("click", function() {
		if(confirm("온라인과제 참여 독려 SMS 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("2");
			$(":hidden[name='progType']").val($("#smsProgType").val());
			$(":hidden[name='sendTarget']").val("3");
			
			sendMessage();
		}
	});
	
	// 메일 진도율 발송 버튼
	$("#progMailBtn").unbind("click").bind("click", function() {
		if($("#mailProgType").val() == "0") {
			alert("진도율을 선택하세요");
		} else if(confirm("진도율 독려 메일 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("1");
			$(":hidden[name='progType']").val($("#mailProgType").val());
			$(":hidden[name='sendTarget']").val("1");
			
			sendMessage();
		}
	});
	
	// 메일 온라인평가 참여독려 버튼
	$("#objMailBtn").unbind("click").bind("click", function() {
		if(confirm("온라인시험 참여 독려 메일 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("1");
			$(":hidden[name='progType']").val($("#mailProgType").val());
			$(":hidden[name='sendTarget']").val("2");
			
			sendMessage();
		}
	});
	
	// 메일 온라인과제 참여독려 버튼
	$("#subMailBtn").unbind("click").bind("click", function() {
		if(confirm("온라인과제 참여 독려 메일 발송하시겠습니까?")) {
			$(":hidden[name='sendType']").val("1");
			$(":hidden[name='progType']").val($("#mailProgType").val());
			$(":hidden[name='sendTarget']").val("3");
			
			sendMessage();
		}
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);
}

function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>수강관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<!-- 검색조건 -->
				        	<select class="searchConditionBox" name="searchCondition">
								<option value='all'>전체</option>
								<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
								<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
							</select>
							<!-- 검색키워드 -->
							<input type="text" class="searchKeywordBox" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>결제상태</th>
	        			<td>
	        				<!-- 결제상태 -->
							<select class="selector" name='paymentState'>
								<option value="">결제상태</option>
								<option value="1" <c:if test="${search.paymentState eq '1'}">selected</c:if>>미결제</option>
								<option value="2" <c:if test="${search.paymentState eq '2'}">selected</c:if>>결제완료</option>
								<option value="4" <c:if test="${search.paymentState eq '4'}">selected</c:if>>환불</option>
							</select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>과정선택</th>
	        			<td>
	        				<!-- 과정 선택 -->
							<input type='text' class="inputSelect" id='courseName' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>기수선택</th>
	        			<td>
	        				<!-- 기수 선택 -->
							<input type='text' class="inputSelect" id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
	        				<button id='searchBtn' class="btn-primary" type="button">검색</button>
	        			</td>
	        		</tr>
	        	</table>
	        </div>
        	<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 메일 또는 SMS 발송 관련 -->
    		<input type='hidden' name='sendType' value='' />
    		<input type='hidden' name='progType' value='0' />
    		<input type='hidden' name='sendTarget' value='' />
        	
        	<!-- 기수와 과정 ID 세팅 -->
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" id="learnType" value='<c:out value="${search.cardinal.learnType}" default="" />' />
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<!-- 지역 선택 -->
			<%-- <select name="region.code">
				<option value="">시도교육청</option>
				<c:forEach items="${region}" var="code" varStatus="status">
					<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq search.region.code}">selected</c:if>><c:out value="${code.name}" /></option>
				</c:forEach>
			</select> --%>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연변</th>
				<th>신청번호</th>
				<th>기수명</th>
				<th>과정명</th>
				<th>성명</th>
				<th>아이디</th>
				<th>연수 진행 경과율</th>
				<th>진도율</th>
			<!--<th>청강수</th>
				<th>응시율</th>
				<th>접속횟수</th>
				<th>학습시간</th>
				<th>게시횟수</th>
				<th>출석점수</th>-->
				<th>최종점수</th>
				<th>결시내역</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		
		<!-- 독려 이메일/메일 추후 추가 -->
		<!-- <div class="bottom-btnSet">
			<span style="color: blue; font-weight: bold;">메일 발송 : </span>
			<select id='mailProgType'>
				<option value="0">==== 진도율 ====</option>
				<option value="1">진도율 10%미만</option>
				<option value="2">진도율 20%미만</option>
				<option value="3">진도율 30%미만</option>
				<option value="4">진도율 40%미만</option>
				<option value="5">진도율 50%미만</option>
				<option value="6">진도율 60%미만</option>
				<option value="7">진도율 70%미만</option>
				<option value="8">진도율 80%미만</option>
				<option value="9">진도율 90%미만</option>
			</select>
			<a id="progMailBtn" class="btn align_left" href="javascript:void();">진도율 독려 메일발송</a>
			<a id="objMailBtn" class="btn align_left" href="javascript:void();">온라인시험 참여 독려 메일발송</a>
			<a id="subMailBtn" class="btn align_left" href="javascript:void();">온라인과제 참여 독려 메일발송</a>
		</div>
		<div class="bottom-btnSet">
			<span style="color: blue; font-weight: bold;">SMS 발송 : </span>
			<select id='smsProgType'>
				<option value="0">==== 진도율 ====</option>
				<option value="1">진도율 10%미만</option>
				<option value="2">진도율 20%미만</option>
				<option value="3">진도율 30%미만</option>
				<option value="4">진도율 40%미만</option>
				<option value="5">진도율 50%미만</option>
				<option value="6">진도율 60%미만</option>
				<option value="7">진도율 70%미만</option>
				<option value="8">진도율 80%미만</option>
				<option value="9">진도율 90%미만</option>
			</select>
			<a id="progSmsBtn" class="btn align_left" href="javascript:void();">진도율 독려 SMS발송</a>
			<a id="objSmsBtn" class="btn align_left" href="javascript:void();">온라인시험 참여 독려 SMS발송</a>
			<a id="subSmsBtn" class="btn align_left" href="javascript:void();">온라인과제 참여 독려 SMS발송</a>
		</div> -->
	</div>
</div>