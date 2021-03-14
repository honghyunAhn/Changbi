<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	$("#listBtns").hide();
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/student/Survey/selectAutoSurveyList' />";
	
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
						var start = dataInfo.autoSurveyStart;
						var period = dataInfo.autoSurveyPeriod;
						var type = dataInfo.autoSurveyType;
						
						switch(start){
						case 1 :
							start = "진도율이 50%이상일 때";
							break;
						case 2 :
							start = "개강일부터 30일 후";
							break;
						case 3 :
							start = "개강일부터 60일 후";
						}
						
						switch(period){
						case 1 :
							period = "연수종료일까지";
							break;
						case 2 :
							period = "일주일";
						}
						
						switch(type){
						case 'gisu' :
							type_kor = "기수별";
							break;
						case 'course' :
							type_kor = "과정별";
						}
						sb.Append('<tr>');
						sb.Append('<td>' + (i+1) + '</td>');
						sb.Append('<td>' + (dataInfo.crc_name ? dataInfo.crc_name : "") + '</td>');
						sb.Append('<td>');
						sb.Append('<input type="button" onclick="autoSurveyDetail(this);" style="color:blue;width:100%;border:0px;height:100%;" class="checc"  value="'+dataInfo.survey_title+'">');
						sb.Append('<input type="hidden" name="survey_seq" value = "' + dataInfo.survey_seq + '">');
						sb.Append('<input type="hidden" name="survey_type" value = "' + type + '">');
						sb.Append('<input type="hidden" name="survey_gisu" value = "' + dataInfo.autoSurveyGisu + '">');
						sb.Append('<input type="hidden" name="crc_id" value="' + dataInfo.crc_id + '">');
						sb.Append('</td>');
						sb.Append('<td>' + start + '</td>');
						sb.Append('<td>' + period + '</td>');
						sb.Append('<td>' + type_kor + '</td>');
						sb.Append('<td>' + (dataInfo.gisu_name ? dataInfo.gisu_name : "-") + '</td>');
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
	/** 페이지 시작 **/
	searchList();
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

function autoSurveyDetail(obj){
	var type = $(obj).siblings('input[name="survey_type"]').val();
	var search = $("form[name='searchForm']").serializeObject();
	var data = new Object();
		data.survey_seq = $(obj).siblings('input[name="survey_seq"]').val();
		data.autoSurveyType = type;
		data.autoSurveyGisu = $(obj).siblings('input[name="survey_gisu"]').val();
		data.crc_id = $(obj).siblings('input[name="crc_id"]').val();
	
	switch(type){
	case "gisu" :
		data.page = "gisu";
		openLayerPopup("자동설문 기수통계 리스트", "/admin/common/popup/surveyAutoGisuList", data);
		break;
	case "course" :
		data.page = "auto";

		var obj = new Object();
			obj.search = JSON.stringify(search);
			obj.data = JSON.stringify(data);
		contentLoad('설문조사 세부 내역','/admin/studentManagement/studentSurveyDetail', obj);
		break;
	}
}

function searchListGisu(seq){
	var sb = new StringBuilder();
	var newSeq = seq;
	var Url	= "<c:url value='/student/Counsel/searchGisuList' />";
	$.ajax({
		type	: "post",
		data 	: newSeq,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<option value="">기수 선택</option>');
			
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
			}
			$('#gisuSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
		}
	});
}

function searchList(){
	var sb = new StringBuilder();
	var Url	= "<c:url value='/student/Counsel/searchCirriculumList' />";//var Url	= "<c:url value='/student/TestManagement/searchCirriculumList' />";
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
</script>

<div class="content_wraper" id="modalsContentss">
	<h3>자동배포 설문 목록</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>과정 선택</th>
	        			<td>
	        				<select class="selector" name="crc_id" id="gwajeongSelector"></select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>통계 방법</th>
	        			<td>
	        				<select class="selector" name="autoSurveyType" id="typeSelector">
	        					<option value="">통계방법 선택</option>
       							<option value="course" <c:if test="${search.autoSurveyType eq 'course'}">selected</c:if>>과정별</option>
       							<option value="gisu" <c:if test="${search.autoSurveyType eq 'gisu'}">selected</c:if>>기수별</option>
	        				</select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>제목 검색</th>
	        			<td>
	        				<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
	        				<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
	        				<a class="btn btn-danger" href="javascript:contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyAuto');">전체 검색</a>
	        			</td>
	        		</tr>
	        	</table>
	        </div>
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;" class="able">
			<thead>
			<tr>
				<th>No</th>
				<th>과정</th>
				<th>설문조사명</th>
				<th>설문 시작일</th>
				<th>설문 기간</th>
				<th>통계 방법</th>
				<th>배포시작 기수</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>

