<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">


	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[1] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[2] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	$(function() {
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
		});
		//목록으로
		$("#boardManagerBtn").on("click", function() {
			$("#boardHiddenManagerForm").submit();
		});
	})
	function gotolist() {
		$("#boardHiddenManagerForm").submit();
	}
</script>
<div class="content_wraper">
	<h3>게시글 작성</h3>
	<div style="justify-content: center;">
		<span class="detailTd">게시판 관리</span>
		<strong>></strong>
		<span class="detailTd">${board_gb.board_nm}</span>
	</div>
	<form action="/data/board/boardInsert" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
		<table class="board_view">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">조회수</th>
					<td>
						조회수 : 0
						<input type="hidden" name="board_content_hit" value="0">
					</td>
					<th scope="row">작성자</th>
					<td>${board_content_nm }<input type="hidden" name="board_content_nm" value="${board_content_nm}">
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일1</th>
					<td colspan="3">
						<div class='attach_file_area' style="clear: both; flex: auto;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file1.fileId' value='<c:out value="${board.file1.fileId}" default="" />' />
							<input type='hidden' class='upload_dir' name='upload_dir'	value='/upload/board/files' />
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일2</th>
					<td colspan="3">
						<div class='attach_file_area' style="clear: both; flex: auto;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file2.fileId' value='<c:out value="${board.file2.fileId}" default="" />' />
							<input type='hidden' class='upload_dir' name='upload_dir'	value='/upload/board/files' />
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일3</th>
					<td colspan="3">
						<div class='attach_file_area' style="clear: both; flex: auto;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file3.fileId' value='<c:out value="${board.file3.fileId}" default="" />' />
							<input type='hidden' class='upload_dir' name='upload_dir'	value='/upload/board/files' />
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td colspan="3">
						<div style="text-align: left; padding-bottom: 10px; padding-left: 10px;">
							<input type="text" name="board_content_title" id="board_content_title" style="width: 400px;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="view_text">
						<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="boardManagerDiv">
			<a class="btn btn-primary" id="boardInsertBtn">등록하기</a>
			<a class="btn" id="boardManagerBtn">목록으로</a>
		</div>
		<input type="hidden" name="board_nm" value="${board_gb.board_nm }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${board_gb.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${board_gb.board_tp}"/>
	</form>
	<form action="/edu/admin/board_contents_search" id="boardHiddenManagerForm" method="post">
		<input type="hidden" name="board_seq" id="board_seq" value="${board_gb.board_seq}" />
		<input type="hidden" name="board_nm" id="board_nm" value="${board_gb.board_nm}" />
        <input type="hidden" name="board_gb" id="board_gb" value="${board_gb.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${board_gb.board_tp}"/>
	</form>
</div>
