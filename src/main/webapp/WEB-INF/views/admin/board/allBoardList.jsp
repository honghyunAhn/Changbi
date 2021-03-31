<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<style>
.board_nm {
	color: blue;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(document).ready(function () {
		/** 변수 영역 **/
		// 여기에서 URL 변경 시켜서 사용
		var listUrl	= "<c:url value='/data/board/allBoardList' />";
		var boardListUrl = "<c:url value='/admin/board/boardListBySeq' />";
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
			
			// ajax 처리
			$.ajax({
				type	: "post",
				url		: listUrl,
				data 	: params,
				success	: function(result) {
					var content = '';
					$.each(result.list, function(index,item) {
						content += '<tr>';
						content += 		'<td>' + (index + 1);
						content +=			'<input type="hidden" name="board_seq" value="' + item.BOARD_SEQ + '">'
						content +=		'</td>';
						content += 		'<td class="board_nm">' + item.BOARD_NM + '</td>';
						content += '</tr>';
					});
					
					if(content == '') {
						content += '<tr><td colspan="2">조회된 결과가 없습니다.</td></tr>';
					}
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
		/** 이벤트 영역 **/
		// 검색 버튼 클릭 시
		$("#searchBtn").unbind("click").bind("click", function() {
			// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
			setContentList(1);
		});
		// 클릭 시 상세 페이지 이동
		$("#dataListBody").on("click", ".board_nm", function() {
			var board_seq = $(this).closest('tr').find(':hidden[name=board_seq]').val();
			var board_nm = $(this).text();
			var params = $('form[name=searchForm]').serializeObject();
			// ajax로 load
			contentLoad(board_nm, boardListUrl, {'board_seq' : board_seq});
		});
		/** 페이지 시작 **/
		// 최초 리스트 페이지 호출 한다.
		setContentList();
		
		// 컨텐츠 타이틀
		$('.content_wraper').children('h3').eq(0).html($('title').text());
	});
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
			<!-- 페이징 처리여부 -->
        	<input type="hidden" name="pagingYn" value="Y" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>내용</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>