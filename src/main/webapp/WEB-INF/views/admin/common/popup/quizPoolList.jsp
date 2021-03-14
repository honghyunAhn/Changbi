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

<title>시험지 풀 리스트 팝업</title>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/quiz/quizPoolList' />";
	var previewUrl = "<c:url value='/admin/quiz/quizPreview' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='popupSearchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var quizItemCnt = 0;
						
						if(dataInfo.quizItemList) {
							for(var j=0; j<dataInfo.quizItemList.length; ++j) {
								if(dataInfo.quizItemList[j].id) {
									++quizItemCnt;
								}
							}
						}
						
						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='popupId' value='"+dataInfo.id+"' />");
						sb.Append("	<input type='hidden' name='popupTitle' value='"+dataInfo.title+"' />");
						sb.Append("	<td>");
						sb.Append(		(i+1));
						sb.Append("	</td>");
						sb.Append("	<td>"+(dataInfo.quizType == "2" ? "객관식" : (dataInfo.quizType == "3" ? "주관식" : "주/객관식"))+"</td>");
						sb.Append("	<td class='popup_content_edit'>"+dataInfo.title+"</td>");
						sb.Append("	<td>"+quizItemCnt+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "<span style='color: red;'>사용불가</span>" : "사용가능")+"</td>");
						sb.Append("	<td><a class='btn popup_preview_btn' href='javascript:void(0);'>미리보기</a></td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	$("#popupDataListBody").on("click", ".popup_preview_btn", function() {
		var idx = $(".popup_preview_btn").index($(this));
		
		var popupForm = document.popupSearchForm;
		
		$(":hidden[name='id']").val($(":hidden[name='popupId']").eq(idx).val());

		window.open("", "openWindow", "width=800, height=600, resizable=no");
		
		popupForm.action = previewUrl;
		popupForm.target = "openWindow";
		popupForm.submit();
	});
	
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		
		// 부모의 함수 호출해준다.
		var quizPool =	{ "id" : $(":hidden[name='popupId']").eq(idx).val()
						, "title" : $(":hidden[name='popupTitle']").eq(idx).val() };
		
		setQuizPool(quizPool);
		
		closeLayerPopup();
	});
	
	setContentList();
});

</script>
</head>

<body>
<div id="wrapper">
    <div>
        <div>
        	<!-- popupUserSearchForm start -->
        	<form name="popupSearchForm" method="post" class="form-inline" onsubmit="return false;">
	        	<input type="hidden" name="id" value="0" />
	        	
	        	<!-- pagingYn(페이징 처리 안함) -->
	        	<input type="hidden" name="pagingYn" value='N' />
	        	
	        	<!-- useYn(사용가능만 조회) -->
	        	<input type="hidden" name="useYn" value='Y' />
	        	
	        	<!-- quizType -->
        		<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />

				<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        		<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>연번</th>
						<th>문제유형</th>
						<th>시험지풀명</th>
						<th>문항수</th>
						<th>상태</th>
						<th>미리보기</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody"></tbody>
				</table>
			</div>
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>