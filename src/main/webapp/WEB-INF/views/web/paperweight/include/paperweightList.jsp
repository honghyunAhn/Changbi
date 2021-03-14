<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- 1.2.3.1 서브-헤더 -->
<div class="sub-header">
	<h2 class="sub-title"><spring:message code='main.menu.onlinepw'/></h2>
	<p><spring:message code='main.menu.explain.onlinepw'/></p>
</div>

<!-- 1.2.3.2 서브-본문 Tab  -->
<div class="sub-body">
	<h3 class="section-title center"><spring:message code='text.medicalExam'/></h3>
	<p class="section-title-subscript center"><spring:message code='text.explain.medicalExam'/></p>
	<div class="flex-btn-group" id='paperweightList'>
	<c:forEach items="${gubunList}" var="gubun" varStatus="status">
		<a href="javascript:void(0);" class="btn">
			<input type='hidden' name='hiddenId' value='<c:out value="${gubun.idx}" />' />
			<c:out value="${gubun.getName(localeLanguage)}" />
		</a>
	</c:forEach>
	</div>
</div><!--//.sub-body#pw_user-->