<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />


<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/basic/policyPointReg' />";
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		
		if (!validation()) return false;
		
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

//데이터 유효성 체크
function validation() {
	
	// [체크1] - 수강신청 적립시 포인트 타입을 % 로 선택 한 경우 100 을 맥시멈으로 체크 한다.
	var saveLectureType = $("select[name='saveLectureType']");
	 
	if (saveLectureType.length > 0 && saveLectureType.val() == 2) {
		
		if ($("input[name='saveLecturePoint']").val() > 100) {
			alert('수강신청시 적립포인트가 100% 보다 큽니다.');
			$("input[name='saveLecturePoint']").focus();
			return false;
		};
	}
	
 
	if($("input[name='saveJoinPoint']").val()<0){
		alert("신규회원가입 적립포인트를 양수로 입력해 주세요.");
		$("input[name='saveJoinPoint']").focus();
		return false;
	}
	if($("input[name='saveLecturePoint']").val()<0){
		alert("수강신청시 적립포인트를 양수로 입력해 주세요.");
		$("input[name='saveLecturePoint']").focus();
		return false;
	}	
	if($("input[name='saveTrainPoint']").val()<0){
		alert("연수후기작성시 적립포인트를 양수로 입력해 주세요.");
		$("input[name='saveTrainPoint']").focus();
		return false;
	}
	if($("input[name='useLecturePoint']").val()<0){
		alert("수강신청시 사용포인트를 양수로 입력해 주세요.");
		$("input[name='useLecturePoint']").focus();
		return false;
	}
	if($("input[name='useLectureUnit']").val()<0){
		alert("수강신청시 사용포인트를 양수로 입력해 주세요.");
		$("input[name='useLectureUnit']").focus();
		return false;
	}
	
	
	return true;
}

</script>
		
<div class="content_wraper">
	<h3>회원관리</h3>
	<div class="tab_body">
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${policyPoint.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- view start -->
			<table style="border-collapse: collapse;">
				<thead>
					<tr>
						<th>구분</th>
						<th>포인트 정책</th>
						<th>사용유무</th>
					</tr>
				</thead>
				<tbody id="dataBody">
					<tr>
						<td>신규회원가입 (적립)</td>
						<td><input type='number' name='saveJoinPoint' value='<c:out value="${policyPoint.saveJoinPoint}" />' /> <span>[점]</span></td>
						<td><input type='checkbox' name='saveJoinUse' value='Y' <c:if test="${policyPoint.saveJoinUse eq 'Y'}">checked</c:if> /></td>
					</tr>
					<tr>
						<td>수강신청시 (적립)</td>
						<td>
							<input type='number' name='saveLecturePoint' value='<c:out value="${policyPoint.saveLecturePoint}" />' />
							<select name="saveLectureType">
								<option value="1" <c:if test="${policyPoint.saveLectureType eq '1'}">selected</c:if>>점</option>
								<option value="2" <c:if test="${policyPoint.saveLectureType eq '2'}">selected</c:if>>%</option>
							</select>
						</td>
						<td><input type='checkbox' name='saveLectureUse' value='Y' <c:if test="${policyPoint.saveLectureUse eq 'Y'}">checked</c:if> /></td>
					</tr>
					<tr>
						<td>연수후기작성시 (적립)</td>
						<td><input type='number' name='saveTrainPoint' value='<c:out value="${policyPoint.saveTrainPoint}" />' /> <span>[점]</span></td>
						<td><input type='checkbox' name='saveTrainUse' value='Y' <c:if test="${policyPoint.saveTrainUse eq 'Y'}">checked</c:if> /></td>
					</tr>
					<tr>
						<td>수강신청시 (사용)</td>
						<td>
							<input type='number' name='useLecturePoint' value='<c:out value="${policyPoint.useLecturePoint}" />' /> <span> 포인트로부터 </span> 
							<input type='number' name='useLectureUnit' value='<c:out value="${policyPoint.useLectureUnit}" />' /> <span> 단위로 사용 </span>
						</td>
						<td><input type='checkbox' name='useLectureUse' value='Y' <c:if test="${policyPoint.useLectureUse eq 'Y'}">checked</c:if> /></td>
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