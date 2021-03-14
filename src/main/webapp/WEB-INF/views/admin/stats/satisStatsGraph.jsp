<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style type="text/css">
	div.bb-tooltip-container > table > tbody > tr > th {background-color:#aaa;}
	
	.chart>div{float:left; width:50%; margin-top:50px;}
</style>

<script type="text/javascript">
var refreshList = null;

$(document).ready(function() {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// url을 여기서 변경
	var aDataUrl = "/data/stats/satisByCourseTop5"; // 기수의 과정 만족도 상위 TOP5
	var bDataUrl = "/data/stats/satisByCardinal"; // 기수 만족도 분포
	var cDataUrl = "/data/stats/satisByAgeGroup"; // 기수의 설문자 연령분포
	var dDataUrl = "/data/stats/satisByClassType"; // 유, 초, 중, 고 별 만족도
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = {"learnType" : $("select[name='cardinal.learnType']").val()};
		
		openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 과정선택 버튼 클릭 시
	$(":text[name='course.name']").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinal.id']").val()) {
			alert("기수를 먼저 선택해야 합니다.");
		} else {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data.cardinalId = $(":hidden[name='cardinal.id']").val();
			data.learnTypes = $("select[name='cardinal.learnType']").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
		}
	});
	
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinal.id']").val()) {
			alert("기수를 선택해주세요.");
		} else {
			ajaxChartData(aDataUrl, 'aChart'); // 기수의 과정 만족도 상위 Top
			ajaxChartData(bDataUrl, 'bChart'); // 기수 만족도분포
			ajaxChartData(cDataUrl, 'cChart'); // 설문자 연령분포
			ajaxChartData(dDataUrl, 'dChart'); // 학교구분에 따른 만족도 통계
		}
	});
});

function setCardinal(cardinal) {
	// 임시저장
	$(":hidden[name='cardinal.id']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);
}

function setCourse(course) {
	// 임시저장
	$(":hidden[name='course.id']").val(course ? course.id : "");
	$(":text[name='course.name']").val(course ? course.name : "과정선택");
}

function ajaxChartData(url, chartTarget) {
	$.ajax({
       type : "POST",
       url : url,
       data : $("form[name='searchForm'").serialize(),
       success  : function(result) {
    	   switch (chartTarget) {
    	   case "aChart" :
    		   var dataList = new Array();
        	   $.each(result, function(i) {
        		   var data = new Array();
        		   data.push(result[i].NAME);
        		   data.push(result[i].COURSE_SATISFACTION_SCORE);
        		   dataList.push(data);
        	   })
    		   aChartDraw(dataList);
    		   break;
    	   case "bChart" :
    		   var dataList = new Array();
    		   $.each(result, function(i) {
    			   var data = new Array();
    			   data.push(result[i].SATIS_NAME);
    			   data.push(result[i].SATIS_ANSWER);
    			   dataList.push(data);
    		   })
    		   bChartDraw(dataList);
    		   break;
    	   case "cChart" :
    		   cChartDraw(result);
    		   break;
    	   case "dChart" :
    		   var dataList = new Array();
    		   dataList.push(['x', '매우만족', '만족', '보통', '불만족', '매우불만족']); // X 헤더
    		   $.each(result, function(i) {
    			   var data = new Array();
    			   data.push(result[i].S_TYPE_NAME);
    			   data.push(result[i].ANSWER1);
    			   data.push(result[i].ANSWER2);
    			   data.push(result[i].ANSWER3);
    			   data.push(result[i].ANSWER4);
    			   data.push(result[i].ANSWER5);
    			   dataList.push(data);
    		   })
    		   dChartDraw(dataList);
    		   break;
    	   }	   
       },
       error  : function(e) {
           alert(e.responseText);
       }
	});
}

function aChartDraw(data) {
	var title = '만족도 상위 Top5 과정'; 
	
	var chart = bb.generate({
		title: {
		    text: title,
	  	},
		data: {
			columns: data,
			type: "pie"
		},
		bindto: '.aChart'
	});
}

function bChartDraw(data) {
	var title = '기수 만족도 분포'; 
	
	var chart = bb.generate({
		title: {
		    text: title,
	  	},
		data: {
			columns: data,
			type: "pie"
		},
		bindto: '.bChart'
	});
}

function cChartDraw(data) {
	var title = '설문자 연령분포';
	
	var chart = bb.generate({
		title: {
		    text: title,
	  	},
		data: {
			x : 'x',
			columns: [
				['x', '20대', '30대', '40대', '50대', '60대', '기타'],
				['연령대', data.AGE_20, data.AGE_30, data.AGE_40, data.AGE_50, data.AGE_60, data.AGE_ETC]
			],
			type: "bar"
		},
		axis: {
		 	x: {
		 		type: "category"
		 	}
		},
		bindto: '.cChart'
	});
}

function dChartDraw(data) {
	var title = '초,중,고,유,특,기 별 만족도';
	
	var chart = bb.generate({
		title: {
		    text: title,
	  	},
		data: {
			x : 'x',
			columns: data,
			type: "bar"
		},
		axis: {
		 	x: {
		 		type: "category"
		 	}
		},
		bindto: '.dChart'
	});
}
</script>

<div class="content_wraper">
	<h3>연수만족도 통계</h3>
	<div class="tab_body">
	   	<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			
			<!-- 기수 선택 -->
			<input type='text' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<!-- 과정 선택 -->
			<input type='text' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
	
		<div class="chart">
			<div class="aChart"></div>
			<div class="bChart"></div>
			<div class="cChart"></div>
			<div class="dChart"></div>
		</div>
	
	</div>
</div>
