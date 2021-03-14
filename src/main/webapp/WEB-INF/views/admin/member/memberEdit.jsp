<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	//var regUrl	= "<c:url value='/data/member/memberReg' />";
	var regUrl	= "<c:url value='/data/member/memberUpd' />";
	var delUrl	= "<c:url value='/data/member/memberDel' />";
	var listUrl	= "<c:url value='/admin/member/memberList' />";
	var userPwInitUrl	= "<c:url value='/data/member/userPwInit' />";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	// file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		 var phoneVal = $(":text[name='phone']").val();		 
		if(!$(":text[name='name']").val()) {
			alert("성명은 필수입력입니다.");
			$(":text[name='name']").focus();
		} else if(!$(":text[name='phone']").val()) {
			alert("휴대전화는 필수입력입니다.");
			$(":text[name='phone']").focus();
		} else if(phoneVal.length!=11){
			alert("휴대전화 번호를 확인해 주세요.");
			$(":text[name='phone']").focus();
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
		// ajax로 load
		contentLoad("회원관리", listUrl, $("form[name='searchForm']").serialize());
	});
	
	// 비밀번호 초기화 버튼 클릭 시
	$("#userPwInitBtn").unbind("click").bind("click", function() {
		var id = $(":hidden[name='id']").val();
		
		if(id && confirm("비밀번호를 초기화 하시겠습니까?")) {
			var data = {"id" : id};
			
			// ajax 처리
			$.ajax({
				type	: "post",
				url		: userPwInitUrl,
				data	: data,
				success	: function(result) {
					if(result > 0) {
						alert("비밀번호 초기화 되었습니다.");
					} else {
						alert("비밀번호 초기화 실패하였습니다.");
					}
				},
				error	: function(e) {
					alert(e.responseText);
				}
			});
		}
	});
	
	// 학교정보 조회 버튼 클릭 시
	$("#schoolBtn").unbind("click").bind("click", function() {
		var data = new Object();
		openLayerPopup("학교검색", "/admin/common/popup/schoolList", data);
	});
	
	// 우편번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function() {
		var idx = $("a.search_addr").index($(this));
		
		daumPostcode(idx);
	});
});

function setSchool(school) {
	$(":text[name='schoolName']").val(school.name);
	$(":text[name='schoolPostCode']").val(school.postCode);
	$(":text[name='schoolAddr1']").val(school.addr1);
	//$(":text[name='schoolAddr2']").val(school.addr2);
	$("select[name='regionCode.code']").val(school.regionCode);
	$(":text[name='jurisdiction']").val(school.jurisdiction);
	$("select[name='sType']").val(school.sType);
	$(":hidden[name='eType']").val(school.eType);
}

</script>
		
