<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>기수 조회 팝업</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/course/trainProcessList' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".popup_pagination"));
	
	/**    LMS  대중소분류 검색      **/
	var data;
	$.ajax({
		type	: "post",
		url		: "<c:url value='/forFaith/base/cateCodeList' />",
		async : false,
		success	: function(result) {
			data=result;
// 			$("#bigSelect").append('<option value="">대분류선택</option>');
// 			for(var i=0;i<result.length;i++){
				
// 				$("#bigSelect").append('<option value="'+result[i].code+'">'+result[i].name+'</option>');
			
			}
	});
	
	// 상세페이지에서 list로 돌아왔을 경우 분류값을 selectbox에 세팅
	function setCourseCode(){
		if('${search.subCourseCode.parentCode.code}' != '' &&  '${search.subCourseCode.parentCode.code}' != null) {
				$("#bigSelect").append('<option value="">대분류선택</option>');
				$("#middleSelect").append('<option value="">중분류선택</option>');
				$("#smallSelect").append('<option value="">소분류선택</option>');
				
			for(var i=0;i<data.length;i++){
				
				$("#bigSelect").append('<option value="'+ data[i].code+'">'+data[i].name+'</option>');
				
				if(data[i].code=='${search.subCourseCode.parentCode.code}'){
					
					for(var j=0;j<data[i].childCodeList.length;j++){
						
						$("#middleSelect").append('<option value="'+data[i].childCodeList[j].code+'">'+data[i].childCodeList[j].name+'</option>');
						
						if(data[i].childCodeList[j].code=='${search.subCourseCode.code}'){
							
							for(var k=0;k<data[i].childCodeList[j].childCodeList.length;k++){
								
								$("#smallSelect").append('<option value="'+data[i].childCodeList[j].childCodeList[k].code+'">'+data[i].childCodeList[j].childCodeList[k].name+'</option>');
							}
						}
					}
				}
			}
			
			$("#bigSelect option").each(function(index, item){
				if($(item).val() == '${search.subCourseCode.parentCode.code}'){
					$("#bigSelect").val($(item).val()).prop("selected",true);
				}
			});
			
			$("#middleSelect option").each(function(index, item){
				if($(item).val() == '${search.subCourseCode.code}'){
					$("#middleSelect").val($(item).val()).prop("selected",true);
				}
			});
			
			$("#smallSelect option").each(function(index, item){
				if($(item).val() == '${search.courseCode.code}'){
					$("#smallSelect").val($(item).val()).prop("selected",true);
				}
			});
		} else {
			$("#bigSelect").append('<option value="">대분류선택</option>');
			for(var i=0;i<data.length;i++){
				$("#bigSelect").append('<option value="'+data[i].code+'">'+data[i].name+'</option>');
			}
		}
	}
	
	setCourseCode();
	
	$("#bigSelect").change(function(){
		$("#middleSelect").html("");
		$("#smallSelect").html("");
		for(var i=0;i<data.length;i++){
			if(data[i].code==$("#bigSelect option:selected").val()){
				$("#middleSelect").append('<option value="">중분류선택</option>');
				for(var j=0;j<data[i].childCodeList.length;j++){

					$("#middleSelect").append('<option value="'+data[i].childCodeList[j].code+'">'+data[i].childCodeList[j].name+'</option>');
					$("#big").val($("#bigSelect option:selected").html());
					
				}
			}
		}
		$("#parentSubCourseCode").val($("#bigSelect option:selected").val());
	});
	
	$("#middleSelect").change(function(){
		$("#smallSelect").html("");
		for(var i=0;i<data.length;i++){
			
			for(var j=0;j<data[i].childCodeList.length;j++){
				
				if(data[i].childCodeList[j].code==$("#middleSelect option:selected").val()){
					$("#smallSelect").append('<option value="">소분류선택</option>');
					for(var k=0;k<data[i].childCodeList[j].childCodeList.length;k++){
						
						$("#smallSelect").append('<option value="'+data[i].childCodeList[j].childCodeList[k].code+'">'+data[i].childCodeList[j].childCodeList[k].name+'</option>');
						
					}
				} 
			}
		}
		$("#subCourseCodecode").val($("#middleSelect option:selected").val());
	});
	
	$("#smallSelect").change(function(){
		var name="";
		$("#courseCodecode").val($("#smallSelect option:selected").val());
	});
	
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		/**LMS 검색창 처리**/
		$.ajax({
			type	: "post",
			url		: listUrl,
			async : false,
			data 	: $("form[name='popupSearchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='popupId' value='"+dataInfo.id+"' />");
						sb.Append("	<input type='hidden' name='popupName' value='"+dataInfo.name+"' />");
						sb.Append("	<input type='hidden' name='popupLearnTypes' value='"+dataInfo.learnTypes+"' />");
						sb.Append("	<input type='hidden' name='popupCredit' value='"+dataInfo.credit+"' />");
						sb.Append("	<input type='hidden' name='popupSelpPeriod' value='"+dataInfo.selpPeriod+"' />");
						sb.Append("	<input type='hidden' name='popupPrice' value='"+dataInfo.price+"' />");
						sb.Append("	<input type='hidden' name='popupMainBookId' value='"+dataInfo.mainBook.id+"' />");
						sb.Append("	<input type='hidden' name='popupSubBookId' value='"+dataInfo.subBook.id+"' />");
						sb.Append("	<input type='hidden' name='popupMainPrice' value='"+dataInfo.mainPrice+"' />");
						sb.Append("	<input type='hidden' name='popupSubPrice' value='"+dataInfo.subPrice+"' />");
						sb.Append("	<input type='hidden' name='popupCompleteTime' value='"+dataInfo.completeTime+"' />");
						sb.Append("	<input type='hidden' name='popupAcceptYn' value='"+dataInfo.acceptYn+"' />");
						sb.Append("	<input type='hidden' name='popupUseYn' value='"+dataInfo.useYn+"' />");
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td class='popup_content_edit' style='cursor: pointer;'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.completeTime+"</td>");
						sb.Append("	<td>"+(dataInfo.acceptYn == "N" ? "신청불가" : "신청가능")+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "중지" : "서비스")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		})
		
		// ajax 처리 (창비)
		/* $.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='popupSearchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var learnTypes = "";
						
						if(dataInfo.learnTypes) {
							var types = dataInfo.learnTypes.split(",");
							
							for(var j=0; j<types.length; ++j) {
								if(types[j] == "J") {
									learnTypes += "직무" + dataInfo.credit + "/";
								} else if(types[j] == "S") {
									learnTypes += "자율/";
								} else if(types[j] == "M") {
									learnTypes += "집합/";
								} else if(types[j] == "G") {
									learnTypes += "단체/";
								}
							}
							
							learnTypes = learnTypes.length > 0 ? learnTypes.slice(0, -1) : ""; 
						}

						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='popupId' value='"+dataInfo.id+"' />");
						sb.Append("	<input type='hidden' name='popupName' value='"+dataInfo.name+"' />");
						sb.Append("	<input type='hidden' name='popupLearnTypes' value='"+dataInfo.learnTypes+"' />");
						sb.Append("	<input type='hidden' name='popupCredit' value='"+dataInfo.credit+"' />");
						sb.Append("	<input type='hidden' name='popupSelpPeriod' value='"+dataInfo.selpPeriod+"' />");
						sb.Append("	<input type='hidden' name='popupPrice' value='"+dataInfo.price+"' />");
						sb.Append("	<input type='hidden' name='popupMainBookId' value='"+dataInfo.mainBook.id+"' />");
						sb.Append("	<input type='hidden' name='popupSubBookId' value='"+dataInfo.subBook.id+"' />");
						sb.Append("	<input type='hidden' name='popupMainPrice' value='"+dataInfo.mainPrice+"' />");
						sb.Append("	<input type='hidden' name='popupSubPrice' value='"+dataInfo.subPrice+"' />");
						sb.Append("	<input type='hidden' name='popupCompleteTime' value='"+dataInfo.completeTime+"' />");
						sb.Append("	<input type='hidden' name='popupAcceptYn' value='"+dataInfo.acceptYn+"' />");
						sb.Append("	<input type='hidden' name='popupUseYn' value='"+dataInfo.useYn+"' />");
						sb.Append("	<td>"+learnTypes+"</td>");
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td class='popup_content_edit' style='cursor: pointer;'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.completeTime+"</td>");
						sb.Append("	<td>"+(dataInfo.groupYn == "Y" ? "신청가능" : "신청불가")+"</td>");
						sb.Append("	<td>"+(dataInfo.acceptYn == "N" ? "신청불가" : "신청가능")+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "중지" : "서비스")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		}); */
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		
		// 부모의 함수 호출해준다.
		var course =	{ "id" : $(":hidden[name='popupId']").eq(idx).val()
						, "name" : $(":hidden[name='popupName']").eq(idx).val()
						, "learnTypes" : $(":hidden[name='popupLearnTypes']").eq(idx).val()
						, "credit" : $(":hidden[name='popupCredit']").eq(idx).val()
						, "selpPeriod" : $(":hidden[name='popupSelpPeriod']").eq(idx).val()
						, "price" : $(":hidden[name='popupPrice']").eq(idx).val()
						, "mainBookId" : $(":hidden[name='popupMainBookId']").eq(idx).val()
						, "subBookId" : $(":hidden[name='popupSubBookId']").eq(idx).val()
						, "mainPrice" : $(":hidden[name='popupMainPrice']").eq(idx).val()
						, "subPrice" : $(":hidden[name='popupSubPrice']").eq(idx).val()
						, "completeTime" : $(":hidden[name='popupCompleteTime']").eq(idx).val()
						, "acceptYn" : $(":hidden[name='popupAcceptYn']").eq(idx).val()
						, "useYn" : $(":hidden[name='popupUseYn']").eq(idx).val()};
		setCourse(course);
		
		closeLayerPopup();
	});
	
	setContentList();
});

