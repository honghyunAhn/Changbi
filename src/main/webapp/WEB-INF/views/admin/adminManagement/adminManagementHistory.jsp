<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var datalistUrl = "<c:url value='/data/adminManagement/adminList' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		var params = $('form[name=searchForm]').serializeObject();
		
		var content = '';
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: datalistUrl,
			data 	: params,
			success	: function(result) {
				console.log(result);
				
				$.each(result.list, function(index, item) {
					content += '<tr>';
					content +=		'<td>' + (index + 1) + '</td>';
					content +=		'<td>' + item.id + '</td>';
					switch(item.grade) {
					case 9:
						content += 		'최고관리자';
						break;
					case 1:
						content += 		'일반관리자';
						break;
					}
					content += 		'</td>';
					content += 		'<td>';
					switch(item.useYn) {
					case 'Y':
						content += 		'사용';
						break;
					case 'N':
						content += 		'비사용';
						break;
					}
					content += 		'</td>';
					if(item.regUser != null && item.updUser != null) {
						content +=		'<td>' + item.regUser.id + '</td>';
						content +=		'<td>' + item.regDate + '</td>';
						content +=		'<td>' + item.updUser.id + '</td>';
						content +=		'<td>' + item.updDate + '</td>';
					} else {
						content += 	'<td colspan="4"></td>';
					}
					content += '</tr>';
				});
				
				$("#dataListBody").html(content);
				
				// 페이징 처리
				pagingNavigation.setData(result);	// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
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
                <th>권한</th>
				<th>생성자</th>
				<th>생성일</th>
				<th>권한부여자</th>
				<th>권한수정일</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>