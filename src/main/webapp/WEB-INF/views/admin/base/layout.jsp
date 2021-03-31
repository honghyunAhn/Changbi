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

<title>타이틀</title>

<!-- bootstrap core css -->
<link href="<c:url value="/resources/css/ext/bootstrap/bootstrap.min.css"/>"rel="stylesheet">
<!-- bootstrap-datetimepicker css -->
<link href="<c:url value="/resources/css/ext/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>"rel="stylesheet">

<!-- <link href="/resources/css/ext/billboard/billboard.css" rel="stylesheet"> -->

<!-- project css -->
<link href="<c:url value="/resources/css/project/admin/common.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/project/admin/accordion.css"/>" rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="<c:url value="/resources/student/js/jquery-3.5.1.js"/>"></script>
<script src="<c:url value="/resources/student/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/js/ext/bootstrap-datetimepicker/datepicker.js" />"></script>
<!-- angular.js 추가 / kim --> 
<script src="<c:url value="/resources/student/js/angular.js" />"></script>

<link href="<c:url value="/resources/css/jquery-ui/jquery-ui.min.css"/>"rel="stylesheet">

<!-- ckeditor -->
<script src="<c:url value="/resources/ckeditor/ckeditor.js" />"></script>

<!-- 차트 -->
<script src="https://d3js.org/d3.v4.min.js"></script>

<!-- <script src="/resources/js/ext/billboard/billboard.js"></script> -->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- bootstrap -->
<script src="<c:url value="/resources/js/ext/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/resources/js/ext/bootstrap-datetimepicker/moment.min.js"/>"></script><!-- moment javascript -->
<script src="<c:url value="/resources/js/ext/bootstrap-datetimepicker/locales.min.js"/>"></script><!-- locales javascript -->
<script src="<c:url value="/resources/js/ext/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>"></script><!-- bootstrap-datetimepicker javascript -->
 
<!-- 내부  -->
<script src="<c:url value="/resources/js/com/commonFunc.js"/>"></script> 
<script src="<c:url value="/resources/js/com/commonObj.js"/>"></script>
<script src="<c:url value="/resources/js/com/commonFile.js"/>"></script>

<!-- 프로젝트 -->
<script src="<c:url value="/resources/js/project/accordion.js"/>"></script> 
<script src="<c:url value="/resources/js/project/changbi.js"/>"></script>

<!-- Daum 우편번호 서비스 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- 구글 차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!-- select2 css -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>


<link rel="stylesheet" href="/resources/css/project/admin/admin_02_classManagement_style.css">
<script src="/resources/js/project/admin_02_classManagement_script.js"></script>


<script type="text/javascript">
/* 사용자 드랍다운 레이어	*/
$(document).ready(function (e) {
    function t(t) {
        e(t).bind("click", function (t) {
            t.preventDefault();
            e(this).parent().fadeOut();
        });
    }
    e(".dropdown-toggle").click(function () {
        var t = e(this).parents(".button-dropdown").children(".dropdown-menu").is(":hidden");
        e(".button-dropdown .dropdown-menu").hide();
        e(".button-dropdown .dropdown-toggle").removeClass("active");
        if (t) {
            e(this).parents(".button-dropdown").children(".dropdown-menu").toggle().parents(".button-dropdown").children(".dropdown-toggle").addClass("active")
        }
    });
    
    e(document).bind("click", function (t) {
        var n = e(t.target);
        if (!n.parents().hasClass("button-dropdown")) e(".button-dropdown .dropdown-menu").hide();
    });
    e(document).bind("click", function (t) {
        var n = e(t.target);
        if (!n.parents().hasClass("button-dropdown")) e(".button-dropdown .dropdown-toggle").removeClass("active");
    });
    
    /* 아코디언 메뉴(색) 아래 뎁스가 존재하지 않은 경우만 고정 */	
    $(".acc_content li:not(.acc_content li:has(ul))").click(function(e) {
    	$(".acc_content li a").removeClass("active");
    	$(this).children("a").addClass("active");
    	
    	cancelBubble(e);
    });
    
    // 3뎁스 이상 컨트롤
    $(".acc_content li:has(ul)").click(function() {
    	if($(this).children("ul").css("display") == "none") {
	    	$(".acc_content li ul").hide(300);
	    	$(this).children("ul").show(300);
    	}
    });
    
    // 아코디언 메뉴 시작
    $("#my-accordion").accordionjs();
    
    // 최초 호출은 메인페이지 호출
    contentLoad();
    
  	//form태그 객체화하는 함수
	$.fn.serializeObject = function() {
		"use strict"
		var result = {}
		var extend = function(i, element) {
			var node = result[element.name]
			if("undefined" !== typeof node && node !== null) {
				if($.isArray(node)) {
					node.push(element.value)
				}else{
					result[element.name] = node
					//result[element.name] = [node, element.value]
				}
			}else{
				result[element.name] = element.value
			}
		}
		$.each(this.serializeArray(), extend)
		return result
	}
});


