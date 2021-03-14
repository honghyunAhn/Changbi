<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/quiz/quizList' />";
	var editUrl	= "<c:url value='/admin/quiz/quizEdit' />";
	var itemUrl = "<c:url value='/admin/quiz/quizItemList' />";
	var previewUrl = "<c:url value='/admin/quiz/quizPreview' />";
	var excelUrl = "";
	
	// 컨텐츠 타이틀 세팅
	contentTitle = ( $("#quizType").val() == "1" ? "기수/과정별 출석시험 관리"
				 : ( $("#quizType").val() == "2" ? "기수/과정별 온라인시험 관리" : "기수/과정별 온라인과제 관리" ) );
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append("		<input type='hidden' name='quizPoolId' value='"+dataInfo.quizPool.id+"' />");
						sb.Append(		(i+1));
						sb.Append("	</td>");
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.title+"</td>");
						sb.Append("	<td>"+(dataInfo.quizType == "2" ? "객관식" : (dataInfo.quizType == "3" ? "주관식" : "주/객관식"))+"</td>");
						sb.Append("	<td>"+dataInfo.startDate+" ~ "+dataInfo.endDate+"</td>");
						sb.Append("	<td>"+dataInfo.examTime+"</td>");
						sb.Append("	<td>"+dataInfo.score+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "<span style='color: red;'>응시불가</span>" : "응시가능")+"</td>");
						sb.Append("	<td><a class='btn preview_btn' href='javascript:void(0);'>미리보기</a></td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='9'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 선택해주세요.");
		} else if(!$(":hidden[name='courseId']").val()) {
			alert("과정을 선택해주세요.");
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($(":hidden[name='cardinalId']").val());
			$(":hidden[name='course.id']").val($(":hidden[name='courseId']").val());
			
			setContentList();
		}
	});
	
	// 미리보기 버튼 클릭 시
	$("#dataListBody").on("click", ".preview_btn", function() {
		var idx = $(".preview_btn").index($(this));
		var popupForm = document.popupForm;
		
		$("#quizPoolId").val($(":hidden[name='quizPoolId']").eq(idx).val());

		window.open("", "openWindow", "width=800, height=600, resizable=no");
		
		popupForm.action = previewUrl;
		popupForm.target = "openWindow";
		popupForm.submit();
	});
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$("#quizId").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad(contentTitle, editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinal.id']").val() || !$(":hidden[name='course.id']").val()) {
			alert("기수와 과정 선택 후 검색을 하셔야 등록이 가능합니다.");
		} else {
			// 폼 이동(ID가 int인 경우 0을 넣어줌)
			$("#quizId").val("");
			
			// ajax로 load
			contentLoad(contentTitle, editUrl, $("form[name='searchForm']").serialize());
		}
	});
	
	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		if(!$(":hidden[name='courseId']").val()) {
			alert("과정을 먼저 선택해야 합니다.");
		} else {
			
			// 기수선택 레이어 팝업
			var data = {"learnType" : $("select[name='cardinal.learnType']").val()};
				data.learnTypes = "J,S,M";
				data.id = $(":hidden[name='courseId']").val();
			// 출석고사인 경우는 학점이 4학점만 조회
			if($("#quizType").val() == "1") {
				data.appPossibles = "4";
			}
			
			openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
		
		}
	});
	
	// 과정선택 버튼 클릭 시
	$(":text[name='course.name']").unbind("click").bind("click", function() {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data.cardinalId = $(":hidden[name='cardinalId']").val();
			data.learnTypes = $("select[name='cardinal.learnType']").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 기수와 과정이 선택되어 있다면 바로 검색
	if($(":hidden[name='cardinal.id']").val() && $(":hidden[name='course.id']").val()) {
		setContentList();
	}
});

function setCardinal(cardinal) {
	// 임시저장
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);
}

function setCourse(course) {
	// 임시저장
	$(":hidden[name='courseId']").val(course ? course.id : "");
	$(":text[name='course.name']").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3 class='content_title'></h3>
	<div class="tab_body">
		<!-- window open target form -->
		<form name='popupForm' method='post'>
			<input type="hidden" id='quizPoolId' name="id" value="" />
		</form>
		
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
        		<table class="searchTable">
					<tr>
	        			<th>과정명</th>
	        			<td>
	        				<!-- 과정 선택 -->
							<input type='text' class="inputSelect" name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
						</td>
					</tr>
					<tr>
	        			<th>기수명</th>
	        			<td>
		        			<!-- 기수 선택 -->
							<input type='text' class="inputSelect" name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td class="buttonTd" colspan="2">
							<button id='searchBtn' class="btn-primary" type="button">검색</button>
						</td>
					</tr>
				</table>
			</div>
        	<input type="hidden" id='quizId' name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />
        	<!-- quizType -->
        	<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
        	
        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="courseId" value='<c:out value="${search.course.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>시험코드</th>
				<th>시험명</th>
				<th>문제유형</th>
				<th>응시기간</th>
				<th>시험시간(분)</th>
				<th>점수</th>
				<th>상태</th>
				<th>미리보기</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>