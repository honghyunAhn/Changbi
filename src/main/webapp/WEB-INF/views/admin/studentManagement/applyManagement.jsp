<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<!-- 지원서 리스트 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/applyManagement.css" />">
<script type="text/javascript">

$(document).ready(function () {

	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/admin/apply/applyList' />";
	
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
			success	: function(result){
				var sb = new StringBuilder();
				var sbModal = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					$('#totalCntLabel').html('Total: '+ result.totalCount +' 건');
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var app_seq = dataInfo.stu_app_seq;
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						
						sb.Append("	<input type='checkbox' name='checkBoxes' value='"+dataInfo.stu_app_seq+"' class='checkBoxes' onclick='changeTrColor(this)' />");
						sb.Append(	'<input type="hidden" class="crc_id" value="' + dataInfo.crc_id + '">');
						sb.Append(	'<input type="hidden" class="gisu_id" value="' + dataInfo.gisu_id + '">');
						sb.Append("	</td>");
						sb.Append("	<td>" + ((pageNo-1)*numOfRows+(i+1)) +"</td>");
						sb.Append("	<td>"+(dataInfo.gisu_nm ? dataInfo.gisu_nm : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.stu_app_ins_dt ? dataInfo.stu_app_ins_dt : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.user_id ? dataInfo.user_id : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.stu_app_nm ? dataInfo.stu_app_nm : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.stu_app_phone ? dataInfo.stu_app_phone : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.stu_app_email ? dataInfo.stu_app_email : "")+"</td>");
						
// 						sb.Append('<td><button class="btn-primary" type="button" onclick="viewApplyForm()">보기</button></td>');
 						sb.Append('<td><a href="<c:url value="/admin/apply/viewApplyForm?user_id="/>'+dataInfo.user_id+'&gisu_id='+dataInfo.gisu_id+'" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#myModal'+app_seq+'">보기</a></td>');
							sbModal.Append('<div class="modal fade bs-example-modal-lg" id="myModal'+app_seq+'" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">');
							sbModal.Append('<div class="modal-dialog" style="max-width:100%; width:1100px; display:table;">');
							sbModal.Append('<div class="modal-content"><div style="margin:1%;margin-bottom:10%;">');
							sbModal.Append('</div></div></div></div>');
							
						sb.Append("<td>");
						sb.Append('<input type="hidden" id="app_rt_doc_'+i+'" value="'+dataInfo.stu_app_rt_doc+'">');
						sb.Append("<select>");
						if (dataInfo.stu_app_rt_doc == 'B1400') {
							sb.Append("<option value='B1400' selected>대기</option>");
							sb.Append("<option value='B1401'>합격</option>");
							sb.Append("<option value='B1402'>불합격</option>");
						} else if (dataInfo.stu_app_rt_doc == 'B1401') {
							sb.Append("<option value='B1400'>대기</option>");
							sb.Append("<option value='B1401' selected>합격</option>");
							sb.Append("<option value='B1402'>불합격</option>");
						} else if (dataInfo.stu_app_rt_doc == 'B1402') {
							sb.Append("<option value='B1400'>대기</option>");
							sb.Append("<option value='B1401'>합격</option>");
							sb.Append("<option value='B1402' selected>불합격</option>");
						} 
						sb.Append("</select></td>");
						
						if(dataInfo.stu_app_rt_doc_dt != null){
							sb.Append("<td>" + dataInfo.stu_app_rt_doc_dt.substring(0,19) + "</td>");
							sb.Append("<td>" + dataInfo.stu_app_rt_doc_id + "</td>");
						} else {
							sb.Append("<td></td><td></td>")
						}
						
						sb.Append("<td>");
						sb.Append('<input type="hidden" id="app_rt_itv_'+i+'" value="'+dataInfo.stu_app_rt_itv+'">');
						sb.Append("<select>");
						if (dataInfo.stu_app_rt_itv == 'B1700') {
							sb.Append("<option value='B1700' selected>대기</option>");
							sb.Append("<option value='B1701'>합격</option>");
							sb.Append("<option value='B1702'>불합격</option>");
						} else if (dataInfo.stu_app_rt_itv == 'B1701') {
							sb.Append("<option value='B1700'>대기</option>");
							sb.Append("<option value='B1701' selected>합격</option>");
							sb.Append("<option value='B1702'>불합격</option>");
						} else if (dataInfo.stu_app_rt_itv == 'B1702') {
							sb.Append("<option value='B1700'>대기</option>");
							sb.Append("<option value='B1701'>합격</option>");
							sb.Append("<option value='B1702' selected>불합격</option>");
						} 
						sb.Append("</select></td>");
						
						if(dataInfo.stu_app_rt_itv_dt != null){
							sb.Append("<td>" + dataInfo.stu_app_rt_itv_dt.substring(0,19) + "</td>");
							sb.Append("<td>" + dataInfo.stu_app_rt_itv_id + "</td>");
						} else {
							sb.Append("<td></td><td></td>")
						}
						
						switch(dataInfo.confirm){
						case "1":
							sb.Append('<td>확정<input type="hidden" value="confirmed"></td>');
							break;
						case "2":
							sb.Append('<td class="tipTD" data-text="수강관리 -> 입과관리에서 입과처리 되었습니다. 학적부를 생성하려면 연수인원 확정 버튼을 누르세요.">기타</td>');
							break;
						case "3":
							sb.Append("<td></td>");
							break;
						}
						
						sb.Append("</tr>");
					}
				} else {
					$('#totalCntLabel').html('Total: 0건');
					sb.Append("<tr>");
					sb.Append("	<td colspan='16'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				$("#dataListBody").html(sb.ToString());
				$("#modalsContentss").append(sbModal.ToString());
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
				
				$('#allCheckBox').prop('checked', false);
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
	// 전체초기화 버튼 클릭 시
	$("#searchAllBtn").unbind("click").bind("click", function() {
		contentLoad('지원자 관리','/admin/studentManagement/applyManagement');
	});
	
	// 체크박스 전부 선택
	$('#allCheckBox').click(function(){
		if($(this).prop("checked")){
			$("input[type=checkbox]").prop("checked",true);
			$('.applyTb').find('tr').css("background-Color","#E0E0E0");
		}else{
			$("input[type=checkbox]").prop("checked",false);
			$('.applyTb').find('tr').css("background-Color","");
		}
	});
	$('#numOfRows').on('change', function() {
		$(':hidden[name=numOfRows]').val($(this).val());
		$("#searchBtn").trigger('click');
	})
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	searchList();
	setContentList();
	
	//메일/sms 이벤트 연결
	setSendBtn();
}); //readyFunction 끝

// checkbox 체크한 행의 색깔 바꾸기
function changeTrColor(obj){
	if($(obj).prop("checked"))
		$(obj).closest('tr').css("background-Color","#E0E0E0");
	else
		$(obj).closest('tr').css("background-Color","");
}

// 전형결과 저장
function update_result(){
	if ($("input:checkbox[name='checkBoxes']:checked").length == 0) {
        alert("선택된 지원자가 없습니다.\n지원자를 선택해주세요.");
        return false;
    }
	
	var result_array = new Array;
	
	$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
		var check = $(this).closest('tr').find('td:eq(15)').find('input').val();
		if(check == "confirmed") return true; //연수인원으로 확정된 사람은 skip
		
		original_doc = $(this).closest('tr').find('td:eq(9)').find('input').val();
		update_doc = $(this).closest('tr').find('td:eq(9)').find("option:selected").val();
		
		original_itv = $(this).closest('tr').find('td:eq(12)').find('input').val();
		update_itv = $(this).closest('tr').find('td:eq(12)').find("option:selected").val();
		
		var result = {
			stu_app_seq : item.value
			,stu_app_rt_doc : (original_doc != update_doc) ? update_doc : null
			,stu_app_rt_itv : (original_itv != update_itv) ? update_itv : null
		};
		result_array.push(result); 
    });
	
	if(result_array.length == 0) {
		alert("연수인원으로 확정되어 전형결과를 수정할 수 없습니다.");
		
		$('#allCheckBox').trigger('click');
		$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
    		this.checked = false;
        });
		
		return;
	}
	
 	$.ajax({
	    type : "POST"
	    ,url : "/admin/apply/apply_rt_update"
	    ,data : JSON.stringify(result_array)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	alert("전형결과가 저장되었습니다.");
	    	contentLoad('지원자 관리','/admin/studentManagement/applyManagement', $("form[name='searchForm']").serialize());
	    }
	    ,error : function(e) {
	    	alert("저장하는데 실패 하였습니다.");
	    }
	});
}	