/* angular module추가 / kim */
//var myApp = angular.module('myapp', []);

/* myApp.directive('selectcode', [ '$http', function($http) {
	return {
		restrict : "A",
		replace : true,
		scope : {
			value : '@'
		},
		controller : function($scope, $element, $attrs) {
			$http({
				method : 'POST',
				url : '/codeconverter',
				responseType : 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
				$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		},
		template : "<option>{{filterParams}}</option>"
	}
} ]);
 */


function mainPageLoad() {
	$("#my-accordion li").removeClass("acc_active");
	$(".acc_content li a").removeClass("active");
	$(".acc_content").hide();
	$(".acc_content li ul").hide();
	// 메인페이지 호출
	contentLoad();
}

function contentLoad(title, contentUrl, data) {
	
	$("title").html(title ? title : "메인");
	
	// contentUrl이 없다면 targetUrl이 있는지 체크해서 targetUrl로 가든지 메인으로 가든지
	// 특정 url로 접근 시 해당 url을 targetUrl로 바꿔줌
	
	// ajax 처리
	$.ajax({
		type		: "POST",
		url			: contentUrl ? contentUrl : "/admin/base/main",
		data		: data,
		success		: function(result) {
			if(result == "ajaxLogin") {
				window.location.href = "/";
			} else {
				$("#container").html(result);
			}
		},
		error	: function(e) {
			alert(e.responseText);
			alert(contentUrl);
			alert(title);
			alert(data);
		}
	});
}

/* 컨텐츠 페이지 높이 */	
function funLoad() {
	var height = $(window).height();
	$('#my-accordion').css({'min-height':(height-50)+'px'});
}

window.onload = funLoad;
window.onresize = funLoad;

//timestamp -> date 형식 바꿔주는 함수
function getDateFormat(timestamp) {
	
	var dateVal = new Date(timestamp);
	var year = dateVal.getFullYear();
	var month = dateVal.getMonth() + 1;
	var day = dateVal.getDate();
	var time = dateVal.getHours();
	var min = dateVal.getMinutes();
	var sec = dateVal.getSeconds();
	var formattedVal = year + '-' + month + '-' + day + ' ' + time + ':' + min + ':' + sec;
	
	return formattedVal;
}
</script>
<script type="text/javascript">
$(function() {
	cleanDatepicker();
	$(".admin_expired_st").datepicker();
	$(".admin_expired_et").datepicker();
	$("#pageSelect").change(function(){
		
		var pageCount = $(this).val();
		var searchName = $("#name").val();
		location.href="/edu/admin/admin_info_setting_form?searchName="+searchName+"&pageCount="+pageCount+"&curPage=${map.adminPager.curPage}";
	});
});
function cleanDatepicker() {

	var original_gotoToday = $.datepicker._gotoToday;

	$.datepicker._gotoToday = function(id) {
		var target = $(id), inst = this._getInst(target[0]);

		original_gotoToday.call(this, id);
		this._selectDate(id, this._formatDate(inst, inst.selectedDay,
				inst.drawMonth, inst.drawYear));
		target.blur();
	}

	var old_fn = $.datepicker._updateDatepicker;

	$.datepicker._updateDatepicker = function(inst) {
		old_fn.call(this, inst);

		var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

		$(	"<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>clear</button>").appendTo(buttonPane).click(function(ev) {
					$.datepicker._clearDate(inst.input);
		});
	}
}

var myApp = angular.module('myapp', []);

myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
	
	$scope.admin_info = JSON.parse('${admin_info_list_json}');
	
	$scope.update = function($event){

		var _row  = angular.element($event.currentTarget).closest(".admin_row");
		var _admin_id = _row.find(".admin_id").text();
		var _admin_grade = _row.find(".admin_grade").val();
		var _admin_state = _row.find(".admin_state").val();
		var _admin_project = _row.find(".admin_project").val();
		var _admin_expired_st = _row.find(".admin_expired_st").val();
		var _admin_expired_et = _row.find(".admin_expired_et").val();

	 	$http({
			method: 'POST',
			url: '/edu/admin/admin_info_update',
			params : {
				admin_id : _admin_id,
				admin_grade : _admin_grade,
				admin_state : _admin_state,
				admin_project : _admin_project,
				admin_expired_st : _admin_expired_st,
				admin_expired_et : _admin_expired_et
			}
		}).then(function successCallback(response) {
    		alert("정보 수정 완료 하였습니다.");
		}, function errorCallback(response) {
			console.log(response);
			alert("정보 수정 실패 하였습니다.");
		});
		
	}
}]);

