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
	/** 함수 영역 **/
	
	/** 이벤트 영역 **/
	// 저장 버튼 클릭 시
	$("#popupRegBtn").unbind("click").bind("click", function() {
		if(!$("#tccTitle").val()) {
			alert("영상제목을 입력하세요.");
			$("#tccTitle").focus();
		} else if(!$("#tccUrl").val()) {
			alert("영상파일URL을 입력하세요.");
			$("#tccUrl").focus();
		} else if(confirm("추가하시겠습니까?")) {
			// 부모의 함수 호출해준다.
			var tcc =	{ "title"	: $("#tccTitle").val()
						, "url"		: $("#tccUrl").val()
						, "useYn"	: $(":radio[name='tccUseYn']:checked").val() };
			
			setTcc(tcc);
			
			closeLayerPopup();
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
				<dt>영상제목</dt>
				<dd>
					<input type='text' class='w100' id='tccTitle' value='' />
				</dd>
				<dt>영상파일URL</dt>
				<dd>
					<input type='text' class='w100' id='tccUrl' value='' />					
				</dd>
				<dt>게시유무</dt>
				<dd>
					<input type="radio" id="tccUseY" name='tccUseYn' value="Y" checked="checked"><label for="tccUseY">게시함</label>
					<input type="radio" id="tccUseN" name='tccUseYn' value="N"><label for="tccUseN">게시안함</label>
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