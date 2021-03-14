<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/member/managerList' />";
	var editUrl	= "<c:url value='/admin/member/managerEdit' />";
	var selectDelUrl = "<c:url value='/data/member/managerSelectDel' />";	// 관리자 선택 삭제
	var saveExcelUrl = "<c:url value='/data/member/excel/download/managerList' />";	// 관리자 리스트 엑셀 다운로드
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var lastLogin = dataInfo.lastLogin;

						sb.Append("<tr>");
						sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+(lastLogin && lastLogin.length == 14 ? lastLogin.substring(0,4)+"-"+lastLogin.substring(4,6)+"-"+lastLogin.substring(6,8)+" "+lastLogin.substring(8,10)+":"+lastLogin.substring(10,12)+":"+lastLogin.substring(12,14) : "")+"</td>");
						sb.Append("	<td>"+dataInfo.tel+"</td>");
						sb.Append("	<td>"+dataInfo.phone+"</td>");
						sb.Append("	<td>"+(dataInfo.uesYn == "N" ? "중지" : "정상")+"</td>");
						
						// 강사인 경우 공지사항 , QnA 추가
						if($(":hidden[name='grade']").val() == "2") {
							sb.Append("	<td><a class='btn' name='noticeBtn' href='javascript:void();'>공지사항</a></td>");
							sb.Append("	<td><a class='btn' name='qnaBtn' href='javascript:void();'>Q&amp;A</a></td>");
						}

						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='"+($(":hidden[name='grade']").val() == "2" ? 10 : 8)+"'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		var title = ($(":hidden[name='grade']").val() == "1" ? "튜터관리" 
				  : ($(":hidden[name='grade']").val() == "8" ? "관리자관리"
				  : ($(":hidden[name='grade']").val() == "2" ? "강사관리" : "업체관리" ))); 
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());

		// ajax로 load
		contentLoad(title, editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 공지사항 버튼 클릭 시
	$("#dataListBody").on("click", ".btn[name='noticeBtn']", function() {
		var idx = $(".btn[name='noticeBtn']").index($(this));
		var data = new Object();
		
		data.boardType = 1;
		data.noticeType = 5;
		data.teacherId = $(":hidden[name='checkId']").eq(idx).val();
		
		openLayerPopup("공지사항", "/admin/common/popup/boardList", data);
	});
	
	// Q&A 버튼 클릭 시
	$("#dataListBody").on("click", ".btn[name='qnaBtn']", function() {
		var idx = $(".btn[name='qnaBtn']").index($(this));
		var data = new Object();
		
		data.boardType = 4;
		data.teacherId = $(":hidden[name='checkId']").eq(idx).val();

		openLayerPopup("QnA", "/admin/common/popup/boardList", data);
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		var title = ($(":hidden[name='grade']").val() == "1" ? "튜터관리" 
				  : ($(":hidden[name='grade']").val() == "8" ? "관리자관리"
				  : ($(":hidden[name='grade']").val() == "2" ? "강사관리" : "업체관리" ))); 
		
		// 폼 이동
		$(":hidden[name='id']").val("");
		
		// ajax로 load
		contentLoad(title, editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 전체 체크박스 클릭 시
	$("#allCheckBox").unbind("click").bind("click", function() {
		$(":checkbox[name='selectCheckBox']").prop("checked", $(this).prop("checked"));
	});
	
	// 선택 삭제 버튼 클릭 시
	$("#selectDelBtn").unbind("click").bind("click", function() {
		var size = $(":checkbox[name='selectCheckBox']:checked").size();
		
		if(size == 0) {
			alert("삭제 할 데이터를 선택하세요.");
		} else if(confirm("선택 된 "+size+"건의 데이터를 삭제하시겠습니까?")) {
			var data = {};
			var objList = new Array();
			
			$(":checkbox[name='selectCheckBox']:checked").each(function(i) {
				var idx = $(":checkbox[name='selectCheckBox']").index($(this));

				objList.push({"id" : $(":hidden[name='checkId']").eq(idx).val()});
			});
			
			data = {"list" : objList};
			
			// ajax 처리
			$.ajax({
				type		: "POST",
				url			: selectDelUrl,
				data		: JSON.stringify(data),
				dataType	: "json",
				contentType	: "application/json; charset=utf-8",
				processData	: false,
				success		: function(result) {
					alert(result+"개 데이터가 삭제 되었습니다.");
					
					setContentList(1);
				},
				error		: function(e) {
					alert(e.responseText);
				}
			});
		}
	});
	
	// 엑셀다운로드
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		if(confirm("엑셀로 저장하시겠습니까?")) {
			$("form[name='searchForm']").attr("action", saveExcelUrl);
			$("form[name='searchForm']").submit();
		}
	});

	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

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
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 등급설정(같은 화면을 다른 등급으로 사용하기 때문) -->
        	<input type="hidden" name="grade" value='<c:out value="${search.grade}" default="8" />' />
        	
			<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
				<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
				<option value='phone' <c:if test="${search.searchCondition eq 'phone'}">selected</c:if>>휴대전화</option>
				<option value='email' <c:if test="${search.searchCondition eq 'email'}">selected</c:if>>이메일</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<select name='useYn'>
				<option value="">서비스상태</option>
				<option value="Y" <c:if test="${search.useYn eq 'Y'}">selected</c:if>>정상</option>
				<option value="N" <c:if test="${search.useYn eq 'N'}">selected</c:if>>중지</option>
			</select>
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>연번</th>
				<th>아이디</th>
				<th>성명</th>
				<th>최근접속일시</th>
				<th>일반전화</th>
				<th>휴대전화</th>
				<th>상태</th>
				<!-- 강사인 경우 공지사항, Q&A 버튼 생성 -->
				<c:if test="${search.grade eq '2'}">
				<th>공지사항</th>
				<th>Q&amp;A</th>
				</c:if>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		
		<div class="pagination"></div>
		<div class="paging">
			<a id="selectDelBtn" class="btn align_right danger" href="javascript:void();">선택삭제</a>
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>