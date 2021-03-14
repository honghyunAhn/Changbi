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

<title>게시판관리</title>
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
    var listUrl	= "<c:url value='/board/boardManage.do' />";
    var editUrl	= "<c:url value='/board/boardManageEdit.do' />";
    
 	// 키워드 검색 조회(자기 자신 호출)
	$("#searchBtn").bind("click", function() {
		$("form[name='searchForm']").attr("action", listUrl);
		$("form[name='searchForm']").submit();
	});
 
	$("#boardManageDelBtn").click(function(){
	 	var id = [];
	 	
	    $("input[name='id']:checked").each(function(i) {
	        id.push($(this).val());
	    });
	    
	    if(id.length == 0) {
			alert("삭제 할 데이터를 선택해주세요.");
		} else if(confirm("선택 삭제하시겠습니까?")) {
			$.ajax({
	            url : 'boardManageDel.do',
	            method: "post",
	            data : {id : id}, 
	            success:function(data){
	                $("form[name='searchForm']").attr("action", listUrl);
	        		$("form[name='searchForm']").submit();
	            }
	        });
		}
	});
	
	$("#boardManageAddBtn").click(function(){
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
		
		$("form[name='searchForm']").attr("action", editUrl);
		$("form[name='searchForm']").submit();
	});
});

function linkPage(pageNo) {
	var f = document.board;
    f.pageIndex.value = pageNo;
    f.action = "<c:url value='/board/boardManage.do'/>";
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
		  <h1>게시판관리(목록)</h1>
		</div>

        <div class="row">
            
            <form name="searchForm" method="post" class="form-inline">
	            <input type="hidden" name="id" value="0" />
	            
				<div class="col-lg-12 text-left">
				    <select class="form-control" id="" name="">
						<option value="1">게시판명</option>
					</select>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="검색어" id="searchKeyword" name="searchKeyword"  value="<c:out value="${search.searchKeyword}" />">
						<span class="input-group-btn">
	                    	<button class="btn btn-default" type="button" id="searchBtn"><i class="fa fa-search"></i></button>
	                    </span>
	               	</div>
				</div>
			</form>
			
			<form name="boardManager" id="boardManager" class="form-inline">			
			<div class="col-lg-12" style="margin-top: 10px;">
				<table class="table dataTable table-bordered table-hover">
				<thead>
				<tr>
					<th class="text-center"></th>
					<th class="text-center">게시판ID</th>
					<th class="text-center">게시판명</th>
					<th class="text-center">사용여부</th>
					<th class="text-center">생성일자</th>
				</tr>
               	</thead>
               	<tbody>
               	<c:forEach var="boardManageList" items="${boardManageList}" varStatus="status">
               	<input type='hidden' name='hiddenId' value='<c:out value="${boardManageList.id}" />' />
				<tr>
					<td class="text-center"><input type="checkbox" name="id" value="${boardManageList.id}"></td>
					<td class="text-center"><c:out value="${boardManageList.boardId}" /></td>
					<td class="text-center"><span class='edit_content' style='cursor: pointer; color: #0000ff;'><c:out value="${boardManageList.koName}" /></span></td>
					<td class="text-center">
					<c:choose>
					<c:when test='${boardManageList.useYn == "Y" }'>
					    Y
					</c:when>			 		
					<c:otherwise>
                        N
					</c:otherwise>
					</c:choose>
					</td>
					<td class="text-center"><c:out value="${boardManageList.updDate}" /></td>
				</tr>
			 	</c:forEach>
				<c:if test="${empty boardManageList }">
				<tr>
					<td class="nodata" colspan="5"><spring:message code="common.nodata.msg" /></td>
				</tr>	
				</c:if>               					 
				</tbody> 
				</table>
				<div class="row mgB30px">
					<div class="text-right">
						<button type="button" id="boardManageDelBtn" class="btn btn-danger">선택삭제</button>
						<button type="button" id="boardManageAddBtn" class="btn btn-primary">추가</button>
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
