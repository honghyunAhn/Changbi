<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/learnApp/activeList' />"; 
	var excelUrl = "";
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit();
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='sendPhone' value='"+dataInfo.PHONE+"' />");
						sb.Append("		<input type='hidden' name='sendEmail' value='"+dataInfo.EMAIL+"' />");
						sb.Append("		<input type='hidden' name='sendId' value='"+dataInfo.ID+"' />");
						sb.Append("		<input type='hidden' name='sendName' value='"+dataInfo.NAME+"' />");
						sb.Append(		(i+1));
						sb.Append("	</td>");
						sb.Append("	<td class='manage' style='cursor: pointer; color: #0000ff'>"+dataInfo.ID+"</td>");
						sb.Append("	<td>"+dataInfo.NAME+"</td>");
						sb.Append("	<td>"+dataInfo.CARDINAL_NAME+"</td>");
						sb.Append("	<td>"+dataInfo.COURSE_NAME+"</td>");
						sb.Append("	<td>"+dataInfo.LOGIN+"</td>");
						sb.Append("	<td>"+dataInfo.FIRST_LOGIN+"</td>");
						sb.Append("	<td>"+dataInfo.LAST_LOGIN+"</td>");
						sb.Append("	<td>"+(dataInfo.A_CNT+" / "+dataInfo.Q_CNT)+"</td>");
						sb.Append("	<td>"+dataInfo.N_CNT+"</td>");
						sb.Append("	<td>"+(dataInfo.CHECK_CNT+" / "+dataInfo.QUIZ_CNT)+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='11'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
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
		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 선택해주세요.");
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($(":hidden[name='cardinalId']").val());
			
			setContentList();
		}
	});
	
	// 튜터아이디 클릭 시 메일 또는 SMS 발송
	$("#dataListBody").on("click", ".manage", function() {
		var idx = $("#dataListBody .manage").index($(this));
		// SMS, EMAIL 레이어 팝업
		var data = new Object();

		data.phone	= $(":hidden[name='sendPhone']").eq(idx).val();
		data.email	= $(":hidden[name='sendEmail']").eq(idx).val();
		data.id		= $(":hidden[name='sendId']").eq(idx).val();
		data.name	= $(":hidden[name='sendName']").eq(idx).val();

		// EMAIL인 경우 1, SMS 인 경우 2(default로 EMAIL)
		
		openLayerPopup("SMS/메일 발송", "/admin/common/popup/smsMail", data);
	});
	
	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = new Object();
		
		data.learnType = "J,G";
		
		openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 과정선택 버튼 클릭 시
	$(":text[name='course.name']").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 먼저 선택해야 합니다.");
		} else {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data.cardinalId = $(":hidden[name='cardinalId']").val();
			data.learnTypes = $("#learnType").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
		}
	});
});

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);

	// 과정이 없는 상태로 화면을 변경 시킨다.
	setCourse();
}

function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>첨삭지도</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" id="cardinalId" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" id="learnType" value='<c:out value="${search.cardinal.learnType}" default="" />' />
        	
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	
			<!-- 기수 선택 -->
			<input type='text' id="cardinalName" name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<!-- 과정 선택 -->
			<input type='text' id="courseName" name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />

			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
			
			<div>
				<span>기간조회 : </span>
				<div class='input-group date datetimepicker w20' id='searchStartDate'>
	                <input type='text' name='searchStartDate' class='form-control' value='<c:out value="${search.searchStartDate}" />' />
	                <span class='input-group-addon'>
	                    <span class='glyphicon glyphicon-calendar'></span>
	                </span>
	            </div>
	            <span>~</span>
	            <div class='input-group date datetimepicker w20' id='searchEndDate'>
	                <input type='text' name='searchEndDate' class='form-control' value='<c:out value="${search.searchEndDate}" />' />
	                <span class='input-group-addon'>
	                    <span class='glyphicon glyphicon-calendar'></span>
	                </span>
	            </div>
            </div>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>튜터아이디</th>
				<th>튜터명</th>
				<th>기수명</th>
				<th>과정명</th>
				<th>로그인</th>
				<th>최초접속일</th>
				<th>최근접속일</th>
				<th>Q&amp;A(답변/게시)</th>
				<th>공지현황</th>
				<th>Test(채점/응시)</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
	</div>
</div>