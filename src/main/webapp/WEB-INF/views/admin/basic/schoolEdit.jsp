<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/basic/schoolReg' />";
	var delUrl	= "<c:url value='/data/basic/schoolDel' />";
	var listUrl	= "<c:url value='/admin/basic/schoolList' />";
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
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
		contentLoad("학교관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 우편번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function() {
		var idx = $("a.search_addr").index($(this));
		
		daumPostcode(idx);
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
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='search.regionCode' value='<c:out value="${search.regionCode}" default="" />' />
			<input type='hidden' name='eType' value='<c:out value="${search.eType}" default="" />' />
			<input type='hidden' name='sType' value='<c:out value="${search.sType}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${school.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='search.regionCode' value='<c:out value="${search.regionCode}" default="" />' />
			<input type='hidden' name='search.eType' value='<c:out value="${search.eType}" default="" />' />
			<input type='hidden' name='search.sType' value='<c:out value="${search.sType}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>구분</dt>
				<dd class="half">
					<select name="sType">
						<option value="">등급</option>
						<option value="1" <c:if test="${school.sType eq '1'}">selected="selected"</c:if>>초등</option>
						<option value="2" <c:if test="${school.sType eq '2'}">selected="selected"</c:if>>중학교</option>
						<option value="3" <c:if test="${school.sType eq '3'}">selected="selected"</c:if>>고등학교</option>
						<option value="4" <c:if test="${school.sType eq '4'}">selected="selected"</c:if>>유치원</option>
						<option value="5" <c:if test="${school.sType eq '5'}">selected="selected"</c:if>>특수학교</option>
						<option value="6" <c:if test="${school.sType eq '6'}">selected="selected"</c:if>>기관</option>
					</select>
					<select name="eType">
						<option value="">설립</option>
						<option value="1" <c:if test="${school.eType eq '1'}">selected="selected"</c:if>>국립</option>
						<option value="2" <c:if test="${school.eType eq '2'}">selected="selected"</c:if>>공립</option>
						<option value="3" <c:if test="${school.eType eq '3'}">selected="selected"</c:if>>사립</option>
					</select>
				</dd>
				<dt>학교(기관)명</dt>
				<dd class="half">
					<input type='text' name='name' class='form-control' value='<c:out value='${school.name}' />' />
				</dd>
				<dt>소속/관할</dt>
				<dd class="">
					<select name="regionCode">
					<option value=''>시도</option>
					<c:forEach var="vo" items="${region}" varStatus="status">
						<option value='<c:out value="${vo.code}"/>' <c:if test="${vo.code eq school.regionCode}">selected</c:if>> <c:out value="${vo.name}"/> </option>
					</c:forEach>
					</select>
					<input type='text' name='jurisdiction' value='<c:out value='${school.jurisdiction}' />' placeholder="관할" />
				</dd>
				<dt>일반전화</dt>
				<dd class="half">
					<input type='text' name='tel' value='<c:out value='${school.tel}' />' />
				</dd>
				<dt>팩스번호</dt>
				<dd class="half">
					<input type='text' name='fax' value='<c:out value='${school.fax}' />' />
				</dd>
				<dt>학교주소</dt>
				<dd class="">
					<input type='text' name='postCode' class='zipcode' value='<c:out value="${school.postCode}" />' readonly="readonly" />
					<a class="btn search_addr" href="javascript:void();">우편번호</a>
					<input type='text' name='addr1' class='addr w100' value='<c:out value="${school.addr1}" />' />
					<%-- <input type='text' name='addr2' class='etc_addr' style="width:300px;" value='<c:out value="${school.addr2}" />' /> --%>
				</dd>
			</dl>
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
	</div>
</div>
<!-- // Navigation -->