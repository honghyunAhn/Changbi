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

<title>게시판관리</title>
<link href="<c:url value="/css/page/styles.css"/>" rel="stylesheet">
<link href="<c:url value="/css/bootstrap/bootstrap.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>"rel="stylesheet"><!-- bootstrap core css -->
<link href="<c:url value="/css/sbadmin2/metisMenu/metisMenu.min.css"/>"	rel="stylesheet"><!-- metisMenu css -->
<link href="<c:url value="/css/sbadmin2/sb-admin-2.css"/>" rel="stylesheet"><!-- custom css -->
<link href="<c:url value="/css/font-awesome/font-awesome.min.css"/>" rel="stylesheet" type="text/css"><!-- custom fonts -->

<script src="<c:url value="/js/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/js/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/moment.min.js"/>"></script><!-- moment javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/locales.min.js"/>"></script><!-- locales javascript -->
<script src="<c:url value="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>"></script><!-- bootstrap-datetimepicker javascript -->
<script src="<c:url value="/js/sbadmin2/metisMenu/metisMenu.min.js"/>"></script><!-- metis menu plugin javascript -->
<script src="<c:url value="/js/sbadmin2/sb-admin-2.js"/>"></script><!-- custom theme javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script><!-- smarteditor javascript -->
<script src="<c:url value="/js/page/main.js"/>"></script>

<script type="text/javascript">

