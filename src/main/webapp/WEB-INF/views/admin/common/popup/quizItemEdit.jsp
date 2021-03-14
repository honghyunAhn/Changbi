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

<title>문제출제</title>

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/quiz/quizItemReg' />";
	var delUrl	= "<c:url value='/data/quiz/quizItemDel' />";
	
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
					if(result.id) {
						alert("저장되었습니다.");
						
						closeLayerPopup();
						
						// 부모함수 호출
						refreshList();
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
						
						closeLayerPopup();
						
						// 부모함수 호출
						refreshList();
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
	
	// 보기 선택
	$(":radio[name='quizBank.examType']").unbind("click").bind("click", function() {
		if($(this).val() == "1") {
			$(".exam_type").hide();
			
			if($("select[name='quizBank.oAnswer']").val() == "5") {
				$("select[name='quizBank.oAnswer']").val("4");
			}
		} else {
			$(".exam_type").show();
		}
	});
	
	// osType 변경 시
	$("select[name='quizBank.osType']").unbind("change").bind("change", function() {
		// quizBank.osType 이 주관식일 경우와 객관식일 경우 보여주는 항목이 틀림
		if($(this).val() == "O") {
			$(".subjective").hide();
			$(".objective").show();
			
			// examType에 따른 변화 처리
			if($(":radio[name='quizBank.examType']:checked").val() == "1") {
				$(".exam_type").hide();
			}
		} else {
			$(".subjective").show();
			$(".objective").hide();
		}
	});	
	
	// quizBank.osType 이 주관식일 경우와 객관식일 경우 보여주는 항목이 틀림
	if($("[name='quizBank.osType']").val() == "O") {
		$(".subjective").hide();
		$(".objective").show();
		
		// examType에 따른 변화 처리
		if($(":radio[name='quizBank.examType']:checked").val() == "1") {
			$(".exam_type").hide();
		}
	} else {
		$(".subjective").show();
		$(".objective").hide();
	}
	
	// examType에 따른 변화 처리
	if($(":radio[name='quizBank.examType']:checked").val() == "1") {
		$(".exam_type").hide();
	} else {
		$(".exam_type").show();
	}
	
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":hidden[name='id']").val() || $(":hidden[name='id']").val() == "0") {
		$("#popupDelBtn").hide();
	}
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<input type="hidden" name="id" value="<c:out value="${quizItem.id}" default="${search.id}" />" />
			<input type="hidden" name="quizPool.id" value="<c:out value="${quizItem.quizPool.id}" default="${search.quizPool.id}" />" />
			<input type="hidden" name="quizBank.id" value="<c:out value="${quizItem.quizBank.id}" default="${search.quizBank.id}" />" />
			<input type="hidden" name="quizBank.course.id" value="<c:out value="${quizItem.quizBank.course.id}" default="${search.quizBank.course.id}" />" />
	       	<input type="hidden" name="quizBank.quizType" value='<c:out value="${quizItem.quizBank.quizType}" default="${search.quizBank.quizType}" />' />
	       	
	       	<c:if test="${search.quizBank.quizType ne '1'}"> <!-- 출석고사가 아닌경우 객관/주관식이 정해져있음 -->
	       	<input type="hidden" name="quizBank.osType" value='<c:out value="${quizItem.quizBank.osType}" default="${search.quizBank.osType}" />' />
	       	</c:if>
	       	
			<!-- view start -->
			<dl>
				<dt>문항번호<span class='require'>*</span></dt>
				<dd>
					<input type='text' name='orderNum' value='<c:out value="${quizItem.orderNum}" default="1" />' />
				</dd>
				
				<c:if test="${search.quizBank.quizType eq '1'}"> <!-- 출석고사인 경우 주관식인지 객관식인지 본인이 체크해야함 -->
				<dt>객관/주관식</dt>
				<dd>
					<select name='quizBank.osType'>
						<option value='S'>주관식</option>
						<option value='O' <c:if test="${quizItem.quizBank.osType eq 'O'}">selected="selected"</c:if>>객관식</option>
					</select>
				</dd>
				</c:if>
				
				<dt class='objective'>보기</dt>
				<dd class='objective'>
					<input type="radio" id="examType1" name='quizBank.examType' value="1" checked="checked"><label for="examType1">4지선다</label>
					/
					<input type="radio" id="examType2" name='quizBank.examType' value="2" <c:if test="${quizItem.quizBank.examType eq '2'}">checked="checked"</c:if>><label for="examType2">5지선다</label>					
				</dd>
				<dt>문제<span class='require'>*</span></dt>
				<dd>
					<textarea class="editor" id="title_editor" name="quizBank.title" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizItem.quizBank.title}" /></textarea>
				</dd>
				<dt>보충설명</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="quizBank.comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizItem.quizBank.comment}" /></textarea>
				</dd>
				<dt class='subjective'>주관식정답</dt>
				<dd class='subjective'>
					<textarea class="editor" id="sAnswer_editor" name="quizBank.sAnswer" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizItem.quizBank.sAnswer}" /></textarea>
				</dd>
				<dt class='objective'>1번보기</dt>
				<dd class='objective'>
					<textarea name="quizBank.exam1"><c:out value="${quizItem.quizBank.exam1}" /></textarea>
				</dd>
				<dt class='objective'>2번보기</dt>
				<dd class='objective'>
					<textarea name="quizBank.exam2"><c:out value="${quizItem.quizBank.exam2}" /></textarea>
				</dd>
				<dt class='objective'>3번보기</dt>
				<dd class='objective'>
					<textarea name="quizBank.exam3"><c:out value="${quizItem.quizBank.exam3}" /></textarea>
				</dd>
				<dt class='objective'>4번보기</dt>
				<dd class='objective'>
					<textarea name="quizBank.exam4"><c:out value="${quizItem.quizBank.exam4}" /></textarea>
				</dd>
				<dt class='objective exam_type'>5번보기</dt>
				<dd class='objective exam_type'>
					<textarea name="quizBank.exam5"><c:out value="${quizItem.quizBank.exam5}" /></textarea>
				</dd>
				<dt class='objective'>객관식정답</dt>
				<dd class='objective'>
					<select name='quizBank.oAnswer'>
						<option value="1">1번</option>
						<option value="2" <c:if test="${quizItem.quizBank.oAnswer eq '2'}">selected="selected"</c:if>>2번</option>
						<option value="3" <c:if test="${quizItem.quizBank.oAnswer eq '3'}">selected="selected"</c:if>>3번</option>
						<option value="4" <c:if test="${quizItem.quizBank.oAnswer eq '4'}">selected="selected"</c:if>>4번</option>
						<option class='exam_type' value="5" <c:if test="${quizItem.quizBank.oAnswer eq '5'}">selected="selected"</c:if>>5번</option>
					</select>
				</dd>
				<dt>난이도</dt>
				<dd>
					<select name='quizBank.quizLevel'>
						<option value="3">상</option>
						<option value="2" <c:if test="${quizItem.quizBank.quizLevel eq '2'}">selected="selected"</c:if>>중</option>
						<option value="1" <c:if test="${quizItem.quizBank.quizLevel eq '1'}">selected="selected"</c:if>>하</option>
					</select>
				</dd>
			</dl>
		</form>
		<div>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			<c:if test="${loginUser != null and loginUser.grade != 1}">
			<a id="popupDelBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>