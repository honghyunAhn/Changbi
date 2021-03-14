<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>게시물관리</title>

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/board/popup/boardReg' />";
	var delUrl	= "<c:url value='/data/board/popup/boardDel' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 함수 영역 **/
	
	/** 이벤트 영역 **/
	// 클릭 시 상세 페이지 이동
	// 저장 버튼 클릭 시
	$("#popupRegBtn").unbind("click").bind("click", function() {
		if(confirm("저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */
			
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				success	: function(result) {
					result = $("#boardType").val() == "4" ? result.boardReply : result;

					if(result.id) {
						alert("저장되었습니다.");
						
						$("#popupListBtn").trigger("click");
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
	$("#popupDelBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						
						$("#popupListBtn").trigger("click");
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
	$("#popupListBtn").unbind("click").bind("click", function() {
		var title = $("#boardType").val() == "1" ? "공지사항" : "QnA";
		
		// ajax로 load
		openLayerPopup(title, "/admin/common/popup/boardList", $("form[name='popupSearchForm']").serialize());
	});
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
    	<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="popupSearchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='useYn' value='<c:out value="${search.useYn}" default="Y" />' />
			<input type='hidden' id='boardType' name='boardType' value='<c:out value="${search.boardType}" default="1" />' />
			<input type='hidden' name='noticeType' value='<c:out value="${search.noticeType}" default="" />' />
			<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinalId}" default="" />' />
       		<input type="hidden" name="courseId" value='<c:out value="${search.courseId}" default="" />' />
       		<input type="hidden" name="teacherId" value='<c:out value="${search.teacherId}" default="" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<form name="popupActionForm" method="post">
			<!-- board ID, 답글 ID -->
			<input type='hidden' name='id' value='<c:out value="${board.id}" default="0" />' />
			<input type='hidden' name='boardReply.id' value='<c:out value="${board.boardReply.id}" default="0" />' />
			
			<!-- 필수 정보들 -->
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="1" />' />
			<input type='hidden' name='noticeType' value='<c:out value="${search.noticeType}" default="" />' />
			<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinalId}" default="" />' />
       		<input type="hidden" name="courseId" value='<c:out value="${search.courseId}" default="" />' />
       		<input type="hidden" name="teacherId" value='<c:out value="${search.teacherId}" default="" />' />
       		
			<!-- view start -->
			<h4>본문</h4>
			<dl>
				<dt>제목</dt>
				<dd>
					<c:choose>
						<c:when test="${search.boardType ne '4'}">
							<input type='text' class='w100' name='title' value='<c:out value="${board.title}" default="" />' />
						</c:when>
						<c:otherwise>
							<c:out value="${board.title}" default="" />
						</c:otherwise>
					</c:choose>
				</dd>
				<dt>내용</dt>
				<dd>
					<c:choose>
						<c:when test="${search.boardType ne '4'}">
							<textarea class="editor" id="comment_editor" name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${board.comment}" default="" /></textarea>
						</c:when>
						<c:otherwise>
							<c:out value="${board.comment}" default="" />
						</c:otherwise>
					</c:choose>
				</dd>
			</dl>
			
			<c:if test="${search.boardType eq '4'}">
			<h4>답글</h4>
			<dl>
				<dt>제목</dt>
				<dd>
					<input type='text' class='w100' name='boardReply.title' value='<c:out value="${board.boardReply.title}" default="" />' />
				</dd>
				<dt>내용</dt>
				<dd>
					<textarea class="editor" id="reply_comment_editor" name="boardReply.comment" rows="10" cols="100" style="width:100%; height:200px;">
						<c:out value="${board.boardReply.comment}" />
		  			</textarea>
				</dd>
			</dl>
			</c:if>
		</form>
		<div>
			<a id="popupListBtn" class="btn align_right" href="javascript:void();">목록</a>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			
			<c:if test="${(search.boardType ne '4' and board.id > 0) or (search.boardType eq '4' and board.boardReply.id > 0)}">
			<a id="popupDelBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>