myApp.directive('code', ['$http',function($http){
	return {
		restrict: "E",
		replace: true,
		scope : {
			value : '@'
		},
		controller: function ($scope, $element, $attrs) {
			$http({
				method: 'POST',
				url: '/codeconverter',
		  		responseType: 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
	    		$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		,template: "<span>{{filterParams}}</span>"
	}
}]);

myApp.directive('selectcode', [ '$http', function($http) {
	return {
		restrict : "A",
		replace : true,
		scope : {
			value : '@'
		},
		controller : function($scope, $element, $attrs) {
			$http({
				method : 'POST',
				url : '/codeconverter',
				responseType : 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
				$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		},
		template : "<option>{{filterParams}}</option>"
	}
} ]);
	// **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function ilist(page){
	    location.href="/edu/admin/admin_info_setting_form?curPage="+page+"&pageCount=${map.pageCount}";
	}

	function search_name(){
		var searchName = $("#name").val();
		location.href="/edu/admin/admin_info_setting_form?searchName="+searchName+"&curPage=${map.adminPager.curPage}&pageCount=${map.pageCount}";
	}
    
</script>
</head>

<body style="overflow-y: scroll;">
<div id="wrap">
	<!-- 레이어 팝업 영역 -->
	<div class="overlay" style="display:none;background-color: #000; bottom: 0; left: 0; opacity: 0.5; filter: alpha(opacity = 50); position: fixed;  right: 0;  top: 0;  z-index: 1999;"></div> 
	<div class="popup" style="width:800px; height:600px; position:absolute; box-shadow: 0px 1px 20px #333; display:none; background-color:#fff; z-index: 2000;">
		<div class="popup_title" style="width: 800px; height: 40px; background-color:#aaa;"></div>
		<div class="popup_content" style="width: 780px; height: 540px; padding: 10px; overflow-y: auto;"></div>
	</div>
	<!--// 레이어 팝업 영역 -->
	
	<div id="header">
		<div class="header">
			<h1 class="navbar-brand"><a class="navbar-brand" href="javascript:mainPageLoad();">창비연수관리자</a></h1>			
			<ul class="navbar-top-links">
				<li class="button-dropdown">
				<c:choose>
					<c:when test="${loginUser.grade eq 8 or loginUser.grade eq 9}">
						<a href="javascript:void(0)" class="dropdown-toggle active">관리자<span>▼</span></a>
					</c:when>
					<c:when test="${loginUser.grade eq 1}">
						<a href="javascript:void(0)" class="dropdown-toggle active">튜터<span>▼</span></a>
					</c:when>
				</c:choose>
					<ul class="dropdown-menu">
						<li><a href="javascript:contentLoad('마이페이지','/admin/base/myPage');">내정보</a></li>
						<li><a href="/forFaith/base/logout">로그아웃</a></li>
						<li><a href="#">원격지원</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="navbar-sidebar">
		<ul id="my-accordion" class="accordionjs">
		<c:choose>
			<c:when test="${loginUser.grade eq 8 or loginUser.grade eq 9}">
			<li>
				<a href="javascript:void(0);">관리자 설정</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('관리자 설정','/admin/adminManagement/adminManagementForm', {'pageNo' : 1, 'numOfRows' : 1});">관리자 설정</a></li>
					<li><a href="javascript:contentLoad('권한 설정 내역','/admin/adminManagement/adminManagementHistory');">권한 설정 내역</a></li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">수강관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('개별신청관리','/admin/learnApp/learnAppList');">개별신청관리</a></li>
					 <!--	<li><a href="javascript:contentLoad('교육청(기관)신청관리','/admin/learnApp/learnAppList', {'groupLearnYn' : 'Y'});">교육청(기관)신청관리</a></li>-->
					<li><a href="javascript:contentLoad('수강관리','/admin/learnApp/learnManList');">수강관리</a></li>
					<!-- 
					<li><a href="javascript:contentLoad('수강변경관리','/admin/learnApp/learnChangeList');">수강변경관리</a></li> 
					<li><a href="javascript:contentLoad('수강연기관리','/admin/learnApp/learnDelayList');">수강연기관리</a></li>
					-->
					<li><a href="javascript:contentLoad('수강취소관리','/admin/learnApp/learnCancelList');">수강취소관리</a></li>
					<li><a href="javascript:contentLoad('입과관리','/admin/learnApp/learnAppInsert');">입과관리</a></li>
				</ul>
			</li>
			 
			<li>
				<a href="javascript:void(0);">평가관리</a>
				<ul class="acc_content">
					<li>
						<a href="javascript:void(0);">온라인시험관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('온라인시험 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '2'});">온라인시험 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('온라인시험 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '2'});">온라인시험 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인시험 관리','/admin/quiz/quizList', {'quizType' : '2'});">기수/과정별 온라인시험 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인시험 현황','/admin/quiz/quizAppList', {'quizType' : '2'});">기수/과정별 온라인시험 현황</a></li>
							<!-- <li><a href="javascript:alert('준비중입니다.');">온라인시험 관리 매뉴얼</a></li> -->
						</ul>
					</li>
					<li>
						<a href="javascript:void(0);">온라인과제관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('온라인과제 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '3'});">온라인과제 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('온라인과제 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '3'});">온라인과제 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인과제 관리','/admin/quiz/quizList', {'quizType' : '3'});">기수/과정별 온라인과제 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인과제 현황','/admin/quiz/quizAppList', {'quizType' : '3'});">기수/과정별 온라인과제 현황</a></li>
							<!-- <li><a href="javascript:contentLoad('첨삭지도','/admin/learnApp/activeList');">첨삭지도</a></li> -->
							<!-- <li><a href="javascript:alert('준비중입니다.');">온라인과제 관리 매뉴얼</a></li> -->
						</ul>
					</li>
					<li>
						<a href="javascript:void(0);">출석시험관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('출석시험 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '1'});">출석시험 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('출석시험 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '1'});">출석시험 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 출석시험 관리','/admin/quiz/quizList', {'quizType' : '1'});">기수/과정별 출석시험 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 출석시험 현황','/admin/quiz/quizAppList', {'quizType' : '1'});">기수/과정별 출석시험 현황</a></li>
							<li><a href="javascript:contentLoad('출석시험 고사장 관리','/admin/quiz/examSpotList');">출석시험 고사장 관리</a></li>
							<!-- <li><a href="javascript:alert('준비중입니다.');">출석시험 관리 매뉴얼</a></li> -->
						</ul>
					</li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">모의토플 관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('서비스목록 관리','/admin/toefl/toeflList');">서비스목록 관리</a></li>
					<li><a href="javascript:contentLoad('개별신청관리','/admin/toefl/toeflPayList');">개별신청 관리</a></li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">학사관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('성적 관리','/admin/studentManagement/studentScoreManagement');">성적 관리</a></li>
					<!-- <li><a href="javascript:contentLoad('출석 관리','/admin/studentManagement/studentAttendanceManagement');">출석 관리</a></li> -->
					<li>
						<a href="javascript:void(0);">설문조사관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('설문조사 생성','/admin/studentManagement/studentSurveyCreate');">설문조사 생성</a></li>
							<li><a href="javascript:contentLoad('일반설문 내역','/admin/studentManagement/studentSurveyManagement');">일반설문 내역</a></li>
							<li><a href="javascript:contentLoad('자동배포 설문','/admin/studentManagement/studentSurveyAuto');">자동배포 설문</a></li>
						</ul>
					</li>
					<li><a href="javascript:contentLoad('상담관리','/admin/studentManagement/studentCounselManagement');">상담관리</a></li>
					<li><a href="javascript:contentLoad('학적부 관리','/admin/studentManagement/studentTableManagement');">학적부 관리</a></li>
				</ul>
			</li>
			 
			<li>
				<a href="javascript:void(0);">이수관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('개별이수관리','/admin/complete/completeProc');">개별이수관리</a></li>
					<!--  
					<li><a href="javascript:contentLoad('교육청(기관)이수관리','/admin/complete/completeProc', {'groupLearnYn' : 'Y'});">교육청(기관)이수관리</a></li>
					<li><a href="javascript:contentLoad('이수자현황보고','/admin/complete/completeList');">이수자현황보고</a></li>
					-->
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">회원관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('회원관리','/admin/member/memberList');">회원관리</a></li>
					<li><a href="javascript:contentLoad('탈퇴회원관리','/admin/member/memOutList');">탈퇴회원관리</a></li>
					<!-- 
					<li><a href="javascript:contentLoad('튜터관리','/admin/member/managerList', {grade : 1});">튜터관리</a></li>
					<li><a href="javascript:contentLoad('관리자관리','/admin/member/managerList', {grade : 8});">관리자관리</a></li>
					<li><a href="javascript:contentLoad('강사관리','/admin/member/managerList', {grade : 2});">강사관리</a></li>
					<li><a href="javascript:contentLoad('업체관리','/admin/member/managerList', {grade : 3});">업체관리</a></li>
					 -->
				</ul>
			</li>
			<!--  
			<li>
				<a href="javascript:void(0);">교재관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('교재신청관리','/admin/book/bookAppList');">교재신청관리</a></li>
					<li><a href="javascript:contentLoad('교재등록관리','/admin/book/bookList');">교재등록관리</a></li>
					<li><a href="javascript:contentLoad('교재업체분류','/forFaith/base/code', {'codeGroup.id' : 'publish'});">교재업체분류</a></li>
					<li><a href="javascript:contentLoad('교재입고관리','/admin/book/bookInputList');">교재입고관리</a></li>
					<li><a href="javascript:contentLoad('교재입/출고현황','/admin/book/bookInoutList');">교재입/출고현황</a></li>
				</ul>
			</li>
			-->
			<li>
				<a href="javascript:void(0);">과정/기수관리</a>
				<ul class="acc_content">
				    <li><a href="javascript:contentLoad('분류관리','/admin/course/subCourse',{'codeGroup.id':'sub_course'});">분류관리</a></li>
					<!-- <li><a href="javascript:contentLoad('연수영역관리','/admin/course/studyRange', {'codeGroup.id':'course'});">연수영역관리</a></li> -->
					<li><a href="javascript:contentLoad('연수과정관리','/admin/course/trainProcessList');">연수과정관리</a></li>
					<li><a href="javascript:contentLoad('기수관리','/admin/course/cardinalList');">기수관리</a>
						<!--  
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('직무4학점기수관리','/admin/course/cardinalList', {'learnType':'J', 'credits':'4'});">직무4학점</a></li>
							<li><a href="javascript:contentLoad('직무3학점기수관리','/admin/course/cardinalList', {'learnType':'J', 'credits':'3'});">직무3학점</a></li>
							<li><a href="javascript:contentLoad('직무1,2학점기수관리','/admin/course/cardinalList', {'learnType':'J', 'credits':'1,2'});">직무1/2학점</a></li>
								<li><a href="javascript:contentLoad('단체연수기수관리','/admin/course/cardinalList', {'learnType':'G'});">단체연수</a></li>
								<li><a href="javascript:contentLoad('집합연수기수관리','/admin/course/cardinalList', {'learnType':'M'});">집합연수</a></li>
						 </ul>
						-->
					</li>
					<!-- <li><a href="javascript:contentLoad('교육청(기관)기수관리','/admin/course/groupLearnList');">교육청(기관)기수관리</a></li> -->
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">결제관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('결제관리','/admin/pay/payList');">결제관리</a></li>
					<!--  
					<li><a href="javascript:contentLoad('개별결제관리','/admin/pay/individualPayList');">개별결제관리</a></li>
					<li><a href="javascript:contentLoad('교육청(기관)결제관리','/admin/pay/groupPayList');">교육청(기관)결제관리</a></li>
					<li><a href="javascript:contentLoad('업체정산관리','/admin/pay/calculateList?calType=company');">업체정산관리</a></li>
					<li><a href="javascript:contentLoad('튜터정산관리','/admin/pay/calculateList?calType=tutor');">튜터정산관리</a></li>
					<li><a href="javascript:contentLoad('강사정산관리','/admin/pay/calculateList?calType=teacher');">강사정산관리</a></li>
					-->
					<li><a href="javascript:contentLoad('포인트관리','/admin/common/view/pointList');">포인트관리</a></li>
					<!--<li><a href="javascript:contentLoad('쿠폰관리','/admin/common/view/couponList');">쿠폰관리</a></li>  -->
				</ul> 
			</li>
			<li>
				<a href="javascript:void(0);">게시물관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('FAQ분류 등록','/forFaith/base/code', {'codeGroup.id':'faq'});">FAQ분류 등록</a></li>
<!-- 					<li><a href="javascript:contentLoad('전체 공지사항','/admin/board/boardList', {'boardType':1});">전체 공지사항</a></li> -->
					<li><a href="javascript:contentLoad('게시판 관리','/admin/board/allBoardList');">게시판 관리</a></li>
<!-- 					<li><a href="javascript:contentLoad('전체 공지사항','/admin/board/noticeList');">전체 공지사항</a></li> -->
					<li><a href="javascript:contentLoad('과정별 공지사항','/admin/board/courseBoardList', {'boardType':1});">과정별 공지사항</a></li>
					<!-- <li><a href="javascript:contentLoad('전체 자료실관리','/admin/board/boardList', {'boardType':2});">전체 자료실관리</a></li>-->
					<li><a href="javascript:contentLoad('과정별 자료실관리','/admin/board/courseBoardList', {'boardType':2});">과정별 자료실관리</a></li>
					<!-- <li><a href="javascript:contentLoad('자유게시판 관리','/admin/board/freeBoardList', {'boardType':8});">자유게시판 관리</a></li> -->
					<li><a href="javascript:contentLoad('자주묻는질문','/admin/board/faqList');">FAQ 관리</a></li>
<!-- 					<li><a href="javascript:contentLoad('자주묻는질문','/admin/board/boardList', {'boardType':3});">FAQ 관리</a></li> -->
					<!-- <li><a href="javascript:contentLoad('1:1상담관리','/admin/board/boardList', {'boardType':4});">1:1상담관리</a></li> -->
					<li><a href="javascript:contentLoad('과정별 질의응답관리','/admin/board/courseBoardList', {'boardType':6});">과정별 질의응답관리</a></li>
					<!--  <li><a href="javascript:contentLoad('연수모집공문관리','/admin/board/boardList', {'boardType':1, 'noticeType':7});">연수모집공문관리</a></li>-->
					<!-- <li><a href="javascript:contentLoad('연수후기관리','/admin/board/boardList', {'boardType':5});">연수후기관리</a></li> -->
					<!-- <li><a href="javascript:contentLoad('연수후기관리','/admin/board/courseBoardList', {'boardType':5});">연수후기관리</a></li> -->
					<li><a href="javascript:contentLoad('연수설문관리','/admin/board/surveyList');">연수설문관리</a></li>
					<!--<li><a href="javascript:contentLoad('쪽지함관리','/admin/board/noteList');">쪽지함관리</a></li> -->
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">통계조회</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('기수/과정별학습통계','/admin/stats/courseStatsList');">기수/과정별학습통계</a></li>
					<!--
					<li><a href="javascript:contentLoad('회원가입현황통계','/admin/stats/joinStatsList');">회원가입현황통계</a></li>
					<li><a href="javascript:contentLoad('회원현황및게시물통계','/admin/stats/userStatsList');">회원현황및게시물통계</a></li>
					<li><a href="javascript:contentLoad('수강현황통계(I)','/admin/stats/learnStatsList');">수강현황통계(I)</a></li>
					<li><a href="javascript:contentLoad('수강현황통계(II)','/admin/stats/learnStatsGraph');">수강현황통계(II)</a></li>
					  -->
					<li><a href="javascript:contentLoad('만족도 조사 통계','/admin/stats/surveyStatsList?survey.surveyCode.code=survey999');">만족도 조사 통계</a></li>
					<!--  
					<li><a href="javascript:contentLoad('강의 평가 통계','/admin/stats/surveyStatsList?survey.surveyCode.code=survey001');">강의 평가 통계</a></li>
					<li><a href="javascript:contentLoad('문자발송통계','/admin/stats/smsHistoryStats');">문자발송통계</a></li>
					-->
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">기초관리</a>
				<ul class="acc_content">
				    <!-- 
					<li><a href="javascript:contentLoad('학교관리','/admin/basic/schoolList');">학교관리</a></li>
					<li><a href="javascript:contentLoad('시도교육청관리','/forFaith/base/code', {'codeGroup.id':'region'});">시도교육청관리</a></li>	
					<li><a href="javascript:contentLoad('연수설문분류관리','/forFaith/base/code', {'codeGroup.id':'survey'});">연수설문분류관리</a></li>				
					<li><a href="javascript:contentLoad('무통장입금계좌관리','/forFaith/base/code', {'codeGroup.id':'account'});">무통장입금계좌관리</a></li>
					<li><a href="javascript:contentLoad('연수자 IP 관리','/admin/basic/ipList');">연수자 IP 관리</a></li>
					 -->
					<li><a href="javascript:contentLoad('포인트정책','/admin/basic/policyPointEdit', {id : 1});">포인트정책</a></li>
					<!-- <li><a href="javascript:contentLoad('수강연기/취소정책','/admin/basic/policyDelayCancelEdit', {id : 1});">수강연기/취소정책</a></li> -->
					<!-- <li><a href="javascript:contentLoad('이벤트관리','/admin/basic/eventList');">이벤트관리</a></li> -->
					<li><a href="javascript:contentLoad('배너관리','/admin/basic/bannerList');">배너관리</a></li>
					<!--  <li><a href="javascript:contentLoad('안내페이지관리','/admin/basic/infoList');">안내페이지관리</a></li>-->
					<li><a href="javascript:contentLoad('공통코드관리','/admin/basic/comCode');">공통코드관리</a></li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">출결관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('기수별출석일수관리','/admin/attendance/insertDate');">기수별출석일수관리</a></li>
					<li><a href="javascript:contentLoad('출결관리','/admin/attendance/attendanceCheck');">출결관리</a></li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">지원관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('지원자관리','/admin/studentManagement/applyManagement');">지원자관리</a></li>
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">SMS/메일관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('sms 전송결과 조회','/admin/common/smsHistory');">SMS 전송결과 조회</a></li>
					<li><a href="javascript:contentLoad('메일 전송결과 조회','/admin/common/emailHistory');">메일 전송결과 조회</a></li>
				</ul>
			</li>
			</c:when>
			<c:when test="${loginUser.grade eq 1}">
			<li>
				<a href="javascript:void(0);">수강관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('개별신청관리','/admin/learnApp/learnAppList');">개별신청관리</a></li>
					<!-- <li><a href="javascript:contentLoad('교육청(기관)신청관리','/admin/learnApp/learnAppList', {'groupLearnYn' : 'Y'});">교육청(기관)신청관리</a></li> -->
					<li><a href="javascript:contentLoad('수강관리','/admin/learnApp/learnManList');">수강관리</a></li>
					<!--  <li><a href="javascript:contentLoad('수강연기관리','/admin/learnApp/learnDelayList');">수강연기관리</a></li>-->
					<li><a href="javascript:contentLoad('수강취소관리','/admin/learnApp/learnCancelList');">수강취소관리</a></li>
				</ul>
			</li>
			<%-- 
			<li>
				<a href="javascript:void(0);">평가관리</a>
				<ul class="acc_content">
					<li>
						<a href="javascript:void(0);">온라인시험관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('온라인시험 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '2'});">온라인시험 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('온라인시험 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '2'});">온라인시험 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인시험 관리','/admin/quiz/quizList', {'quizType' : '2'});">기수/과정별 온라인시험 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인시험 현황','/admin/quiz/quizAppList', {'quizType' : '2'});">기수/과정별 온라인시험 현황</a></li>
							<!-- <li><a href="javascript:alert('준비중입니다.');">온라인시험 관리 매뉴얼</a></li> -->
						</ul>
					</li>
					<li>
						<a href="javascript:void(0);">온라인과제관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('온라인과제 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '3'});">온라인과제 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('온라인과제 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '3'});">온라인과제 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인과제 관리','/admin/quiz/quizList', {'quizType' : '3'});">기수/과정별 온라인과제 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 온라인과제 현황','/admin/quiz/quizAppList', {'quizType' : '3'});">기수/과정별 온라인과제 현황</a></li>
							<!-- <li><a href="javascript:contentLoad('첨삭지도','/admin/learnApp/activeList');">첨삭지도</a></li> -->
							<!-- <li><a href="javascript:alert('준비중입니다.');">온라인과제 관리 매뉴얼</a></li> -->
						</ul>
					</li>
					<li>
						<a href="javascript:void(0);">출석시험관리</a>
						<ul style="display: none;">
							<li><a href="javascript:contentLoad('출석시험 문제은행관리','/admin/quiz/quizBankList', {'quizType' : '1'});">출석시험 문제은행관리</a></li>
							<li><a href="javascript:contentLoad('출석시험 시험지풀관리','/admin/quiz/quizPoolList', {'quizType' : '1'});">출석시험 시험지풀관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 출석시험 관리','/admin/quiz/quizList', {'quizType' : '1'});">기수/과정별 출석시험 관리</a></li>
							<li><a href="javascript:contentLoad('기수/과정별 출석시험 현황','/admin/quiz/quizAppList', {'quizType' : '1'});">기수/과정별 출석시험 현황</a></li>
							<!-- <li><a href="javascript:alert('준비중입니다.');">출석시험 관리 매뉴얼</a></li> -->
						</ul>
					</li>
				</ul>
			</li>
						
			<li>
				<a href="javascript:void(0);">결제관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('튜터정산관리','/admin/pay/calculateList?calType=tutor');">튜터정산관리</a></li>
				</ul> 
			</li>
			--%>
			<li>
				<a href="javascript:void(0);">게시물관리</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('과정별 공지사항','/admin/board/courseBoardList', {'boardType':1});">과정별 공지사항</a></li>
					<li><a href="javascript:contentLoad('과정별 자료실관리','/admin/board/courseBoardList', {'boardType':2});">과정별 자료실관리</a></li>
					<li><a href="javascript:contentLoad('과정별 질의응답관리','/admin/board/courseBoardList', {'boardType':6});">과정별 질의응답관리</a></li>
					<li><a href="javascript:contentLoad('연수후기관리','/admin/board/courseBoardList', {'boardType':5});">연수후기관리</a></li>
					<!-- <li><a href="javascript:contentLoad('연수설문관리','/admin/board/surveyList');">연수설문관리</a></li> -->
					<!--  <li><a href="javascript:contentLoad('쪽지함관리','/admin/board/noteList');">쪽지함관리</a></li>-->
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">통계조회</a>
				<ul class="acc_content">
					<li><a href="javascript:contentLoad('기수/과정별학습통계','/admin/stats/courseStatsList');">기수/과정별학습통계</a></li>
					<!-- 
					<li><a href="javascript:contentLoad('수강현황통계(I)','/admin/stats/learnStatsList');">수강현황통계(I)</a></li>
					<li><a href="javascript:contentLoad('수강현황통계(II)','/admin/stats/learnStatsGraph');">수강현황통계(II)</a></li>
					 -->
					<li><a href="javascript:contentLoad('만족도 조사 통계','/admin/stats/surveyStatsList?survey.surveyCode.code=survey999');">만족도 조사 통계</a></li>
					<!-- <li><a href="javascript:contentLoad('강의 평가 통계','/admin/stats/surveyStatsList?survey.surveyCode.code=survey001');">강의 평가 통계</a></li>  -->
				</ul>
			</li>
			</c:when>
		</c:choose>
		</ul>
	</div>
	
	<div id="container">ajax로 호출 된 웹 페이지가 들어올 자리</div>
