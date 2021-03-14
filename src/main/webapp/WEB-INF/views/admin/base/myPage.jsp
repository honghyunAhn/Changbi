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

<title>마이페이지</title>
<link href="<c:url value="/css/page/styles.css"/>" rel="stylesheet">
<link href="<c:url value="/css/bootstrap/bootstrap.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/sbadmin2/metisMenu/metisMenu.min.css"/>"	rel="stylesheet"><!-- metisMenu css -->
<link href="<c:url value="/css/sbadmin2/sb-admin-2.css"/>" rel="stylesheet"><!-- custom css -->
<link href="<c:url value="/css/font-awesome/font-awesome.min.css"/>" rel="stylesheet" type="text/css"><!-- custom fonts -->
<link href="<c:url value="/css/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>"rel="stylesheet"><!-- bootstrap-datetimepicker css -->

<script src="<c:url value="/js/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/moment.min.js"/>"></script><!-- moment javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/locales.min.js"/>"></script><!-- locales javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>"></script><!-- bootstrap-datetimepicker javascript -->
<script src="<c:url value="/js/sbadmin2/metisMenu/metisMenu.min.js"/>"></script><!-- metis menu plugin javascript -->
<script src="<c:url value="/js/sbadmin2/sb-admin-2.js"/>"></script><!-- custom theme javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script><!-- smarteditor javascript -->
<script src="<c:url value="/js/jquery/jquery.MultiFile.js"/>"></script><!-- multifile upload -->
<script src="<c:url value="/js/page/main.js"/>"></script>

<!-- 내부 자바스크립트 -->
<script src='<c:url value="/js/com/commonFunc.js" />'></script>
<script src='<c:url value="/js/com/commonObj.js" />'></script>
<script src='<c:url value="/js/com/commonFile.js" />'></script>

<!-- 내부 프로젝트 자바스크립트 -->
<script src='<c:url value="/js/project/jejuolle.js" />'></script>

<!-- Daum 우편번호 서비스 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var regUrl = "<c:url value='/forFaith/base/myPageReg' />";
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").bind("click", function() {
		// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
		/* $("textarea.editor").each(function(i) {
			var editor_id = $("textarea.editor").eq(i).attr("id");
		
			editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
		}); */
		
		if($(":password[name='userPw']").val() && ($(":password[name='userPw']").val() != $(":password[name='reUserPw']").val())) {
			alert("비밀번호와 비밀번호 확인이 다릅니다.");
			
			$(":password[name='reUserPw']").val("");
			$(":password[name='reUserPw']").focus();
		} else if(!$(":text[name='userName']").val()) {
			alert("이름을 입력하세요.")
			
			$(":text[name='userName']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			$("form[name='actionForm']").attr("action", regUrl);
			$("form[name='actionForm']").submit();
		}
	});
});
 
</script>
</head>

<body>

<div id="wrapper" style="width: 80%;">

	<!-- Navigation -->
	<!-- // Navigation -->

    <div id="page-wrapper">
    	<ol class="breadcrumb" style="background-color:#fff">
			<!-- <li><a href="#">Home</a></li>
			<li><a href="#">Library</a></li>
			<li class="active">Data</li> -->
		</ol>
		<div class="page-header">
		  <h1>마이페이지</h1>
		</div>

        <div class="panel panel-warning">
		  	<!-- actionForm 시작 -->
		  	<form name="actionForm" method="post" role="form">
		  	
			  	<!-- hidden 데이터 -->
		  		<input type='hidden' name='id' value='<c:out value='${manager.id}' default="0" />' />		<!-- Id가 존재 하면 update 없으면 insert -->
		  		
		  		<!-- 부서 코드 저장 -->
		  		<input type='hidden' name='deptCode.id' value='<c:out value="${manager.deptCode.id}" />' />
		  		
		  		<!-- 관리자 등급 저장 -->
		  		<input type='hidden' name='level' value='<c:out value="${manager.level}" />' />
		  		
		  		<!-- 문의 구분 데이터 리스트(콤마로 구분) -->
		  		<input type='hidden' name='noticeCodes' value='<c:out value='${manager.noticeCodes}' />' />
		  		<!-- 봉사 구분 데이터 리스트(콤마로 구분) -->
		  		<input type='hidden' name='serviceCodes' value='<c:out value='${manager.serviceCodes}' />' />

				<table class="table dataTable table-bordered">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
	            <tbody>
	            <tr>
					<td class="text-center info" style="vertical-align: middle;">관리자 구분</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
						<c:forEach items="${deptCodeList}" var="deptCode" varStatus="status">
							<c:if test="${deptCode.id == manager.deptCode.id}">
								<input type='text' class='form-control' value='<c:out value="${deptCode.koName}" />' readonly='readonly' />
							</c:if>
						</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">관리자 등급</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
						<c:choose>
							<c:when test="${manager.level eq '9'}"><input type='text' class='form-control' value='최고관리자' readonly='readonly' /></c:when>
							<c:otherwise><input type='text' class='form-control' value='일반관리자' readonly='readonly' /></c:otherwise>
						</c:choose>
						</div>
					</td>
				</tr>
	            <tr>
					<td class="text-center info" style="vertical-align: middle;">아이디</td>
					<td>
						<div class="col-lg-3" style="padding : 0;">
							<input type='text' class='form-control' id='' name='userId' value='<c:out value="${manager.userId}" />' readonly='readonly' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">비밀번호</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
							<input type='password' class='form-control' id='' name='userPw' value='' placeholder='비밀번호를 입력하세요' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">비밀번호 확인</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
							<input type='password' class='form-control' id='' name='reUserPw' value='' placeholder='비밀번호를 입력하세요' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">이름</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
							<input type="text" class="form-control" id="" name='userName' value='<c:out value="${manager.userName}" />' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">이메일</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
							<input type="text" class="form-control" id="" name='email' value='<c:out value="${manager.email}" />' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">휴대전화</td>
					<td class="text-center">
						<div class="col-lg-3" style="padding : 0;">
							<input type="text" class="form-control" id="" name='phone' value='<c:out value="${manager.phone}" />' />
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">문의구분 매칭</td>
					<td>
						<div class="form-group">
							<c:forEach items="${noticeCodeList}" var="noticeCode" varStatus="status">
							   	<div class="checkbox" >
							   	<c:forEach items="${fn:split(manager.noticeCodes, ',')}" var="managerNoticeCode">
							   		<c:if test="${managerNoticeCode eq noticeCode.id}">
							   			<c:out value="${noticeCode.koName}" /><br />
							   		</c:if>
							   	</c:forEach>
						    	</div>
					    	</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">봉사분야 매칭</td>
					<td>
						<div class="form-group">
							<c:forEach items="${serviceCodeList}" var="serviceCode" varStatus="status">
							   	<div class="checkbox" >
						   		<c:forEach items="${fn:split(manager.serviceCodes, ',')}" var="managerServiceCode">
						   			<c:if test="${managerServiceCode eq serviceCode.id}">
						   				<c:out value="${serviceCode.koName}" /><br />
						   			</c:if>
						   		</c:forEach>
						    	</div>
					    	</c:forEach>
						</div>
					</td>
				</tr>
				</tbody>
				</table>
				
			</form>
			<!-- //actionForm 종료 -->
			
        </div>
        
		<div class="row mgB30px">
			<div class="col-lg-12 text-right">
				<button type="button" id="regBtn" class="btn btn-danger">저장</button>
			</div>
		</div>
	</div>
	<!-- /#page-wrapper -->
	
</div>
<!-- /#wrapper -->

</body>
</html>
