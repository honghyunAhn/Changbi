<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/stats/smsHistoryStats' />";
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit();
	
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
					var dataList	= result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						sb.Append("<tr>");
						sb.Append("	<td>"+((pageNo-1)*numOfRows+(i+1))+"</td>");
						sb.Append("	<td>"+dataInfo.REG_DATE+"</td>");
						sb.Append("	<td>"+dataInfo.USER_ID+"</td>");
						sb.Append("	<td>"+dataInfo.PHONE+"</td>");
						sb.Append("	<td>"+dataInfo.CONTENT.replace(/\n/g, '<br />')+"</td>");
						sb.Append("	<td>1</td>");
						sb.Append("	<td>"+dataInfo.REG_ID+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
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
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});

	setContentList();
});

</script>

<div class="content_wraper">
	<h3>문자발송 통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />

        	<!-- 기간조회 -->
			<div>
				<span>기간 : </span>
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

			<select name="searchCondition">
				<option value='all'>검색조건</option>
				<option value='phone' <c:if test="${search.searchCondition eq 'phone'}">selected</c:if>>전송번호</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>전송일자</th>
				<th>아이디</th>
				<th>전송번호</th>
				<th>전송메시지</th>
				<th>건수</th>
				<th>발송자</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>