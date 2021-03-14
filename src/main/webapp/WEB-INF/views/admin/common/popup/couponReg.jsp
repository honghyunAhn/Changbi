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

<title>포인트등록</title>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/common/view/couponList' />";
	var regUrl	= "<c:url value='/data/pay/couponReg' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 함수 영역 **/
	
	/** 이벤트 영역 **/
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".select_popup_id").index($(this));
		
		closeLayerPopup();
	});
	
	// 저장 버튼 클릭 시
	$("#popupRegBtn").unbind("click").bind("click", function() {
		if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						closeLayerPopup();
						innerCallback();
					} else {
						alert("저장실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	$("input[name='issue']").on("change", function() {
		if ($(this).val() == "1") {
			$(":text[name='userIds']").attr("readonly", false).attr("placeholder", "");
		} else {
			$(":text[name='userIds']").attr("readonly", true).val("").attr("placeholder", "발급매수가 1장일 때만 입력 할 수 있습니다.");
		}
	});
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<!-- view start -->
			<dl>
				<dt>쿠폰조건</dt>
				<dd>
					<input type='number' name='cond' />
					<span>원 이상 신청시</span>
					<input type='number' name='coupon' />
					<select name="couponType">
						<option value="1">원 할인</option>
						<option value="2">% 할인</option>
					</select>
				</dd>
				
				<dt>만료일자</dt>
				<dd>
					<div class='input-group date datetimepicker' id='expDate'>
	                <input type='text' name='expDate' class='form-control' />
	                <span class='input-group-addon'>
	                    <span class='glyphicon glyphicon-calendar'></span>
	                </span>
	            	</div>
            	</dd>
				
				<dt>발급매수</dt>
				<dd>
					<input type='number' name='issue' />
				</dd>
				
				<dt>대상자 ID(,) 로 구분</dt>
				<dd>
					<input type='text' style='width:100%;' name='userIds' />
				</dd>
				
				<dt>적용과정(설명보기)</dt>
				<dd>
					<input type='text' style='width:100%;' name='courseId' />
				</dd>
				
				<dt>비고</dt>
				<dd>
					<span>※ 쿠폰발행은 1회 1천장이내로 발행권장</span>
				</dd>
			</dl>
		</form>
		<div>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>