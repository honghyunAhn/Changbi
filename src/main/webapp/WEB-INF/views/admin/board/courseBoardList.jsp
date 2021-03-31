<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/board/courseBoardList' />";
	var editUrl	= "<c:url value='/admin/board/courseBoardEdit' />";
	var excelUrl = "";
	
	var boardType = "<c:out value='${search.boardType}'/>";
	var boardTypeForColspan = (boardType == '6' ? '8' : '7');
	
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
				console.log(result);
				var sb = new StringBuilder();
				
				// 일반 게시물 
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo ? result.pageNo : 1;
					var numOfRows	= result.numOfRows	? result.numOfRows : 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;
						
						sb.Append("<tr>");
							sb.Append("<td>");
								sb.Append("<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
								sb.Append(((pageNo-1)*numOfRows+(i+1)));	
							sb.Append("</td>");
							sb.Append("<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
							sb.Append("<td>"+(dataInfo.course.name ? dataInfo.course.name : ''));
							if(dataInfo.course.cardinalName != null) {
								sb.Append("<br>" + dataInfo.course.cardinalName);
							}
							sb.Append("</td>");
							sb.Append("<td class='content_edit' style='text-align:left'>&nbsp;"+dataInfo.title+"</td>");
							
							if (boardType == '6') {
								sb.Append("<td>"+(dataInfo.boardReply ? '답변' : '미답변')+"</td>");
							}
							
							sb.Append("<td>"+(dataInfo.regUser ?  dataInfo.regUser.name : (dataInfo.user ? dataInfo.user.name : ""))+"</td>");
							sb.Append("<td>"+(dataInfo.hits ? dataInfo.hits : 0)+"</td>");
							sb.Append("<td>");
							if (dataInfo.file1) {
								sb.Append('<a href="/forFaith/file/file_download?origin='+dataInfo.file1.detailList[0].originFileName+'&saved=' + dataInfo.file1.detailList[0].fileName+ '&path=uploadImage" download>첨부파일1</a>');
							}
							if (dataInfo.file2) {
								sb.Append('<a href="/forFaith/file/file_download?origin='+dataInfo.file2.detailList[0].originFileName+'&saved=' + dataInfo.file2.detailList[0].fileName+ '&path=uploadImage" download>첨부파일2</a>');
							}
							sb.Append("</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='"+boardTypeForColspan+"'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);	// 데이터 전달
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

		if (boardType == '6') editUrl = "<c:url value='/admin/board/courseBoardReplyEdit' />";
		
		// ajax로 load
		contentLoad("-", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동(ID가 int인 경우 0을 넣어줌)
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("-", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 과정선택 버튼 클릭 시
	// TODO : 과정 팝업에 관리자의 과정만 가져올 수 있도록 파라미터가 필요함.
	$(":text[name='course.name']").unbind("click").bind("click", function() {
		var data = new Object();
		
		// 과정선택 레이어 팝업
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
});

function setCourse(course) {
	// 임시저장
	$(":hidden[name='courseId']").val(course.id);
	$(":text[name='course.name']").val(course.name);
}

</script>	

<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
	        	<table class="searchTable">
		        	<tr>
		        		<th>키워드검색</th>
		        		<td>
			        		<select name="searchCondition">
								<option value='all'>전체</option>
								<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
							</select>
				
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>과정선택</th>
		        		<td>
			        		<!-- 과정 선택 -->
							<input type='text' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
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
        	<!-- <input type="hidden" name="search.boardId" value="0" /> -->
        	<input type="hidden" name="boardType" value='<c:out value="${search.boardType}" />' /> <!-- 게시타입 -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' /> <!-- pageNo -->        	
        	<input type="hidden" name="courseId" value='<c:out value="${search.course.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinalId}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th>순번</th>
					<th>게시일자</th>
					<th>과정명</th>
					<th>제목</th>
					<c:if test="${search.boardType eq '6'}">
						<th>답변여부</th>
					</c:if>
					<th>게시자</th>
					<th>조회수</th>
					<th>첨부다운로드</th>
				</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<c:if test="${search.boardType ne '5' and search.boardType ne '6'}">
				<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
			</c:if>
		</div>
	</div>
</div>