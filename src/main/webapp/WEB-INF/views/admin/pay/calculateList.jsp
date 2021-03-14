<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/pay/calculateList' />";
	var saveExcelUrl = "<c:url value='/data/pay/calculateList/excelDownLoad' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		
		if (!validation()) return false;
		
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
							sb.Append("<td>");
								sb.Append(((pageNo-1)*numOfRows+(i+1)));	
							sb.Append("</td>");
							sb.Append("	<td>"+dataInfo.name+"</td>");
							sb.Append("	<td>"+dataInfo.cntCal+"</td>");
							sb.Append("	<td>"+dataInfo.sumPayment+"</td>");
							sb.Append("	<td>"+dataInfo.sumDisPayment+"</td>");
							sb.Append("	<td>"+dataInfo.sumDisPoint+"</td>");
							sb.Append("	<td>"+dataInfo.sumRealPayment+"</td>");
							sb.Append("	<td>"+dataInfo.sumCommPayment+"</td>");
							sb.Append("	<td>"+dataInfo.sumCalPayment+"</td>");
							sb.Append("	<td>"+dataInfo.sumCompanyPayment+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='10'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
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
		setContentList(1);
	});
	
	// 엑셀저장
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		if(confirm("엑셀로 저장하시겠습니까?")) {
			$("form[name='searchForm']").attr("action", saveExcelUrl);
			$("form[name='searchForm']").submit();
		}
	});

	// 기수 추가 버튼 클릭 시(레이어팝업)
	$(":input[name='cardinal.name']").unbind("click").bind("click", function() {
		// 그룹인 경우만 조회
		var data = {};
		
		openLayerPopup("기수 검색", "/admin/common/popup/cardinalList", data);
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	//setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

function setCardinal(cardinal) {
	$(":hidden[name='cardinal.id']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);
}

//데이터 유효성 체크
function validation() {
	var cardinalId = $("input[name='cardinal.id']");
	
	if (cardinalId.length > 0 && cardinalId.val() == '') {
		alert("기수를 선택하셔야 합니다.");
		$(":text[name='cardinal.name']").trigger("click");
		return false;
	}
	
	return true;
}
</script>

<div class="content_wraper">
	<h3>컨텐츠 타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
			<input type="hidden" name="calType" value="<c:out value='${search.calType}' default=''/>" />
       	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<c:if test="${search.calType eq 'company'}">
	        	<select name="id">
					<option value="" selected>업체 전체</option>
					<c:forEach items="${companyList}" var="company" varStatus="status">
						<option value='<c:out value="${company.id}" />' <c:if test="${company.id eq search.company.id}">selected</c:if>><c:out value="${company.name}" /></option>
					</c:forEach>
				</select>
        	</c:if>
        	
        	<c:if test="${search.calType eq 'teacher'}">
        		<select name="id">
					<option value="" selected>강사 전체</option>
					<c:forEach items="${teacherList}" var="teacher" varStatus="status">
						<option value='<c:out value="${teacher.id}" />' <c:if test="${teacher.id eq search.teacher.id}">selected</c:if>><c:out value="${teacher.name}" /></option>
					</c:forEach>
				</select>
        	</c:if>
        	
        	<c:if test="${search.calType eq 'tutor'}">
        		<select name="id">
					<option value="" selected>튜터 전체</option>
					<c:forEach items="${tutorList}" var="tutor" varStatus="status">
						<option value='<c:out value="${tutor.id}" />' <c:if test="${tutor.id eq search.tutor.id}">selected</c:if>><c:out value="${tutor.name}" /></option>
					</c:forEach>
				</select>
        	</c:if>
						
			<!-- 기수 선택 -->
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type='text' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>업체명</th>
				<th>정산건수</th>
				<th>원금액계</th>
				<th>할인금액</th>
				<th>사용포인트</th>
				<th>실결제금액</th>
				<th>금융수수료</th>
				<th>정산금액</th>
				<th>본사금액</th>
			</tr>
			</thead>
			<tbody id="dataListBody">
				<tr id="initMessage">
					<td colspan="10">기수를 먼저 선택하세요.</td>
				</tr>
			</tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div>
	</div>
</div>