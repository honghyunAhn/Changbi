<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<link type="text/css" rel="stylesheet" href="/resources/css/ext/bootstrap-datetimepicker/jquery.timepicker.css">
<script type="text/javascript" src="/resources/js/ext/bootstrap-datetimepicker/jquery.timepicker.min.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	
	//timepicker 세팅
	$("#classStartTime, #classEndTime").timepicker({
		'minTime' : '00:00am', // 조회하고자 할 시작 시간 ( 00시 부터 선택 가능하다. )
        'maxTime' : '23:55pm', // 조회하고자 할 종료 시간 ( 23시59분 까지 선택 가능하다. )
        'timeFormat' : 'H:i',
        'step' : 5 //test로 5분단위
    // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
	});
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/course/cardinalReg' />";
	var updUrl	= "<c:url value='/data/course/cardinalUpd' />";
	var delUrl	= "<c:url value='/data/course/cardinalDel' />";
	var listUrl	= "<c:url value='/admin/course/cardinalList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	// file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	// 과정정보 : 수정할때만 노출
	$(":text[name='id']").val() ? $(".course_add").show() : $(".course_add").hide();
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		var _title = $(":text[name='id']").val() ? "수정" : "저장";
		var _url = $(":text[name='id']").val() ? updUrl : regUrl;
		
		if(!$(":text[name='name']").val()) {
			alert("기수명은 필수항목입니다.");
			$(":text[name='name']").focus();
		} else if(!$(":text[name='price']").val()) {
			alert("금액을 입력해주세요.");
			$(":text[name='price']").focus();
		} else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			$("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			});
			
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: _url,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(_title == "저장" ? result.id : result > 0) {
						alert(_title+"되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert(_title+"실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 삭제 버튼
	$("#delBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("기수관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 과정 상세페이지 이동
	$(document).on("click", ".content_edit", function() {
		var data = new Object();
		data.id = $(this).text();
		contentLoad("학습과정관리", "<c:url value='/admin/course/trainProcessEdit' />", data);
	});
	
	// 과정 추가 버튼 클릭 시(레이어팝업)
	$("#addCourse").unbind("click").bind("click", function() {
		var appPossibles = "";
		
		$(":checkbox[name='appPossibles']:checked").each(function(i) {
			appPossibles += $(this).val()+",";
		});
		
		appPossibles = appPossibles.length > 0 ? appPossibles.slice(0, -1) : ""; 
		
		var data = {"learnTypes" : $("#learnType").val(), "appPossibles" : appPossibles};
		
		openLayerPopup("과정 검색", "/admin/common/popup/courseList", data);
	});
	
	// 과정 선택삭제 버튼 클릭 시
	$("#delCourse").unbind("click").bind("click", function() {
		if($(":checkbox[name='chkCourseId']:checked").size() > 0) {
			$(":checkbox[name='chkCourseId']:checked").each(function() {
				$(this).closest("tr").remove();
			});
			
			// 데이터 삭제 시 이름을 다시 세팅해준다.
			$(":text[name^='courseList']").each(function(i) {
				$(this).attr("name", "courseList["+i+"].id");
			});
		} else {
			alert("삭제 할 과정을 체크해주세요.");
		}
	});
	
	// 과정 전체 선택
	$("#selectCourseAll").unbind("change").bind("change", function() {
		var isChecked = $(this).prop('checked');
		
		$(":checkbox[name='chkCourseId']").prop('checked', isChecked);
	});
	
	// 과정서비스 형태 변경 시
	$(":radio[name='courseType']").unbind("change").bind("change", function() {
		if($(this).val() == "S") {
			$(".course_add").show();
		} else {
			$(".course_add").hide();
		}
	});
	
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":text[name='id']").val()) {
		$("#delBtn").hide();
	}
});

