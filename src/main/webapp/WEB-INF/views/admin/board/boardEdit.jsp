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
	var regUrl	= "<c:url value='/data/board/boardReg' />";
	var delUrl	= "<c:url value='/data/board/boardDel' />";
	var listUrl	= "<c:url value='/admin/board/boardList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[1] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		
		if (!validation()) return false;
		
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						$("#listBtn").trigger("click");
					} else {
						alert("저장실패했습니다.");
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
		contentLoad(pageTitle, listUrl, $("form[name='searchForm']").serialize());
	});
	
	var boardType = '<c:out value="${search.boardType}" />';
	var noticeType = '<c:out value="${search.noticeType}" />';
	var pageTitle;
	
	switch (boardType) {
		case '1' : 
			pageTitle = '공지사항';
			if (noticeType == '7') pageTitle = '연수모집공문관리'
			break;
		case '2' : pageTitle = '자료실관리'; break;
		case '3' : pageTitle = '자주묻는질문'; break;
		case '4' : pageTitle = '1:1상담관리'; break;
		case '5' : pageTitle = '연수후기관리'; break;
		default : pageTitle = ''; break;
	}
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html(pageTitle);
});

// 데이터 유효성 체크
function validation() {
	var faqCode = $("select[name='faqCode']");
	
	if (faqCode.length > 0 && faqCode.val() == '') {
		alert("분류를 선택하셔야 합니다.");
		return false;
	}
	
	return true;
}
</script>
		
<div class="content_wraper">
	<h3>게시물 상세</h3> 
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="" />' />
			<input type='hidden' name='noticeType' value='<c:out value="${search.noticeType}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${board.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="" />' />
			<input type='hidden' name='hits' value='<c:out value="${board.hits}" default="0" />' />
			<dl>
				<c:choose>
					<c:when test="${search.boardType eq '1' and empty search.noticeType}">
						<dt>구분</dt>
						<dd>
							<select name="noticeType">
								<option value="1" <c:if test="${board.noticeType eq '1'}">selected</c:if>>공지사항</option>
								<option value="2" <c:if test="${board.noticeType eq '2'}">selected</c:if>>이벤트</option>
							</select>
							<select name="icon">
								<option value="">ICON</option>
								<option value="1" <c:if test="${board.icon eq '1'}">selected</c:if>>NEW</option>
								<option value="2" <c:if test="${board.icon eq '2'}">selected</c:if>>HOT</option>
								<option value="3" <c:if test="${board.icon eq '3'}">selected</c:if>>신규</option>
							</select>
							<input type="checkbox" name="topYn" value="Y" <c:if test="${fn:contains(board.topYn, 'Y')}">checked="checked"</c:if> /><span>고정</span>
						</dd>
					</c:when>
					<c:when test="${search.boardType eq '1' and search.noticeType eq '7'}">
						<input type='hidden' name='noticeType' value='<c:out value="${search.noticeType}" default="" />' />
					</c:when>
				</c:choose>
				<c:if test="${search.boardType eq '3'}">
					<dt>분류</dt>
					<dd>
						<select name="faqCode">
							<option value=''>전체</option>
							<c:forEach var="vo" items="${faq}" varStatus="status">
								<option value='<c:out value="${vo.code}"/>' <c:if test="${board.faqCode eq vo.code}">selected</c:if>> <c:out value="${vo.name}"/> </option>
							</c:forEach>
						</select>
					</dd>
				</c:if>
				
				<dt>제목</dt>
				<dd>
					<input type="text" name="title" class="form-control" value="<c:out value='${board.title}'/>" />
				</dd>
				<dt>내용</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${board.comment}" /></textarea>
				</dd>
				<c:if test="${search.boardType ne '5'}">
					<dt>파일#1</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file1.fileId' value='<c:out value="${board.file1.fileId}" default="" />' />
							<input type='hidden' class='upload_dir'	value='/upload/board/files' />
							
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수: 1개, 파일크기 :100M )</span>
							</div>
							
							<c:if test="${board.file1 ne null and board.file1.detailList ne null and fn:length(board.file1.detailList) > 0}">
								<c:forEach items="${board.file1.detailList}" var="file" varStatus="status">
								<div class='file_info_area' style='float: left;'>
									<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>
										<input type='button' value='<c:out value="${file.originFileName}" />' style='width: 200px; height: 30px;' />
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
					<dt>파일#2</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file2.fileId' value='<c:out value="${board.file2.fileId}" default="" />' />
							<input type='hidden' class='upload_dir'	value='/upload/board/files' />
							
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수: 1개, 파일크기: 100M)</span>
							</div>
							
							<c:if test="${board.file2 ne null and board.file2.detailList ne null and fn:length(board.file2.detailList) > 0}">
								<c:forEach items="${board.file2.detailList}" var="file" varStatus="status">
								<div class='file_info_area' style='float: left;'>
								<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>
										<input type='button' value='<c:out value="${file.originFileName}" />' style='width: 200px; height: 30px;' />
									</div>
									<!-- 
									<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
										<img style='width: 200px; height: 200px; cursor: pointer;' src='<c:out value="${file.urlPath}" />' />
									</div>
									 -->
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
				</c:if>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
				<c:if test="${not empty board.id}">
					<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
				</c:if>
				<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->