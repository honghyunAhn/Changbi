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

<title>기수 조회 팝업</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/student/studentTb/studentTableMOU' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".popup_pagination"));
	
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		/**LMS 검색창 처리**/
		$.ajax({
			type	: "post",
			url		: listUrl,
			async : false,
			data 	: $("form[name='popupSearchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='mou_sc_code' value='"+dataInfo.mou_code+"' />");
						sb.Append("	<input type='hidden' name='mou_sc_nm' value='"+dataInfo.code_nm+"' />");
						sb.Append("	<td>"+dataInfo.mou_code+"</td>");
						sb.Append("	<td class='popup_content_edit' style='cursor: pointer;'>"+dataInfo.code_nm+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='2'>조회된 결과가 없습니다.</td>");
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
		})
		
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 팝업창에서 학교명 클릭시 학적부 수정페이지에 값 세팅
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		var code = $(":hidden[name='mou_sc_code']").eq(idx).val();
		var name = $(":hidden[name='mou_sc_nm']").eq(idx).val();
		
		$(":hidden[name='stu_mou_sc']").val(code);
		$('#stu_mou_sc_nm').val(name);
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
        		<div>
		        	<table class="searchTable">
		        		<tr>
		        			<td>
			        			<select class="searchConditionBox" name="searchCondition">
									<option value='sc'>학교명</option>
								</select>
								<input type="text" class="form-control searchKeywordBox" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="">
	                    		<a type="button" class="btn" id="popupSearchBtn"><i class="fa fa-search">검색</i></a>
		        			</td>
		        		</tr>
		        	</table>
				</div>
	        	<input type="hidden" name="id" value="" />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='1' />
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>학교코드</th>
						<th>학교명</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody">
					</tbody>
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