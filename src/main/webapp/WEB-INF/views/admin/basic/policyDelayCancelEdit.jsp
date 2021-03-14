<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />


<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/basic/policyDelayCancelReg' />";
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
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
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>
		
<div class="content_wraper">
	<h3>회원관리</h3>
	<div class="tab_body">
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${policyDelayCancel.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- view start -->
			<table style="border-collapse: collapse;">
				<tbody id="dataBody">
					<tr>
						<td>연기정책</td>
						<td>과정신청일로부터</td>
						<td><input type='number' name='delayCourseDay' value='<c:out value="${policyDelayCancel.delayCourseDay}" />' /> <span>[일이내]</span></td>
						<td>연수시작일로부터</td>
						<td><input type='number' name='delayTrainDay' value='<c:out value="${policyDelayCancel.delayTrainDay}" />' /> <span>[일이내]</span></td>						
					</tr>
					<tr>
						<td>취소정책</td>
						<td>과정신청일로부터</td>
						<td><input type='number' name='cancelCourseDay' value='<c:out value="${policyDelayCancel.cancelCourseDay}" />' /> <span>[일이내]</span></td>
						<td>연수시작일로부터</td>
						<td><input type='number' name='cancelTrainDay' value='<c:out value="${policyDelayCancel.cancelTrainDay}" />' /> <span>[일이내]</span></td>						
					</tr>
				</tbody>
			</table>				
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>
<!-- // Navigation -->