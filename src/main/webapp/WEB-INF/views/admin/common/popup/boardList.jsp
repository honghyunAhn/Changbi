<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>게시물관리</title>

<script type="text/javascript">
$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/board/popup/boardList' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".popup_pagination"));
	
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
			data 	: $("form[name='popupSearchForm']").serialize(),
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
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td class='popup_content_edit' style='text-align:left'>");
						sb.Append("		&nbsp;"+dataInfo.title);
						
						if(dataInfo.boardType == "4") {
							sb.Append(		(dataInfo.boardReply && dataInfo.boardReply.id > 0 ? "<span style='color:red;'>답변완료</span>" : "<span style='color:black;'>답변대기</span>") );
						}
						
						sb.Append("	</td>");
						sb.Append("	<td>"+(dataInfo.user ?  dataInfo.user.name : (dataInfo.regUser ? dataInfo.regUser.name : ""))+"</td>");
						sb.Append("	<td>"+(dataInfo.hits ? dataInfo.hits : 0)+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='5'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
				
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
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		var title = $(":hidden[name='boardType']").val() == "1" ? "공지사항" : "QnA";
		
		// 선택 된 ID 를 hidden id 값으로 세팅하고 form submit
		$(":hidden[name='id']").val($(":hidden[name='checkId']").eq(idx).val());
		
		openLayerPopup(title, "/admin/common/popup/boardEdit", $("form[name='popupSearchForm']").serialize());
	});
	
	// 신규생성 버튼 클릭 시
	$("#popupAddBtn").unbind("click").bind("click", function() {
		var title = $(":hidden[name='boardType']").val() == "1" ? "공지사항" : "QnA";
		
		// 폼 이동(ID가 int인 경우 0을 넣어줌)
		$(":hidden[name='id']").val("0");
		
		openLayerPopup(title, "/admin/common/popup/boardEdit", $("form[name='popupSearchForm']").serialize());
	});
	
	setContentList();
});

</script>
</head>

<body>
<div id="wrapper">
    <div>
        <div>     	
        	<!-- popupUserSearchForm start -->
        	<form name="popupSearchForm" method="post" class="form-inline" onsubmit="return false;">
	        	<input type="hidden" name="id" value="0" />
	        	<!-- pageNo -->
	        	<input type="hidden" name="pageNo" value='1' />
	        	
	        	<!-- 사용여부 Y인 경우만 조회 -->
	        	<input type="hidden" name="useYn" value='Y' />
	        	
	        	<!-- 게시물 타입 -->
	        	<input type="hidden" name="boardType" value='<c:out value="${search.boardType}" default="1" />' />
	        	
	        	<!-- 공지타입 -->
        		<input type="hidden" name="noticeType" value='<c:out value="${search.noticeType}" default="" />' />
        		
        		<!-- 기수ID, 과정ID, 강사 ID -->
        		<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinalId}" default="" />' />
        		<input type="hidden" name="courseId" value='<c:out value="${search.courseId}" default="" />' />
        		<input type="hidden" name="teacherId" value='<c:out value="${search.teacherId}" default="" />' />
	        	
	        	<div class="col-lg-12">
					<!-- 키워드 검색 -->
					<div class="input-group">키워드검색</div>
					<select name="searchCondition">
						<option value='all'>전체</option>
						<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
					</select>
					
					<div class="input-group">
						<input type="text" class="form-control" placeholder="검색어" id="popupSearchKeyword" name="searchKeyword" value="<c:out value="${search.searchKeyword}" default="" />">
						<span class="input-group-btn">
	                    	<a type="button" class="btn" id="popupSearchBtn"><i class="fa fa-search">검색</i></a>
	                    </span>
	               	</div>
				</div>
			</form>
			<!-- //popupSearchForm end -->
			
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>연번</th>
						<th>게시일자</th>
						<th>제목</th>
						<th>게시자</th>
						<th>조회수</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody"></tbody>
				</table>
			</div>
			<div class="popup_pagination"></div>
			
			<div class="paging">
			<c:if test="${search.boardType ne '4'}">
				<a id="popupAddBtn" class="btn align_right primary" href="javascript:void();">신규등록</a>
			</c:if>
		</div>
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>