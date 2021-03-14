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
	
 	$("#wrapper").on("click",'.popup_content_edit #popupSearchBtn', function(){
		var search = $("form[name='popupSearchForm']").serialize()
		$.ajax({
				url : "<c:url value='/data/toefl/toeflRefund' />"
				, type : "POST"
				, data		: $("form[name=sub-form]").serialize()
				, async		: false
				, success	: function(result) {
					if(result == false) {
						alert("환불 정보 수정에 실패하였습니다.");
					} else {
						alert("환불 정보를 수정하였습니다.");
					}
					contentLoad('개별신청관리','/admin/toefl/toeflPayList', search)
					closeLayerPopup();
				}
		});
	}) 
/* 	$(".popupSearchBtn").on("click", function(){
		var search = $("form[name='popupSearchForm']").serialize()
		$.ajax({
				url : "<c:url value='/data/toefl/toeflRefund' />"
				, type : "POST"
				, data		: $("form[name=sub-form]").serialize()
				, async		: false
				, success	: function(result) {
					if(result == false) {
						alert("환불 정보 수정에 실패하였습니다.");
					} else {
						alert("환불 정보를 수정하였습니다.");
					}
					contentLoad('개별신청관리','/admin/toefl/toeflPayList', search)
					closeLayerPopup();
				}
		});
	}) */
});

</script>
</head>

<body>
<div id="wrapper">
    <div>
        <div  class="col-lg-12">     	
        	<form name="popupSearchForm" method="post">
				<input type="hidden" name="searchStartDate" value="${search.searchStartDate}">
				<input type="hidden" name="searchEndDate" value="${search.searchEndDate}">
				<input type="hidden" name="pay_user_status" value="${search.pay_user_status}">
				<input type="hidden" name="pageNo" value="${search.pageNo}">
			</form>
        	<!-- popupUserSearchForm start -->
        		<form name='sub-form' id="sub-form" method="POST">
        			<input type="hidden" name="pay_toefl_seq" value='${refund.pay_toefl_seq}'>
        			<table class="table dataTable table-bordered table-hover">
						<tr>
        					<td>은행명</td>
        					<td><input type='text' disabled="disabled" value='${refund.bank}'></td>
        				</tr>
        				<tr>
        					<td>계좌번호</td>
        					<td><input type='text' disabled="disabled" value='${refund.accnum}'></td>
        				</tr>
        				<tr>
        					<td>예금주</td>
        					<td><input type='text' disabled="disabled" value='${refund.accname}'></td>
        				</tr>
        				<tr>
        					<td>출결상태</td>
        					<td>
        						<select name="pay_user_status" id="pay_user_status">
        							<option ${refund.pay_user_status eq "F0002"?'selected="selected"':""} value="F0002">환불신청</option>
        							<option ${refund.pay_user_status eq "F0003"?'selected="selected"':""} value="F0003">환불완료</option>
        						</select>
        					</td>
        				</tr>
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