<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">

	//변수
	var editUrl = '<c:url value="/admin/board/noticeEdit" />';
	var dataListUrl = '<c:url value="/data/board/noticeList" />';
	var listPageUrl = '<c:url value="/admin/board/noticeList" />';
	//공지 리스트
	var list;
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	$(document).ready(function(){
		setContent();
		setEvent();
	});
	//컨텐츠 세팅
	function setContent() {
		getList();
		setTableContent();
		setForm();
		pagingFunc();
	}
	//전체 공지사항 리스트
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
			$.each(list,function(index, item) {
				content += '<tr>';
				content += 		'<td>' + (index + 1);
				content +=			'<input type="hidden" name="board_content_seq" value="'+item.board_content_seq+'"></td>';
				content +=		'</td>';
				content += 		'<td>';
				switch(item.boardGt.board_gb) {
				case 'A0306':
					content += '두잇캠퍼스'
					break;
				case 'A0301':
					content += '레인보우';
					break;
				}
				content += 		'</td>';
				content += 		'<td>';
				switch(item.boardGt.board_detail_gb) {
				case 'A1702':
					content += '공지사항';
					break;
				case 'A1703':
					content += '이벤트';
					break;
				case 'A1704':
					content += '공지사항';
					break;
				case 'A1705':
					content += '이벤트';
					break;
				}
				content += 		'</td>';
				content += 		'<td>';
				switch(item.boardGt.board_tp) {
				case 'A0400':
					content += '글';
					break;
				case 'A0401':
					content += '동영상';
					break;
				case 'A0402':
					content += '사진';
					break;
				case 'A0403':
					content += '질문';
					break;
				}
				content +=		'<td>';
				switch(item.board_content_imp) {
				case 'A1100':
					content += '중요'
					break;
				case 'A1101':
					content += '일반';
					break;
				}
				content += 		'</td>';
				content += 		'<td class="detailTd">'+ item.board_content_title +'</td>';
				content += 		'<td>'+ item.board_content_nm +'</td>';
				content += 		'<td>' + getDateFormat(item.board_content_ins_dt) + '</td>';
				content += '<tr>';
			});
		} else {
			content += '<tr>';
			content +=		'<td colspan="8">조회 결과가 없습니다.</td>';
			content += '</tr>';
		}
		$('#dataListBody').html(content);
	}
	
	function setForm() {
		if('${search.board_detail_gb}' != '' && '${search.board_detail_gb}' != '') {
			var option = '';
			switch('${search.board_detail_gb}') {
			case 'A1702':
			case 'A1703':
				option += '<option value="A1702" <c:if test="${search.board_detail_gb eq \'A1702\'}">selected</c:if>>공지사항(두잇)</option>';
				option += '<option value="A1703" <c:if test="${search.board_detail_gb eq \'A1703\'}">selected</c:if>>이벤트(두잇)</option>';
				break;
			case 'A1704':
			case 'A1705':
				option += '<option value="A1704" <c:if test="${search.board_detail_gb eq \'A1704\'}">selected</c:if>>공지사항(레인)</option>';
				option += '<option value="A1705" <c:if test="${search.board_detail_gb eq \'A1705\'}">selected</c:if>>이벤트(레인)</option>';
				break;
			}
			$('select[name=board_detail_gb]').append(option);
		}
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
	
	function setEvent() {
		//검색 selectBox 이벤트
		$('select[name=board_gb]').on('change', function(){
			$('select[name=board_detail_gb]').empty();
			var option = '';
			option += '<option value="">전체</option>';
			switch($('select[name=board_gb]').val()) {
			case 'A0306':
				option += '<option value="A1702">공지사항(두잇)</option>';
				option += '<option value="A1703">이벤트(두잇)</option>';
				break;
			case 'A0307':
				option += '<option value="A1704">공지사항(레인)</option>';
				option += '<option value="A1705">이벤트(레인)</option>';
				break;
			}
			$('select[name=board_detail_gb]').append(option);
		});
		
		//상세보기
		$('.detailTd').on('click', function(){
			var seq = $(this).closest('tr').find('td:eq(0) > input[name=board_content_seq]').val();
			var params = $('form[name=searchForm]').serializeObject();
			params.board_content_seq = seq;
			contentLoad('공지사항 상세',editUrl, params);
		});
		
		//신규등록
		$('#insertBtn').on('click', function(){
			contentLoad('공지사항 작성',editUrl);
		});
		$('#searchBtn').on('click', function() {
			var params = $('form[name=searchForm]').serializeObject();
			contentLoad('공지사항 검색',listPageUrl, params);
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
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<dl style="margin-bottom: 0;">
       			<dt>게시위치</dt>
       			<dd class="half">
       				<select name="board_gb" class="searchConditionBox">
       					<option value="">전체</option>
       					<option value="A0306" <c:if test="${search.board_gb eq 'A0306'}">selected</c:if>>두잇캠퍼스</option>
       					<option value="A0301" <c:if test="${search.board_gb eq 'A0301'}">selected</c:if>>레인보우</option>
       				</select> 
       			</dd>
       			<dt>항목구분</dt>
       			<dd class="half">
       				<select name="board_detail_gb" class="searchConditionBox">
       				</select> 
       			</dd>
       			<dt>게시판 유형</dt>
       			<dd class="half">
       				<select name="board_tp" class="searchConditionBox">
       					<option value="">전체</option>
       					<option value="A0400" <c:if test="${search.board_tp eq 'A0400'}">selected</c:if>>공지사항</option>
       					<option value="A0401" <c:if test="${search.board_tp eq 'A0401'}">selected</c:if>>동영상</option>
       					<option value="A0402" <c:if test="${search.board_tp eq 'A0402'}">selected</c:if>>사진</option>
       					<option value="A0403" <c:if test="${search.board_tp eq 'A0403'}">selected</c:if>>질문</option>
       				</select> 
       			</dd>
       			<dt>중요도</dt>
       			<dd class="half">
       				<select name="board_content_imp" class="searchConditionBox">
       					<option value="">전체</option>
       					<option value="A1100" <c:if test="${search.board_content_imp eq 'A1100'}">selected</c:if>>중요</option>
       					<option value="A1101" <c:if test="${search.board_content_imp eq 'A1101'}">selected</c:if>>일반</option>
       				</select> 
       			</dd>
       			<dt>키워드 검색</dt>
       			<dd>
       				<select id="searchCondition" name="searchCondition" class="searchConditionBox">
						<option value='all'>전체</option>
						<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
						<option value='content' <c:if test="${search.searchCondition eq 'content'}">selected</c:if>>내용</option>
						<option value='author' <c:if test="${search.searchCondition eq 'author'}">selected</c:if>>작성자</option>
					</select>
		
					<input type="text" placeholder="검색어입력" name="searchKeyword" class="searchKeywordBox" value="<c:out value="${search.searchKeyword}" />">
       			</dd>
       		</dl>
       		<div style="text-align: center;"><input type="button" id="searchBtn" value="검색"></div>
		</form>
		<!-- //searchForm end -->
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th style="width: 2%;">순번</th>
					<th style="width: 4%;">게시위치</th>
					<th style="width: 5%;">항목구분</th>
					<th style="width: 4%;">유형</th>
					<th style="width: 4%;">중요도</th>
					<th style="width: 30%;">제목</th>
					<th style="width: 10%;">작성자</th>
					<th style="width: 10%;">작성일</th>
				</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="insertBtn" class="btn align_right primary">신규등록</a>
		</div>
	</div>
</div>