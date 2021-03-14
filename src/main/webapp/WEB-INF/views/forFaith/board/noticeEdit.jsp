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

<title>게시물관리</title>
<link href="<c:url value="/css/page/styles.css"/>" rel="stylesheet">
<link href="<c:url value="/css/bootstrap/bootstrap.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/sbadmin2/metisMenu/metisMenu.min.css"/>"	rel="stylesheet"><!-- metisMenu css -->
<link href="<c:url value="/css/sbadmin2/sb-admin-2.css"/>" rel="stylesheet"><!-- custom css -->
<link href="<c:url value="/css/font-awesome/font-awesome.min.css"/>" rel="stylesheet" type="text/css"><!-- custom fonts -->
<link href="<c:url value="/css/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>"rel="stylesheet"><!-- bootstrap-datetimepicker css -->

<script src="<c:url value="/js/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/moment.min.js"/>"></script><!-- moment javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/locales.min.js"/>"></script><!-- locales javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>"></script><!-- bootstrap-datetimepicker javascript -->
<script src="<c:url value="/js/sbadmin2/metisMenu/metisMenu.min.js"/>"></script><!-- metis menu plugin javascript -->
<script src="<c:url value="/js/sbadmin2/sb-admin-2.js"/>"></script><!-- custom theme javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script><!-- smarteditor javascript -->
<%-- <script src="<c:url value="/js/jquery/jquery.MultiFile.js"/>"></script><!-- multifile upload --> --%>
<script src="<c:url value="/js/page/main.js"/>"></script>

<!-- 내부 자바스크립트 -->
<script src='<c:url value="/js/com/commonFunc.js" />'></script>
<script src='<c:url value="/js/com/commonObj.js" />'></script>
<script src='<c:url value="/js/com/commonFile.js" />'></script>

<!-- 내부 프로젝트 자바스크립트 -->
<script src='<c:url value="/js/project/jejuolle.js" />'></script>

<!-- ol3.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.18.2/ol.css" type="text/css" />
<link rel="stylesheet" href="/css/page/map/aracomm_map_ol3.css" type="text/css" />
<!-- Hint.css : http://kushagragour.in/lab/hint/ -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/hint.css/2.3.2/hint.min.css" type="text/css" />

<style type="text/css">
/* Bootstrap Modal Dialog */
@media screen and (min-width: 768px) {
	#myModal .modal-dialog  {width:900px;}
}

#myModal {
	top:10%;
	outline: none;
}

/* div for ol3-map */
#map {
	width:100%;
	height:400px;
}
</style>

<script type="text/javascript">

