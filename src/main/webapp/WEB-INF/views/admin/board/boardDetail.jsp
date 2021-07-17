<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script>
	//변수영역
	var allBoardListUrl = "<c:url value='/admin/board/allBoardList' />";
	var boardListUrl = "<c:url value='/admin/board/boardListBySeq' />";
	var detailUrl = "<c:url value='/admin/board/boardDetail' />";
	var boardUpdateUrl = "<c:url value='/admin/board/boardUpdate' />";
	
	$(function() {
		// 컨텐츠 타이틀
		$('.content_wraper').children('h3').eq(0).html($('title').text());
	});
	
	/* 게시판 관리 페이지 이동 */
		$('.allBoardList').on('click', function() {
			var params = $('form[name="searchForm"]').serializeObject();
			// ajax로 load
			contentLoad('게시글 관리', allBoardListUrl, params);
		});
		
		/* 게시판 내용 페이지(목록으로) 이동 */
		$(".dataListBody").on("click", function() {
			var params = $('form[name="searchForm"]').serializeObject();
			var board_nm = $("#board_nm").val();
			params.board_nm = board_nm;
			var board_seq = $("#board_seq").val();
			params.board_seq = board_seq;
			contentLoad(board_nm, boardListUrl, params);
		});
		
		/* 게시판 상세 페이지 이동 */
		$(".boardDetailMove").on("click", function() {
			var params = $('form[name="searchForm"]').serializeObject();
			var board_nm = $("#board_nm").val();
			params.board_nm = board_nm;
			var board_seq = $("#board_seq").val();
			params.board_seq = board_seq;
			var board_content_seq = $("#board_content_seq").val()
			params.board_content_seq = board_content_seq;
			contentLoad("게시글 상세", detailUrl, params);
		});
		
		//수정하기 버튼
		$("#boardUpdateBtn").on("click", function() {
			var params = $('form[name="searchForm"]').serializeObject();
			var board_nm = $("#board_nm").val();
			params.board_nm = board_nm;
			var board_seq = $("#board_seq").val();
			params.board_seq = board_seq;
			var board_content_seq = $("#board_content_seq").val()
			params.board_content_seq = board_content_seq;
			contentLoad("게시글 수정", boardUpdateUrl, params);
		});
		
		// 삭제하기 버튼
		$("#boardDeleteBtn").on("click", function() {
			var board_content_seq = $("#board_content_seq").val();
			var board_file_seq_list = [];
			var board_file_saved_list = []; 
			
			$("input:hidden[name=board_file_seq]").each(function(index, item){
				board_file_seq_list.push($(item).val());
			});
			
			$("input:hidden[name=board_file_saved]").each(function(index, item){
				board_file_saved_list.push($(item).val());
			});
			
			jQuery.ajaxSettings.traditional = true;
			
			if (confirm("삭제하시겠습니까?")) {
				if(board_file_seq_list.length > 0){
					$.ajax({
							beforeSend: function(xhr) {
							     xhr.setRequestHeader("AJAX", true);
							}
							, type: "post"
							, url : '/data/board/boardFileDelete'
							, type : 'post'
							, data : {
								board_file_seq_list : board_file_seq_list,
								board_file_saved_list : board_file_saved_list
							}
							, success : function() {
							
							}
							, error: function(e) {
								if(e.status == 403){
									alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
									location.href = "/fap/admin/admin_login";
								}
							}
					});
				}
				$.ajax({
					type	: "post",
					url : "/data/board/boardDelete",
					data 	: {"board_content_seq" : board_content_seq},
					success	: function(result) {
						if(result > 0){
							var params = $('form[name="searchForm"]').serializeObject();
							var board_nm = $("#board_nm").val();
							params.board_nm = board_nm;
							var board_seq = $("#board_seq").val();
							params.board_seq = board_seq;
							contentLoad(board_nm, boardListUrl, params);
						}
					},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
			}
			return false;
		});
</script>
<div class="content_wraper">
	<h3></h3>
	<div style="justify-content: center;">
		<span class="detailTd allBoardList">게시판 관리</span>
		<strong>></strong>
		<span class="detailTd dataListBody">${board_gb.board_nm}</span>
		<strong>></strong>
		<span class="detailTd boardDetailMove">게시글 상세</span>
	</div>
	<br>
	<div class="tab_body">
		<table class="board_view">
		<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
		</colgroup>
		<tbody>
		    <tr>
		        <th scope="row">글 번호</th>
		        <td>
		            ${boardDetail.board_content_seq}
				</td>
			<th scope="row">조회수</th>
			<td>${boardDetail.board_content_hit}</td>
		</tr>
		<tr>
		    <th scope="row">작성자</th>
		    <td>${boardDetail.board_content_nm}</td>
			<th scope="row">수정일</th>
			<td>${boardDetail.board_content_udt_dt}</td>
		</tr>
		<tr>
		    <th scope="row">첨부파일</th>
		    <td colspan="3">
		    <c:forEach var="data" items="${files}" varStatus="status">
				<a href="/forFaith/file/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved }&path=edu/apply/board_file">
					<strong>${data.board_file_origin }</strong>
				</a>
				<img class="boardImage" alt="" src="${path }/${data.board_file_saved }"> <br/>
				<input type="hidden" class="board_file_seq" name="board_file_seq" value="${data.board_file_seq}">
				<input type="hidden" class="board_file_saved" name="board_file_saved" value="${data.board_file_saved }">
			</c:forEach>
		    </td>
		</tr>
		<tr>
		    <th scope="row">제목</th>
		    <td colspan="3">
		        ${boardDetail.board_content_title }
		    </td>
		</tr>
		<tr>
		    <td colspan="4" class="view_text">
				<div id="view_text_div">
					${boardDetail.board_content_ct }
				</div>
		    </td>
		</tr>
		</tbody>
	</table>
	
	<div class="boardManagerDiv">
		<a class="btn btn-danger" id="boardDeleteBtn">삭제하기</a>
		<a class="btn btn-primary" id="boardUpdateBtn">수정하기</a>
		<a class="btn dataListBody" id="boardManagerBtn">목록으로</a>
	</div>
    <input type="hidden" id="board_seq" value="${search.board_seq}" />
    <input type="hidden" id="board_nm" value="${search.board_nm}" />
    <input type="hidden" id="board_content_seq" value="${search.board_content_seq}" />
    <form name="searchForm">
	    <input type="hidden" name="searchCondition" value="${search.searchCondition}" />
	    <input type="hidden" name="searchKeyword" value="${search.searchKeyword}" />
	    <input type="hidden" name="pagingYn" value="${search.pagingYn}" />
	    <input type="hidden" name="pageNo" value="${search.pageNo}" />
    </form>
	</div>
</div>
