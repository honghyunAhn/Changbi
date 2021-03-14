<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/member/memberReg' />";
	var delUrl	= "<c:url value='/data/member/memberDel' />";
	var listUrl	= "<c:url value='/admin/member/memberList' />";
	
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
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
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
					alert(result.id);
					if(result.id) {
						alert("저장되었습니다.");
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
});

</script>
		
<div class="content_wraper">
	<h3>회원관리</h3>
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
			<input type='hidden' name='id' value='<c:out value='${member.id}' default="" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			
			<!-- 조회조건(저장 방식을 ajax가 아닌 페이지 방식으로 한 경우 저장 후 리스트 페이지로 이동 시키는데 그때 검색 조건을 저장해두기 위해 사용) -->
	       	<input type='hidden' name='search.pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='search.searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='search.searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			
			<!-- view start -->
			<dl>
				<dt>연수타입</dt><dd class="half">직무연수</dd>
				<dt>기수코드</dt><dd class="half"><input type="text" size="5" maxlength="5" value="n1506"></dd>
				<dt>기수명</dt><dd class="half"><input type="text" maxlength="50" value="2015년 제6기"></dd>
				<dt>과정서비스형태</dt><dd class="half"><input id="Select_subject" type="radio" value="2"><label for="Select_subject">선택과목서비스</label><input id="All_subject" type="radio" value="1"><label for="All_subject">전체과목서비스</label></dd>
				<dt>접수기간</dt><dd class="half"><input type="text" maxlength="10" value="2015-07-20">~<input type="text" maxlength="10" value="2015-07-20"></dd>
				<dt>연수기간</dt><dd class="half"><input type="text" maxlength="10" value="2015-07-20">~<input type="text" maxlength="10" value="2015-07-20"><label>이수발급일 :</label><input type="text" maxlength="10" value="2015-07-20"></dd>
				<dt>출석평가</dt><dd><label style="margin-left: 0px;" for="date_evaluation">평가일자 :</label><input style="width: initial" id="date_evaluation" type="text" maxlength="10" value="2015-07-11"><label for="time_evaluation">평가시간 :</label><input style="width: initial;" id="time_evaluation" size="10" type="text" maxlength="10" value="2015-07-11"><span>※ ex)1교시:15시, 2교시:16시10분</span></dd>
				<dt>수강취소일</dt>
				<dd class="half">
					<select>
						<option selected>지정안함</option>
						<option>신청일로부터 1일</option>
						<option>신청일로부터 2일</option>
						<option>신청일로부터 3일</option>
					</select>
				</dd>
				<dt>중복접수Limit</dt>
				<dd class="half">
					<select>
						<option selected>제한없음</option>
						<option>1개 과정</option>
						<option>2개 과정</option>
						<option>3개 과정</option>
					</select>
				</dd>
				<dt>출석고사장</dt>
				<dd class="half">
					<select>
						<option selected>출석고사장 뷰어 / 변경신청 불가</option>
						<option>출석고사장 히든 / 변경신청 불가</option>
						<option>출석고사장 뷰어 / 변경신청 가능</option>						
					</select>
				</dd>
				<dt>추가평가기간</dt>
				<dd class="half">
					<select>
						<option selected>지정안함</option>
						<option>1일</option>
						<option>2일</option>
						<option>3일</option>
					</select>
				</dd>
				<dt>학점별성적공개</dt>
				<dd>
					<label>1학점</label><input type="checkbox">
					<label>2학점</label><input type="checkbox">
					<label>3학점</label><input type="checkbox">
					<label>4학점</label><input type="checkbox">					
					<span>※ 체크된 학점은 최종성적이 수강자에게 보여집니다.</span>
				</dd>
				<dt>신청가능학점</dt>
				<dd>
					<label>1학점</label><input type="checkbox">
					<label>2학점</label><input type="checkbox">
					<label>3학점</label><input type="checkbox">
					<label>4학점</label><input type="checkbox">					
					<span>※ 접수가능한 학점별 과정을 설정하십시오.</span>
				</dd>
				<dt>출석평가 예상문제</dt>
				<dd class="half">
					<input type="radio"><label>비공개</label>
					<input type="radio"><label>공개</label>/
					<select style="margin-left: 5px;">
						<option selected>A형 예상문제</option>
						<option>B형 예상문제</option>
						<option>C형 예상문제</option>
					</select>
					<a class="btn" href="#">예상문제보기</a>
				</dd>
				<dt>예습미리보기</dt>
				<dd class="half">
					<select>
						<option>8강</option>
						<option>9강</option>
						<option selected>10강</option>
						<option>11강</option>
						<option>12강</option>
						<option>13강</option>
					</select>
				</dd>
				<dt>이수처리</dt>
				<dd class="half">
					<select>
						<option selected>이수미처리</option>
						<option>이수처리 및 성적발표</option>						
					</select>
					<input style="margin-left: 10px; margin-right: -8px;" type="checkbox"><label>적용(체크시 수강정보반영)</label>
				</dd>
				<dt>상태구분</dt>
				<dd class="half">
					<select>
						<option selected>서비스</option>
						<option>보류</option>
					</select>
				</dd>
				<dt>접수현황</dt>
				<dd class="half">
					<span>접수자 : <strong>0명</strong> / 수강자 : <strong>0명</strong> / 이수자 : <strong>0명</strong></span>					
				</dd>
				<dt>수강자뷰어링</dt>
				<dd class="half">
					<input type="radio"><label>수강자공개</label>
					<input type="radio"><label>수강자비공개</label>				
				</dd>
				<dt>연수설문지설정</dt>
				<dd>
					<select>
						<option selected>- 연수설문지 선택-</option>
						<option>[160420151456] 연수 만족도 설문조사</option>						
					</select>
					<span>※ 과정별 차시에 등록된 평가설문지도 자동적용됩니다.</span>
				</dd>
				<dt>교육청보고내용</dt>
				<dd>
					<label>공문시행 :</label>
					<input type="text" style="margin-right: 13px;">/
					<label>공문보고담당 :</label>
					<input type="text">
					<span>※ 문구내용 그대로 인쇄됨</span>
				</dd>
				<dt class="texttextarea">추후일정</dt>
				<dd class="texttextarea">
					<textarea></textarea>					
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