<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/board/noteList' />";
	var editUrl	= "<c:url value='/admin/board/noteEdit' />";
	var excelUrl = "";
	
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
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
							sb.Append("<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
							/* sb.Append("<td>");
							sb.Append("<input type='checkbox' name='select' />");
							sb.Append("</td>"); */

							switch ($("select[name='searchCondition']").val()) {
								case "send" : // send
									$('table > thead > tr > th').eq(0).text("받는이");
									sb.Append("<td>"+dataInfo.toUserId+"</td>");	
									break;
								default : // receive
									$('table > thead > tr > th').eq(0).text("보낸이");
									sb.Append("<td>"+dataInfo.fromUserId+"</td>");	
									break;
							}
							
							sb.Append("<td class='content_edit'>"+dataInfo.title+"</td>");
							sb.Append("<td>"+dataInfo.sendDate.substring(0,4)+"-"+dataInfo.sendDate.substring(4,6)+"-"+dataInfo.sendDate.substring(6,8)+"</td>");
							sb.Append("<td>"+(dataInfo.procYn == 'Y' ? "읽음" : "읽지않음")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='5'>조회된 결과가 없습니다.</td>");
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
		contentLoad("쪽지 상세", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 추가 버튼(추가 페이지 호출)
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		//$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("쪽지 발송", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 엑셀저장
	$("#saveExcelBtn").unbind("click").bind("click", function() {
		alert("EXCEL 저장");
	});

	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
	$("select[name='searchCondition']").on("change", function() {
		$('#searchBtn').trigger("click");
	});
});

</script>

<div class="content_wraper">
	<h3>타이틀</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
			<select name="searchCondition">
				<option value='receive' <c:if test="${search.searchCondition eq 'receive'}">selected</c:if>>받은쪽지함</option>
				<option value='send' <c:if test="${search.searchCondition eq 'send'}">selected</c:if>>보낸쪽지함</option>
			</select>
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<!-- <th><input type='checkbox' name='selectAll' /></th> -->
				<th>보낸이</th>	
				<th>쪽지제목</th>
				<th>발신일시</th>
				<th>처리상태</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
	</div>
</div>