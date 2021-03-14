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
	var regUrl	= "<c:url value='/data/board/boardReplyReg' />";
	var delUrl	= "<c:url value='/data/board/boardReplyDel' />";
	var originalDelUrl	= "<c:url value='/data/board/boardDel' />";
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
						contentLoad("1:1상담관리", listUrl, $("form[name='searchForm']").serialize());
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
	
	// 원글삭제 버튼 
	$("#originalDelBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: originalDelUrl,
				data 	: $("form[name='originalForm']").serialize(),
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
	
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("1:1상담관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html("1:1상담관리");
});
</script>
		
<div class="content_wraper">
	<h3>1:1상담관리</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- 원글 Form 시작 -->
		<form name="originalForm" method="post">
			<input type='hidden' name='id' value='<c:out value='${board.id}' default="0" />' />
			<!-- view start -->
			<dl>
				<dt>원글제목</dt>
				<dd>
					<input readonly type="text" name="title" class="form-control" value="<c:out value='${board.title}'/>" />
				</dd>
				<dt>원글내용</dt>
				<dd>
					<textarea readonly name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${board.comment}" /></textarea>
				</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${boardReply.id}' default="0" />' />
			<input type='hidden' name='boardId' value='<c:out value='${board.id}' default="0" />' />
			
			<!-- view start -->
			<dl>
				<dt>답글제목</dt>
				<dd>
					<input type="text" name="title" class="form-control" value="<c:out value='${boardReply.title}'/>" />
				</dd>
				<dt>답글내용</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${boardReply.comment}" /></textarea>
				</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if test="${not empty board.id}">
				<a id="originalDelBtn" class="btn align_right danger" href="javascript:void();">원글삭제</a>
			</c:if>
			<c:if test="${not empty boardReply.id}">
				<a id="delBtn" class="btn align_right danger" href="javascript:void();">답글삭제</a>
			</c:if>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>
<!-- // Navigation -->