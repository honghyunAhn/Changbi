<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/board/freeBoardList' />";
	var editUrl	= "<c:url value='/admin/board/freeBoardEdit' />";
	var editReplyUrl = "<c:url value='/admin/board/freeBoardReplyEdit' />";
	var excelUrl = "";
	
	var boardType = "<c:out value='${search.boardType}'/>";
	
	switch (boardType) {
		case '4' : editUrl = "<c:url value='/admin/board/boardReplyEdit' />"; break;
	}
	
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
				
				var baseList = result.baseList && result.baseList.list ? result.baseList.list : null;
				var topList = result.topList && result.topList.list ? result.topList.list : null;

				var sb = new StringBuilder();
				
				// 일반 게시물 
				if(baseList && baseList.length > 0) {
					var dataList = baseList;
					var pageNo		= result.baseList.pageNo ? result.baseList.pageNo : 1;
					var numOfRows	= result.baseList.numOfRows	? result.baseList.numOfRows : 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;
						
						if (dataInfo.category == 'M') {
							sb.Append("<tr>");
							sb.Append("	<td>");
							sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
							sb.Append("		<input type='hidden' name='checkCategory' value='"+dataInfo.category+"' />");
							sb.Append("		<input type='hidden' name='checkBoardId' value='"+dataInfo.id+"' />");
							sb.Append(		((pageNo-1)*numOfRows+(i+1)));
							sb.Append("	</td>");
							sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
							
							switch(boardType) {
							case '1' :
								sb.Append("<td>"+dataInfo.noticeTypeName+"</td>");
								break;
							case '3' : 
								sb.Append("<td>"+(dataInfo.faq ? dataInfo.faq.name : '')+"</td>");
								break;							 
							}
							
							sb.Append("	<td class='content_edit' style='text-align:left'>&nbsp;"+dataInfo.title+"</td>");
							sb.Append("	<td>"+(dataInfo.regUser ?  dataInfo.regUser.name : (dataInfo.user ? dataInfo.user.name : ""))+"</td>");
							sb.Append("	<td>"+(dataInfo.hits ? dataInfo.hits : 0)+"</td>");
							sb.Append("	<td>");
							if (dataInfo.file1) {
								sb.Append("<a href="+dataInfo.file1.detailList[0].urlPath+" download>첨부파일1</a>");
							}
							if (dataInfo.file2) {
								sb.Append("<a href="+dataInfo.file2.detailList[0].urlPath+" download>첨부파일2</a>");
							}
							sb.Append("	</td>");
							sb.Append("</tr>");
						} else if (dataInfo.category == 'S') {
							sb.Append("<tr>");
							sb.Append("	<td>");
							sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.boardReply.id+"' />");
							sb.Append("		<input type='hidden' name='checkCategory' value='"+dataInfo.category+"' />");
							sb.Append("		<input type='hidden' name='checkBoardId' value='"+dataInfo.id+"' />");
							sb.Append(		((pageNo-1)*numOfRows+(i+1)));
							sb.Append("	</td>");
							sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
							
							switch(boardType) {
							case '1' :
								sb.Append("<td>"+dataInfo.noticeTypeName+"</td>");
								break;
							case '3' : 
								sb.Append("<td>"+(dataInfo.faq ? dataInfo.faq.name : '')+"</td>");
								break;
							}
							
							sb.Append("	<td class='content_edit' style='text-align:left'>&nbsp;&nbsp;<span style='color:red'>→RE:</span>"+dataInfo.title+"</td>");
							sb.Append("	<td>"+(dataInfo.regUser ?  dataInfo.regUser.name : (dataInfo.user ? dataInfo.user.name : ""))+"</td>");
							sb.Append("	<td>"+(dataInfo.hits ? dataInfo.hits : 0)+"</td>");
							sb.Append("	<td>");
							if (dataInfo.file1) {
								sb.Append("<a href="+dataInfo.file1.detailList[0].urlPath+" download>첨부파일1</a>");
							}
							if (dataInfo.file2) {
								sb.Append("<a href="+dataInfo.file2.detailList[0].urlPath+" download>첨부파일2</a>");
							}
							sb.Append("	</td>");
							sb.Append("</tr>");
						}
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 탑 게시물
				sb.empty();
				if(topList && topList.length > 0) {
					var dataList = topList;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;
						
						sb.Append("<tr>");
						sb.Append("<td>");
						sb.Append("<input type='hidden' name='checkId' value='"+dataInfo.id+"' />Top");
						sb.Append("<input type='hidden' name='checkCategory' value='"+dataInfo.category+"' />");
						sb.Append("<input type='hidden' name='checkBoardId' value='"+dataInfo.id+"' />");
						sb.Append("</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td>"+dataInfo.noticeTypeName+"</td>");
						sb.Append("	<td class='content_edit' style='text-align:left'>&nbsp;"+dataInfo.title+"</td>");
						sb.Append("	<td>"+(dataInfo.regUser ?  dataInfo.regUser.name : (dataInfo.user ? dataInfo.user.name : ""))+"</td>");
						sb.Append("	<td>"+(dataInfo.hits ? dataInfo.hits : 0)+"</td>");
						sb.Append("	<td>");
						if (dataInfo.file1) {
							sb.Append("<a href="+dataInfo.file1.detailList[0].urlPath+" download>첨부파일1</a>");
						}
						if (dataInfo.file2) {
							sb.Append("<a href="+dataInfo.file2.detailList[0].urlPath+" download>첨부파일2</a>");
						}
						sb.Append("	</td>");
						sb.Append("</tr>");
					}
				}
				
				$("#topDataListBody").html(sb.ToString());
								
				// 페이징 처리
				pagingNavigation.setData(result.baseList);	// 데이터 전달
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
	$("#dataListBody, #topDataListBody").on("click", ".content_edit", function() {
		
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());

		// M : 원글, S : 답글
		$(":hidden[name='category']").val($(":hidden[name='checkCategory']").eq(idx).val());
		
		// 답글 대상의 원글을 찾기 위한 id 값 설정
		if ($(":hidden[name='checkCategory']").eq(idx).val() == "M") {
			$(":hidden[name='search.boardId']").val($(":hidden[name='checkId']").eq(idx).val());
			contentLoad("-", editUrl, $("form[name='searchForm']").serialize());
		} else if ($(":hidden[name='checkCategory']").eq(idx).val() == "S") {
			$(":hidden[name='search.boardId']").val($(":hidden[name='checkBoardId']").eq(idx).val());		
			contentLoad("-", editReplyUrl, $("form[name='searchForm']").serialize());
		}
		
	    //alert($(":hidden[name='id']").val()+","+$(":hidden[name='search.boardId']").val()+","+$(":hidden[name='category']").val())
	
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동(ID가 int인 경우 0을 넣어줌)
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("-", editUrl, $("form[name='searchForm']").serialize());
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
});

