<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript">

$(document).ready(function(){
	// 최초 호출 시(페이지 번호와 검색 조건, 검색 키워드를 세팅한다)
	var pageNo = $(":hidden[name='pageNo']").val();
	var searchCondition = $(":hidden[name='searchCondition']").val();
	var searchKeyword = $(":hidden[name='searchKeyword']").val();
	
	// 첫 화면 호출 시(검색 조건 및 키워드를 세팅한다)
	$("#searchCondition").val(searchCondition);
	$("#searchKeyword").val(searchKeyword);
	
	setContentsList(pageNo);
});

</script>

<table class="bbs">
	<colgroup>
		<col class="num" width="70">
		<col class="title" width="">
		<col class="writer" width="100">
		<col class="hit" width="70">
		<col class="datetime" width="150">
	</colgroup>
	<thead>
	<tr>
		<th class="num" scope="col">No.</th>
		<th class="title" scope="col"><spring:message code='text.title'/></th>
		<th class="writer" scope="col"><spring:message code='text.writer'/></th>
		<th class="hit" scope="col"><spring:message code='text.inquire'/></th>
		<th class="datetime" scope="col"><spring:message code='text.writeDate'/></th>
	</tr>
	</thead>
	<tbody></tbody>
</table>

<!-- 페이지 네비게이션 -->
<div class="page-nav"></div><!--//.page-nav-->

<!-- 검색 조건 -->
<div class="search-form">
	<label for="searchCondition" class="sr-only"></label>
	<select id="searchCondition" name="searchCondition">
		<option value=''><spring:message code='text.total'/></option>
		<option value='title'><spring:message code='text.title'/></option>
		<option value='contents'><spring:message code='text.content'/></option>
		<option value='writer'><spring:message code='text.writer'/></option>
	</select>
	<input type="text" id='searchKeyword' name='searchKeyword' placeholder="<spring:message code='text.search'/>">
	<button type="button" class="btn" id='searchBtn' name='searchBtn'><spring:message code='button.search'/></button>
</div>