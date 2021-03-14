<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/member/managerReg' />";
	var delUrl	= "<c:url value='/data/member/managerDel' />";
	var listUrl	= "<c:url value='/admin/member/managerList' />";
	
	// API
	var idCheckUrl	= "<c:url value='/data/member/managerIdCheck' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		// 등록 인 경우 체크 사항
		if(!$(":hidden[name='hiddenId']").val()) {
			// 등록일 경우 패스워드가 없으면  return
			if(!$(":text[name='id']").val()) {
				alert("아이디를 입력하세요.");
				$(":text[name='id']").focus();
				
				return false;
			} else if($(":text[name='id']").val() != $("#dupCheckId").val()) {
				alert("아이디 중복 체크를 하세요!");
				
				return false;
			} else if(!$(":password[name='pw']").val()) {
				alert("비밀번호를 입력해주세요!");
				$(":password[name='pw']").focus();
				
				return false;
			}
		}
		
		if($(":password[name='pw']").val() && ($(":password[name='pw']").val() != $(":password[name='rePw']").val())) {
			alert("비밀번호와 비밀번호 확인이 다릅니다.");
			
			$(":password[name='rePw']").val("");
			$(":password[name='rePw']").focus();
		} else if(!$(":text[name='name']").val()) {
			alert("이름을 입력하세요.")
			
			$(":text[name='name']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// 저장 방식(직접호출X)
			// contentLoad("회원추가", regUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("저장실패했습니다.");
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
			// 저장 방식(직접호출X)
			// contentLoad("회원삭제", delUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("정상적으로 삭제 되었습니다.");
						
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
		var title = ($("#grade").val() == "1" ? "튜터관리" 
				  : ($("#grade").val() == "8" ? "관리자관리"
				  : ($("#grade").val() == "2" ? "강사관리" : "업체관리" ))); 
		
		// ajax로 load
		contentLoad(title, listUrl, $("form[name='searchForm']").serialize());
	});
	
	// ID 입력 마다 중복 체크 다시 실행 또는 이미 중복 체크 되었던 ID면 버튼 사라짐
	$(":text[name='id']").unbind("input").bind("input", function() {
		if($(":text[name='id']").val()) {
			if($(":text[name='id']").val() == $("#dupCheckId").val()) {
				$("#idCheckBtn").hide();
			} else {
				$("#idCheckBtn").show();
			}
		}
	});
	
	// ID 중복 체크 버튼 클릭 시
	$("#idCheckBtn").unbind("click").bind("click", function() {
		if(!$(":text[name='id']").val()) {
			alert("아이디를 입력해주세요.");
			$(":text[name='id']").focus();
		} else if($(":text[name='id']").val() == $("#dupCheckId").val()) {
			alert("사용가능한 아이디입니다.");
		} else {
			var data = {"id" : $(":text[name='id']").val()};
			
			$.ajax({
				type	: "post",
				url		: idCheckUrl,
				data	: data,
				dataType: "json",
				success	: function(result) {
					if(result > 0) {
						alert("이미 존재하는 아이디입니다.");
						$(":text[name='id']").focus();
					} else {
						alert("사용 가능한 아이디입니다.");

						$("#idCheckBtn").hide();
						
						$("#dupCheckId").val($(":text[name='id']").val());
						$(":password[name='pw']").focus();
					}
				},
				error	: function(e) {
					alert(e.responseText);
				}
			});
		}
	});
	
	// 공지사항 버튼 클릭 시
	$("#noticeBtn").unbind("click").bind("click", function() {
		var data = new Object();
		
		data.boardType = 1;
		data.noticeType = 5;
		data.teacherId = $(":hidden[name='hiddenId']").val();
		
		openLayerPopup("공지사항", "/admin/common/popup/boardList", data);
	});
	
	// Q&A 버튼 클릭 시
	$("#qnaBtn").unbind("click").bind("click", function() {
		var data = new Object();
		
		data.boardType = 4;
		data.teacherId = $(":hidden[name='hiddenId']").val();

		openLayerPopup("QnA", "/admin/common/popup/boardList", data);
	});
	
	// TCC 추가 버튼 클릭 시(레이어팝업)
	$("#addTcc").unbind("click").bind("click", function() {
		var data = null;
		
		openLayerPopup("TCC 영상 추가", "/admin/common/popup/tccReg", data);
	});
	
	// 과정 선택삭제 버튼 클릭 시
	$("#delTcc").unbind("click").bind("click", function() {
		if($(":checkbox[name='chkTccId']:checked").size() > 0) {
			$(":checkbox[name='chkTccId']:checked").each(function() {
				$(this).closest("tr").remove();
			});
			
			// 데이터 삭제 시 이름을 다시 세팅해준다.
			$("td.tcc_list_num").each(function(i) {
				$(this).html(i);
			});
			$(":text[name^='tccList'][name$='title']").each(function(i) {
				$(this).attr("name", "tccList["+i+"].title");
			});
			$(":text[name^='tccList'][name$='url']").each(function(i) {
				$(this).attr("name", "tccList["+i+"].url");
			});
			$(":hidden[name^='tccList'][name$='useYn']").each(function(i) {
				$(this).attr("name", "tccList["+i+"].useYn");
			});
		} else {
			alert("삭제 할 TCC 영상을 선택해주세요.");
		}
	});
	
	// 과정 전체 선택
	$("#selectTccAll").unbind("change").bind("change", function() {
		var isChecked = $(this).prop('checked');
		
		$(":checkbox[name='chkTccId']").prop('checked', isChecked);
	});
	
	// 과정 추가 버튼 클릭 시(레이어팝업)
	$("#addCourse").unbind("click").bind("click", function() {
		var data = null;
		
		openLayerPopup("과정 검색", "/admin/common/popup/courseList", data);
	});
	
	// 과정 선택삭제 버튼 클릭 시
	$("#delCourse").unbind("click").bind("click", function() {
		if($(":checkbox[name='chkCourseId']:checked").size() > 0) {
			$(":checkbox[name='chkCourseId']:checked").each(function() {
				$(this).closest("tr").remove();
			});
			
			// 데이터 삭제 시 이름을 다시 세팅해준다.
			$(":text[name^='courseList'][name$='id']").each(function(i) {
				$(this).attr("name", "courseList["+i+"].id");
			});
			
			// 데이터 삭제 시 persons 이름을 다시 세팅해준다.
			$(":text[name^='courseList'][name$='persons']").each(function(i) {
				$(this).attr("name", "courseList["+i+"].persons");
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
});

function setTcc(tcc) {
	var isExist = false;
	var sb = new StringBuilder();
	
	$(":text[name^='tccList'][name$='url']").each(function() {
		if($(this).val() == tcc.url) {
			isExist = true;
			return false;
		}
	});

	if(isExist) {
		alert("이미 존재하는 TCC 영상 URL 입니다.");
	} else {
		var idx = $(":text[name^='tccList'][name$='url']").size();

		sb.Append("<tr>");
		sb.Append("	<td><input type='checkbox' name='chkTccId' value='"+tcc.url+"' /></td>");
		sb.Append("	<td class='tcc_list_num'>"+(idx+1)+"</td>");
		sb.Append("	<td><input type='text' class='border_none' name='tccList["+idx+"].title' value='"+tcc.title+"' readonly='readonly' /></td>");
		sb.Append("	<td><input type='text' class='border_none' name='tccList["+idx+"].url' value='"+tcc.url+"' readonly='readonly' /></td>");
		sb.Append("	<td>");
		sb.Append("		<input type='hidden' name='tccList["+idx+"].useYn' value='"+tcc.useYn+"' />");
		sb.Append(		tcc.useYn == "N" ? "게시안함" : "게시함");
		sb.Append("	</td>");
		sb.Append("</tr>");
		
		$("#tccList").append(sb.ToString());
	}
}

function setCourse(course) {
	var isExist = false;
	var sb = new StringBuilder();
	
	$(":text[name^='courseList'][name$='id']").each(function() {
		if($(this).val() == course.id) {
			isExist = true;
			return false;
		}
	});

	if(isExist) {
		alert("이미 존재하는 과정입니다.");
	} else {
		var idx = $(":text[name^='courseList'][name$='id']").size();
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
		sb.Append("	<td><input type='text' name='courseList["+idx+"].persons' value='0' /></td>");
		sb.Append("</tr>");
		
		$("#courseList").append(sb.ToString());
	}
}

</script>
		
<div class="content_wraper">
	<h3>
	<c:choose>
		<c:when test="${search.grade eq 1}">튜터관리</c:when>
		<c:when test="${search.grade eq 2}">강사관리</c:when>
		<c:when test="${search.grade eq 3}">업체관리</c:when>
		<c:when test="${search.grade eq 8}">관리자관리</c:when>
	</c:choose>
	</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<!-- 조회조건 -->
        	<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='useYn' value='<c:out value="${search.useYn}" default="" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- 등급설정(같은 화면을 다른 등급으로 사용하기 때문) -->
        	<input type="hidden" id="grade" name="grade" value='<c:out value="${search.grade}" default="8" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			
			<!-- hidden 데이터 추가인 경우 처리하기 위해 임시 저장 -->
			<input type='hidden' name='hiddenId' value='<c:out value='${manager.id}' default="" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- ID 중복 체크 값 저장 시킴 -->
		  	<input type='hidden' id='dupCheckId' value='' />
		  	
		  	<!-- 등급 설정 -->
		  	<input type="hidden" name="grade" value='<c:out value="${search.grade}" default="8" />' />
			
			<!-- view start -->
			<h4>기본정보</h4>
			<dl>
				<dt>아이디<span class='require'>*</span></dt>
				<dd>
					<input type='text' class='w40' name='id' value='<c:out value="${manager.id}" default="" />' <c:if test="${manager.id ne null and manager.id ne ''}">readonly='readonly'</c:if> />
					<c:if test="${empty manager.id}">
						<a class="btn" id='idCheckBtn' href="javascript:void();">아이디중복체크</a>
					</c:if>
				</dd>
				<dt>비밀번호<span class='require'>*</span></dt>
				<dd><input type='password' class='w40' name='pw' value='' placeholder='비밀번호를 입력하세요' /></dd>
				<dt>비밀번호확인<span class='require'>*</span></dt>
				<dd><input type='password' class='w40' name='rePw' value='' placeholder='비밀번호를 입력하세요' /></dd>
				<dt>성명<span class='require'>*</span></dt>
				<dd class='half'><input type="text" class='w60' name='name' value='<c:out value='${manager.name}' />'></dd>
				<dt>서비스상태</dt>
				<dd class='half'>
					<input type="radio" id="useY" name='useYn' value="Y" checked="checked"><label for="useY">정상</label>
					<input type="radio" id="useN" name='useYn' value="N" <c:if test="${manager.useYn eq 'N'}">checked="checked"</c:if>><label for="useN">중지</label>
				</dd>
				<dt>전자메일</dt>
				<dd class='half'><input type='text' class='w60' name='email' value='<c:out value="${manager.email}" />' /></dd>
				<dt>휴대전화</dt>
				<dd class='half'><input type='text' class='w60' name='phone' value='<c:out value="${manager.phone}" />' /></dd>
				<dt>일반전화</dt>
				<dd class='half'><input type='text' class='w60' name='tel' value='<c:out value="${manager.tel}" />' /></dd>
				<dt>팩스전화</dt>
				<dd class='half'><input type='text' class='w60' name='fax' value='<c:out value="${manager.fax}" />' /></dd>
				
				<c:if test="${search.grade eq '2'}">
					
					<!-- 공지사항, QnA는 강사 가입 후 사용 가능 -->
					<c:if test="${!empty manager.id}">
					<dt>강사공지사항</dt>
					<dd class='half'>
						<a class='btn' id='noticeBtn' href='javascript:void();'>공지사항</a>
					</dd>
					<dt>강사Q&amp;A</dt>
					<dd class='half'>
						<a class='btn' id='qnaBtn' href='javascript:void();'>Q&amp;A</a>
					</dd>
					</c:if>
				<dt>강사과정분류</dt>
				<dd>
					<select name="courseCode.code">
						<option value=''>대표과정분류</option>
						<c:forEach items="${courseList}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq manager.courseCode.code}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>						
					</select>
				</dd>
				<dt>프로필사진</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='photoFile.fileId' value='<c:out value="${manager.photoFile.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/member' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE)</span>
						</div>
						
						<c:if test="${manager.photoFile ne null and manager.photoFile.detailList ne null and fn:length(manager.photoFile.detailList) > 0}">
							<c:forEach items="${manager.photoFile.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
									<img style='width: 200px; height: 200px; cursor: pointer;' src='<c:out value="${file.urlPath}" />' />
								</div>
								<div class='file_info' style='padding-left: 5px;'>
									<input type='hidden' class='attach_file_name'			value='<c:out value="${file.fileName}" />' />
									<input type='hidden' class='attach_file_path'			value='<c:out value="${file.filePath}" />' />
									<input type='hidden' class='attach_file_size'			value='<c:out value="${file.fileSize}" default="0" />' />
									<input type='hidden' class='attach_origin_file_name'	value='<c:out value="${file.originFileName}" />' />
									<input type='hidden' class='attach_url_path'			value='<c:out value="${file.urlPath}" />' />
									<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />
								</div>
							</div>
							</c:forEach>
						</c:if>
					</div>
				</dd>
				<dt>약력</dt>
				<dd>
					<textarea class="editor" id="profile_editor" name="profile" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${manager.profile}" /></textarea>
				</dd>
				</c:if>
			</dl>
			
			<c:if test="${search.grade eq '2'}">
			<div class='tcc_add' style="">
				<h4>TCC 영상</h4>
				<button type='button' id='addTcc'>영상추가</button>
				<button type='button' id='delTcc'>선택삭제</button>
				<table>
					<thead>
						<tr>
							<th><input type='checkbox' id='selectTccAll' /></th>
							<th>연번</th>
							<th>영상제목</th>
							<th>영상파일URL</th>
							<th>게시유무</th>
						</tr>
					</thead>
					<tbody id='tccList'>
						<c:forEach items="${manager.tccList}" var="tcc" varStatus="status">
						<tr>
							<td><input type='checkbox' name='chkTccId' value='<c:out value="${tcc.url}" />' /></td>
							<td class='tcc_list_num'><c:out value="${status.count}" /></td>
							<td><input type='text' class='border_none' name='tccList[<c:out value="${status.index}" />].title' value='<c:out value="${tcc.title}" default="" />' readonly="readonly" /></td>
							<td><input type='text' class='border_none' name='tccList[<c:out value="${status.index}" />].url' value='<c:out value="${tcc.url}" default="" />' readonly="readonly" /></td>
							<td>
								<input type='hidden' name='tccList[<c:out value="${status.index}" />].useYn' value='<c:out value="${tcc.useYn}" default="Y" />' />
								<c:choose>
									<c:when test="${tcc.useYn eq 'N'}">게시안함</c:when>
									<c:otherwise>게시함</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:forEach> 
					</tbody>
				</table>
			</div>
			</c:if>
			
			<div class='course_add' style="">
				<h4>관리담당교과지정</h4>
				<button type='button' id='addCourse'>과정추가</button>
				<button type='button' id='delCourse'>선택삭제</button>
				<table>
					<thead>
						<tr>
							<th><input type='checkbox' id='selectCourseAll' /></th>
							<th>연수타입</th>
							<th>과정코드</th>
							<th>과정명</th>
							<th>이수시간</th>
							<th>배당인원</th>
						</tr>
					</thead>
					<tbody id='courseList'>
						<c:forEach items="${manager.courseList}" var="course" varStatus="status">
						<tr>
							<td><input type='checkbox' name='chkCourseId' value='<c:out value="${course.id}" />' /></td>
							<td>
								<c:set var="learnTypes" value="" />
								
								<c:if test="${fn:contains(course.learnTypes, 'J')}">
									<c:set var="learnTypes" value="${learnTypes}직무${course.credit}/" />
								</c:if>
								<c:if test="${fn:contains(course.learnTypes, 'S')}">
									<c:set var="learnTypes" value="${learnTypes}자율/" />
								</c:if>
								<c:if test="${fn:contains(course.learnTypes, 'M')}">
									<c:set var="learnTypes" value="${learnTypes}집합/" />
								</c:if>
								<c:if test="${fn:contains(course.learnTypes, 'G')}">
									<c:set var="learnTypes" value="${learnTypes}단체/" />
								</c:if>
								
								<c:if test="${fn:length(learnTypes) > 0}">
									<c:set var="learnTypes" value="${fn:substring(learnTypes, 0, fn:length(learnTypes)-1)}" />
								</c:if>
								<c:out value="${learnTypes}" default="" />
							</td>
							<td>
								<input type='text' name='courseList[<c:out value="${status.index}" />].id' value='<c:out value="${course.id}" />' readonly="readonly" />
							</td>
							<td><c:out value="${course.name}" default="" /></td>
							<td><c:out value="${course.completeTime}" default="0" />시간</td>
							<td>
								<input type='text' name='courseList[<c:out value="${status.index}" />].persons' value='<c:out value="${course.persons}" default="0" />' />
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
			<c:if test="${not empty manager.id}">
				<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->