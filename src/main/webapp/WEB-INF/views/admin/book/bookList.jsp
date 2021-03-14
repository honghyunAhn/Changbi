<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/book/bookList' />";
	var editUrl	= "<c:url value='/admin/book/bookEdit' />";
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
					var dataList	= result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+(dataInfo.mainYn == "N" ? "부교재" : "주교재")+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+(dataInfo.author ? dataInfo.author : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.supply ? dataInfo.supply.name : "")+"</td>");
						sb.Append("	<td>"+dataInfo.price+"원</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='8'>조회된 결과가 없습니다.</td>");
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
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("교재등록관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동(ID가 int인 경우 0을 넣어줌)
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("교재등록관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

</script>

<div class="content_wraper">
	<h3>교재등록관리</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
			<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>교재명</option>
			</select>
			
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<!-- 출판사 선택 -->
			<select name="supply.code">
				<option value="">출판사</option>
				<c:forEach items="${publish}" var="code" varStatus="status">
					<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq search.supply.code}">selected</c:if>><c:out value="${code.name}" /></option>
				</c:forEach>
			</select>
			
			<select name='useYn'>
				<option value="">판매여부</option>
				<option value="Y" <c:if test="${search.useYn eq 'Y'}">selected</c:if>>판매</option>
				<option value="N" <c:if test="${search.useYn eq 'N'}">selected</c:if>>중지</option>
			</select>
			
			<select name='mainYn'>
				<option value="">교재구분</option>
				<option value="Y" <c:if test="${search.mainYn eq 'Y'}">selected</c:if>>주교재</option>
				<option value="N" <c:if test="${search.mainYn eq 'N'}">selected</c:if>>부교재</option>
			</select>
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>등록일</th>
				<th>교재코드</th>
				<th>교재구분</th>
				<th>교재명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>가격</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>