<div class="content_wraper">
	<h3>회원관리</h3>
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
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${member.id}' default="" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			<input type='hidden' name="userFlag" value='${member.userFlag}'/>
			<input type="hidden" name="pw" value="${member.pw}">
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- view start -->
			<h4>회원정보 입력</h4>
			<dl>
				<dt>가입일시</dt>
				<dd class="half">
					<%-- <fmt:parseDate var="dateString" value="${member.regDate}" pattern="yyyyMMddHHmmss" /> --%>
					<fmt:parseDate var="dateString" value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" />
				</dd>
				<dt>서비스상태</dt>
				<dd class="half">
					<%-- <input type="radio" id="useY" name='useYn' value="Y" checked="checked"><label for="useY">정상</label>
					<input type="radio" id="useN" name='useYn' value="N" <c:if test="${member.useYn eq 'N'}">checked="checked"</c:if>><label for="useN">탈퇴</label> --%>
					<input type="radio" id="useY" name='useYn' value="A0200" checked="checked"><label for="useY">정상</label>
					<input type="radio" id="useN" name='useYn' value="A0202" <c:if test="${member.useYn eq 'A0202'}">checked="checked"</c:if>><label for="useN">탈퇴</label>
				</dd>
				<dt>아이디<span class='require'>*</span></dt>
				<dd class="half"><c:out value='${member.id}' default="" /></dd>
				<dt>생년월일</dt>
				<dd class="half">
					<div class='input-group date datetimepicker w50' id='birthDay'>
	                    <input type='text' name='birthDay' class='form-control' value='<c:out value="${member.birthDay}" />'  />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>성명<span class='require'>*</span></dt>
				<dd class="half"><input type="text" name='name' value='<c:out value='${member.name}' default="" />' ></dd>
				<dt>성별</dt>
				<dd class="half">
					<%-- <input type="radio" id="genderM" name='gender' value="M" checked="checked"><label for="genderM">남자</label>
					<input type="radio" id="genderF" name='gender' value="F" <c:if test="${member.gender eq 'F'}">checked="checked"</c:if>><label for="genderF">여자</label> --%>
					<input type="radio" id="genderM" name='gender' value="A0000" checked="checked"><label for="genderM">남자</label>
					<input type="radio" id="genderF" name='gender' value="A0001" <c:if test="${member.gender eq 'A0001'}">checked="checked"</c:if>><label for="genderF">여자</label>
				</dd>
				<dt>비밀번호<span class='require'>*</span></dt>
				<dd >
					<a id='userPwInitBtn' class="btn" href="javascript:void();">비밀번호초기화</a><span>1234로 초기화</span>
				</dd>
				<dt>휴대전화<span class='require'>*</span></dt>
				<dd class="half"><input type='text' name='phone' value='<c:out value="${member.phone}" default="" />' /></dd>
				<dt>자택전화</dt>
				<dd class="half"><input type='text' name='tel' value='<c:out value="${member.tel}" default="" />' /></dd>
				<dt>이메일</dt>
				<dd><input type='text' name='email' value='<c:out value="${member.email}" default="" />' /></dd>
				<dt>주소</dt>
				<dd>
					<div>
						<input type='text' name='postCode' class='zipcode' value='<c:out value="${member.postCode}" />' readonly="readonly" /><a class="btn search_addr" href="javascript:void();">우편번호</a>
					</div>
					<div>
						<input type='text' name='addr1' class='addr w100' value='<c:out value="${member.addr1}" />' />
					</div>
					<div>
						<input type='text' name='addr2' class='etc_addr w100' value='<c:out value="${member.addr2}" />' />
					</div>
				</dd>
			</dl>
			<%-- 
			<h4>학교 및 기관정보 입력</h4>
			<dl>
				<dt>학교/기관명<span class='require'>*</span></dt>
				<dd>
					<input type='text' name='schoolName' value='<c:out value="${member.schoolName}" default="" />' readonly="readonly" />
					<a id='schoolBtn' class="btn" href="javascript:void();">학교검색</a>
				</dd>
				<dt>학교주소</dt>
				<dd>
					<input type='text' name='schoolPostCode' class='zipcode' value='<c:out value="${member.schoolPostCode}" />' readonly="readonly" />
					<!-- <a class="btn search_addr" href="javascript:void();">우편번호</a> -->
					<input type='text' name='schoolAddr1' class='addr w100' value='<c:out value="${member.schoolAddr1}" />' readonly="readonly" />					 
				</dd>
				<dt>시도교육청</dt>
				<dd class="half">
					<select name='regionCode.code'>
						<option value=''>선택</option>
						<c:forEach items="${region}" var="code" varStatus="status">
							<option value='<c:out value="${code.code}" />' <c:if test="${code.code eq member.regionCode.code}">selected</c:if>><c:out value="${code.name}" /></option>
						</c:forEach>
					</select>
				</dd>
				<dt>교육지원청</dt>
				<dd class="half">
					<input type='text' name='jurisdiction' value='<c:out value="${member.jurisdiction}" />' />
				</dd>
				<dt>NEIS 개인번호</dt>
				<dd><input type='text' name='neisNum' value='<c:out value="${member.neisNum}" />' /></dd>
				<dt>자격구분</dt>
				<dd class="half">
					<select name='sType'>
						<option value="1">초등</option>
						<option value="2" <c:if test="${member.sType eq 2}">selected="selected"</c:if>>중학교</option>
						<option value="3" <c:if test="${member.sType eq 3}">selected="selected"</c:if>>고등학교</option>
						<option value="4" <c:if test="${member.sType eq 4}">selected="selected"</c:if>>유치원</option>
						<option value="5" <c:if test="${member.sType eq 5}">selected="selected"</c:if>>특수학교</option>
						<option value="6" <c:if test="${member.sType eq 6}">selected="selected"</c:if>>기관</option>
					</select>
					<input type='hidden' name='eType' value='<c:out value="${member.eType}" default="" />' />
				</dd>
				<dt>담당과목</dt>
				<dd class="half"><input type='text' name='subject' value='<c:out value="${member.subject}" />' /></dd>
				<dt>직위</dt>
				<dd class="half">
					<select name='position'>
						<option value="교사">교사</option>
						<option value="수석교사" <c:if test="${member.position eq '수석교사'}">selected="selected"</c:if>>수석교사</option>
						<option value="부장교사" <c:if test="${member.position eq '부장교사'}">selected="selected"</c:if>>부장교사</option>
						<option value="교감" <c:if test="${member.position eq '교감'}">selected="selected"</c:if>>교감</option>
						<option value="교장" <c:if test="${member.position eq '교장'}">selected="selected"</c:if>>교장</option>
						<option value="장학/연구사" <c:if test="${member.position eq '장학/연구사'}">selected="selected"</c:if>>장학/연구사</option>
						<option value="장학/연구관" <c:if test="${member.position eq '장학/연구관'}">selected="selected"</c:if>>장학/연구관</option>
						<option value="원장" <c:if test="${member.position eq '원장'}">selected="selected"</c:if>>원장</option>
						<option value="원감" <c:if test="${member.position eq '원감'}">selected="selected"</c:if>>원감</option>
						<option value="기타" <c:if test="${member.position eq '기타'}">selected="selected"</c:if>>기타</option>
					</select>
					<input type="text" name='positionEtc' value='<c:out value='${member.positionEtc}' default="" />'>
				</dd>
				<dt>임용년도</dt>
				<dd class="half">
					<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear" />
					<select name='appYear'>
						<c:forEach var="year" begin="${nowYear - 40}" end="${nowYear}" step="1">
							<option value="${nowYear - year + nowYear - 40}" <c:if test="${member.appYear eq (nowYear - year + nowYear - 40)}">selected="selected"</c:if>>${nowYear - year + nowYear - 40}년</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			 --%>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<!-- <a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a> -->
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			<!-- <a id="pointBtn" class="btn align_right danger" href="javascript:void();">포인트</a> -->
		</div>
	</div>
</div>

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->