</div>
</body>

<style>
/* 김성미 : select2 삼각형 아이콘 분리되는 경우, select2가 들어있는 요소(<dd>, <div> 등..)의 class에 "select2_dd" 추가해주세요. */
.select2_dd span{
	margin-left: 0px;
}

.js-example-basic-single{
width: 75%;
}
.js-states{
width: 20%;
margin: 0px;
}

.justWatch:focus{
outline: none;
}

.range-slider { margin: 3% 0 0 0%; }

.range-slider { width: 100%; }

.range-slider__range {
  -webkit-appearance: none;
 width: calc(100% - (73px));
  height: 10px;
  border-radius: 5px;
  background: #d7dcdf;
  outline: none;
  padding: 0;
  margin: 0;
}
.range-slider__range::-webkit-slider-thumb {
 -webkit-appearance: none;
 appearance: none;
 width: 20px;
 height: 20px;
 border-radius: 50%;
 background: #2c3e50;
 cursor: pointer;
 -webkit-transition: background .15s ease-in-out;
 transition: background .15s ease-in-out;
}
.range-slider__range::-webkit-slider-thumb:hover {
 background: #1abc9c;
}
.range-slider__range:active::-webkit-slider-thumb {
 background: #1abc9c;
}
.range-slider__range::-moz-range-thumb {
 width: 20px;
 height: 20px;
 border: 0;
 border-radius: 50%;
 background: #2c3e50;
 cursor: pointer;
 -webkit-transition: background .15s ease-in-out;
 transition: background .15s ease-in-out;
}
.range-slider__range::-moz-range-thumb:hover {
 background: #1abc9c;
}
.range-slider__range:active::-moz-range-thumb {
 background: #1abc9c;
}
.range-slider__range:focus::-webkit-slider-thumb {
 -webkit-box-shadow: 0 0 0 3px #fff, 0 0 0 6px #1abc9c;
 box-shadow: 0 0 0 3px #fff, 0 0 0 6px #1abc9c;
}

