<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
/* 사용자 드랍다운 레이어	*/
$(document).ready(function (e) {
    function t(t) {
        e(t).bind("click", function (t) {
            t.preventDefault();
            e(this).parent().fadeOut()
        })
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
    
    /* 아코디언 메뉴 고정 */	
    $(".acc_content li a").click(function() {
    	$(this).toggleClass("active");
    });
    
    $("#my-accordion").accordionjs();
});

/* 컨텐츠 페이지 높이 */	
function funLoad(){
	var height = $(window).height();
	$('#my-accordion').css({'min-height':(height-50)+'px'});
}

window.onload = funLoad;
window.onresize = funLoad;

</script>

<!-- 레이어 팝업 영역 -->
<div class="overlay" style="display:none;background-color: #000; bottom: 0; left: 0; opacity: 0.5; filter: alpha(opacity = 50); position: fixed;  right: 0;  top: 0;  z-index: 1999;"></div> 
<div class="popup" style="width:800px; height:600px; position:absolute; box-shadow: 0px 1px 20px #333; display:none; background-color:#fff; z-index: 2000;">
	<div class="popup_title" style="width: 800px; height: 40px; background-color:#aaa;"></div>
	<div class="popup_content" style="width: 780px; height: 540px; padding: 10px; overflow-y: auto;"></div>
</div>
<!--// 레이어 팝업 영역 -->

<div id="header">
	<div class="header">
		<h1 class="navbar-brand"><a class="navbar-brand" href="<c:url value="/admin/base/main"/>">창비연수관리자</a></h1>			
		<ul class="navbar-top-links">
			<li class="button-dropdown">
				<a href="javascript:void(0)" class="dropdown-toggle active">관리자<span>▼</span></a>
				<ul class="dropdown-menu">
					<li><a href="/forFaith/base/myPage">내정보</a></li>
					<li><a href="/forFaith/base/logout">로그아웃</a></li>
					<li><a href="#">원격지원</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>

<div class="navbar-sidebar">
	<ul id="my-accordion" class="accordionjs">
		<li>
			<a href="#">수강관리</a>
			<ul class="acc_content">
				<li><a href="#">개별신청관리</a></li>
				<li><a href="#">단체신청관리</a></li>
				<li><a href="#">수강관리</a></li>
				<li><a href="#">수강연기관리</a></li>
				<li><a href="#">수강취소관리</a></li>
				<li><a href="#">첨삭이력관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">평가관리</a>
			<ul class="acc_content">
				<li><a href="#">온라인평가관리</a></li>
				<li><a href="#">온라인과제관리</a></li>
				<li><a href="#">출석평가관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">이수관리</a>
			<ul class="acc_content">
				<li><a href="#">개별이수관리</a></li>
				<li><a href="#">단체이수관리</a></li>
				<li><a href="#">이수자현황보고</a></li>
			</ul>
		</li>
		<li>
			<a href="#">회원관리</a>
			<ul class="acc_content">
				<li><a href="/admin/member/memberList">회원관리</a></li>
				<li><a href="/admin/member/memOutList">탈퇴회원관리</a></li>
				<li><a href="/admin/member/managerList/1">튜터관리</a></li>
				<li><a href="/admin/member/managerList/8">관리자관리</a></li>
				<li><a href="/admin/member/managerList/2">강사관리</a></li>
				<li><a href="/admin/member/managerList/3">업체관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">교재관리</a>
			<ul class="acc_content">
				<li><a href="#">교재신청관리</a></li>
				<li><a href="#">교재등록관리</a></li>
				<li><a href="#">교재입/출고현황</a></li>
			</ul>
		</li>
		<li>
			<a href="#">과정/기수관리</a>
			<ul class="acc_content">
				<li><a href="#">연수영연관리</a></li>
				<li><a href="#">연수과정관리</a></li>
				<li><a href="#">기수관리</a></li>
				<li><a href="#">단체등록관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">결제관리</a>
			<ul class="acc_content">
				<li><a href="#">개별결제관리</a></li>
				<li><a href="#">단체결제관리</a></li>
				<li><a href="#">업체정산관리</a></li>
				<li><a href="#">튜터정산관리</a></li>
				<li><a href="#">강사정산관리</a></li>
				<li><a href="#">포인트관리</a></li>
				<li><a href="#">쿠폰관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">게시물관리</a>
			<ul class="acc_content">
				<li><a href="#">공지사항PC</a></li>
				<li><a href="#">공지사항모바일</a></li>
				<li><a href="#">자료실관리</a></li>
				<li><a href="#">자주묻는질문PC</a></li>
				<li><a href="#">자주묻는질문모바일</a></li>
				<li><a href="#">1:1상담관리</a></li>
				<li><a href="#">연수모집공문관리</a></li>
				<li><a href="#">연수후기관리</a></li>
				<li><a href="#">연수설문관리</a></li>
				<li><a href="#">쪽지함관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#">통계조회</a>
			<ul class="acc_content">
				<li><a href="#">기수/과정별학습통계</a></li>
				<li><a href="#">회원가입현황통계</a></li>
				<li><a href="#">회원현황및게시물통계</a></li>
				<li><a href="#">수강현황통계(I)</a></li>
				<li><a href="#">수강현황통계(II)</a></li>
				<li><a href="#">연수만족도통계</a></li>
				<li><a href="#">연수설문통계</a></li>
				<li><a href="#">문자발송통계</a></li>
			</ul>
		</li>
		<li>
			<a href="#">기초관리</a>
			<ul class="acc_content">
				<li><a href="#">학교관리</a></li>
				<li><a href="#">무통장입금계좌관리</a></li>
				<li><a href="#">관리자허용IP설정</a></li>
				<li><a href="#">포인트정책</a></li>
				<li><a href="#">수강연기/취소정책</a></li>
				<li><a href="#">이벤트관리</a></li>
				<li><a href="#">배너관리</a></li>
				<li><a href="#">안내페이지관리</a></li>
			</ul>
		</li>
	</ul>
</div>