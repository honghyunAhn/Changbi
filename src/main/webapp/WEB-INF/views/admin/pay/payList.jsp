<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/pay/payList' />"; 
	var editUrl	= "<c:url value='/admin/learnApp/learnAppEdit' />";
	var saveExcelUrl = "<c:url value='/data/pay/payList/excelDownLoad' />";
	
	var listTestUrl = "<c:url value='/data/pay/payListTest' />";
	
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
					
					for(var i=0; i<dataList.length; i++) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						 
						sb.Append("	<td>"+(dataInfo.edu.pay_ins_dt)+"</td>");
						sb.Append("	<td class='content_edit'>"+ dataInfo.user.id + "</td>");
						if(dataInfo.edu!= null){
						sb.Append("	<input type='hidden' name='click_pay_user_seq' value='"+ dataInfo.edu.pay_user_seq +"'>");
						} else {
							sb.Append("<input type='hidden' name='click_pay_user_seq' value='' />");
						}
						sb.Append("	<td>"+dataInfo.user.name+"</td>");
						sb.Append("	<td>"+(dataInfo.cardinal.name==null? "" : dataInfo.cardinal.name )+"</td>");
						sb.Append("	<td>"+(dataInfo.course.name==null? "" : dataInfo.course.name )+"</td>");
						
						if(dataInfo.edu != null) {
							sb.Append("<td>"+ (dataInfo.edu.pay_crc_amount == null ? "0" : dataInfo.edu.pay_crc_amount) +"</td>");  //결제금액
							sb.Append("<td>"+ (dataInfo.edu.real_pay_amount == null ? '0' : dataInfo.edu.real_pay_amount) +"</td>"); //실결제금액
						} else {
							sb.Append("<td>0</td>");
							sb.Append("<td>0</td>");
						}
						
						if(dataInfo.edu != null) {
							switch (dataInfo.edu.pay_user_status) {
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
							default :
								sb.Append("<td>관리자 입과(결제정보 없음)</td>");
								break;
							}
						} else {
							sb.Append("<td>-</td>");
						}
						
						if(dataInfo.edu != null) {
							if(dataInfo.edu.dis_point == '' || dataInfo.edu.dis_point == null) {
								sb.Append("	<td>-</td>"); //사용포인트
							} else {
								sb.Append("<td>" + dataInfo.edu.dis_point + "</td>");
								sb.Append("	<input type='hidden' name='used_point' value='"+dataInfo.edu.dis_point+"' />");
							}
						} else {
							sb.Append(" <td>-</td>");
						}
						if(dataInfo.admin_add_yn != "Y") {
							sb.Append("	<td></td>");
						} else {
							sb.Append("	<td>관리자 추가</td>");	
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
			}
		}); 

		// ajax 처리
		/* $.ajax({
			type	: "post",
			url		: listUrl, 
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
                   
					for(var i=0; i<dataList.length; i++) {
						var dataInfo = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						 
						sb.Append("	<td>"+(dataInfo.regDate.substring(0,19))+"</td>");
						if(dataInfo.pay!= null){
						sb.Append("	<input type='hidden' name='click_pay_user_seq' value='"+dataInfo.pay.pay_user_seq+"'>");				
						}
						sb.Append("	<td class='content_edit'>"+dataInfo.user.id+"</td>");
						sb.Append("	<td>"+dataInfo.user.name+"</td>");
						sb.Append("	<td>"+(dataInfo.cardinal.name==null? "" : dataInfo.cardinal.name )+"</td>");
						sb.Append("	<td>"+(dataInfo.course.name==null? "" : dataInfo.course.name )+"</td>");
						
						
						switch(dataInfo.paymentType) {
						case "B" :
							sb.Append("	<td>가상계좌</td>");
							break;
						case "C" :
							sb.Append("	<td>신용카드</td>");
							break;
						case "F" :
							sb.Append("	<td>무료</td>");
							break;
						case "1" : 
							sb.Append("	<td>무통장입금</td>");	
							break;
						case "2" :
							sb.Append("	<td>계좌이체</td>");
							break;
						case "5" :
							sb.Append("	<td>지난연기결제</td>");
							break;
						case "7" :
							sb.Append("	<td>단체연수결제</td>");
							break;
						default :
							sb.Append("	<td></td>");
							break;
						}
						
						sb.Append("	<td>"+dataInfo.course.price+"</td>");  //결제금액
						
						if(dataInfo.admin_add_yn != "Y") {
							sb.Append("	<td>"+(dataInfo.course.price-dataInfo.disPoint)+"</td>"); //실결제금액
						} else {
							sb.Append("	<td>0</td>"); //실결제금액	
						}
						//sb.Append("	<td>"+dataInfo.paymentState+"</td>");
						
						if(dataInfo.pay != null) {
							switch (dataInfo.pay.pay_user_status) {
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
						
						sb.Append("	<input type='hidden' name='used_point' value='"+dataInfo.disPoint+"' />");
						sb.Append("	<td>"+(dataInfo.disPoint>=0? dataInfo.disPoint: "-")+"</td>"); //사용포인트
						if(dataInfo.admin_add_yn != "Y") {
							sb.Append("	<td></td>");
						} else {
							sb.Append("	<td>관리자 추가</td>");	
						}
						
						
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
		}); */  
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
		//선택된 pay_user_seq를 hidden값으로 세팅하고 form submit
		$(":hidden[name='edu.pay_user_seq']").val($(":hidden[name='click_pay_user_seq']").eq(idx).val());
		
		var t = $(":hidden[name='edu.pay_user_seq']").val();
	 
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

	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		
		// 과정선택 레이어 팝업
		var data = new Object();
		data.learnTypes = $(":hidden[name='groupLearnYn']").val() == "Y" ? "G" : $("#learnType").val();
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {

		if($('#courseName').val()=='과정선택'){
			alert('과정을 먼저 선택해주세요.');
			return;
		} else {
			// 기수선택 레이어 팝업
			var data = new Object();
			data.learnTypes = "J,S,M";
			data.id = $("#courseId").val();

			if($(":hidden[name='groupLearnYn']").val() == "Y") {
				data.learnTypes = "G";
			}
		
			openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
		}		
	}); 
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();

});
function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);		// 임시저장
	
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);
}

