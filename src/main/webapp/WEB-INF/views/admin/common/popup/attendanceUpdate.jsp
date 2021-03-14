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
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 달력 등 초기화
	setPageInit(editor_object, file_object);
	
	var now = new Date();
	
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	
	var today = year + "-" + month + "-" + date;
	
	$('.currentDate').val(today);
	
	// 여기에서 URL 변경 시켜서 사용
	/* var listUrl	= "<c:url value='/data/member/memberList' />"; */
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	/* var pagingNavigation = new PagingNavigation($(".popup_pagination")); */
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	/* function setContentList(pageNo) {
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
	} */
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	/* $("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	}); */
	
	// 클릭 시 상세 페이지 이동
	/* $("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".select_popup_id").index($(this));
		
		closeLayerPopup();
	});
	
	setContentList(); */
	$('.file_info_area').on("click", '.reg_file_del_btn', function(){
		var saved = $(this).parent().children('.reg_file_name').val();	
		var origin = $(this).parent().next().children('.reg_origin_file_name').val();
		var userId = "${userId}";
		var cardinal = "${cardinal}";

		var path="user/attendance/cert/"+userId+"_"+cardinal;
		
		var attInfoTimeSeq = $(':hidden[name$="attInfoTimeSeq"]').val();
		
 		$.ajax({
			url : "<c:url value='/forFaith/file/deleteCertiFile' />"
				, type : "POST"
				, data		: {
					saved : saved,
					path : path
				}
				, async		: false
				, success	: function(result) {
				 	 $.ajax({
						url : "<c:url value='/data/attendance/deleteRegFile' />"
							, type : "POST"
							, data		: {
								attInfoTimeSeq : attInfoTimeSeq
							}
							, async		: false
							, success	: function(result) {
								if(result != 0) {
									alert("삭제했습니다.");
								} else {
									alert("삭제에 실패했습니다.");
								}
							}
					}); 
				
					createTable();
					closeLayerPopup();
 				}
		}) 
	})
	
	$('.file_info_area').on("click", '.downloadBtn_admin', function(){
		var origin = $(this).parent().next().children('.attach_origin_file_name').val();
		var saved = $(this).parent().next().children('.attach_file_name').val();
		
		location.href = "/forFaith/file/file_download?origin="+origin+"&saved="+saved+"&path=uploadImage";
	})
	
	$('.file_info_area').on("click", '.downloadBtn_user', function(){
		var saved = $(this).parent().next().children('.reg_file_name').val();
		var origin = $(this).parent().next().children('.reg_origin_file_name').val();
		var userId = "${userId}";
		var cardinal = "${cardinal}";
		
		var path="${link}/"+userId+"_"+cardinal;
		
		location.href = "/forFaith/file/file_download?origin="+origin+"&saved="+saved+"&path="+path;
	})
	
	$("#wrapper").on("click",'.popup_content_edit', function(){
		var change = false;
		
		if($('.file_info_area').length == 0) {
			$('.attach_file_id').val('')
		}
		
		if(!checkForm()) {
			return;
		}
		
		$.ajax({
				url : "<c:url value='/data/attendance/sutUpdate' />"
				, type : "POST"
				, data		: $("form[name=sub-form]").serialize()
				, async		: false
				, success	: function(result) {
					//console.log(result);
					if(result == "Success") {
						change = true;
					}
				}
		}); 
		
		var attinfoseq = $('input[name$="attInfoSeq"]');
		var attinfogubun = $('select[name$="attInfoGubun"]');
		var current = $('.currentDate').val();
		
		var arr = new Array();
		
		for(var i = 0; i < attinfoseq.length; i++) {
			var obj = new Object();
			obj.attInfoSeq = attinfoseq[i].value;
			obj.attInfoGubun = attinfogubun[i].value;
			obj.UPD_DATE = current;
			
			arr.push(obj);
		}
		
		var formArr = JSON.stringify(arr);
		
		$.ajax({
				url : "<c:url value='/data/attendance/sutSisuUpdate' />"
				, type : "POST"
				, data		: formArr
				, contentType: 'application/json; charset=UTF-8'
				, async		:	false,
				success		: function(result) {
					if(result == "Success") {
						change = true;
					} else {
						change = false;
					}
				}
		});  
		
	 if(change) {
	 		alert("수정되었습니다.");
		} else {
			alert("실패하였습니다.");
		}
		
		createTable();
		closeLayerPopup();
	});
});

function checkForm() {
	var time_pattern = /^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$/;
	
	var inTime = $('#inTime').val();
	var outTime = $('#outTime').val();
	var tGubun = $('#attFinalGubun').val();

	if(tGubun != "B4702") {
		if(!time_pattern.test(inTime) || !time_pattern.test(outTime)) {
			alert("시간을 잘못 입력하셨습니다.");
			return false;
		} else if(!inTime || !outTime) {
			alert("시간을 입력하세요.");
			return false;
		}	
	}
	
	switch(tGubun) {
	case "B4701":
	case "B4702":
	case "B4703":
		break;
	case "":
		alert("최종 출결 상태를 입력하세요.");
		return false;
	}
	
	var gubun = $('select[name$="attInfoGubun"]');
	$.each(gubun, function(index, item){
		
		switch(item.value) {
		case "B4701":
		case "B4702":
		case "B4704":
			break;
		case "":
			alert("상세 출결 상태를 입력하세요.");
			return false;
		}
	});
	
	return true;
}
</script>
</head>

