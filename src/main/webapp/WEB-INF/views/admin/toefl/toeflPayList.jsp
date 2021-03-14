<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var saveExcelUrl = "<c:url value='/data/pay/payList/excelDownLoad' />";
	var listTestUrl = "<c:url value='/data/toefl/toeflPayList' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	if("${search.searchStartDate}" != '' && "${search.searchStartDate}" != null) {
		$("input[name='searchStartDate']").val("${search.searchStartDate}");
		$("input[name='searchEndDate']").val("${search.searchEndDate}");
	} else {
		$("input[name='searchStartDate']").val("");
		$("input[name='searchEndDate']").val("");
	}
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
 	function setContentList(pageNo) {
		
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		$.ajax({
			type : "POST"
			, url : listTestUrl
			, data 	: $("form[name='searchForm']").serialize()
			, success : function(data) {
				
				var sb = new StringBuilder();
				if(data.list && data.list.length > 0) {
					var dataList = data.list;
					var pageNo		= data.pageNo		? data.pageNo		: 1;
					var numOfRows	= data.numOfRows	? data.numOfRows 	: 10;
					
					console.log(pageNo);
					console.log(numOfRows);
					
					for(var i=0; i<dataList.length; i++) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.pay_toefl_seq+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						
						sb.Append("	<td>"+(dataInfo.updDate)+"</td>");
						sb.Append("	<td class=''>"+ dataInfo.user.id + "</td>");
						sb.Append("	<td>"+dataInfo.user.name+"</td>");
						sb.Append("	<td>"+dataInfo.user.email+"</td>");
						sb.Append("	<td style='width: 200px;'>"+(dataInfo.toefl_id.title==null? "" : dataInfo.toefl_id.title )+"</td>");
						
						if(dataInfo.pay_user_status != null) {
							switch (dataInfo.pay_user_status) {
							case "F0000":
								sb.Append("<td>미결제</td>");
								break;
								
							case "F0001":
								sb.Append("<td>결제완료</td>");
								break;
								
							case "F0002":
								sb.Append("<td>환불요청</td>");
								break;
								
							case "F0003":
								sb.Append("<td>환불완료</td>");
								break;
							}
						} else {
							sb.Append("<td>-</td>");
						}
						
						if(dataInfo.toefl_id != null) {
							sb.Append("<td>"+ (dataInfo.toefl_id.price == null ? "0" : dataInfo.toefl_id.price) +"</td>");  //결제금액
						} else {
							sb.Append("<td>0</td>");
						}
						
						sb.Append("<td>"+ (dataInfo.real_pay_amount == null ? '0' : dataInfo.real_pay_amount) +"</td>"); //실결제금액
						sb.Append("<td>" + dataInfo.dis_point + "</td>");
						if(dataInfo.pay_user_status == "F0002" || dataInfo.pay_user_status == "F0003") {
							sb.Append("<td><input type='button' value='환불 정보' onclick='refundInfo("+ dataInfo.pay_toefl_seq + ")'></td>");
						} else {
							sb.Append("<td></td>");
						}
						
						sb.Append("</tr>");
					}
				}
				
				$("#dataListBody").html(sb.ToString()); 
				
				// 페이징 처리
				pagingNavigation.setData(data);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			}
			, error : function() {
				console.log("실패");
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
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());

	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();

});

function refundInfo(id) {
	var search = $("form[name='searchForm']").serializeObject();
	var data = {pay_toefl_seq : id}
	var obj = new Object();
		obj.search = JSON.stringify(search)
		obj.data = JSON.stringify(data)
	openLayerPopup("환불 정보","/admin/common/popup/toeflRefundInfo", obj);
}
</script>

<div class="content_wraper">
	<h3>토플결제관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
		<form name="searchForm" method="post">
	       	<div>
	        	<table class="searchTable">
 		        	<tr>
		        		<th>기간선택</th>
		        		<td>
		        			<div class='input-group col-md-2 date datetimepicker' id='searchStartDate'>
				                <input type='text' name='searchStartDate' class='form-control' value='<c:out value="${search.searchStartDate}" />' />
				                <span class='input-group-addon'>
				                    <span class='glyphicon glyphicon-calendar'></span>
				                </span>
				            </div> ~
				            <div class='input-group col-md-2 date datetimepicker' id='searchEndDate'>
				                <input type='text' name='searchEndDate' class='form-control' value='<c:out value="${search.searchEndDate}" />' />
				                <span class='input-group-addon'>
				                    <span class='glyphicon glyphicon-calendar'></span>
				                </span>
				            </div>
		        		</td>
		        	</tr> 
 		        	<tr>
		        		<th>결제상태</th>
		        		<td>
		        			<select name="pay_user_status">
		        				<option value="">결제상태 선택</option>
		        				<option value="F0000">결제대기</option>
		        				<option value="F0001">결제완료</option>
		        				<option value="F0002">환불신청</option>
		        				<option value="F0003">환불완료</option>
		        			</select>
		        		</td>
		        	</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
							<button id='searchBtn' class="btn-primary" type="button">검색</button>
	        			</td>
	        		</tr>
	        	</table>
			</div>
			<input type="hidden" name="" value="0" />
			<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="pagingYn" value='Y' />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>순번</th>
				<th>결제 일시</th>
				<th>아이디</th>
				<th>성명</th>
				<th>메일</th>
				<th>시험명</th>
				<th>결제상태</th>
				<th>결제금액</th>
				<th>실 결제금액</th>
				<th>사용 포인트</th>
				<th>환불정보</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<!-- <div class="paging">
			<a id="saveExcelBtn" class="btn align_right" href="javascript:void();">EXCEL저장</a>
		</div> -->
	</div>
</div>