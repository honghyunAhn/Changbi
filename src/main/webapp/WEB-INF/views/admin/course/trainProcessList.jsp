<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/course/trainProcessList' />";
	var editUrl	= "<c:url value='/admin/course/trainProcessEdit' />";
	var chapterUrl = "<c:url value='/admin/course/chapterList' />";
	var chapterUrlPort = "<c:url value='/admin/course/chapterListPort' />";
	var selectDelUrl = "<c:url value='/data/course/trainProcessSelectDel' />";	// 과정 선택 삭제
	var saveExcelUrl = "<c:url value='/data/course/excel/download/trainProcessList' />";	// 과정 리스트 엑셀 다운로드
	var courseListUrl = "<c:url value='/data/course/selectCourseList' />"; //검색1: 대분류 선택시 학습영역 목록 로드 
	var trainProcessListUrl = "<c:url value='/data/course/selectTrainProcessList' />"; //검색2: 학습영역 선택시 학습과정 목록 로드 
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/**    LMS  대중소분류 검색      **/
	var data;
	$.ajax({
		type	: "post",
		url		: "<c:url value='/forFaith/base/cateCodeList' />",
		async : false,
		success	: function(result) {
			data=result;
		}
	});
	
	// 상세페이지에서 list로 돌아왔을 경우 분류값을 selectbox에 세팅
	function setSearchCode(){
		//대분류 코드가 있을 때
		if('${search.subCourseCode.parentCode.code}' != '' &&  '${search.subCourseCode.parentCode.code}' != null) {
				$("#bigSelect").append('<option value="">대분류선택</option>');
				$("#middleSelect").append('<option value="">중분류선택</option>');
				
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
			//대분류 코드가 없을 때(검색조건이 없을 때 최초 세팅)
			$("#bigSelect").append('<option value="">대분류선택</option>');
			for(var i=0;i<data.length;i++){
				$("#bigSelect").append('<option value="'+data[i].code+'">'+data[i].name+'</option>');
			}
		}
	}
	
	setSearchCode();
	
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
		$("#courseCodecode").val('');
		$("#subCourseCodecode").val('');
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
		$("#courseCodecode").val('');
		$("#subCourseCodecode").val($("#middleSelect option:selected").val());
	});
	
	$("#smallSelect").change(function(){
		$("#courseCodecode").val($("#smallSelect option:selected").val());
	});
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			async : false,
			success	: function(result) {
				var sb = new StringBuilder();
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					for(var i=0; i< dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;
						sb.Append("<tr>");
						sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						if(dataInfo.subCourseCode!= null && dataInfo.subCourseCode.name!=null){
						    sb.Append("	<td>"+dataInfo.subCourseCode.name+"</td>");
						}else{
							sb.Append("	<td></td>");
						}	
						if(dataInfo.courseCode!= null && dataInfo.courseCode.name!=null){
							sb.Append("	<td>"+dataInfo.courseCode.name+"</td>");
						}else{
							sb.Append("	<td></td>");
						}	
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.completeTime+"</td>");
						sb.Append("	<td>"+(dataInfo.acceptYn == "N" ? "신청불가" : "신청가능")+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "N" ? "중지" : "서비스")+"</td>");					 
						sb.Append(" <td>");
						sb.Append("	<button type='button' class='chapter_btn btn align_right primary'>세부차시</button>");
						sb.Append(" <input type='hidden' name='portYn' value='" + dataInfo.portYn + "' />")
						sb.Append(" </td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='11'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	
	/*검색 1: 대분류 콤보박스 변경시 학습영역 데이터 로드 */ 
	$("select[name='subCourseCode.code']").unbind("change").bind("change",function(){			
	 
	     var courseSb = new StringBuilder();
	     courseSb.Append("<option value='0'>--학습영역--</option>");
	     
	     if($(this).val()){
	    	 var data = {"parentCode.code": $(this).val(), "useYn":"Y", "pagingYn":"N"};
	    
		    	 $.ajax({
		    		 type: "post",
		    		 url : courseListUrl , 
		    		 data: data, 
		    		 success: function(result){		    			 
		    			 if(result.list && result.list.length>0){
		    				 var dataList = result.list;
		    				 var courseCodeVal = $("#actionCourseCode").val();		 
		    				 
		    				 for(var i =0; i< dataList.length; i++){
		    					 var dataInfo = dataList[i];		    				 
		    					 courseSb.Append("<option value ="+dataInfo.code+" "+(courseCodeVal ==dataInfo.code? "selected": "")+">"+dataInfo.name+"</option>")
		    				 }
		    			 }		    		   
		    			 $("select[name='courseCode.code']").html(courseSb.ToString());  
		    		 }	    			 
		    	 })
		     }
		})
		
	/*검색 2: 학습영역 콤보박스 변경시 해당 학습과정 데이터 로드 */
	$("select[name='courseCode.code']").unbind("change").bind("change",function(){			
	 
	     var courseSb = new StringBuilder();
	     courseSb.Append("<option value='0'>--학습과정--</option>");
	     
	     if($(this).val()){
	    	 var data = {"code": $(this).val(), "useYn":"Y", "pagingYn":"N"};
	    
		    	 $.ajax({
		    		 type: "post",
		    		 url : trainProcessListUrl , 
		    		 data: data, 
		    		 success: function(result){	
		    			 if(result.list && result.list.length>0){
		    				 var dataList = result.list;
		    				 var courseCodeVal = $("#actionCourseCode").val();		 
		    				 
		    				 for(var i =0; i< dataList.length; i++){
		    					 var dataInfo = dataList[i];		    				 
		    					 courseSb.Append("<option value ="+dataInfo.id+" "+(courseCodeVal ==dataInfo.id? "selected": "")+">"+dataInfo.name+"</option>")
		    				 }
		    			 }		    		   
		    			 $("select[name='trainProcessId']").html(courseSb.ToString());  
		    		 }	    			 
		    	 })
		     }
		})
	
	
	
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		// ajax로 load
		contentLoad("학습과정관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동(ID가 int인 경우 0을 넣어줌)
		$(":hidden[name='id']").val("");
		
		// ajax로 load
		contentLoad("학습과정관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 세부차시 등록 기능
	$("#dataListBody").on("click", ".chapter_btn", function() {
		
		var idx = $(".chapter_btn").index($(this));
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		//포팅여부
		var portYn = $(this).closest('td').find(':hidden[name=portYn]').val();
		
		//포팅여부에 따라 다르게 ajax로 load
		if(portYn == 'N') contentLoad("세부차시관리(링크)", chapterUrl, $("form[name='searchForm']").serialize());
		else contentLoad("세부차시관리(포팅)", chapterUrlPort, $("form[name='searchForm']").serialize());
	});
	
	// 전체 체크박스 클릭 시
	$("#allCheckBox").unbind("click").bind("click", function() {
		$(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
	});
	
	// 선택 삭제 버튼 클릭 시
	$("#selectDelBtn").unbind("click").bind("click", function() {
		var size = $(":checkbox[name='selectCheckBox']:checked").size();
		
		if(size == 0) {
			alert("삭제 할 데이터를 선택하세요.");
		} else if(confirm("선택 된 "+size+"건의 데이터를 삭제하시겠습니까?")) {
			var data = {};
			var objList = new Array();
			
			$(":checkbox[name='selectCheckBox']:checked").each(function(i) {
				var idx = $(":checkbox[name='selectCheckBox']").index($(this));

				objList.push({"id" : $(":hidden[name='checkId']").eq(idx).val()});
			});
			
			data = {"list" : objList};
			
			// ajax 처리
			$.ajax({
				type		: "POST",
				url			: selectDelUrl,
				data		: JSON.stringify(data),
				dataType	: "json",
				contentType	: "application/json; charset=utf-8",
				processData	: false,
				success		: function(result) {
					alert(result+"개 데이터가 삭제 되었습니다.");
					
					setContentList(1);
				},
				error		: function(e) {
					alert(e.responseText);
				}
			});
		}
	});
	
	// 엑셀다운로드
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		if(confirm("엑셀로 저장하시겠습니까?")) {
			$("form[name='searchForm']").attr("action", saveExcelUrl);
			$("form[name='searchForm']").submit();
		}
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

</script>

<div class="content_wraper">
	<h3>학습과정관리</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
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
							<input type="text" placeholder="검색어입력" class="searchKeywordBox" id="searchKeyword" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
							<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
	        			</td>
	        		</tr>
	        		</table>
				</div>
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
			<!-- 검색시 분류값 저장하는 곳 -->
			<input type="hidden" value="${search.subCourseCode.parentCode.code }" name="subCourseCode.parentCode.code" id="parentSubCourseCode">
			<input type="hidden" value="${search.subCourseCode.code}" name="subCourseCode.code" id="subCourseCodecode">
	       	<input type="hidden" value="${search.courseCode.code}" name="courseCode.code" id="courseCodecode">

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
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>연번</th>
				<th>대분류</th>
				<th>학습영역</th>
				<th>과정코드</th>
				<th>과정명</th>
<!-- 				<th>과정줄임말</th>		 -->
				<th>시간</th>
				<th>신청구분</th>
				<th>과정상태</th>
				<th>세부차시</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="selectDelBtn" class="btn align_right danger" href="javascript:void();">선택삭제</a>
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>