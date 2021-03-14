<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>게시물관리</title>
<link href="<c:url value="/css/page/styles.css"/>" rel="stylesheet">
<link href="<c:url value="/css/bootstrap/bootstrap.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/sbadmin2/metisMenu/metisMenu.min.css"/>"	rel="stylesheet"><!-- metisMenu css -->
<link href="<c:url value="/css/sbadmin2/sb-admin-2.css"/>" rel="stylesheet"><!-- custom css -->
<link href="<c:url value="/css/font-awesome/font-awesome.min.css"/>" rel="stylesheet" type="text/css"><!-- custom fonts -->

<script src="<c:url value="/js/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/js/sbadmin2/metisMenu/metisMenu.min.js"/>"></script><!-- metis menu plugin javascript -->
<script src="<c:url value="/js/sbadmin2/sb-admin-2.js"/>"></script><!-- custom theme javascript -->
<script src="<c:url value="/js/page/main.js"/>"></script>

<script type="text/javascript">

$(document).ready(function(){
	var viewUrl	= "<c:url value='/board/boardView.do' />";
	var editUrl	= "<c:url value='/board/boardEdit.do' />";
	var listUrl	= "<c:url value='/board/board.do' />";
	
	// 게시판별 조회
	$("#boardId").bind("change", function() {
	 	// 무조건 1페이지로 이동
	    $(":hidden[name='pageIndex']").val("1");
	 
		$("form[name='searchForm']").attr("action", listUrl);
		$("form[name='searchForm']").submit();
	});
	
	// 키워드 검색 조회(자기 자신 호출)
	$("#searchBtn").bind("click", function() {
	 	// 무조건 1페이지로 이동
	    $(":hidden[name='pageIndex']").val("1");
	 
		$("form[name='searchForm']").attr("action", listUrl);
		$("form[name='searchForm']").submit();
	});
	
	// 전체 체크 박스 선택 및 해제
	$("#allChk").bind("click", function() {
		$(":checkbox[name='id']").prop("checked", $(this).is(":checked"));
	});
	
	$("#boardDelBtn").click(function(){
	 	var id = [];
	 	
	    $("input[name='id']:checked").each(function(i) {
	        id.push($(this).val());
	    });
	    
	    if(id.length == 0) {
			alert("삭제 할 데이터를 선택해주세요.");
		} else if(confirm("선택 삭제하시겠습니까?")) {
			$.ajax({
	            url : 'boardDel.do',
	            method: "post",
	            data : {id : id}, 
	            success:function(data){
	        		$("form[name='searchForm']").attr("action", listUrl);
	        		$("form[name='searchForm']").submit();
	            }
	        });
		}
	});
	
	$("#boardAddBtn").click(function() {
	 	// 폼 이동
		$(":hidden[name='id']").val("0");
	 
		$("form[name='searchForm']").attr("action", editUrl);
		$("form[name='searchForm']").submit();
	});
	
	// 제목 클릭 시 수정 페이지 호출
	$(".edit_content").bind("click", function() {
		var idx = $(".edit_content").index($(this));
		
		// 폼 이동
		$(":hidden[name='id']").val($(":hidden[name='hiddenId']").eq(idx).val());
		
		$("form[name='searchForm']").attr("action", viewUrl);
		$("form[name='searchForm']").submit();
	});
});

function linkPage(pageNo) {
	var f = document.searchForm;
    f.pageIndex.value = pageNo;
    f.action = "<c:url value='/board/board.do'/>";
    f.submit();
}
</script> 
</head>

<body>

