<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>기수 조회 팝업</title>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/course/cardinalList' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".popup_pagination"));
	
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
			data 	: $("form[name='popupSearchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;
						
						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='popupId' value='"+dataInfo.id+"' />");
						sb.Append("	<input type='hidden' name='popupName' value='"+dataInfo.name+"' />");
						sb.Append("	<input type='hidden' name='popupLearnType' value='"+dataInfo.learnType+"' />");
						sb.Append("	<input type='hidden' name='popupAppStartDate' value='"+(dataInfo.appStartDate ? dataInfo.appStartDate : "")+"' />");
						sb.Append("	<input type='hidden' name='popupAppEndDate' value='"+(dataInfo.appEndDate ? dataInfo.appEndDate : "")+"' />");
						sb.Append("	<input type='hidden' name='popupLearnStartDate' value='"+(dataInfo.learnStartDate ? dataInfo.learnStartDate : "")+"' />");
						sb.Append("	<input type='hidden' name='popupLearnEndDate' value='"+(dataInfo.learnEndDate ? dataInfo.learnEndDate : "")+"' />");
						sb.Append("	<input type='hidden' name='popupComplateYn' value='"+dataInfo.complateYn+"' />");
						sb.Append("	<input type='hidden' name='popupUseYn' value='"+dataInfo.useYn+"' />");
						sb.Append("	<input type='hidden' name='price' value='"+dataInfo.price+"' />");
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td class='popup_content_edit' style='cursor: pointer;'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+(dataInfo.appStartDate ? dataInfo.appStartDate : "")+" ~ "+(dataInfo.appEndDate ? dataInfo.appEndDate : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.learnStartDate ? dataInfo.learnStartDate : "")+" ~ "+(dataInfo.learnEndDate ? dataInfo.learnEndDate : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.complateYn == "N" ? "미처리" : "처리")+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "중지" : "서비스")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
				
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
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		
		// 부모의 함수 호출해준다.
		var cardinal =	{ "id" : $(":hidden[name='popupId']").eq(idx).val()
						, "name" : $(":hidden[name='popupName']").eq(idx).val()
						, "learnType" : $(":hidden[name='popupLearnType']").eq(idx).val()
						, "appStartDate" : $(":hidden[name='popupAppStartDate']").eq(idx).val()
						, "appEndDate" : $(":hidden[name='popupAppEndDate']").eq(idx).val()
						, "learnStartDate" : $(":hidden[name='popupLearnStartDate']").eq(idx).val()
						, "learnEndDate" : $(":hidden[name='popupLearnEndDate']").eq(idx).val()
						, "complateYn" : $(":hidden[name='popupComplateYn']").eq(idx).val()
						, "useYn" : $(":hidden[name='popupUseYn']").eq(idx).val() 
						, "price" : $(":hidden[name='price']").eq(idx).val() 
						};
		setCardinal(cardinal);
		
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
	        	<input type="hidden" name="courseId" value='<c:out value="${search.id}"/>' />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
				
	        	<div class="col-lg-12">
	        		<!-- 연수구분 -->
	        		<%-- <select name="learnType">
	        			<c:if test="${empty search.learnType}">
	        				<option value="J">직무</option>
	        				<option value="S">자율</option>
	        				<option value="M">집합</option>
	        				<option value="G">단체</option>
	        			</c:if>
	        			<c:if test="${fn:contains(search.learnType, 'J')}"><option value="J">직무</option></c:if>
	        			<c:if test="${fn:contains(search.learnType, 'S')}"><option value="S">자율</option></c:if>
	        			<c:if test="${fn:contains(search.learnType, 'M')}"><option value="M">집합</option></c:if>
	        			<c:if test="${fn:contains(search.learnType, 'G')}"><option value="G">단체</option></c:if>
					</select> --%>
	        		<!-- 학점구분 -->
	        		<!-- <select name="credits">
	        			<option value="">직무학점구분</option>
						<option value="4">4학점</option>
						<option value="3">3학점</option>
						<option value="1,2">1,2학점</option>
					</select> -->
					
					<!-- 상태구분 -->
					<!-- <select name='useYn'>
						<option value="">상태구분</option>
						<option value="Y">서비스</option>
						<option value="N">중지</option>
					</select>
					
					<select name='complateYn'>
						<option value="">이수구분</option>
						<option value="Y">처리</option>
						<option value="N">미처리</option>
					</select> -->
					
					<!-- 키워드 검색 -->
					<div class="input-group">키워드검색</div>
					<select name="searchCondition">
						<option value='all'>전체</option>
						<option value='name'>기수명</option>
						<option value='id'>기수코드</option>
					</select>
					
					<div class="input-group">
						<input type="text" class="form-control" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="">
						<span class="input-group-btn">
	                    	<a type="button" class="btn" id="popupSearchBtn"><i class="fa fa-search">검색</i></a>
	                    </span>
	               	</div>
				</div>
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>기수코드</th>
						<th>기수명</th>
						<th>접수기간</th>
						<th>연수기간</th>
						<th>이수구분</th>
						<th>상태구분</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody"></tbody>
				</table>
			</div>
			<div class="popup_pagination"></div>
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>