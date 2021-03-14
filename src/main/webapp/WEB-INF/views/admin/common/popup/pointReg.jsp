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
	var listUrl	= "<c:url value='/data/common/view/pointList' />";
	var regUrl	= "<c:url value='/data/pay/pointReg' />";
	
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
			
			switch ($("select[name='regPointType']").val()) {
				case "give" :
					$(":hidden[name='give']").val($(":text[name='regPoint']").val());
					break;
				case "withdraw" :
					$(":hidden[name='withdraw']").val($(":text[name='regPoint']").val());
					break;
			}
			
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
});

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<input type="hidden" name="give" value="0" />
			<input type="hidden" name="withdraw" value="0" />
			
			<!-- view start -->
			<dl>
				<dt>포인트</dt>
				<dd>
					<input type='text' name='regPoint' />
					<span>포인트</span>
					<select name='regPointType'>
						<option value='give'>지급</option>
						<option value='withdraw'>회수</option>
					</select>
				</dd>
				<dt>대상자</dt>
				<dd>
					<span>ID : </span>
					<input type='text' name='userId' value="<c:out value="${search.userId }"/>" />
					<span>성명 : </span>
					<input type='text' name='name'  value="<c:out value="${search.name }"/>"/>					
				</dd>
				<dt>적용사유</dt>
				<dd>
					<input type='text' style='width:100%;' name='note' />
				</dd>
				<dt>수강접수No</dt>
				<dd>
					<input type='number' name='learnAppId' value="0" />
					<span>※ 수강과 상관없는 경우 미기재</span>
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