<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!doctype html>
<html>
<head>
<title><spring:message code='main.menu.jejuomt'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<script type="text/javascript">

$(document).ready(function() {
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	// Toggle가능한 리스트 만들기
	$(document).on("click", ".detail-toggle .item-title", function() {
		//$(this).next().toggle();
		$(this).parent(".item").toggleClass("open");	
		$(this).children(".icon-btn").toggleClass("remove");	
		$(this).children(".icon-btn").toggleClass("more");	
		return false; //링크실행 방지
	});
	
	// 1차 카테고리 변경 시
	$(document).on("change", "select[name='category-1step']", function() {
		// 2차 카테고리 세팅
		setCategory($(this).val());
	});
	
	// 2차 카테고리 변경 시
	$(document).on("change", "select[name='category-2step']", function() {
		setContents();
	});
	
	// 1차 카테고리 세팅
	setCategory();
});

function setCategory(groupKey) {
	// ajax로 리스트 호출 후 세팅해준다.
	var data = new Object();
	
	groupKey = groupKey && groupKey > 0 ? groupKey : 0;
	data.groupKey = groupKey;
	
	$.ajax({
		url		: "/data/dic/categoryList",
		type 	: 'post',	
		data 	: data,
		success	: function(result) {
			var sb = new StringBuilder();
			
			if(result && result.length > 0) {
				var locale = "<c:out value="${localeLanguage}" />";
				
				for(var i=0; i<result.length; ++i) {
					var category = result[i];
					
					sb.Append("<option value='"+(groupKey == 0 ? category.groupKey : category.idx)+"'>"+category[locale+"Name"]+"</option>");
				}
			}
			
			if(groupKey == 0) {
				// 1뎁스
				$("select[name='category-1step']").html(sb.ToString());
				
				// 1뎁스 생성 후 첫번째 값으로 2뎁스 카테고리 호출
				setCategory($("select[name='category-1step']").val());
			} else {
				// 2뎁스
				$("select[name='category-2step']").html(sb.ToString());
				
				// 2뎁스 생성 후 첫번째 값으로 컨텐츠를 구성해준다.
				setContents();
			}
		}
	});
}

function setContents() {
	var categoryIdx	= $("select[name='category-2step']").val();
	var data		= new Object();
	
	// 카테고리 idx를 세팅한다.
	data["category.idx"] = categoryIdx;
	
	$.ajax({
		url		: "/data/dic/orientalMedicineList",
		type 	: 'post',
		data 	: data,
		success	: function(result) {
			var sb = new StringBuilder();
			
			if(result && result.length > 0) {
				var locale = "<c:out value="${localeLanguage}" />";
				
				for(var i=0; i<result.length; ++i) {
					var orientalMedicine = result[i];
					
					sb.Append("<li class='item'>");
					sb.Append("	<h4 class='item-title'>");
					sb.Append("		<span class='category-name' data-depth='1'>["+$("select[name='category-1step'] option:selected").text()+"]</span>");
					sb.Append("		<span class='category-name' data-depth='2'>["+$("select[name='category-2step'] option:selected").text()+"]</span>");
		     		sb.Append(		orientalMedicine[locale+"Title"]);
					sb.Append("		<a class='icon-btn more' href='javascript:void(0);'><span class='sr-only'></span></a>");
					sb.Append("	</h4>");
					sb.Append("	<div class='detail-view'>");
					sb.Append(		orientalMedicine[locale+"Text"]);
					sb.Append("	</div>");
					sb.Append("</li>");
					
				}
			}
			
			$(".item-list").html(sb.ToString());
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
			<a href="javascript:void(0);"><span><spring:message code='main.menu.jejuomt'/></span></a>
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
			<h2 class="sub-title"><spring:message code='main.menu.jejuomt'/></h2>
			<p><spring:message code='main.menu.explain.jejuomt'/></p>
		</div>
		<!-- 1.2.3.2 서브-본문 Tab 1 -->
		<div class="sub-body">
			<form class="category-form">
				<label for="category-1step" class="sr-only"></label>
				<select name="category-1step"></select>
				<label for="category-2step" class="sr-only"></label>
				<select name="category-2step"></select>
			</form>
			<ul class="item-list detail-toggle"></ul>
		</div><!--//.sub-body-->        
	</div><!--//.page-content-->
	<!--// 1.2.3 콘텐츠 END -->
	<!--// 1.2. 서브페이지 END -->
	
	<!-- 하단 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/footer.jsp"></jsp:include>
	
</div><!--//.page-->
<!--// 1.페이지 END -->
</body>
</html>