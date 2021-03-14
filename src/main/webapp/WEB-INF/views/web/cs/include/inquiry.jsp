<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<form class="bbs-form" name="bbsForm">
	<!-- 입력 타입을 Q(문의하기)로 지정 -->
	<input type='hidden' name='type' value='Q' />
	
	<!-- 타이틀 입력 시 언어별로 모두 입력함. -->
	<input type='hidden' name='koTitle' />
	<input type='hidden' name='enTitle' />
	<input type='hidden' name='zhTitle' />
	<input type='hidden' name='jaTitle' />
	<input type='hidden' name='ruTitle' />
	
	<!-- 문의내용 입력 시 언어별로 모두 입력함. -->
	<input type='hidden' name='koComment' />
	<input type='hidden' name='enComment' />
	<input type='hidden' name='zhComment' />
	<input type='hidden' name='jaComment' />
	<input type='hidden' name='ruComment' />
	
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.inquiryDiv'/></strong>
			<select name="gubun.idx">
			<c:forEach items="${gubunList}" var="gubun" varStatus="status">
				<option value='<c:out value="${gubun.idx}" />'><c:out value="${gubun.getName(localeLanguage)}" /></option>
			</c:forEach>
			</select>
		</label>
	</p>
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.title'/></strong>
			<input type="text" size="100" name='title' placeholder="<spring:message code='text.title'/>">
		</label>
	</p>
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.writer'/></strong>
			<input type="tel" name='writer' placeholder="<spring:message code='text.writer'/>">
		</label>
	</p>
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.tel'/></strong>
			<input type="tel" name='phone' placeholder="<spring:message code='text.phone'/>">
		</label>
	</p>
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.email'/></strong>
			<input type="email" name='email' placeholder="<spring:message code='text.email'/>">
		</label>
	</p>
	<p class="row-group">
		<label>
			<strong class="row-group-label"><spring:message code='text.inquiryContent'/></strong>
			<textarea rows="10" cols="30" name='comment' placeholder="<spring:message code='text.inquiryContent'/>"></textarea>
		</label>
	</p>
	<div class="bbs-footer">
		<button type="button" class="btn impt" id='inquiryBtn' style="cursor: pointer;"><spring:message code='text.inquiry'/></button>
	</div> 
</form>