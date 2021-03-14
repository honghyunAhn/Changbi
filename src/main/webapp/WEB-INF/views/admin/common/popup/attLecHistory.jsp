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

<title>수강이력조회</title>

<script type="text/javascript">
$(function(){
	/** 함수 영역 **/
	
	/** 이벤트 영역 **/
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<!-- view start -->
			<table style="border-collapse: collapse;">
				<thead>
				<tr>
					<th>차시</th>
					<th>총시간(분)</th>
					<th>시작시각</th>
					<th>종료시각</th>
					<th>수강횟수</th>
				</tr>
				</thead>
				<tbody>
					<c:set var="totalLearnTime" value="0" />
					<c:set var="totalHistory" value="0" />
					
					<c:forEach items="${attLecList}" var="attLec">
						<c:if test="${!empty attLec.id}">
						
						<fmt:parseNumber var="totalLearnTime" type="number" value="${totalLearnTime + attLec.learnTime}" />
						<fmt:parseNumber var="totalHistory" type="number" value="${totalHistory + fn:length(attLec.historyList)}" />
						
						<tr>
							<td><c:out value="${attLec.chasi}" default="" />차시</td>
							<td><c:out value="${attLec.learnTime / 60}" default="0" />분(<c:out value="${attLec.learnTime}" default="0" />초)</td>
							<td>
								<c:forEach items="${attLec.historyList}" var="history">
									<fmt:parseDate var="dateString" value="${history.startDate}" pattern="yyyyMMddHHmmss" />
									<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" /><br />
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${attLec.historyList}" var="history">
									<fmt:parseDate var="dateString" value="${history.endDate}" pattern="yyyyMMddHHmmss" />
									<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" /><br />
								</c:forEach>
							</td>
							<td><c:out value="${fn:length(attLec.historyList)}" default="0" />회</td>
						</tr>
						</c:if>
					</c:forEach>
					
					<tr>
						<td>합계</td>
						<td colspan="4">총 수강 <c:out value="${totalLearnTime / 60}" default="0" />분 / <c:out value="${totalHistory}" default="0" />회 접속</td>
					</tr>
					
				</tbody>
		</table>
		</form>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>