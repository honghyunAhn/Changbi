<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<style>
.fa-caret-down {
	cursor: pointer;
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
					console.log(result.list);
					var content = '';
					if(result.list != null && result.list.length != 0) {
						$.each(result.list, function(index,data) {
							content += '<tr>';
							content += '<input type="hidden" value="'+data.CONSULTING_SEQ+'"/>';
							content += '<td style="text-align: center;">'+(index + 1)+'</td>';
							content += '<td style="text-align: center;">'+data.CONSULTING_TITLE+'</td>';
							content += '<td style="text-align: center;">'+data.CONSULTING_INS_ID+'</td>';
							content += '<td style="text-align: center;">'+data.CONSULTING_HIT+'</td>';
							content += '<td style="text-align: center;">'+getDateFormat(data.CONSULTING_INS_DT)+'</td>';
							content += '<td style="text-align: center;">'+getDateFormat(data.CONSULTING_UDT_DT)+'</td>';
							content += '<td style="text-align: center;">';
							if(data.CONSULTING_OPEN == 0){
								content += '공개';
							}else {
								content += '비공개';
							}
							content += '</td>';
							content += '<td style="text-align: center;">';  
							if(data.CONSULTING_CHECK == 0){
								content += '공개';
							}else if(data.CONSULTING_CHECK == 1){
								content += '비공개';
							} else{
								content += '답변완료';
							}
							content += '</td>';
							content += '</tr>';
						});
					} else {
						content += '<tr><td colspan="10">조회된 결과가 없습니다.</td></tr>';
					}
					$('#dataListBody').html(content);
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
		
		/** 이벤트 영역 **/
		// 검색 버튼 클릭 시
		$("#searchBtn").unbind("click").bind("click", function() {
			// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
			setContentList(1);
		});
		
		//검색어 치고 엔터 눌렀을 때
		$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
			if(event.keyCode === 13) {
				$("#searchBtn").trigger("click");
			}
		});
		
		
	});
	
	var trOnclick = $("#dataListBody tr");
	trOnclick.click(function(){
		var params = $('form[name=searchForm]').serializeObject();
		var consulting_seq = $(this).children("input[type=hidden]").val();
		alert(consulting_seq);
		params.consulting_seq = consulting_seq;
		contentLoad('온라인 상담 상세',editUrl, params);
	});
	
	$('#addBtn').on('click', function(){
		var params = {"consulting_seq" : 0};
		contentLoad('온라인 상담 작성',editUrl, params);
	});
	$('#searchBtn').on('click', function() {
		var params = $('form[name=searchForm]').serializeObject();
		console.log(params);
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
								<option value='all'>전체</option>
								<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
								<option value='content' <c:if test="${search.searchCondition eq 'content'}">selected</c:if>>내용</option>
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
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th style="width :5%;">번호</th>
				<th style="width :34%;">제목</th>
				<th style="width :7%;">작성자</th>
				<th style="width :5%;">조회수</th>
				<th style="width :13%;">작성일 <i class="fa fa-caret-down" aria-hidden="true"></i></th>
				<th style="width :13%;">수정일 <i class="fa fa-caret-down" aria-hidden="true"></i></th>
				<th style="width :7%;">공개여부 <i class="fa fa-caret-down" aria-hidden="true"></i></th>
				<th style="width :7%;">처리상태 <i class="fa fa-caret-down" aria-hidden="true"></i></th>
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