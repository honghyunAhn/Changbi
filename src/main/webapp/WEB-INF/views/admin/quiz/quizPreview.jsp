<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>[팝업] 미리보기</title>

<link href="/resources/css/project/admin/preview.css" rel="stylesheet" type="text/css">
<!--[if lte IE 9]><script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script><![endif]-->
<!--[if (gt IE 9) | (!IE)]><!--><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script><!--<![endif]--> 
<script type="text/javascript">
/*
$(function () {
	// 온라인 시험 단답문제 체크 효과
	$(".question-list .item-body input[type=radio]").click(function(){
		$(this).parent('label').parent('li').parent('ol').children().removeClass("check");
		$(this).parent('label').parent('li').addClass("check");
	});
	
	$(".question-list .item-body input[type=checkbox]").click(function(){
		$(this).parent('label').parent('li').toggleClass("check");
	});
});
*/
</script>
</head>

<body>
<!-- 1.페이지 -->
<!--// 2.팝업 -->
<div class="popup-header">
	<h3 class="popup-title"><c:out value="${quizPool.title}" default="" /></h3>
</div>
<div class="popup-body">
	<form>
		<ol class="question-list">
			<c:forEach items="${quizPool.quizItemList}" var="quizItem" varStatus="status">
			<c:if test="${quizItem.id > 0}">
			<li>
				<div class="item-header"><c:out value="${quizItem.quizBank.title}" default="" escapeXml="false" /></div>
				<c:choose>
					<c:when test="${quizItem.quizBank.osType eq 'O'}">
					<ol class="item-body">
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam1}" default="보기1" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam2}" default="보기2" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam3}" default="보기3" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam4}" default="보기4" /></label></li>
						
						<c:if test="${quizItem.quizBank.examType eq '2'}">
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam5}" default="보기5" /></label></li>
						</c:if>
					</ol>
					</c:when>
					<c:otherwise>
					<div class="item-body">
						<div class="html-view"><c:out value="${quizItem.quizBank.comment}" default="" escapeXml="false" /></div>
						<textarea></textarea>
					</div>
					</c:otherwise>
				</c:choose>
			</li>
			</c:if>
			</c:forEach>
		</ol>
		<!-- <div class="list-bottom alignC">
			<button class="btn primary w5em">제출</button>
			<button class="btn w5em btn-closePopup">취소</button>
		</div> -->
	</form>
</div><!--//.popup-body-->
</body>
</html> 