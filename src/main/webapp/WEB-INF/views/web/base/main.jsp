<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!doctype html>
<html>
<head>
<!-- 페이지 별로 타이틀 변경 -->
<title><spring:message code='main.title'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<!-- 구글 지도 추가 -->
<script async defer src ="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8gP_f2eZ7fIm6QOIRMYZrhzqDhwu6S-I&language=<c:out value="${localeLanguage}" />&callback=initMap"></script>

<script type="text/javascript">
var roughMap;

$(document).ready(function(){
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	// 서브 메뉴 클릭 시 
	$(document).on("click", ".main-tab li", function() {
		// 서브메뉴 탭을 on 시킨다. default로 0
		var idx = $(".main-tab li").index($(this)); 
		
		$(":hidden[name='subMenuIndex']").val(idx);		// 서브메뉴 클릭 시 해당 메뉴의 index를 세팅 
		$(":hidden[name='contentsType']").val("list");	// 서브메뉴 클릭 시 무조건 list로 호출
		
		// 서브메뉴 탭을 on 시킨다. default로 0
		$(".main-tab li").removeClass("on");
		$(".main-tab li").eq(idx).addClass("on");
		 
		setContentsList();
	});
	
	// 리스트 클릭 시 상세 페이지로 이동
	$(document).on("click", "#item-list .item", function() {
		var idx = $("#item-list .item").index($(this));
		
		// 먼저 클릭 한 리스트의 ID를 세팅
		$(":hidden[name='contentsId']").val($(":hidden[name='hiddenId']").eq(idx).val());
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("view");
		// 리스트에서 상세페이지로 이동할 경우 viewTabIdx 는 0으로 세팅 시킴
		$(":hidden[name='viewTabIdx']").val(0);

		// 상세 페이지 호출
		setContentsView();
	});
	
	// 지도에서 상세보기 클릭 시 상세 페이지로 이동
	$(document).on("click", "a[name='mapDetailView']", function() {
		var idx = $("a[name='mapDetailView']").index($(this));
		var targetList = new ArrayList(["jejuomt", "tourist", "stay", "restaurant"]);
		var contentsId = $(":hidden[name='mapHiddenId']").eq(idx).val();
		var target = $(":hidden[name='mapTarget']").eq(idx).val();
		
		// 서브메뉴 탭을 on 시킨다. default로 0
		$(".main-tab li").removeClass("on");
		$(".main-tab li").eq(targetList.indexOf(target)).addClass("on");
		// 서브 메뉴를 변경한다.
		$(":hidden[name='subMenuIndex']").val(targetList.indexOf(target));
		
		// 지도에서 상세 보기 하는 경우 pageNo를 1로 바꿔버림(pageNo가 다를수 있음)
		$(":hidden[name='pageNo']").val(1);
		// 지도에서 클릭한 컨텐츠 ID를 세팅
		$(":hidden[name='contentsId']").val(contentsId);
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("view");
		// 리스트에서 상세페이지로 이동할 경우 viewTabIdx 는 0으로 세팅 시킴
		$(":hidden[name='viewTabIdx']").val(0);
		
		// 상세 페이지 호출
		setContentsView();
	});
	
	// 상세 화면의 탭 클릭 시
	$(document).on("click", ".sub-header .tab-list li", function() {
		var idx = $(".sub-header .tab-list li").index($(this));

		// 변경 된 탭 정보를 지속적으로 저장해둔다.
		$(":hidden[name='viewTabIdx']").val(idx);
		
		// 기존 탭 메뉴와 내용을 안보이게 하고 선택 된 탭을 보이게 함.
		$(".sub-header .tab-list li").removeClass("on");
		$(".sub-body").removeClass("on");
		
		$(this).addClass("on");					// 선택한 탭에 on추가
		$(".sub-body").eq(idx).addClass("on");	// 해당 idx에 해당하는 본문 on 추가
		
		// 약도인 경우 이미 지정된 사이즈의 맵이 화면에 나오게 하기 위해 resize를 호출해준다. 설정 된 좌표를 가운데로 보여준다.
		if($(this).hasClass("Map")) {
			var lat = $("#roughMap").attr("data-lat");
			var lng = $("#roughMap").attr("data-lon");
			
			var uluru = {lat: Number(lat), lng: Number(lng)};
			
			google.maps.event.trigger(roughMap, "resize");
			
			roughMap.setOptions({
				center: uluru,
				zoom: 18
			});
		}
	});
	
	// 상세화면에서 목록으로 이동
	$(document).on("click", ".list_back", function() {
		var pageNo = $(":hidden[name='pageNo']").val();
		
		// 컨텐츠 타입을 list로 변경
		$(":hidden[name='contentsType']").val("list");
		
		// 상세 페이지 호출시 기존에 사용된 pageNo를 그대로 사용 함
		setContentsList(pageNo);
	});
	
	// 상세화면에서 예약하기 버튼 클릭 시
	$(document).on("click", ".appmt", function() {
		// header에 존재하는 페이지 함수 호출 
		actionPageTurning("appointment");
	});
	
	// 목록 보기와 앨범보기 버튼
	$(document).on("click", ".list-view-ctrl a:not(.view-search)", function() {
		var idx = $(".list-view-ctrl a").index($(this));
		
		$(".list-view-ctrl a:not(.view-search)").removeClass("on");
		$(this).addClass("on");
		
		if(idx == 0) {
			// 리스트 보기 인 경우 item-list의  gallery-view 클래스 삭제
			$("#item-list").removeClass("gallery-view");
			
			$(":hidden[name='listType']").val("list");
		} else {
			// 앨범보기 인 경우 item-list의  gallery-view 클래스 추가
			$("#item-list").addClass("gallery-view");
			
			$(":hidden[name='listType']").val("album");
		}
	});
	
	// 돋보기 버튼 클릭 시
	$(document).on("click", ".list-view-ctrl a.view-search", function() {
		$(".search-form").toggleClass('on');
		$(this).toggleClass('on');
		$("#searchKeyword").focus();
	});
	
	// 검색 버튼 클릭 시
	$(document).on("click", "#searchBtn", function() {
		// 검색키워드에서 포커스를 없앤다(2중 검색을 방지하기 위해)
		setContentsList(1, true);
	});
	
	// 검색키워드에서 엔터키 입력시
	$(document).on("keyup", "#searchKeyword", function(event) {
		if(event.keyCode == 13){
			$("#searchBtn").trigger("click");
		}
	});
	
	// 페이지 네비게이션 클릭 기능
	$(document).on("click", ".page-nav a", function() {
		var currPageNo = Number($(":hidden[name='pageNo']").val());		// 현재 페이지 번호
		var movePageNo = currPageNo;									// 이동할 페이지 번호	

		// 이전 버튼, 다음 버튼, 숫자 버튼 클릭 시
		if($(this).hasClass("prev")) {
			if($(this).hasClass("active")) {
				movePageNo = currPageNo - 1;
			}
		} else if($(this).hasClass("next")) {
			if($(this).hasClass("active")) {
				movePageNo = currPageNo + 1;
			}
		} else {
			movePageNo = $(this).attr("data-num");
		}

		// 현재 페이지와 이동할 페이지가 같지 않아야 처리
		if(currPageNo != movePageNo) {
			// 리스트를 다시 불러온다.
			setContentsList(movePageNo);
		}
	});
	
	// 최초 호출 시 메인 컨텐츠 세팅
	initMainContents();
});

