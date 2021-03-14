<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/book/bookAppReg' />";
	var delUrl	= "<c:url value='/data/book/bookAppDel' />";
	var listUrl	= "<c:url value='/admin/book/bookAppList' />";
	//var userPwInitUrl	= "<c:url value='/data/book/userPwInit' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	//file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("수정하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("수정되었습니다.");
						
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
		// ajax로 load
		contentLoad("교재신청관리", listUrl, $("form[name='searchForm']").serialize());
	});
});

</script>
		
<div class="content_wraper">
	<h3>교재신청관리</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${bookApp.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			<input type='hidden' name='courseId' value='<c:out value='${bookApp.courseId}' />' />
			<input type='hidden' name='userId' value='<c:out value='${bookApp.userId}' />' />
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>과정명</dt><dd><c:out value="${bookApp.course.name}" /></dd>
				<dt>총 구매수량</dt>
				<dd class="half">
					<input type='text' name='amount' class='form-control' value='<c:out value='${bookApp.amount}' />' />
				</dd>
				<dt>구매금액</dt>
				<dd class="half">
					<input type='text' name='price' class='form-control' value='<c:out value='${bookApp.price}' />' />
				</dd>
				<dt>성명(아이디)</dt>
				<dd class="half"><c:out value='${bookApp.userId}' /></dd>
				<dt>접수일자</dt><dd class="half">
					<fmt:parseDate var="dateString" value="${bookApp.regDate}" pattern="yyyyMMddHHmmss" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
				</dd>
				<dt>일반전화</dt><dd class="half"><c:out value='${bookApp.tel}' /></dd>
				<dt>휴대전화</dt><dd class="half"><c:out value='${bookApp.phone}' /></dd>
				<dt>전자메일</dt><dd class="half"><c:out value='${bookApp.email}' /></dd>
				<dt>수령주소지</dt><dd class="half"><c:out value='${bookApp.addr1} ${bookApp.addr2} ${bookApp.postCode}' /></dd>
				<dt>MEMO</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="remarks" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${bookApp.remarks}" /></textarea>
				</dd>
				<dt>결제유무</dt>
				<dd class="half">
					<select name="paymentYn">
						<option value="N" <c:if test="${bookApp.paymentYn eq 'N'}">selected="selected"</c:if>>미결제</option>
						<option value="Y" <c:if test="${bookApp.paymentYn eq 'Y'}">selected="selected"</c:if>>결제</option>
					</select>
					<input type='text' name='paymentDate' value='<c:out value='${bookApp.paymentDate}' />' placeholder="결제일" />
				</dd>
				<dt>결제방법</dt>
				<dd class="half">
					<select name="paymentType">
						<option value="C" <c:if test="${bookApp.paymentType eq 'C'}">selected="selected"</c:if>>신용카드</option>
						<option value="A" <c:if test="${bookApp.paymentType eq 'A'}">selected="selected"</c:if>>계좌이체</option>
					</select>
				</dd>
				<dt>결제발급번호</dt>
				<dd>
					<input type='text' name='issueNum' class='form-control' value='<c:out value='${bookApp.issueNum}' />' />
				</dd>
				<dt>배송유무</dt>
				<dd class="half">
					<select name="delivYn">
						<option value="N" <c:if test="${bookApp.delivYn eq 'N'}">selected="selected"</c:if>>배송중(준비중)</option>
						<option value="Y" <c:if test="${bookApp.delivYn eq 'Y'}">selected="selected"</c:if>>배송완료</option>
					</select>
					<input type='text' name='delivDate' value='<c:out value='${bookApp.delivDate}' />' placeholder='배송일' />
				</dd>
				<dt>배송번호</dt>
				<dd class="half">
					<input type='text' name='delivNum' value='<c:out value='${bookApp.delivNum}' />' />
					<a id='' class="btn" href="javascript:alert('준비중입니다.');">조회</a>
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