<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
var refreshList = null;

var SURVEY999 = 'survey999'; // 절대코드

$(document).ready(function() {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/board/surveyItemList' />";
	var surveyUrl = "<c:url value='/admin/board/surveyList' />";
	var surveyItemEditUrl = "<c:url value='/admin/common/popup/surveyItemEdit' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='actionForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						
						sb.Append("<li>");
							sb.Append("<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
							/* sb.Append("<input type='hidden' name='surveyCode' value='"+dataInfo.survey.code+"' />"); */							
							sb.Append("<p class='survey_item_edit' style='cursor:pointer;' title='눌러서 문항 수정'>"+parseInt(i+1)+". "+dataInfo.title+"("+dataInfo.itemTypeName+")"+"</p>");
							sb.Append("<ol>");
								if(dataInfo.itemType == "2") {
									sb.Append("<li><input type='text' placeholder='주관식란' readonly /></li>");
								} else {
									if (dataInfo.exam1Yn == 'Y') {
										sb.Append("<li>①"+(dataInfo.exam1.trim() == '' ? '' : dataInfo.exam1)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam1.trim() == '' ? '' : '①'+dataInfo.exam1)+"</li>");
									}
									if (dataInfo.exam2Yn == 'Y') {
										sb.Append("<li>②"+(dataInfo.exam2.trim() == '' ? '' : dataInfo.exam2)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam2.trim() == '' ? '' : '②'+dataInfo.exam2)+"</li>");
									}
									if (dataInfo.exam3Yn == 'Y') {
										sb.Append("<li>③"+(dataInfo.exam3.trim() == '' ? '' : dataInfo.exam3)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam3.trim() == '' ? '' : '③'+dataInfo.exam3)+"</li>");
									}
									if (dataInfo.exam4Yn == 'Y') {
										sb.Append("<li>④"+(dataInfo.exam4.trim() == '' ? '' : dataInfo.exam4)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam4.trim() == '' ? '' : '④'+dataInfo.exam4)+"</li>");
									}
									if (dataInfo.exam5Yn == 'Y') {
										sb.Append("<li>⑤"+(dataInfo.exam5.trim() == '' ? '' : dataInfo.exam5)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam5.trim() == '' ? '' : '⑤'+dataInfo.exam5)+"</li>");
									}
									if (dataInfo.exam6Yn == 'Y') {
										sb.Append("<li>⑥"+(dataInfo.exam6.trim() == '' ? '' : dataInfo.exam6)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam6.trim() == '' ? '' : '⑥'+dataInfo.exam6)+"</li>");
									}
									if (dataInfo.exam7Yn == 'Y') {
										sb.Append("<li>⑦"+(dataInfo.exam7.trim() == '' ? '' : dataInfo.exam7)+" <input type='text' placeholder='주관식란' readonly /></li>");
									} else {
										sb.Append("<li>"+(dataInfo.exam7.trim() == '' ? '' : '⑦'+dataInfo.exam7)+"</li>");
									}
								}
							sb.Append("</ol>");
						sb.Append("</li>");
					}
				}
				
				$(".survey_item_list").html(sb.ToString());
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 페이지 이벤트 등록(추가 버튼 클릭 시)
	$("#addBtn").unbind("click").bind("click", function() {
		openLayerPopup(contentTitle, surveyItemEditUrl, $("form[name='parentForm']").serialize());
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수설문관리", surveyUrl, $("form[name='searchForm']").serialize());
	});

	// 문항수정
	$(".survey_item_list").on("click", ".survey_item_edit", function() {
		
		var idx = $(".survey_item_edit").index($(this));
		
		/* if ($(":hidden[name='surveyCode']").eq(idx).val() == SURVEY999) {
			return;
		} */
		
		var param = {};
		param.id = $(":hidden[name='checkId']").eq(idx).val();
		param.surveyId = $(":hidden[name='surveyId']").val();
		
		openLayerPopup('문항수정', surveyItemEditUrl, param);
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 외부 함수에 내부 함수 연결
	refreshList = setContentList;
	
	// 처음 리스트 생성
	setContentList();
});
 
</script>

<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
	   	<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
	
       	<form name="parentForm" method="post">
       		<!-- hidden 부모 데이터 -->
			<%-- <input type='hidden' name='seq' value='<c:out value='${survey.seq}' default="0" />' /> --%>
			<%-- <input type='hidden' name='id' value='<c:out value='${survey.id}' default="" />' /> --%>
			<input type='hidden' name='surveyId' value='<c:out value='${survey.id}' default="" />' />
			
			<h4>연수설문정보</h4>
			<dl>
				<dt>등록일시</dt>
				<dd>
					<c:out value="${survey.regDate}" />
				</dd>
				
				<dt>설문제목</dt>
				<dd>
					<c:out value="${survey.title}" />
				</dd>
				<dt>게시상태</dt>
				<dd>
					<c:choose>
						<c:when test="${survey.useYn eq 'Y'}">서비스</c:when>
						<c:otherwise>보류</c:otherwise>
					</c:choose>
				</dd>
				<dt>안내머리글</dt>
				<dd class="half">
					<c:out value="${survey.aLead}" />
				</dd>
				<dt>포함기수코드</dt>
				<dd class="half">
					<c:out value="${survey.concatCardinalId}" />
				</dd>
			</dl>
		</form>
		<div>
			<a id="listBtn" class="btn align_left" href="javascript:void();">리스트</a>
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규문항등록</a>
		</div>
		
		<!-- actionForm start -->
		<form name="actionForm" method="post">
			<!-- 연수설문 마스터 ID -->
			<input type='hidden' name='surveyId' value='<c:out value='${survey.id}' default="" />' />
			
			<div class="survey">
				<h4>연수 만족도 설문조사</h4>				
				<ul class="survey_item_list"></ul>
			</div>
		</form>
		<!-- //actionForm end -->
	</div>
</div>