<body>
<div id="wrapper" style="height: 740px; overflow: auto;">
    <div>
        <div  class="col-lg-12 " style='margin-top: 10px;'>     	
        	<!-- popupUserSearchForm start -->
        		<form name='sub-form' id="sub-form" method="POST">
        			<input type="hidden" name="attInfoTimeSeq" value="${info.attInfoTimeSeq}"/>
        			<table class="table dataTable table-bordered table-hover">
						<tr>
        					<td>이름</td>
        					<td>${userName}</td>
        				</tr>
        				<tr>
        					<td>입실시간</td>
        					<td><input type='text' id='inTime' name='inTime' value="${info.inTime}"></td>
        				</tr>
<!--         				<tr>
        					<td>인증수단</td>
        					<td>컬럼 없음</td>
        				</tr> -->
        				<tr>
        					<td>퇴실시간</td>
        					<td><input type='text' id='outTime' name='outTime' value='${info.outTime}'></td>
        				</tr>
<!--         				<tr>
        					<td>인증수단</td>
        					<td>컬럼없음</td>
        				</tr> -->
        				<tr>
        					<td>출결상태</td>
        					<td>
        						<select name="attFinalGubun" id="attFinalGubun">
        							<option ${info.attFinalGubun eq "B4701"?'selected="selected"':""} value="B4701">출석</option>
        							<option ${info.attFinalGubun eq "B4702"?'selected="selected"':""} value="B4702">결석</option>
        							<option ${info.attFinalGubun eq "B4703"?'selected="selected"':""} value="B4703">지각/조퇴</option>
        						</select>
        					</td>
        				</tr>
        				<tr>
        					<td>첨부파일</td>
        					<td>
        						<%-- <input type="file" class="file_upload_btn" name="certiAttachFile" value="${info.regSavedFile}"> --%>
        						<div class='attach_file_area' style="clear: both;">
									<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
									<input type='hidden' class='attach_file_id'	name='certiAttachFile.fileId' value="${info.certiAttachFile.fileId}"/> <!-- 디비에 파일 저장된 이름 -->
									<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/> 
						
									<div class='file_upload_btn_area' style="clear: both;">
										<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
										<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
									</div>
									<c:if test="${info.certiAttachFile ne null and info.certiAttachFile.detailList ne null and fn:length(info.certiAttachFile.detailList) > 0}">
										<c:forEach items="${info.certiAttachFile.detailList}" var="file" varStatus="status">
										<div class='file_info_area' id="area1" style='float: left;'>
											<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
												<input type="button" class="downloadBtn_admin" id="btn1" style="width: 200px; height: 30px;" value="${file.originFileName}"/> <!-- 파일 오리지널 네임 -->
											</div>
											<div class="file_info" style="padding-left: 5px;">
												<input type="hidden" class="attach_file_name" value="${file.fileName}"/>
												<input type="hidden" class="attach_file_path" value="${file.filePath}"/>
												<input type="hidden" class="attach_file_size" value="${file.fileSize}"/>
												<input type="hidden" class="attach_origin_file_name" value="${file.originFileName}"/>
												<input type="hidden" class="attach_url_path" value="${file.urlPath}"/>
												<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
											</div>
										</div>
										</c:forEach>
									</c:if>
									<c:if test="${info.regOriginFile ne null and info.regSavedFile ne null}">
										<div class='file_info_area' id="area2" style='float: left;'>
											<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
												<input type="button" class="downloadBtn_user" id="btn2" style="width: 200px; height: 30px;" value="${info.regOriginFile}"/> <!-- 파일 오리지널 네임 -->
											</div>
											<div class="file_info" style="padding-left: 5px;">
												<input type="hidden" class="reg_file_name" value="${info.regSavedFile}"/>
												<input type="hidden" class="reg_origin_file_name" value="${info.regOriginFile}"/>
												<input type="button" class="reg_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
											</div>
										</div>
									</c:if>
								</div>
        					</td>
        				</tr>
        				<tr>
        					<td>관리자 메모</td>
        					<td><input type='text' id='memo' name='memo' value='${info.memo}'></td>
        				</tr>
        				<tr>
        					<td>사용자 메모</td>
        					<td><input type='text' disabled="disabled" id='userMemo' value='${info.userMemo}'></td>
        				</tr>
        				<!-- <tr>
        					<td colspan='2' class="popup_content_edit"><button class='sub-btn'>수정</button></td>
        				</tr> -->
        			</table>
        		</form>
        </div>
	</div>
	<hr>
	<div>
		<div class="col-lg-12" style='margin-top: 10px;'>
			<form name="InfoForm">
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>시수</th>
						<th>날짜</th>
						<th>시작시간</th>
						<th>종료시간</th>
						<th>출결상태</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody">
					<c:forEach  var="user" items="${usersisu}" varStatus="status">
						<tr>
							<td>${user.SISU}</td>
							<td>${user.att_date}</td>
							<td>${user.STAND_IN_TIME}</td>
							<td>${user.STAND_OUT_TIME}</td>
							<td>
								<input type='hidden' class='currentDate' name='updDate'>
								<input type='hidden' name='attInfoSeq' value='${user.ATT_INFO_SEQ}'>
								<select name="attInfoGubun">
        							<option ${user.att_info_gubun eq "B4701"?'selected="selected"':""} value="B4701">출석</option>
        							<option ${user.att_info_gubun eq "B4702"?'selected="selected"':""} value="B4702">결석</option>
        							<option ${user.att_info_gubun eq "B4704"?'selected="selected"':""} value="B4704">공결</option>
        						</select>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<!-- /#page-wrapper -->
	<div class="popup_content_edit"><button class="btn submitBtn" id="popupSearchBtn"><i class="fa fa-search">수정</i></button></div>
</div>
<!-- /#wrapper -->
</body>
</html>