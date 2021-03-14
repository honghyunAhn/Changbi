<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	
	$('.js-example-basic-single').select2();
	
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	    var val = $(this).val();
	    if (val==0) {
	    	$(this).val($(this).val().replace(/[^1-9]/g,""));	
		}
	    if(val < 0 || val > 1000) {
	        alert("1~1000 범위로 입력해 주십시오.");
	        $(this).val('');
	    }
	    
	});
	$('input[type="checkbox"][name="checkNeedFile"]').click(function(){
        if ($(this).prop('checked')
        && $('input[type="checkbox"][name="checkNeedFile"]:checked').size()>2) {
            $(this).prop('checked', false);
     alert('세개 이상 선택할 수 없습니다.');
        }
    });
	
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
			alert("기수명은 필수항목입니다..");
			$(":text[name='name']").focus();
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
	searchList();
	
});

function clearInput(){
	/* 텍스트박스 지우는 부분 */
	var el = document.getElementsByClassName('input-text');
	for(var i=0; i<el.length; i++){
		el[i].value = '';
	}
	/* 체크(라디오)박스 지우는 부분 */
	var el = document.getElementsByClassName('input-radio');
	for(var i=0; i<el.length; i++){
		el[i].checked = false;
		}
	}
	
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

function searchListGisu(seq){
	var sb = new StringBuilder();
	var newSeq = seq;
	var Url	= "<c:url value='/student/TestManagement/searchGisuList' />";
	$.ajax({
		type	: "post",
		data 	: newSeq,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<select class="js-example-basic-single" id="gisuList" name="state" onchange="categorySetting()">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				if (i == 0) {
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
					continue;
				}
				sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
	 		}
	 		sb.Append('</select>');
			$('#gisuSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
			categorySetting();
	 		}
		});
}


function searchList(){
	var sb = new StringBuilder();
	var firstGisu = 0;
	var Url	= "<c:url value='/student/TestManagement/searchCirriculumList' />";
	$.ajax({
		type	: "post",
		url		: Url,
		async	: false,
		success : function(result){
			$("#gwajeongSelector").html("");
			sb.Append('<select class="js-example-basic-single" name="state" id="gisuValue" onchange="searchListGisu(this.value);">">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				 if (i == 0) {
					 firstGisu = map.CRC_SEQ;
				sb.Append('<option value="" disabled selected hidden>과정명을 선택해주세요..</option>');
				sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
					continue;
				} 
				sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
	 		}
	 		sb.Append('</select>');
			$('#gwajeongSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
	 		}
		});
}


function categorySetting(){
	var sb = new StringBuilder();
	var value = $("#gisuList").val();
	var Url	= "<c:url value='/student/TestManagement/searchCategoryList' />";
	if(value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length)){
		alert("기수명이 설정되지 않았습니다. 설정부탁드립니다.");
		return;
		}
	var allData = {"gisu_id" : value, "crc_id" : $("#gisuValue").val()};
		$.ajax({
			url		: Url,
			data 	: allData,
			type	: "post",
			success	: function(result){
				$("#categoryRadio").html("");
				if (result.length == 0) {
					alert("카테고리가 하나도없습니다. 카테고리 설정 창으로!!");
					sb.Append('<a class="btn align_right primary" id=categorySetting onclick="openLayerPopup()">설정하기</a>');
					$("#categoryRadio").html(sb.ToString());
					return;
				}
				sb.Append('');
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					if (i == 0) {
						sb.Append('<input type="radio" name="categoryType" value="'+map.CAT_SEQ+'" checked="checked"><label>'+map.CAT_NM+'</label>');
						continue;
					}
						sb.Append('<input type="radio" name="categoryType" value="'+map.CAT_SEQ+'"><label>'+map.CAT_NM+'</label>');
				}
				$("#categoryRadio").html(sb.ToString());
			}
		});
	}

