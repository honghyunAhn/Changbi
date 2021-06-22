<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">
	var allBoardListUrl = "<c:url value='/admin/board/allBoardList' />";
	var boardListUrl = "<c:url value='/admin/board/boardListBySeq' />";
	var insertUrl = "<c:url value='/admin/board/boardInsert' />";
	var params = $('form[name="searchForm"]').serializeObject();
	
	window.parent.CKEDITOR.tools.callFunction('${CKEditorFuncNum}', '${file_path}', '파일 전송 완료.');
	
	$(function() {
		/* CKEditor */
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
			enterMode: CKEDITOR.ENTER_BR,
			shiftEnterMode:  CKEDITOR.ENTER_P,
			fullPage: true,
			allowedContent:  true
		});
		
		/* 게시판 관리 페이지 이동 */
		$('.allBoardList').on('click', function() {
			var params = $('form[name="searchForm"]').serializeObject();
			// ajax로 load
			contentLoad('게시글 관리', allBoardListUrl, params);
		});
		
		/* 게시판 내용 페이지(목록으로) 이동 */
		$(".dataListBody").on("click", function() {
			var params = $('#boardHiddenManagerForm').serializeObject();
			// ajax로 load
			contentLoad(params.board_nm, boardListUrl, params);
		});

		/* 게시판 등록 페이지 이동 */
		$('.boardInsertBtn').on('click', function(){
			var params = $('#boardHiddenManagerForm').serializeObject();
			// ajax로 load
			contentLoad('게시글 작성', insertUrl, params);
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
	
	//게시판 등록
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
		var check = confirm("등록하시겠습니까?");
		if (!check) {
			return false;
		}
		$.ajax({
	        url : "/data/board/boardInsert",
	        processData: false,
	        contentType: false,
	        type : 'POST',
	        data : formData,
	        success : function(result){
	        	if(result > 0){
	        		CKEDITOR.instances.board_content_ct.destroy();
	        		var params = $("#boardHiddenManagerForm").serializeObject();
	         		contentLoad(formData.get("board_nm"), boardListUrl, params);
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
	<h3>게시글 작성</h3>
	<div style="justify-content: center;">
		<span class="detailTd allBoardList">게시판 관리</span>
		<strong>></strong>
		<span class="detailTd dataListBody">${board_gb.board_nm}</span>
		<strong>></strong>
		<span class="detailTd boardInsertBtn">게시글 작성</span>
	</div>
	<form action="/data/board/boardInsert" method="post" id="boardInsertForm" enctype="multipart/form-data">
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
						0
						<input type="hidden" name="board_content_hit" id="board_content_hit" value="0">
					</td>
					<th scope="row" style="width: 20%;">작성자</th>
					<td>${board_content_nm}<input type="hidden" name="board_content_nm" id="board_content_nm" value="${board_content_nm}">
					</td>
				</tr>
				<tr>
					<th scope="row" style="width: 20%;">제목</th>
					<td colspan="3" style="width: 80%;">
						<div style="padding: 0px 5px 0px 5px;">
							<input type="text" name="board_content_title" id="board_content_title" style="width: 100%;  border: none;"/>
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
		<table id="file_table"></table>
		<table class="board_view" style="border-top: none;">
			<tbody>
				
				<tr>
					<td colspan="4" class="view_text">
						<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="boardManagerDiv">
			<input type="button" value="등록하기" class="btn btn-primary" onclick="formCheck(); return false;">
			<a class="btn dataListBody">목록으로</a>
		</div>
		<input type="hidden" name="board_seq" id="board_seq" value="${board_gb.board_seq}" />
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
