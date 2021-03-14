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
	var regUrl	= "<c:url value='/data/quiz/examSpotReg' />";
	var updUrl	= "<c:url value='/data/quiz/examSpotUpd' />";
	var delUrl	= "<c:url value='/data/quiz/examSpotDel' />";
	var listUrl	= "<c:url value='/admin/quiz/examSpotList' />";
	
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
		var _url	= $(":text[name='id']").val() ? updUrl : regUrl;
		var _title	= $(":text[name='id']").val() ? "수정" : "저장";
		
		if(!$(":text[name='name']").val()) {
			alert("고사장명은 필수입력항목입니다.");
			$(":text[name='name']").focus();
		} else if(!$(":text[name='spot']").val()) {
			alert("장소명은 필수입력항목입니다.");
			$(":text[name='spot']").focus();
		} else if(!$(":text[name='postCode']").val()) {
			alert("주소는 필수입력입니다.");
			$(":text[name='postCode']").focus();
		} else if(!$(":text[name='addr1']").val()) {
			alert("주소는 필수입력입니다.");
			$(":text[name='addr1']").focus();
		} else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

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
		contentLoad("단체연수등록관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 우편번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function() {
		var idx = $("a.search_addr").index($(this));
		
		daumPostcode(idx);
	});
		
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":text[name='id']").val()) {
		$("#delBtn").hide();
	}
});

</script>
		
<div class="content_wraper">
	<h3>출석시험 고사장 관리</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- view start -->
			<h4>고사장관리</h4>
			<dl>
				<dt>고사장코드</dt>
				<dd class="half">
					<input type="text" name='id' value='<c:out value='${examSpot.id}' default="" />' readonly="readonly" />
				</dd>
				<dt>서비스상태</dt>
				<dd class='half'>
					<select name='useYn'>
						<option value='Y'>사용</option>
						<option value='N' <c:if test="${examSpot.useYn eq 'N'}">selected</c:if>>사용안함</option>
					</select>
				</dd>
				<dt>고사장명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" name='name' value='<c:out value='${examSpot.name}' default="" />'>
				</dd>
				<dt>장소명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" name='spot' value='<c:out value='${examSpot.spot}' default="" />'>
				</dd>
				<dt>주소<span class='require'>*</span></dt>
				<dd>
					<div>
						<input type='text' name='postCode' class='zipcode' value='<c:out value="${examSpot.postCode}" />' readonly="readonly" /><a class="btn search_addr" href="javascript:void();">우편번호</a>
					</div>
					<div>
						<input type='text' name='addr1' class='addr w100' value='<c:out value="${examSpot.addr1}" />' />
					</div>
					<div>
						<input type='text' name='addr2' class='etc_addr w100' value='<c:out value="${examSpot.addr2}" />' />
					</div>
				</dd>
				<dt>약도이미지</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='map.fileId' value='<c:out value="${examSpot.map.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/quiz/map' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE)</span>
						</div>
						
						<c:if test="${examSpot.map ne null and examSpot.map.detailList ne null and fn:length(examSpot.map.detailList) > 0}">
							<c:forEach items="${examSpot.map.detailList}" var="file" varStatus="status">
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
				<dt>전화번호</dt>
				<dd class="half"><input type='text' name='tel' value='<c:out value="${examSpot.tel}" default="" />' /></dd>
				<dt>고사장인원제한</dt>
				<dd class="half">
					<input type='text' name='limitNum' value='<c:out value="${examSpot.limitNum}" default="0" />' />
					<span>("0" 입력 시 제한없음.)</span>
				</dd>
				<dt>해당지역</dt>
				<dd>
					<textarea name="appArea" style="width:100%; height:100px;"><c:out value="${examSpot.appArea}" /></textarea>
		  			<span>※ "해당지역" 란에는 고사장에 소속지역 입력, 지역과 지역은 콤마로 구분, 지역과 소속지역은 콜론으로 구분바랍니다.</span><br />
		  			<span>입력 예) 서울,경기:김포,경기:일산    =>  지역과 지역 사이엔 ","를 지역과 소속지역은  ":" 를 입력, 공백은 없습니다.</span>
				</dd>
				<dt>교통안내</dt>
				<dd>
					<textarea class="editor" id="traffic_editor" name="traffic" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${examSpot.traffic}" /></textarea>
				</dd>
			</dl>
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