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

<title>과제 응답</title>

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>
<!-- <link href="/resources/css/project/admin/preview.css" rel="stylesheet" type="text/css"> -->

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/quiz/popup/correctReg' />";
	
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
		if(confirm("첨삭을 저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				async: false,
				success	: function(result) {
					if(result > 0) {
						
					} else {
						alert("첨삭 저장에 실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				},
			});
			
			$.ajax({
				type	: "post",
				url		: "<c:url value='/data/quiz/reportUpd' />",
				data 	: $("form[name='quizForm']").serialize(),
				async: false,
				success	: function(result) {
					if(result > 0) {
						alert("저장되었습니다.");
						contentLoad("기수/과정별 온라인과제 현황", "<c:url value='/admin/quiz/quizAppList' />", $("form[name='returnForm']").serialize());
						closeLayerPopup();
					} else {
						alert("점수 저장에 실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
});
</script>
</head>
<!-- <style type="text/css">
#correct_editor {
	resize: none;
}

</style> -->
<body>
<div class="content_wraper" id="wrapper" style="height: 740px; overflow: auto;">
<div class="popup-header">
	<h3 class="popup-title"><c:out value="" default="" /></h3>
</div>
<div class="popup-body">
		<ol class="question-list">
			<c:forEach items="${reply}" var="item" varStatus="status">
			<c:if test="${item.ID > 0}">
			<li>
				<div class="item-header"><c:out value="${item.TITLE}" default="" escapeXml="false" /></div>
				<c:choose>
					<c:when test="${quizItem.quizBank.osType eq 'O'}">
					<ol class="item-body">
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam1}" default="보기1" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam2}" default="보기2" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam3}" default="보기3" /></label></li>
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam4}" default="보기4" /></label></li>
						
						<c:if test="${quizItem.quizBank.examType eq '2'}">
						<li><label><input type="radio" name="P001-1"><c:out value="${quizItem.quizBank.exam5}" default="보기5" /></label></li>
						</c:if>
					</ol>
					</c:when>
					<c:otherwise>
					<div class="item-body">
						<dl>
							<dt><c:out value="${item.COMMENT}" default="" escapeXml="false" /></dt>
							<dd>
								<textarea class="editor" id="correct_editor" rows="10" cols="100" disabled="disabled">${item.S_REPLY}</textarea>
							</dd>
						</dl>
					</div>
					<c:if test="${not empty item.ORIGINAL_FILE_NM}">
					<div>
						<span>제출 파일 :</span>
						<c:url value="/forFaith/file/file_download?origin=${item.ORIGINAL_FILE_NM}&saved=${item.SAVED_FILE_NM}&path=report/files/${correct.user.id}_${quiz.cardinal.id}" var="download"/>
						<a href="${download}">${item.ORIGINAL_FILE_NM}</a>
					</div>
					</c:if>
					</c:otherwise>
				</c:choose>
			</li>
			</c:if>
			</c:forEach>
		</ol>
</div>
<div>
	<form name="returnForm" method="post">
	<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
	<input type="hidden" name="quizType" value='<c:out value="${quiz.quizType}" default="2" />' />
	<input type="hidden" name="cardinal.id" value='<c:out value="${quiz.cardinal.id}" default="" />' />
    <input type="hidden" name="course.id" value='<c:out value="${quiz.course.id}" default="" />' />
    <input type="hidden" name="cardinal.learnType" value='<c:out value="${quiz.cardinal.learnType}" default="J" />' />
    <input type="hidden" name="cardinal.name" value='<c:out value="${quiz.cardinal.name}" default="기수선택" />' />
    <input type="hidden" name="course.name" value='<c:out value="${quiz.course.name}" default="과정선택" />' />
	</form>
</div>
<div>
	<form name="quizForm" method="post">
		<!-- 저장 시 quiz로 받아서 처리해야 함. List 형태로 저장하기 위해 -->
		<input type="hidden" name="quizType" value='<c:out value="${quiz.quizType}" default="2" />' />
		<input type='hidden' name="cardinal.id" value='<c:out value="${quiz.cardinal.id}" default="" />' />
		<input type='hidden' name="course.id" value='<c:out value="${quiz.course.id}" default="" />' />
		<input type='hidden' name="id" value='<c:out value="${quiz.id}" default="" />' />
		<input type='hidden' name='reportId' value='<c:out value="${report.id}" />' />	
		<div>
			<dl>
				<dt>채점 점수</dt>
				<dd>
					<c:choose>
						<c:when test="${quiz.quizType eq '3'}">
							<input type='hidden' name='reportList[${idx}].id' value='<c:out value="${correct.id}" default="0" />' />
							<input type='text' name='reportList[${idx}].score' value='<c:out value="${score}" default="0" />' />
						</c:when>
					<c:otherwise>
						<c:out value="${score}" default="0" />
					</c:otherwise>
					</c:choose>
				</dd>
			</dl>
		</div>
	</form>
</div>
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<!-- board ID, 답글 ID -->
			<input type='hidden' name='id' value='<c:out value="${correct.id}" default="${search.id}" />' />
<%--        		<c:forEach items="${reply}" var="item">
       			<input type="text" value="${item.TITLE}">
       		</c:forEach> --%>       		
			<!-- view start -->
			<dl>
				<dt>첨삭</dt>
				<dd>
					<textarea class="editor" id="correct_editor" name="correct" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${correct.correct}" default="" /></textarea>
				</dd>
			</dl>
		</form>
		<div>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>