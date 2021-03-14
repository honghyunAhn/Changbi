<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/pay/individualPayList' />";
	var editUrl	= "<c:url value='/admin/learnApp/learnAppEdit' />";
	var saveExcelUrl = "<c:url value='/data/pay/individualPayList/excelDownLoad' />";
	
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
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td>"+((dataInfo.paymentDate && dataInfo.paymentDate.length >= 8) ? dataInfo.paymentDate.substring(0,4)+"-"+dataInfo.paymentDate.substring(4,6)+"-"+dataInfo.paymentDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.user.id+"</td>");
						sb.Append("	<td>"+dataInfo.user.name+"</td>");
						sb.Append("	<td>"+dataInfo.cardinal.name+"</td>");
						sb.Append("	<td>"+dataInfo.course.name+"</td>");
						sb.Append("	<td>"+dataInfo.payment+"</td>");
						
						switch(dataInfo.paymentType) {
						case "1" : 
							sb.Append("	<td>무통장입금</td>");	
							break;
						case "2" :
							sb.Append("	<td>계좌이체</td>");
							break;
						case "3" :
							sb.Append("	<td>가상계좌</td>");
							break;
						case "4" :
							sb.Append("	<td>신용카드</td>");
							break;
						case "5" :
							sb.Append("	<td>지난연기결제</td>");
							break;
						case "6" :
							sb.Append("	<td>무료</td>");
							break;
						case "7" :
							sb.Append("	<td>단체연수결제</td>");
							break;
						default :
							sb.Append("	<td></td>");
							break;
						}
						
						sb.Append("	<td>"+dataInfo.paymentState+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='9'>조회된 결과가 없습니다.</td>");
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
		contentLoad("신청관리상세", editUrl, $("form[name='searchForm']").serialize());
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
				<option value="" selected>검색조건</option>
				<option value="userName" <c:if test="${search.searchCondition eq 'userName'}">selected</c:if>>성명</option>
				<option value="courseName" <c:if test="${search.searchCondition eq 'courseName'}">selected</c:if>>과정명</option>
				<option value="cardinalName" <c:if test="${search.searchCondition eq 'cardinalName'}">selected</c:if>>기수명</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<select name="paymentType">
				<option value="" selected>결제 수단</option>
				<%-- <option value="1" <c:if test="${search.paymentType eq '1'}">selected</c:if>>무통장입금</option> --%>
				<%-- <option value="2" <c:if test="${search.paymentType eq '2'}">selected</c:if>>계좌이체</option> --%>
				<option value="3" <c:if test="${search.paymentType eq '3'}">selected</c:if>>가상계좌</option>
				<option value="4" <c:if test="${search.paymentType eq '4'}">selected</c:if>>신용카드</option>
				<%-- <option value="5" <c:if test="${search.paymentType eq '5'}">selected</c:if>>지난연기결제</option>
				<option value="6" <c:if test="${search.paymentType eq '6'}">selected</c:if>>무료</option>
				<option value="7" <c:if test="${search.paymentType eq '7'}">selected</c:if>>단체연수결제</option> --%>
			</select>
			<select name="paymentState">
				<option value='' selected>결제 상태</option>
				<option value='1' <c:if test="${search.paymentState eq '1'}">selected</c:if>>미결제</option>
				<option value='2' <c:if test="${search.paymentState eq '2'}">selected</c:if>>결제완료</option>
			</select>
			<br/>
			<div class='input-group col-md-2 date datetimepicker' id='searchStartDate'>
                <input type='text' name='searchStartDate' class='form-control' value='<c:out value="${searchStartDate}" />' />
                <span class='input-group-addon'>
                    <span class='glyphicon glyphicon-calendar'></span>
                </span>
            </div> ~
            <div class='input-group col-md-2 date datetimepicker' id='searchEndDate'>
                <input type='text' name='searchEndDate' class='form-control' value='<c:out value="${searchEndDate}" />' />
                <span class='input-group-addon'>
                    <span class='glyphicon glyphicon-calendar'></span>
                </span>
            </div>
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>결제 일시</th>
				<th>아이디</th>
				<th>성명</th>
				<th>기수</th>
				<th>연수 과정</th>
				<th>결제 금액</th>
				<th>결제 구분</th>
				<th>비고</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div>
	</div>
</div>