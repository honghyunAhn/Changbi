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
	var listUrl	= "<c:url value='/data/stats/joinStatsList' />";
	
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
						sb.Append("	<td>"+(dataInfo.YEAR != "9999" ? dataInfo.YEAR : "기타")+"</td>");
						sb.Append("	<td>"+(dataInfo.GENDER == "M" ? "남" : "여")+"</td>");
						sb.Append("	<td>"+dataInfo.CNT1+"</td>");
						sb.Append("	<td>"+dataInfo.CNT2+"</td>");
						sb.Append("	<td>"+dataInfo.CNT3+"</td>");
						sb.Append("	<td>"+dataInfo.CNT4+"</td>");
						sb.Append("	<td>"+dataInfo.CNT5+"</td>");
						sb.Append("	<td>"+dataInfo.CNT6+"</td>");
						sb.Append("	<td>"+dataInfo.CNT7+"</td>");
						sb.Append("	<td>"+dataInfo.TOTAL_CNT+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='10'>조회된 결과가 없습니다.</td>");
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
		setContentList();
	});

	setContentList();
});

</script>

<div class="content_wraper">
	<h3>회원가입현황통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

			<!-- 년월일 검색 -->
			<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear" />
			<select name='year'>
				<option value=''>년도</option>
				<c:forEach var="year" begin="${nowYear - 4}" end="${nowYear}" step="1">
					<option value="${nowYear - year + nowYear - 4}" <c:if test="${search.year eq (nowYear - year + nowYear - 4)}">selected="selected"</c:if>>${nowYear - year + nowYear - 4}년</option>
				</c:forEach>
			</select>
			<select name='month'>
				<option value=''>월</option>
				<c:forEach var="month" begin="1" end="12" step="1">
					<option value="${month}" <c:if test="${search.month eq month}">selected="selected"</c:if>>${month}월</option>
				</c:forEach>
			</select>
			<select name='date'>
				<option value=''>일</option>
				<c:forEach var="date" begin="1" end="31" step="1">
					<option value="${date}" <c:if test="${search.date eq date}">selected="selected"</c:if>>${date}일</option>
				</c:forEach>
			</select>
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th rowspan="2">연령</th>
				<th rowspan="2">성별</th>
				<th colspan="8">기관별</th>
			</tr>
			<tr>
				<th>유아</th>
				<th>초등</th>
				<th>중등</th>
				<th>고등</th>
				<th>특수</th>
				<th>기관</th>
				<th>일반</th>
				<th>합계</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="paging">
		</div>
	</div>
</div>