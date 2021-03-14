<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/basic/bannerReg' />";
	var delUrl	= "<c:url value='/data/basic/bannerDel' />";
	var listUrl	= "<c:url value='/admin/basic/bannerList' />";
	
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
		if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
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
		// ajax로 load
		contentLoad("배너관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
	// 배너위치에 따른 권장이미지사이즈 설정
	$("select[name='position']").change(function() {
		var selectedVal = $(this).val();
		var imgSize = '';
		if (selectedVal == '1') {
			imgSize = '1920*940px';
		} else if (selectedVal == '2') {
			imgSize = '1920*500px'
		} else if (selectedVal == '3') {
			imgSize = '1920*160px';
		} else if (selectedVal == '4') {
			imgSize = '340*350px';
		}
		$(".file_upload_info").html("(파일갯수 : 1개, 파일크기 : 100M, 권장이미지사이즈 : "+imgSize+" )")
	});
});

</script>
		
<div class="content_wraper">
	<h3>타이틀</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${banner.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- 배너 사용 여부 -->
			<input type='hidden' name='useYn' value='<c:out value="${banner.useYn}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>배너위치</dt>
				<dd>
					<select name='position'>
						<option value="1" <c:if test="${banner.position eq '1'}">selected="selected"</c:if>>최상단</option>
						<option value="2" <c:if test="${banner.position eq '2'}">selected="selected"</c:if>>메인</option>
						<option value="3" <c:if test="${banner.position eq '3'}">selected="selected"</c:if>>띠</option>
						<option value="4" <c:if test="${banner.position eq '4'}">selected="selected"</c:if>>Hot&New</option>
					</select>
				</dd>	
				<dt>배너명</dt>
				<dd>
					<input type="text" name="title" value="<c:out value='${banner.title}'/>" />
				</dd>
				<dt>배너이미지</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='img1.fileId' value='<c:out value="${banner.img1.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/banner/files' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>
								<c:choose>
									<c:when test="${banner.position eq '2'}">(파일갯수 : 1개, 파일크기 : 100M, 권장이미지사이즈 : 1920*500px)</c:when>
									<c:when test="${banner.position eq '3'}">(파일갯수 : 1개, 파일크기 : 100M, 권장이미지사이즈 : 1920*160px)</c:when>
									<c:when test="${banner.position eq '4'}">(파일갯수 : 1개, 파일크기 : 100M, 권장이미지사이즈 : 340*350px)</c:when>
									<c:otherwise>(파일갯수 : 1개, 파일크기 : 100M, 권장이미지사이즈 : 1920*940px)</c:otherwise>
								</c:choose>
							</span>
						</div>
						
						<c:if test="${banner.img1 ne null and banner.img1.detailList ne null and fn:length(banner.img1.detailList) > 0}">
							<c:forEach items="${banner.img1.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<span>${file.originFileName}</span>
								<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
									<%-- <input type='button' value='<c:out value="${file.originFileName}" />' style='width: 200px; height: 30px;' /> --%>
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
				<dt>URL</dt>
				<dd>
					<input type="text" name="url" class="form-control" value="<c:out value='${banner.url}'/>" />
				</dd>
				<dt>Target</dt>
				<dd>
					<select name="target">
						<option value="_blank" <c:if test="${banner.target eq '_blank'}">selected="selected"</c:if>>_blank</option>
						<option value="_self" <c:if test="${banner.target eq '_self'}">selected="selected"</c:if>>_self</option>
						<option value="_parent" <c:if test="${banner.target eq '_parent'}">selected="selected"</c:if>>_parent</option>
						<option value="_top" <c:if test="${banner.target eq '_top'}">selected="selected"</c:if>>_top</option>
					</select>
				</dd>
			</dl>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<c:if test="${not empty banner.id}">
				<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</c:if>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->