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

<title>첨삭</title>

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

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
		if(confirm("첨삭 저장하시겠습니까?")) {
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
					if(result > 0) {
						alert("저장되었습니다.");
						
						closeLayerPopup();
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
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<!-- board ID, 답글 ID -->
			<input type='hidden' name='id' value='<c:out value="${report.id}" default="${search.id}" />' />
       		
			<!-- view start -->
			<dl>
				<dt>첨삭</dt>
				<dd>
					<textarea class="editor" id="correct_editor" name="correct" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${report.correct}" default="" /></textarea>
				</dd>
			</dl>
		</form>
		<div>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">첨삭저장</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>