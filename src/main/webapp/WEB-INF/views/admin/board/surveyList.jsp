<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/board/surveyList' />";
	var editUrl	= "<c:url value='/admin/board/surveyEdit' />";
	var itemUrl = "<c:url value='/admin/board/surveyItemInfo' />";
	var excelUrl = "";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
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
						sb.Append("		<input type='hidden' name='checkSeq' value='"+dataInfo.seq+"' />");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("<td>"+dataInfo.regDate+"</td>");
						sb.Append("<td>"+dataInfo.surveyCode.name+"</td>");
						sb.Append("<td class='content_edit'>"+dataInfo.title+"</td>");
						sb.Append("<td>"+(dataInfo.concatCardinalId ? dataInfo.concatCardinalId : '없음')+"</td>");
						sb.Append("<td>"+(dataInfo.useYn == 'Y' ? '서비스' : '보류')+"</td>");
						sb.Append("<td><button tpe='button' class='survey_item_btn'>관리</button></td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
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
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='seq']").val($(":hidden[name='checkSeq']").eq(idx).val());
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("연수설문 수정", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		//$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("연수설문 등록", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 엑셀저장
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		alert("EXCEL 저장");
	});

	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 문항추가 등록 기능
	$("#dataListBody").on("click", ".survey_item_btn", function() {
		var idx = $(".survey_item_btn").index($(this));
		
		$(":hidden[name='seq']").val($(":hidden[name='checkSeq']").eq(idx).val());
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("문항추가", itemUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>

<div class="content_wraper">
	<h3>타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       	<div>
	        	<table class="searchTable">
		        	<tr>
		        		<th>키워드검색</th>
		        		<td>
			        		<select name="searchCondition">
								<option value=''>검색조건</option>
								<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>설문지명</option>
							</select>
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class="buttonTd" colspan="2">
		        			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		        		</td>
		        	</tr>
		        </table>
		    </div>
       		<input type="hidden" name="seq" value="0" />
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>등록일시</th>
				<th>설문유형</th>
				<th>설문지명</th>
				<th>포함기수코드</th>
				<th>상태</th>
				<th>설문</th>
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