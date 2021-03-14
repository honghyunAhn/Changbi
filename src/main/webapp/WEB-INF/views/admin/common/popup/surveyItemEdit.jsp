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

<title>연수설문 문항추가</title>

<script type="text/javascript">

/* var SURVEY999 = 'survey999'; */ // 절대코드 

$(function(){
	
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/board/surveyItemReg' />";
	var delUrl	= "<c:url value='/data/board/surveyItemDel' />";

	// 저장 버튼 클릭 시
	$("#popupRegBtn").unbind("click").bind("click", function() {
		
		if (!validation()) return false;
		
		if(confirm("저장하시겠습니까?")) {
			
			// 만족도 선택시 해당 컨트롤 폼 전달을 위하여 사용으로 변경.
			if ($(':radio[name="itemType"]').prop("disabled")) {
				$(':radio[name="itemType"]').prop("disabled", false);
			}
			/* if ($('select[name="surveyCode"]').prop("disabled")) {
				$('select[name="surveyCode"]').prop("disabled", false);
			} */
			
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						
						closeLayerPopup();
						
						// 부모함수 호출
						refreshList();
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
	
	// 삭제 버튼
	$("#popupDelBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						
						closeLayerPopup();
						
						// 부모함수 호출
						refreshList();
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 문항유형에 따른 동적 처리
	$(":radio[name='itemType']").on("click", function() {
		
		$("#exam").find(":checkbox").attr("checked", false);
		$("#exam").find(":text").val("");
		
		switch ($(this).val()) {
			case "1" :
				$("#exam").show();
				$("#exam > table > thead > tr > th").eq(2).hide();
				$("#exam > table > tbody > tr").find("td:eq(2)").hide();
				break;
			case "2" :
				$("#exam").hide();				
				break;
			case "3" :
				$("#exam").show();
				$("#exam > table > thead > tr > th").eq(2).show();
				$("#exam > table > tbody > tr").find("td:eq(2)").show();
				break;
			default :
				break;
		}
	});
	
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":hidden[name='id']").val() || $(":hidden[name='id']").val() == "0") {
		$("#popupDelBtn").hide();
	}
	
	// 편집모드가 아니거나 편집모드에서 객관식인 경우	
	if (!'${surveyItem}' || '${surveyItem.itemType}' == '1') {
		initForm();
	}
	
	/* // 이전 보기 입력하지 않으면 입력 못하도록 방지 (텍스트란)
	$("#exam").find(":text").on("keydown", function(index) {
		var index = $("#exam").find(":text").index($(this)); // 현재인덱스
		var prevIndex = index - 1; // 이전인덱스
		
		if (prevIndex > -1) {
			var prevInput = $("#exam").find(":text").eq(prevIndex);
			if (prevInput.val().trim() == "") {
				alert("이전 보기부터 입력 하셔야 합니다.");
				$(this).val("");
				prevInput.focus();
			}
		}
	});
	
	// 이전 보기 입력하지 않으면 입력 못하도록 방지 (체크란)
	$("#exam").find(":checkbox").on("change", function(index) {
		if ($(this).is(":checked")) {
			var index = $("#exam").find(":checkbox").index($(this)); // 현재인덱스
			var prevIndex = index - 1; // 이전인덱스
			
			if (prevIndex > -1) {
				var prevInput = $("#exam").find(":text").eq(prevIndex);
				if (prevInput.val().trim() == "") {
					alert("이전 보기부터 입력 하셔야 합니다.");
					$(this).prop("checked", false);
					prevInput.focus();
				}
			}
		}
	}); */
	
	// 문항유형이 만족도 (suvey999) 인 경우
	/* $('select[name="surveyCode"]').on('change', function() {
		var target = $(this);
		
		if (target.val() == SURVEY999) {
			$.ajax({
			       type : "POST",
			       url : "/data/board/surveyItemVerification",       
			       data : $("form[name='popupActionForm'").serialize(),
			       success  : function(result) {
			    	   if (result > 0) {
			    		   target.val("");
			    		   alert("설문지에 연수만족도가 이미 등록되어있습니다.");
			    		   return;
			    	   } else {
			    		   setForm(true);			    		   
			    	   }
			       },
			       error  : function(e) {
			           alert(e.responseText);
			       }
			});
		} else {
			setForm(false);
		}
	}) */
	
	// 문항번호 999 입력 막기
	/* $('input[name="orderNum"]').on('blur', function() {
		
		if('${surveyItem}' && '${surveyItem.surveyCode}' == SURVEY999) return;
		
		if($('select[name="surveyCode"]').val() == SURVEY999) return; 
		
		if ($(this).val() == '999') {
			$(this).val('0');
		}
	})
	
	// 문항 편집시 만족도 인경우 폼 설정
	if('${surveyItem}' && '${surveyItem.surveyCode}' == SURVEY999) {
		$('select[name="surveyCode"]').prop("disabled", true); // 문항분류 변경 못하도록 변경
		$(':radio[name="itemType"]').prop("disabled", true); // 문항유형 변경 못하도록 변경
		$('input[name="orderNum"]').prop("readonly", true); // 문항번호를 읽기전용
		$('#exam').find('input:text').prop("readonly", true); // 보기문항 읽기전용으로 변경 
	} */
});

// 문항 등록시 만족도 선택시 폼 설정
function setForm(b) {
	if (b) { // 만족도 선택시 
		$('#itemType1').trigger("click"); // 문항유형을 객관식으로 변경
		$(':radio[name="itemType"]').prop("disabled", true); // 문항유형 변경 못하도록 변경
		$('input[name="orderNum"]').prop("readonly", true); // 문항번호를 읽기전용
		$('#exam').find('input:text').prop("readonly", true); // 보기문항 읽기전용으로 변경
		
		$('input[name="orderNum"]').val('999'); // 문항번호 999 로 변경
		$('input[name="title"]').val('연수 만족도 입니다.'); // 문항제목 기본 설정
		$('input[name="exam1"]').val('매우만족'); // 문항보기1번 고정
		$('input[name="exam2"]').val('만족'); // 문항보기2번 고정
		$('input[name="exam3"]').val('보통'); // 문항보기3번 고정
		$('input[name="exam4"]').val('불만족'); // 문항보기4번 고정
		$('input[name="exam5"]').val('매우불만족'); // 문항보기5번 고정
	} else { // 만족도 제외 선택시
		$(':radio[name="itemType"]').prop("disabled", false); // 문항유형 변경 하도록 변경
		$('input[name="orderNum"]').prop("readonly", false); // 문항번호를 읽기전용 해제
		$('#exam').find('input:text').prop("readonly", false); // 보기문항 읽기전용 해제
		
		$('#exam').find('input:text').val(''); // 보기문항 초기화
		$('input[name="orderNum"]').val('0'); // 문항번호 0 으로 변경
		$('input[name="title"]').val(''); // 문항제목 빈값으로 변경
	}
	
}

function initForm() {
	$("#exam > table > thead > tr > th").eq(2).hide();
	$("#exam > table > tbody > tr").find("td:eq(2)").hide();
}

//데이터 유효성 체크
function validation() {
	/* var surveyCode = $("select[name='surveyCode']");
	
	if (surveyCode.length > 0 && surveyCode.val() == '') {
		alert("문항분류를 선택하셔야 합니다.");
		return false;
	} */
	
	var title = $("input[name='title']");
	
	if (title.length > 0 && title.val() == '') {
		alert("질문을 입력하셔야 합니다.");
		title.focus();
		return false;
	}
	
	return true;
}

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form name="popupActionForm" method="post">
			<input type="hidden" name="id" value="<c:out value="${surveyItem.id}" default="${search.id}" />" />
			<input type="hidden" name="surveyId" value="<c:out value="${surveyItem.surveyId}" default="${search.surveyId}" />" />
	       	
			<!-- view start -->
			<dl>
				<dt>문항유형</dt>
				<dd>
					<input type="radio" id="itemType1" name='itemType' value="1" checked="checked"><label for="itemType1">객관식</label>
					<input type="radio" id="itemType2" name='itemType' value="2" <c:if test="${surveyItem.itemType eq '2'}">checked="checked"</c:if>><label for="itemType2">주관식</label>
					<input type="radio" id="itemType3" name='itemType' value="3" <c:if test="${surveyItem.itemType eq '3'}">checked="checked"</c:if>><label for="itemType3">객관+주관식</label>
				</dd>
				<%-- <dt>문항분류</dt>
				<dd>
					<select name="surveyCode">
						<option value="">선택</option>
						<c:forEach items="${surveyCodeList}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq surveyItem.surveyCode}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
				</dd> --%>
				<dt>문항번호</dt>
				<dd class="half">
					<input type="number" name="orderNum" max="999" value="<c:out value='${surveyItem.orderNum}' default='0' />" />
				</dd>
				<dt>설문코드</dt>
				<dd class="half">
					<c:out value='${search.surveyId}' />
				</dd>
				<dt>질문</dt>
				<dd>
					<input type="text" name="title" value="<c:out value='${surveyItem.title}' />" />
				</dd>
			</dl>
			<div id="exam">
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>보기내용</th>
							<th>주관식여부</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td><input type="text" name="exam1" class="form-control" value="<c:out value='${surveyItem.exam1}'/>"/></td>
							<td><input type="checkbox" name="exam1Yn" value="Y" <c:if test="${surveyItem.exam1Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>2</td>
							<td><input type="text" name="exam2" class="form-control" value="<c:out value='${surveyItem.exam2}'/>"/></td>
							<td><input type="checkbox" name="exam2Yn" value="Y" <c:if test="${surveyItem.exam2Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>3</td>
							<td><input type="text" name="exam3" class="form-control" value="<c:out value='${surveyItem.exam3}'/>"/></td>
							<td><input type="checkbox" name="exam3Yn" value="Y" <c:if test="${surveyItem.exam3Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>4</td>
							<td><input type="text" name="exam4" class="form-control" value="<c:out value='${surveyItem.exam4}'/>"/></td>
							<td><input type="checkbox" name="exam4Yn" value="Y" <c:if test="${surveyItem.exam4Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>5</td>
							<td><input type="text" name="exam5" class="form-control" value="<c:out value='${surveyItem.exam5}'/>"/></td>
							<td><input type="checkbox" name="exam5Yn" value="Y" <c:if test="${surveyItem.exam5Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>6</td>
							<td><input type="text" name="exam6" class="form-control" value="<c:out value='${surveyItem.exam6}'/>"/></td>
							<td><input type="checkbox" name="exam6Yn" value="Y" <c:if test="${surveyItem.exam6Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
						<tr>
							<td>7</td>
							<td><input type="text" name="exam7" class="form-control" value="<c:out value='${surveyItem.exam7}'/>"/></td>
							<td><input type="checkbox" name="exam7Yn" value="Y" <c:if test="${surveyItem.exam7Yn eq 'Y'}">checked="checked"</c:if> /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<div>
			<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			<c:if test="${loginUser != null and loginUser.grade != 1}">
			<a id="popupDelBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>