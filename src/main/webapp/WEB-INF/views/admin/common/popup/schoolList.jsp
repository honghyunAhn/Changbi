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
	var listUrl	= "<c:url value='/data/basic/schoolList' />";
	
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
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='popupId' value='"+dataInfo.id+"' />");
						sb.Append("	<input type='hidden' name='popupSType' value='"+dataInfo.sType+"' />");
						sb.Append("	<input type='hidden' name='popupEType' value='"+dataInfo.eType+"' />");
						sb.Append("	<input type='hidden' name='popupName' value='"+dataInfo.name+"' />");
						sb.Append("	<input type='hidden' name='popupRegionCode' value='"+(dataInfo.region ? dataInfo.region.code : "")+"' />");
						sb.Append("	<input type='hidden' name='popupRegionName' value='"+(dataInfo.region ? dataInfo.region.name : "")+"' />");
						sb.Append("	<input type='hidden' name='popupJurisdiction' value='"+dataInfo.jurisdiction+"' />");
						sb.Append("	<input type='hidden' name='popupTel' value='"+dataInfo.tel+"' />");
						sb.Append("	<input type='hidden' name='popupFax' value='"+dataInfo.fax+"' />");
						sb.Append("	<input type='hidden' name='popupPostCode' value='"+dataInfo.postCode+"' />");
						sb.Append("	<input type='hidden' name='popupAddr1' value='"+dataInfo.addr1+"' />");
						sb.Append("	<input type='hidden' name='popupAddr2' value='"+dataInfo.addr2+"' />");
						sb.Append("	<td class='popup_content_edit'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+(dataInfo.region ? dataInfo.region.name : "")+"</td>");
						sb.Append("	<td>"+dataInfo.jurisdiction+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='3'>조회된 결과가 없습니다.</td>");
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
		var school =	{ "id" : $(":hidden[name='popupId']").eq(idx).val()
						, "sType" : $(":hidden[name='popupSType']").eq(idx).val()
						, "eType" : $(":hidden[name='popupEType']").eq(idx).val()
						, "name" : $(":hidden[name='popupName']").eq(idx).val()
						, "regionCode" : $(":hidden[name='popupRegionCode']").eq(idx).val()
						, "regionName" : $(":hidden[name='popupRegionName']").eq(idx).val()
						, "jurisdiction" : $(":hidden[name='popupJurisdiction']").eq(idx).val()
						, "tel" : $(":hidden[name='popupTel']").eq(idx).val()
						, "fax" : $(":hidden[name='popupFax']").eq(idx).val()
						, "postCode" : $(":hidden[name='popupPostCode']").eq(idx).val()
						, "addr1" : $(":hidden[name='popupAddr1']").eq(idx).val()
						, "addr2" : $(":hidden[name='popupAddr2']").eq(idx).val() };

		setSchool(school);
		
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
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='1' />
	        	
	        	<div class="col-lg-12">
					<!-- 키워드 검색 -->
					<div class="input-group">키워드검색</div>
					<select name="searchCondition">
						<option value='name'>학교명</option>
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
						<th>학교명</th>
						<th>시도교육청</th>
						<th>교육지원청</th>
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