/**
 * 아래부터는 메인 페이지 새로고침한 경우 메인 페이지 화면 구성을 위한 함수
 * 화면 구성 
 */
// 메인 페이지 화면을 생성한다. 메인 페이지 로드 시에만 사용 된다.
function initMainContents() {
	var subIndex = $(":hidden[name='subMenuIndex']").val();
	var contentsType = $(":hidden[name='contentsType']").val();
	var pageNo = $(":hidden[name='pageNo']").val();

	// 서브메뉴 탭을 on 시킨다. default로 서브메뉴 index가 0인 경우
	$(".main-tab li").removeClass("on");
	$(".main-tab li").eq(subIndex).addClass("on");
	
	// 메인 화면에 컨텐츠를 뿌려준다.
	if(contentsType == "list") {
		// default는 list 이며, list인 경우 list 화면을 보여준다.
		setContentsList(pageNo);
	} else {
		// view 화면인 경우
		setContentsView();
	}
}

// 리스트 화면 뿌려주기
function setContentsList(pageNo, isTest) {
	var subIndex = $(":hidden[name='subMenuIndex']").val();
	var listType = $(":hidden[name='listType']").val(); 
	var typeArr = ["J", "T", "R", "S"];
	var classArr = ["t_medi", "t_enjoy", "t_stay", "t_food"];
	var targetUrl = subIndex == 0 ? "/data/main/jejuomtList" : "/data/main/tourList";
	
	// 검색 처리 속도를 표시하기 위한 시작 시간
	var startDateTime = new Date();
	var endDateTime = null;
	
	// AJAX 통신 시 사용 될 데이터 저장 공간
	var data = new Object();
	
	// 리스트 호출 시 default는 1번 페이지 hidden에 저장해둔다.
	pageNo = pageNo && pageNo > 1 ? pageNo : 1;
	// 여기서 생성 된 pageNo를 히든에 저장시켜둠.. 언어 변경 시 해당 page를 그대로 유지하기 위해 저장
	$(":hidden[name='pageNo']").val(pageNo);
	
	// view 영역을 숨기고 list 영역을 보여줌
	$("#contents_view").hide();
	$("#contents_list").show();
	
	// 갤러리 형태 여부 설정
	if(listType == "list") {
		// 리스트 보기 인 경우 item-list의  gallery-view 클래스 삭제
		$(".list-view-ctrl .view-list").addClass("on");
		$("#item-list").removeClass("gallery-view");
	} else {
		// 앨범보기 인 경우 item-list의  gallery-view 클래스 추가
		$(".list-view-ctrl .view-album").addClass("on");
		$("#item-list").addClass("gallery-view");
	}
	
	// 공통 다국어 언어 세팅
	setMultiLanguage();
	
	// ajax로 넘길 데이터를 세팅함
	data.type = typeArr[subIndex];
	data.searchKeyword = $("#searchKeyword").val();
	data.numOfRows = 12;		// 12개씩 보여줌.. 3과 4의 최소공배수
	data.pageNo = pageNo;
	data.pagingYn = "Y";
	data.useYn = "Y";
	
	// ajax로 리스트 호출 후 세팅해준다.
	$.ajax({
		url		: targetUrl,
		type 	: 'post',	
		data 	: data,
		success	: function(result) {
			var sb = new StringBuilder();
			
			if(result.list && result.list.length > 0) {
				var dataList	= result.list;
				var pageNo		= result.pageNo		? result.pageNo		: 1;
				var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
				
				var locale = "<c:out value="${localeLanguage}" />";

				for(var i=0; i<dataList.length; ++i) {
					var dataInfo	= dataList[i];
					var productList = new Array();
					var productName = "TreatName";
					
					sb.Append("<li class='item'>");
					sb.Append("<input type='hidden' name='hiddenId' value='"+dataInfo.idx+"' />");
					sb.Append("	<a href='javascript:void(0);'>");
					sb.Append("		<div class='img'><img src='"+(dataInfo.attachFile ? ("/upload/"+dataInfo.attachFile.fileName) : "")+"' width='345' /></div>");
					sb.Append("		<div class='summary'>");
					sb.Append("			<span class='item-num marker-icon medi'>"+((pageNo-1)*numOfRows+(i+1))+"</span>");
					sb.Append("			<strong class='item-title'>"+dataInfo[locale+"Name"]+"</strong>");
					sb.Append("			<p class='item-tag-list'>");
					
					if(subIndex == 0) {
						// 한방의료관광인 경우
						productList = dataInfo.orientalProductList;
						productName = "TreatName";
					} else {
						// 그외
						productList = dataInfo.gubunList;
						productName = "Name";
					}
					
					if(productList && productList.length > 0) {
						for(var j=0; j<productList.length; ++j) {
							var productInfo = productList[j];
							
							sb.Append("				<span class='teg-item'>"+(productInfo[locale+productName] ? productInfo[locale+productName] : "")+"</span>");
						}
					}
					
					sb.Append("			</p>");
					sb.Append("			<ul class='item-info'>");
					sb.Append("				<li><strong class='icon addr'><spring:message code='text.addr'/></strong><span>"+dataInfo[locale+"Addr"]+"</span></li>");
					sb.Append("				<li><strong class='icon tel'><spring:message code='text.tel'/></strong><span>"+dataInfo.phone+"</span></li>");
					sb.Append("			</ul>");
					sb.Append("		</div>");
					sb.Append("	</a>");
					sb.Append("</li>");
				}
			}
			
			$("#item-list").html(sb.ToString());
			
			// 리스트 헤더에 이미지를 추가한다. 기존 클래스를 삭제하고 탭에 해당하는 이미지를 추가한다.
			for(var i=0; i<classArr.length; ++i) {
				$(".list-header").removeClass(classArr[i]);
			}
			$(".list-header").addClass(classArr[subIndex]);
			
			// 네비게이션 자동 생성(default 네비게이션)
			//var pagingNavigation = new PagingNavigation(result);
			//pagingNavigation.setNavigation($(".page-nav").get(0), setContentsList);
			
			setNavigation(result);
			
			// 조회 전에 종료 시간을 구한다.
			if(isTest) {
				var startDate	= "";
				var endDate		= "";

				startDate	= startDateTime.getFullYear()+"-"+leadingZeros(startDateTime.getMonth()+1)+"-"+leadingZeros(startDateTime.getDate())+" "
							+ leadingZeros(startDateTime.getHours())+":"+leadingZeros(startDateTime.getMinutes())+":"+leadingZeros(startDateTime.getSeconds())+"."+leadingZeros(startDateTime.getMilliseconds(),3);
				
				setTimeout(function() {
					endDateTime = new Date();
					endDate		= endDateTime.getFullYear()+"-"+leadingZeros(endDateTime.getMonth()+1)+"-"+leadingZeros(endDateTime.getDate())+" "
								+ leadingZeros(endDateTime.getHours())+":"+leadingZeros(endDateTime.getMinutes())+":"+leadingZeros(endDateTime.getSeconds())+"."+leadingZeros(endDateTime.getMilliseconds(),3);
					
					alert("시작일시 : "+startDate+"\n"
						 +"종료일시 : "+endDate+"\n\n"
						 +"실행시간(ms) : "+(endDateTime.getTime()-startDateTime.getTime())+"ms");
				}, 400);
			}
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}

// 상세 화면 뿌려주기
function setContentsView() {
	var subIndex = $(":hidden[name='subMenuIndex']").val();
	var targetArr = ["jejuomt", "tourist", "stay", "restaurant"];
	var targetUrl = (subIndex == 0) ? "/data/main/jejuomtInfo" : "/data/main/tourInfo";
	var contentsId = $(":hidden[name='contentsId']").val();
	var viewTabIdx = $(":hidden[name='viewTabIdx']").val();
	
	if(contentsId > 0) {
		// ajax data
		var data = new Object();
		
		// list 영역을 숨기고 view 영역을 보여줌
		$("#contents_list").hide();
		$("#contents_view").show();
		
		// 다국어 언어 세팅
		// setMultiLanguage();
		
		// ajax로 리스트 호출 후 세팅해준다.
		data.idx = contentsId;
		
		$.ajax({
			url		: targetUrl,
			type 	: 'post',	
			data 	: data,
			success	: function(result) {
				if(result) {
					var tabMenuSb = new StringBuilder();
					var contentSb = new StringBuilder();
					
					var medicineIdArr	= ["medi_intro", "medi_service", "medi_staff", "medi_image", "medi_map"];
					var medicineMenuArr = ["<spring:message code='tab.menu.intro'/>", "<spring:message code='tab.menu.medicineProduct'/>", "<spring:message code='tab.menu.staffProfile'/>", "<spring:message code='tab.menu.facilityImage'/>", "<spring:message code='tab.menu.map'/>"];
					var medicineTextArr = ["Intro", "MedicineProduct", "StaffProfile", "FacilityImage", "Map"];
					var otherMenuArr	= ["<spring:message code='tab.menu.intro'/>", "<spring:message code='tab.menu.facilityImage'/>", "<spring:message code='tab.menu.map'/>"];
					var otherTextArr	= ["Intro", "FacilityImage", "Map"];
					
					var itemTagView = "";
					var productList = new Array();
					var productName = "TreatName";
					
					var locale = "<c:out value="${localeLanguage}" />";
					
					if(subIndex == 0) {
						// 제주한방의료관광인 경우
						$("a.impt").show();				// 예약하기 버튼 보여줌
						
						productList = result.orientalProductList;
						productName = "TreatName";
						
						for(var i=0; i<medicineMenuArr.length; ++i) {
							tabMenuSb.Append("<li class='"+medicineTextArr[i]+"'><a href='javascript:void(0)' class='openTab'>"+medicineMenuArr[i]+"</a></li>");
							
							contentSb.Append("<div class='sub-body tab' id='"+medicineIdArr[i]+"'>");
							contentSb.Append("	<h3 class='sr-only'>"+medicineMenuArr[i]+"</h3>");
							
							if(i == 1) {
								// 의료상품인 경우
								if(productList && productList.length > 0) {
									contentSb.Append("	<div class='section-group'>");

									for(var j=0; j<productList.length; ++j) {
										var product = productList[j];

										contentSb.Append("		<section>");
										contentSb.Append("			<h4 class='item-title'>"+product[locale+"TreatName"]+"</h4>");
										contentSb.Append("			<div class='html-wrap'>"+product[locale+"TreatContents"]+"</div>");
										contentSb.Append("			<ul class='item-info sizeL'>");
										contentSb.Append("				<li><strong class='blit cal'><spring:message code='text.treatmentPeriod'/></strong><span>"+product[locale+"TreatTerm"]+"</span></li>");
										contentSb.Append("				<li><strong class='blit cash'><spring:message code='text.treatmentCost'/></strong><span>"+product[locale+"TreatCost"]+"</span></li>");
										contentSb.Append("			</ul>");
										contentSb.Append("		</section>");
									}
									
									contentSb.Append("	</div>");
								}
							} else {
								// 의료상품이 아닌 경우
								if(medicineTextArr[i] == "Map") {
									contentSb.Append("	<div class='html-wrap'><div class='api-map-wrap' id='roughMap' data-lon='"+result.lon+"' data-lat='"+result.lat+"'></div></div>");
								} else {
									contentSb.Append("	<div class='html-wrap'>"+result[locale+medicineTextArr[i]]+"</div>");
								}
								
								// 안내인 경우 추가
								if(i == 0) {						
									contentSb.Append("	<ul class='item-info sizeL center'>");
									contentSb.Append("		<li><strong class='icon addr'><spring:message code='text.addr'/></strong><span>"+result[locale+"Addr"]+"</span></li>");
									contentSb.Append("		<li><strong class='icon tel'><spring:message code='text.tel'/></strong><span>Tel."+result.phone+" / Fax."+result.fax+"</span></li>");
									contentSb.Append("	</ul>");
								}
							}
							
							contentSb.Append("</div>");
						}

					} else {
						// 그외 나머지
						$("a.impt").hide();				// 예약하기 버튼 숨김
						
						productList = result.gubunList;
						productName = "Name";
						
						for(var i=0; i<otherMenuArr.length; ++i) {
							tabMenuSb.Append("<li class='"+otherTextArr[i]+"'><a href='javascript:void(0)' class='openTab'>"+otherMenuArr[i]+"</a></li>");
							
							contentSb.Append("<div class='sub-body tab'>");
							contentSb.Append("	<h3 class='sr-only'>"+otherMenuArr[i]+"</h3>");
							
							if(otherTextArr[i] == "Map") {
								contentSb.Append("	<div class='html-wrap'><div class='api-map-wrap' id='roughMap' data-lon='"+result.lon+"' data-lat='"+result.lat+"'></div></div>");
							} else {
								contentSb.Append("	<div class='html-wrap'>"+result[locale+otherTextArr[i]]+"</div>");
							}
							
							// 안내인 경우 추가
							if(i == 0) {
								contentSb.Append("	<ul class='item-info  sizeL center'>");
								contentSb.Append("		<li><strong class='blit addr'><spring:message code='text.addr'/></strong><span>"+result[locale+"Addr"]+"</span></li>");
								contentSb.Append("		<li><strong class='blit tel'><spring:message code='text.tel'/></strong><span>Tel."+result.phone+" / Fax."+result.fax+"</span></li>");
								contentSb.Append("		<li><strong class='blit mail'><spring:message code='text.email'/></strong><span>"+result.email+"</span></li>");
								contentSb.Append("	</ul>");
								
								contentSb.Append("	<p class='item_site center'>");
								if(result.homepage)
									contentSb.Append("		<a class='site_ho' href='"+result.homepage+"' target='_blank' title='<spring:message code='text.homepage'/>'><span class='sr-only'><spring:message code='text.homepage'/></span></a>");
								if(result.facebook)
									contentSb.Append("		<a class='site_fb' href='"+result.facebook+"' target='_blank' title='<spring:message code='text.facebook'/>'><span class='sr-only'><spring:message code='text.facebook'/></span></a>");
								if(result.instargram)
									contentSb.Append("		<a class='site_in' href='"+result.instargram+"' target='_blank' title='<spring:message code='text.instargram'/>'><span class='sr-only'><spring:message code='text.instargram'/></span></a>");
								if(result.twitter)
									contentSb.Append("		<a class='site_tw' href='"+result.twitter+"' target='_blank' title='<spring:message code='text.twitter'/>'><span class='sr-only'><spring:message code='text.twitter'/></span></a>");
								if(result.kakao)
									contentSb.Append("		<a class='site_ks' href='"+result.kakao+"' target='_blank' title='<spring:message code='text.kakaostory'/>'><span class='sr-only'><spring:message code='text.kakaostory'/></span></a>");
								contentSb.Append("	</p>");
							}
							
							contentSb.Append("</div>");
						}
					}
					
					if(productList && productList.length > 0) {
						for(var i=0; i<productList.length; ++i) {
							var productInfo = productList[i];
							itemTagView += (productInfo[locale+productName] ? productInfo[locale+productName]+" " : "");
						}
					}
					
					$(".sub-title").html(result[locale+"Name"]);
					$(".item-tag-view").html(itemTagView);

					$(".sub-header .tab-list").html(tabMenuSb.ToString());
					$("#contents_view .tab-group").html(contentSb.ToString());
					
					$(".sub-header .tab-list li").eq(viewTabIdx).addClass("on");
					$(".sub-body").eq(viewTabIdx).addClass("on");
					
					// 약도 맵 생성
					createRoughMap();
				}
			}
		});
	} else {
		alert("<spring:message code='fail.common.select'/>");
	}
}

function setMultiLanguage() {
	var subIndex = $(":hidden[name='subMenuIndex']").val();
	var contentsType = $(":hidden[name='contentsType']").val();
	
	// defaut 제주한방의료관광
	var title		= "<spring:message code='main.sub.menu.jejuomt' />"
	var descript	= "<spring:message code='main.sub.explain.jejuomt' />";
	
	// index 별로 내용 변경
	if(subIndex == 1) {
		// 제주힐링관광지 
		title		= "<spring:message code='main.sub.menu.tourist' />";
		descript	= "<spring:message code='main.sub.explain.tourist' />";
	} else if(subIndex == 2) {
		title		= "<spring:message code='main.sub.menu.stay' />";
		descript	= "<spring:message code='main.sub.explain.stay' />";
	} else if(subIndex == 3) {
		title		= "<spring:message code='main.sub.menu.restaurant' />";
		descript	= "<spring:message code='main.sub.explain.restaurant' />";
	}
	
	// 언어별 설정
	if(contentsType == "list") {
		$(".list-title").html(title);
		$(".list-descript").html(descript);
	}
}

function setNavigation(obj) {
	var pageNo		= obj.pageNo		? obj.pageNo		: 1;
	var numOfRows	= obj.numOfRows		? obj.numOfRows 	: 10;
	var numOfNums	= obj.numOfNums		? obj.numOfNums 	: 10;
	var totalCount	= obj.totalCount	? obj.totalCount	: 0;
	var pagingYn	= obj.pagingYn		? obj.pagingYn		: "Y";

	var count = 0;
	// countOfNums ====> 네비게이션 숫자들의 총 수 total 136 이고 10개의 데이터를 보여준다면 네비게이션 숫자는 14가 됨.
	var countOfNums = (totalCount % numOfRows == 0) ? Math.floor(totalCount / numOfRows) : Math.floor(totalCount / numOfRows)+1;
	// countOfPaging ====> 네비게이션 숫자를 몇개씩 보여주는지에 따라 나오는 숫자 묶음의 갯수  네비게이션 숫자를 10개씩 보여준다면 14까지의 숫자를 보여주기 위해서 1이 됨. 10단위로 -1을 해서 0부터 시작함.
	var countOfPaging = (countOfNums % numOfNums == 0) ? Math.floor(countOfNums / numOfNums)-1 : Math.floor(countOfNums / numOfNums);
	// startNum ===> 현재 페이지가 보여지는 네비게이션 숫자의 처음 시작값 보통 10개씩 보여진다면 1 11 21 31 이렇게 보여짐.
	var startNum = ((pageNo % numOfNums == 0) ? Math.floor(pageNo / numOfNums)-1 : Math.floor(pageNo / numOfNums)) * numOfNums+1;
	// 화면에 보여줄 네비게이션 숫자 갯수
	var countNum = (startNum + numOfNums <= countOfNums) ? numOfNums : countOfNums-startNum+1;

	var sb = new StringBuilder();

	if(totalCount > 0) {
		sb.Append("<a class='prev"+((pageNo == 1) ? " disabled" : " active")+"' href='javascript:void(0);'>◀</a>");
		
		while(count++ < countNum) {
			sb.Append("<a data-num='"+startNum+"' class='num"+((pageNo == startNum) ? " on" : "")+"' href='javascript:void(0);'>"+startNum+"</a>");
			++startNum;
		}
		
		sb.Append("<a class='next"+((pageNo == countOfNums) ? " disabled" : " active")+"' href='javascript:void(0);'>▶</a>");
	}
	
	$(".page-nav").html(sb.ToString());
}

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
					sb.Append("	<input type='hidden' name='mapTarget' value='jejuomt' />");
					sb.Append("	<img class='info-img' src='"+(dataInfo.attachFile ? ("/upload/"+dataInfo.attachFile.fileName) : "")+"' width='345' />");
					sb.Append("	<h3>"+dataInfo[locale+"Name"]+"</h3>");
					sb.Append("	<ul class='item-info'>");
					sb.Append("		<li><strong class='sr-only'><spring:message code='text.addr' /></strong><span>"+dataInfo[locale+"Addr"]+"</span></li>");
					sb.Append("		<li><strong class='sr-only'><spring:message code='text.tel' /></strong><span>"+dataInfo.phone+"</span></li>");
					sb.Append("	</ul>");
					sb.Append("	<a class='btn-zoom' href='javascript:void(0);' name='mapDetailView'><spring:message code='text.detail' /></a>");
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

function createRoughMap() {
	var lat = $("#roughMap").attr("data-lat");
	var lng = $("#roughMap").attr("data-lon");
	
	var uluru = {lat: Number(lat), lng: Number(lng)};
	
	// 맵 생성
	roughMap = new google.maps.Map(document.getElementById('roughMap'), {
		center: uluru,
		zoom: 18
	});

	// 마커 생성
	var marker = new google.maps.Marker({
	    position : uluru,
	    map : roughMap
	});
}

</script>
</head>

<body>
<!-- 1.페이지 -->
<div class="page">
	<!-- 상단 메뉴 공통 -->
	<%-- <%@ include file="/WEB-INF/views/web/common/header.jsp" %> --%>
	<jsp:include page="/WEB-INF/views/web/common/header.jsp"></jsp:include>
	
	<!-- 1.2. 메인페이지 -->
    <!-- 1.2.1 지도 -->
	<div class="api-map-wrap" id="map"></div>
	
    <!-- 1.2.2 TAB -->
	<div class="main-tab">
		<ul class="tab-list">
			<li><a href="javascript:void(0);" class="blit t_medi openTab"><span><spring:message code='main.sub.menu.jejuomt'/></span></a></li>
			<li><a href="javascript:void(0);" class="blit t_enjoy openTab"><span><spring:message code='main.sub.menu.tourist'/></span></a></li>
			<li><a href="javascript:void(0);" class="blit t_stay openTab"><span><spring:message code='main.sub.menu.stay'/></span></a></li>
			<li><a href="javascript:void(0);" class="blit t_food openTab"><span><spring:message code='main.sub.menu.restaurant'/></span></a></li>
		</ul>
		<div class="cs-center self-toggle">
			<span class="label">Customer Center</span>
			<a href="tel:<spring:message code='customer.center.contact'/>"><spring:message code='customer.center.contact'/></a>
		</div>
	</div>

	<!-- 1.2.3 Tab -->
	<div class="tab-group" id='contents_list'>
		<!-- 1.2.3.1 Tab 1 -->
		<div class="contents tab on">
			<!--.list-header-->
			<div class="list-header blit">
				<h3 class="list-title"></h3>
				<p class="list-descript"></p>
				<div class="list-view-ctrl">
					<a href="javascript:void(0);" class="view-list"><span class="sr-only"></span></a>
					<a href="javascript:void(0);" class="view-album"><span class="sr-only"></span></a>
					<a href="javascript:void(0);" class="view-search"><span class="sr-only"><spring:message code='button.search'/></span></a>
				</div>
				<div class="search-form">
					<input type="text" id='searchKeyword' placeholder="<spring:message code='text.search'/>">
					<button type="button" class="btn" id='searchBtn' style='cursor: pointer;'><spring:message code='button.search'/></button>
				</div>
			</div><!--//.list-header-->
			<!-- list -->
			<ul class="item-list" id="item-list"></ul>
        	<!-- 리스트 푸터 영역 -->
			<!-- 페이지 네비게이션 -->
			<div class="page-nav"></div><!--//.page-nav-->
		</div><!--//.main-list#tab1-->
	</div><!-- //1.2.3 Tab -->
	<!--// 1.2. 메인페이지 END -->
	
	<!-- 1.2.3 contents -->
	<div class="contents" id='contents_view'>
		<!-- 1.2.3.1 서브-헤더 -->
		<div class="sub-header">
			<h2 class="sub-title"></h2>
			<p class="item-tag-view"></p>
			<ul class="tab-list"></ul>
		</div>
		<div class="tab-group"></div>
		
		<!--tab-footer-->
		<div class="tab-footer">
			<button class="btn list_back" style='cursor: pointer;'><span class="blit t_back"><spring:message code='button.list'/></span></button>
			<a class="btn impt appmt" href="javascript:void(0);"><span class="blit t_write"><spring:message code='main.menu.appmt'/></span></a>
		</div><!--//tab-footer-->
	</div><!--//.contents-->
  
  	<!-- 하단 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/footer.jsp"></jsp:include>

</div><!--//.page-->
</body>
</html>