<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"		prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt"		prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags"	prefix="spring" %>

<!-- 오늘날짜 세팅 -->
<jsp:useBean id="today" class="java.util.Date" />

<!doctype html>
<html>
<head>
<title><spring:message code='main.menu.appmt'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<!-- 모달 관련 css 추가 -->
<link rel="stylesheet" href="/resources/css/project/web/modal.css" />

<!-- 구글 지도 추가 -->
<script async defer src ="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8gP_f2eZ7fIm6QOIRMYZrhzqDhwu6S-I&language=<c:out value="${localeLanguage}" />"></script>

<script type="text/javascript">

$(document).ready(function() {
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	// 맵 버튼 클릭 시 모달
	$(document).on("click", "#open_map", function() {
		$("#modal_map").modal({
	    	overlayClose:true,
			opacity:80,
			overlayCss: {backgroundColor:"#000"}
	 	});
		
		initMap();
	});
	
	// 모달 클로즈 버튼 클릭 시
	$(document).on("click", ":button[name='modal_close']", function(){
		$.modal.close();
	});
	
	// 지도에서 상세보기 클릭 시 상세 페이지로 이동
	$(document).on("click", "a[name='mapSelectOriental']", function() {
		var idx = $("a[name='mapSelectOriental']").index($(this));
		var orientalId = $(":hidden[name='mapHiddenId']").eq(idx).val();
		
		// 한의원 선택
		$("select[name='oriental.idx']").val(orientalId);
		
		$.modal.close();
	});
	
	// 예약하기 버튼 클릭 시
	$(document).on("click", "#app_btn", function() {
		var bookingDate	= $("input[name='bookingDate']").val();
		var bookingHour	= $("input[name='bookingHour']").val();
		var name		= $("input[name='name']").val();
		var phone		= $("input[name='phone']").val();
		var email		= $("input[name='email']").val();
		var langSize	= $(":checkbox[name='langChk']:checked").size();
		
		// 이메일 정규식
		var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if(!bookingDate) {
			alert("<spring:message code='validate.date.empty'/>.");
			$("input[name='bookingDate']").focus();
		} else if(!bookingHour) {
			alert("<spring:message code='validate.time.empty'/>.");
			$("input[name='bookingHour']").focus();
		} else if(!name) {
			alert("<spring:message code='validate.name.empty'/>.");
			$("input[name='name']").focus();
		} else if(langSize == 0) {
			alert("<spring:message code='validate.language.empty'/>.");
		} else if(!phone) {
			alert("<spring:message code='validate.phone.empty'/>.");
			$("input[name='phone']").focus();
		} else if(!email) {
			alert("<spring:message code='validate.email.empty'/>.");
			$("input[name='email']").focus();
		} else if(!emailRegExp.test(email)) {
			alert("<spring:message code='validate.email.wrongExp'/>.");
			$("input[name='email']").focus();
		} else {
			var lang = "";
			
			// 사용가능 언어를 컴마 형태로 변경 시킨다.
			$(":checkbox[name='langChk']:checked").each(function() {
				lang += $(this).val()+",";
			});
			
			// 히든에 컴마 형태로 저장시킨다.
			$(":hidden[name='lang']").val(lang.substring(0, lang.length-1));

			$.ajax({
				type		: "POST",
				url			: "/data/appointment/appointmentReg",
				data		: $("form[name='appForm']").serialize(),
				success		: function(result) {
					if(result && result.idx) {
						alert("<spring:message code='alert.reg.success'/>.");
						
						$("form[name='appForm']").get(0).reset();
					} else {
						alert("<spring:message code='alert.reg.failure'/>!! retry!!");
					}
				},
				error		: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
});

function initMap() {
	// 중심 좌표 도청
	var uluru = {lat: 33.488833, lng: 126.498079};
	//var uluru = {lat: -34.397, lng: 150.644};
	// 맵 생성 후 마커 생성
	var targetUrl = "/data/main/jejuomtList";
	// ajax 데이터
	var data = new Object();
	
	// 맵 생성
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 13,
		center: uluru
	});
	
	// 윈도우 창 생성(1개만 존재)
	var infowindow = new google.maps.InfoWindow();
	
	// 맵 클릭 시 윈도우 창 닫기
	map.addListener('click', function() {
		infowindow.close();
    });
	
	// ajax로 넘길 데이터를 세팅함
	data.pagingYn = "N";
	data.useYn = "Y";
	
	// ajax로 리스트 호출 후 세팅해준다.
	$.ajax({
		url		: targetUrl,
		type 	: 'post',
		data 	: data,
		success	: function(result) {
			if(result.list && result.list.length > 0) {
				var dataList = result.list;
				var sbList = new Array();
				var markerList = new Array();
				
				var locale = "<c:out value="${localeLanguage}" />";
				
				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var sb = new StringBuilder();
					var marker = null;
					
					sb.Append("<div class='map-info-window'>");
					sb.Append("	<input type='hidden' name='mapHiddenId' value='"+dataInfo.idx+"' />");
					sb.Append("	<img class='info-img' style='max-width: 160px; max-height: 160px;' src='/resources/images/project/web/imsi/hospitel.jpg'>");
					//sb.Append("	<img class='info-img' src='"+dataInfo.attachFile.fileSubpath+"/"+dataInfo.attachFile.fileName+"' width='345' />");
					sb.Append("	<h3>"+dataInfo[locale+"Name"]+"</h3>");
					sb.Append("	<ul class='item-info'>");
					sb.Append("		<li><strong class='sr-only'><spring:message code='text.addr'/></strong><span>"+dataInfo[locale+"Addr"]+"</span></li>");
					sb.Append("		<li><strong class='sr-only'><spring:message code='text.tel'/></strong><span>"+dataInfo.phone+"</span></li>");
					sb.Append("	</ul>");
					sb.Append("	<a class='btn-zoom' href='javascript:void(0);' name='mapSelectOriental'><spring:message code='button.confirm'/></a>");
					sb.Append("</div>");
					
					// 마커 생성
					marker = new google.maps.Marker({
					    position : new google.maps.LatLng(dataInfo.lat, dataInfo.lon),
					    title : dataInfo[locale+"Name"],
					    map : map
					});
					
					sbList[i] = sb.ToString();
					markerList[i] = marker;
					
					marker.addListener('click', function() {
						var markerIdx = 0;
						
						for(var j=0; j<markerList.length; ++j) {
							if(markerList[j] == this) {
								markerIdx = j;
								break;
							}
						}
						
						infowindow.setContent(sbList[markerIdx]);
						infowindow.open(map, this);
			        });
				}
			}
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
			<a href="javascript:void(0);"><span><spring:message code='main.menu.appmt'/></span></a>
		</div>
	</div><!--//.page-location-->
    
	<!-- 1.2.2 Top 이미지 -->
	<div class="page-img" style="background-image:url(/resources/images/project/web/sub/topimg_03.jpg)">
		<div class="cs-center self-toggle">
			<span class="label">Customer Center</span>
			<a href="tel:<spring:message code='customer.center.contact'/>"><spring:message code='customer.center.contact'/></a>
		</div>
	</div>
	
	<!-- 1.2.3 콘텐츠 -->
	<div class="contents">
		<!-- 1.2.3.1 서브-헤더 -->
		<div class="sub-header">
			<h2 class="sub-title"><spring:message code='main.menu.appmt'/></h2>
			<p><spring:message code='main.menu.explain.appmt'/></p>
		</div>
		<!-- 1.2.3.2 서브-본문 Tab 1 -->
		<div class="sub-body">
			<form class="bbs-form" name='appForm'>
				<input type='hidden' name='lang' />
				
				<p class="row-group">
					<label for="oriental.idx">
						<strong class="row-group-label"><spring:message code='text.orientalMedicalClinic'/></strong>
					</label>
					<select name="oriental.idx">
						<c:forEach items="${jejuomtList}" var="jejuomt" varStatus="status">
						<option value="${jejuomt.idx}" <c:if test="${jejuomt.idx eq selectOriental}">selected='selected'</c:if>><c:out value="${jejuomt.getName(localeLanguage)}" /></option>
						</c:forEach>
					</select>
					<button type='button' class="btn line" style='cursor: pointer;' id='open_map'><spring:message code='text.map'/></button>
				</p>
				<p class="row-group">
					<label for="bookingDate">
						<strong class="row-group-label"><spring:message code='text.appDateTime'/></strong>
					</label>
					<input type="date" name="bookingDate" type="text" value='<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />' placeholder='<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />'>
					<select name='bookingAmpm'>
						<option value='am'><spring:message code='text.morning'/></option>
						<option value='pm'><spring:message code='text.afternoon'/></option>
					</select>
					<input type="text" name='bookingHour' placeholder="10:30" maxlength="5">
				</p>
				<p class="row-group">
					<label>
						<strong class="row-group-label"><spring:message code='text.treatExam'/></strong>
						<select name="medicalGubun.idx">
							<c:forEach items="${examList}" var="exam" varStatus="status">
							<option value="${exam.idx}"><c:out value="${exam.getName(localeLanguage)}" /></option>
							</c:forEach>
						</select>
					</label>
				</p>
				<p class="row-group">
					<strong class="row-group-label"><spring:message code='text.appInfo'/></strong>
					<select name="countryGubun.idx">
						<c:forEach items="${nationList}" var="nation" varStatus="status">
						<option value="${nation.idx}"><c:out value="${nation.getName(localeLanguage)}" /></option>
						</c:forEach>
					</select>
					<input type="text" name='name' placeholder="<spring:message code='text.name'/>">
              	</p>
				<p class="row-group multi">
					<strong class="row-group-label"><spring:message code='text.useLang'/></strong>
					<c:forEach items="${languageList}" var="language" varStatus="status">
					<label><input type="checkbox" name='langChk' value='<c:out value="${language.idx}" />'><c:out value="${language.getName(localeLanguage)}" /></label>
					</c:forEach>
				</p>
				<p class="row-group">
					<label>
						<strong class="row-group-label"><spring:message code='text.tel'/></strong>
						<input type="tel" name='phone' placeholder="<spring:message code='text.phone'/>">
					</label>
				</p>
				<p class="row-group">
					<label>
						<strong class="row-group-label"><spring:message code='text.email'/></strong>
						<input type="email" name='email' placeholder="<spring:message code='text.email'/>">
					</label>
				</p>
				<p class="row-group">
					<label>
						<strong class="row-group-label"><spring:message code='text.comment'/></strong>
						<textarea rows="10" cols="30" name='comment' placeholder="<spring:message code='text.comment'/>"></textarea>
					</label>
				</p>
				<div class="bbs-footer">
					<button type='button' class="btn impt" id='app_btn'><spring:message code='main.menu.appmt'/></button>
				</div> 
			</form>
		</div><!--//.sub-body#tab2-->
	</div><!--//.content-->
	<!--// 1.2.3 콘텐츠 END -->
	<!--// 1.2. 서브페이지 END -->
	
	<!-- 하단 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/footer.jsp"></jsp:include>
	
</div><!--//.page-->
<!--// 1.페이지 END -->

<!-- 지도 모달 -->
<div id="modal_map">
	<div class="wrap">
		<button type="button" class="ic close" name='modal_close'></button>
		<div class="api-map-wrap" id="map"></div>
	</div>
</div>
<!-- //지도 모달 -->

</body>
</html>