.range-slider__value {
  display: inline-block;
  position: relative;
  width: 60px;
  color: #fff;
  line-height: 20px;
  text-align: center;
  border-radius: 3px;
  background: #2c3e50;
  padding: 5px 10px;
  margin-left: 8px;
}

.range-slider__value:after {
  position: absolute;
  top: 8px;
  left: -7px;
  width: 0;
  height: 0;
  border-top: 7px solid transparent;
  border-right: 7px solid #2c3e50;
  border-bottom: 7px solid transparent;
  content: '';
}

::-moz-range-track {
 background: #d7dcdf;
 border: 0;
}
 input::-moz-focus-inner, input::-moz-focus-outer {
 border: 0;
}

input[type=range]{
	width: 75%;

}

#tabs_container {
    border-bottom: 2px solid #666;
}

#tabs {
    list-style: none;
    padding: 9px 0 7px 0;
    margin: 4px 0 0 0;
}

#tabs li {
    display: inline;
}

#tabs li a {
    color: #333;
    padding: 10px 20px;
    text-decoration: none;
    border-bottom: none;
    outline: none;
    border-radius: 5px 5px 0 0;
    -moz-border-radius: 5px 5px 0 0;
    -webkit-border-top-left-radius: 5px;
    -webkit-border-top-right-radius: 5px;
}

#tabs li a:hover {
    color: #333;
    background-color: #bbb;
    padding: 10px 20px;
}

#tabs li.active a {
    background-color: #666;
    color: #fff;
    border-radius: 3px 3px 0 0;
}

#tabs_content_container {
    border-top: none;
    padding: 10px;
    width: 100%;
}

.tab_content {
    display: none;
}

.titlee, .col-xs-6{
color: white;
}
</style>
</html>