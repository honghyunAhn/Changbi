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
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/quiz/quizBankReg' />";
	var delUrl	= "<c:url value='/data/quiz/quizBankDel' />";
	var listUrl	= "<c:url value='/admin/quiz/quizBankList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	// 컨텐츠 타이틀 세팅
	contentTitle	= ( $("#quizType").val() == "1" ? "출석시험 문제은행관리" 
					: ( $("#quizType").val() == "2" ? "온라인시험 문제은행관리" : "온라인과제 문제은행관리" ) );
	
	/** 함수 영역 **/
	
	/** 이벤트 영역 **/
	// 클릭 시 상세 페이지 이동
	// 저장 버튼 클릭 시
	$("#regBtn").unbind("click").bind("click", function() {
		if(confirm("저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */
			
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						
						// 리스트 페이지로 이동
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
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						
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
		contentLoad(contentTitle, listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 보기 선택
	$(":radio[name='examType']").unbind("click").bind("click", function() {
		if($(this).val() == "1") {
			$(".exam_type").hide();
			
			if($("select[name='oAnswer']").val() == "5") {
				$("select[name='oAnswer']").val("4");
			}
		} else {
			$(".exam_type").show();
		}
	});
	
	// osType 변경 시
	$("select[name='osType']").unbind("change").bind("change", function() {
		// quizBank.osType 이 주관식일 경우와 객관식일 경우 보여주는 항목이 틀림
		if($(this).val() == "O") {
			$(".subjective").hide();
			$(".objective").show();
			
			// examType에 따른 변화 처리
			if($(":radio[name='examType']:checked").val() == "1") {
				$(".exam_type").hide();
			}
		} else {
			$(".subjective").show();
			$(".objective").hide();
		}
	});
	
	// osType 이 주관식일 경우와 객관식일 경우 보여주는 항목이 틀림
	if($("form[name='actionForm'] [name='osType']").val() == "O") {
		$(".subjective").hide();
		$(".objective").show();
		
		// examType에 따른 변화 처리
		if($(":radio[name='examType']:checked").val() == "1") {
			$(".exam_type").hide();
		}
	} else {
		$(".subjective").show();
		$(".objective").hide();
	}
	
	// examType에 따른 변화 처리
	if($(":radio[name='examType']:checked").val() == "1") {
		$(".exam_type").hide();
	} else {
		$(".exam_type").show();
	}
	
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":hidden[name='id']").val() || $(":hidden[name='id']").val() == "0") {
		$("#delBtn").hide();
	}
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
});

</script>
</head>

<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			<input type="hidden" name="osType" value='<c:out value="${search.osType}" default="O" />' />
			<%-- <input type="hidden" name="classType" value='<c:out value="${search.classType}" default="" />' /> --%>
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="과정선택" />' />
		</form>
		<!-- //searchForm end -->
		
		<form name="actionForm" method="post">
			<input type="hidden" name="id" value="<c:out value="${search.id}" default="0" />" />
	       	<input type='hidden' name="course.id" value='<c:out value="${search.course.id}" default="" />' />
	       	<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
	       	
	       	<c:if test="${search.quizType ne '1'}"> <!-- 출석고사가 아닌경우 객관/주관식이 정해져있음 -->
	       	<input type="hidden" name="osType" value='<c:out value="${search.osType}" default="O" />' />
	       	</c:if>
	       	
			<!-- view start -->
			<dl>
				<dt>교육과정</dt>
				<dd>
					<c:out value="${quizBank.course.name}" default="${search.course.name}" />
				</dd>
				<%-- <dt>문제유형</dt>
				<dd>
					<select name='classType'>
						<option value=''>문제유형선택</option>
						<option value='A' <c:if test="${quizBank.classType eq 'A'}">selected</c:if>>A형</option>
						<option value='B' <c:if test="${quizBank.classType eq 'B'}">selected</c:if>>B형</option>
						<option value='C' <c:if test="${quizBank.classType eq 'C'}">selected</c:if>>C형</option>
					</select>
				</dd> --%>
				<dt>문항번호</dt>
				<dd>
					<input type='text' name='orderNum' value='<c:out value="${quizBank.orderNum}" default="1" />' />
				</dd>
				<c:if test="${search.quizType eq '1'}"> <!-- 출석고사인 경우 주관식인지 객관식인지 본인이 체크해야함 -->
				<dt>객관/주관식</dt>
				<dd>
					<select name='osType'>
						<option value='S'>주관식</option>
						<option value='O' <c:if test="${quizBank.osType eq 'O'}">selected="selected"</c:if>>객관식</option>
					</select>
				</dd>
				</c:if>
				<dt class='objective'>보기</dt>
				<dd class='objective'>
					<input type="radio" id="examType1" name='examType' value="1" checked="checked"><label for="examType1">4지선다</label>
					/
					<input type="radio" id="examType2" name='examType' value="2" <c:if test="${quizBank.examType eq '2'}">checked="checked"</c:if>><label for="examType2">5지선다</label>					
				</dd>
				<dt>문제</dt>
				<dd>
					<textarea class="editor" id="title_editor" name="title" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizBank.title}" /></textarea>
				</dd>
				<dt>보충설명</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizBank.comment}" /></textarea>
				</dd>
				<dt class='subjective'>주관식정답</dt>
				<dd class='subjective'>
					<textarea class="editor" id="sAnswer_editor" name="sAnswer" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${quizBank.sAnswer}" /></textarea>
				</dd>
				<dt class='objective'>1번보기</dt>
				<dd class='objective'>
					<textarea name="exam1"><c:out value="${quizBank.exam1}" /></textarea>
				</dd>
				<dt class='objective'>2번보기</dt>
				<dd class='objective'>
					<textarea name="exam2"><c:out value="${quizBank.exam2}" /></textarea>
				</dd>
				<dt class='objective'>3번보기</dt>
				<dd class='objective'>
					<textarea name="exam3"><c:out value="${quizBank.exam3}" /></textarea>
				</dd>
				<dt class='objective'>4번보기</dt>
				<dd class='objective'>
					<textarea name="exam4"><c:out value="${quizBank.exam4}" /></textarea>
				</dd>
				<dt class='objective exam_type'>5번보기</dt>
				<dd class='objective exam_type'>
					<textarea name="exam5"><c:out value="${quizBank.exam5}" /></textarea>
				</dd>
				<dt class='objective'>객관식정답</dt>
				<dd class='objective'>
					<select name='oAnswer'>
						<option value="1">1번</option>
						<option value="2" <c:if test="${quizBank.oAnswer eq '2'}">selected="selected"</c:if>>2번</option>
						<option value="3" <c:if test="${quizBank.oAnswer eq '3'}">selected="selected"</c:if>>3번</option>
						<option value="4" <c:if test="${quizBank.oAnswer eq '4'}">selected="selected"</c:if>>4번</option>
						<option class='exam_type' value="5" <c:if test="${quizBank.oAnswer eq '5'}">selected="selected"</c:if>>5번</option>
					</select>
				</dd>
				<dt>난이도</dt>
				<dd>
					<select name='quizLevel'>
						<option value="3">상</option>
						<option value="2" <c:if test="${quizBank.quizLevel eq '2'}">selected="selected"</c:if>>중</option>
						<option value="1" <c:if test="${quizBank.quizLevel eq '1'}">selected="selected"</c:if>>하</option>
					</select>
				</dd>
			</dl>
		</form>
		<div>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			<c:if test="${loginUser != null and loginUser.grade != 1}">
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>