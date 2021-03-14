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

<title>자동설문 기수통계 리스트</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/student/Survey/surveyList' />";
	
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
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var startDate = dataInfo.survey_start_date;
						var endDate = dataInfo.survey_end_date;
						var regDate = dataInfo.survey_regdate;
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.survey_seq+"' />" + (i+1));
						sb.Append('		<input type="hidden" name="crc_id" value="' + dataInfo.crc_id + '">');
						sb.Append('		<input type="hidden" name="gisu_id" value="' + dataInfo.gisu_id + '">');
						sb.Append("	</td>");
						sb.Append('	<td>'+(dataInfo.crc_name ? dataInfo.crc_name : "")+'</td>');
						sb.Append("	<td>"+(dataInfo.gisu_name ? dataInfo.gisu_name : "")+"</td>");
						sb.Append('	<td><input type="button" onclick="showDetail(this);" style="width:100%;border:0px;height:100%;" value="'+dataInfo.survey_title+'"></td>');
						sb.Append(" <td>"+startDate.substring(0,10)+"</td>");
						sb.Append(" <td>"+endDate.substring(0,10)+"</td>");
						sb.Append("	<td>" + (dataInfo.survey_state == "OPEN" ? "진행중" : "마감") + "</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				$("#popupDataListBody").html(sb.ToString());
				// 자동배포설문 리스트에서 넘긴 survey_seq값  초기화
				$('input[name="survey_seq"]').val('0');
				
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
	
	/** 페이지 시작 **/
	searchList();
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

function searchList(){
	var sb = new StringBuilder();
	var Url	= "<c:url value='/student/Counsel/searchCirriculumList' />";
	var crc_id = "${search.crc_id}";
	
	$.ajax({
		type	: "post",
		url		: Url,
		async	: false,
		success : function(result){
			$("#gwajeongSelector").html("");
			sb.Append('<option value="" disabled selected hidden>과정 선택</option>');
			
			if(crc_id.trim().length == 0){
				for (var i = 0; i < result.length; i++){
					var map = result[i];
					sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
				}
			}else{
				for (var i = 0; i < result.length; i++){
					var map = result[i];
					if(map.CRC_CLASS == crc_id)
						sb.Append('<option value="'+map.CRC_CLASS+ '" selected>'+map.CRC_NM+'</option>');
					else
						sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
				}
				searchListGisu(crc_id);
			}
			$('#gwajeongSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
		}
	});
}

function searchListGisu(seq){
	var sb = new StringBuilder();
	var Url	= "<c:url value='/student/Counsel/searchGisuList' />";
	var newSeq = seq;
	var gisu_id = "${search.gisu_id}";
	
	$.ajax({
		type	: "post",
		data 	: newSeq,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<option value="">기수 선택</option>');
			
			if(gisu_id.trim().length == 0){
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
				}
			}else{
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					if(map.gisu_seq == gisu_id)
						sb.Append('<option value="'+map.gisu_seq+ '" selected>'+map.gisu_crc_nm+'</option>');
					else
						sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
				}
			}
			$('#gisuSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
		}
	});
}

function showDetail(obj){
	var search = $("form[name='searchForm']").serializeObject();
	var data = new Object();
		data.survey_seq = $(obj).parents('tr').find('input[name="checkId"]').val();
		data.crc_id = $(obj).parents('tr').find('input[name="crc_id"]').val();
		data.gisu_id = $(obj).parents('tr').find('input[name="gisu_id"]').val();
		data.page = "gisu";
		data.autoSurveyType = "gisu";
		
		var obj = new Object();
			obj.search = JSON.stringify(search);
			obj.data = JSON.stringify(data);
		contentLoad('설문조사 세부 내역','/admin/studentManagement/studentSurveyDetail', obj);
		closeLayerPopup();
}
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
		        			<th>과정 선택</th>
		        			<td><select class="selector" name="crc_id" id="gwajeongSelector" onchange="searchListGisu(this.value);"></select></td>
		        		</tr>
		        		<tr class="gisu_tr">
		        			<th>기수 선택</th>
		        			<td><select class="selector" name="gisu_id" id="gisuSelector"></select></td>
		        		</tr>
		        		<tr>
		        			<th>제목 검색</th>
		        			<td>
		        				<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
		        				<a type="button" class="btn" id="popupSearchBtn"><i class="fa fa-search">검색</i></a>
		        			</td>
		        		</tr>
		        	</table>
				</div>
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
				
				<!-- 자동설문 기수별 리스트 출력할 때 필요한 변수들-->
				<input type="hidden" name="survey_seq" value="${search.survey_seq}">
				<input type="hidden" name="page" value="${search.page}">
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>No</th>
						<th>과정</th>
						<th>기수</th>
						<th>설문조사명</th>
						<th>설문 시작일</th>
						<th>설문 종료일</th>
						<th>상태</th>
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