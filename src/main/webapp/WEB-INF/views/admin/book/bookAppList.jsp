<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/book/bookAppList' />";
	var editUrl	= "<c:url value='/admin/book/bookAppEdit' />";
	var selectDelUrl = "<c:url value='/data/book/bookAppSelectDel' />";	// 교재신청 선택 삭제
	var saveExcelUrl = "<c:url value='/data/book/excel/download/bookAppList' />";			// 교재신청 리스트 엑셀 다운로드
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	//file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
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

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append("		<input type='checkbox' name='selectCheckBox' />");
						sb.Append("	</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+(dataInfo.recName ? dataInfo.recName : "")+"</td>");
						sb.Append("	<td>"+dataInfo.userId+"</td>");
						sb.Append("	<td>"+(dataInfo.phone ? dataInfo.phone : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.course ? dataInfo.course.name : "")+"</td>");
						sb.Append("	<td>"+dataInfo.amount+"</td>");
						sb.Append("	<td>"+(dataInfo.delivYn == "Y" ? "배송완료" : "배송중(준비중)")+"</td>");
						sb.Append("	<td>"+(dataInfo.paymentYn == "Y" ? "결제" : "미결제")+"</td>");
						sb.Append("	<td>"+(dataInfo.paymentType == "C" ? "신용카드" : "계좌이체")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
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
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("교재신청관리", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("교재신청관리", editUrl, $("form[name='searchForm']").serialize());
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
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});

</script>

<div class="content_wraper">
	<h3>컨텐츠 타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
			<select name="searchCondition">
				<option value='all' selected>검색조건</option>
				<option value='recName' <c:if test="${search.searchCondition eq 'recName'}">selected</c:if>>수령자명</option>
				<option value='userId' <c:if test="${search.searchCondition eq 'userId'}">selected</c:if>>아이디</option>
				<option value='email' <c:if test="${search.searchCondition eq 'email'}">selected</c:if>>이메일</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<select name="delivYn">
				<option value='' selected>배송유무</option>
				<option value='Y'>배송완료</option>
				<option value='N'>배송중(준비중)</option>
			</select>
			<select name="paymentYn">
				<option value='' selected>결제유무</option>
				<option value='Y'>결제완료</option>
				<option value='N'>미결제</option>
			</select>
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>접수일자</th>
				<th>접수번호</th>
				<th>성명</th>
				<th>아이디</th>
				<th>연락처</th>
				<th>과정명</th>
				<th>주문수량</th>
				<th>배송상태</th>
				<th>결제상태</th>
				<th>결제방법</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="selectDelBtn" class="btn align_right danger" href="javascript:void();">선택삭제</a>
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div>
	</div>
</div>