$(document).ready(function() {
	// url을 여기서 변경
	var regUrl	= "<c:url value='/board/boardManageReg.do' />";
	var listUrl	= "<c:url value='/board/boardManage.do' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 에디터, 달력, 언어 선택 기능 초기화
	setPageInit(editor_object);
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").bind("click", function() {
		if(!$(":text[name='boardId']").val()) {
			alert("게시판 ID는 필수항목입니다.");
			$(":text[name='boardId']").focus();
		} else if(!$(":text[name='koName']").val()) {
			alert("한국어 게시판명은 필수항목입니다.");
			$(":text[name='koName']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			$("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
			
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
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
	
	$("#tag_btn").click(function(){
		var sb = "";
		var progress = true;
		var index = $("#inlineList li").size();
		
		// 이미 등록 된 날짜를 선택 한 경우는 다시 넣지 않음.
		$("#inlineList li").each(function() {
			if($(this).find(":hidden[name^=tagList]").val() == $(":text[name='tag_name']").val()) {
				alert($(":text[name='tag_name']").val()+" 는 이미 입력한 태그입니다.");
				
				progress = false;
				
				// each문 빠져나오기 (break)
				return false;
			}
		});
		
		if(progress) {
			sb += "<li class='mapping_data'>"
			sb += "	<span class='label label-default'>";
			sb += "		<input type='hidden' name='tagList["+index+"]' value='"+$(":text[name='tag_name']").val()+"' />"+$(":text[name='tag_name']").val();
			sb += "		<button type='button' class='close' aria-label='Close'>";
			sb += "			<span aria-hidden='true' style='color:red'>&times;</span>";
			sb += "		</button>";
			sb += "	</span>"
			sb += "</li>";
			
			$("#inlineList").append(sb);
			
			// 삭제 버튼 클릭 시 삭제 처리
			$("#inlineList li:last-child :button.close").bind("click", deleteMapData);
		}
	});
	
	// 관리그룹지정 체크박스 클릭 시 이름 만들어줌.
	$(".groupCodeId").bind("click", function() {
		// 모든 name을 없앤다.
		$(".groupCodeId").each(function(i) {
			$(this).attr("name", "");
		});
		
		// 체크 된 목록만 name을 붙인다.
		$(".groupCodeId:checked").each(function(i) {
			$(this).attr("name", "groupCodeList["+i+"]");
		});
	});		

});

// 매핑 된 데이터 삭제
function deleteMapData() {
	$(this).parents("li.mapping_data").remove();
	
	// 데이터 삭제 시 이름을 다시 세팅해준다.
	$(":hidden[name^=eduDateList]").each(function(i) {
		$(this).attr("name", "eduDateList["+i+"]");
	});
}

// 공통 부분 초기화 (에디터, 달력, 언어 선택 기능)
function setPageInit(editor_object) {
	// 스마트에디터 프레임생성
	$("textarea.editor").each(function(i) {
		var editor_id = $("textarea.editor").eq(i).attr("id");
		
		// 에디터 초기화
		nhn.husky.EZCreator.createInIFrame({
			oAppRef			: editor_object,
			elPlaceHolder	: editor_id,
			sSkinURI		: "<c:url value='/common/editor/SmartEditor2Skin.html' />",
			htParams 		: { bUseToolbar : true
							  , bUseVerticalResizer : true
							  ,bUseModeChanger : true }
		});
	});
	
	//달력
	$('#datetimepicker1,#datetimepicker2').datetimepicker({
       	format	: 'YYYY-MM-DD'
        ,dayViewHeaderFormat : 'YYYY년 MM월'
        ,locale : moment.locale('ko')
    });

	// 언어선택(전체 선택 또는 전체 해제 시)
	$("#lang_all").click(function(){
        if ($(this).prop("checked")) {
        	$(":checkbox[name=langchk]").prop("checked", true);		// 언어 전체 선택
            
            $("li[role='presentation']").addClass("show");			// 모든 언어탭을 보여준다.
        }else {
        	$(":checkbox[name=langchk]").prop("checked", false);	// 언어 전체 해제
        	$("#lang_ko").prop("checked", true);					// 한국어 체크박스만 default로 체크 됨
        	
        	// 모든 언어 탭에서 첫번째 노드(한국어)만 제외하고 hide 시킴
        	$("li[role='presentation']:not(:first-child)").removeClass("show").addClass("hide");
        	
        	// 전체 언어 선택 삭제 시 무조건 한국어 상태로 변경 시킴
        	$("li[role='presentation']").removeClass("active");
        	$("li[role='presentation']:first-child").addClass("active");
        	
        	$("div.tab-pane").removeClass("active");
        	$("div.tab-pane:first-child").addClass("active");
        }
    });
	
	// 개별 언어 클릭 시
	$(":checkbox[name=langchk]").click(function(event){
		// 클릭 한 언어 index
		var idx = $(":checkbox[name=langchk]").index($(this));						// (0 : 한국어default)
		var parentList = $("li[role='presentation']:first-child").parent("ul");		// (언어 탭의 부모 리스트 가지고 온다.)

		// 한국어는 default로 사용 한국어 클릭 시 return 시킴.
		if(idx == 0){ return false; }
    	
		if($(this).is(":checked")) {
			parentList.each(function(i) {
				// 여기서 $this는 each 안에서 선택 된 parentList
				$(this).children("li").eq(idx).addClass("show");
			});
		} else {
			parentList.each(function(i) {
				// 여기서 $this는 each 안에서 선택 된 parentList
				var targetList	= $(this).children("li");
				var target		= targetList.eq(idx);
				
				// 해당 언어의 탭을 안 보이게 함.
				target.removeClass("show").addClass("hide");
				
				// 삭제하는 언어가 선택 된 상태였다면 무조건 한국어영역으로 바꿈.
				if(target.hasClass("active")) {
					target.removeClass("active");
					targetList.first().addClass("active");
		        	
		        	// 탭과 함께 컨텐츠 화면도 한국어로 바꿔줌.
		        	$("div.tab-pane:first-child").parent("div").eq(i).children("div.tab-pane").removeClass("active");
		        	$("div.tab-pane:first-child").parent("div").eq(i).children("div.tab-pane:first-child").addClass("active");
				}
			});
		}
		
		// 언어 선택 전체 체크 여부 판단 개별 언어의 갯수로 체크함.
		var len = $(":checkbox[name=langchk]:checked").length;
		
		if(len == 4){
			$("#lang_all").prop("checked", true);
		}else{
			$("#lang_all").prop("checked", false);
		}
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
		  <h1>게시판관리(<c:choose><c:when test="${boardManage.id > 0}">수정</c:when><c:otherwise>추가</c:otherwise></c:choose>)</h1>
		</div>

        <div class="panel panel-warning">
		  	
		  	<!-- searchForm start -->
	       	<form name="searchForm" method="post">
	        	<!-- 조회조건 -->
				<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			</form>
			
		  	<!-- actionForm 시작 -->
		  	<form name="actionForm" method="post">
			  	<!-- hidden 데이터 -->
		  		<input type='hidden' name='id' value='<c:out value='${boardManage.id}' default="0" />' />		<!-- Id가 존재 하면 update 없으면 insert -->

				<!-- 조회조건 -->
				<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
				
				<table class="table dataTable table-bordered">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
	            <tbody>
				<tr>
					<td class="text-center info require" style="vertical-align: middle;">게시판ID(*)</td>
					<td class="text-center">
						<div class='col-lg-3' role="tabpanel" id="boardpn">
							<input type="text" class="form-control" id="boardId" name="boardId" <c:if test="${boardManage.id>0}">readOnly</c:if> value="<c:out value="${boardManage.boardId}" />"   placeholder="<c:out value='${type}'/> 게시판id(영문10자이내)를 입력하세요">
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info require" style="vertical-align: middle;">게시판명(*)</td>
					<td class="text-center">
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">한국어</div>
							 <input type="text" class="col-lg-3 form-control pull-left" id="koName" name="koName" placeholder="한국어" value="<c:out value='${boardManage.koName}' />">
						   </div>
						</div>
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">영어</div>
							 <input type="text" class="col-lg-3 form-control pull-left" id="enName" name="enName" placeholder="영어"value="<c:out value='${boardManage.enName}' />">
						   </div>
						</div>
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">중국어</div>
							 <input type="text" class="col-lg-3 form-control pull-left" id="chName" name="chName" placeholder="중국어"value="<c:out value='${boardManage.chName}' />">
						   </div>
						</div>
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">일국어</div>
							 <input type="text" class="col-lg-3 form-control pull-left" id="jaName" name="jaName" placeholder="일본어"value="<c:out value='${boardManage.jaName}' />">
						   </div>
						</div>
					</td>
				</tr>
				<%-- <tr>
					<td class="text-center info" style="vertical-align: middle;">답변(게시글 외부)</td>
					<td>
						<label class="radio-inline">
						  <input type="radio" name="answerYn" value="Y" <c:if test="${ fn:contains(boardManage.answerYn, 'Y')}">checked</c:if>> 사용
						</label>
						<label class="radio-inline">
						  <input type="radio" name="answerYn" value="N" <c:if test="${ fn:contains(boardManage.answerYn, 'N')}">checked</c:if>> 사용안함
						</label>
					</td>
				</tr> --%>
				<tr>
					<td class="text-center info" style="vertical-align: middle;">댓글(게시글 내부)</td>
					<td>
						<label class="radio-inline">
						  <input type="radio" name="commentYn" value="Y" checked="checked"> 사용
						</label>
						<label class="radio-inline">
						  <input type="radio" name="commentYn" value="N" <c:if test="${ fn:contains(boardManage.commentYn, 'N')}">checked</c:if>> 사용안함
						</label>
					</td>
				</tr>	
				<tr>
					<td class="text-center info" style="vertical-align: middle;">기능별 권한설정</td>
					<td class="text-center">
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">목록보기</div>
							<select class="form-control" id="listAuth" name="listAuth">
									<option value="1" <c:if test="${boardManage.listAuth==1}">selected</c:if>>모두</option>
									<option value="2" <c:if test="${boardManage.listAuth==2}">selected</c:if>>회원</option>
									<option value="3" <c:if test="${boardManage.listAuth==3}">selected</c:if>>관리자</option>
							</select>
						   </div>
						</div>
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">글읽기</div>
							<select class="form-control" id="readAuth" name="readAuth">
									<option value="1" <c:if test="${boardManage.readAuth==1}">selected</c:if>>모두</option>
									<option value="2" <c:if test="${boardManage.readAuth==2}">selected</c:if>>회원</option>
									<option value="3" <c:if test="${boardManage.readAuth==3}">selected</c:if>>관리자</option>
							</select>					   </div>
						</div>
						<%-- <div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">댓글쓰기</div>
							<select class="form-control" id="commentAuth" name="commentAuth">
									<option value="1" <c:if test="${boardManage.commentAuth==1}">selected</c:if>>모두</option>
									<option value="2" <c:if test="${boardManage.commentAuth==2}">selected</c:if>>회원</option>
									<option value="3" <c:if test="${boardManage.commentAuth==3}">selected</c:if>>관리자</option>
							</select>					   </div>
						</div> --%>
						<div class="col-lg-3 form-group" style="margin-top: 8px;">
						   <div class="input-group">
						     <div class="input-group-addon">글쓰기</div>
							<select class="form-control" id="writeAuth" name="writeAuth">
									<option value="1" <c:if test="${boardManage.writeAuth==1}">selected</c:if>>모두</option>
									<option value="2" <c:if test="${boardManage.writeAuth==2}">selected</c:if>>회원</option>
									<option value="3" <c:if test="${boardManage.writeAuth==3}">selected</c:if>>관리자</option>
							</select>					   </div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info">관리그룹지정</td>
					<td>
						<div>
						          관리그룹으로 지정되면 위의 Level에 따른 권한 설정과 관계없이 해당 게시판의 조회, 수정, 삭제 등  게시판의 모든 권한을 갖습니다.<br>
							<c:forEach items="${boardManage.groupCodeList}" var="groupCodetype" varStatus="status">
				                	<c:set var="codeGroups" value="${codeGroups},${groupCodetype}" />
				            </c:forEach>					           
						   <c:forEach items="${groupList}" var="groupList" varStatus="courseStatus">
						   	<label class="checkbox-inline">
							  <input type="checkbox" class="groupCodeId" name="" value="<c:out value="${groupList.id}" />" <c:if test="${ fn:contains(codeGroups, groupList.id)}">checked</c:if>> <c:out value="${groupList.koName}" />
							</label>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info">추천사용</td>
					<td>
						<div>			
						   	<label class="checkbox-inline">
							  <input type="checkbox" name="recommendYn" id="" value="Y" <c:if test="${boardManage.recommendYn=='Y'}">checked</c:if>> 추천사용
							</label>
						   	<label class="checkbox-inline">
							  <input type="checkbox" name="nonrecommendYn" id="" value="Y" <c:if test="${boardManage.nonrecommendYn=='Y'}">checked</c:if>> 비추천사용
							</label>
						</div>
					</td>
				</tr>		
				<tr>
					<td class="text-center info" style="vertical-align: middle;">업로드 파일 개수</td>
					<td>
						<div class="col-lg-3" style="padding-left:0">
							<select class="form-control" id="fileCnt" name="fileCnt">
							<c:forEach var="min" begin="0" end="10" step="1">
	                             <option value="<c:out value='${min}' />" <c:if test="${min==boardManage.fileCnt}">selected</c:if> ><c:out value="${min}" /></option>
	                        </c:forEach>
							</select>
						</div>
					</td>
				</tr>	
				<tr>
					<td class="text-center info" style="vertical-align: middle;">업로드 파일 용량</td>
					<td class="text-center">
						<div class="form-group" style="margin-top: 8px; padding-left: 0;">
						   	<div class="input-group col-lg-3">
						   		<input type="text" class="form-control" name='fileSize' value='<c:out value="${boardManage.fileSize}" default="0" />'/>
	 				    	<div class="input-group-addon">MB</div> 
						   </div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-center info">SNS사용</td>
					<td>
						<label class="radio-inline">
						  <input type="radio" name="snsYn" value="N" checked="checked"> 사용안함
						</label>
						<label class="radio-inline">
						  <input type="radio" name="snsYn" value="Y" <c:if test="${ fn:contains(boardManage.snsYn, 'Y')}">checked</c:if>> 사용
						</label>
					</td>
				</tr>							
				<tr>
					<td class="text-center info" style="vertical-align: middle;">출력우선순위</td>
					<td class="text-center">
						<div class="form-group" style="margin-top: 8px; padding-left: 0;">
						   	<div class="input-group col-lg-5">
						   		<input type="text" class="form-control" name='orderNum' value='<c:out value="${boardManage.orderNum}" default="1" />'/>
	 				    	<div class="input-group-addon">숫자가 높을수록 우선 출력</div> 
						   </div>
						</div>
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
 
</body>

</html>