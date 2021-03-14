<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
var applyPagingNavigation = new PagingNavigation($("#applyPagination"));
var regPagingNavigation = new PagingNavigation($("#regPagination"));
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/member/memberList' />";
	var editUrl	= "<c:url value='/admin/member/memberEdit' />";
	var insUrl = "<c:url value='/data/learnApp/learnAppInsert' />";
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
	// 입과자 리스트 검색 버튼 클릭 시
	$("#regSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setRegUserList(1);
	});
	
	
	// 
	$('#applySearchBtn').unbind("click").bind("click", function(){
		setApplyUserList(1);
	});
	
	// 회원 리스트 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 입과자리스트 회원 이름 클릭 시 상세 페이지 이동
	$("#regListBody").on("click", ".content_edit", function() {
		var idx = $("#regListBody").find(".content_edit").index($(this));
		var selectId = $("#regListBody").find(":hidden[name='checkUserId']").eq(idx).val();
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$("form[name='regSearchForm']").children(":hidden[name='id']").val(selectId);
		
		// ajax로 load
		contentLoad("회원관리", editUrl, $("form[name='regSearchForm']").serialize());
	});
	
	// 
	$("#applyListBody").on("click", ".content_edit", function() {
		var idx = $("#applyListBody").find(".content_edit").index($(this));
		var selectId = $("#applyListBody").find(":hidden[name='checkUserId']").eq(idx).val();
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$("form[name='applySearchForm']").children(":hidden[name='id']").val(selectId);
		
		// ajax로 load
		contentLoad("회원관리", editUrl, $("form[name='applySearchForm']").serialize());
	});
	
	// 회원리스트 회원 이름 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $("#dataListBody").find(".content_edit").index($(this));
		var selectId = $("#dataListBody").find(":hidden[name='checkId']").eq(idx).val();
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$("form[name='searchForm']").children(":hidden[name='id']").val(selectId);
		
		// ajax로 load
		contentLoad("회원관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 입과자 리스트 전체 체크박스 클릭 시
	$("#allRegCheckBox").unbind("click").bind("click", function() {
		$("#regListBody").find(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
	});
	
	//
	$("#allApplyCheckBox").unbind("click").bind("click", function() {
		$("#applyListBody").find(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
	});
	
	// 회원 리스트 전체 체크박스 클릭 시
	$("#allCheckBox").unbind("click").bind("click", function() {
		$("#dataListBody").find(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
	});
	
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
	
	// 회원 리스트 보기
	$("#confirmReg").on("click", "#userListBtn", function() {
		// 과정/기수 선택 유효성 검사
		if ($(":hidden[name='cardinalId']").val() == '') {
			alert("과정/기수를 선택해주세요");
			return;
		}
		// 회원 리스트 보이게 하기
		$("#userList").show();
		// 회원 리스트 호출
		setContentList();
	});
	
	// 입과 대상자 삭제
	$("#userData").on("click", ".delBtn", function() {
		$(this).parent().parent().remove();
		// 데이터가 없으면 초기화
		if ($("#userData tr").length == 0) {
			$("#confirmReg").html("<tr><td colspan='3'>입과 대상자를 선택하세요</td></tr>");
		} else {
			$("#confirmReg").html("<tr><td colspan='3'>전체"+$("#userData tr").length+"명 <button type='button' id='learnRegBtn'>입과 처리</button></td></tr>");
		}
	});
	
	// 회원 선택 추가
	$("#selectAddBtn").unbind("click").bind("click", function() {
		var size = $("#dataListBody").find(":checkbox[name='selectCheckBox']:checked").size();
		
		if(size == 0) {
			alert("추가 할 데이터를 선택하세요.");
		} else if(confirm("선택 된 "+size+"건의 데이터를 추가하시겠습니까?")) {
			var sb = new StringBuilder();
			$("#dataListBody").find(":checkbox[name='selectCheckBox']:checked").each(function(i) {
				var idx = $("#dataListBody").find(":checkbox[name='selectCheckBox']").index($(this));
				var selectId = $("#dataListBody").find(":hidden[name='checkId']").eq(idx).val();
				var selectName = $("#dataListBody").find(":hidden[name='checkName']").eq(idx).val();
				
				// 중복 체크
				if ($("#userData input").length > 0) {
					var flag = true;
					$(":hidden[name='regId']").each(function(i){
						var regIdx = $(":hidden[name='regId']").index($(this));
						if ($(":hidden[name='regId']").eq(regIdx).val() == selectId) {
							flag = false;
							return false;
						}
					});
					
					if (flag == true) {
						sb.Append("<tr>");
						sb.Append(" <td>" +selectName+"</td>");
						sb.Append("	<td>");
						sb.Append("  <input type='hidden' name='regId' value='" +selectId+ "'>");
						sb.Append(	 selectId);
						sb.Append("	</td>");
						sb.Append("	<td><button type='button' class='delBtn'>삭제</button></td>");
						sb.Append("</tr>");
					}
					else {
						alert(selectName+"("+selectId+ ") : 이미 선택된 회원입니다.");
					}
				} else {
					sb.Append("<tr>");
					sb.Append(" <td>" +selectName+"</td>");
					sb.Append("	<td>");
					sb.Append("  <input type='hidden' name='regId' value='" +selectId+ "'>");
					sb.Append(	 selectId);
					sb.Append("	</td>");
					sb.Append("	<td><button type='button' class='delBtn'>삭제</button></td>");
					sb.Append("</tr>");
				}
				
				// 처음 등록할 경우
				if (i==0 && typeof $(":hidden[name='regId']").eq(0).val()=="undefined") {
					$("#userData").html(sb.ToString());
					sb.empty();
				}
			});

			$("#userData").append(sb.ToString());
			
			$("#confirmReg").html("<tr><td colspan='3'>총"+$("#userData tr").length+"명&nbsp&nbsp<button type='button' id='learnRegBtn'>입과 처리</button></td></tr>");
			
			$("#allCheckBox").prop("checked", false);
			$(":checkbox[name='selectCheckBox']").prop("checked", false);
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
				regData["admin_add_yn"] = "Y";
				regData["acceptance_yn"] = "Y";
				
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
					setRegUserList(1);
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
	
	// 수강자 입과 처리
	$("#selectApplyAddBtn").unbind("click").bind("click", function() {
		var learnAppInUrl = "<c:url value='/data/learnApp/learnAppSelectIn' />";
		var size = $("#applyListBody").find(":checkbox[name='selectCheckBox']:checked").size();
		
		if(size == 0) {
			alert("입과 처리 할 데이터를 선택하세요.");
		} else if(confirm("선택 된 "+size+"건의 데이터를 입과 처리하시겠습니까?")) {
			var data = {};
			var objList = new Array();
			
			$("#applyListBody").find(":checkbox[name='selectCheckBox']:checked").each(function(i) {
				var idx =$("#applyListBody").find(":checkbox[name='selectCheckBox']").index($(this));

				objList.push({"id" : $("#applyListBody").find(":hidden[name='checkId']").eq(idx).val()});
			});
			
			data = {"list" : objList};
			
			// ajax 처리 
			$.ajax({
				type		: "POST",
				url			: learnAppInUrl,
				data		: JSON.stringify(data),
				dataType	: "json",
				contentType	: "application/json; charset=utf-8",
				processData	: false,
				success		: function(result) {
					alert(result+"개 데이터가 입과 처리 되었습니다.");
					
					setRegUserList(1);
					setApplyUserList(1);
				},
				error		: function(e) {
					alert(e.responseText);
				}
			});
		}
	});	
	
	// 입과 취소  버튼 클릭 시
	$("#selectDelBtn").unbind("click").bind("click", function() {
		var size = $("#regListBody").find(":checkbox[name='selectCheckBox']:checked").size();
		
		if(size == 0) {
			alert("입과 취소 할 데이터를 선택하세요.");
		} else if(confirm("선택 된 "+size+"건의 데이터를 입과 취소하시겠습니까?")) {
			var data = {};
			var objList = new Array();
			
			$("#regListBody").find(":checkbox[name='selectCheckBox']:checked").each(function(i) {
				var idx =$("#regListBody").find(":checkbox[name='selectCheckBox']").index($(this));

				objList.push({"id" : $("#regListBody").find(":hidden[name='checkId']").eq(idx).val()});
			});
			
			data = {"list" : objList};
			
			// ajax 처리 
			$.ajax({
				type		: "POST",
				url			: selectDelUrl,
				data		: JSON.stringify(data),
				dataType	: "json",
				contentType	: "application/json; charset=utf-8",
				processData	: false,
				success		: function(result) {
					alert(result+"개 데이터가 입과 취소 되었습니다.");
					
					setRegUserList(1);
				},
				error		: function(e) {
					alert(e.responseText);
				}
			});
		}
	});
});

function setCourse(course) {
	$(":hidden[name='courseId']").val(course.id);
	$("#course").html(course.name);
	$(":hidden[name='course.id']").val(course.id);
	
}

function setCardinal(cardinal) {
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$("#cardinal").html(cardinal.name);
	
	// 입과자 정보 리스트
	$("#regUserList").show();
	$(":hidden[name='cardinal.id']").val(cardinal.id);
	setRegUserList();
	
	// 지원자 정보 리스트
	$('#applyUserList').show();
	$(":hidden[name='cardinal.id']").val(cardinal.id);
	setApplyUserList();
}

// 입과자 정보 리스트
function setRegUserList(pageNo) {
	var regListUrl = "<c:url value='/data/learnApp/learnAppList' />";

	// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
	pageNo = pageNo ? pageNo : $("form[name='regSearchForm']").find(":hidden[name='pageNo']").val();
	
	// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
	$("form[name='regSearchForm']").find(":hidden[name='pageNo']").val(pageNo);
	
	// ajax 처리
	$.ajax({
		type	: "post",
		url		: regListUrl,
		data 	: $("form[name='regSearchForm']").serialize(),
		success	: function(result) {
			// 체크박스 전체선택  초기화
			$("#allRegCheckBox").prop("checked", false);
			
			var sb = new StringBuilder();
			
			if(result.list && result.list.length > 0) {
				var dataList	= result.list;
				var pageNo		= result.pageNo		? result.pageNo		: 1;
				var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var regDate	 = dataInfo.regDate;

					sb.Append("<tr>");
					sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
					sb.Append("	<td>");
					sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
					sb.Append("		<input type='hidden' name='checkUserId' value='"+dataInfo.user.id+"' />");
					sb.Append("		<input type='hidden' name='checkName' value='"+(dataInfo.user.name ? dataInfo.user.name : "")+"' />");
					sb.Append(		((pageNo-1)*numOfRows+(i+1)));
					sb.Append("	</td>");
					sb.Append("	<td name='userName'>"+(dataInfo.user.name ? dataInfo.user.name : "")+"</td>");
					sb.Append("	<td class='content_edit'>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
					sb.Append("	<td>"+(dataInfo.user.phone ? dataInfo.user.phone : "")+"</td>");
					sb.Append("	<td>"+(dataInfo.user.email ? dataInfo.user.email : "")+"</td>");
					sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
					sb.Append("</tr>");
				}
			} else {
				sb.Append("<tr>");
				sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
				sb.Append("</tr>");
			}
			
			$("#regListBody").html(sb.ToString());
			
			// 페이징 처리
			regPagingNavigation.setData(result);				// 데이터 전달
			// 페이징(콜백함수 숫자 클릭 시)
			regPagingNavigation.setNavigation(setRegUserList);
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}

function setApplyUserList(pageNo) {
	var applyListUrl = "<c:url value='/data/learnApp/learnAppList' />";

	// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
	pageNo = pageNo ? pageNo : $("form[name='applySearchForm']").find(":hidden[name='pageNo']").val();
	
	// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
	$("form[name='applySearchForm']").find(":hidden[name='pageNo']").val(pageNo);
	
	// ajax 처리
	$.ajax({
		type	: "post",
		url		: applyListUrl,
		data 	: $("form[name='applySearchForm']").serialize(),
		success	: function(result) {
			// 체크박스 전체선택  초기화
			$("#allApplyCheckBox").prop("checked", false);
			
			var sb = new StringBuilder();
			
			if(result.list && result.list.length > 0) {
				var dataList	= result.list;
				var pageNo		= result.pageNo		? result.pageNo		: 1;
				var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var regDate	 = dataInfo.regDate;

					sb.Append("<tr>");
					sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
					sb.Append("	<td>");
					sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
					sb.Append("		<input type='hidden' name='checkUserId' value='"+dataInfo.user.id+"' />");
					sb.Append("		<input type='hidden' name='checkName' value='"+(dataInfo.user.name ? dataInfo.user.name : "")+"' />");
					sb.Append(		((pageNo-1)*numOfRows+(i+1)));
					sb.Append("	</td>");
					sb.Append("	<td name='userName'>"+(dataInfo.user.name ? dataInfo.user.name : "")+"</td>");
					sb.Append("	<td class='content_edit'>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
					sb.Append("	<td>"+(dataInfo.user.phone ? dataInfo.user.phone : "")+"</td>");
					sb.Append("	<td>"+(dataInfo.user.email ? dataInfo.user.email : "")+"</td>");
					sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
					sb.Append("</tr>");
				}
			} else {
				sb.Append("<tr>");
				sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
				sb.Append("</tr>");
			}
			
			$("#applyListBody").html(sb.ToString());
			
			// 페이징 처리
			applyPagingNavigation.setData(result);				// 데이터 전달
			// 페이징(콜백함수 숫자 클릭 시)
			applyPagingNavigation.setNavigation(setApplyUserList);
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}
</script>

<div class="content_wraper">
	<h3>입과관리</h3>			
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
	
	<div id="regUserList" class="tab_body" style="display:none">
		<h4>입과자 리스트</h4>
		<!-- searchForm start -->
       	<form name="regSearchForm" method="post">
       		<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드 검색</th>
	        			<td>
	        				<select name="searchCondition">
								<option value='all'>전체</option>
								<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
								<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
							</select>
							
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
							<button id='regSearchBtn' class="btn-primary" type="button">검색</button>
	        			</td>
	        		</tr>
	        	</table>
	        </div>
        	<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="cardinal.id" />
        	<input type="hidden" name="course.id" />
        	<input type="hidden" name="paymentState" value="" />
        	<input type="hidden" name="acceptance_yn" value='Y' />
        	<!-- <input type="hidden" name="payment" value='' /> -->
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allRegCheckBox' /></th>
				<th>연번</th>
				<th>성명</th>
				<th>아이디</th>
				<th>휴대전화</th>
				<th>전자우편</th>				 
				<th>입과일자</th>
			</tr>
			</thead>
			<tbody id="regListBody"></tbody>
		</table>
		<div id="regPagination" class="pagination"></div>
		<div class="paging">
			<a id="selectDelBtn" class="btn align_right danger" href="javascript:void();">입과취소</a>
		</div>
	</div>
	
	<br><br>
	
	<div id="applyUserList" class="tab_body" style="display:none">
		<h4>수강 신청자 리스트</h4>
		<!-- searchForm start -->
       	<form name="applySearchForm" method="post">
       		<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드 검색</th>
	        			<td>
	        				<select name="searchCondition">
								<option value='all'>전체</option>
								<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
								<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
							</select>
							
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
	        				<button id='applySearchBtn' class="btn-primary" type="button">검색</button>
	        			</td>
	        		</tr>
	        	</table>
	        </div>
        	<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="cardinal.id" />
        	<input type="hidden" name="course.id" />
        	<input type="hidden" name="paymentState" value="" />
        	<input type="hidden" name="acceptance_yn" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allApplyCheckBox' /></th>
				<th>연번</th>
				<th>성명</th>
				<th>아이디</th>
				<th>휴대전화</th>
				<th>전자우편</th>				 
				<th>입과일자</th>
			</tr>
			</thead>
			<tbody id="applyListBody"></tbody>
		</table>
		<div id="applyPagination" class="pagination"></div>
		<div class="paging">
			<a id="selectApplyAddBtn" class="btn align_right primary" href="javascript:void();">입과처리</a>
		</div>
	</div>
	
	<br><br>
	
	<div class="tab_body">
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th colspan="3">입과 대상자</th>
				</tr>
				<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="userData">
				<tr>
					<td colspan='3'>입과 대상자를 추가하세요</td>
				</tr>
			</tbody>
			<tfoot id="confirmReg">
				<tr>
					<td colspan='3'><button type='button' id='userListBtn'>입과 대상자 선택</button></td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<form name="learnRegForm" method="post">
		<input type="hidden" name="courseId">
		<input type="hidden" name="cardinalId">
	</form>
	
	<div id="userList" class="tab_body" style="display:none">
		<h4>회원 리스트</h4>
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드 검색</th>
	        			<td>
	        				<select name="searchCondition">
								<option value='all'>전체</option>
								<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
								<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
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
        	<input type="hidden" name="id" value="" />
        	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>연번</th>
				<th>성명</th>
				<th>아이디</th>
				<th>휴대전화</th>
				<th>전자우편</th>				 
				<th>가입일자</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div id="userPagination" class="pagination"></div>
		<a id="selectAddBtn" class="btn align_right primary" href="javascript:void();">선택추가</a>
	</div>
</div>