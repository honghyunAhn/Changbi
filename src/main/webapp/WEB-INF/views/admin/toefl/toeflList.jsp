<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
	//변수
	var editUrl = '<c:url value="/admin/toefl/toeflEdit" />';
	var dataListUrl = '<c:url value="/data/toefl/toeflList" />';
	var listPageUrl = '<c:url value="/admin/toefl/toeflList" />';
	var selectDelUrl = '<c:url value="/data/toefl/deleteToefl" />'
	//데이터 리스트
	var list;
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	$(document).ready(function(){
		setContent(1);
		setEvent();
	});
	
	//전체 시험 리스트
	function setContent(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		var params = $('form[name=searchForm]').serializeObject();
		
		$.ajax({
			type	: "post",
			url		: dataListUrl,
			data 	: params,
			async	: false,
			success	: function(result) {
				setTableContent(result);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	//table 내용 세팅
	function setTableContent(result) {
		
		var content = '';
		
		if(result.list != null && result.list.length != 0) {
			
			$.each(result.list, function(index,item) {
				content += '<tr>';
				content += 		'<td><input type="checkbox" name="selectCheckBox" /></td>';
				content += 		'<td>' + (index + 1);
				content += 			'<input type="hidden" name="id" value="' + item.id + '">';
				content += 		'</td>';
				content += 		'<td>';
				switch(item.type) {
				case 1:
					content += 		'Complete';
					break;
				case 2:
					content += 		'Half(R/L)';
					break;
				case 3:
					content += 		'Half(S/W)';
					break;
				}
				content += 		'</td>';
				content += 		'<td class="content_edit">' + item.title + '</td>';
				content +=		'<td>' + item.volum + '</td>';
				content += 		'<td>' + formatMoney(item.price) + '원</td>';
				content += 		'<td>' + item.regUser.id + '</td>';
				content += 		'<td>' + (item.regDate).substr(0,16) + '</td>';
				content += '</tr>';
			});
		} else {
			content += '<tr>';
			content +=		'<td colspan="8">조회 결과가 없습니다.</td>';
			content +=	'</tr>';
		}
		
		$('#dataListBody').html(content);
		// 페이징 처리
		pagingNavigation.setData(result);		// 데이터 전달
		// 페이징(콜백함수 숫자 클릭 시)
		pagingNavigation.setNavigation(setContent);
	}
	//이벤트 연결
	function setEvent() {
		
		// 전체 체크박스 클릭 시
		$("#allCheckBox").unbind("click").bind("click", function() {
			$(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
		});
		
		//신규등록
		$('#insBtn').on('click', function() {
			contentLoad("서비스관리(상세)", editUrl);
		});
		
		//선택삭제
		$('#delBtn').on('click', function(){
			var size = $(":checkbox[name='selectCheckBox']:checked").size();
			if(size == 0) {
				alert("삭제 할 데이터를 선택하세요.");
			} else if(confirm("선택 된 "+size+"건의 데이터를 삭제하시겠습니까?")) {
				var objList = new Array();
				
				$(":checkbox[name='selectCheckBox']:checked").each(function() {
					var id = $(this).closest('tr').find('td:eq(1) > :hidden[name=id]').val();

					objList.push({"id" : id});
				});
				
				// ajax 처리
				$.ajax({
					type		: "POST",
					url			: selectDelUrl,
					data		: JSON.stringify(objList),
					dataType	: "json",
					contentType	: "application/json; charset=utf-8",
					success		: function(result) {
						alert(result+"개 데이터가 삭제 되었습니다.");
						setContent(1);
					},
					error		: function(e) {
						alert(e.responseText);
					}
				});
			}
		});
		
		//상세보기
		$("#dataListBody").on("click", ".content_edit", function() {
			var id = $(this).closest('tr').find('td:eq(1) > :hidden[name=id]').val();
			var params = $('form[name=searchForm]').serialize();
			params += '&id='+id+'';
			contentLoad("서비스관리(상세)", editUrl, params);
		});
		
		//검색
		$('#searchBtn').on('click', function() {
			setContent(1);
		});
		//검색어 치고 엔터 눌렀을 때
		$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
			if(event.keyCode === 13) {
				$("#searchBtn").trigger("click");
			}
		});
	}
</script>

<div class="content_wraper">
	<h3>서비스목록 관리</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
	       	<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<select class="searchConditionBox" name="searchCondition">
								<option value='all' <c:if test="${search.searchCondition eq 'all'}">selected</c:if>>전체</option>
								<option value='author' <c:if test="${search.searchCondition eq 'author'}">selected</c:if>>작성자</option>
								<option value='volum' <c:if test="${search.searchCondition eq 'volum'}">selected</c:if>>볼륨</option>
							</select>
							<input type="text" placeholder="검색어입력" class="searchKeywordBox" name="searchKeyword" value="<c:out value="${search.searchKeyword}" default=""/>">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
							<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
	        			</td>
	        		</tr>
	        		</table>
				</div>
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse; margin-bottom: 10px;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th style="width: 5%;">연번</th>
				<th style="width: 10%;">타입</th>
				<th style="width: 30%;">시험명</th>
				<th style="width: 10%;">볼륨</th>
				<th style="width: 10%;">가격</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">선택삭제</a>
			<a id="insBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>