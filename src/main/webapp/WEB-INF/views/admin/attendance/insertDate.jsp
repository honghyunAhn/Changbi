<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!-- xls 성공 xlsx 실패 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.6/xlsx.min.js"></script> 
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.0/xlsx.min.js"></script> 실패 -->

<!-- xls 성공 xlsx 데이터 읽지 못함 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.6/xlsx.full.min.js"></script> -->

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script type="text/javascript">

var startDate;
var endDate;

$(document).ready(function () {
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/member/memberList' />";
	var editUrl	= "<c:url value='/admin/member/memberEdit' />";
	var insUrl = "<c:url value='/data/attendance/dateReg' />";
	var insSuccessUrl = "<c:url value='/admin/learnApp/learnAppInsert' />";
	var selectDelUrl = "<c:url value='/data/learnApp/learnAppSelectDel' />";	// 입과자 선택 삭제
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($("#userPagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $("form[name='searchForm']").find(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$("form[name='searchForm']").find(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				// 체크박스 전체선택  초기화
				$("#allCheckBox").prop("checked", false);
				
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						sb.Append("<tr>");
						sb.Append("<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("<td>");
						sb.Append("<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append("<input type='hidden' name='checkName' value='"+(dataInfo.name ? dataInfo.name : "")+"' />");
						sb.Append(	((pageNo-1)*numOfRows+(i+1)));
						sb.Append("</td>");
						sb.Append("<td name='userName'>"+(dataInfo.name ? dataInfo.name : "")+"</td>");
						sb.Append("<td class='content_edit'>"+(dataInfo.id ? dataInfo.id : "")+"</td>");
						sb.Append("<td>"+(dataInfo.phone ? dataInfo.phone : "")+"</td>");
						sb.Append("<td>"+(dataInfo.email ? dataInfo.email : "")+"</td>");
						sb.Append("<td>"+dataInfo.regDate+"</td>")
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("<td colspan='12'>조회된 결과가 없습니다.</td>");
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
	
	// 과정 선택
	$("#courseListBtn").unbind("click").bind("click", function() {
		// 초기화
		$("#course").html('');
		$(":hidden[name='courseId']").val('');
		$("#cardinal").html('');
		$(":hidden[name='cardinalId']").val('');
		$("#regUserList").hide();
		
		var data = new Object();
		
		// 과정선택 레이어 팝업
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalListBtn").unbind("click").bind("click", function() {
		// 초기화
		$("#cardinal").html('');
		$(":hidden[name='cardinalId']").val('');
		$("#regUserList").hide();
		
		if(!$(":hidden[name='courseId']").val()) {
			alert("과정을 먼저 선택해야 합니다.");
		} else {
			// 기수선택 레이어 팝업
			var data = new Object();
			data.learnTypes = "J,S,M";
			data.id = $(":hidden[name='courseId']").val();
			
			if($(":hidden[name='groupLearnYn']").val() == "Y") {
				data.learnTypes = "G";
			}
		
			openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
			
		}
	});
	
	
	
	$("#date-during-button").on("click",function(){

		var dateFrom=$("#date-from").val();
		var dateTo=$("#date-to").val();
		
		if(!dateFrom) {
			alert("시작 기간을 선택해주세요.");
			return;
		}
		if(!dateTo) {
			alert("끝 기간을 선택해주세요.");
			return;
		}
		
		if(dateTo >= dateFrom){

			// 캘린더 사용하지 않기로 하여 호출하는 메소드 주석
			// 20 09 01 김태원
			/* $('#calendar').fullCalendar('destroy');
			renderCalendar(dateFrom,dateTo); 
			$("#attButton").css("display","block"); */
			
			confirmDate(dateFrom, dateTo);
			alert("날짜 지정 성공");
			
		}else{
			alert("끝 기간이 시작 기간보다 빠를수 없습니다. ");
			return;
		}
		
	});
});

$("#add-date-btn").on("click", function(){
	
	var s = "Sisu.xlsx";
	var o = "Sisu.xlsx";
	var p = "Files";
	
	location.href = "/data/attendance/datesExcelDownload";
});


function setCourse(course) {
	$(":hidden[name='courseId']").val(course.id);
	$("#course").html(course.name);
}


function setCardinal(cardinal) {
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$("#cardinal").html(cardinal.name);
	$("#date-from").html(cardinal.learnStartDate);
	$("#date-to").html(cardinal.learnEndDate);
	
	$.ajax({
		type : "POST"
		, url : "<c:url value='/data/attendance/dateSearch' />"
		, data		: $("form[name='regForm']").serialize()
		, dataType	: "json"
		, processData	: false
		, success		: function(result) {
			
			/* alert("setCardinal Finished"); */

			$("#date-from").val(result.start);
			$("#date-to").val(result.end);
			$("#start").val(result.start);
			$("#end").val(result.end);
			
			 createTable(); 
			
		}
		, error		: function(e) {
		
		}
	});
	
	
	$(".dateDiv").css("display","block");
}

function confirmDate(dateFrom, dateTo){
	
	if(!confirm("출결기간을 설정 하시겠습니까?")){
		alert("날짜는 변경되었으나 저장되진 않았습니다.");
		return;
	}
	
	/* var data ={
			courseId:$(":hidden[name='courseId']").val(),
			cardinalId:$(":hidden[name='cardinalId']").val(),
			start:dateFrom,
			end:dateTo
	} */
	
	$(":hidden[name='start']").val(dateFrom);
	$(":hidden[name='end']").val(dateTo);
	
	/* alert("DateFrom : " + dateFrom);
	alert("DateTo : " + dateTo);
	alert("Course ID : " + data.courseId);
	alert("Cardinal ID : " + data.cardinalId); */
	
	$.ajax({
		type : "POST"
		, url : "<c:url value='/data/attendance/dateReg' />"
		, data		: $("form[name='regForm']").serialize()
		, dataType	: "json"
		, processData	: false
		, success		: function(result) {
			
		}
		, error		: function(e) {
			alert(e);
		}
	});
}

function executeAjax(){
	
	$.ajax({
		type: 'GET',
		url: "<c:url value='/data/attendance/addDate' />",
		data: $("form[name='regForm']").serialize(),
		success : function (data) {
			/* alert(data); */
			/* createTable(); */ 
		},
		error: function(request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function createTable() {
        	
	var sb = new StringBuilder();
    var content = "";
	$.ajax({
		type: "get"
		, url : "<c:url value='/data/attendance/selectDates' />"
		, data: {
			course_id: $(":hidden[name='courseId']").val(),
			cardinal_id: $(":hidden[name='cardinalId']").val()
		}
		, success : function (data) {
			sb.Append("<tbody>"); 
			if(data.length > 0) {
				$.each(data, function(index, item) {
					sb.Append("<tr><input type='hidden' name='sisu_seq' value="+item.attSisuSeq+">");
					sb.Append("<td>" + (index+1) + "</td>");
					sb.Append("<td class='hasSisu' value='" + item.SISU + "'>" + item.sisu + "</td>");
	        		sb.Append("<td class='hasvalue' data-value='" + item.attDate + "'>" + item.attDate + "</td>");
	        		sb.Append("<td calss='hasStandInTime' data-value='" + item.standInTime + "'>" + item.standInTime + "</td>");
	        		sb.Append("<td calss='hasStandOutTime' data-value='" + item.standOutTime + "'>" + item.standOutTime + "</td>");
	        		sb.Append("<td><a class='btn btn-danger btn-delete' type='button'>삭제</td></tr>");
	        	}); 
        	} else {
        		sb.Append("<tr><td class='empty-date'>조회된 일자가 없습니다.</td></tr>");
        	}
        	sb.Append("</tbody>"); 
        	$("#dates-table").html(sb.ToString());
        	$(".registeredDates").css("display", "block");
        				
        }
        , error: function(e) {
        	alert(e);
        }
       });
}
		
/* Ajax로 생성된 버튼 클릭 이벤트가 실행이 안되어 수정 */
$(document).on('click', '.btn-delete', function(){
	var date = $(this).parent().parent().children().eq(3).attr('data-value');
	var sInTime = $(this).parent().parent().children().eq(4).attr('data-value');
	var sOutTime = $(this).parent().parent().children().eq(5).attr('data-value');
	var cardinal = $(":hidden[name='cardinalId']").val();
	var course = $(":hidden[name='courseId']").val();
	var seq = $(this).parent().parent().children('input[name$=sisu_seq]').val();
			
	if(!confirm(date+" : "+sInTime+"~"+sOutTime+"을 삭제하시겠습니까?")) {
		return;
	}
			
	var today = new Date();
	var compareDay = new Date();
			
	var arr = date.split("-");
			
	compareDay.setFullYear(arr[0], arr[1] - 1, arr[2]);
			
			
	/* 날짜가 같을 시 스케줄러가 실행되는 시간을 비교하는 if문 추가 */
	if(today.getTime() > compareDay.getTime()) {
		alert("현재 날짜보다 빠른 날짜는 지울 수 없습니다.");
	} else {
		$.ajax({
			type: "GET"
			, url: "<c:url value='/data/attendance/deleteDate' />"
			, data: {
				course_id: course,
				cardinal_id: cardinal,
				att_date: date,
				stand_in_time: sInTime,
				stand_out_time: sOutTime,
				seq : seq
			}
			, success: function(data) {
				createTable(); 
			}
		}); 
	}
});
		
$(document).on('click', '#file-upload-btn', function(){
			
	$("#course-id").val($(":hidden[name='courseId']").val());
	$("#cardinal-id").val($(":hidden[name='cardinalId']").val());
	var file = $("#upload-file").val();
	
	if(!file) {
		alert("파일을 선택하세요.");
		return;
	}
	
	var formData = new FormData($('#excelUpload')[0]);
			
	$.ajax({
		url: '<c:url value="/data/attendance/fileUpload"/>',
		type: "POST",
		data: formData,
        processData: false,
        contentType: false,
		success: function() {
			createTable();
			alert("저장에 성공하였습니다.");
		},
		error: function() {
			alert("저장에 실패하였습니다.");
		}
	});
			
});
		
$(document).on('click', '#date-add-btn', function(){
	var addTag = '';
			
	var sb = new StringBuilder();
			
	var findedElement = $("td").hasClass("empty-date");
			
	if(findedElement == true) {
		$(".empty-date").parent().remove();
	}
			
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;   
	var date = now.getDate(); 
			
	if(date < 10) {
		date = "0" + date;
	}
			 
	sb.Append("<tr> <td>Index</td>");
	sb.Append("<td><input type='text' name='newSisu' placeholder='ex) 1'></td>");
	sb.Append("<td><input type='text' name='newDates' placeholder='ex)");
	sb.Append(year + "-" + month + "-" + date + "'></td>");
	sb.Append("<td><input type='text' name='newStart' placeholder='ex)09:00'></td>");
	sb.Append("<td><input type='text' name='newEnd' placeholder='ex)09:50'></td>");
	sb.Append("<td><button class='btn-delete-temp'>삭제</button></td>"); 
	sb.Append("</tr>");
			
	$("#dates-table > tbody:last").prepend(sb.ToString());
});
		
$(document).on('click', '.btn-delete-temp', function(){
	$(this).parent().parent().remove();
});
		
$(document).on('click', '#date-submit-btn', function(){
	var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; 
	var time_pattern = /^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$/;
	var cardinal = $(":hidden[name='cardinalId']").val();
	var course = $(":hidden[name='courseId']").val();
	var dateFrom = $("#date-from").val();
	var dateTo = $("#date-to").val();
			
	var fromArray = dateFrom.split('-');
	var toArray = dateTo.split('-');
			
	var fromDate = new Date(fromArray[0], fromArray[1], fromArray[2]);
	var toDate = new Date(toArray[0], toArray[1], toArray[2]);

	var len = $('input[name=newDates]').length;
	// 각 시수의 시작, 끝 시간을 추가
	var sisuArr = [];   // 시차 
	var dateArr = [];	// 날짜
	var startArr = [];	// 시수 시작 시간
	var endArr = []; 	// 시수 끝나는 시간
	var jsonArr = [];
			
	for(var i=0; i<len; i++) {
		sisuArr[i] = $('input[name=newSisu]').eq(i).val();
	}
			
	for(var i=0; i<len; i++) {
		dateArr[i] = $('input[name=newDates]').eq(i).val();
	}
			
	for(var i=0; i<len; i++) {
		startArr[i] = $('input[name=newStart]').eq(i).val();
	}
			
	for(var i=0; i<len; i++) {
		endArr[i] = $('input[name=newEnd]').eq(i).val();
	}
			
	for(var i=0; i<len; i++) {
		if(!date_pattern.test(dateArr[i])) {
			alert("날짜 형식이 아닙니다. 다시 입력하세요");
			return;
		}
				
		var dArr = dateArr[i].split('-');
		var dDate = new Date(dArr[0], dArr[1], dArr[2]);
				
		if(fromDate.getTime() > dDate.getTime()) {
			alert("시작 날짜보다 빠릅니다.");
			break;
		} else if (toDate.getTime() < dDate.getTime()) {
			alert("마지막 날짜보다 느립니다.");
			break;
		}
	}
			
	for(var i=0; i<len; i++) {
		if(!time_pattern.test(startArr[i]) || !time_pattern.test(endArr[i])) {
			alert("시간 형식이 아닙니다. 다시 입력하세요.");
			return;
		}
				
		jsonArr.push({
			"courseId": course,
			"cardinalId": cardinal,
			"attDate": dateArr[i],
			"standInTime": startArr[i],
			"standOutTime": endArr[i],
			"sisu" : sisuArr[i]
		});
	}
			
	$.ajax({
		type: "POST"
		, url: "<c:url value='/data/attendance/newDatesAdd' />"
		, data: JSON.stringify(jsonArr)
		, contentType: "application/json"
		, success: function(data){
			alert(data);
			createTable();
		}
		, error: function(){
			alert("날짜 저장에 실패하였습니다.");
		}
	}); 
			
});
		
$("#termSearch").on("click", function(){
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
		
	$.ajax({
		type: "get"
		, url : "<c:url value='/data/attendance/selectDates' />"
		, data: {
			course_id: $(":hidden[name='courseId']").val(),
			cardinal_id: $(":hidden[name='cardinalId']").val(),
			startDate: startDate,
			endDate: endDate
		}
		, success : function (data) {
			var sb = new StringBuilder();
			
			sb.Append("<tbody>"); 
			if(data.length > 0) {
   				$.each(data, function(index, item) {
   					sb.Append("<tr><td>" + (index+1) + "</td>");
   					sb.Append("<td class='hasSisu' value='" + item.sisu + "'>" + item.sisu + "</td>");
   					sb.Append("<td class='hasvalue' data-value='" + item.attDate + "'>" + item.attDate + "</td>");
   					sb.Append("<td calss='hasStandInTime' data-value='" + item.standInTime + "'>" + item.standInTime + "</td>");
   					sb.Append("<td calss='hasStandOutTime' data-value='" + item.standOutTime + "'>" + item.standOutTime + "</td>");
   					sb.Append("<td><a class='btn btn-danger btn-delete' type='button'>삭제</td></tr>");
   				}); 
			} else {
				sb.Append("<tr><td class='empty-date'>조회된 일자가 없습니다.</td></tr>");
			}
			sb.Append("</tbody>"); 
			$("#dates-table").html(sb.ToString());
			$(".registeredDates").css("display", "block");
				
		}
		, error: function(e) {
			alert(e);
		}
	});
		
});
	
</script>

<div class="content_wraper">
	<h3>과정기수별출석일수관리</h3>			
	<div class="tab_body">
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>과정</th>
				<th>기수</th>
			</tr>
			</thead>
			<tbody>
				<tr>
					<td id='course'></td>
					<td id='cardinal'></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td><button type='button' id='courseListBtn'>선택</button></td>
					<td><button type='button' id='cardinalListBtn'>선택</button></td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	
	<br><br>
	<div class="tab_body dateDiv" style="display:none">
		<h3>출석일수등록</h3>
		<!-- 관리자 검색박스 서식 적용 -->
		<div>
       		<table class="searchTable">
       			<tr>
       				<th>연수기간</th>
       				<td>
       					<input type="date" id="date-from" /> 
       					<span> ~ </span>
       					<input type="date" id="date-to" />
       					<a class="btn" type="button" style="vertical-align: bottom;" id="date-during-button">날짜 지정</a>
 					</td>
 					<td class="buttonTd" style="width: 150px;">
       					<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id="add-date-btn">엑셀 다운로드</a>
 					</td>
       			</tr>
       			<tr>
       				<th>엑셀업로드</th>
       				<td>
       					<form action="/data/attendance/fileUpload" id="excelUpload" method="post" name="excelUpload" enctype="multipart/form-data">
							<input type="file" id="upload-file" name="dateExcel" value="엑셀 업로드">
							<input type="hidden" id="course-id" name="courseId">
							<input type="hidden" id="cardinal-id" name="cardinalId">
						</form>
       				</td>
       				<td class="buttonTd" style="width: 150px;">
						<a class="btn btn-danger" type="button" style="vertical-align: bottom;" id="file-upload-btn">업로드</a>
       				</td>
       			</tr>
       		</table>
       	</div>
	</div>
	<br>
	<div class="registeredDates" style="display: none">
		<table class="searchTable" style="margin-bottom: 20px;">
      		<tr>
      			<th>검색기간</th>
      			<td>
      				<input type="date" id="startDate" placeholder="yyyy-mm-dd">
      				<span> ~ </span>
      				<input type="date" id="endDate" placeholder="yyyy-mm-dd">
      			</td>
      			<td class="buttonTd" style="width: 150px;">
      				<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id="termSearch">검색</a>
      			</td>
      		</tr>
      		<tr>
      			<td class="buttonTd" colspan="3">
      				<a class="btn" type="button" style="vertical-align: bottom;"  id='date-add-btn'>일자추가</a>
      				<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id='date-submit-btn'>등록하기</a>
      			</td>
      		</tr>
      	</table>
		<table id='dates-table'>
		</table>
	</div>
	<div id='calendar'></div>
	<form name="regForm" id="regFormId" method="post">
		<input type="hidden" id="courseId" name="courseId">
		<input type="hidden" id="cardinalId" name="cardinalId">
		<input type="hidden" id="start" name="start">
		<input type="hidden" id="end" name="end">
	</form>
	
	
</div>