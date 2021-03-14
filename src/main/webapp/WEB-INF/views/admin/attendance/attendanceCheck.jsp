<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

var startDate;
var endDate;

$(document).ready(function () {
	$('.js-example-basic-single').select2();
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 달력 등 초기화
	setPageInit(editor_object, file_object);
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/member/memberList' />";
	var editUrl	= "<c:url value='/admin/member/memberEdit' />";
	var insUrl = "<c:url value='/data/attendance/dateReg' />";
	var selectUserUrl = "<c:url value='/data/attendance/selected' />";
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
						sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append("		<input type='hidden' name='checkName' value='"+(dataInfo.name ? dataInfo.name : "")+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td name='userName'>"+(dataInfo.name ? dataInfo.name : "")+"</td>");
						sb.Append("	<td class='content_edit'>"+(dataInfo.id ? dataInfo.id : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.phone ? dataInfo.phone : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.email ? dataInfo.email : "")+"</td>");
						sb.Append(" <td>"+dataInfo.regDate+"</td>")
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
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
	
	
	// 입과 처리
	$("#confirmReg").on("click", "#learnRegBtn", function() {
		if (confirm("입과처리하시겠습니까?")) {
			// 입과 정보
			var data = {};
			var cardinal = {};
			var course = {};
			var objList = new Array();
			
			var courseId = $(":hidden[name='courseId']").val();
			var cardinalId = $(":hidden[name='cardinalId']").val();
			
			if (!courseId || !cardinalId) {
				alert("과정/기수를 선택하세요.");
				return;
			}
			
			$(":hidden[name='regId']").each(function(i){
				var idx = $(":hidden[name='regId']").index($(this));
				var user = {};
				var regData = {};
				
				cardinal["id"] = cardinalId;
				course["id"] = courseId;
				user["id"] = $(":hidden[name='regId']").eq(idx).val();
				
				regData["user"] = user;
				regData["cardinal"] = cardinal;
				regData["course"] = course;
				
				objList.push(regData);
			});
			
			data = {"list" : objList};
			
			// 입과 처리
			$.ajax({
				type : "POST"
				, url : insUrl
				, data		: JSON.stringify(data)
				, dataType	: "text json"
				, contentType	: "application/json; charset=utf-8"
				, processData	: false
				, success		: function(result) {
					if (result.length != 0) {
						for (var i = 0; i < result.length; i++) {
							alert(result[i].user.id + ": 이미 입과된 회원입니다.");
						}
						alert("이미 입과된 회원을 제외하고 입과처리되었습니다.");
					} else {
						alert("입과 처리되었습니다.");
					}
					 
					// 입과 된 후 입과자 리스트 새로고침
					setRegUserList();
					$("#userData").html("<tr><td colspan='3'>입과 대상자를 추가하세요</td></tr>");
					$("#confirmReg").html("<tr><td colspan='3'><button type='button' id='userListBtn'>입과 대상자 선택</button></td></tr>");	
					$("#userList").hide();
					
				}
				, error		: function(e) {
					alert(e.responseText);
				}
			});
		};
	});	
	
	$("#selected-date").on("change", function(){
		createTable();
	});
	
	// 기간 탐색 시 출결 통계 출력
	$("#termSearch").on("click", function(){
		var course_id = $(":hidden[name='courseId']").val();
		var cardinal_id = $(":hidden[name='cardinalId']").val();
		var start_date = $("#start-date").val();
		var end_date = $("#end-date").val();
		
		var sb = new StringBuilder();
		
		if(start_date == '' || end_date == '') {
			alert("기간을 입력해주세요.");
			return;
		}
		
		$.ajax({
			type: "POST"
			, url: "<c:url value='/data/attendance/searchTerm' />"
			, data: {
				course_id: course_id
				, cardinal_id: cardinal_id
				, att_date: start_date
				, end_date: end_date
			}
			, success: function(data) {
				if($('.term-search-box').children().is('table')) {
					$('.term-search-box').empty();
				}
				
				var user_info = [];
				var attendance = [];
				var list = data[0];
				var map = data[1];
				var total = data[2];
				//console.log(total)
				//console.log(map);
				if(list.length != 0) {
				for(var i = 0; i < map.length; i++) {
					var user = {};
					user.id = map[i]["userId"];
					user.name = map[i]["userName"];
					user_info.push(user);
				}
				//console.log(user_info);
				for(var key in total[0]) {
					switch(key){
					case "ATT_DATE":
						break;
					default:
						attendance.push(key);
					}
				}
				
				sb.Append("<table>");
				
				for(var i = 0; i < user_info.length; i++) {
					if(i == 0) {
						sb.Append("<thead><tr>");
						sb.Append("<th></th>");
						for(var j = 0; j < total.length; j++) {
							sb.Append("<th>");
							sb.Append(total[j]["ATT_DATE"]);
							sb.Append("</th>");
						}
						
						for(var j = 0; j < attendance.length; j++) {
							sb.Append("<th>");
							switch(attendance[j]) {
							case "attend":
								sb.Append("출석");
								break;
							case "late":
								sb.Append("지각/조퇴");
								break;
							case "empty":
								sb.Append("결석");
								break;
							}
							sb.Append("</th>");
						}
						
						sb.Append("</tr></thead><tbody>");
					}
					
					sb.Append("<tr>");
					
					sb.Append("<td>");
					sb.Append(user_info[i]["name"]);
					sb.Append("</td>");
					
					var uList = new Array();
					
					for(var j = 0; j < list.length; j++) {
						if(user_info[i]["id"] == list[j]["USER_ID"]) {
							uList.push(list[j]);
						}
					}

					for(var n = 0; n < total.length; n++) {
						var flag = false;
						
						for(var j = 0; j < uList.length; j++) {
							if(user_info[i]["id"] == uList[j]["USER_ID"] && total[n]["ATT_DATE"] == uList[j]["ATT_DATE"]) {
								flag = true;
								
								sb.Append("<td>");
								switch(uList[j]["ATT_FINAL_GUBUN"]) {
								case "B4701":
									sb.Append("출석");
									break;
								case "B4702":
									sb.Append("결석");
									break;
								case "B4703":
									sb.Append("지각/조퇴");
									break;
								default:
									sb.Append("-");
									break;
								}
								sb.Append("</td>");
							}
						}
						
						if(flag == false) {
							sb.Append("<td>");
							sb.Append("-");
							sb.Append("</td>");
						}
					}
					
					for(var j = 0; j < map.length; j++) {
						if(user_info[i]["id"] == map[j]["userId"]) {
							for(var z = 0; z < attendance.length; z++) {
								sb.Append("<td>");	
								sb.Append(map[j][attendance[z]]);
								sb.Append("</td>");
							}
						}	
					}
					
					sb.Append("</tr>");
				}
					
				for(var i = 0; i < attendance.length; i++) {
					sb.Append("<tr>");
					sb.Append("<td>");
					switch(attendance[i]) {
					case "attend":
						sb.Append("출석");
						break;
					case "late":
						sb.Append("지각/조퇴");
						break;
					case "empty":
						sb.Append("결석");
						break;
					}
					sb.Append("</td>");
					for(var j = 0; j < total.length; j++) {
						sb.Append("<td>"+total[j][attendance[i]]+"</td>");
						
						if(i == 0 & j == total.length-1) {
							sb.Append("<td colspan='4' rowspan='4'></td>");
						}
					}
					sb.Append("</tr>");
				}
				
				sb.Append("</tbody></table>");
				
				$('.term-search-box').append(sb.ToString());
				} else {
					sb.Append("<table>");
					sb.Append("<tr><th></th></tr><tr><td>기간에 맞는 정보가 없습니다.</td></tr>");
					sb.Append("</table>");
					$('.term-search-box').append(sb.ToString());
				}
			}
			, error: function(data) {
				alert("리스트를 불러오는 데 실패했습니다.");
			}
		});
		
	});
});

// 출결 정보가 없는 학생 출결 정보 등록
$(document).on('click', "#user-submit-btn", function(){
	var arr = new Array();
	
	var id = $('input[name$="userId"]');
	var inTime = $('input[name$="inTime"]');
	var outTime = $('input[name$="outTime"]');
	var gubun = $('select[name$=gubun] > option:selected');
	var course = $(":hidden[name='courseId']").val();
	var cardinal = $(":hidden[name='cardinalId']").val(); 
	var att_date = $('#selected-date').val();
	
	if(inTime.length == 0 || inTime.length == 0 ) {
		alert("등록할 출결 정보가 없습니다.");
		return;
	}
	console.log(gubun);
	var it = [];
	var ot = [];
	var gu = [];
	var uid = [];
	
	for(var i = 0; i < inTime.length; i++) {
		if(inTime[i].value != "" || gubun[i].value == "B4702") { 
			it.push(inTime[i]);
			uid.push(id[i]);
			ot.push(outTime[i]);
			gu.push(gubun[i]);
		}
	}
	
	var ad = att_date.split("-");
	//console.log(id);
	//console.log(it);
	//console.log(outTime);
	//console.log(gubun);
	
	var time_pattern = /^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$/;
	
	for(var i = 0; i < uid.length; i++) {
		var obj = new Object();
		var user = uid[i].value;
		var inT = it[i].value;
		var outT = ot[i].value;
		var gb = gu[i].value;
		
		if(inT != '' && inT != null && outT != '' && outT != null) {
			if(!time_pattern.test(inT) || !time_pattern.test(outT)) {
				alert("시간을 잘못 입력하셨습니다.");
				return;
			}	
		
			var as1 = inT.split(":");
			var as2 = outT.split(":");
			
			var date1 = new Date(ad[0], ad[1]+1, ad[2], as1[0], as1[1]);
			var date2 = new Date(ad[0], ad[1]+1, ad[2], as2[0], as2[1]);
			
//			console.log(date1.getTime());
//			console.log(date2.getTime());
			
			if(date2.getTime() - date1.getTime() < 0) {
				alert("퇴실 시간이 입실시간보다 빠릅니다.");
				return;
			}
		} else if(gb != "B4702") {
			alert("시간을 입력해주세요.");
			return;
		}
		
		switch(gb) {
		case "B4701":
		case "B4702":
		case "B4703":
			break;
		case "":
			alert("구분을 입력해주세요.")
			return;
		}
		
		obj.user_id = user;
		obj.course_id = course;
		obj.cardinal_id = cardinal;
		obj.att_date = att_date;
		obj.in_time = inT;
		obj.out_time = outT;
		obj.att_final_gubun = gb;
		
		arr.push(obj);
	}
	
	var formArr = JSON.stringify(arr);
	$.ajax({
		url: "<c:url value='/data/attendance/attendInsert'/>"
		, type: "POST"
		, data: formArr
		, ataType:	"json"
		, contentType: 'application/json; charset=UTF-8'
		, success: function(data) {
			alert("자장에 성공하였습니다.");
			createTable();
		}
		, error: function(){
			alert("저장에 실패했습니다.");
		}
	}); 
});

$(document).on("click", "#updateStudents", function(){
	
	var selected_date = $("#selected-date").val();
	
	var inTime=[];
	var userId=[];
	var outTime=[];
	var memo=[];
	var attDtSeq=[];
	
	var data=[];
	
	if($("input:checkbox[name=isChecked]:checked").length <= 0) {
		alert("수정 할 학생을 체크 해주세요.");
	}else {
	 	$("input:checkbox[name=isChecked]:checked").each(function(){
	 		var value = $(this).parent().parent().find(".inTime").val();
	 		
			if(value == "-" || value == !value) {
				inTime.push(null);
			} else {
				var temp = selected_date + " " + $(this).parent().parent().find(".inTime").val();
				inTime.push(temp);
			}
		});
		
		
	 	$("input:checkbox[name=isChecked]:checked").each(function(){
	 		var value = $(this).parent().parent().find(".outTime").val();
	 		if(value == "-" || value == !value) {
				outTime.push(null);
			} else {
				var temp = selected_date + " " + $(this).parent().parent().find(".outTime").val();
				outTime.push(temp);
			}
		});
		
	 	$("input:checkbox[name=isChecked]:checked").each(function(){
	 		var value = $(this).parent().parent().find(".memo").val();
	 		if(value == "-" || !value) {
	 			memo.push(null);
	 		} else {
				memo.push($(this).parent().parent().find(".memo").val());
	 		}
		});
		
		$("input:checkbox[name=isChecked]:checked").each(function(){
			attDtSeq.push($(this).parent().parent().find(".attDtSeq").val());
		});
		
		$("input:checkbox[name=isChecked]:checked").each(function(){
			userId.push($(this).parent().parent().find(".userId").val());
		}); 
		
		for(var i=0; i<inTime.length; i++) {
			data.push({
				attDtSeq:attDtSeq[i],
				userId: userId[i],
				inTime: inTime[i],
				outTime: outTime[i],
				memo: memo[i]
			});
		}
		
	 	$.ajax({
			type: "POST"
			, url: "<c:url value='/data/attendance/attendanceUpdate'/>"
			, data: JSON.stringify(data)
			, dataType: "json"
			, contentType: "application/json; charset=utf-8"
			, processData: false
			, success: function(data) {
				alert("성공하였습니다.");
				createTable();
			}
			, error: function(){
				alert("실패했습니다.");
			}
		});
	}
	
});

function createTable(){
	var course_id = $(":hidden[name='courseId']").val();
	var cardinal_id = $(":hidden[name='cardinalId']").val();
	var selected_date = $("#selected-date").val();
	
	var sb = new StringBuilder();
	var sv = new StringBuilder();
	
	$.ajax({
		type: "POST"
		, url: "<c:url value='/data/attendance/selected' />"
		, data: {
			course_id: course_id
			, cardinal_id: cardinal_id
			, att_date:  selected_date
		}
		, success: function(data) {
			if(data.length == 0) {
				// 등록된 정보가 없습니다. 출력
				sb.Append("<div>조회된 결과가 없습니다.</div>");
			} else {
				if(!$('#studentsList').children().is('#user-submit-btn')) {
					sv.Append("<input type='button' id='user-submit-btn' value='저장하기'>");
					$("#studentsList").prepend(sv.ToString());	
				}
				// 각 인원들의 return 된 정보들 테이블로 생성.
				// checkbox가 체크 된 컬럼의 정보들만 가져와서 저장.
				sb.Append("<tr>");
				sb.Append("<th>수정</th>");
				sb.Append("<th>NO</th>");
				sb.Append("<th>이름</th>");
				sb.Append("<th>아이디</th>");
				sb.Append("<th>생년월일</th>");
				sb.Append("<th>입실시간</th>");
/* 				sb.Append("<th>인증수단</th>"); */
				sb.Append("<th>퇴실시간</th>");
/* 				sb.Append("<th>인증수단</th>"); */
				sb.Append("<th>출결상태</th>");
				sb.Append("<th>첨부파일</th>");
				sb.Append("<th>관리자 메모</th>");
				sb.Append("<th>사용자 메모</th>");
				sb.Append("</tr>");
				$.each(data, function(index, item){
					
					sb.Append("<tr>");
					if((item.IN_TIME == null || item.IN_TIME == "") && item.ATT_FINAL_GUBUN != "B4702") {
						sb.Append("<td><span value='-' disabled>-</span></td>");	
					} else {
						sb.Append("<td><input type='button' class='update-btn' value='수정'></td>");
					}
					
					sb.Append("<td>" + (index+1) + "</td>");
					sb.Append("<td class='user_Nm'><span class='user_Nm' value='"+ item.USER_NM +"'>" + item.USER_NM + "</span></td>");
					sb.Append("<td class='user_Id'><span class='user_Id' value='"+ item.USER_ID +"'>" + item.USER_ID + "</span></td>");
					sb.Append("<td class='user_Birth'><span class='user_Birth' value='"+ item.USER_BIRTH +"'>" + item.USER_BIRTH + "</span></td>");
					
					if(item.ATT_FINAL_GUBUN == "B4702") {
						sb.Append("<td><span value='-' disabled>-</span></td>");
					} else if(item.IN_TIME == null || item.IN_TIME == "") {
						sb.Append("<td><input type='text' class='inTime' name='inTime' placeholder='입실시간을 입력하세요'></td>");
					} else if(item.ATT_FINAL_GUBUN.indexOf('B4703') != -1) {
						sb.Append("<td><span class='inTime' value='" + item.IN_TIME + " ' style='color:red'>" + item.IN_TIME + "</span></td>");
					} else {
						sb.Append("<td><span class='inTime' value='" + item.IN_TIME + " '>" + item.IN_TIME + "</span></td>");
					}
					
/* 					sb.Append("<td>");      // 인증수단 컬럼추가 필요
					sb.Append("<select>");
					sb.Append("<option value=''>핸드폰</option>"); // value값 DB컬럼 추가해서 가져와야함 (핸드폰)
					sb.Append("<option value=''>컴퓨터</option>"); // value값 DB컬럼 추가해서 가져와야함 (컴퓨터)
					sb.Append("</select>");
					sb.Append("</td>"); */
					
					if(item.ATT_FINAL_GUBUN == "B4702") {
						sb.Append("<td><span value='-' disabled>-</span></td>");
					} else if(item.OUT_TIME == null || item.OUT_TIME == "") {
						sb.Append("<td><input type='text' class='outTime' name='outTime' placeholder='퇴실시간을 입력하세요.'></td>");
					} else if(item.ATT_FINAL_GUBUN.indexOf('B4703') != -1) {
						sb.Append("<td><span class='outTime' value='" + item.OUT_TIME + " ' style='color:red'>" + item.OUT_TIME + "</span></td>");
					} else {
						sb.Append("<td><span class='outTime' value='" + item.OUT_TIME + " '>" + item.OUT_TIME + "</span></td>");
					}
						
/* 					sb.Append("<td>");      // 인증수단 컬럼추가 필요
					sb.Append("<select>");
					sb.Append("<option value=''>핸드폰</option>"); // value값 DB컬럼 추가해서 가져와야함 (핸드폰)
					sb.Append("<option value=''>컴퓨터</option>"); // value값 DB컬럼 추가해서 가져와야함 (컴퓨터)
					sb.Append("</select>");
					sb.Append("</td>"); */
					
					if(item.ATT_FINAL_GUBUN == null || item.ATT_FINAL_GUBUN == "") {
						/* sb.Append("<td><input type='text' class='' name='attFinalGubun' placeholder='구분을 입력하세요.'></td>"); */
						sb.Append("<td>");
						sb.Append("<select name='gubun'>");
						sb.Append("<option value=''>구분</option>");
						sb.Append("<option value='B4701'>출석</option>"); 
						sb.Append("<option value='B4702'>결석</option>"); 
						sb.Append("<option value='B4703'>지각/조퇴</option>");
						/* sb.Append("<option value=''>지각</option>"); */
						/* sb.Append("<option value=''>조퇴</option>"); */
						sb.Append("</select>");
						sb.Append("</td>");
					} else {
						switch(item.ATT_FINAL_GUBUN) {
						case "B4701":
							sb.Append("<td class='attInfoGubun'>출석</td>");
							break;
						case "B4702":
							sb.Append("<td class='attInfoGubun'>결석</td>");
							break;
						case "B4703":
							sb.Append("<td class='attInfoGubun'>지각/조퇴</td>");
							break;
						}
					}
					
					if((item.certiAttachedFile != null && item.certiAttachedFile != '' && item.certiAttachedFile != undefined) || ((item.REG_ORIGIN_FILE != null && item.REG_ORIGIN_FILE != '' && item.REG_ORIGIN_FILE != undefined) && (item.REG_SAVED_FILE != null && item.REG_SAVED_FILE != '' && item.REG_SAVED_FILE != undefined))){
						sb.Append("<td><span style='font-weight: bold'>있음</span></td>"); // 증명서 부분.
					} else {
						sb.Append("<td><span>없음</span></td>");
					}
					
					if(item.MEMO == null || item.MEMO == "") sb.Append("<td>-</td>");
						else sb.Append("<td>"+item.MEMO+"</td>"); 
					
					if(item.USER_MEMO == null || item.USER_MEMO == "") sb.Append("<td>-</td>");
					else sb.Append("<td>"+item.USER_MEMO+"</td>"); 
					
					if((item.IN_TIME == null || item.IN_TIME == "") && item.ATT_FINAL_GUBUN != "B4702") {
						sb.Append("<input type='hidden' name='userId' value='" + item.USER_ID + "'>");	
					} else {
						sb.Append("<input type='hidden' class='attInfoTimeSeq' value='" + item.ATT_INFO_TIME_SEQ + "'>");
						sb.Append("<input type='hidden' class='userId' value='" + item.USER_ID + "'>");
						sb.Append("<input type='hidden' class='attDtSeq' value='" + item.ATT_DT_SEQ + "'>");
					}
					
					sb.Append("</tr>");
				});
			}
			
			$("#studentsListTable").html(sb.ToString());
		}
	});
}

function setCourse(course) {
	$(":hidden[name='courseId']").val(course.id);
	$("#course").html(course.name);
}

function setCardinal(cardinal) {
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$(":hidden[name='cardinal_nm']").val(cardinal.name);
	$("#cardinal").html(cardinal.name);
	$("#date-from").html(cardinal.learnStartDate);
	$("#date-to").html(cardinal.learnEndDate);
	var sb2 = new StringBuilder();
	
	$.ajax({
		type : "POST"
		, url : "<c:url value='/data/attendance/studentList' />"
		, data		: $("form[name='regForm']").serialize()
		, success		: function(result) {
		 	sb2.Append('<option value="" disabled hidden>이름 검색</option>');
			sb2.Append('<option value="">[전체 검색]</option>');
			
			for (var i = 0; i < result.length; i++) {
				if (result[i].USER_NM === undefined) {
					continue;
				}
				sb2.Append('<option value="'+result[i].USER_ID+'">'+result[i].USER_NM+' / '+result[i].USER_ID+'</option>');
			}
			$("#printStudent").html(sb2.ToString());
			$("#date-from").val(result.start);
			$("#date-to").val(result.end);
			$("#start").val(result.start);
			$("#end").val(result.end);
			
			$(".dateDiv").css("display", "block"); 
			/* renderCalendar(result.start,result.end); */ 
			
		}
		, error		: function(e) {
		
		}
	});
	
	
	//$(".dateDiv").css("display","block");
	//setRegUserList(1);
}

function renderCalendar(dateFrom,dateTo){
	
	var startMonth=parseInt(dateFrom.split("-")[1]-1);
	var lastMonth=parseInt(dateTo.split("-")[1]);

	startDate=dateFrom;	
	
	$('#calendar').fullCalendar({

		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'year,month,agendaWeek,agendaDay'
		},
	
		firstMonth: startMonth, 
		//lastMonth: lastMonth,
		lang:"ko",
		defaultDate: dateFrom, 
		defaultView: 'month',
		selectable: true,
		eventConstraint:{
			   start: dateFrom,
		        end: dateTo+" 20:00:00"
	    },

		selectAllow:{
			start: dateFrom,
	        end: dateTo+" 20:00:00"
		},
		selectHelper: true,
		select: function(start, end) {
			/* var title = prompt('Event Title:');
			var eventData;
			if (title) {
				eventData = {
					title: title,
					start: start,
					end: end+" T20:00:00"
				};
				$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
			}
			$('#calendar').fullCalendar('unselect'); */
			
			if(moment(moment(start).format('YYYY-MM-DD')+" 06:00:00").isAfter(dateFrom)&&moment(start).isBefore(dateTo+" 20:00:00")){
				var data={
						presentDate:moment(start).format('YYYY-MM-DD'),
						courseId:$(":hidden[name='courseId']").val(),
						cardinalId:$(":hidden[name='cardinalId']").val()
				}
				openLayerPopup(moment(start).format('YYYY년MM월DD일')+" 출결관리", "/admin/common/popup/attendList", data);
			}else{
				alert("출결관리 가능일자가 아닙니다.");
			}
			
			
		},
		firstDay: 0, 
		eventStartEditable: false,
		editable: false,
		eventLimit: true, // allow "more" link when too many events
		events: [
			{
				title: '연수기간',
				start: dateFrom,
				end: dateTo+" 20:00:00"
			}]
		
	});
	
}

