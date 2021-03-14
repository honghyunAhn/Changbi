<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">
	
	//변수
	var dataListUrl = "<c:url value='/data/board/faqList' />";
	var listPageUrl = '<c:url value="/admin/board/faqList"/>';
	var editUrl = '<c:url value="/admin/board/faqEdit"/>';
	var list; //리스트 담는 변수
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	$(document).ready(function(){
		setContent();
		
		//이벤트 영역
		setEvent();
	});
	
	//컨텐츠 세팅
	function setContent() {
		getList();
		setTableContent();
		pagingFunc();
	}
	//faq리스트
	function getList() {
		var params = $('form[name=searchForm]').serializeObject();
		$.ajax({
			type	: "post",
			url		: dataListUrl,
			data 	: params,
			async: false,
			success	: function(result) {
				list=result;
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	//table 내용 세팅
	function setTableContent() {
		var content = '';
		if(list != null && list.length != 0) {
			$.each(list, function(index,item) {
				content += '<tr>';
				content += 		'<td>' +(index + 1);
				content += 			'<input type="hidden" name="seq" value="'+item.CONSULTING_SEQ+'"></td>';
				content += 		'<td>';
				switch(item.CONSULTING_TP) {
				case 'A0505':
					content += '두잇캠퍼스';
					break;
				case 'A0506':
					content += '레인보우';
					break;
				}
				content += 		'</td>';
				content += 		'<td>';
				switch(item.CONSULTING_TYPE) {
				case '001':
					content += '과정문의';
					break;
				case '002':
					content += '학습문의';
					break;
				case '003':
					content += '시스템문의';
					break;
				case '004':
					content += '결제문의';
					break;
				}
				content += 		'</td>';
				content += 		'<td class="detailTd">' + item.CONSULTING_TITLE + '</td>';
				content += 		'<td>' + item.NAME + '</td>';
				content += 		'<td>' + getDateFormat(item.CONSULTING_INS_DT) + '</td>';
			});
		} else {
			
		}
		$('#dataListBody').html(content);
	}
	//dto를 쓰지않아서 commonObj.js에 정의된 형식에 맞춰서 직접 값 세팅
	function pagingFunc() {
		// 페이징 처리
		var obj = new Object();
		obj.list = list;
		obj.pageNo = $('input[name=pageNo]').val();
		obj.totalCount = list.length;
		pagingNavigation.setData(obj);				// 데이터 전달
		// 페이징(콜백함수 숫자 클릭 시)
		pagingNavigation.setNavigation(setContent);
	}
	//이벤트 연결
	function setEvent() {
		$('.detailTd').on('click', function(){
			var seq = $(this).closest('tr').find('td:eq(0) > input[name=seq]').val();
			var params = $('form[name=searchForm]').serializeObject();
			params.consulting_seq = seq;
			contentLoad('FAQ상세',editUrl, params);
		});
		$('#addBtn').on('click', function(){
			var params = {"consulting_seq" : 0};
			contentLoad('FAQ작성',editUrl, params);
		});
		$('#searchBtn').on('click', function() {
			var params = $('form[name=searchForm]').serializeObject();
			contentLoad('FAQ검색',listPageUrl, params);
		});
		//검색어 치고 엔터 눌렀을 때
		$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
			if(event.keyCode === 13) {
				$("#searchBtn").trigger("click");
			}
		});
	}
	//timestamp -> date 형식 바꿔주는 함수
	function getDateFormat(timestamp) {
		
		var dateVal = new Date(timestamp);
		var year = dateVal.getFullYear();
		var month = dateVal.getMonth() + 1;
		var day = dateVal.getDate();
		var time = dateVal.getHours();
		var min = dateVal.getMinutes();
		var sec = dateVal.getSeconds();
		var formattedVal = year + '-' + month + '-' + day + ' ' + time + ':' + min + ':' + sec;
		
		return formattedVal;
	}
</script>

<div class="content_wraper">
	<h3>FAQ 관리</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<select id="searchCondition" name="searchCondition">
								<option value='all'>전체</option>
								<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
								<option value='content' <c:if test="${search.searchCondition eq 'content'}">selected</c:if>>내용</option>
							</select>
				
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
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>위치</th>
				<th>구분</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			</thead>
			<tbody id="topDataListBody"></tbody>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary">신규등록</a>
		</div>
	</div>
</div>