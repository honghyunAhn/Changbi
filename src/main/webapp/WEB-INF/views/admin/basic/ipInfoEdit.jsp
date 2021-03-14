<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var editUrl	= "<c:url value='/admin/basic/ipInfoEdit' />";
	var delUrl	= "<c:url value='/data/basic/ipDel' />";
	var listUrl	= "<c:url value='/admin/basic/ipList' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	//file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수자 IP 관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	$(".delIp").on("click", function() {
		var idx = $(".delIp").index(this);
		
		var data = new Object();
		data["user.id"] = $(":hidden[name='user.id']").val();
		data["ip"] = $(this).siblings("span.ip").text();
				
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: data,
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("정상적으로 삭제 되었습니다.");
						
						contentLoad("연수자 IP 관리", editUrl, $("form[name='searchForm']").serialize());
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
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>
		
<div class="content_wraper">
	<h3>타이틀</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='user.id' value='<c:out value='${ipInfoList[0].user.id}' default="" />' />
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- view start -->
			<dl>
				<dt>성명</dt>
				<dd><c:out value="${ipInfoList[0].user.name}" /></dd>
				<dt>아이디</dt>
				<dd><c:out value="${ipInfoList[0].user.id}" /></dd>
				
				<c:forEach var="ipInfo" items="${ipInfoList}" varStatus="status">
					<dt>허용 아이피</dt>
					<dd><span class="ip"><c:out value="${ipInfo.ip}" /></span> <span class="delIp" style="cursor:pointer">[del]</span></dd>
				</c:forEach>
			</dl>
		</form>
		<!-- actionForm end -->
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
		</div>
	</div>
</div>

