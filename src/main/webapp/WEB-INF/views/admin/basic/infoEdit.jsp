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
	var regUrl	= "<c:url value='/data/basic/infoReg' />";
	var delUrl	= "<c:url value='/data/basic/infoDel' />";
	var listUrl	= "<c:url value='/admin/basic/infoList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	//file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
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
		contentLoad("이벤트관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>
		
<div class="content_wraper">
	<h3>타이틀</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${info.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>테마명</dt>
				<dd class="half">
					<select name="themaType">
						<option value="1" <c:if test="${info.themaType eq '1'}">selected="selected"</c:if>>회원약관</option>
						<option value="2" <c:if test="${info.themaType eq '2'}">selected="selected"</c:if>>개인정보보호정책</option>
						<option value="3" <c:if test="${info.themaType eq '3'}">selected="selected"</c:if>>소개</option>
						<option value="4" <c:if test="${info.themaType eq '4'}">selected="selected"</c:if>>연혁</option>
						<option value="5" <c:if test="${info.themaType eq '5'}">selected="selected"</c:if>>조직도</option>
						<option value="6" <c:if test="${info.themaType eq '6'}">selected="selected"</c:if>>찾아오시는길</option>
						<option value="7" <c:if test="${info.themaType eq '7'}">selected="selected"</c:if>>규정</option>
						<option value="8" <c:if test="${info.themaType eq '8'}">selected="selected"</c:if>>교육부인가서</option>
					</select>
				</dd>
				<dt>표출우선순위</dt>
				<dd class="half">
					<input type='number' name='showOrderNum' placeholder='1~999' value='<c:out value="${info.showOrderNum}" default="1" />' />
				</dd>
				<dt>노출기간</dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='showStartDate'>
	                    <input type='text' name='showStartDate' class='form-control' value='<c:out value="${info.showStartDate}" />' /> 
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
	                <div class='input-group date datetimepicker' id='showEndDate'>
	                    <input type='text' name='showEndDate' class='form-control' value='<c:out value="${info.showEndDate}" />' /> 
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>승인상태</dt>
				<dd class="half">
					<select name="approvalStatus">
						<option value="1" <c:if test="${info.approvalStatus eq '1'}">selected="selected"</c:if>>노출보류</option>
						<option value="2" <c:if test="${info.approvalStatus eq '2'}">selected="selected"</c:if>>서비스</option>
					</select>
				</dd>
				<dt>컨텐츠 내용</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="contents" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${info.contents}" /></textarea>
				</dd>
			</dl>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- // Navigation -->