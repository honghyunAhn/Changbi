<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!doctype html>
<html>
<head>
<title><spring:message code='main.menu.intro'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<script type="text/javascript">

$(document).ready(function(){
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	initContents();
});

function initContents() {
	// ajax로 리스트 호출 후 세팅해준다.
	var data = new Object();
	
	$.ajax({
		url		: "/data/intro/introInfo",
		type 	: 'post',	
		data 	: data,
		success	: function(result) {
			var sb = "";
			
			if(result && result.idx) {
				var locale = "<c:out value="${localeLanguage}" />";
				
				sb = result[locale+"Text"];
			}
				
			$(".sub-body").html(sb);
		}
	});
}

</script>

</head>
<body>
<!-- 1.페이지 -->
<div class="page">
  	<!-- 상단 메뉴 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/header.jsp"></jsp:include>
	
	<!-- 1.2. 서브페이지 -->
	<!-- 1.2.1 위치 -->
	<div class="page-location">
		<div class="inner-wrap">
			<a href="javascript:void(0);"><span class="icon nav_home">home</span></a>
			<span class="sr-only">&#62;</span>
			<a href="javascript:void(0);"><span><spring:message code='main.menu.intro'/></span></a>
		</div>
	</div><!--//.page-location-->
    
    <!-- 1.2.2 Top 이미지 -->
	<div class="page-img" style="background-image:url(/resources/images/project/web/sub/topimg_01.jpg)">
		<div class="cs-center self-toggle">
			<span class="label">Customer Center</span>
			<a href="tel:<spring:message code='customer.center.contact'/>"><spring:message code='customer.center.contact'/></a>
		</div>
	</div>
	
	<!-- 1.2.3 콘텐츠 -->
	<div class="contents">
		<!-- 1.2.3.1 서브-헤더 -->
		<div class="sub-header">
			<h2 class="sub-title"><spring:message code='main.menu.intro'/></h2>
			<p><spring:message code='main.menu.explain.intro'/></p>
		</div>
		<!-- 1.2.3.2 서브-본문 Tab 1 -->
		<div class="sub-body"></div><!--//.sub-body-->        
	</div><!--//.page-content-->
	<!--// 1.2.3 콘텐츠 END -->
	<!--// 1.2. 서브페이지 END -->

	<!-- 하단 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/footer.jsp"></jsp:include>
	
</div><!--//.page-->
<!--// 1.페이지 END -->
</body>
</html>