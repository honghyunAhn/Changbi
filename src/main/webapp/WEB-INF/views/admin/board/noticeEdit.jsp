<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">
	
	//변수
	var dataListUrl = '<c:url value="/data/board/noticeList" />';
	var listPageUrl = '<c:url value="/admin/board/noticeList" />';
	var deleteUrl = '<c:url value="/data/board/deleteNotice" />';
	var insertUrl = '<c:url value="/data/board/insertNotice" />';
	var detail;
	var board_content_seq = parseInt('${search.board_content_seq}');
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[1] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	$(document).ready(function(){
		setContent();
		setEvent();
	});
	
	//컨텐츠 세팅
	function setContent() {
		getDetail();
		setForm();
	}
	function getDetail() {
		var params = new Object();
		(board_content_seq != null && board_content_seq != '') ? 
				params.board_content_seq = board_content_seq : params.board_content_seq=0;
		$.ajax({
			type	: "post",
			url		: dataListUrl,
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
	//값 세팅
	function setForm() {
		if(detail != null && detail !== undefined) {
			$('#delDiv').removeAttr('hidden');
			$('select[name=board_gb]').val(detail.boardGt.board_gb).prop('selected',true);
			var option ='';
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
			$('select[name=board_detail_gb]').val(detail.boardGt.board_detail_gb).prop('selected',true);
			$('select[name=board_tp]').val(detail.boardGt.board_tp).prop('selected',true);
			$('select[name=board_content_imp]').val(detail.board_content_imp).prop('selected',true);
			$('input[name=board_content_title]').val(detail.board_content_title);
			$('#comment_editor').html(detail.board_content_ct);
			
			$.each(detail.file, function(index, item) {
				if(item.origin_file_name !== undefined) {
					$(":hidden.attach_file_id").eq(index).val(item.board_file_saved)
					var sb = new StringBuilder();
					sb.Append("<div class='file_info_area' style='float: left;'>");
					sb.Append("<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>");
					sb.Append("<input type='button' value='"+item.origin_file_name+"' style='width: 200px; height: 30px;' />");
					sb.Append("</div>");
					sb.Append("<div class='file_info' style='padding-left: 5px;'>");
					sb.Append("<input type='hidden' class='attach_file_name' 		value='"+item.file_name+"' />");
					sb.Append("<input type='hidden' class='attach_file_path'		value='"+item.file_path+"' />");
					sb.Append("<input type='hidden' class='attach_file_size'		value='"+(item.file_size ? item.file_size : 0)+"' />");
					sb.Append("<input type='hidden'	class='attach_origin_file_name'	value='"+item.origin_file_name+"' />");
					sb.Append("<input type='hidden'	class='attach_url_path'			value='"+item.url_path+"' />");
					sb.Append("<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />");
					sb.Append("</div>");
					sb.Append("</div>");
					$(".attach_file_area").eq(index).append(sb.ToString());
					
					//생성된 area에 새로 이벤트 적용
					var option = new Object();
					option.area = $(".attach_file_area").eq(index);
					option.fileIndex = index;
					option.callback = '';
					deleteFileEvent(option);
				}
			});
		} else {
			//값 없는 경우 기초세팅
			var option = '';
			option += '<option value="A1702">공지사항(두잇)</option>';
			option += '<option value="A1703">이벤트(두잇)</option>';
			$('select[name=board_detail_gb]').append(option);
		}
	}
	function setEvent() {
		//검색 selectBox 이벤트
		$('select[name=board_gb]').on('change', function(){
			$('select[name=board_detail_gb]').empty();
			var option = '';
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
		//리스트로
		$('#listBtn').on('click', function(){
			var pageTitle = $('.content_wraper > h3').html();
			contentLoad(pageTitle, listPageUrl, $('form[name=searchForm]').serialize());
		});
		//삭제
		$('#deleteBtn').on('click', function(){
			var params = {"board_content_seq" : board_content_seq};
			$.ajax({
				type	: "post",
				url		: deleteUrl,
				data 	: params,
				async: false,
				success	: function(result) {
					if(result) {
						alert('삭제에 성공했습니다.');
						$('#listBtn').trigger('click');
					} else {
						alert('삭제에 실패했습니다.');
						return;
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
		//신규등록
		$('#insertBtn').on('click', function(){
			
			if(!checkForm()) return;
			
			var params = $('form[name=actionForm]').serializeObject();
			if(!isNaN(board_content_seq)) params.board_content_seq = board_content_seq;
			
			var fileObj = new Object();
			if($('div.file_info > :hidden').length != 0) {
				var fileDiv = $('div.file_info');
				var obj = new Object();
				$.each(fileDiv, function(index,item) {
					var attach_origin_file_name = $(item).find(':hidden.attach_origin_file_name').val();
					fileObj['file' + index] = attach_origin_file_name;
				});
			}
			
			var obj = new Object();
			//actionform 내용
			obj.params = JSON.stringify(params);
			//첨부파일 내용
			obj.file = JSON.stringify(fileObj);
			
			$.ajax({
				type	: "post",
				url		: insertUrl,
				data: obj,
				success	: function(result) {
					if(result) {
						alert('등록/수정에 성공했습니다.');
						$('#listBtn').trigger('click');
					} else {
						alert('등록/수정에 실패했습니다.');
						return;
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
		
		$('div.file_view').on('click', function(){
			var file_info = $(this).siblings().eq(0);
			var origin = file_info.children().eq(3).val();
			var saved = file_info.children().eq(0).val();
			var download_url = "/forFaith/file/file_download?origin=" + origin + "&saved=" + saved + "&path=uploadImage";
			location.href = download_url;
		});
	}
	//유효성검사
	function checkForm() {
		if($('input[name=board_content_title]').val() == '') {
			alert('제목을 입력해주세요.');
			$('input[name=board_content_title]').focus();
			return false;
		}
		if($('#comment_editor').val().length == 0) {
			alert('내용을 입력해주세요.');
			$('#comment_editor').focus();
			return false;
		}
		return true;
	}
</script>

<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<input type="hidden" name="searchCondition" value="${search.searchCondition}">
       		<input type="hidden" name="searchKeyword" value="${search.searchKeyword}">
		</form>
		<!-- //searchForm end -->
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<dl>
				<dt>게시위치</dt>
				<dd class="half">
       				<select name="board_gb" class="searchConditionBox">
       					<option value="A0306">두잇캠퍼스</option>
       					<option value="A0307">레인보우</option>
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
       					<option value="A0400">공지사항</option>
       					<option value="A0401">동영상</option>
       					<option value="A0402">사진</option>
       					<option value="A0403">질문</option>
       				</select> 
       			</dd>
       			<dt>중요도</dt>
       			<dd class="half">
       				<select name="board_content_imp" class="searchConditionBox">
       					<option value="A1100">중요</option>
       					<option value="A1101">일반</option>
       				</select> 
       			</dd>
       			<dt>제목</dt>
       			<dd>
       				<input type="text" name="board_content_title" style="width: 100%;">
       			</dd>
				<dt>내용</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="board_content_ct" rows="10" cols="100" style="width:100%; height:200px; resize: none;"></textarea>
				</dd>
					<dt>파일#1</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file1.fileId' value='<c:out value="${board.file1.fileId}" default="" />' />
							<input type='hidden' class='upload_dir' name='upload_dir'	value='/upload/board/files' />
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
							</div>
						</div>
					</dd>
					<dt>파일#2</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file2.fileId' value='<c:out value="${board.file2.fileId}" default="" />' />
							<input type='hidden' class='upload_dir'	value='/upload/board/files' />
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M)</span>
							</div>
						</div>
					</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		<div>
			<div style="float: left; padding-right: 3px;"><a id="listBtn" class="btn align_right">리스트</a></div>
			<div id="delDiv" hidden="hidden" style="float: left; padding-right: 3px;">
				<a id="deleteBtn" class="btn align_right danger">삭제</a>
			</div>
			<div><a id="insertBtn" class="btn align_right primary">저장</a></div>
		</div>
	</div>
</div>