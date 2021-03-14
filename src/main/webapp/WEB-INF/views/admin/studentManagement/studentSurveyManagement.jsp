<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/student/Survey/surveyList' />";
	
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
						var startDate = dataInfo.survey_start_date;
						var endDate = dataInfo.survey_end_date;
						var regDate = dataInfo.survey_regdate;
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='survey_seq' value='"+dataInfo.survey_seq+"' />" + (i+1));
						sb.Append('		<input type="hidden" name="crc_id" value="' + dataInfo.crc_id + '">');
						sb.Append('		<input type="hidden" name="gisu_id" value="' + dataInfo.gisu_id + '">');
						sb.Append("	</td>");
						sb.Append('	<td><a href="javascript:void(0);" onclick="goCourseDetail(this);">'+(dataInfo.crc_name ? dataInfo.crc_name : "")+'</a></td>');
						sb.Append("	<td>"+(dataInfo.gisu_name ? dataInfo.gisu_name : "")+"</td>");
						
						if(regDate == null){
							sb.Append('	<td><input type="button" onclick="showDetail(\'modify\', this);" style="color:blue;width:100%;border:0px;height:100%;" class="checc"  value="'+dataInfo.survey_title+'"></td>');
						}else{
							sb.Append('	<td><input type="button" onclick="showDetail(\'detail\', this);" style="color:blue;width:100%;border:0px;height:100%;" class="checc"  value="'+dataInfo.survey_title+'"></td>');
						}
						sb.Append(" <td>"+startDate.substring(0,10)+"</td>");
						sb.Append(" <td>"+endDate.substring(0,10)+"</td>");
						
						if(regDate == null){
							sb.Append('<td><button class="btn btn-primary" onclick="regSurvey(\''+ dataInfo.survey_seq +'\')" style="border-radius: 5px;">설문 배포</button></td>')
						}else{
							sb.Append("	<td>" + (dataInfo.survey_state == "OPEN" ? "진행중" : "마감") + "</td>");
						}
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

// 과정 상세페이지로 이동 - 해당과정의 자동설문 리스트 확인할 수 있도록
function goCourseDetail(obj){
	var crc_id = $(obj).parents('tr').find('input[name="crc_id"]').val();
	var data = {id : crc_id};
	contentLoad("학습과정관리", "<c:url value='/admin/course/trainProcessEdit' />", data);
}

// 과정리스트 불러오기
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

// 기수 리스트 불러오기
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

function showDetail(str, obj){
	var search = $("form[name='searchForm']").serializeObject();
	var data = new Object();
		data.survey_seq = $(obj).parents('tr').find('input[name="survey_seq"]').val();
		data.crc_id = $(obj).parents('tr').find('input[name="crc_id"]').val();
		data.gisu_id = $(obj).parents('tr').find('input[name="gisu_id"]').val();
		data.page = "survey";
		
	var obj = new Object();
		obj.search = JSON.stringify(search);
		obj.data = JSON.stringify(data);

	switch(str){
	case "detail" :
		contentLoad('설문조사 세부 내역','/admin/studentManagement/studentSurveyDetail', obj);
		break;
	case "modify" :
		contentLoad('설문조사 내용 수정','/admin/studentManagement/studentSurveyModify', obj);
	}
}

function regSurvey(seq){
	if(confirm("설문을 배포하시겠습니까?")){
		var jsonStr = JSON.stringify(seq);
		$.ajax({
			url:"<c:url value='/student/Survey/regSurvey'/>",
			type:		"post",
			dataType:	"json",
			contentType: 'application/json; charset=UTF-8',
			data: jsonStr,
			success:function(result){
				if (result){
					alert("설문 배포 완료");
					var data = $("form[name='searchForm']").serialize();
					contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyManagement', data);
				}else{
					alert("설문 배포 실패");
				}
			}
		});
	}
}

function createSurvey(){
	var data = $("form[name='searchForm']").serialize();
	contentLoad('설문조사추가','/admin/studentManagement/studentSurveyCreate', data);
}
</script>

<div class="content_wraper" id="modalsContentss">
	<h3>설문조사 내역</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
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
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
	        				<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
							<a class="btn btn-danger" href="javascript:contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyManagement');">전체 검색</a>
	        			</td>
	        		</tr>
	        	</table>
	        </div>
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
			<!-- 현재 페이지 위치 정보 -->
			<input type="hidden" name="page" value="${search.page}">
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;" class="able">
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
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a class="btn" href="javascript:void(0);" onclick="createSurvey();">추가하기</a>
		</div>
	</div>
</div>

