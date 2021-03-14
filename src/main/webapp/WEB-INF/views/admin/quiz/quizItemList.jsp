<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
var refreshList = null;

$(document).ready(function() {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/quiz/quizItemList' />";
	var regUrl = "<c:url value='/data/quiz/quizItemReg' />";
	var delUrl = "<c:url value='/data/quiz/quizItemDel' />";
	var quizPoolUrl = "<c:url value='/admin/quiz/quizPoolList' />";
	var previewUrl = "<c:url value='/admin/quiz/quizPreview' />";
	
	// 컨텐츠 타이틀 세팅
	contentTitle = ( $("#quizType").val() == "1" ? "출석시험 시험지풀관리"
				 : ( $("#quizType").val() == "2" ? "온라인시험 시험지풀관리" : "온라인과제 시험지풀관리" ) );
	
	// osType을 세팅한다.
	$("#osType").val($("#quizType").val() == "3" ? "S" : "O");
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='actionForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						sb.Append("<tr>");
						sb.Append(" <input type='hidden' name='chkId' value='"+dataInfo.id+"' />");
						sb.Append(" <input type='hidden' name='quizBankList["+i+"].id' value='"+dataInfo.quizBank.id+"' />");
						sb.Append("	<td class='order_num'>"+dataInfo.orderNum+"</td>");
						sb.Append("	<td class='os_type'>"+(dataInfo.quizBank.osType == "O" ? "객관식" : "주관식")+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.quizBank.title+"</td>");
						sb.Append("</tr>");
					}
				}
				
				$("#dataListBody").html(sb.ToString());
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/	
	// 클릭 시 분류 세팅
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 값 세팅
		$("#quizItemId").val($(":hidden[name='chkId']").eq(idx).val());
		$(":hidden[name='quizBank.id']").val($(":hidden[name^='quizBankList']").eq(idx).val());
		
		openLayerPopup(contentTitle, "/admin/common/popup/quizItemEdit", $("form[name='actionForm']").serialize());
	});
	
	// 페이지 이벤트 등록(추가 버튼 클릭 시)
	$("#addBtn").unbind("click").bind("click", function() {
		$("#quizItemId").val("0");
		$(":hidden[name='quizBank.id']").val("0");
		
		openLayerPopup(contentTitle, "/admin/common/popup/quizItemEdit", $("form[name='actionForm']").serialize());
	});
	
	$("#bankBtn").unbind("click").bind("click", function() {
		openLayerPopup(contentTitle, "/admin/common/popup/quizBankList", $("form[name='actionForm']").serialize());
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad(contentTitle, quizPoolUrl, $("form[name='searchForm']").serialize());
	});
	
	// 미리보기 버튼 클릭 시
	$("#previewBtn").unbind("click").bind("click", function() {
		var popupForm = document.popupForm;
		
		window.open("", "openWindow", "width=800, height=600, resizable=no");
		
		popupForm.action = previewUrl;
		popupForm.target = "openWindow";
		popupForm.submit();
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 외부 함수에 내부 함수 연결
	refreshList = setContentList;
	
	// 처음 리스트 생성
	setContentList();
});
 
</script>

<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">	<!-- quiz 기준 -->
       		<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
       		<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="과정선택" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- window open target form -->
		<form name='popupForm' method='post'>
			<input type="hidden" id='quizPoolId' name="id" value="<c:out value="${quizPool.id}" default="" />" />
		</form>
		
		<!-- actionForm start -->
       	<form name="actionForm" method="post">	<!-- quizItem 기준 -->
       		<input type="hidden" id="quizItemId" name="id" value="0" />
	       	<input type="hidden" name="quizPool.id" value="<c:out value="${quizPool.id}" default="" />" />
	       	<input type="hidden" name="quizPool.title" value="<c:out value="${quizPool.title}" default="" />" />
	       	<input type="hidden" name="quizBank.id" value="0" />
       		<input type="hidden" name="quizBank.course.id" value='<c:out value="${search.course.id}" default="" />' />
	       	<input type="hidden" name="quizBank.quizType" value='<c:out value="${search.quizType}" default="2" />' />
	       	<input type="hidden" id="osType" name="quizBank.osType" value='O' />
			
			<h4>시험정보</h4>
			<dl>
				<dt>시험지풀명</dt>
				<dd class="half">
					<c:out value="${quizPool.title}" default="" />
				</dd>
				<dt>문제유형</dt>
				<dd class="half">
					<c:choose>
						<c:when test="${search.quizType eq '2'}">객관식</c:when>
						<c:when test="${search.quizType eq '3'}">주관식</c:when>
						<c:otherwise>주/객관식</c:otherwise>
					</c:choose>
				</dd>
				<dt>과정코드</dt>
				<dd class="half">
					<input type='hidden' name="course.id" value='<c:out value="${quizPool.course.id}" default="${search.course.id}" />' />
					<c:out value="${quizPool.course.id}" default="${search.course.id}" />
				</dd>
				<dt>과정명</dt>
				<dd class="half">
					<c:out value="${quizPool.course.name}" default="${search.course.name}" />
				</dd>
			</dl>
			
			<table style="border-collapse: collapse;">
				<thead>
				<tr>
					<th>문항번호</th>
					<th>문제유형</th>
					<th>문제명</th>
				</tr>
				</thead>
				<tbody id="dataListBody"></tbody>
			</table>
		</form>
		<!-- //actionForm end -->
		
		<div>
			<a id="previewBtn" class="btn align_left" href="javascript:void();">문제지 미리보기</a>
			<a id="listBtn" class="btn align_left primary" href="javascript:void();">리스트</a>
			<a id="bankBtn" class="btn align_right primary" href="javascript:void();">문제은행출제</a>
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규문제등록</a>
		</div>
	</div>
</div>
