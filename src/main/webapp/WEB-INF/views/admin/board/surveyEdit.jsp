<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/board/surveyReg' />";
	var delUrl	= "<c:url value='/data/board/surveyDel' />";
	var listUrl	= "<c:url value='/admin/board/surveyList' />";
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		
		if (!validation()) return false;
		
		if(confirm("저장하시겠습니까?")) {
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
		contentLoad("연수설문 관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

// 데이터 유효성 체크
function validation() {

	var surveyCode = $("select[name='surveyCode.code']");
	
	if (surveyCode.val() == '') {
		alert("설문유형을 선택 하셔야 합니다.");
		return false;
	}
	
	return true;
}

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
			<input type='hidden' name='seq' value='<c:out value='${survey.seq}' default="0" />' />
			<input type='hidden' name='id' value='<c:out value='${survey.id}' default="" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>등록일시</dt>
				<dd><c:out value="${survey.regDate}" /></dd>
				
				<dt>설문유형</dt>
				<dd>
					<select name="surveyCode.code">
						<option value="" selected>설문유형</option>
						<c:forEach items="${surveyCodeList}" var="surveyCode" varStatus="status">
							<option value='<c:out value="${surveyCode.code}" />' <c:if test="${surveyCode.code eq survey.surveyCode.code}">selected</c:if>><c:out value="${surveyCode.name}" /></option>
						</c:forEach>
					</select>
				</dd>
				
				<dt>설문제목</dt>
				<dd>
					<input type='text' name='title' value='<c:out value="${survey.title}" />' />
				</dd>
				<dt>게시상태</dt>
				<dd>
					<input type="radio" id="useY" name='useYn' value="Y" checked="checked"><label for="useY">서비스</label>
					<input type="radio" id="useN" name='useYn' value="N" <c:if test="${survey.useYn eq 'N'}">checked="checked"</c:if>><label for="useN">보류</label>
				</dd>
				<dt>안내머리글</dt>
				<dd class="half">
					<textarea class="editor" id="comment_editor' />" name="aLead" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${survey.aLead}" /></textarea>
				</dd>
				<dt>포함기수코드</dt>
				<dd class="half">
					<textarea readonly class="editor" id="comment_editor' />" name="readonlyConcatCardinalId" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${survey.concatCardinalId}" /></textarea>
				</dd>
			</dl>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if test="${loginUser != null and loginUser.grade != 1}">
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>