$(document).on('click', '.update-btn', function(){
	
	var attInfoTimeSeq = $(this).parent().parent().find('.attInfoTimeSeq').attr('value');
	var userId = $(this).parent().parent().find('.userId').attr('value');
	var attDtSeq = $(this).parent().parent().find('.attDtSeq').attr('value');
	var cardinal = $(":hidden[name='cardinalId']").val();
	
	var object = new Object();
	
	object.attInfoTimeSeq = attInfoTimeSeq;
	object.userId = userId;
	object.attDtSeq = attDtSeq;
	object.cardinal = cardinal;
	
	openLayerPopup("유저 출석정보 업데이트", "/admin/common/popup/attendanceUpdate", object);
});

$("#stu-list-download").on("click", function(){
	
	var course = $(":hidden[name='courseId']").val();
	var cardinal = $(":hidden[name='cardinalId']").val();
	
	location.href = "/data/attendance/stuListDownload?course_id=" + course + "&cardinal_id=" + cardinal;
	
});

$("#file-upload-btn").on("click", function(){
	
	var course = $(":hidden[name='courseId']").val();
	var cardinal = $(":hidden[name='cardinalId']").val();
	var upload = $("#upload-file").val();
	
	if(!upload) {
		alert("파일을 선택하세요.");
		return;
	}
	
	
	var formData = new FormData($('#excelUpload')[0]);
	
	$.ajax({
		url: '<c:url value="/data/attendance/attendUpload"/>',
		type: "POST",
		data: formData,
        processData: false,
        contentType: false,
		success: function() {
			alert("저장에 성공하였습니다.");
			createTable();
		},
		error: function() {
			alert("저장에 실패하였습니다.");
		}
	});
	
});