$(document).ready(function() {
	// url을 여기서 변경
	var regUrl	    = "<c:url value='/board/boardReg.do' />";
	var listUrl	    = "<c:url value='/board/board.do' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 에디터, 달력, 언어 선택 기능, 파일 업로드 초기화
	setPageInit(editor_object);
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").bind("click", function() {
		if(!$(":text[name='title']").val()) {
			alert("제목은 필수항목입니다.");
			$(":text[name='title']").focus();
		} else if( ($("#emergencyYn").val() == "Y" && confirm("긴급공지로 저장하시겠습니까?"))
		        || ($("#emergencyYn").val() != "Y" && confirm("저장하시겠습니까?")) ) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			$("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
			
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			});
			
			// 타이틀을 넣어준다.(0인 경우 default)
			$(".contents_title").each(function(i) {
				$(this).val($(".event_name").eq(i).val());//이벤트명
			});
			
			$("form[name='actionForm']").attr("action", regUrl);
			$("form[name='actionForm']").submit();
		}
	});
	
	// 페이지 이벤트 등록(취소 버튼 클릭 시)
	$("#cancelBtn").bind("click", function() {
		$("form[name='searchForm']").attr("action", listUrl);
		$("form[name='searchForm']").submit();
	});	

	// 인라인 리스트(추가 삭제하기 위한 리스트) 중 삭제 버튼 클릭 시
	$("#inlineList li :button.close").bind("click", deleteMapData);
	
	// 태그 추가 버튼 클릭 시(태그를 컴마로 구분해서 저장하면 됩니다.)
	$("#addInlineBtn").bind("click", function(e) {
		var index = $("#inlineList li").size();

		var tags = $(":text[name='tags']").val().trim();
		var tagList = new ArrayList();

		if(tags) {
			tagList.set(tags.split(','));
		}
		
		if(tagList && tagList.size() > 0) {
			// 이미 등록 된 태그는 다시 넣지 않음
			for(var i=0; i<tagList.size(); ++i) {
				var tagName	= tagList.get(i);
				var progress = true;
				var sb = "";
				
				$("#inlineList li").each(function() {
					if($(this).find(":hidden[name^=tagList]").val() == tagName) {
						alert(tagName+" 은 이미 포함 된 태그명입니다.");
						
						progress = false;
						
						// each문 빠져나오기 (break)
						return false;
					}
				});
			
				if(progress) {
					sb += "<li class='mapping_data'>"
					sb += "	<span class='label label-default'>";
					sb += "		<input type='hidden' name='tagList["+(index+i)+"].name' value='"+tagName+"' />"+tagName;
					sb += "		<button type='button' class='close' aria-label='Close'>";
					sb += "			<span aria-hidden='true' style='color:red'>&times;</span>";
					sb += "		</button>";
					sb += "	</span>"
					sb += "</li>";
					
					$("#inlineList").append(sb);
				}
			}
		} else {
			alert("등록 할 태그를 콤마(,) 단위로 등록하세요.");
			
			$(":text[name='tags']").focus();
		}
		
		$(":text[name='tags']").val("");
	});
	
	// 태그에서 엔터키를 쳤을 때 추가 버튼 클릭과 동일한 효과
	$(":text[name='tags']").bind("keypress", function(e) {
		if(e.which == 13) {
			$("#addInlineBtn").click();
			return false;
		}
	});
	
	// 인라인 리스트(추가 삭제하기 위한 리스트) 중 삭제 버튼 클릭 시(동적으로 추가되는 버튼에 이벤트 자동 적용 방식)
	$(document).on("click", "#inlineList li :button.close", deleteMapData);
	
	// 관련코스 체크박스 클릭 시 이름 명칭을 만들어준다.
	$(".relation_course").bind("click", function() {
		// 모든 name을 없앤다.
		$(".relation_course").each(function(i) {
			$(this).attr("name", "");
		});
		
		// 체크 된 목록만 name을 붙인다.
		$(".relation_course:checked").each(function(i) {
			$(this).attr("name", "contents.courseList["+i+"].course.id");
		});
	});
	
	// 컨텐츠 분류 체크박스 클릭 시 이름 만들어줌.
	$(".contents_type").bind("click", function() {
		// 모든 name을 없앤다.
		$(".contents_type").each(function(i) {
			$(this).attr("name", "");
		});
		
		// 체크 된 목록만 name을 붙인다.
		$(".contents_type:checked").each(function(i) {
			$(this).attr("name", "contents.typeList["+i+"].contentType");
		});
	});
	
	// 관련축제 체크박스 클릭 시 이름 만들어줌.
	$(".relation_festival").bind("click", function() {
		// 모든 name을 없앤다.
		$(".relation_festival").each(function(i) {
			$(this).attr("name", "");
		});
		
		// 체크 된 목록만 name을 붙인다.
		$(".relation_festival:checked").each(function(i) {
			$(this).attr("name", "contents.festivalList["+i+"].festival.id");
		});
	});
	
	// 최초에 관련코스 옵션 체크 되어 있는 곳에 명칭을 넣는다.
	$(".relation_course:checked").each(function(i) {
		$(this).attr("name", "contents.courseList["+i+"].course.id");
	});
	
	// 최초에 컨텐츠 분류 옵션 체크 되어 있는 곳에 명칭을 넣는다.
	$(".contents_type:checked").each(function(i) {
		$(this).attr("name", "contents.typeList["+i+"].contentType");
	});
	
	// 최초에 관련축제 옵션 체크 되어 있는 곳에 명칭을 넣는다.
	$(".relation_festival:checked").each(function(i) {
		$(this).attr("name", "contents.festivalList["+i+"].festival.id");
	});
	
	$("select[name='boardId']").bind("change", function() {
	 	// 긴급공지여부는 올레소식일때만 나와야하며 올레소식이 아닐땐 사라지며 N으로 바뀜.
		if($(this).val() == "ollenews") {
			$(".emergency_area").show();
		} else {
		    $(".emergency_area").hide();
		    $("#emergencyYn").val("N");
		}
	 
		// 파일 업로드 정보 객체 생성 및 전달
		var file_object = [];
		
		var maxCount = 1;
		var maxSize = 10;
		var boardId = $(this).val();
		var manageBoardId = 0;
		
		<c:forEach items="${boardManageList}" var="boardManage" varStatus="status">
			manageBoardId = "<c:out value='${boardManage.boardId}' />";
			
			if(boardId == manageBoardId) {
				maxCount = "<c:out value='${boardManage.fileCnt}' />";
				maxSize = "<c:out value='${boardManage.fileSize}' />";
			}
		</c:forEach>
		
		$(".file_upload_info").html("(파일갯수 : "+maxCount+"개, 파일크기 : "+maxSize+"M, 파일종류 : ALL)");
		
		// 첫번째 파일
		file_object[0] = { maxCount : maxCount, maxSize : maxSize, maxTotalSize : (maxCount*maxSize)};
		
		attachFileReset(file_object);
	});

	$("select[name='boardId']").trigger("change");
});

