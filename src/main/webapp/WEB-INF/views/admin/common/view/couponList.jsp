<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

var innerCallback;

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/pay/couponList' />";
	var editUrl	= "<c:url value='/admin/pay/couponEdit' />";
	var delUrl	= "<c:url value='/data/pay/couponDel' />";
	var saveExcelUrl = "<c:url value='/data/pay/couponList/excelDownLoad' />";
	
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
		
		$(":checkbox[name='selectAll']").prop("checked", false);
		
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
						sb.Append("		<input type='checkbox' name='select' />");
						sb.Append("	</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td>"+dataInfo.couponNum+"</td>");
						sb.Append("	<td>"+""+"</td>");
						sb.Append("	<td>"+dataInfo.expDate+"</td>");
						sb.Append("	<td>"+(dataInfo.useYn == "Y" ? "사용가능" : "이미사용")+"</td>");
						sb.Append("	<td>"+(dataInfo.userId ? dataInfo.userId : '')+"</td>");
						sb.Append("	<td>"+(dataInfo.name ? dataInfo.name : '')+"</td>");
						sb.Append("	<td>"+(dataInfo.useDate ? dataInfo.useDate : '')+"</td>");
						sb.Append("	<td>"+""+"</td>");
						sb.Append("	<td>"+dataInfo.courseId+"</td>");
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
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		var data = {};
		openLayerPopup("신규쿠폰발행", "/admin/common/popup/couponReg", data);
	});
	
	// 엑셀저장
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		if(confirm("엑셀로 저장하시겠습니까?")) {
			$("form[name='searchForm']").attr("action", saveExcelUrl);
			$("form[name='searchForm']").submit();
		}
	});

	// 선택쿠폰삭제
	$("#delCouponBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			
			var delCouponIds = [];
			
			$(":checkbox[name='select']").each(function(index) {
				if ($(this).is(":checked")) {
					delCouponIds.push($(":hidden[name='checkId']").eq(index).val());
				}
			});
			
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: {"delCouponIds" : delCouponIds},
				traditional : true,
				success	: function(result) {
					if (result > 0) {
						alert(result + " 건이 삭제되었습니다.");
						setContentList(1);
					} else {
						alert("삭제실패하였습니다");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 쿠폰 모두 선택
	$(":checkbox[name='selectAll']").on("change", function() {
		$(":checkbox[name='select']").prop("checked", $(this).is(":checked"));
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
	innerCallback = setContentList;
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
				<option value='' selected>검색조건</option>
				<option value="couponNum" <c:if test="${search.searchCondition eq 'couponNum'}">selected</c:if>>쿠폰번호</option>
				<option value="userId" <c:if test="${search.searchCondition eq 'userId'}">selected</c:if>>아이디</option>
				<option value="name" <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
			</select>
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' name='selectAll' /></th>
				<th>발행일</th>
				<th>쿠폰번호</th>
				<th>쿠폰할인내역</th>
				<th>만료기한</th>
				<th>사용상태</th>
				<th>사용자ID</th>
				<th>사용자명</th>
				<th>사용일자</th>
				<th>사용주문번호</th>
				<th>쿠폰적용과정코드</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="delCouponBtn" class="btn align_left" href="javascript:void();">선택쿠폰삭제</a>
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
			<a id="addBtn" class="btn align_right" href="javascript:void();">신규쿠폰발행</a>
		</div>
	</div>
</div>