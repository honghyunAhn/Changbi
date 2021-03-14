<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!doctype html>
<html>
<head>
<title><spring:message code='main.menu.onlinepw'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<script type="text/javascript">

$(document).ready(function() {
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	// 온라인 문진 리스트 화면에서 문진을 선택한 경우
	$(document).on("click", "#paperweightList a", function() {
		var idx = $("#paperweightList a").index($(this));
		
		// 먼저 클릭 한 리스트의 ID를 세팅
		$(":hidden[name='contentsId']").val($(":hidden[name='hiddenId']").eq(idx).val());
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("view");

		// 온라인 문진 상세 페이지 변환
		setPaperWeightContents();
	});
	
	// 온라인 문진 상세에서 리스트 목록 버튼 클릭 시
	$(document).on("click", "#pwListBtn", function() {
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("list");

		// 온라인 문진 리스트 페이지 변환
		setPaperWeightContents();
	});
	
	// 온라인 문진 상세에서 문진 목록 이동버튼 클릭 시
	$(document).on("click", "#pwDetailBtn", function() {
		// 선택 된 ID를 변경 시킨다.
		var changeGubun = $("#paperweightList").val();
		
		if($(":hidden[name='gubun.idx']").val() != changeGubun) {
			var step = $("ul.step-nav>li.nav").index($("ul.step-nav>li.nav.on"));
			
			// 기존 IDX를 변경 한다.
			$(":hidden[name='gubun.idx']").val(changeGubun);
			
			// 헤더에 저장하는 contentsId도 변경 시켜준다.
			$(":hidden[name='contentsId']").val(changeGubun);
			
			// 서브헤더 상세 타이틀 변경
			$(".sub-detail-title").html($("#paperweightList option:selected").text());
			
			// 심화문진 섹션을 삭제하고, 현재 스텝이 심화문진인 경우에만 화면을 갱신한다. 
			$(".sub-body.tab").eq(2).find(".section-group>section").remove();
			
			if(step == 2) {
				setPaperWeight(2);
			}
		}
	});
	
	// 온라인 문진 상세에서 다음 버튼 클릭 시
	$(document).on("click", "#pageNextBtn", function() {
		var step = $("ul.step-nav>li.nav").index($("ul.step-nav>li.nav.on"));

		if(step != 2) {
			// 심화문진이 아닌경우에는 다음 페이지를 불러온다.
			$("ul.step-nav>li.nav").eq(step+1).trigger("click");
		} else {
			if(isMedicalExamValidate()) {
				// 섹션 안의 체크박스 및 라디오 버튼 선택 된 내용을 html 태그에 넣어준다.
				$(".section-group>section :checkbox:checked,:radio:checked").attr("checked", "checked");
				
				$(":hidden[name='commonText']").val($("#pw_basic .section-group").html());
				$(":hidden[name='examText']").val($("#pw_deep .section-group").html());

				$.ajax({
					type		: "POST",
					url			: "/data/medicalExam/medicalExamLogReg",
					data		: $("form[name='paperweightForm']").serialize(),
					success		: function(result) {
						if(result && result.idx) {
							alert("<spring:message code='alert.reg.success'/>!!");
							
							// 리스트 화면으로 이동
							$("#pwListBtn").trigger("click");
						} else {
							alert("<spring:message code='alert.reg.failure'/>!! retry!!");
						}
					},
					error		: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
			}
		}
	});
	
	// 섹션 다음 버튼 클릭 시
	$(document).on("click", "#nextBtn", function() {
		var idx = $("ul.step-nav>li.nav ul>li").index($("ul.step-nav>li.nav ul>li.on"));

		$("ul.step-nav>li.nav ul>li").eq(idx+1).trigger("click");
	});
	
	// 섹션 이전 버튼 클릭 시
	$(document).on("click", "#prevBtn", function() {
		var idx = $("ul.step-nav>li.nav ul>li").index($("ul.step-nav>li.nav ul>li.on"));
		
		$("ul.step-nav>li.nav ul>li").eq(idx-1).trigger("click");
	});
	
	// 온라인 문진 상세에서 상단 스텝 네비게이션 동작
	$(document).on("click", "ul.step-nav>li.nav", function() {
		var step = $("ul.step-nav>li.nav").index($(this));
		
		if(step == 0 || (step != 0 && isMedicalExamValidate())) {
			// 심화문진인 경우 공통문진이 생성 되고 넘어와야 함.
			if(step == 2 && $("#pw_basic .section-group>section").size() == 0) {
				alert("<spring:message code='alert.next.failure'/>!!");
			} else {
				// 서브 바디 탭 화면 바꾸기.
				$("div.sub-body.tab").removeClass("on");
				$("div.sub-body.tab").eq(step).addClass("on");
				
				// 스텝 네비 변경 및 섹션 삭제
				$("ul.step-nav li.nav").removeClass("on");
				$("ul.step-nav li.nav").eq(step).addClass("on");
				
				// 문진 정보를 세팅한다.
				setPaperWeight(step);
			}
		}
	});
	
	// 문진 네비게이션 중에 섹션 선택 버튼 클릭 시
	$(document).on("click", "ul.step-nav>li.nav ul>li", function(e) {
		var step = $("ul.step-nav>li.nav").index($("ul.step-nav>li.nav.on"));
		var idx	= $("ul.step-nav>li.nav ul>li").index($(this));
		var sectionCount = $(".sub-body.tab").eq(step).find(".section-group>section").size();

		// 섹션 네비 변경
		$("ul.step-nav>li.nav ul>li").removeClass("on");
		$(this).addClass("on");
		
		// 섹션 바디 변경
		$(".sub-body.tab").eq(step).find(".section-group>section").removeClass("on");
		$(".sub-body.tab").eq(step).find(".section-group>section").eq(idx).addClass("on");
		
		// 하단 버튼 변경
		$("#prevBtn").hide();
		$("#nextBtn").hide();
		$("#pageNextBtn").hide();
		// 클릭된 idx가 마지막인 경우 다음 버튼 생성 / idx가 마지막이 아닌 경우 next 버튼 생성 / idx가 0보다 크면 prev 버튼 생성
		if(idx == sectionCount-1) {
			$("#pageNextBtn").show();
		}
		if(idx < sectionCount-1) {
			$("#nextBtn").show();
		}
		if(idx > 0) {
			$("#prevBtn").show();
		}
		
		// 현재 버튼의 부모 객체의 클릭 이벤트가 적용 안되도록 함.
		// 온라인 문진 상세에서 상단 스텝 네비게이션 동작하지 않도록 함.
		cancelBubble(e);
	});
	
	// 최초 호출
	setPaperWeightContents();
});

// 온라인 문진 화면 구성 함수
function setPaperWeightContents() {
	var contentsType = $(":hidden[name='contentsType']").val();
	var targetUrl = "/web/paperweight/include/paperweightDetail";
	
	var data = new Object();
	
	if(contentsType == "list") {
		// default는 list 이며, list인 경우 list 화면을 보여준다.
		targetUrl = "/web/paperweight/include/paperweightList";
	}
	
	// 온라인 문진 상세 화면인 경우 IDX를 이용하여 선택 된 진료과목을 가져온다.
	data.idx = $(":hidden[name='contentsId']").val();

	// ajax로 리스트 호출 후 세팅해준다.
	$.ajax({
		url		: targetUrl,
		type 	: 'post',	
		data 	: data,
		success	: function(targetView) {
			$(".contents").html(targetView);
		}
	});
}

// 온라인 문진 구성
function setPaperWeight(step) {
	var targetUrl = "/data/medicalExam/medicalExam";
	
	var data = new Object();
	
	data.type = ( step == 2 ) ? "E" : "O";
	data["gubun.idx"] = $(":hidden[name='gubun.idx']").val();
	data.useYn = "Y";
	
	// 스텝이 기본정보가 아니고 섹션 그룹의 섹션이 존재하지 않으면 생성 시킴
	if(step != 0 && $(".sub-body.tab").eq(step).find(".section-group>section").size() == 0) {
		// ajax로 리스트 호출 후 세팅해준다.
		$.ajax({
			url		: targetUrl,
			type 	: 'post',	
			data 	: data,
			success	: function(result) {
				var locale = "<c:out value="${localeLanguage}" />";
				
				// 현재 스텝 구성
				$(".sub-body.tab").eq(step).find(".section-group").html(result[locale+"Text"]);
				
				setStepSection(step);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	} else {
		// 스텝의 섹션 갯수 세팅 및 첫번째 섹션 선택 하도록 함.
		setStepSection(step);
	}
}

// 스텝 네비에 섹션 추가
function setStepSection(step) {
	var sb = new StringBuilder();
	var sectionCount = $(".sub-body.tab").eq(step).find(".section-group>section").size();
	
	// 기존 섹션 네비 삭제
	$("ul.step-nav li.nav ul").remove();
	
	// 섹션이 1개 이상 존재할 경우 섹션 네비 생성
	if(sectionCount > 0) {
		sb.Append("<ul class='tab-list byStep center'>");
		
		for(var i=0; i<sectionCount; ++i) {
			sb.Append("<li class='"+(i == 0 ? "on" : "")+"'><a href='javascript:void(0);' class='step-change skip'>"+(i+1)+"</a></li>");
		}
		
	  	sb.Append("</ul>");
	  	
	 	// 상단 네비게이션에 섹션별 번호 부여
	  	$("ul.step-nav li.nav").eq(step).append(sb.ToString());
	  	
	 	// 섹션 바디 변경(스텝 변경시에는 무조건 첫번째 섹션으로 변경
		$(".sub-body.tab").eq(step).find(".section-group>section").removeClass("on");
		$(".sub-body.tab").eq(step).find(".section-group>section").eq(0).addClass("on");
	}
  	
 	// 다음 스텝 버튼 명칭 변경 및 스텝 섹션 이동 버튼 안보이게 하기
	$("#prevBtn").hide();
	$("#nextBtn").hide();
	$("#pageNextBtn").hide();
	$("#pageNextBtn").text((step != 2) ? "<spring:message code='button.next'/>" : "<spring:message code='button.submit'/>");
	
  	// 섹션 카운터가 1보다 큰 경우 next 섹션 버튼 보이게 함
  	if(sectionCount > 1) {
  		$("#nextBtn").show();
  	} else {
  		$("#pageNextBtn").show();
  	}
}

// 폼 안에 내용 validate
function isMedicalExamValidate() {
	var isValidate = false;
	
	// 심화문진인 경우 해당 내용을 DB에 저장한다.
	var age		= $("input[name='age']").val();
	var name	= $("input[name='name']").val();
	var phone	= $("input[name='phone']").val();
	var email	= $("input[name='email']").val();
	
	// 이메일 정규식
	var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	if(!age) {
		alert("<spring:message code='validate.age.empty'/>.");
		$("input[name='age']").focus();
	} else if(!name) {
		alert("<spring:message code='validate.name.empty'/>.");
		$("input[name='name']").focus();
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
		isValidate = true;
	}
	
	return isValidate;
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
			<a href="#"><span class="icon nav_home">home</span></a>
			<span class="sr-only">&#62;</span>
			<a href="#"><span><spring:message code='main.menu.onlinepw'/></span></a>
		</div>
	</div><!--//.page-location-->
	<!-- 1.2.2 Top 이미지 -->
	<div class="page-img" style="background-image:url(/resources/images/project/web/sub/topimg_02.jpg)">
		<div class="cs-center self-toggle">
			<span class="label">Customer Center</span>
			<a href="tel:<spring:message code='customer.center.contact'/>"><spring:message code='customer.center.contact'/></a>
		</div>
	</div>
	
	<!-- 1.2.3 콘텐츠 -->
	<div class="contents"></div><!--//.page-content-->
	<!--// 1.2.3 콘텐츠 END -->
	<!--// 1.2. 서브페이지 END -->

	<!-- 하단 공통 -->
	<jsp:include page="/WEB-INF/views/web/common/footer.jsp"></jsp:include>
	
</div><!--//.page-->
<!--// 1.페이지 END -->
  </body>
</html>