<div id="wrapper">

	<!-- Navigation -->
	<%-- <jsp:include page="/WEB-INF/jsp/common/inc/navigation.jsp"/> --%>
	<!-- // Navigation -->

    <div id="page-wrapper">
        <ol class="breadcrumb" style="background-color:#fff">
		  <!-- <li><a href="#">Home</a></li>
		  <li><a href="#">Library</a></li>
		  <li class="active">Data</li> -->
		</ol>
		<div class="page-header">
		  <h1>게시물관리(목록)</h1>
		</div>

        <div class="row">
            
            <form name="searchForm" method="post" class="form-inline">
	            
	            <input type="hidden" name="id" value="0" />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageIndex" value='<c:out value="${search.pageIndex}" default="1" />' />
	            
				<div class="col-lg-12 text-left">
					<select class="form-control" id="boardId" name="boardId">
						<option value="">게시판목록</option>
						<c:forEach var="boardManageList" items="${boardManageList}" varStatus="status">
							<c:if test="${boardManageList.boardId ne 'qna'}">
								<option value="${boardManageList.boardId}" <c:if test="${boardManageList.boardId == search.boardId}">selected</c:if>>${boardManageList.koName}</option>
							</c:if>
						</c:forEach>
					</select>
				    <select class="form-control" id="searchCondition" name="searchCondition">
						<option value="title" <c:if test="${search.searchCondition == 'title'}">selected</c:if>>제목</option>
						<option value="name"  <c:if test="${search.searchCondition == 'name'}">selected</c:if>>작성자</option>
						<option value="comment"  <c:if test="${search.searchCondition == 'comment'}">selected</c:if>>내용</option>
					</select>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
						<span class="input-group-btn">
	                    	<button class="btn btn-default" type="button" id="searchBtn"><i class="fa fa-search"></i></button>
	                    </span>
	               	</div>
				</div>
			</form>
			
			<form name="board" id="board" class="form-inline">			
			<div class="col-lg-12" style="margin-top: 10px;">
				<table class="table dataTable table-bordered table-hover">
				<thead>
				<tr>
					<th class="text-center"><input type="checkbox" id="allChk" name=""></th>
					<th class="text-center">No</th>
					<th class="text-center">구분</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자ID</th>
					<th class="text-center">작성자</th>
					<th class="text-center">조회수</th>
					<th class="text-center">작성일자</th>
				</tr>
               	</thead>
               	<tbody>
               	<c:forEach var="boardList" items="${boardList}" varStatus="status">
               	<input type='hidden' name='hiddenId' value='<c:out value="${boardList.id}" />' />
				<tr>
					<td class="text-center"><input type="checkbox" name="id" value='<c:out value="${boardList.id}" />' ></td>
					<td class="text-center"><c:out value="${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1)*paginationInfo.recordCountPerPage+status.index)}" /></td>
					<td class="text-center"><c:out value="${boardList.boardName}" /></td>
					<td class="text-center">
						<span class='edit_content' style='cursor: pointer; color: <c:choose><c:when test="${boardList.emergencyYn eq 'Y'}">#ff0000;</c:when><c:otherwise>#0000ff;</c:otherwise></c:choose>'>						
							<c:out value="${fn:substring(boardList.title, 0, 50)}" />
							<c:if test="${fn:length(boardList.title) > 50}">...</c:if>
						</span>
					</td>
					<td class="text-center"><c:out value="${boardList.userId}" default="제주올레" /></td>
					<td class="text-center"><c:out value="${boardList.name}" /></td>
					<td class="text-center"><c:out value="${boardList.hits}" /></td>
					<td class="text-center">
						<fmt:parseDate var="dateString" value="${boardList.regDate}" pattern="yyyyMMddHHmmss" />
						<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			 	</c:forEach>
				<c:if test="${empty boardList }">
				<tr>
					<td class="nodata" colspan="8"><spring:message code="common.nodata.msg" /></td>
				</tr>	
				</c:if> 
				               	
               	</tbody>
				</table>
				<div class="row mgB30px">
					<div class="col-lg-7 text-left">
	 					<%-- <ui:pagination paginationInfo="${paginationInfo}" type="bootstrap" jsFunction="linkPage"/> --%>
					</div>
					<div class="col-lg-5 text-right">
						<button type="button" id="boardDelBtn" class="btn btn-danger">선택삭제</button>
						<button type="button" id="boardAddBtn" class="btn btn-primary">추가</button>
					</div>
				</div>	
			</div>
			</form>
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

</body>

</html>