// 연수인원 확정
function confirm_student(){
	if($("input:checkbox[name=checkBoxes]:checked").length == 0) {
        alert("선택된 지원자가 없습니다.\n지원자를 선택해주세요.");
        return false;
    }
	
	var student_array = new Array;
	
	$("input:checkbox[name=checkBoxes]:checked").each(function(index,item){
		var check = $(this).closest('tr').find('td:eq(15)').find('input').val();
		if(check == "confirmed") return true; //연수인원으로 확정된 사람은 skip
		
		var student = {
			stu_app_seq : item.value
			,user_id : $(this).closest("tr").find("td:eq(4)").text()
			,crc_id : $(this).siblings('.crc_id').val()
			,gisu_id : $(this).siblings('.gisu_id').val()
		};
		student_array.push(student);
    });

	if(student_array.length == 0) {
		alert("이미 연수인원으로 확정되어 있습니다.");

		$('#allCheckBox').prop('checked', false);
		$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
    		this.checked = false;
    		$(item).closest('tr').css("background-Color","");
        });
		return;
	}
	
 	$.ajax({
	    type : "POST"
	    ,url : "/admin/apply/confirm_student"
	    ,data : JSON.stringify(student_array)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data){
	    		alert("학적부 생성과 입과 처리를 완료하였습니다.");
		    	contentLoad('지원자 관리','/admin/studentManagement/applyManagement', $("form[name='searchForm']").serialize());
	    	}else{
	    		alert("학적부 생성 /입과 처리 실패");
	    	}
	    }
	    ,error : function(e) {
	    	alert("통신 실패");
	    }
	});
}

