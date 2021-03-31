<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var datalistUrl = "<c:url value='/data/adminManagement/adminHistory' />";
})
</script>
<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
		       		<tr>
		        		<td class="buttonTd" colspan="2">
		        			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		        		</td>
		        	</tr>
	        	</table>
	        </div>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
				<th>상태</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>