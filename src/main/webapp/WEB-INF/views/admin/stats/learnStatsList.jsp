<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/stats/learnStatsList' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var generalSb = new StringBuilder();
				var teacherSb = new StringBuilder();
				
				generalSb.Append("<tr>");
				generalSb.Append("	<td>"+result.TOTAL_CNT+"</td>");
				generalSb.Append("	<td>"+result.STATE_1+"</td>");
				generalSb.Append("	<td>"+result.STATE_2+"</td>");
				generalSb.Append("	<td>"+result.DELAY_APP_CNT+"</td>");
				generalSb.Append("	<td>"+result.CANCEL_APP_CNT+"</td>");
				generalSb.Append("	<td>"+result.DELAY_CNT+"</td>");
				generalSb.Append("	<td>"+result.CANCEL_CNT+"</td>");
				generalSb.Append("	<td>"+result.ISSUE_1+"</td>");
				generalSb.Append("	<td>"+result.ISSUE_2+"</td>");
				generalSb.Append("</tr>");
				
				teacherSb.Append("<tr>");
				teacherSb.Append("	<td>"+result.TOTAL_CNT+"</td>");
				teacherSb.Append("	<td>"+result.CNT1+"</td>");
				teacherSb.Append("	<td>"+result.CNT2+"</td>");
				teacherSb.Append("	<td>"+result.CNT3+"</td>");
				teacherSb.Append("	<td>"+result.CNT4+"</td>");
				teacherSb.Append("	<td>"+result.CNT5+"</td>");
				teacherSb.Append("	<td>"+result.CNT6+"</td>");
				teacherSb.Append("</tr>");
				
				$("#generalBody").html(generalSb.ToString());
				$("#teacherBody").html(teacherSb.ToString());
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

	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = {"learnType" : $("select[name='cardinal.learnType']").val()};
		
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
			data.learnTypes = $("select[name='cardinal.learnType']").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
		}
	});
});

function setCardinal(cardinal) {
	// 임시저장
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);
	
	setCourse();
}

function setCourse(course) {
	// 임시저장
	$(":hidden[name='course.id']").val(course ? course.id : "");
	$(":text[name='course.name']").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>기수/과정별 통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	
        	<!-- 직무연수 -->
			<select name="cardinal.learnType">
				<option value='J'>직무연수</option>
				<option value='G' <c:if test="${search.cardinal.learnType eq 'G'}">selected</c:if>>단체연수</option>
			</select>
			
			<!-- 기수 선택 -->
			<input type='text' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<!-- 과정 선택 -->
			<input type='text' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />

			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<!-- 일반통계 -->
		<h4>일반통계</h4>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>총접수</th>
				<th>미인증</th>
				<th>수강인증</th>
				<th>연기접수</th>
				<th>취소접수</th>
				<th>연기자</th>
				<th>취소자</th>
				<th>이수완료</th>
				<th>과락완료</th>
			</tr>
			</thead>
			<tbody id="generalBody"></tbody>
		</table>
		
		<!-- 교원접수통계 -->
		<h4>교원접수통계</h4>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>총접수</th>
				<th>유아</th>
				<th>초등</th>
				<th>중등</th>
				<th>고등</th>
				<th>특수</th>
				<th>교육청/기타</th>
			</tr>
			</thead>
			<tbody id="teacherBody"></tbody>
		</table>
	</div>
</div>