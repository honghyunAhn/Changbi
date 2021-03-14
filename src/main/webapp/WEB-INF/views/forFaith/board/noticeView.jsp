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
<link href="<c:url value="/css/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/sbadmin2/metisMenu/metisMenu.min.css"/>"	rel="stylesheet"><!-- metisMenu css -->
<link href="<c:url value="/css/sbadmin2/sb-admin-2.css"/>" rel="stylesheet"><!-- custom css -->
<link href="<c:url value="/css/font-awesome/font-awesome.min.css"/>" rel="stylesheet" type="text/css"><!-- custom fonts -->

<script src="<c:url value="/js/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/moment.min.js"/>"></script><!-- moment javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/locales.min.js"/>"></script><!-- locales javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>"></script><!-- bootstrap-datetimepicker javascript -->
<script src="<c:url value="/js/sbadmin2/metisMenu/metisMenu.min.js"/>"></script><!-- metis menu plugin javascript -->
<script src="<c:url value="/js/sbadmin2/sb-admin-2.js"/>"></script><!-- custom theme javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script><!-- smarteditor javascript -->
<script src="<c:url value="/js/page/main.js"/>"></script>

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var editUrl	= "<c:url value='/board/boardEdit.do' />";
	var listUrl	= "<c:url value='/board/board.do' />";
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#editBtn").bind("click", function() {
		$("form[name='searchForm']").attr("action", editUrl);
		$("form[name='searchForm']").submit();
	});
	
	// 페이지 이벤트 등록(취소 버튼 클릭 시)
	$("#listBtn").bind("click", function() {
		// 폼 이동
		$("form[name='searchForm']").attr("action", listUrl);
		$("form[name='searchForm']").submit();
	});
});

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
		  <h1>게시물관리(상세)</h1>
		</div>

        <div class="panel panel-warning">
        	
        	<!-- searchForm 시작 -->
		  	<form name="searchForm" method="post">
			  	<!-- hidden 데이터 -->
		  		<input type='hidden' name='id' value='<c:out value='${board.id}' default="0" />' />		<!-- Id가 존재 하면 update 없으면 insert -->
				<!-- 조회조건 -->
				<input type='hidden' name='pageIndex' value='<c:out value="${search.pageIndex}" default="1" />' />
				<input type='hidden' name='boardId' value='<c:out value="${search.boardId}" default="" />' />
				<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
				<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			</form>
			<!-- //searchForm 종료 -->
				  	
			<table class="table dataTable table-bordered">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
            <tbody>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">게시판</td>
				<td class="text-center" colspan="3">
					<div role="tabpanel" id="boardpn" style="text-align:left">
						<c:forEach var="boardManageList" items="${boardManageList}" varStatus="status">
							 <c:if test="${boardManageList.boardId== board.boardId}">${boardManageList.koName}</c:if>
						</c:forEach>
					</div>
				</td>
			</tr>            
			<tr>
				<td class="text-center info" style="vertical-align: middle;">제목</td>
				<td class="text-center" colspan="3">
					<div role="tabpanel" id="boardpn" style="text-align:left">
						<c:out value="${board.title}" /><c:if test="${board.emergencyYn eq 'Y'}"><span style='color:#ff0000;'>(긴급공지)</span></c:if>
					</div>
				</td>
			</tr>
			<tr>	
				<td class="text-center info" style="vertical-align: middle;">작성자</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group">
					   		<c:out value="${board.name}" />			    	 
					   </div>
					</div>
				</td>
				<td class="text-center info" style="vertical-align: middle;">작성일시</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group">
					   		<fmt:parseDate var="dateString" value="${board.regDate}" pattern="yyyyMMddHHmmss" />
							<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />	    	
					   </div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">연락처</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group">
					   		<c:out value="${board.phone}" />			    	 
					   </div>
					</div>
				</td>
				<td class="text-center info" style="vertical-align: middle;">이메일</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group">
					   		<c:out value="${board.email}" />			    	 
					   </div>
					</div>
				</td>
			</tr>		
			<tr>
				<td class="text-center info" style="vertical-align: middle;">조회수</td>
				<td class="text-center">
					<div role="tabpanel" id="boardpn" style="text-align:left">
						조회수(<c:out value="${board.hits}" />)  추천(<c:out value="${board.recommend}" />)  비추천(<c:out value="${board.nonrecommend}" />)  공유(<c:out value="${board.share}" />)  
					</div>
				</td>
			</tr>											
			<tr>
				<td class="text-center info" style="vertical-align: middle;">내용</td>
				<td class="text-center" colspan="3">
					<div role="tabpanel" id="contents">
						<div class="tab-content" style="vertical-align: middle;text-align:left">
							<% pageContext.setAttribute("frontUrl", "/file_upload/"); %>
							${fn:replace(board.comment, frontUrl,'https://www.jejuolle.org/file_upload/')}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">첨부파일</td>
				<td colspan="3">
					<div class='attach_file_area' style="clear: both;">						
						<c:if test="${board.uploadFile ne null and board.uploadFile.detailList ne null and fn:length(board.uploadFile.detailList) > 0}">
							<c:forEach items="${board.uploadFile.detailList}" var="file" varStatus="status">
							<div class='file_info_area'>
								<div class='file_view' style='padding-left: 0px; padding-top: 5px;'>
									<c:out value="${file.originFileName}" />
								</div>
							</div>
							</c:forEach>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">관련코스</td>
				<td  colspan="3">
					<div class="form-inline">
						<div class="form-group">
							<c:forEach items="${board.contents.courseList}" var="relationCourse" varStatus="rcStatus">
		                		<c:set var="cids" value="${cids}[${relationCourse.course.id}]" /> <!-- ID를 []로 감싼다. -->
			                </c:forEach>
	
							<c:if test="${fn:contains(cids, '[0]')}">전체코스,</c:if>
							<c:forEach items="${courseList}" var="course" varStatus="courseStatus">
						   		<c:set var="checkId" value="[${course.id}]" />	<!-- ID에 []로 감싼다. -->
								<c:if test="${fn:contains(cids, checkId)}"><c:out value="${course.courseNum}" />,</c:if>
						    </c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">컨텐츠분류</td>
				<td  colspan="3">
					<div class="form-inline">
						<div class="form-group">
							<c:set var="types">N,C,S,E,T,P</c:set>
							<c:set var="typeNameList" value="${fn:split('알아두세요,코스정보,올레스토리,이벤트,이야기톡톡,프로모션', ',')}" />
							
							<c:forEach items="${board.contents.typeList}" var="type" varStatus="status">
			                	<c:set var="contentTypes" value="${contentTypes}${type.contentType}" />
			                </c:forEach>
			                
			                <c:forEach items="${fn:split(types,',')}" var="type" varStatus="typeStatus">
			                	<c:if test="${fn:contains(contentTypes, type)}"><c:out value="${typeNameList[(typeStatus.index)]}" />,</c:if> 
							</c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">관련축제</td>
				<td  colspan="3">
					<div class="form-inline">
						<div class="form-group">
							<c:forEach items="${board.contents.festivalList}" var="relationFestival" varStatus="rfStatus">
			                	<c:set var="fids" value="${fids}[${relationFestival.festival.id}]" /> <!-- ID를 []로 감싼다. -->
			                </c:forEach>
			                
			                <c:forEach items="${festivalList}" var="festival" varStatus="festivalStatus">
						   		<c:set var="checkId" value="[${festival.id}]" />	<!-- ID에 []로 감싼다. -->
								<c:if test="${fn:contains(fids, checkId)}"><c:out value="${festival.detail.title}" />,</c:if>
						    </c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">태그목록</td>
				<td  colspan="3">
					<ul class="list-inline" id="inlineList" style="margin: 10px 0 0 0">
						<c:forEach items="${board.tagList}" var="tag" varStatus="status">
							<c:if test="${tag ne null and tag.name ne null and tag.name ne ''}">
							<li class='mapping_data'>
								<span class="label label-default">
									<input type='hidden' name='tagList[<c:out value="${status.index}" />].name' value='<c:out value="${tag.name}" />' /><c:out value="${tag.name}" />
								</span>
							</li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
			</tr>
									
			</tbody>
			</table>
			
        </div>
		<div class="row mgB30px">
			<div class="col-lg-7 text-left">
<%-- 						<ui:pagination paginationInfo="" type="bootstrap" jsFunction="linkPage"/> --%>
			</div>
			<div class="col-lg-5 text-right">
				<button type="button" id="editBtn" class="btn btn-danger">수정</button>
				<button type="button" id="listBtn" class="btn btn-primary">취소</button>
			</div>
		</div>	
	
	</div>
	<!-- /#page-wrapper -->
	
</div>
<!-- /#wrapper -->
 
</body>

</html>