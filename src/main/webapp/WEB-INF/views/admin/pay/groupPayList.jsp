<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/pay/groupPayList' />";
	var editUrl	= "<c:url value='/data/pay/groupPayEdit' />";
	var saveExcelUrl = "<c:url value='/data/pay/groupPayList/excelDownLoad' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
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
							sb.Append("<td>");
								sb.Append("<input type='hidden' name='groupId' value='"+dataInfo.groupId+"' />");
								sb.Append("<input type='hidden' name='paymentState' value='"+dataInfo.paymentState+"' />");
								sb.Append("<input type='hidden' name='cardinalId' value='"+dataInfo.cardinalId+"' />");
								sb.Append("<input type='hidden' name='courseId' value='"+dataInfo.courseId+"' />");
								sb.Append("<input type='hidden' name='schoolName' value='"+dataInfo.schoolName+"' />");
								sb.Append("<input type='checkbox' name='select' />");
							sb.Append("</td>");
							sb.Append("<td>"+dataInfo.schoolName+"</td>");
							sb.Append("<td>"+dataInfo.courseName+"</td>");
							sb.Append("<td>"+dataInfo.totalAppUser+"</td>");
							sb.Append("<td>"+dataInfo.totalPayment+"</td>");
							sb.Append("<td>"+dataInfo.validAppUser+"</td>");
							sb.Append("<td>"+dataInfo.totalValidPayment+"</td>");
							sb.Append("<td>"+dataInfo.paymentStateName+"</td>");
							sb.Append("<td>"+dataInfo.learnStartDate+"~"+dataInfo.learnEndDate+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='11'>조회된 결과가 없습니다.</td>");
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
	
	// 엑셀저장
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
	
	// 선택쿠폰삭제
	$("#editBundlePayBtn").on("click", function() {
		
		if ($(":checkbox[name='select']:checked").length == 0) {
			alert("선택 대상이 없습니다.");
			return false;
		}
		
		if(confirm("일괄 결제 처리하시겠습니까?")) {
			
			var editArray = new Array(); // 결제처리 대상 데이터 리스트
			
			$(":checkbox[name='select']").each(function(index) {
				if ($(this).is(":checked")) {
					var editObject = new Object(); // 결제처리 대상 데이터
					editObject.groupId = $(":hidden[name='groupId']").eq(index).val();
					editObject.paymentState = $(":hidden[name='paymentState']").eq(index).val(); 
					editObject.cardinalId = $(":hidden[name='cardinalId']").eq(index).val();
					editObject.courseId = $(":hidden[name='courseId']").eq(index).val();
					editObject.schoolName = $(":hidden[name='schoolName']").eq(index).val();
					
					editArray.push(editObject);
				}
			});
			
			$.ajax({
				type	: "post",
				url		: editUrl,
				data 	: JSON.stringify(editArray),
				dataType: "json",
			    contentType : 'application/json',
				success	: function(result) {
					if (result > 0) {
						alert(result + " 건이 수정되었습니다.");
						setContentList(1);
					} else {
						alert("수정실패하였습니다");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 모두 선택
	$(":checkbox[name='selectAll']").on("change", function() {
		if ($(this).is(":checked")) {
			$(":checkbox[name='select']").prop("checked", true);
		}
	});
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
				<option value="">검색조건</option>
				<option value="schoolName" <c:if test="${search.searchCondition eq 'schoolName'}">selected</c:if>>단체명</option>
				<option value="courseName" <c:if test="${search.searchCondition eq 'courseName'}">selected</c:if>>과정명</option>
			</select>
			<select name="paymentState">
				<option value="">전체</option>
				<option value="1" <c:if test="${paymentState eq '1'}">selected</c:if>>미결제</option>
				<option value="2" <c:if test="${paymentState eq '2'}">selected</c:if>>결제완료</option>
				<option value="3" <c:if test="${paymentState eq '3'}">selected</c:if>>일부결제</option>
				<option value="4" <c:if test="${paymentState eq '4'}">selected</c:if>>환불</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' name='selectAll' /> 선택</th>
				<th>단체(기관명)</th>
				<th>과정명</th>
				<th>총 신청자</th>
				<th>총 연수금액</th>
				<th>수강유효자</th>
				<th>실결제금액</th>
				<th>결제상태</th>
				<th>연수기간</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="editBundlePayBtn" class="btn align_left" href="javascript:void();">[선택 일괄 결제처리]</a>
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div>
	</div>
</div>