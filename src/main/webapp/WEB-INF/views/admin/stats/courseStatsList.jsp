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
	var listUrl	= "<c:url value='/data/stats/courseStatsList' />";
	
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
						sb.Append("	<td>"+(i+1)+"</td>");
						sb.Append("	<td>"+dataInfo.COURSE_NAME+"</td>");
						sb.Append("	<td>"+dataInfo.TOTAL_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.LEARN_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.CANCEL_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.DELAY_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.PASS_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.FAIL_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.NON_ISSUE_NUM+"</td>");
						sb.Append("	<td>"+dataInfo.PAYMENT+"</td>");
						sb.Append("	<td>"+dataInfo.REAL_PAYMENT+"</td>");
						sb.Append("	<td>"+dataInfo.DISCOUNT+"</td>");
						sb.Append("	<td>"+dataInfo.CANCEL_PAYMENT+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='13'>조회된 결과가 없습니다.</td>");
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
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($(":hidden[name='cardinalId']").val());
			$(":hidden[name='course.id']").val($(":hidden[name='courseId']").val());
			
			setContentList();
		}
	});

	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		
		if(!$(":hidden[name='course.id']").val()) {
			alert("과정을 먼저 선택해야 합니다.");
		} else {
			// 기수선택 레이어 팝업
			var data = {"learnType" : $("select[name='cardinal.learnType']").val()};
				data.id = $(":hidden[name='course.id']").val();
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
});

function setCardinal(cardinal) {
	// 임시저장
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);

}

function setCourse(course) {
	// 임시저장
	$(":hidden[name='course.id']").val(course ? course.id : "");
	$(":text[name='course.name']").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>기수/과정별 통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
	        	<table class="searchTable">
		        	<tr>
		        		<th>연수구분</th>
		        		<td>
			        		<!-- 직무연수 -->
							<select class="selector" name="cardinal.learnType">
								<option value='J'>직무연수</option>
								<option value='G' <c:if test="${search.cardinal.learnType eq 'G'}">selected</c:if>>단체연수</option>
							</select>
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>과정선택</th>
		        		<td>
		        			<!-- 과정 선택 -->
							<input type='text' class="inputSelect" name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>기수선택</th>
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
		    
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" name="courseId" value='<c:out value="${search.course.id}" default="" />' />
        	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />

			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>과정명</th>
				<th>신청 합계</th>
				<th>수강자</th>
				<th>취소자</th>
				<th>연기자</th>
				<th>이수자</th>
				<th>과락자</th>
				<th>미이수자</th>
				<th>총연수비</th>
				<th>실결제액</th>
				<th>할인금액</th>
				<th>환불금액</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="paging">
		</div>
	</div>
</div>