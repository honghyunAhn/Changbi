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
	var regUrl	= "<c:url value='/data/quiz/quizReg' />";
	var updUrl	= "<c:url value='/data/quiz/quizUpd' />";
	var listUrl	= "<c:url value='/admin/quiz/quizList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	// 컨텐츠 타이틀 세팅
	contentTitle	= ( $("#quizType").val() == "1" ? "기수/과정별 출석시험 관리" 
					: ( $("#quizType").val() == "2" ? "기수/과정별 온라인시험 관리" : "기수/과정별 온라인과제 관리" ) );
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		var _title	= $(":hidden[name='id']").val() ? "수정" : "저장";
		var _url	= $(":hidden[name='id']").val() ? updUrl : regUrl;
		
		if(!$(":text[name='title']").val()) {
			alert("시험명은 필수항목입니다.");
			
			$(":text[name='title']").focus();
		} else if(!$(":hidden[name='quizPool.id']").val() || $(":hidden[name='quizPool.id']").val() == "0") {
			alert("시험지풀 등록은 필수항목입니다.");
		} else if(!$(":text[name='examTime']").val()) {
			alert("시험시간은 필수항목입니다.");
			
			$(":text[name='examTime']").focus();
		} else if(!$(":text[name='score']").val()) {
			alert("점수는 필수항목입니다.");
			
			$(":text[name='score']").focus();
		} else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: _url,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(_title == "저장" ? result.id : result > 0) {
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
	
	// 시험지 풀 버튼 클릭 시
	$(":text[name='quizPool.title']").unbind("click").bind("click", function() {
		// 제출자 수
		var submit = Number($(":hidden[name='submit']").val());
		
		if(submit > 0) {
			alert("이미 응시자가 있습니다. 변경할 수 없습니다.");
		} else {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data["course.id"] = $("#courseId").val();
			data.quizType = $("#quizType").val();
			
			openLayerPopup("시험지풀검색", "/admin/common/popup/quizPoolList", data);
		}
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
});

function setQuizPool(quizPool) {
	// 임시저장
	$(":hidden[name='quizPool.id']").val(quizPool.id);
	$(":text[name='quizPool.title']").val(quizPool.title);
}

</script>
	
<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="cardinal.learnType" value='<c:out value="${search.cardinal.learnType}" default="J" />' />
        	<input type="hidden" name="cardinal.name" value='<c:out value="${search.cardinal.name}" default="기수선택" />' />
        	<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="과정선택" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<input type="hidden" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			
			<!-- 시험 제출 여부 -->
			<input type="hidden" name="submit" value='<c:out value="${quiz.submit}" default="0" />' />
			
			<!-- 기수코드/과정코드/시험코드 -->
			<input type='hidden' name="id" value='<c:out value="${quiz.id}" default="" />' />
			<input type='hidden' name="cardinal.id" value='<c:out value="${quiz.cardinal.id}" default="${search.cardinal.id}" />' />
			<input type='hidden' name="course.id" value='<c:out value="${quiz.course.id}" default="${search.course.id}" />' />
			
			<!-- view start -->
			<h4>시험등록</h4>
			<dl>
				<dt>기수명</dt>
				<dd class='half'>
					<c:out value="${quiz.cardinal.name}" default="${search.cardinal.name}" />
				</dd>
				<dt>과정명</dt>
				<dd class='half'>
					<c:out value="${quiz.course.name}" default="${search.course.name}" />
				</dd>
				<dt>시험명<span class="require">*</span></dt>
				<dd>
					<input type='text' class='w100' name="title" value='<c:out value="${quiz.title}" default="" />' />
				</dd>
				<dt>시험지풀<span class="require">*</span></dt>
				<dd class="half">
					<!-- 시험지 풀 선택 -->
					<input type="hidden" name="quizPool.id" value='<c:out value="${quiz.quizPool.id}" default="0" />' />
					<input type='text' name='quizPool.title' value='<c:out value="${quiz.quizPool.title}" default="시험지풀선택" />' readonly="readonly" />
				</dd>
				<dt>시험기간</dt>
				<dd class="half">
					<div class='input-group date datetimepicker col-md-5' id='startDate'>
	                    <input type='text' name='startDate' class='form-control' value='<c:out value="${quiz.startDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
               		~
               		<div class='input-group date datetimepicker col-md-5' id='endDate'>
	                    <input type='text' name='endDate' class='form-control' value='<c:out value="${quiz.endDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>시험시간<span class="require">*</span></dt>
				<dd class="half">
					<input type='text' name="examTime" value='<c:out value="${quiz.examTime}" default="100" />' />분
				</dd>
				<dt>점수<span class="require">*</span></dt>
				<dd class="half">
					<input type='text' name="score" value='<c:out value="${quiz.score}" default="" />' />점
				</dd>
				<dt>시험상태</dt>
				<dd class="half">
					<select name="useYn">
						<option value="Y">응시</option>
						<option value="N" <c:if test="${'N' eq quiz.useYn}">selected</c:if>>미응시</option>
					</select>
				</dd>
				<dt>답안공개</dt>
				<dd class="half">
					<select name="openYn">
						<option value="N">비공개</option>
						<option value="Y" <c:if test="${'Y' eq quiz.openYn}">selected</c:if>>공개</option>
					</select>
				</dd>
				<dt>시험안내글</dt>
				<dd>
					<textarea class="editor" id="guide_editor" name="guide" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quiz.guide}" /></textarea>
				</dd>
				<dt>제한기능</dt>
				<dd class="half">
					<input type="checkbox" name="limits" value="1" <c:choose><c:when test="${empty quiz.limits}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limits, '1')}">checked="checked"</c:when></c:choose> /><span>시간제한사용</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limits" value="2" <c:if test="${fn:contains(quiz.limits, '2')}">checked="checked"</c:if> /><span>재응시허용</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limits" value="3" <c:choose><c:when test="${empty quiz.limits}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limits, '3')}">checked="checked"</c:when></c:choose> /><span>타PC작업제한</span>
				</dd>
				<dt>제한키</dt>
				<dd class="half">
					<input type="checkbox" name="limitKeys" value="1" <c:choose><c:when test="${empty quiz.limitKeys}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limitKeys, '1')}">checked="checked"</c:when></c:choose> /><span>Ctrl+C</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limitKeys" value="2" <c:choose><c:when test="${empty quiz.limitKeys}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limitKeys, '2')}">checked="checked"</c:when></c:choose> /><span>Ctrl+P</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limitKeys" value="3" <c:choose><c:when test="${empty quiz.limitKeys}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limitKeys, '3')}">checked="checked"</c:when></c:choose> /><span>Ctrl+V</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limitKeys" value="5" <c:choose><c:when test="${empty quiz.limitKeys}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limitKeys, '5')}">checked="checked"</c:when></c:choose> /><span>Ctrl+F</span>
					<span>&nbsp;</span>
					<input type="checkbox" name="limitKeys" value="4" <c:choose><c:when test="${empty quiz.limitKeys}">checked="checked"</c:when><c:when test="${fn:contains(quiz.limitKeys, '4')}">checked="checked"</c:when></c:choose> /><span>우마우스클릭</span>
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

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->