function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}
</script>

<div class="content_wraper">
	<h3>컨텐츠 타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
	        	<table class="searchTable">
	        		<tr>
		        		<th>과정명</th>
		        		<td>
		        			<!-- 과정 선택 -->
							<input type='text' id='courseName' name='course.name' value='<c:out value="${search.course.name}" />' placeholder="과정선택" readonly="readonly" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>기수명</th>
		        		<td>
		        			<!-- 기수 선택 -->
							<input type='text' id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" />' placeholder="기수선택" readonly="readonly" />
		        		</td>
		        	</tr>
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
		        			<select name="edu.pay_user_status">
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
            <input type="hidden" name="edu.pay_user_seq" value="0" />
        	<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="pagingYn" value='Y' />
        	<!-- 기수와 과정 ID 세팅 -->
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />         
			 <%-- 
			<select name="paymentType" disabled="disabled" style="background: lightgray;">
				<option value="" selected >결제 수단</option>
				<!-- <option value="1" <c:if test="${search.paymentType eq '1'}">selected</c:if>>무통장입금</option> -->
				<!-- <option value="2" <c:if test="${search.paymentType eq '2'}">selected</c:if>>계좌이체</option> -->
				<option value="3" <c:if test="${search.paymentType eq '3'}">selected</c:if>>가상계좌</option>
				<option value="4" <c:if test="${search.paymentType eq '4'}">selected</c:if>>신용카드</option>
				<!-- <option value="5" <c:if test="${search.paymentType eq '5'}">selected</c:if>>지난연기결제</option>
				<option value="6" <c:if test="${search.paymentType eq '6'}">selected</c:if>>무료</option>
				<option value="7" <c:if test="${search.paymentType eq '7'}">selected</c:if>>단체연수결제</option> -->
			</select>
			<select name="paymentState"  disabled="disabled" style="background: lightgray;">
				<option value='' selected>결제 상태</option>
				<option value='1' <c:if test="${search.paymentState eq '1'}">selected</c:if>>미결제</option>
				<option value='2' <c:if test="${search.paymentState eq '2'}">selected</c:if>>결제완료</option>
			</select>
		 --%>
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
				<th>실 결제 금액</th>
				<th>결제 현황</th>
				<th>사용포인트</th>
				<!--  <th>결제 구분</th>-->
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