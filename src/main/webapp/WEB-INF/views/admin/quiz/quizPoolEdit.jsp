<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/quiz/quizPoolReg' />";
	var listUrl	= "<c:url value='/admin/quiz/quizPoolList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	// 컨텐츠 타이틀 세팅
	contentTitle = ( $("#quizType").val() == "1" ? "출석시험 시험지풀관리"
				 : ( $("#quizType").val() == "2" ? "온라인시험 시험지풀관리" : "온라인과제 시험지풀관리" ) );
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		var _title	= $(":hidden[name='id']").val() != 0 ? "수정" : "저장";
		var _url	= regUrl;
		
		if(!$(":text[name='title']").val()) {
			alert("시험지풀명은 필수항목입니다.");
			
			$(":text[name='title']").focus();
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
				url		: _url,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert(_title+"되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert(gubun+"실패했습니다.");
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
		contentLoad(contentTitle, listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
});

</script>
	
<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="과정선택" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<input type="hidden" name="id" value='<c:out value="${quizPool.id}" default="0" />' />
			<input type="hidden" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			
			<!-- view start -->
			<h4>시험지풀등록</h4>
			<dl>
				<dt>과정명</dt>
				<dd>
					<input type='hidden' name="course.id" value='<c:out value="${quizPool.course.id}" default="${search.course.id}" />' />
					<c:out value="${quizPool.course.name}" default="${search.course.name}" />
				</dd>
				<dt>시험지풀명<span class='require'>*</span></dt>
				<dd class="half">
					<input type='text' class='w100' name="title" value='<c:out value="${quizPool.title}" default="" />' />
				</dd>
				<dt>상태</dt>
				<dd class="half">
					<select name="useYn">
						<option value="Y">사용가능</option>
						<option value="N" <c:if test="${'N' eq quizPool.useYn}">selected</c:if>>사용불가</option>
					</select>
				</dd>
			</dl>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>