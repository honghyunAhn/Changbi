<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/complete/completeList' />";
	var saveExcelUrl = "<c:url value='/data/complete/excel/download/completeList' />";	// 엑셀다운로드
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList	= result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var sType = "";
						
						sType = (dataInfo.sType == "1" ? "초등" 
							  : (dataInfo.sType == "2" ? "중등" 
							  : (dataInfo.sType == "3" ? "고등"
							  : (dataInfo.sType == "4" ? "유아"
							  : (dataInfo.sType == "5" ? "특수"
							  : (dataInfo.sType == "6" ? "기관" : ""))))));
						
						sb.Append("<tr>");
						sb.Append("	<td>"+dataInfo.course.id+"</td>");
						sb.Append("	<td>"+(dataInfo.schoolName ? dataInfo.schoolName : "")+"</td>");
						sb.Append("	<td>"+sType+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.birthDay) ? dataInfo.user.birthDay : "")+"</td>");
						sb.Append("	<td>"+dataInfo.objScore+"</td>");
						sb.Append("	<td>"+dataInfo.subScore+"</td>");
						//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
						sb.Append("	<td>"+dataInfo.partScore+"</td>");
						sb.Append("	<td>"+dataInfo.attScore+"</td>");
						sb.Append("	<td>"+dataInfo.totalScore+"</td>");
						sb.Append("	<td>"+(dataInfo.issueNum ? "이수" : "미이수")+"</td>");
						sb.Append("	<td>"+((dataInfo.region && dataInfo.region.name) ? dataInfo.region.name : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.jurisdiction ? dataInfo.jurisdiction : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.issueNum ? dataInfo.issueNum : "")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
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
		// 이수처리 후 리스트 조회
		if(!$("#cardinalId").val()) {
			alert("기수를 선택해주세요.");
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($("#cardinalId").val());
			
			setContentList();
		}
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = new Object();
		
		data.learnType = "J,G";

		openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		// 과정선택 레이어 팝업
		var data = new Object();
		
		data.cardinalId = $("#cardinalId").val();
		data.learnTypes = $("#learnType").val();
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 엑셀다운로드
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinal.id']").val()) {
			alert("검색 후 엑셀 저장 가능합니다.");
		} else if(confirm("엑셀로 저장하시겠습니까?")) {
			$("form[name='searchForm']").attr("action", saveExcelUrl);
			$("form[name='searchForm']").submit();
		}
	});
});

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);		// 임시저장
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);
	
	// 과정이 없는 상태로 화면을 변경 시킨다.
	setCourse();
}

function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>이수자현황보고</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />
        	
        	<!-- 기수와 과정 ID 세팅 -->
        	<input type="hidden" id="cardinalId" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" id="learnType" value='<c:out value="${search.cardinal.learnType}" default="" />' />
			
			<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	
			<!-- 기수 선택 -->
			<input type='text' id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<!-- 과정 선택 -->
			<input type='text' id='courseName' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
			
			<!-- 지역 선택 -->
			<select name="region.code">
				<option value="">시도교육청</option>
				<c:forEach items="${region}" var="code" varStatus="status">
					<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq search.region.code}">selected</c:if>><c:out value="${code.name}" /></option>
				</c:forEach>
			</select>
			
			<!-- 관할교육청 -->
			<input type='text' name='jurisdiction' value='<c:out value="${search.jurisdiction}" default="" />' placeholder="관할교육청" />
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>과정코드</th>
				<th>학교명</th>
				<th>구분</th>
				<th>성명</th>
				<th>생년월일</th>
				<th>온라인시험</th>
				<th>온라인과제</th>
				<th>학습참여도</th>
				<th>출석시험</th>
				<th>최종환산점수</th>
				<th>이수현황</th>
				<th>시도교육청</th>
				<th>관할교육청</th>
				<th>이수번호</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div>
	</div>
</div>