$(document).on('click', '#popupStudent', function(){
	var student = $("form[name='printForm']")[0];
	var start_date = $("#start-date-print").val();
	var end_date = $("#end-date-print").val();
	var teacher = $("#teacher").val();
	var val = $('#printStudent option:selected').val();
	var name = $('#printStudent option:selected').text();
	
	if(!start_date || !end_date) {
		alert("기간을 입력해주세요.");
		return;
	}
	if(!val) {
		alert("학생 이름을 선택해주세요.");
		return;
	}
	if(!teacher) {
		alert("훈련교사 이름을 입력해주세요.");
		return;
	}
	
	$("form[name='printForm']").find(":hidden[name='userId']").val(val);
	$("form[name='printForm']").find(":hidden[name='start_date']").val(start_date);
	$("form[name='printForm']").find(":hidden[name='end_date']").val(end_date);
	$("form[name='printForm']").find(":hidden[name='user_nm']").val(name.split("/")[0].trim());
	$("form[name='printForm']").find(":hidden[name='teacher_nm']").val(teacher);
	
	window.open('','openWindow',"width=800px, height=900px,scrollbars=yes");
	student.action = "/data/attendance/printAttendance";
	student.target = "openWindow";
	student.submit();
});
</script>


<div class="content_wraper">
	<h3>출결관리</h3>			
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
		<h3 style="margin-bottom: 10px; padding-bottom: 0px;">출석일 선택</h3>
		<label>연수기간 : <span id="date-from"></span> ~<span id="date-to"></span></label>
		<div>
       		<table class="searchTable">
       			<tr>
       				<th>학생 출석부 출력</th>
       				<td>
       					<input type="date" id="start-date-print" placeholder="yyyy-mm-dd">
       					<span> ~ </span>
       					<input type="date" id="end-date-print" placeholder="yyyy-mm-dd"><br>
       					<label style="margin-bottom:0px;margin-left: 2%;margin-right: 1%;">이름 : </label>
  						<select class="js-example-basic-single" style="width: 30%;" name="state" id="printStudent" onchange="">
  							<option value="" disabled hidden>이름을 검색해주세요..</option>
  							<option value="">[전체 검색]</option>
  						</select>
  						<input type="text" id="teacher" style="margin-left: 50px;" placeholder="훈련고사 이름을 입력해주세요.">
 					</td>
 					<td class="buttonTd" style="width: 150px;">
       					<a class="btn btn-primary" type="button" id="popupStudent" style="vertical-align: bottom;">출석부 출력</a>
 					</td>
       			</tr>
       			<tr>
       				<th>기간검색</th>
       				<td>
       					<input type="date" id="start-date" placeholder="yyyy-mm-dd">
       					<span> ~ </span>
       					<input type="date" id="end-date" placeholder="yyyy-mm-dd">
 					</td>
 					<td class="buttonTd" style="width: 150px;">
       					<a class="btn btn-primary" type="button" id="termSearch" style="vertical-align: bottom;">검색</a>
 					</td>
       			</tr>
       			<tr>
       				<th>선택일자</th>
       				<td>
       					<input type="date" id="selected-date" placeholder="yyyy-mm-dd">
       				</td>
       				<td class="buttonTd" style="width: 150px;">
       					<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id="stu-list-download" >엑셀 다운로드</a>
       				</td>
       			</tr>
       			<tr>
       				<th>엑셀업로드</th>
       				<td>
       					 <form action="/data/attendance/attendUpload" id="excelUpload" method="post" name="excelUpload" enctype="multipart/form-data">
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
<!-- 	 기간 검색 <input type="date" id="start-date" placeholder="yyyy-mm-dd"> ~ <input type="date" id="end-date" placeholder="yyyy-mm-dd"><br><br> -->
<!-- 	 선택 일자 <input type="date" id="selected-date" placeholder="yyyy-mm-dd"> -->
<!-- 	 <input type="button" id="stu-list-download" value="엑셀 다운로드"> -->
<!-- 	 <form action="/data/attendance/attendUpload" id="excelUpload" method="post" name="excelUpload" enctype="multipart/form-data"> -->
<!-- 		<input type="file" id="upload-file" name="dateExcel" value="엑셀 업로드"> -->
<!-- 		<input type="hidden" id="course-id" name="courseId"> -->
<!-- 		<input type="hidden" id="cardinal-id" name="cardinalId"> -->
<!-- 		<button type="button" id="file-upload-btn">업로드</button> -->
<!-- 	</form> -->
	<div id="studentsList">
		<div>
			<table id="studentsListTable">
			</table>
			<!-- 이곳에 기간 검색 통계 -->
			<br><br>
			<div class="term-search-box">
			</div>
		</div>
	</div>
	</div>
	<div id="regListBody"></div>
	<div id="notice" style="display:none"><h4> 출결관리(날짜를 클릭) </h4></div>
	<br><br>
	<div id='calendar'></div>
	
	<form name="regForm" method="post">
		<input type="hidden" name="courseId">
		<input type="hidden" name="cardinalId">
	</form>
		<form name="printForm" method="post">
		<input type="hidden" name="courseId">
		<input type="hidden" name="cardinalId">
		<input type="hidden" name="userId">
		<input type="hidden" name="start_date">
		<input type="hidden" name="end_date">
		<input type="hidden" name="user_nm">
		<input type="hidden" name="cardinal_nm">
		<input type="hidden" name="teacher_nm">
	</form>	
</div>