</script>

<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="category" value="" />
        	<input type="hidden" name="search.boardId" value="0" />
        	   	
        	<!-- 구분타입 -->
        	<input type="hidden" name="boardType" value='<c:out value="${search.boardType}" />' />
        	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 공지타입 -->
        	<%-- <input type="hidden" name="noticeType" value='<c:out value="${search.noticeType}" />' /> --%>
        	
			<select name="searchCondition">
				<option value=''>전체</option>
				<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
			</select>

			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<!-- 게시물 별 검색조건 조정 -->
			<c:choose> 
       			<c:when test="${search.boardType == '1' and search.noticeType ne '7'}"> <!-- 공지사항 인 경우 -->
       				<select name="noticeType">
       					<option value="">구분</option>
       					<option value="1" <c:if test="${board.noticeType eq '1'}">selected</c:if>>공지사항</option>
       					<option value="2" <c:if test="${board.noticeType eq '2'}">selected</c:if>>이벤트</option>
       				</select> 
       			</c:when>
       			
       			<c:when test="${search.boardType == '1' and search.noticeType eq '7'}"> <!-- 연수모집공문관리 인 경우 -->
       				<select name="noticeType">
       					<option value="7" <c:if test="${board.noticeType eq '7'}">selected</c:if>>공지사항</option>
       				</select>
       			</c:when>
       		</c:choose>
			
			<c:if test="${!empty faq}">
				<select name="faqCode">
					<option value=''>전체</option>
					<c:forEach var="vo" items="${faq}" varStatus="status">
						<option value='<c:out value="${vo.code}"/>'><c:out value="${vo.name}"/></option>
					</c:forEach>
				</select>
			</c:if>
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>게시일자</th>
				
				<c:if test="${search.boardType eq '1' or search.boardType eq '3'}">
					<th>구분</th>
				</c:if>
				
				<th>제목</th>
				<th>게시자</th>
				<th>조회수</th>
				<th>첨부다운로드</th>
			</tr>
			</thead>
			<tbody id="topDataListBody"></tbody>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<c:if test="${search.boardType ne '4' and search.boardType ne '5'}">
				<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
			</c:if>
		</div>
	</div>
</div>