</script>
</head>

<body>
<div id="wrapper" style="height: 740px; overflow: auto;">
    <div>
        <div>     	
        	<!-- popupUserSearchForm start -->
        	<form name="popupSearchForm" method="post" class="form-inline" onsubmit="return false;">
        		<div>
		        	<table class="searchTable">
		        		<tr>
		        			<th>대분류</th>
		        			<td>
		        			 	<select class="selector" id='bigSelect'/></select>
		        			</td>
		        		</tr>
		        		<tr>
		        			<th>중분류</th>
		        			<td>
								<select class="selector" id="middleSelect"></select>
		        			</td>
		        		</tr>
		        		<tr>
		        			<th>소분류</th>
		        			<td>
								<select class="selector" id="smallSelect"></select>
		        			</td>
		        		</tr>
		        		<tr>
		        			<th>키워드검색</th>
		        			<td>
			        			<select class="searchConditionBox" name="searchCondition">
									<option value='all'>전체</option>
									<option value='name'>과정명</option>
									<option value='id'>과정코드</option>
								</select>
								<input type="text" class="form-control searchKeywordBox" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="">
	                    		<a type="button" class="btn" id="popupSearchBtn"><i class="fa fa-search">검색</i></a>
		        			</td>
		        		</tr>
		        	</table>
				</div>
	        	<input type="hidden" name="id" value="" />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='1' />
	        	<!-- 기수ID -->
        		<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinalId}" default="" />' />
        		<!-- 학점리스트(기수에서 코스 조회 시 필요) -->
        		
        		<!-- appPossibles(신청학점) 이 있으면 있는 만큼 creditList를 만들고 없으면 0으로 creditList를 만듬 -->
        		<c:if test="${fn:length(search.appPossibles) > 0}">
	        		<c:forTokens items="${search.appPossibles}" var="credit" delims="," varStatus="status">
	        		<input type="hidden" name="creditList[<c:out value="${status.index}" />]" value='<c:out value="${credit}" />' />
	        		</c:forTokens>
	        	</c:if>
				<input type="hidden" value="${search.subCourseCode.parentCode.code }" name="subCourseCode.parentCode.code" id="parentSubCourseCode">
				<input type="hidden" value="${search.subCourseCode.code}" name="subCourseCode.code" id="subCourseCodecode">
	       		<input type="hidden" value="${search.courseCode.code}" name="courseCode.code" id="courseCodecode">
	        	<!-- 연수구분 선택 -->
				<%-- <select name="learnTypes">
					<c:if test="${empty search.learnTypes}">
						<option value="">연수구분</option>
        				<option value="J">직무</option>
        				<option value="S">자율</option>
        				<option value="M">집합</option>
        				<option value="G">단체</option>
        			</c:if>
        			<c:if test="${fn:contains(search.learnTypes, 'J')}"><option value="J">직무</option></c:if>
        			<c:if test="${fn:contains(search.learnTypes, 'S')}"><option value="S">자율</option></c:if>
        			<c:if test="${fn:contains(search.learnTypes, 'M')}"><option value="M">집합</option></c:if>
        			<c:if test="${fn:contains(search.learnTypes, 'G')}"><option value="G">단체</option></c:if>
				</select> --%>
				
				<!-- 과정분류 선택 -->
				<%-- <select name="courseCode.code">
					<option value="">과정분류</option>
					<c:forEach items="${courseList}" var="code" varStatus="status">
						<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq search.courseCode.code}">selected</c:if>><c:out value="${code.name}" /></option>
					</c:forEach>
				</select> --%>
				
				<!-- 협력업체 선택 -->
				<%-- <select name="company.id">
					<option value="">협력업체</option>
					<c:forEach items="${companyList}" var="company" varStatus="status">
						<option value='<c:out value="${company.id}" />' <c:if test="${company.id eq search.company.id}">selected</c:if>><c:out value="${company.name}" /></option>
					</c:forEach>
				</select> --%>
				
				<!-- 강사 선택 -->
				<%-- <select name="teacher.id">
					<option value="">강사</option>
					<c:forEach items="${teacherList}" var="teacher" varStatus="status">
						<option value='<c:out value="${teacher.id}" />' <c:if test="${teacher.id eq search.teacher.id}">selected</c:if>><c:out value="${teacher.name}" /></option>
					</c:forEach>
				</select> --%>
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<!-- <th>연수타입</th> -->
						<th>과정코드</th>
						<th>과정명</th>
						<th>이수시간</th>
						<!-- <th>단체신청여부</th> -->
						<th>신청</th>
						<th>상태</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody"></tbody>
				</table>
			</div>
			<div class="popup_pagination"></div>
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>