// 연수인원 확정 취소
function cancel_student(){
	if ($("input:checkbox[name=checkBoxes]:checked").length == 0) {
        alert("선택된 지원자가 없습니다.\n지원자를 선택해주세요.");
        return false;
    }
	
	var student_array = new Array;
	
	$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
		var check = $(this).closest('tr').find('td:eq(15)').find('input').val();
		if(check != "confirmed") return true; //연수인원 확정을 하지 않은 사람은 skip
		
		var student = {
			stu_app_seq : item.value
			,user_id : $(this).closest("tr").find("td:eq(4)").text()
			,crc_id : $(this).siblings('.crc_id').val()
			,gisu_id : $(this).siblings('.gisu_id').val()
		};
		student_array.push(student);
    });

	if(student_array.length == 0) {
		alert("연수인원이 아닙니다.");
		
		$('#allCheckBox').prop('checked', false);
		$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
    		this.checked = false;
    		$(item).closest('tr').css("background-Color","");
        });
		return;
	}
	
 	$.ajax({
	    type : "POST"
	    ,url : "/admin/apply/cancel_confirm"
	    ,data : JSON.stringify(student_array)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data){
	    		alert("입과처리를 취소하였습니다");
		    	contentLoad('지원자 관리','/admin/studentManagement/applyManagement', $("form[name='searchForm']").serialize());
	    	}else{
	    		alert("입과처리 취소 실패");
	    	}
	    }
	    ,error : function(e) {
	    	alert("통신 실패");
	    }
	});
}

// 지원신청서 출력
function print_applyForm(){
	
	if ($("input:checkbox[name=checkBoxes]:checked").length == 0) {
        alert("선택된 지원자가 없습니다.\n지원자를 선택해주세요.");
        return false;
    }
	
	var sb = new StringBuilder();
	$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
		var user_id = $(this).closest("tr").find("td:eq(4)").text();
		var gisu_id = $(this).siblings('.gisu_id').val();
		
		sb.Append('<input type="hidden" name="user_id" value="'+ user_id +'">');
		sb.Append('<input type="hidden" name="gisu_id" value="'+ gisu_id +'">');
    });
	$("#applyForm_popup").html(sb.ToString());
	
	var popupX = (window.screen.width / 2) - ( 1200 / 2 );
	var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
	var applyForm_popup = document.applyForm_popup;
	window.open('','applyForm_print',"width=1100,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
	applyForm_popup.target = 'applyForm_print';
	applyForm_popup.submit();
}