function setCourse(course) {
	var isExist = false;
	var sb = new StringBuilder();
	
	$(":text[name^='courseList']").each(function() {
		if($(this).val() == course.id) {
			isExist = true;
			return false;
		}
	});

	if(isExist) {
		alert("이미 존재하는 과정입니다.");
	} else {
		var idx = $(":text[name^='courseList']").size();
		var learnTypes = "";
		
		if(course.learnTypes) {
			var types = course.learnTypes.split(",");
			
			for(var j=0; j<types.length; ++j) {
				if(types[j] == "J") {
					learnTypes += "직무" + course.credit + "/";
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
		sb.Append("	<td><input type='checkbox' name='chkCourseId' value='"+course.id+"' /></td>");
		sb.Append("	<td>"+learnTypes+"</td>");
		sb.Append("	<td><input type='text' name='courseList["+idx+"].id' value='"+course.id+"' readonly='readonly' /></td>");
		sb.Append("	<td>"+course.name+"</td>");
		sb.Append("	<td>"+course.completeTime+"시간</td>");
		sb.Append("	<td>"+(course.acceptYn == "N" ? "신청불가" : "신청가능")+"</td>");
		sb.Append("	<td>"+(course.useYn == "N" ? "중지" : "서비스")+"</td>");
		sb.Append("</tr>");
		
		$("#courseList").append(sb.ToString());
	}
}

</script>
		
<div class="content_wraper">
	<h3>		 
		기수관리
	</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='useYn' value='<c:out value="${search.useYn}" default="" />' />
			<input type='hidden' name='complateYn' value='<c:out value="${search.complateYn}" default="" />' />
			<input type="hidden" name="learnType" value='<c:out value="${search.learnType}" default="J" />' />
			<input type="hidden" name="credits" value='<c:out value="${search.credits}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- 연수타입을 HIDDEN으로 가지고 간다. -->
			<input type="hidden" id="learnType" name="learnType" value='<c:out value="${search.learnType}" default="J" />' />
<%-- 			<input type="hidden" name="credits" value='<c:out value="${search.credits}" default="" />' /> --%>
			<input type="hidden" name='credits' value='1,2'>
			
			<!-- view start -->
			<h4>기본정보</h4>
			<dl>
				<dt>기수명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" name='name' value='<c:out value='${cardinal.name}' default="" />'>
				</dd>
				<dt>기수코드</dt>
				<dd class="half" >
					<input type='text' name='id' value='<c:out value='${cardinal.id}' default="" />' readonly="readonly" />	<!-- Id가 존재 하면 update 없으면 insert --> 
				</dd>
				<dt>모집인원</dt>
				<dd >
					<input type="text" id="recruit" name="recruit" value='<c:out value="${cardinal.recruit}" default="0" />'><label for="recruit">명(0명이면 인원제한없음)</label>
				</dd>

				<dt>접수기간</dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='appStartDate'>
	                    <input type='text' name='appStartDate' class='form-control' value='<c:out value="${cardinal.appStartDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
	                ~
	                <div class='input-group date datetimepicker' id='appEndDate'>
	                    <input type='text' name='appEndDate' class='form-control' value='<c:out value="${cardinal.appEndDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>연수기간</dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='learnStartDate'>
	                    <input type='text' name='learnStartDate' class='form-control' value='<c:out value="${cardinal.learnStartDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
	                ~
	                <div class='input-group date datetimepicker' id='learnEndDate'>
	                    <input type='text' name='learnEndDate' class='form-control' value='<c:out value="${cardinal.learnEndDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
					이수발급일 : (JPT 특별시험의 경우 시험일)
					<div class='input-group date datetimepicker' id='issueDate'>
	                    <input type='text' name='issueDate' class='form-control' value='<c:out value="${cardinal.issueDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>수업일</dt>
				<dd>
					<input type="checkbox" class="checkBox" name="classDay" value="월" <c:if test="${fn:contains(cardinal.classDay, '월')}">checked="checked"</c:if>>월
					<input type="checkbox" class="checkBox" name="classDay" value="화" <c:if test="${fn:contains(cardinal.classDay, '화')}">checked="checked"</c:if>>화
					<input type="checkbox" class="checkBox" name="classDay" value="수" <c:if test="${fn:contains(cardinal.classDay, '수')}">checked="checked"</c:if>>수
					<input type="checkbox" class="checkBox" name="classDay" value="목" <c:if test="${fn:contains(cardinal.classDay, '목')}">checked="checked"</c:if>>목
					<input type="checkbox" class="checkBox" name="classDay" value="금" <c:if test="${fn:contains(cardinal.classDay, '금')}">checked="checked"</c:if>>금
					<input type="checkbox" class="checkBox" name="classDay" value="토" <c:if test="${fn:contains(cardinal.classDay, '토')}">checked="checked"</c:if>>토
					<input type="checkbox" class="checkBox" name="classDay" value="일" <c:if test="${fn:contains(cardinal.classDay, '일')}">checked="checked"</c:if>>일
				</dd>
				<dt>수업시간</dt>
				<dd>
					<input type="text" id="classStartTime" name="classStartTime" placeholder="시간선택" value='<c:out value="${cardinal.classStartTime}" />' 
					style="width: 80px; height: 90%; margin-top: 2px; margin-bottom: 3px;">
					~
					<input type="text" id="classEndTime" name="classEndTime" placeholder="시간선택" value='<c:out value="${cardinal.classEndTime}" />' 
					style="width: 80px; height: 90%; margin-top: 2px; margin-bottom: 3px;">
				</dd>
				<dt>교육비</dt>
				<dd class="half">
					<input type="text" name="price" value="${cardinal.price}" placeholder="금액 입력">
				</dd>
				<dt>이수처리</dt>
				<dd class="half">
					<select name='complateYn'>
						<option value="N" <c:if test="${cardinal.complateYn eq 'N'}">selected</c:if>>이수미처리</option>
						<option value="Y" <c:if test="${cardinal.complateYn eq 'Y'}">selected</c:if>>이수처리</option>
					</select>
				</dd>
				<dt>상태구분</dt>
				<dd class="half">
					<select name='useYn'>
						<option value="Y" <c:if test="${cardinal.useYn eq 'Y'}">selected</c:if>>서비스</option>
						<option value="N" <c:if test="${cardinal.useYn eq 'N'}">selected</c:if>>중지</option>
					</select>
				</dd>
				<dt>수료조건</dt>
				<dd>
					<table>
						<thead>
							<th colspan="2">평가방법</th>
							<th>비중</th>
							<th>배점</th>
						</thead>
						<tbody>
							<tr>
								<td rowspan="3">평가 항목</td>
								<td>과제</td>
								<td><input type="text" id="compPercentQuiz" name="compPercentQuiz" value="<c:out value="${cardinal.compPercentQuiz}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreQuiz" name="compScoreQuiz" value="<c:out value="${cardinal.compScoreQuiz}" default="0" />" />
								<span>점</span></td>
							</tr>
							
							<tr>
								<td>시험</td>
								<td><input type="text" id="compPercentExam" name="compPercentExam" value="<c:out value="${cardinal.compPercentExam}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreExam" name="compScoreExam" value="<c:out value="${cardinal.compScoreExam}" default="0" />" />
								<span>점</span></td>
							</tr>
							<tr>
								<td>진도율</td>
								<td><input type="text" id="compPercentProg" name="compPercentProg" value="<c:out value="${cardinal.compPercentProg}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreProg" name="compScoreProg" value="<c:out value="${cardinal.compScoreProg}" default="0" />" />
								<span>점</span></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th colspan="2">수료기준</th>
								<td colspan="2"><span>총점</span><input type="text" name="completeTotal" value="<c:out value="${cardinal.completeTotal}" default="0" />" />
					<span>점 이상</span></td></td>
							</tr>
						</tfoot>
					</table>
				</dd>
			</dl>
			
			<!-- 과정 추가 화면 -->
			
			<div class='course_add' style="display: <c:if test="${cardinal.courseType eq 'A'}">none;</c:if>">
				<h4>학습과정 정보</h4>
				<!--  
				<button type='button' id='addCourse'>과정추가</button>
				<button type='button' id='delCourse'>선택삭제</button>
				-->
				<table>
					<thead>
						<tr>
							<!--  <th><input type='checkbox' id='selectCourseAll' /></th>-->					
							<th>과정코드</th>
							<th>과정명</th>
							<th>이수시간</th>
							<th>신청</th>
							<th>상태</th>
						</tr>
					</thead>

					<tbody id='courseList'>
						<c:forEach items="${cardinal.courseList}" var="course" varStatus="status">
						<tr>
							<!--  <td><input type='checkbox' name='chkCourseId' value='<c:out value="${course.id}" />' /></td>	-->						
							<!-- <td><input type='text' name='courseList[<c:out value="${status.index}" />].id' value='<c:out value="${course.id}" />' readonly="readonly" /></td> -->
							<td class="content_edit"><c:out value="${course.id}" /></td> 
							<td><c:out value="${course.name}" default="" /></td>
							<td><c:out value="${course.completeTime}" default="0" />시간</td>
							<td>
								<c:choose>
									<c:when test="${course.acceptYn eq 'N'}">신청불가</c:when>
									<c:otherwise>신청가능</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${course.useYn eq 'N'}">중지</c:when>
									<c:otherwise>서비스</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			 
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->