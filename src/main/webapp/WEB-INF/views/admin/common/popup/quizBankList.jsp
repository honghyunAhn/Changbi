<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>문제은행팝업</title>

<script type="text/javascript">

$(function() {
	// 여기에서 URL 변경 시켜서 사용
	var cardinalListUrl = "<c:url value='/data/course/cardinalList' />";
	var listUrl	= "<c:url value='/data/quiz/quizBankList' />";
	var regUrl	= "<c:url value='/data/quiz/quizItemListReg' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
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
						var level = dataInfo.quizLevel == "3" ? "上" : (dataInfo.quizLevel == "2" ? "中" : "下");
						var total = 0;
						var success = 0;
						var pScore = 0;
						var tScore = 0;
						var percent = 0;
						
						// 문제당 점수를 가지고 정답률 및 난이도를 구함.
						if(dataInfo.quizReplyList && dataInfo.quizReplyList.length > 0) {
							total = dataInfo.quizReplyList.length;
							
							for(var j=0; j<dataInfo.quizReplyList.length; ++j) {
								var quizReply = dataInfo.quizReplyList[j];
								
								// 문제당 점수를 모두 더하고..
								pScore += quizReply.pScore;
								
								// tScore가 0보다 크면 정답으로 판단.
								if(quizReply.tScore > 0) {
									++success;
									tScore += quizReply.tScore;
								}
							}
							
							percent = tScore/pScore*100;
						}
						
						// 해당 문제은행의 문제 출제 수가 3보다 크면 난이도를 구하고 3보다 적으면 문제 출제 시 만들어진 난이도로 보여준다. 
						if(total > 0) {
							// 정답률이 33프로보다 작거나 같으면 상, 33보다 크고 66보다 작거나 같으면 중, 그 이상은 하
							level = (percent <= 33 ? "上" : (percent <= 66 ? "中" : "下"));
						}

						sb.Append("<li>");
						sb.Append("	<label>");
						sb.Append("		<input type='checkbox' name='quizBankList["+i+"].id' value='"+dataInfo.id+"' />");
						sb.Append(		$(":hidden[name='quizPool.title']").val());
						sb.Append("	</label>");
						sb.Append("	<span>");
						sb.Append("		난이도 "+level+" ("+success+"/"+total+")</span><span> 정답율 "+percent+"%");
						sb.Append("	</span>");
						sb.Append("	<p>"+dataInfo.title+"</p>");
						
						if(dataInfo.osType == "O") {
							sb.Append("	<ol>");
							// 객관식
							sb.Append("		<li class='"+(dataInfo.oAnswer == "1" ? "answer" : "") +"'>"+dataInfo.exam1+"</li>");
							sb.Append("		<li class='"+(dataInfo.oAnswer == "2" ? "answer" : "") +"'>"+dataInfo.exam2+"</li>");
							sb.Append("		<li class='"+(dataInfo.oAnswer == "3" ? "answer" : "") +"'>"+dataInfo.exam3+"</li>");
							sb.Append("		<li class='"+(dataInfo.oAnswer == "4" ? "answer" : "") +"'>"+dataInfo.exam4+"</li>");
							
							if(dataInfo.examType == "2") {
								sb.Append("		<li class='"+(dataInfo.oAnswer == "5" ? "answer" : "") +"'>"+dataInfo.exam5+"</li>");
							}
							
							sb.Append("	</ol>");
						} else {
							// 주관식
							sb.Append("		<div class='answer'>"+dataInfo.sAnswer+"</div>");
						}
						
						sb.Append("</li>");
					}
				}
				
				$(".bank_list").html(sb.ToString());
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList();
	});
	
	// 기수선택 버튼 클릭 시
	$("select[name='learnType']").unbind("change").bind("change", function() {
		var sb = new StringBuilder();
		
		sb.Append("<option value=''>기수선택</option>");
		
		if($(this).val()) {
			var data = {"learnType" : $(this).val(), "pagingYn" : "N"};
			
			$.ajax({
				type	: "post",
				url		: cardinalListUrl,
				data	: data,
				success	: function(result) {
					if(result.list && result.list.length > 0) {
						var dataList = result.list;
	
						for(var i=0; i<dataList.length; ++i) {
							var dataInfo = dataList[i];
							var learnType = "";
							
							learnType = dataInfo.learnType == "J" ? "직무"+dataInfo.appPossibles+"학점" : "단체"; 
							
							sb.Append("<option value="+dataInfo.id+">"+learnType+"-"+dataInfo.name+"["+dataInfo.id+"]</option>");
						}
					} 
					
					// 콤보박스 아이템 바인딩
					$("select[name='cardinalId']").html(sb.ToString());
				},
				error	: function(e) {
					alert(e.responseText);
				}
			});
		} else {
			// 콤보박스 아이템 바인딩
			$("select[name='cardinalId']").html(sb.ToString());
		}
	});
	
	// 선택문제출제
	$("#popupRegBtn").unbind("click").bind("click", function() {
		if($(":checkbox[name^='quizBankList']:checked").size() > 0) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='popupActionForm']").serialize(),
				success	: function(result) {
					alert(result+" 개 저장되었습니다.");
					
					closeLayerPopup();

					// 부모함수 호출
					refreshList();
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		} else {
			alert("선택 된 문제은행이 없습니다.");
		}
	});
	
	setContentList();
});

</script>
</head>

<body>
<div id="wrapper">
	<div id="">
		<div class="popup">
			<!-- popupUserSearchForm start -->
        	<form name="popupSearchForm" method="post" class="form-inline" onsubmit="return false;">
        		<input type="hidden" name="id" value="0" />
        		<!-- course.id -->
        		<input type="hidden" name="course.id" value='<c:out value="${search.quizBank.course.id}" default="" />' />
        		<!-- quizType -->
        		<input type="hidden" id="quizType" name="quizType" value='<c:out value="${search.quizBank.quizType}" default="2" />' />
	       	
				<!-- 연수구분 선택 -->
				<select name="learnType">
					<option value="">연수구분</option>
					<option value="J">직무</option>
					<option value="G">단체</option>
				</select>
				
				<!-- 과정분류 선택 -->
				<select name="cardinalId">
					<option value="">기수선택</option>
				</select>
				
				<a class="btn primary" id="popupSearchBtn">조회</a>
			</form>
			
			<form name="popupActionForm" method="post">
				<!-- quizPool -->
	       		<input type="hidden" name="quizPool.id" value="<c:out value="${search.quizPool.id}" default="" />" />
	       		<input type="hidden" name="quizPool.title" value="<c:out value="${search.quizPool.title}" default="" />" />
	       		
				<div>
					<ul class="bank_list"></ul>
				</div>
			</form>
			
			<div>
				<a id="popupRegBtn" class="btn align_right primary" href="javascript:void();">선택문제출제</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>