function print_allApplyForm(){
	
	$(":hidden[name='pagingYn']").val('N');
	
	var sb = new StringBuilder();
	var list;
	$.ajax({
		type	: "post",
		url		: "<c:url value='/admin/apply/applyList' />",
		data 	: $("form[name='searchForm']").serialize(),
		async: false,
		success	: function(result){
			list = result.list;
		}
	});
	$.each(list, function(index,item){
		var user_id = item.user_id;
		var gisu_id = item.gisu_id;
		sb.Append('<input type="hidden" name="user_id" value="'+ user_id +'">');
		sb.Append('<input type="hidden" name="gisu_id" value="'+ gisu_id +'">');
	});
	$("#applyForm_popup").html(sb.ToString());
	
	var popupX = (window.screen.width / 2) - ( 1200 / 2 );
	var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
	var applyForm_popup = document.applyForm_popup;
	window.open('','applyForm_print',"width=1100,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
	applyForm_popup.target = 'applyForm_print';
	applyForm_popup.submit();
	$(":hidden[name='pagingYn']").val('Y');
}

/* myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
	
	$scope.doc_change = function(doc, app_rt_seq){
		var app_rt_doc = angular.element(doc).prevAll(".docSelect_prev").next().val();
		$http({
			method: 'POST',
			url: "/edu/admin/apply_result_update",
			params : {
				app_rt_doc : app_rt_doc,
				app_rt_seq : app_rt_seq
			}
		}).then(function successCallback(response) {
			alert("서류 결과를 변경 하였습니다.");
			$scope.list_draw(response);
		}, function errorCallback(response) {
		});
		
	};

}]);
 */

function setGisu(seq){
	$('#searchGisu_id').val(seq);
}

function searchListGisu(seq){
	var sb = new StringBuilder();
	var gisu_id = $('#searchGisu_id').val();
	var newSeq = seq;
	
	$('#searchCrc_id').val(seq);
	
	var Url	= "<c:url value='/student/TestManagement/searchGisuList' />";
	$.ajax({
		type	: "post",
		data 	: newSeq,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<option value="" selected>기수 선택</option>');
			
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				
				if(map.gisu_seq == gisu_id)
					sb.Append('<option value="'+map.gisu_seq+ '" selected>'+map.gisu_crc_nm+'</option>');
				else
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
	 		}
	 		$('#gisuSelector').append(sb.ToString());
	 	}
	});
}

function searchList(){
	var sb = new StringBuilder();
	var crc_id = $('#searchCrc_id').val();
	var Url	= "<c:url value='/student/TestManagement/searchCirriculumList' />";
	
	$.ajax({
		type	: "post",
		url		: Url,
		async	: false,
		success : function(result){
				$("#gwajeongSelector").html("");
				sb.Append('<option value="" selected>과정 선택</option>');
				
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					
					if(map.CRC_CLASS == crc_id){
						sb.Append('<option value="'+map.CRC_CLASS+ '" selected>'+map.CRC_NM+'</option>');
						searchListGisu(map.CRC_CLASS);
					}else sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
				}
		 		$('#gwajeongSelector').append(sb.ToString());
	 		}
		});
}

function setSendBtn() {
	$('#sendBtn').on('click', function() {
		
		var list = new Array();
		
		if ($("input:checkbox[name=checkBoxes]:checked").length == 0) {
	        alert("선택된 지원자가 없습니다.\n지원자를 선택해주세요.");
	        return false;
	    }
		
		$("input:checkbox[name='checkBoxes']:checked").each(function(index,item){
			var user_id = $(this).closest('tr').find('td:eq(4)').text();
			var stu_app_nm = $(this).closest('tr').find('td:eq(5)').text();
			var stu_app_phone = $(this).closest('tr').find('td:eq(6)').text();
			var stu_app_email = $(this).closest('tr').find('td:eq(7)').text();
			var obj = new Object();
			
			obj.user_id = user_id;
			obj.stu_app_phone = stu_app_phone;
			obj.stu_app_email = stu_app_email;
			obj.stu_app_nm = stu_app_nm;
			list.push(obj);
		});
		var data = new Object();
		data.list = JSON.stringify(list);
		openLayerPopup("메일/SMS 발송", "/admin/common/popup/smsMail", data);
	})
}
</script>

