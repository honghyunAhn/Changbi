<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

var listUrl = "<c:url value='/admin/common/emailList'/>";
var detailUrl = "<c:url value='/admin/common/mailHistoryDetail'/>";
var pagingNavigation = new PagingNavigation($(".pagination"));

$(document).ready(function () {
	$('#searchBtn').on('click', function() {
		setContentList();
	});
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	$('#numOfRows').on('change', function() {
		$(':hidden[name=numOfRows]').val($(this).val());
		$("#searchBtn").trigger('click');
	});
	
	$('#dataListBody').on('click', ".title", function(){
 		var mail_seq = $(this).closest("tr").find("td:eq(0)").find("input.mail_seq").val();
		var tag = '<input type="hidden" value="'+ mail_seq +'" name="mail_seq">';
		var pageNo = $('input[name="pageNo"]').val();
		var numOfRows = $('input[name="numOfRows"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('select[name="searchCondition"]').val();
		var start_date = $('input[name="start_date"]').val();
		var end_date = $('input[name="end_date"]').val();
		
		tag += '<input type="hidden" value="'+ searchCondition +'" name="searchCondition">';
		tag += '<input type="hidden" value="'+ searchKeyword +'" name="searchKeyword">';
		tag += '<input type="hidden" value="'+ pageNo +'" name="pageNo" default="1">';
		tag += '<input type="hidden" value="'+ numOfRows +'" name="numOfRows" default="10">';
		tag += '<input type="hidden" value="'+ start_date +'" name="start_date">';
		tag += '<input type="hidden" value="'+ end_date +'" name="end_date">';
		tag += '<input type="hidden" value="Y" name="pagingYn">';
		$('#mailDetailForm').html(tag);
		contentLoad("상세정보조회", detailUrl, $('#mailDetailForm').serialize());
	});
	setContentList(1);
})
//함수영역

function setContentList(pageNo) {
	// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
	pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
	
	// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
	$(":hidden[name='pageNo']").val(pageNo);
	
	// ajax 처리
 	$.ajax({
		type	: "post",
		url		: listUrl,
		data 	: $("form[name='searchForm']").serialize(),
		success	: function(result){
			var sb = new StringBuilder();
			if(result.list && result.list.length > 0) {
				$('#totalCntLabel').html('Total: '+ result.totalCount +' 건');
				
				var dataList = result.list;
				var pageNo		= result.pageNo		? result.pageNo		: 1;
				var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
				
				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var sms_seq = dataInfo.MAIL_SEQ;
					sb.Append('<tr>');
					sb.Append('<td>' + (i+1));
					sb.Append('<input type="hidden" class="mail_seq" value="'+ dataInfo.MAIL_SEQ +'"/>');
					sb.Append('</td>');
					sb.Append('<td class="title" style="cursor:pointer; color: #0000ff">'+ dataInfo.SEND_TITLE +'</td>');
					sb.Append('<td>'+ dataInfo.SEND_NAME +'</td>');
					sb.Append('<td>'+ dataInfo.MAIL_INS_DATE +'</td>');
					sb.Append('<td>');
					sb.Append('<input type="button" class="btn btn-primary" name="detailBtn" value="명단보기">');
					sb.Append('</td>');
				}
			} else {
				sb.Append('<td colspan="9">조회 결과가 없습니다.</td>');
			}
			$('#dataListBody').html(sb.ToString());
			// 페이징 처리
			pagingNavigation.setData(result);// 데이터 전달
			// 페이징(콜백함수 숫자 클릭 시)
			pagingNavigation.setNavigation(setContentList);
			showSendResult();
		}
	});
}
//checkbox 체크한 행의 색깔 바꾸기
function changeTrColor(obj){
	if($(obj).prop("checked"))
		$(obj).closest('tr').css("background-Color","#E0E0E0");
	else
		$(obj).closest('tr').css("background-Color","");
}
//전송결과 조회 api 요청
function showSendResult() {
	$('input[name="detailBtn"]').on('click', function() {
		var mail_seq = $(this).closest("tr").find("td:eq(0)").find("input.mail_seq").val();
				
		$.ajax({
			type	: "post",
			url		: '/admin/common/mailDetail',
			dataType : "json",
			data 	: {
				"mail_seq" : mail_seq
			},
			success	: function(result) {
				
				var data = new Object();
				data.list = JSON.stringify(result.list);
				openLayerPopup('MAIL 상세내역 조회','/admin/common/popup/mailDetail', data);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	})
}

</script>

<div class="content_wraper" id="modalsContentss">
	<h3>전송결과 조회</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>기간선택</th>
	        			<td>
	        				<input type="date" name="start_date" max="9999-12-31" value="${search.start_date}" style="width: 192px;"><span>~</span>
	        				<input type="date" name="end_date" max="9999-12-31" value="${search.end_date}" style="width: 192px;">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<select class="searchConditionBox" name="searchCondition">
								<option value='0' <c:if test="${search.searchCondition eq '0'}">selected</c:if>>전체</option>
								<option value='1' <c:if test="${search.searchCondition eq '1'}">selected</c:if>>발송자</option>
								<option value='2' <c:if test="${search.searchCondition eq '2'}">selected</c:if>>제목</option>
								<option value='3' <c:if test="${search.searchCondition eq '3'}">selected</c:if>>내용</option>
							</select>
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
		        	<tr>
		        		<td class="buttonTd" colspan="2">
		        			<a id='searchBtn' class="btn btn-primary" type="button" style="vertical-align: bottom; width: 300px;">조회</a>
		        		</td>
	        		</tr>
       			</table>
       		</div>
       		<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<!-- n개씩 조회 -->
        	<input type="hidden" name="numOfRows" value='<c:out value="${search.numOfRows}" default="10" />' />
       		<!-- 페이징 처리 -->
        	<input type="hidden" name="pagingYn" value='Y' />
		</form>
		<div style="float: left;"><label id="totalCntLabel"></label></div>
		<div style="margin-bottom: 10px; text-align: right;">
			<select class="selector" name="numOfRows" id="numOfRows">
				<option value="10" selected>10개씩</option>
				<option value="50">50개씩</option>
				<option value="100">100개씩</option>
				<option value="500">500개씩</option>
				<option value="1000">1000개씩</option>
			</select>
		</div>
		<table id="dataTbl" class="table-hover applyTb" style="border-collapse: collapse;">
			<thead>
				<tr>
					<th>순번</th>
					<th style="width: 250px;">제목</th>
					<th>발신자</th>
					<th>등록일</th>
					<th>전송결과조회</th>
				</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging"></div>
		
		<form action="/admin/common/mailDetailForm" method="post" name="mailDetailForm" id="mailDetailForm"></form>
	</div>
</div>