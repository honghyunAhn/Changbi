<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/basic/schoolList' />";
	var editUrl	= "<c:url value='/admin/basic/schoolEdit' />";
	var excelUrl = "";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	// 네이버 스마트 에디터 저장 객체
	//var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	//var file_object = [];

	// 파일
	//file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	//setPageInit(editor_object, file_object);
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		
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
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("<td>"+dataInfo.sTypeName+"</td>");
						sb.Append("<td class='content_edit'>"+dataInfo.name+"</td>");
						sb.Append("<td>"+(dataInfo.region ? dataInfo.region.name : "")+"</td>");
						sb.Append("<td>"+dataInfo.jurisdiction+"</td>");
						sb.Append("<td>"+dataInfo.eTypeName+"</td>");
						sb.Append("<td>"+dataInfo.tel+"</td>");
						sb.Append("<td>"+dataInfo.fax+"</td>");
						sb.Append("<td>"+dataInfo.postCode+"</td>");
						sb.Append("<td>"+dataInfo.addr1+"</td>");
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
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("학교 수정", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("학교 등록", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// sms발송 클릭
	$("#sendSmsBtn").unbind("click").bind("click", function() {
		alert("SMS 발송");
	});
	
	// 메일발송
	$("#sendEmailBtn").unbind("click").bind("click", function() {
		alert("메일 발송");
	});
	
	// 엑셀저장
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		alert("EXCEL 저장");
	});

	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>

<div class="content_wraper">
	<h3>컨텐츠 타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
			<select name="searchCondition">
				<option value='' selected>검색조건</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>학교명</option>
				<option value='addr' <c:if test="${search.searchCondition eq 'addr'}">selected</c:if>>주소</option>
				<option value='jurisdiction' <c:if test="${search.searchCondition eq 'jurisdiction'}">selected</c:if>>관할</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<select name="regionCode">
				<option value=''>시도</option>
				<c:forEach var="vo" items="${region}" varStatus="status">
					<option value='<c:out value="${vo.code}"/>' <c:if test="${vo.code eq search.regionCode}">selected</c:if>> <c:out value="${vo.name}"/> </option>
				</c:forEach>
			</select>
			
			<select name="eType">
				<option value='' selected>설립</option>
				<option value='1' <c:if test="${search.eType eq '1'}">selected</c:if>>국립</option>
				<option value='2' <c:if test="${search.eType eq '2'}">selected</c:if>>공립</option>
				<option value='3' <c:if test="${search.eType eq '3'}">selected</c:if>>사립</option>
			</select>
			<select name="sType">
				<option value='' selected>구분</option>
				<option value='1' <c:if test="${search.sType eq '1'}">selected</c:if>>초등</option>
				<option value='2' <c:if test="${search.sType eq '2'}">selected</c:if>>중학교</option>
				<option value='3' <c:if test="${search.sType eq '3'}">selected</c:if>>고등학교</option>
				<option value='4' <c:if test="${search.sType eq '4'}">selected</c:if>>유치원</option>
				<option value='5' <c:if test="${search.sType eq '5'}">selected</c:if>>특수학교</option>
				<option value='6' <c:if test="${search.sType eq '6'}">selected</c:if>>기관</option>
			</select>
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>구분</th>
				<th>학교명</th>
				<th>시도</th>
				<th>교육지원청</th>
				<th>설립</th>
				<th>일반전화</th>
				<th>팩스전화</th>
				<th>우편번호</th>
				<th>주소지</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>