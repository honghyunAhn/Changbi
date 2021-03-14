<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/stats/userStatsList' />";
	
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
				var userSb = new StringBuilder();
				var stateSb = new StringBuilder();
				var paymentSb = new StringBuilder();
				var boardSb = new StringBuilder();
				
				userSb.Append("<tr>");
				userSb.Append("	<td>"+(result.A_CNT + result.B_CNT + result.C_CNT + result.D_CNT + result.E_CNT)+"</td>");
				userSb.Append("	<td>"+result.A_CNT+"</td>");
				userSb.Append("	<td>"+result.B_CNT+"</td>");
				userSb.Append("	<td>"+result.C_CNT+"</td>");
				userSb.Append("	<td>"+result.D_CNT+"</td>");
				userSb.Append("	<td>"+result.E_CNT+"</td>");
				userSb.Append("</tr>");
				
				stateSb.Append("<tr>");
				stateSb.Append("	<td>"+result.TOTAL_STATE+"</td>");
				stateSb.Append("	<td>"+result.STATE_1+"</td>");
				stateSb.Append("	<td>"+result.STATE_2+"</td>");
				stateSb.Append("	<td>"+result.STATE_3+"</td>");
				stateSb.Append("	<td>"+result.STATE_4+"</td>");
				stateSb.Append("</tr>");
				
				paymentSb.Append("<tr>");
				paymentSb.Append("	<td>"+(result.PAYMENT_1+"/"+result.PAYMENT_2+"/"+result.PAYMENT_3)+"</td>");
				paymentSb.Append("	<td>"+(result.ISSUE_1+"/"+result.ISSUE_2)+"</td>");
				paymentSb.Append("	<td>"+(result.BOOK_1+"/"+result.TOTAL_BOOK)+"</td>");
				paymentSb.Append("	<td>"+result.LEARN_1+"</td>");
				paymentSb.Append("	<td>"+result.LEARN_2+"</td>");
				paymentSb.Append("	<td>"+result.LEARN_3+"</td>");
				paymentSb.Append("</tr>");
				
				boardSb.Append("<tr>");
				boardSb.Append("	<td>"+result.BOARD_1+"</td>");
				boardSb.Append("	<td>0</td>");
				boardSb.Append("	<td>"+result.BOARD_2+"</td>");
				boardSb.Append("	<td>"+result.BOARD_3+"</td>");
				boardSb.Append("</tr>");
				
				
				$("#userBody").html(userSb.ToString());
				$("#stateBody").html(stateSb.ToString());
				$("#paymentBody").html(paymentSb.ToString());
				$("#boardBody").html(boardSb.ToString());
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
		setContentList();
	});

	setContentList();
});

</script>

<div class="content_wraper">
	<h3>회원현황 및 게시물통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

			<!-- 기간조회 -->
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
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<!-- 회원현황 -->
		<h4>기본신청정보</h4>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>총회원수</th>
				<th>마스터관리자</th>
				<th>운영관리자</th>
				<th>강의관리자</th>
				<th>교원회원</th>
				<th>일반회원</th>
			</tr>
			</thead>
			<tbody id="userBody"></tbody>
		</table>
		
		<!-- 수강접수 및 처리현황 -->
		<h4>수강접수 및 처리현황</h4>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>총접수건</th>
				<th>미인증</th>
				<th>수강인증</th>
				<th>수강연기</th>
				<th>수강취소</th>
			</tr>
			</thead>
			<tbody id="stateBody"></tbody>
		</table>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>미납/입금/환불</th>
				<th>이수/과락</th>
				<th>교재발송/신청</th>
				<th>자율/무료연수</th>
				<th>1,2학점연수</th>
				<th>3,4학점연수</th>
			</tr>
			</thead>
			<tbody id="paymentBody"></tbody>
		</table>
		
		<!-- 게시물 관리현황 -->
		<h4>게시물 관리현황</h4>
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>공지사항</th>
				<th>자유게시판</th>
				<th>Q&amp;A게시판</th>
				<th>연수후기</th>
			</tr>
			</thead>
			<tbody id="boardBody"></tbody>
		</table>
	</div>
</div>