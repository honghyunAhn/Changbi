<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
var refreshList = null;

$(document).ready(function() {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/quiz/quizBankList' />";
	var editUrl	= "<c:url value='/admin/quiz/quizBankEdit' />";
	
	// 컨텐츠 타이틀 세팅
	contentTitle	= ( $("#quizType").val() == "1" ? "출석시험 문제은행관리" 
					: ( $("#quizType").val() == "2" ? "온라인시험 문제은행관리" : "온라인과제 문제은행관리" ) );
	
	// osType을 세팅한다.
	$("#osType").val($("#quizType").val() == "3" ? "S" : "O");
	
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
					var dataList = result.list;;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var level = dataInfo.quizLevel == "3" ? "上" : (dataInfo.quizLevel == "2" ? "中" : "下");
						var total = 0;
						var success = 0;
						var pScore = 0;
						var tScore = 0;
						var percent = 0;
						
						// 문제당 점수를 가지고 정답률 및 난이도를 구함.
						if(dataInfo.quizReplyList && dataInfo.quizReplyList.length > 0) {
							total = dataInfo.quizReplyList.length;
							
							for(var j=0; j<dataInfo.quizReplyList.length; ++j) {
								var quizReply = dataInfo.quizReplyList[j];
								
								// 문제당 점수를 모두 더하고..
								pScore += quizReply.pScore;
								
								// tScore가 0보다 크면 정답으로 판단.
								if(quizReply.tScore > 0) {
									++success;
									tScore += quizReply.tScore;
								}
							}
							
							percent = tScore/pScore*100;
						}
						
						// 해당 문제은행의 문제 출제 수가 3보다 크면 난이도를 구하고 3보다 적으면 문제 출제 시 만들어진 난이도로 보여준다. 
						if(total > 0) {
							// 정답률이 33프로보다 작거나 같으면 상, 33보다 크고 66보다 작거나 같으면 중, 그 이상은 하
							level = (percent <= 33 ? "上" : (percent <= 66 ? "中" : "下"));
						}

						sb.Append("<tr>");
						sb.Append(" <input type='hidden' name='chkId' value='"+dataInfo.id+"' />");
						sb.Append("	<td class='order_num'>"+dataInfo.orderNum+"</td>");
						// sb.Append("	<td class='class_type'>"+(dataInfo.classType ? dataInfo.classType : "")+"</td>");
						sb.Append("	<td class='os_type'>"+(dataInfo.osType == "O" ? "객관식" : "주관식")+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.title+"</td>");
						sb.Append("	<td class=''>"+level+"("+(success+"/"+(total-success))+")</td>");
						sb.Append("	<td class=''>"+total+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='5'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
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
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		if(!$(":hidden[name='courseId']").val()) {
			alert("과정을 선택해주세요.");
		} else {
			// 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='course.id']").val($(":hidden[name='courseId']").val());
			
			setContentList();
		}
	});
	
	// 클릭 시 분류 세팅
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));

		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='chkId']").eq(idx).val());

		// ajax로 load
		contentLoad(contentTitle, editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 페이지 이벤트 등록(추가 버튼 클릭 시)
	$("#addBtn").unbind("click").bind("click", function() {
		if(!$(":hidden[name='course.id']").val()) {
			alert("과정 선택 후 검색을 하셔야 등록이 가능합니다.");
		} else {
			// 폼 이동(ID가 int인 경우 0을 넣어줌)
			$(":hidden[name='id']").val("0");
			
			// ajax로 load
			contentLoad(contentTitle, editUrl, $("form[name='searchForm']").serialize());
		}
	});
	
	// 과정선택 버튼 클릭 시
	$(":text[name='course.name']").unbind("click").bind("click", function() {
		// 과정선택 레이어 팝업
		var data = new Object();
		
		// 출석고사인 경우는 직무, 단체이며 학점이 4학점만 과정 조회
		if($("#quizType").val() == "1") {
			data.learnTypes = "J,G";
			data.appPossibles = "4";
		}
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 기수와 과정이 선택되어 있다면 바로 검색
	if($(":hidden[name='course.id']").val()) {
		setContentList();
	}
});

function setCourse(course) {
	// 임시저장
	$(":hidden[name='courseId']").val(course.id);
	$(":text[name='course.name']").val(course.name);
}

</script>

<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
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
						<td class="buttonTd" colspan="2">
							<button id='searchBtn' class="btn-primary" type="button">검색</button>
						</td>
					</tr>
				</table>
			</div>
        	<input type="hidden" name="id" value="0" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />
        	<!-- quizType -->
        	<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizType}" default="2" />' />
        	<!-- osType -->
        	<input type="hidden" id="osType" name="osType" value='<c:out value="${search.osType}" default="O" />' />
        	
        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" name="courseId" value='<c:out value="${search.course.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	
        	<!-- 문제유형 -->
			<%-- <select name="classType">
				<option value=''>문제유형선택</option>
				<option value='A' <c:if test="${search.classType eq 'A'}">selected</c:if>>A형</option>
				<option value='B' <c:if test="${search.classType eq 'B'}">selected</c:if>>B형</option>
				<option value='C' <c:if test="${search.classType eq 'C'}">selected</c:if>>C형</option>
			</select> --%>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>문항번호</th>
				<!-- <th>문제유형</th> -->
				<th>문항타입</th>
				<th>문제명</th>
				<th>난이도(정답/오답)</th>
				<th>출제횟수</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>