//매핑 된 데이터 삭제
function deleteMapData() {
	$(this).parents("li.mapping_data").remove();
	
	// 데이터 삭제 시 이름을 다시 세팅해준다.
	$(":hidden[name^=tagList]").each(function(i) {
		$(this).attr("name", "tagList["+i+"].name");
	});
}


</script>
</head>

<body>

<div id="wrapper">

	<!-- Navigation -->
	<%-- <jsp:include page="/WEB-INF/jsp/common/inc/navigation.jsp"/> --%>
	<!-- // Navigation -->

	<div id="page-wrapper">
        <ol class="breadcrumb" style="background-color:#fff">
		  <!-- <li><a href="#">Home</a></li>
		  <li><a href="#">Library</a></li>
		  <li class="active">Data</li> -->
		</ol>
		<div class="page-header">
		  <h1>게시물관리(<c:choose><c:when test="${board.id > 0}">수정</c:when><c:otherwise>추가</c:otherwise></c:choose>)</h1>
		</div>

        <div class="panel panel-warning">
        	
        	<!-- searchForm 시작 -->
		  	<form name="searchForm" method="post">
				<!-- 조회조건 -->
				<input type='hidden' name='pageIndex' value='<c:out value="${search.pageIndex}" default="1" />' />
				<input type='hidden' name='boardId' value='<c:out value="${search.boardId}" default="" />' />
				<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
				<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			</form>
			<!-- //searchForm 종료 -->
			
		  	<!-- actionForm 시작 -->
		  	<form name="actionForm" method="post">
			  	<!-- hidden 데이터 -->
		  		<input type='hidden' name='id' value='<c:out value='${board.id}' default="0" />' />		<!-- Id가 존재 하면 update 없으면 insert -->
				<!-- 언어별로 배열 hidden 세팅 -->
				<c:forEach items="${LangTypeList}" var="type" varStatus="status">
				<input type='hidden' name='detailList[<c:out value="${status.index}" />].lang' value='<c:out value="${type.code}" />' />
				</c:forEach>
				
				<!-- 조회조건 -->
				<input type='hidden' name='search.pageIndex' value='<c:out value="${search.pageIndex}" default="1" />' />
				<input type='hidden' name='search.boardId' value='<c:out value="${search.boardId}" default="" />' />
				<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
				<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
				
				<input type='hidden' name='contents.id' value='<c:out value='${board.contents.id}' default="0" />' />
				<input type='hidden' name='contents.tableName' value='JO_BOARD' />
				<input type='hidden' name='contents.pageDiv' value='A' />
				<input type='hidden' name='contents.startDate' value='' />
				<input type='hidden' name='contents.distance' value='' />
				<input type='hidden' name='contents.diffLevel' value='' />
				<input type='hidden' name='contents.image.id' value='0' />
				
				<!-- 코스는 1 행사는 2 나머지는 모두 9 default -->
				<!-- 코스와 행사는 orderNum을 100으로 나머지 defaul 10 -->
				<input type='hidden' name='contents.template' value='9' />
				<input type='hidden' name='contents.orderNum' value='10' />
				
				<!-- 언어별로 배열 hidden 세팅 -->
				<c:forEach items="${LangTypeList}" var="type" varStatus="status">
				<input type='hidden' name='contents.detailList[<c:out value="${status.index}" />].lang' value='<c:out value="${type.code}" />' />
				<input type='hidden' class='contents_title'  name='contents.detailList[<c:out value="${status.index}" />].title' value='' />
				</c:forEach>		  		
			<table class="table dataTable table-bordered">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
            <tbody>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">게시판</td>
				<td>
					<div role="tabpanel" id="boardpn">
						<select class="form-control" id="boardId" name="boardId">
							<c:forEach var="boardManageList" items="${boardManageList}" varStatus="status">
								<c:if test="${boardManageList.boardId ne 'qna'}">
									<option value="${boardManageList.boardId}" <c:if test="${boardManageList.boardId == board.boardId}">selected</c:if>>${boardManageList.koName}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info require" style="vertical-align: middle;">제목(*)</td>
				<td class="text-center">
					<div role="tabpanel" id="boardpn">
						<input type="text" class="form-control event_name" id="title" name="title" value="<c:out value="${board.title}" />"   placeholder="<c:out value='${type}'/> ">
					</div>
				</td>
			</tr>
			<tr class='emergency_area'>
				<td class="text-center info" style="vertical-align: middle; font-weight: bold;">긴급공지여부</td>
				<td>
					<div class="col-lg-3" style="padding-left:0">
						<select class="form-control" id="emergencyYn" name="emergencyYn">
							<option value="N">일반공지</option>
							<option value="Y" <c:if test="${board.emergencyYn=='Y'}">selected</c:if>>긴급공지</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">작성자</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group col-lg-3">
					   		<input type="text" class="form-control" name='name' value='<c:choose><c:when test="${board ne null and board.name ne null and board.name ne ''}"><c:out value="${board.name}" /></c:when><c:otherwise><c:out value="${LoginVO.userName}" /></c:otherwise></c:choose> '/>				    	 
					   </div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">연락처</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group col-lg-3">
					   		<input type="text" class="form-control" name='phone' value='<c:choose><c:when test="${board ne null and board.phone ne null and board.phone ne ''}"><c:out value="${board.phone}" /></c:when><c:otherwise><c:out value="${LoginVO.phone}" /></c:otherwise></c:choose> '/>				    	 
					   </div>
					</div>
				</td>
			</tr>			
			<tr>
				<td class="text-center info" style="vertical-align: middle;">이메일</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group col-lg-3">
					   		<input type="text" class="form-control" name='email' value='<c:choose><c:when test="${board ne null and board.email ne null and board.email ne ''}"><c:out value="${board.email}" /></c:when><c:otherwise><c:out value="${LoginVO.email}" /></c:otherwise></c:choose> '/>				    	 
					   </div>
					</div>
				</td>
			</tr>			
			<tr>
				<td class="text-center info" style="vertical-align: middle;">작성일시</td>
				<td class="text-center">
					<div class="form-group" style="margin-top: 8px; padding-left: 0;">
					   	<div class="input-group col-lg-3">
					   		<fmt:parseDate var="dateString" value="${board.regDate}" pattern="yyyyMMddHHmmss" />
					   		<input type="text" class="form-control" name='regDate' ReadOnly value='<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" />'/>				    	
					   </div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">언어구분</td>
				<td>
					<div class="col-lg-3" style="padding-left:0">
						<select class="form-control" id="lang" name="lang">
							<option value="ko" <c:if test="${board.lang=='ko'}">selected</c:if>>한국어</option>
							<option value="en" <c:if test="${board.lang=='en'}">selected</c:if>>영어</option>
							<option value="ch" <c:if test="${board.lang=='ch'}">selected</c:if>>중국어</option>
							<option value="ja" <c:if test="${board.lang=='ja'}">selected</c:if>>일본어</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">내용</td>
				<td class="text-center">
					<div role="tabpanel" id="contents">
						<div class="tab-content" style="vertical-align: middle;">
					  			<textarea class="editor" id="comment" name="comment" rows="10" cols="100" style="width:100%; height:200px;">
					  				<% pageContext.setAttribute("frontUrl", "/file_upload/"); %>
									${fn:replace(board.comment, frontUrl,'https://www.jejuolle.org/file_upload/')}
					  			</textarea>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">첨부파일</td>
				<td>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='uploadFile.id' value='<c:out value="${board.uploadFile.id}" default="0" />' />
						<input type='hidden' class='upload_dir'	value='/board/images' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'></span>
						</div>
						
						<c:if test="${board.uploadFile ne null and board.uploadFile.detailList ne null and fn:length(board.uploadFile.detailList) > 0}">
							<c:forEach items="${board.uploadFile.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>
									<input type='button' value='<c:out value="${file.originFileName}" />' style='width: 200px; height: 30px;' />
								</div>
								<div class='file_info' style='padding-left: 5px;'>
									<input type='hidden' class='attach_file_name'			value='<c:out value="${file.fileName}" />' />
									<input type='hidden' class='attach_file_path'			value='<c:out value="${file.filePath}" />' />
									<input type='hidden' class='attach_file_size'			value='<c:out value="${file.fileSize}" default="0" />' />
									<input type='hidden' class='attach_origin_file_name'	value='<c:out value="${file.originFileName}" />' />
									<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />
								</div>
							</div>
							</c:forEach>
						</c:if>
					</div>
				</td>
			</tr>			
			<tr>
				<td class="text-center info" style="vertical-align: middle;">관련코스</td>
				<td>
					<div class="form-inline">
						<div class="form-group">
							<c:forEach items="${board.contents.courseList}" var="relationCourse" varStatus="rcStatus">
			                	<c:set var="cids" value="${cids}[${relationCourse.course.id}]" /> <!-- ID를 []로 감싼다. -->
			                </c:forEach>
			                <div class="checkbox">
			                	<input type='checkbox' class='relation_course' id='relationCourse0' name='' value='0' <c:if test="${fn:contains(cids, '[0]')}">checked</c:if> />
			                	<label for='relationCourse0'>전체코스</label>
			                </div>
							<c:forEach items="${courseList}" var="course" varStatus="courseStatus">
							   	<div class="checkbox" style="margin-left: 10px;">
							   		<c:set var="checkId" value="[${course.id}]" />	<!-- ID에 []로 감싼다. -->
							   		
						    		<input type='checkbox' class='relation_course' id='relationCourse<c:out value="${course.id}" default="0" />' name='' value='<c:out value="${course.id}" default="0" />' <c:if test="${fn:contains(cids, checkId)}">checked</c:if> />
				    				<label for='relationCourse<c:out value="${course.id}" default="0" />'><c:out value="${course.courseNum}" /></label>
						    	</div>
						    </c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">컨텐츠분류</td>
				<td>
					<div class="form-inline">
						<div class="form-group">
							<%-- <c:set var="types">N,C,S,E,T,P</c:set>
							<c:set var="typeNameList" value="${fn:split('알아두세요,코스정보,올레스토리,이벤트,이야기톡톡,프로모션', ',')}" /> --%>
							<c:set var="types">E</c:set>
							<c:set var="typeNameList" value="${fn:split('이벤트', ',')}" />
							
							<c:forEach items="${board.contents.typeList}" var="type" varStatus="status">
			                	<c:set var="contentTypes" value="${contentTypes}${type.contentType}" />
			                </c:forEach>
			                
			                <c:forEach items="${fn:split(types,',')}" var="type" varStatus="typeStatus">
				                <div class="checkbox">
				                	<input type='checkbox' class='contents_type' id='contentsType<c:out value="${type}" />' name='' value='<c:out value="${type}" />' <c:if test="${fn:contains(contentTypes, type)}">checked</c:if> />
				                	<label for='contentsType<c:out value="${type}" />'><c:out value="${typeNameList[(typeStatus.index)]}" /></label>
				                </div>
							</c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">관련축제</td>
				<td>
					<div class="form-inline">
						<div class="form-group">
							<c:forEach items="${board.contents.festivalList}" var="relationFestival" varStatus="rfStatus">
			                	<c:set var="fids" value="${fids}[${relationFestival.festival.id}]" /> <!-- ID를 []로 감싼다. -->
			                </c:forEach>
			                
							<c:forEach items="${festivalList}" var="festival" varStatus="festivalStatus">
							   	<div class="checkbox">
							   		<c:set var="checkId" value="[${festival.id}]" />	<!-- ID에 []로 감싼다. -->
							   		
						    		<input type='checkbox' class='relation_festival' id='relationFestival<c:out value="${festival.id}" default="0" />' name='' value='<c:out value="${festival.id}" default="0" />' <c:if test="${fn:contains(fids, checkId)}">checked</c:if> />
				    				<label for='relationFestival<c:out value="${festival.id}" default="0" />'><c:out value="${festival.detail.title}" /></label>
						    	</div>
						    </c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="text-center info" style="vertical-align: middle;">태그목록</td>
				<td>
					<div class="col-lg-4" style='padding: 0;'>
						<input type="text" class="form-control" name="tags" placeholder="콤마(,)로 구분해 입력하세요" />
					</div>
					<button type="button" class="btn btn-default" id='addInlineBtn'>추가</button>
					<ul class="list-inline" id="inlineList" style="margin: 10px 0 0 0">
						<c:forEach items="${board.tagList}" var="tag" varStatus="status">
							<c:if test="${tag ne null and tag.name ne null and tag.name ne ''}">
							<li class='mapping_data'>
								<span class="label label-default">
									<input type='hidden' name='tagList[<c:out value="${status.index}" />].name' value='<c:out value="${tag.name}" />' /><c:out value="${tag.name}" />
									<button type="button" class="close" aria-label="Close">
										<span aria-hidden="true" style="color:red">&times;</span>
									</button>
								</span>
							</li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
			</tr>
									
			</tbody>
			</table>
			
			</form>
			<!-- //actionForm 종료 -->
			
        </div>
		<div class="row mgB30px">
			<div class="col-lg-7 text-left">
<%-- 						<ui:pagination paginationInfo="" type="bootstrap" jsFunction="linkPage"/> --%>
			</div>
			<div class="col-lg-5 text-right">
				<button type="button" id="regBtn" class="btn btn-danger">저장</button>
				<button type="button" id="cancelBtn" class="btn btn-primary">취소</button>
			</div>
		</div>	
	</div>
	<!-- /#page-wrapper -->
	
</div>
<!-- /#wrapper -->
<!-- image Modal -->
<%-- <jsp:include page="/WEB-INF/jsp/common/inc/imagePreviewModal.jsp" /> --%>
 
</body>

</html>