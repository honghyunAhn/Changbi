<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<style>
.fa-caret-down {
	cursor: pointer;
}
.consultinglist {
	cursor: pointer;
}
.dataListBody tr:hover {
	background-color: #f5f5f5;
}
</style>
<script type="text/javascript">
	//변수
	var dataListUrl = "<c:url value='/data/board/onlineConsultingList' />";
	var onlineadviceUrl = '<c:url value="/admin/board/onlineConsulting"/>';
	var editUrl = '<c:url value="/admin/board/onlineConsultingEdit"/>';
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	$(document).ready(function(){

		function setContentList(pageNo) {
			// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
			pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
			
			// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
			$(":hidden[name='pageNo']").val(pageNo);
			
			var params = $('form[name=searchForm]').serializeObject();
			
			$.ajax({
				type	: "post",
				url		: dataListUrl,
				data 	: params,
				async: false,
				success	: function(result) {
					var content = '';
					if(result.list != null && result.list.length != 0) {
						$.each(result.list, function(index,data) {
							content += '<tr onclick="onlineConsultingEdit('+data.CONSULTING_SEQ+')">';
							content += '<input type="hidden" value="'+data.CONSULTING_SEQ+'"/>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+(index + 1)+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+data.CONSULTING_TITLE+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+data.CONSULTING_INS_ID+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+data.CONSULTING_HIT+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+getDateFormat(data.CONSULTING_INS_DT)+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">'+getDateFormat(data.CONSULTING_UDT_DT)+'</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">';
							if(data.CONSULTING_OPEN == 0){
								content += '공개';
							}else {
								content += '비공개';
							}
							content += '</td>';
							content += '<td class="consultinglist" style="text-align: center; border-right: none;">';  
							if(data.CONSULTING_CHECK == 0){
								content += '삭제글';
							}else if(data.CONSULTING_CHECK == 1){
								content += '답변대기';
							} else{
								content += '답변완료';
							}
							content += '</td>';
							content += '</tr>';
						});
					} else {
						content += '<tr><td colspan="10">조회된 결과가 없습니다.</td></tr>';
					}
					$('.dataListBody').html(content);
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
		
		// 컨텐츠 타이틀
		$('.content_wraper').children('h3').eq(0).html($('title').text());
		
		// 검색 버튼 클릭 시
		$("#searchBtn").unbind("click").bind("click", function() {
			// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
			setContentList(1);
		});
		
		//검색어 치고 엔터 눌렀을 때
		$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
			console.log(event);
			if(event.keyCode === 13) {
				$("#searchBtn").trigger("click");
			}
		});
		
	});
	
	/** 이벤트 영역 **/
	function onlineConsultingEdit(consulting_seq){
		var params = $('form[name=searchForm]').serializeObject();
		params.consulting_seq = consulting_seq;
		contentLoad('온라인 상담 상세',editUrl, params);
	};

	$('#searchBtn').on('click', function() {
		var params = $('form[name=searchForm]').serializeObject();
		contentLoad('온라인 상담 검색',onlineadviceUrl, params);
	});
	
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
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<select id="searchCondition" name="searchCondition">
								<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
							</select>
				
							<input type="text" placeholder="검색어입력" id="searchKeyword" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
		       		<tr>
		        		<td class="buttonTd" colspan="2">
		        			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		        		</td>
		        	</tr>
	        	</table>
	        </div>
	        <!-- 페이징 처리여부 -->
        	<input type="hidden" name="pagingYn" value="Y" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse; border: none;">
			<thead>
			<tr>
				<th style="width :5%; border-right: none;">번호</th>
				<th style="width :43%; border-right: none;">제목</th>
				<th style="width :7%; border-right: none;">작성자</th>
				<th style="width :5%; border-right: none;">조회수</th>
				<th style="width :13%; border-right: none;">작성일</th>
				<th style="width :13%; border-right: none;">수정일 </th>
				<th style="width :7%; border-right: none;">공개여부</th>
				<th style="width :7%; border-right: none;">처리상태</th>
			</tr>
			</thead>
			<tbody id="topDataListBody"></tbody>
			<tbody class="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
	</div>
</div>