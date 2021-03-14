<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="<c:url value="/resources/js/ext/jquery/jquery-ui.min.js"/>"></script>

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/basic/bannerList' />";
	var delUrl = "<c:url value='/data/basic/bannerDel' />";
	var editUrl = "<c:url value='/admin/basic/bannerEdit' />";
	var managedUrl = "<c:url value='/data/basic/bannerManaged' />";
	var stateUrl	= "<c:url value='/data/basic/bannerState' />";
	var orderUrl	= "<c:url value='/data/basic/bannerOrder' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// 미사용 배너 리스트 출력
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
						var position = dataInfo.position;
						if (position == "1") {
							position = "최상단";
						} else if (position == "2") {
							position = "메인";
						} else if (position == "3"){
							position = "띠";
						} else {
							position = "Hot&New";
						}
						sb.Append("<tr>");
						sb.Append("	<input type='hidden' name='checkPosition' value='"+dataInfo.position+"' />");
						sb.Append("	<input type='hidden' class='fileId' value='"+(dataInfo.img1 ? dataInfo.img1.fileId : '')+"' />");
						sb.Append("	<td>");
						sb.Append("	<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
						sb.Append(		((pageNo-1)*numOfRows+(i+1)));
						sb.Append("	</td>");
						sb.Append("	<td class='position'>"+position+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.title+"</td>");
						sb.Append("	<td class='url'>"+dataInfo.url+"</td>");
						sb.Append("	<td class='target'>"+dataInfo.target+"</td>");
						sb.Append("	<td><button type='button' class='useBtn'>사용</button></td>");
						sb.Append("	<td><button type='button' class='del_btn'>삭제</button></td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='7'>조회된 결과가 없습니다.</td>");
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
	
	function setManagedList() {
		// 관리 배너 리스트 출력
		$.ajax({
			type	: "post",
			url		: managedUrl,
			success	: function(result) {
				var sb1 = new StringBuilder();
				var sb2 = new StringBuilder();
				var sb3 = new StringBuilder();
				var sb4 = new StringBuilder();
				
				for (var i=0; i<result.length; i++) {
					var sb = new StringBuilder();
					var dataInfo = result[i];
					
					if (dataInfo.position == '1') {
						sb = sb1;
					} else if (dataInfo.position == '2') {
						sb = sb2;
					} else if (dataInfo.position == '3'){
						sb = sb3;
					} else if (dataInfo.position == '4'){
						sb = sb4;
					}
					
					sb.Append("<tr>");
					sb.Append("	<input type='hidden' name='checkId' value='"+dataInfo.id+"' />");
					sb.Append("	<input type='hidden' name='checkPosition' value='"+dataInfo.position+"' />");
					sb.Append("	<input type='hidden' class='fileId' value='"+(dataInfo.img1 ? dataInfo.img1.fileId : '')+"' />");
					sb.Append("	<td class='content_edit'>"+dataInfo.title+"</td>");
					sb.Append("	<td class='url'>"+dataInfo.url+"</td>");
					sb.Append("	<td class='target'>"+dataInfo.target+"</td>");
					sb.Append("	<td><button type='button' class='delBtn'>삭제</button></td>");
					sb.Append("</tr>");
				}
				
				if (sb1.buffer.length == 0) {
					sb1.Append("<tr>");
					sb1.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb1.Append("</tr>");
				}
				if (sb2.buffer.length == 0) {
					sb2.Append("<tr>");
					sb2.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb2.Append("</tr>");
				} else{
					sb2.Append("<tr id='fix'>");
					sb2.Append("	<td colspan='6'><button type='button' class='orderBtn'>순서 저장</button></td>");
					sb2.Append("</tr>");
				}
				if (sb3.buffer.length == 0) {
					sb3.Append("<tr>");
					sb3.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb3.Append("</tr>");
				}
				if (sb4.buffer.length == 0) {
					sb4.Append("<tr>");
					sb4.Append("	<td colspan='6'>조회된 결과가 없습니다.</td>");
					sb4.Append("</tr>");
				} else{
					sb4.Append("<tr id='fix'>");
					sb4.Append("	<td colspan='6'><button type='button' class='orderBtn'>순서 저장</button></td>");
					sb4.Append("</tr>");
				}
				
				$("#topListBody").html(sb1.ToString());
				$("#mainListBody").html(sb2.ToString());
				$("#midListBody").html(sb3.ToString());
				$("#hotAndNewListBody").html(sb4.ToString());
			
				// 메인배너, hot&new 순서지정을 위한 드래그앤 드롭 추가
				$( function() {
				    $("#mainListBody, #hotAndNewListBody").sortable({
				    	items: 'tr:not(#fix)'
				    });
				    $("#mainListBody, #hotAndNewListBody").disableSelection();
				} );
				
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});

	// 삭제 기능
	$("#dataListBody").on("click", ".del_btn", function() {
		if(confirm("삭제하시겠습니까?")) {
			var idx		= $(".del_btn").index($(this));
			var _target	= $(this);
			var data	= {id : $("#dataListBody").find(":hidden[name='checkId']").eq(idx).val()};
			
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: data,
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");						
						setContentList();
						
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 사용배너 미사용으로 변경
	$("#topListBody, #mainListBody, #midListBody, #hotAndNewListBody").on("click", ".delBtn", function() {
		if(confirm("미사용으로 변경하시겠습니까?")) {
			var idx		= $(".delBtn").index($(this));
			var _target	= $(this);
			var data	= {
					id : $(":hidden[name='checkId']").eq(idx).val()
					, position : $(":hidden[name='checkPosition']").eq(idx).val()
					, useYn : 'Y'
				};
			
			$.ajax({
				type	: "post",
				url		: stateUrl,
				data 	: data,
				success	: function(result){
					if (result) {
						alert("변경되었습니다.");
						setContentList();
						setManagedList();
					} else {
						alret("변경실패하였습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 미사용 배너 사용으로 변경
	$("#dataListBody").on("click", ".useBtn", function() {
		if(confirm("사용하시겠습니까?")) {
			var idx = $(".useBtn").index($(this));
			var _target = $(this);
			
			var position = $("#dataListBody").find(":hidden[name='checkPosition']").eq(idx).val();
			
			if (position == "1" && $("#topListBody input").length > 0) {
				alert("최상단 배너는 하나만 등록 가능합니다.");
				return;
			} else if (position == "3" && $("#midListBody input").length > 0) {
				alert("띠 배너는 하나만 등록 가능합니다.");
				return;
			} else if (position == "4" && $("#hotAndNewListBody tr").length == 4) {
				alert("Hot&New는 3개만 등록 가능합니다.");
				return;
			}
			
			var data = {
				id : $("#dataListBody").find(":hidden[name='checkId']").eq(idx).val()
				, position : position
				, useYn : 'N'
			};
			
			$.ajax({
				type	: "post",
				url		: stateUrl,
				data 	: data,
				success	: function(result){
					if (result) {
						alert("변경되었습니다.");
						setContentList();
						setManagedList();
					} else {
						alret("변경실패하였습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
			
		}
	})
	
	// 메인배너, hot&new 순서 저장
	$("#mainListBody, #hotAndNewListBody").on("click", ".orderBtn", function() {	
		if (confirm("순서를 변경하시겠습니까?")) {
			var banner_seq_array = new Array();
			var target = "#" + $(this).closest("tbody").attr("id");
			
			$(target).find(":hidden[name='checkId']").each(function(index,element){
				banner_seq_array.push($(this).val());
			})
			
			jQuery.ajaxSettings.traditional = true;

			$.ajax({
				type : 'POST'
				, url : orderUrl
				, data : {
					banner_seq_array : banner_seq_array
				}
				, success : function() {
					alert('순서가 변경되었습니다.');
					setManagedList();
				}
				, error : function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			
			});
		}
	});
	
	// 클릭 시 상세 페이지 이동
	$("#dataListBody, #topListBody, #mainListBody, #midListBody, #hotAndNewListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		// ajax로 load
		contentLoad("배너 수정", editUrl, $("form[name='searchForm']").serialize());
	});
	
	$("#addBtn").unbind("click").bind("click", function() {
		// 폼 이동
		$(":hidden[name='id']").val("0");
		
		// ajax로 load
		contentLoad("배너 등록", editUrl, $("form[name='searchForm']").serialize());
	});
	
	// 처음 리스트 생성
	setContentList();
	setManagedList();
});
</script>

<div class="content_wraper">
	<h3>배너관리</h3>
	<div class="tab_body">
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th colspan="5">최상단</th>
				</tr>
				<tr>
					<th>배너명</th>
					<th>URL</th>
					<th>Target</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="topListBody"></tbody>
		</table>
		<br>
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th colspan="5">메인슬라이드</th>
				</tr>
				<tr>
					<th>배너명</th>
					<th>URL</th>
					<th>Target</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="mainListBody"></tbody>
		</table>
		<br>
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th colspan="5">띠</th>
				</tr>
				<tr>
					<th>배너명</th>
					<th>URL</th>
					<th>Target</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="midListBody"></tbody>
		</table>
		<br>
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th colspan="5">Hot&New</th>
				</tr>
				<tr>
					<th>배너명</th>
					<th>URL</th>
					<th>Target</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="hotAndNewListBody"></tbody>
		</table>
		
		<h4>배너 리스트</h4>
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<input type="hidden" name="id" value="<c:out value="${banner.id}" default="0" />" />
			<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
			<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>배너명</option>
			</select>
			
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm start -->
       	<form name="actionForm" method="post">
			<table style="border-collapse: collapse;">
				<thead>
				<tr>
					<th>순번</th>
					<th>위치</th>
					<th>배너명</th>
					<th>URL</th>
					<th>Target</th>
					<th>사용</th>
					<th>관리</th>
				</tr>
				</thead>
				<tbody id="dataListBody"></tbody>
			</table>
		</form>
		<!-- //actionForm end -->
		<div class="pagination"></div>
		<div class="paging">
			<a id="addBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
		</div>
		
	</div>
</div>
