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

<title>유저 조회 팝업</title>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/member/memberList' />";
	
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
						sb.Append("	<input type='hidden' name='popupCheckId' value='"+dataInfo.id+"' />");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td class='popup_content_edit' style='cursor: pointer;'>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+dataInfo.phone+"</td>");
						sb.Append("	<td>"+dataInfo.schoolName+"</td>");
						sb.Append("	<td>"+(dataInfo.regionCode ? dataInfo.regionCode.name : "")+"/"+dataInfo.jurisdiction+"</td>");
						sb.Append("	<td>"+dataInfo.position+"</td>");
						sb.Append("	<td>"+(dataInfo.grade == 1 ? "교원회원" : "일반회원")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
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
		var idx = $(".select_popup_id").index($(this));
		
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
	        	<input type="hidden" name="id" value="" />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='1' />
	        	
	        	<div class="col-lg-12">
	        		<!-- 지역 선택 -->
	               	<div class="input-group">지역</div>
					<select name="regionCode.code">
						<option value="">지역</option>
						<c:forEach items="${region}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />'><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
					
					<!-- 키워드 검색 -->
					<div class="input-group">키워드검색</div>
					<select name="searchCondition">
						<option value='all'>전체</option>
						<option value='name'>회원명</option>
						<option value='id'>아이디</option>
						<option value='phone'>휴대전화</option>
						<option value='email'>이메일</option>
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
						<th>회원명</th>
						<th>아이디</th>
						<th>연락처</th>
						<th>학교/직장명</th>
						<th>소속교육청</th>
						<th>담당업무</th>
						<th>회원구분</th>
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