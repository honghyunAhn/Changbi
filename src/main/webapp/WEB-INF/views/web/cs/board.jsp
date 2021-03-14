<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!doctype html>
<html>
<head>
<title><spring:message code='main.menu.cs'/></title>

<!-- 리소스 공통 -->
<jsp:include page="/WEB-INF/views/web/common/resource.jsp"></jsp:include>

<script type="text/javascript">

$(document).ready(function() {
	// self-toggle (전화 클릭 시 이용)
	$(document).on("click", ".self-toggle", function(){
		$(this).toggleClass("on")
	});
	
	// 고객센터 서브 탭 클릭 시
	$(document).on("click", ".sub-header .tab-list li", function() {
		var idx = $(".sub-header .tab-list li").index($(this));
		var subMenuIndex = $(":hidden[name='subMenuIndex']").val();
		
		if(idx != subMenuIndex) {
			$(":hidden[name='subMenuIndex']").val(idx);
			
			setBoardContents();
		}
	});
	
	// 리스트 검색 버튼 클릭 시
	$(document).on("click", "#searchBtn", function() {
		// 검색 조건과 검색 키워드를 HIDDEN에 저장
		$(":hidden[name='searchCondition']").val($("#searchCondition").val());
		$(":hidden[name='searchKeyword']").val($("#searchKeyword").val());
		
		setContentsList();
	});
	
	// 리스트 검색키워드에서 엔터키 입력시
	$(document).on("keyup", "#searchKeyword", function(event) {
		if(event.keyCode == 13) {
			$("#searchBtn").trigger("click");
		}
	});
	
	// 리스트 제목 클릭 시
	$(document).on("click", "td.title", function() {
		var idx = $("td.title").index($(this));
		
		// 먼저 클릭 한 리스트의 ID를 세팅
		$(":hidden[name='contentsId']").val($(":hidden[name='hiddenId']").eq(idx).val());
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("view");

		// 페이지 호출
		setBoardContents();
	});
	
	// 리스트 페이지 네비게이션 클릭 기능
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
	
	// 상세 페이지에서 리스트 버튼 클릭 시
	$(document).on("click", "#listBtn", function() {
		// 컨텐츠 타입을 view로 변경
		$(":hidden[name='contentsType']").val("list");

		// 페이지 호출
		setBoardContents();
	});
	
	// 문의하기 버튼 클릭 시
	$(document).on("click", "#inquiryBtn", function() {
		var title	= $("input[name='title']").val();
		var writer	= $("input[name='writer']").val();
		var phone	= $("input[name='phone']").val();
		var email	= $("input[name='email']").val();
		var comment	= $("textarea[name='comment']").val();
		
		// 이메일 정규식
		var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if(!title) {
			alert("<spring:message code='validate.title.empty'/>.");
			$("input[name='title']").focus();
		} else if(!writer) {
			alert("<spring:message code='validate.writer.empty'/>.");
			$("input[name='writer']").focus();
		} else if(!phone) {
			alert("<spring:message code='validate.phone.empty'/>.");
			$("input[name='phone']").focus();
		} else if(!email) {
			alert("<spring:message code='validate.email.empty'/>.");
			$("input[name='email']").focus();
		} else if(!emailRegExp.test(email)) {
			alert("<spring:message code='validate.email.wrongExp'/>.");
			$("input[name='email']").focus();
		} else if(!comment) {
			alert("<spring:message code='validate.comment.empty'/>.");
			$("textarea[name='comment']").focus();
		} else {
			// 언어별로 타이틀과 문의내용을 저장시킨다.
			$("input[name$='Title']").val(title);
			$("input[name$='Comment']").val(comment);
			
			$.ajax({
				type		: "POST",
				url			: "/data/cs/noticeReg",
				data		: $("form[name='bbsForm']").serialize(),
				success		: function(result) {
					if(result && result.idx) {
						alert("<spring:message code='alert.reg.success'/>!!");
						
						$("form[name='bbsForm']").get(0).reset();
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
	
	// 화면 구성
	setBoardContents();
});

/**
 * 아래부터는 페이지 새로고침한 경우 페이지 화면 구성을 위한 함수
 * 화면 구성 
 */
// 페이지 화면을 생성한다. 페이지 로드 시에만 사용 된다.
function setBoardContents() {
	var subIndex = $(":hidden[name='subMenuIndex']").val();
	var contentsType = $(":hidden[name='contentsType']").val();
	var targetUrl = "/web/cs/include/inquiry";					// default로 문의하기

	$(".sub-header .tab-list li").removeClass("on");
	$(".sub-header .tab-list li").eq(subIndex).addClass("on");
	
	if(subIndex == 0) {
		// 공지사항인 경우
		if(contentsType == "list") {
			// default는 list 이며, list인 경우 list 화면을 보여준다.
			targetUrl = "/web/cs/include/noticeList";
		} else {
			// view 화면인 경우
			targetUrl = "/web/cs/include/noticeDetail";
		}
	}
	
	var data = new Object();
	
	// 상세 인 경우에만 해당 idx를 가지고 상세 정보 조회
	data.idx = $(":hidden[name='contentsId']").val();
	
	// ajax로 리스트 호출 후 세팅해준다.
	$.ajax({
		url		: targetUrl,
		type 	: 'post',	
		data 	: data,
		success	: function(targetView) {
			$(".sub-body").html(targetView);
		}
	});
}

//공지사항 리스트 화면 뿌려주기
function setContentsList(pageNo) { 
	var targetUrl = "/data/cs/noticeList";
	
	var data = new Object();
	
	// 리스트 호출 시 default는 1번 페이지 hidden에 저장해둔다.
	pageNo = pageNo && pageNo > 1 ? pageNo : 1;
	// 여기서 생성 된 pageNo를 히든에 저장시켜둠.. 언어 변경 시 해당 page를 그대로 유지하기 위해 저장
	$(":hidden[name='pageNo']").val(pageNo);

	// ajax로 넘길 데이터를 세팅함
	data.searchCondition = $("#searchCondition").val() ? $("#searchCondition").val() : "all";
	data.searchKeyword = $("#searchKeyword").val() ? $("#searchKeyword").val() : "";
	data.type = 'N';		// 공지사항
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
				var dataList = result.list;
				
				var locale = "<c:out value="${localeLanguage}" />";
				
				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
	
					sb.Append("<tr>");
					sb.Append("	<input type='hidden' name='hiddenId' value='"+dataInfo.idx+"' />");
					sb.Append("	<td class='num'>"+(result.totalCount-((result.pageNo-1)*result.numOfRows+i))+"</td>");
					sb.Append("	<td class='title' style='cursor: pointer;'>"+dataInfo[locale+"Title"]+"</td>");
					sb.Append("	<td class='writer'>"+dataInfo.writer+"</td>");
					sb.Append("	<td class='hit'>"+dataInfo.cnt+"</td>");
					sb.Append("	<td class='datetime'>"+dataInfo.regDate+"</td>");
					sb.Append("</tr>");
				}
			}
			
			$("table.bbs tbody").html(sb.ToString());
			
			// 네비게이션 자동 생성(default 네비게이션)
			//var pagingNavigation = new PagingNavigation(result);
			//pagingNavigation.setNavigation($(".page-nav").get(0), setContentsList);
			
			setNavigation(result);
		}
	});
}

// 리스트 이동 네비게이션 생성
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
			<a href="javascript:void(0);"><span><spring:message code='main.menu.cs'/></span></a>
			<!-- <span class="sr-only">&#62;</span>
			<a href="javascript:void(0);"><span>공지사항</span></a> -->
		</div>
	</div><!--//.page-location-->
    
	<!-- 1.2.2 Top 이미지 -->
	<div class="page-img" style="background-image:url(/resources/images/project/web/sub/topimg_04.jpg)">
		<div class="cs-center self-toggle">
			<span class="label">Customer Center</span>
			<a href="tel:<spring:message code='customer.center.contact'/>"><spring:message code='customer.center.contact'/></a>
		</div>
	</div>
	
	<!-- 1.2.3 콘텐츠 -->
	<div class="contents">
		<!-- 1.2.3.1 서브-헤더 -->
		<div class="sub-header">
			<h2 class="sub-title"><spring:message code='main.menu.cs'/></h2>
			<p><spring:message code='main.menu.explain.cs'/></p>
			<ul class="tab-list">
				<li><a href="javascript:void(0);"><spring:message code='text.notice'/></a></li>
				<li><a href="javascript:void(0);"><spring:message code='text.inquiry'/></a></li>
			</ul>
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