<div class="content_wraper" id="modalsContentss">
	<h3>지원자 관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
        	<input type="hidden" name="crc_id" value="${search.crc_id }" id="searchCrc_id"/>
        	<input type="hidden" name="gisu_id" value="${search.gisu_id }" id="searchGisu_id"/>
        	
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>과정명</th>
	        			<td>
	        				<select class="selector" id="gwajeongSelector" onchange="searchListGisu(this.value);"></select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>기수명</th>
	        			<td>
	        				<select class="selector" id="gisuSelector" onchange="setGisu(this.value);"></select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>서류전형 합격여부</th>
	        			<td>
	        				<select class="selector" name="stu_app_rt_doc">
								<option value="" selected>전체</option>
								<option value="B1400">대기</option>
								<option value="B1401">합격</option>
								<option value="B1402">불합격</option>
							</select>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>면접전형 합격여부</th>
	        			<td>
		        			<select class="selector" name="stu_app_rt_itv">
								<option value="" selected>전체</option>
								<option value="B1700">대기</option>
								<option value="B1701">합격</option>
								<option value="B1702">불합격</option> 
							</select>
	        			</td>
	        		</tr>
        			<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<select class="searchConditionBox" name="searchCondition">
								<option value='all' <c:if test="${search.searchCondition eq 'all'}">selected</c:if>>전체</option>
								<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
								<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
							</select>
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>전체 인쇄</th>
	        			<td>
	        				<a class="btn btn-primary" type="button" style="vertical-align: bottom;" onclick="print_allApplyForm()">전체 인쇄</a>
	        				<span>검색 조건에 해당하는 지원서를 모두 인쇄합니다.</span>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>선택 인쇄</th>
	        			<td>
	        				<a class="btn" type="button" style="vertical-align: bottom;" onclick="print_applyForm()">선택 인쇄</a>
	        				<span>선택한 지원서만 인쇄합니다.</span>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>메일/SMS 발송</th>
	        			<td>
	        				<a class="btn btn-danger" type="button" style="vertical-align: bottom;" id="sendBtn">메일/SMS</a>
	        				<span>선택한 지원자에게 메일/SMS를 발송합니다.</span>
	        			</td>
	        		</tr>
		        	<tr>
		        		<td class="buttonTd" colspan="2">
		        			<a id='searchBtn' class="btn btn-primary" type="button" style="vertical-align: bottom;">검색</a>
							<a class="btn" type="button" style="vertical-align: bottom;" onclick="update_result()"> 결과 저장</a>
							<a class="btn" type="button" style="vertical-align: bottom;" onclick="confirm_student()">연수인원 확정</a>
							<a class="btn" type="button" style="vertical-align: bottom;" onclick="cancel_student()">확정 취소</a>
							<a id='searchAllBtn' class="btn btn-danger" type="button" style="vertical-align: bottom;">전체초기화</a>
		        		</td>
	        		</tr>
       			</table>
       		</div>
       	
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<!-- n개씩 조회 -->
        	<input type="hidden" name="numOfRows" value='<c:out value="${search.numOfRows}" default="10" />' />
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
        	<!-- 페이징 처리 -->
        	<input type="hidden" name="pagingYn" value='Y' />
		</form>
		<!-- //searchForm end -->
		<div style="float: left;"><label id="totalCntLabel"></label></div>
		<div style="margin-bottom: 10px; text-align: right;">
			<select class="selector" name="numOfRows" id="numOfRows">
				<option value="10" selected>10명씩</option>
				<option value="50">50명씩</option>
				<option value="100">100명씩</option>
				<option value="500">500명씩</option>
				<option value="1000">1000명씩</option>
			</select>
		</div>
		<table class="table-hover applyTb" style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>No</th>
				<th>기수명</th>
				<th>지원일</th>
				<th>아이디</th>
				<th>성명</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>지원신청서</th>
				<th>서류전형</th>
				<th>처리일</th>
				<th>담당자</th>
				<th>면접전형</th>
				<th>처리일</th>
				<th>담당자</th>
				<th>상태</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging"></div>
		
		<form action="/admin/apply/print_applyForm" method="post" name="applyForm_popup" id="applyForm_popup"></form>
	</div>
</div>
