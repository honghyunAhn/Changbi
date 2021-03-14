<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/course/groupLearnReg' />";
	var delUrl	= "<c:url value='/data/course/groupLearnDel' />";
	var listUrl	= "<c:url value='/admin/course/groupLearnList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'image'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		var _title = $(":hidden[name='id']").val() == "0" ? "저장" : "수정";
		
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			$("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			});

			// 저장 방식(직접호출X)
			// contentLoad("회원추가", regUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert(_title+"되었습니다.");
						
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
		contentLoad("단체연수등록관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 기수 추가 버튼 클릭 시(레이어팝업)
	$("#addCardinal").unbind("click").bind("click", function() {
		// 그룹인 경우만 조회
		var data = {"learnType" : "G"};
		
		openLayerPopup("기수 검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 기수 선택삭제 버튼 클릭 시
	$("#delCardinal").unbind("click").bind("click", function() {
		if($(":checkbox[name='chkCardinalId']:checked").size() > 0) {
			$(":checkbox[name='chkCardinalId']:checked").each(function() {
				$(this).closest("tr").remove();
			});
			
			// 데이터 삭제 시 ID 이름을 다시 세팅해준다.
			$(":text[name^='cardinalList'][name$='id']").each(function(i) {
				$(this).attr("name", "cardinalList["+i+"].id");
			});
			
			// 데이터 삭제 시 limitNum 이름을 다시 세팅해준다.
			$(":text[name^='cardinalList'][name$='limitNum']").each(function(i) {
				$(this).attr("name", "cardinalList["+i+"].limitNum");
			});
		} else {
			alert("삭제 할 기수를 체크해주세요.");
		}
	});
	
	// 기수 전체 선택
	$("#selectCardinalAll").unbind("change").bind("change", function() {
		var isChecked = $(this).prop('checked');
		
		$(":checkbox[name='chkCardinalId']").prop('checked', isChecked);
	});
	
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if($(":hidden[name='id']").val() == "0") {
		$("#delBtn").hide();
	}
});

function setCardinal(cardinal) {
	var isExist = false;
	var sb = new StringBuilder();
	
	$(":text[name^='cardinalList'][name$='id']").each(function() {
		if($(this).val() == cardinal.id) {
			isExist = true;
			return false;
		}
	});

	if(isExist) {
		alert("이미 존재하는 기수입니다.");
	} else {
		var idx = $(":text[name^='cardinalList'][name$='id']").size();
		
		sb.Append("<tr>");
		sb.Append("	<td><input type='checkbox' name='chkCardinalId' value='"+cardinal.id+"' /></td>");
		sb.Append("	<td><input type='text' name='cardinalList["+idx+"].id' value='"+cardinal.id+"' readonly='readonly' /></td>");
		sb.Append("	<td>"+cardinal.name+"</td>");
		sb.Append("	<td>"+cardinal.appStartDate+" ~ "+cardinal.appEndDate+"</td>");
		sb.Append("	<td>"+cardinal.learnStartDate+" ~ "+cardinal.learnEndDate+"</td>");
		sb.Append("	<td><input type='text' name='cardinalList["+idx+"].limitNum' value='0' />명</td>");
		sb.Append("</tr>");
		
		$("#cardinalList").append(sb.ToString());
	}
}

</script>
		
<div class="content_wraper">
	<h3>단체연수등록관리</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='region.code' value='<c:out value="${search.region.code}" default="" />' />
			<input type='hidden' name='useYn' value='<c:out value="${search.useYn}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${groupLearn.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- view start -->
			<h4>단체연수등록관리</h4>
			<dl>
				<dt>단체연수명</dt><dd class="half"><input type="text" name='name' value='<c:out value='${groupLearn.name}' default="" />'></dd>
				<dt>노출기간</dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='startDate'>
	                    <input type='text' name='startDate' class='form-control' value='<c:out value="${groupLearn.startDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
	                ~
	                <div class='input-group date datetimepicker' id='endDate'>
	                    <input type='text' name='endDate' class='form-control' value='<c:out value="${groupLearn.endDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>시도교육청</dt>
				<dd class='half'>
					<select name="region.code">
						<option value="">전체</option>
						<c:forEach items="${region}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq groupLearn.region.code}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
				</dd>
				<dt>교육지원청</dt><dd class="half"><input type="text" name='jurisdiction' value='<c:out value='${groupLearn.jurisdiction}' default="" />'></dd>
				<dt>수강료납입</dt>
				<dd>
					<input type="radio" id="paymentTypeG" name='paymentType' value="G" checked="checked"><label for="paymentType">단체일괄납부</label>
					<input type="radio" id="paymentTypeS" name='paymentType' value="S" <c:if test="${groupLearn.paymentType eq 'S'}">checked="checked"</c:if>><label for="paymentTypeS">개인개별납부</label>
				</dd>
				<dt>접수대상</dt>
				<dd>
					<input type="checkbox" name='targets' value='유' 	<c:if test="${fn:contains(groupLearn.targets, '유')}">checked="checked"</c:if> />유
					<input type="checkbox" name='targets' value='초' 	<c:if test="${fn:contains(groupLearn.targets, '초')}">checked="checked"</c:if> />초
					<input type="checkbox" name='targets' value='중' 	<c:if test="${fn:contains(groupLearn.targets, '중')}">checked="checked"</c:if> />중
					<input type="checkbox" name='targets' value='고' 	<c:if test="${fn:contains(groupLearn.targets, '고')}">checked="checked"</c:if> />고
					<input type="checkbox" name='targets' value='특' 	<c:if test="${fn:contains(groupLearn.targets, '특')}">checked="checked"</c:if> />특
					<input type="checkbox" name='targets' value='전문'	<c:if test="${fn:contains(groupLearn.targets, '전문')}">checked="checked"</c:if> />전문
					<input type="checkbox" name='targets' value='일반인'	<c:if test="${fn:contains(groupLearn.targets, '일반인')}">checked="checked"</c:if> />일반인
				</dd>
				<dt>배너이미지</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='banner.fileId' value='<c:out value="${groupLearn.banner.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/groupLearn/banner' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE)</span>
						</div>
						
						<c:if test="${groupLearn.banner ne null and groupLearn.banner.detailList ne null and fn:length(groupLearn.banner.detailList) > 0}">
							<c:forEach items="${groupLearn.banner.detailList}" var="file" varStatus="status">
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
				<dt>표출순위</dt><dd class="half"><input type="text" name='orderNum' value='<c:out value='${groupLearn.orderNum}' default="1" />'></dd>
				<dt>공개상태</dt>
				<dd class='half'>
					<select name='useYn'>
						<option value='Y'>공개</option>
						<option value='N' <c:if test="${groupLearn.useYn eq 'N'}">selected</c:if>>비공개</option>
					</select>
				</dd>
				<dt>컨텐츠내용</dt>
				<dd>
					<textarea class="editor" id="contents_editor' />" name="contents" rows="10" cols="100" style="width:100%; height:200px;">
						<c:out value="${groupLearn.contents}" />
		  			</textarea>
				</dd>
			</dl>
			
			<!-- 추가 화면 -->
			<div class='cardinal_add'>
				<h4>진행 단체연수기수</h4>
				<button type='button' id='addCardinal'>기수추가</button>
				<button type='button' id='delCardinal'>선택삭제</button>
				<table>
					<thead>
						<tr>
							<th><input type='checkbox' id='selectCardinalAll' /></th>
							<th>기수코드</th>
							<th>기수명</th>
							<th>접수기간</th>
							<th>연수기간</th>
							<th>신청제한인원</th>
						</tr>
					</thead>

					<tbody id='cardinalList'>
						<c:forEach items="${groupLearn.cardinalList}" var="cardinal" varStatus="status">
						<tr>
							<td><input type='checkbox' name='chkCardinalId' value='<c:out value="${cardinal.id}" />' /></td>
							<td><input type='text' name='cardinalList[<c:out value="${status.index}" />].id' value='<c:out value="${cardinal.id}" />' readonly="readonly" /></td>
							<td><c:out value="${cardinal.name}" default="" /></td>
							<td><c:out value="${cardinal.appStartDate}" default="" /> ~ <c:out value="${cardinal.appEndDate}" default="" /></td>
							<td><c:out value="${cardinal.learnStartDate}" default="" /> ~ <c:out value="${cardinal.learnEndDate}" default="" /></td>
							<td><input type='text' name='cardinalList[<c:out value="${status.index}" />].limitNum' value='<c:out value="${cardinal.limitNum}" default="0" />' />명</td>
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