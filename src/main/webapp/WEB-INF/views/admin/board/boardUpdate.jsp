<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">
	var allBoardListUrl = "<c:url value='/admin/board/allBoardList' />";
	var boardListUrl = "<c:url value='/admin/board/boardListBySeq' />";
	var detailUrl = "<c:url value='/admin/board/boardDetail' />";
	var boardUpdateUrl = "<c:url value='/admin/board/boardUpdate' />";
	
	$(function() {
		var search = $("#search").val();
		var files = $("#files").val();
		var boardDetail = $("#boardDetail").val();
		
		/* CKEditor */
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
			enterMode: CKEDITOR.ENTER_BR,
			shiftEnterMode:  CKEDITOR.ENTER_P,
			fullPage: true,
			allowedContent:  true,
			removeButtons: 'Save',
			removePlugins: 'resize'
		});
		
		/* 게시판 관리 페이지 이동 */
		$('.allBoardList').on('click', function() {
			var params = $('form[name="searchForm"]').serializeObject();
			// ajax로 load
			contentLoad('게시글 관리', allBoardListUrl, params);
		});
		
		/* 게시판 내용 페이지(목록으로) 이동 */
		$(".dataListBody").on("click", function() {
			var params = $("#boardMoveHidden").serializeObject(); 
			contentLoad(params.board_nm, boardListUrl, params);
		});
		
		/* 게시판 상세 페이지 이동 */
		$(".boardDetailMove").on("click", function() {
			var params = $("#boardMoveHidden").serializeObject(); 
			contentLoad("게시글 상세", detailUrl, params);
		});
		
		//수정하기 버튼
		$("#boardUpdateBtn").on("click", function() {
			var params = $("#boardMoveHidden").serializeObject();
			contentLoad(params.board_nm, boardUpdateUrl, params);
		});
		
		//목록으로 버튼
		$("#boardManagerBtn").on("click", function() {
			var params = $("#boardMoveHidden").serializeObject(); 
			contentLoad(params.board_nm, boardListUrl, params);
		});
		
		function gotolist() {
			$("#boardHiddenManagerForm").submit();
		}
	});
	
	$("#file_add").on('click',function(){ $('#multi-add').click(); });
	var $fileListArr = new Array();
	var $totSize = 0;
	var $keyNum = 0;
	var $limit = 0;
	function content(keyNum, fileslist, size){
		var content = null;
		content += "<tr id=file"+ keyNum +">";
		content += "<td class='txt-c' style='width: 5%;'>";
		content += "<button type='button' style='color: #A4A4A4; font-size: large; border: none;' class='deleteFile' >&#8861;</button>";
		content += "</td>";
		content += "<td style='width: 80%;'>"+ fileslist +"</td>";
		content += "<td id='fileSize "+ keyNum +"' style='width: 15%;'>";
		content += "<p class=file"+ keyNum +" style='margin-bottom: 0;'>"+ Math.floor(size / 1000) +" KB</p>";
		content += "</td>";
		content += "</tr>";
		return content;
	}
	
	//파일 add
	$("#multi-add").on('change',function(){
		var files = $(this)[0].files;

		var fileArr = new Array();

		fileArr = $fileListArr;
		$limit = $totSize;
		for(var i = 0 ; i < files.length ; i++){
			$limit = $limit + files[i].size;
			if($limit > 100000000){
				alert("첨부파일 용량은 100MB를 넘길수 없습니다.");
				return false;
			}
		}
		for(var i = 0 ; i < files.length ; i++){
			 $('#file_table').append(content($keyNum, files[i].name, files[i].size));
			 $keyNum++;
			 fileArr.push(files[i]);
			 $totSize = $totSize + files[i].size;
		}
		$fileListArr = new Array();
		$fileListArr = fileArr;
		$('#totSize').text("");
		$('#totSize').text(Math.floor($totSize / 1000000));
	});

	//기존 파일 delete
	$('.delBtn').on("click" , function(){
		$(this).parent().parent().remove();
		
		var board_file_seq = $(this).parent().next().next().children('.board_file_seq').attr('value');
		var board_file_saved = $(this).parent().next().next().children('.board_file_saved').attr('value');
		
		var check = confirm("파일을 삭제 하시겠습니까?");
		if (!check) {
			return false;
		}
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, type : "POST"
			, url : "/data/board/boardFileDel"
			, data : {board_file_seq : board_file_seq, board_file_saved : board_file_saved}
			, success : function(data) {
			},
			error : function(e) {
				console.log(e);
			}
		});
	});
	
	//파일 delete
	$(document).on("click" , '.deleteFile', function(){
		//삭제할 파일의 아이디
		var DeleteID = $(this).parent().parent().attr('id');

		//삭제하려는 파일의 크기값(텍스트)
		var DeleteFileSize = $(this).parent().next().next().children('p').text();

		//삭제하는 파일의 크기값(바이트)
		var fileSizeByteArr = new Array();
		fileSizeByteArr = DeleteFileSize.split(' ');
		var fileSize = Number(fileSizeByteArr[0]) * 1000;

		//배열에서 삭제를 위한 번호
		var DeleteArrNum = DeleteID.substring(DeleteID.length , DeleteID.length -1);

		var fileArr = $fileListArr;

		fileArr.splice(DeleteArrNum , 1);
		$keyNum = 0
		$fileListArr = new Array();
		$('#file_table').children().remove();
		 $totSize = 0;
		for(var i = 0 ; i < fileArr.length ; i++){
			 $('#file_table').append(content($keyNum, fileArr[i].name, fileArr[i].size));
			 $keyNum++;
			 $fileListArr.push(fileArr[i]);
			 $totSize = $totSize + fileArr[i].size;
		}

		$limit = $totSize;
		$('#totSize').text("");
		$('#totSize').text(Math.floor($totSize / 1000000));
	});

	function formCheck(){
		var form = $("form")[0];        
	    var formData = new FormData(form);
	    var board_content_ct = CKEDITOR.instances.board_content_ct.getData();
	    formData.set("board_content_ct", board_content_ct);
		for(var i = 0; i < $fileListArr.length ; i++){
			formData.append("uploadFile" , $fileListArr[i]);
		}
		
		if (formData.get("board_content_title").length == 0) {
			alert("제목을 입력해 주세요.");
			return false;
		}
		var check = confirm("수정하시겠습니까?");
		if (!check) {
			return false;
		}
		$.ajax({
	        url : "/data/board/boardUpdate",
	        processData: false,
	        contentType: false,
	        type : 'POST',
	        data : formData,
	        success : function(result){
	        	if(result > 0){
	        		CKEDITOR.instances.board_content_ct.destroy();
	        		var params = $("#boardMoveHidden").serializeObject(); 
	         		contentLoad(params.board_nm, boardListUrl, params);
	        	} else{
	        		alert("등록실패했습니다.");
	        	}
	        },
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
		return true;
	}
</script>
<div class="content_wraper">
	<h3>게시글 수정</h3>
	<div style="justify-content: center;">
		<span class="detailTd allBoardList">게시판 관리</span>
		<strong>></strong>
		<span class="detailTd dataListBody">${board_gb.board_nm}</span>
		<strong>></strong>
		<span class="detailTd boardDetailMove">게시글 상세</span>
		<strong>></strong>
		<span class="detailTd boardUpdateBtn">게시글 수정</span>
	</div>
	<form enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" style="width: 20%;">조회수</th>
					<td>
						${boardDetail.board_content_hit}
					</td>
					<th scope="row" style="width: 20%;">작성자</th>
					<td><input type="hidden" name="board_content_nm" id="board_content_nm" value="">
					${boardDetail.board_content_nm}</td>
				</tr>
				<tr>
					<th scope="row" style="width: 20%;">제목</th>
					<td colspan="3" style="width: 80%;">
						<div style="padding: 0px 5px 0px 5px;">
							<input type="text"  name="board_content_title" value="${boardDetail.board_content_title}" id="board_content_title" style="width: 100%;  border: none;"/>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row" style="width: 20%;">첨부파일</th>
					<td colspan="3">
					<input type="file" id="multi-add" class="btn-add" multiple style="display: none;" multiple="multiple" name="file" >
					<button type="button" class="btn-add" id="file_add">파일추가</button>
					<span class='file_upload_info'>(파일크기 : 100M )</span>
					</td>
					
				</tr>
		</table>
		<table id="detail_file_table">
			<c:forEach var="data" items="${files}" varStatus="status">
				<tr id='file${data.board_file_seq}'>
					<td class='txt-c' style='width: 5%;'>
						<button class="delBtn" type='button' style='color: #A4A4A4; font-size: large; border: none;'>&#8861;</button>
					</td>
					<td style='width: 80%;'>
						<a href="/forFaith/file/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved }&path=edu/apply/board_file">
							<strong>${data.board_file_origin }</strong>
						</a>
					</td>
					<td style='width: 15%;'>
						<input type="hidden" class="board_file_seq" name="boardFileList[${status.index}].board_file_seq" value="${data.board_file_seq }">	
						<input type="hidden" name="boardFileList[${status.index}].board_file_origin" value="${data.board_file_origin }">
						<input type="hidden"  class="board_file_saved" name="boardFileList[${status.index}].board_file_saved" value="${data.board_file_saved }">
					</td>
				</tr>
			</c:forEach>
		</table>
		<table id="file_table"></table>
		<table class="board_view" style="border-top: none;">
			<tbody>
				<tr>
					<td colspan="4" class="view_text">
						<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60">${boardDetail.board_content_ct}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="boardManagerDiv">
			<input type="button" value="수정하기" class="btn btn-primary" onclick="formCheck(); return false;">
			<a class="btn dataListBody">목록으로</a>
		</div>
		<input type="hidden" name="board_content_seq" value="${search.board_content_seq}">
	</form>
	
	<form action="/data/board/boardDelete" id="boardMoveHidden" method="post">
		<input type="hidden" name="searchCondition" value="${search.searchCondition}" />
	    <input type="hidden" name="searchKeyword" value="${search.searchKeyword}" />
	    <input type="hidden" name="pagingYn" value="${search.pagingYn}" />
	    <input type="hidden" name="pageNo" value="${search.pageNo}" />
        <input type="hidden" name="board_seq" value="${search.board_seq}" />
        <input type="hidden" name="board_nm" value="${search.board_nm}" />
        <input type="hidden" name="board_content_seq" value="${search.board_content_seq}" />
    </form>
</div>