function submitt(){
	var alldata = 
				{	"gisu_id"			:	$("#gisuList").val(),
					"crc_id"			:	$("#gisuValue").val(),
					"cat_seq"			:	$("input[name=categoryType]:checked").val(),
					"total_score"		:	$("#total").val(),
					"retest_time"		:	$("#reTest").val(),
					"test_nm"			:	$("#recruit").val(),
					"test_start_date"	:	$("#startDate").val(),
					"test_end_date"		:	$("#endDate").val(),
					"test_content"		:	$("#content").val()
				};
	
	
	if (checkDate($("#startDate").val()) > checkDate($("#endDate").val())) {
		alert("일정 설정이 잘못되었습니다..");
		return false;
	}
	if ($("#gisuList").val() == null || $("#gisuList").val() == '' || $("#gisuValue").val() == null || $("#gisuValue").val() == '') {
		alert('과정과 기수 설정이 안되있습니다.');
		return false;
	}
	if ($("#recruit").val() == '' ||  $("#recruit").val() == ' ' || $("#recruit").val() == null) {
		alert('시험명을 입력해주세요.');
		return false;
	}
	var Url = "<c:url value='/student/TestManagement/insertTestInfo' />";
	$.ajax({
		url		: Url,
		data 	: alldata,
		type	: "post",
		success : function(){
			alert("저장완료!!");
			}
		});
	
	
}
function checkDate(str) {
    var y = str.substr(0, 4);
    var m = str.substr(5, 2);
    var d = str.substr(8, 2);
    return new Date(y,m-1,d);
}

</script>
		
<div class="content_wraper">
	<h3>		 
		시험 생성
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
				<dt>과정명<span class='require'>*</span></dt>
				<dd class="half" id="gwajeongSelector">
					<%-- <input type="text" name='name' value='<c:out value='${cardinal.name}' default="" />'> --%>
					<select class="js-example-basic-single" name="state">

					</select>
				</dd>
				<dt>카테고리<span class='require'>*</span></dt>
				<dd  class="half" id="categoryRadio">
					
				</dd>
				<dt>기수명<span class='require'>*</span></dt>
				<dd class="half" id="gisuSelector">
				<select class="js-example-basic-single" name="state" id="gisuSelector">
				</select>
						<%-- <input type="text" name='name' value='<c:out value='${cardinal.name}' default="" />'> --%>
			           <%-- 		<input type='text' name='id' value='<c:out value='${cardinal.id}' default="" />' readonly="readonly" />	<!-- Id가 존재 하면 update 없으면 insert --> --%>	
			 </dd>
				
				<dt>총 점수 설정</dt>
				<dd class="half">
					<input type="text" id="total" numberOnly style="margin: 0px;border-radius: 3px; cursor: default;width: 39.5%;" placeholder="숫자 입력" value="100">
				</dd>
				<dt>시험명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" id="recruit" name="recruit" placeholder="시험명 입력" style="margin: 0px;border-radius: 3px;width: 75%;" onclick="clearInput()">
				</dd>
				<dt>재응시 횟수</dt>
				<dd class="half">
					<select id="reTest" name='dupLimit' class="js-states form-control" style="width: 39.5%;">
						<option value="0">0번</option>
						<c:forEach var="i" begin="1"  end="3" step="1">
						<option value="${i}" <c:if test="${cardinal.dupLimit eq i}">selected="selected"</c:if>>${i}번</option>
						</c:forEach>
					</select>
				</dd>

				<dt>시험 일정</dt>
				<dd>
					<div class='input-group date datetimepicker'  id="appStartDate" style="width: 40%;margin-right: 1%;">
	                    <input type='text' name='appStartDate' id="startDate" class='form-control'/>
	                    <span class='input-group-addon' id="startDate2">
	                        <span class='glyphicon glyphicon-calendar' id="startDate3" ></span>
	                    </span>
	                </div>
	                ~
	                <div class='input-group date datetimepicker' id='appEndDate' style="width: 40%;margin-left: 1%">
	                    <input type='text' name='appEndDate' id="endDate" class='form-control'/>
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>추가 내용</dt>
				<dd class="half">
					<input type="file" style="margin: 0px;"id="uploadFile">
  				</dd>
				<dt>제출파일 여부</dt>
				<dd class="half">
					 <label>
     					 <input type="checkbox" name="checkNeedFile"> 유
   					 </label>
   					 <label>
     					 <input type="checkbox" name="checkNeedFile"> 무
   					 </label>
 					
				</dd>
				<dt>시험내용<span class='require'>*</span></dt>
				<dd>
					<textarea cols="50" id="content" rows="10" style="resize: none;overflow: scroll;overflow-x: hidden;border-radius: 3px; " placeholder="[시험 범위 및 내용]"></textarea>
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
							<td><c:out value="${course.id}" /></td> 
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
			<a id="listBtn" class="btn align_right" href="javascript:contentLoad('시험 내역','/admin/studentManagement/studentTestManagement');">>리스트</a>
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			<a onclick="submitt()" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->