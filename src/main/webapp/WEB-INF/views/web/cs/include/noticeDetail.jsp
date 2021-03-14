<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="bbs-view">
	<div class="bbs-view-header">
		<span>[<spring:message code='text.notice'/>]</span>
		<h3 class="bbs-view-title"><c:out value="${noticeInfo.getTitle(localeLanguage)}" /></h3>
	</div><!--//bbs-view-header-->
	<div class="bbs-view-info">
		<p>
			<span class="writer"><c:out value="${noticeInfo.writer}" /></span>
			<span class="datetime"><c:out value="${noticeInfo.regDate}" /></span>
			<span class="hit"><spring:message code='text.inquire'/> : <c:out value="${noticeInfo.cnt}" /></span>
		</p>
	</div><!--//.bbs-view-info-->
	<div class="bbs-view-body">
		<c:out value="${noticeInfo.getComment(localeLanguage)}" />
	</div><!--//.bbs-view-body-->   
	<div class="bbs-footer">
		<a class="btn" href="javascript:void(0);" id='listBtn'><spring:message code='button.list'/></a>
	</div>
</div><!--//.bbs-view-->