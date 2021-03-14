<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/course/cardinalList' />";
	var editUrl	= "<c:url value='/admin/course/cardinalEdit' />";
	var selectDelUrl = "<c:url value='/data/course/cardinalSelectDel' />";	// 기수 선택 삭제
	var saveExcelUrl = "<c:url value='/data/course/excel/download/cardinalList' />";	// 기수 리스트 엑셀 다운로드
	
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

						sb.Append('<tr>');
						sb.Append("	<td><input type='checkbox' name='selectCheckBox' /></td>");
						sb.Append("	<td>");
						sb.Append("		<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");						 
						/* 
						sb.Append("	<td></td>");
						sb.Append("	<td></td>");
						sb.Append("	<td></td>");
						*/
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.appStartDate+"</td>");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+dataInfo.learnStartDate+" ~ "+dataInfo.learnEndDate+"</td>");
						sb.Append("	<td>"+dataInfo.name+"</td>");
						sb.Append("	<td>"+(dataInfo.complateYn == "N" ? "예정" : "종료")+"</td>");
						
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='8'>조회된 결과가 없습니다.</td>");
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
		contentLoad("기수관리상세", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		$(":hidden[name='id']").val("");
		
		// ajax로 load
		contentLoad("기수관리상세", editUrl, $("form[name='searchForm']").serialize());
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
		시험 관리
	</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 연수타입 -->
        	<input type="hidden" name="learnType" value='<c:out value="${search.learnType}" default="J" />' />
        	
        	<!-- 직무메뉴학점구분 -->
        	<input type="hidden" name="credits" value='<c:out value="${search.credits}" default="" />' />

			<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>기수명</option>
				<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>기수코드</option>
			</select>
			
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<!--  
			<select name='useYn'>
				<option value="">상태구분</option>
				<option value="Y" <c:if test="${search.useYn eq 'Y'}">selected</c:if>>서비스</option>
				<option value="N" <c:if test="${search.useYn eq 'N'}">selected</c:if>>중지</option>
			</select>
			
			<select name='complateYn'>
				<option value="">이수구분</option>
				<option value="Y" <c:if test="${search.complateYn eq 'Y'}">selected</c:if>>처리</option>
				<option value="N" <c:if test="${search.complateYn eq 'N'}">selected</c:if>>미처리</option>
			</select>
			-->
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type='checkbox' id='allCheckBox' /></th>
				<th>연번</th>
				<th>과정명</th>
				<th>기수명</th>
				<th>테스트번호</th>
				<th>시험명</th>
				<th>카테고리</th>
				<th>시험내용 및 범위</th>
				<th>시험날짜</th>
				<th>재응시 횟수</th>
				<th>상태</th>
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