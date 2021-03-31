<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script>
	$(function() {
		//변수영역
		var boardListUrl = "<c:url value='/admin/board/boardListBySeq' />";
		var deleteUrl = "<c:url value='/data/board/boardDelete' />";
		// 삭제하기
		$("#boardDeleteBtn").on("click", function() {
			if (confirm("삭제하시겠습니까?")) {
				$.ajax({
					type	: "post",
					url		: deleteUrl,
					data 	: params,
					async: false,
					success	: function(result) {
						detail = result[0];
					},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
			}
			return false;
		});
		//수정하기
		$("#boardUpdateBtn").on("click", function() {
			$("#boardHiddenForm_update").submit();
		});
		//목록으로
		$("#boardManagerBtn").on("click", function() {
			var params = $('form[name=searchForm]').serializeObject();
			// ajax로 load
			contentLoad('${board_gb.board_nm}', boardListUrl, params);
		});
		// 컨텐츠 타이틀
		$('.content_wraper').children('h3').eq(0).html($('title').text());
	})
</script>
<div class="content_wraper">
	<h3></h3>
	<div style="justify-content: center;">
		<span class="detailTd">게시판 관리</span>
		<strong>></strong>
		<span class="detailTd">${board_gb.board_nm}</span>
	</div>
	<br>
	<form name="searchForm">
		<!-- 페이징 처리여부 -->
       	<input type="hidden" name="pagingYn" value="Y" />
       	<!-- pageNo -->
       	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		<input type="hidden" name="board_seq" value="${search.board_seq}">
	</form>
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
		<a class="btn" id="boardManagerBtn">목록으로</a>
	</div>
	
    <form action="/edu/admin/board_contents_update_form" id="boardHiddenForm_update" method="post">
        <input type="hidden" name="search_division" id="search_division" value="${search_division}" />
        <input type="hidden" name="search_type" id="search_type" value="${search_type}" />
        <input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
        <input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }" />
    </form>
    <form action="/data/board/boardDelete" id="boardHiddenForm_delete" method="post">
        <input type="hidden" name="board_content_seq" value="${boardDetail.board_content_seq }" />
    </form>
	</div>
</div>