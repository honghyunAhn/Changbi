<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/quiz/reportUpd' />";
	var listUrl	= "<c:url value='/admin/quiz/quizAppList' />";
	var ckplus	= "http://admin.changbiedu.com:8083/ckplus/copykiller.jsp";
	
	// 컨텐츠 타이틀 세팅
	contentTitle = ( $("#quizType").val() == "1" ? "기수/과정별 출석시험 현황"
				 : ( $("#quizType").val() == "2" ? "기수/과정별 온라인시험 현황" : "기수/과정별 온라인과제 현황" ) );
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("채점 등록 하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id")
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */
			// 저장 방식(직접호출X)
			// contentLoad("회원추가", regUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result > 0) {
						alert("채점 완료 되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("채점 등록이 실패했습니다.");
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
	
	// 표절검사 상세결과 링크
	$(".answer_btn").unbind("click").bind("click", function() {
		/* var idx = $(".answer_btn").index($(this));
		
		window.open(ckplus+"?uri="+$(".copy_ratio_uri").eq(idx).val()+"&property_id="+$(".property_id").eq(idx).val()); */
		
		var idx = $(".answer_btn").index($(this));
		var reportId = $(":hidden[name='reportId']").eq(idx).val();
		
		var score = $("input[name='reportList["+idx+"].score']").val();
		
		var data = new Object();
		
		/* data.id = reportId; */
		var d = $("form[name='searchForm']").serialize();
		d += '&id=' + reportId;
		d += '&score=' + score;
		d += '&idx=' + idx;
		
		openLayerPopup("응답결과","/admin/common/popup/reportReply", d);
	});
	
	// 첨삭기능 버튼
	$(".correct_btn").unbind("click").bind("click", function() {
		var idx = $(".correct_btn").index($(this));
		var reportId = $(":hidden[name='reportId']").eq(idx).val();
		var data = new Object();
		
		data.id = reportId;
		
		openLayerPopup("첨삭", "/admin/common/popup/correctEdit", data);
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
});

</script>

<div class="content_wraper">
	<h3 class='content_title'></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="cardinal.learnType" value='<c:out value="${search.cardinal.learnType}" default="J" />' />
        	<input type="hidden" name="cardinal.name" value='<c:out value="${search.cardinal.name}" default="기수선택" />' />
        	<input type="hidden" name="course.name" value='<c:out value="${search.course.name}" default="과정선택" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- 저장 시 quiz로 받아서 처리해야 함. List 형태로 저장하기 위해 -->
			<input type="hidden" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
			<input type='hidden' name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type='hidden' name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			<input type='hidden' name="id" value='<c:out value="${search.id}" default="" />' />
		
			<table style="border-collapse: collapse;">
				<thead>
				<tr>
					<th>연번</th>
					<th>응시기간</th>
					<th>제출일시</th>
					<th>아이디</th>
					<th>성명</th>
<!-- 					<th>학교명</th> -->
					<th>점수</th>
					<th>채점</th>
					<th>채점여부</th>
					<c:if test="${search.quizType eq '3'}">
<!-- 					<th>모사율</th> -->
					<th>첨삭</th>
					<th>결과보기</th>
					</c:if>
				</tr>
				</thead>
				<tbody id="dataListBody">
				
				<c:set var="dataCount" value="${fn:length(reportList)}" />
                <c:choose>
                	<c:when test="${dataCount > 0}">
                		<c:set var="reportIdx" value="0" />
                		
						<c:forEach items="${reportList}" var="report" varStatus="status">
							<tr>
								<td>
									<c:out value="${status.count}" />
									<input type='hidden' name='reportId' value='<c:out value="${report.id}" />' />
								</td>
								<td>
									<c:out value="${report.quiz.startDate}" />~<c:out value="${report.quiz.endDate}" />
								</td>
								<td>
									<fmt:parseDate var="dateString" value="${report.regDate}" pattern="yyyyMMddHHmmss" />
									<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd hh:mm:ss" />
								</td>
								<td>
									<c:out value="${report.user.id}" />
								</td>
								<td>
									<c:out value="${report.user.name}" />
								</td>
<%-- 								<td>
									<c:out value="${report.user.schoolName}" />
								</td> --%>
								<td>
									<c:out value="${report.quiz.score}" />
								</td>
								<td>
									<c:choose>
										<c:when test="${report.quizType eq '3'}">
											<input type='hidden' name='reportList[<c:out value="${reportIdx}" />].id' value='<c:out value="${report.id}" default="0" />' />
											<input type='hidden' name='reportList[<c:out value="${reportIdx}" />].score' value='<c:out value="${report.score}" default="0" />' />
											${report.score}
											<c:set var="reportIdx" value="${reportIdx + 1}" />
										</c:when>
										<c:otherwise>
											<c:out value="${report.score}" default="0" />
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${report.markYn eq 'Y'}">채점완료</c:when>
										<c:otherwise>미채점</c:otherwise>
									</c:choose>
								</td>
								
								<c:if test="${report.quizType eq '3'}">
		<%-- 						<td>
								<c:forEach items="${report.copyRatioList}" var="copyRatio">
									<c:if test="${copyRatio.checkType eq 'report'}">
										<c:out value="${copyRatio.dispTotalCopyRatio}" default="0%" />
									</c:if>
								</c:forEach>
								</td> --%>
								<td>
									<c:choose>
										<c:when test="${not empty report.correct}">첨삭완료</c:when>
										<c:otherwise>미첨삭</c:otherwise>
									</c:choose>
									<!-- <button type='button' class='correct_btn'>첨삭</button> -->
								</td>
								<td>
								<%-- <c:forEach items="${report.copyRatioList}" var="copyRatio">
									<c:if test="${copyRatio.checkType eq 'report' and copyRatio.completeStatus eq 'Y'}"> --%>
										<%-- <input type='hidden' class='copy_ratio_uri' value='<c:out value="${copyRatio.uri}" default="" />' />
										<input type='hidden' class='property_id' value='4' /> --%>

										<button type='button' class='answer_btn'>결과보기</button>
									<%-- </c:if>
								</c:forEach> --%>
								</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="text-center" colspan="<c:choose><c:when test="${search.quizType eq '3'}">12</c:when><c:otherwise>9</c:otherwise></c:choose>">조회 된 목록이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if test="${search.quizType eq '3'}">
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			</c:if>
		</div>
	</div>
</div>