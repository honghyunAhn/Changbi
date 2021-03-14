<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/book/bookReg' />";
	var delUrl	= "<c:url value='/data/book/bookDel' />";
	var listUrl	= "<c:url value='/admin/book/bookList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	file_object[1] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		var _title	= $(":hidden[name='id']").val() && $(":hidden[name='id']").val() > 0 ? "수정" : "저장";
		
		if(!$(":text[name='name']").val()) {
			alert("교재명은 필수항목입니다.");
			
			$(":text[name='name']").focus();
		} else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// 저장 방식(직접호출X)
			// contentLoad("회원추가", regUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert(_title+"되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert(_title+"실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 삭제 버튼
	$("#delBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("정상적으로 삭제 되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("교재등록관리", listUrl, $("form[name='searchForm']").serialize());
	});
});

</script>
		
<div class="content_wraper">
	<h3>교재등록관리</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='supply.code' value='<c:out value="${search.supply.code}" default="" />' />
			<input type='hidden' name='useYn' value='<c:out value="${search.useYn}" default="" />' />
			<input type='hidden' name='mainYn' value='<c:out value="${search.mainYn}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${book.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- view start -->
			<h4>교재관리</h4>
			<dl>
				<dt>코드/구분</dt>
				<dd class='half'>
					<input type='text' value='<c:out value='${book.id}' default="0" />' disabled="disabled" />
					<select name='mainYn'>
						<option value='Y'>주교재</option>
						<option value='N' <c:if test="${book.mainYn eq 'N'}">selected</c:if>>부교재</option>
					</select>
				</dd>
				<dt>출판(공급)사</dt>
				<dd class='half'>
					<select name="supply.code">
						<option value="">교재업체선택</option>
						<c:forEach items="${publish}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq book.supply.code}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
				</dd>
				<dt>교재명<span class='require'>*</span></dt>
				<dd class="half"><input type="text" name='name' value='<c:out value='${book.name}' default="" />'></dd>
				<dt>가격/상태</dt>
				<dd class="half">
					<input type="text" name='price' value='<c:out value='${book.price}' default="0" />'>원
				</dd>
				<dt>저자</dt>
				<dd class="half"><input type="text" name='author' value='<c:out value='${book.author}' default="" />'></dd>
				<dt>판매여부</dt>
				<dd class="half">
					<select name='useYn'>
						<option value='Y'>판매</option>
						<option value='N' <c:if test="${book.useYn eq 'N'}">selected</c:if>>중지</option>
					</select>
				</dd>
				<dt>교재설명<br/>(사용자노출)</dt>
				<dd>
					<textarea class="editor" id="memo_editor" name="memo" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${book.memo}" /></textarea>
				</dd>
				<dt>이미지#1</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='img1.fileId' value='<c:out value="${book.img1.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/book/images' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE)</span>
						</div>
						
						<c:if test="${book.img1 ne null and book.img1.detailList ne null and fn:length(book.img1.detailList) > 0}">
							<c:forEach items="${book.img1.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
									<img style='width: 200px; height: 200px; cursor: pointer;' src='<c:out value="${file.urlPath}" />' />
								</div>
								<div class='file_info' style='padding-left: 5px;'>
									<input type='hidden' class='attach_file_name'			value='<c:out value="${file.fileName}" />' />
									<input type='hidden' class='attach_file_path'			value='<c:out value="${file.filePath}" />' />
									<input type='hidden' class='attach_file_size'			value='<c:out value="${file.fileSize}" default="0" />' />
									<input type='hidden' class='attach_origin_file_name'	value='<c:out value="${file.originFileName}" />' />
									<input type='hidden' class='attach_url_path'			value='<c:out value="${file.urlPath}" />' />
									<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />
								</div>
							</div>
							</c:forEach>
						</c:if>
					</div>
				</dd>
				<dt>이미지#2</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='img2.fileId' value='<c:out value="${book.img2.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/book/images' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE)</span>
						</div>
						
						<c:if test="${book.img2 ne null and book.img2.detailList ne null and fn:length(book.img2.detailList) > 0}">
							<c:forEach items="${book.img2.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
									<img style='width: 200px; height: 200px; cursor: pointer;' src='<c:out value="${file.urlPath}" />' />
								</div>
								<div class='file_info' style='padding-left: 5px;'>
									<input type='hidden' class='attach_file_name'			value='<c:out value="${file.fileName}" />' />
									<input type='hidden' class='attach_file_path'			value='<c:out value="${file.filePath}" />' />
									<input type='hidden' class='attach_file_size'			value='<c:out value="${file.fileSize}" default="0" />' />
									<input type='hidden' class='attach_origin_file_name'	value='<c:out value="${file.originFileName}" />' />
									<input type='hidden' class='attach_url_path'			value='<c:out value="${file.urlPath}" />' />
									<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />
								</div>
							</div>
							</c:forEach>
						</c:if>
					</div>
				</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if test="${not empty book.id and book.id > 0}">
				<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->