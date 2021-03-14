<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript">

$(document).ready(function(){
	// 언어 변경 시 마다..
	$(document).on("click", "#changeLanguage", function() {
		var locale = "<c:out value="${localeLanguage}" />";
		
		if(locale != $("select.language").val()) {
			$(":hidden[name='locale']").val($("select.language").val());
			
			// 현재 자기 자신의 페이지를 호출한다. 이때는 actionForm을 사용함.
			$("#actionForm").submit();
		}
	});
	
	// 메인 메뉴 클릭 시
	$(document).on("click", "#fullmenu .gnb-item", function() {
		var index = $("#fullmenu .gnb-item").index($(this));
		
		menuPageTurning(getPageNameByIndex(index));
	});
	
	// 로고 클릭 시
	$(document).on("click", ".header-logo", function() {
		menuPageTurning(getPageNameByIndex());
	});
	
	// layer 토글
    $('a.toggle-layer').click(function(){
      targetid = $(this).attr("href");
      $(targetid).toggleClass('on');
      return false; //링크실행 방지
    })
});

// 메뉴 페이지 전환(메뉴 클릭 시)
function menuPageTurning(pageName) {
	$("#menuForm").attr("action", getPageUrlByName(pageName));
	$("#menuForm").submit();
}

// 버튼 클릭 후 페이지 전환 등 메뉴 action에 의한 페이지 전환 시
function actionPageTurning(pageName) {
	$("#actionForm").attr("action", getPageUrlByName(pageName));
	$("#actionForm").submit();
}

// index로 페이지 이름을 추출 해당 페이지 이름이 없으면 main
function getPageNameByIndex(index) {
	var menuNameArr = ["intro", "dic", "paperweight", "appointment", "board"];
	
	// default로 메인
	return menuNameArr[index] ? menuNameArr[index] : "main";
}

// 페이지 이름으로 호출 url을 가져오기
function getPageUrlByName(pageName) {
	var menuNameList	= new ArrayList(["main", "intro", "dic", "paperweight", "appointment", "board"]);
	var pageUrlList		= new ArrayList(["/web/base/main", "/web/intro/intro", "/web/dic/dic", "/web/paperweight/paperweight", "/web/appointment/appointment", "/web/cs/board"]);
	
	// default로 메인
	return pageUrlList.get(menuNameList.indexOf(pageName)) ? pageUrlList.get(menuNameList.indexOf(pageName)) : pageUrlList.get(0);
}
	
</script>
	
<!-- 1.1. 헤더 -->
<header id="header">
	<!-- menuForm(페이지 이동시 사용) -->
	<form id='menuForm' name='menuForm' method='post'></form>
	
	<!-- actionForm (locale을 제외한 나머지는 메인에서만 사용됨) - 자신 페이지 호출 시 사용 -->
	<form id='actionForm' name='actionForm' method='post'>
		<!-- 메인페이지 내에서 리스트와 상세 모두 보기 위해서 해당 정보를 가지고 있음 -->
		<!-- ajax 처리인 경우에는 상관없지만 새로고침할 때 현재 화면 그대로 유지하기 위해서는 필수 -->
		<input type='hidden' name='contentsType'	value='<c:out value="${actionForm.contentsType}"	default="list" />' />	<!-- 리스트/상세 구분 -->
		<input type='hidden' name='subMenuIndex'	value='<c:out value="${actionForm.subMenuIndex}"	default="0" />' />		<!-- 서브 메뉴 탭 index -->
		<input type='hidden' name='listType'		value='<c:out value="${actionForm.listType}"		default="album" />' />	<!-- 리스트인 경우 리스트 형태 -->
		<input type='hidden' name='pageNo'			value='<c:out value="${actionForm.pageNo}"			default="1" />' />		<!-- 리스트인 경우 pageNo -->
		<input type='hidden' name='searchCondition'	value='<c:out value="${actionForm.searchCondition}"	default="" />' />		<!-- 리스트인 경우 검색 조건 -->
		<input type='hidden' name='searchKeyword'	value='<c:out value="${actionForm.searchKeyword}"	default="" />' />		<!-- 리스트인 경우 검색 키워드 -->
		<input type='hidden' name='contentsId'		value='<c:out value="${actionForm.contentsId}"		default="0" />' />		<!-- 메인화면 상세인 경우 상세 ID -->
		<input type='hidden' name='viewTabIdx'		value='<c:out value="${actionForm.viewTabIdx}"		default="0" />' />		<!-- 메인화면 상세인 경우 상세 탭 index -->
		<input type='hidden' name='locale'			value='' />	<!-- 언어 변경 시 화면을 다시 불러오는데 여기에 언어 정보를 입력해서 넘김 -->
	</form>
	
	<div class="inner-wrap">
		<h1 class="header-logo"><a href="javascript:void(0);"><img src="/resources/images/project/web/logo_<c:out value="${localeLanguage}" />.png" alt="<spring:message code='main.agent'/> <spring:message code='main.title'/>"></a></h1>
		<a id="m_MenuBtn"class="toggle-layer" href="#fullmenu"><strong class="sr-only"><spring:message code='text.menu'/></strong></a>
		<div id="fullmenu" class="gnb">
			<a class="gnb-item" href="javascript:void(0);"><spring:message code='main.menu.intro'/></a>
			<a class="gnb-item" href="javascript:void(0);"><spring:message code='main.menu.jejuomt'/></a>
			<a class="gnb-item" href="javascript:void(0);"><spring:message code='main.menu.onlinepw'/></a>
			<a class="gnb-item" href="javascript:void(0);"><spring:message code='main.menu.appmt'/></a>
			<a class="gnb-item" href="javascript:void(0);"><spring:message code='main.menu.cs'/></a>
		</div>
		<div class="lang-change">
			<label>
				<span class="sr-only">Language</span>
				<select class="min language">
					<option value='ko' <c:if test="${localeLanguage eq 'ko'}">selected='selected'</c:if>>한국어</option>
					<option value='en' <c:if test="${localeLanguage eq 'en'}">selected='selected'</c:if>>English</option>
					<option value='zh' <c:if test="${localeLanguage eq 'zh'}">selected='selected'</c:if>>中國</option>
					<option value='ja' <c:if test="${localeLanguage eq 'ja'}">selected='selected'</c:if>>日本</option>
					<option value='ru' <c:if test="${localeLanguage eq 'ru'}">selected='selected'</c:if>>русский</option>
				</select>
			</label>
           	<button type="button" class="btn min" style='cursor: pointer;' id="changeLanguage"><spring:message code='button.change'/></button>
		</div>
	</div>
</header>
<hr class="sr-only"><!-- css 미지원 모드에서 콘텐츠 구분선-->
<!--// 1.1. 헤더 END -->