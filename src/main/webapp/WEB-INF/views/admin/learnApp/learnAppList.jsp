<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/learnApp/learnAppList' />";
	var editUrl	= "<c:url value='/admin/learnApp/learnAppEdit' />";
	var memberEditUrl = "<c:url value='/admin/member/memberEdit' />";
	var cardinalListUrl = "<c:url value='/data/course/cardinalList' />";		// 기수리스트 조회
	var courseListUrl = "<c:url value='/data/course/trainProcessList' />";		// 과정리스트 조회
	var selectDelUrl = "<c:url value='/data/learnApp/learnAppSelectDel' />";	// 수강신청 선택 삭제
	var saveExcelUrl = "<c:url value='/data/learnApp/excel/download/learnAppList' />";			// 수강신청 리스트 엑셀 다운로드
	
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
					var dataList	= result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td class='member_edit'>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.cardinal && dataInfo.cardinal.name) ? dataInfo.cardinal.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.course && dataInfo.course.name) ? dataInfo.course.name : "")+"</td>");
						sb.Append("	<td>");
						sb.Append(		( dataInfo.cardinal && dataInfo.cardinal.id 
										? ( dataInfo.cardinal.learnType == "J" 
										  ? "직무"+dataInfo.course.credit+"학점" 
										  : (dataInfo.cardinal.learnType == "G" ? "단체" : "집합") )
										: "자율" ));
						sb.Append(" </td>");
						//sb.Append("	<td>"+dataInfo.desNum+"</td>");
						sb.Append("	<td>");
						sb.Append(		(dataInfo.paymentState == "1" ? "결제대기" : (dataInfo.paymentState == "2" ? "결제완료" : (dataInfo.paymentState == "3" ? "일부결제" : "환불"))) + "/");
						sb.Append(		(dataInfo.paymentType == "1" ? "무통" : (dataInfo.paymentState == "2" ? "이체" : (dataInfo.paymentState == "3" ? "가상" : (dataInfo.paymentState == "4" ? "카드" : (dataInfo.paymentState == "5" ? "연기" : (dataInfo.paymentState == "6" ? "무료" : "단체")))))));
						sb.Append(" </td>");
						sb.Append("	<td>"+formatMoney(dataInfo.payment)+"</td>");
						//sb.Append("	<td>"+dataInfo.mainBook+"/"+dataInfo.subBook+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='13'>조회된 결과가 없습니다.</td>");
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
	
	// 클릭 시 회원 상세 페이지 이동
	$("#dataListBody").on("click", ".member_edit", function() {
		// ajax로 load
		contentLoad('회원관리상세', memberEditUrl, {'id' : $(this).text()});
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {
		if(!$("#courseId").val()) {
			alert("과정을 먼저 선택해야 합니다.");
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
	
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		// 과정선택 레이어 팝업
		var data = new Object();
		data.learnTypes = $(":hidden[name='groupLearnYn']").val() == "Y" ? "G" : $("#learnType").val();
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
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

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);
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
	<h3>연수신청관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
		<form name="searchForm" method="post">
	       	<div>
	        	<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
	        				<!-- 검색조건 -->
				        	<select class="searchConditionBox" name="searchCondition">
								<option value='all'>전체</option>
								<option value='id'>아이디</option>
								<option value='name'>성명</option>
							</select>
							<!-- 검색키워드 -->
							<input type="text" placeholder="검색어입력" class="searchKeywordBox" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
	        		<c:if test="${search.groupLearnYn eq 'Y'}">
		        		<tr>
		        			<th>단체연수</th>
		        			<td>
								<select name="groupLearn.id">
									<option value="0">단체연수</option>
									<c:forEach items="${groupLearnList}" var="groupLearn" varStatus="status">
										<option value='<c:out value="${groupLearn.id}" />' <c:if test="${groupLearn.id eq search.groupLearn.id}">selected</c:if>><c:out value="${groupLearn.name}" /></option>
									</c:forEach>
								</select>
							</td>
		        		</tr>
					</c:if>
					<tr>
						<th>결제여부</th>
						<td>
							<!-- 결제상태 -->
							<select class="selector" name='paymentState'>
								<option value="">결제상태</option>
								<option value="1" <c:if test="${search.paymentState eq '1'}">selected</c:if>>결제대기</option>
								<option value="2" <c:if test="${search.paymentState eq '2'}">selected</c:if>>결제완료</option>
								<%-- <option value="3" <c:if test="${search.paymentState eq '3'}">selected</c:if>>일부결제</option> --%>
								<option value="4" <c:if test="${search.paymentState eq '4'}">selected</c:if>>환불</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>과정선택</th>
						<td>
							<!-- 과정 선택 -->
							<input type='text' class="inputSelect" id='courseName' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />
						</td>
					</tr>
					<tr>
						<th>기수선택</th>
						<td>
							<!-- 기수 선택 -->
							<input type='text' class="inputSelect" id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
						</td>
					</tr>
	        		<tr>
	        			<td class="buttonTd" colspan="2">
							<button id='searchBtn' class="btn-primary" type="button">검색</button>
	        			</td>
	        		</tr>
	        		</table>
				</div>
				<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<!-- 그룹연수 구분 -->
        	<input type="hidden" name="groupLearnYn" value='<c:out value="${search.groupLearnYn}" default="" />' />
        	<!-- 기수와 과정 ID 세팅 -->
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" id="learnType" value='<c:out value="${search.cardinal.learnType}" default="" />' />
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>연번</th>
				<th>번호</th>
				<th>신청일자</th>
				<th>성명</th>
				<th>아이디</th>
				<th>기수</th>
				<th>연수 과정명</th>
				<th>학점</th>
				<!-- <th>연수 지명 번호</th> -->
				<th>결제상태</th>
				<th>결제금액</th>
				<!-- <th>교재</th> -->
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