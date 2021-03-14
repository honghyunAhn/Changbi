<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/learnApp/learnChangeList' />";
	var changeUrl = "<c:url value='/data/learnApp/learnChange' />";
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
					var dataList 	= result.list;
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
						sb.Append("	<td>"+dataInfo.id+"</td>");
						sb.Append("	<td>"+((regDate && regDate.length >= 8) ? regDate.substring(0,4)+"-"+regDate.substring(4,6)+"-"+regDate.substring(6,8) : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.cardinal && dataInfo.cardinal.name) ? dataInfo.cardinal.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.oldCourse && dataInfo.oldCourse.name) ? dataInfo.oldCourse.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.newCourse && dataInfo.newCourse.name) ? dataInfo.newCourse.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.phone) ? dataInfo.user.phone : "")+"</td>");
						sb.Append(" <td>"+(dataInfo.state == "1" ? "변경신청" : (dataInfo.state == "2" ? "변경완료" : "변경불가"))+"</td>");
						sb.Append("	<td>");
						if(dataInfo.state == "1") {
							sb.Append("		<input type='hidden' name='changeId' value='"+dataInfo.id+"' />");
							sb.Append("		<input type='hidden' name='changeLearnAppId' value='"+dataInfo.learnApp.id+"' />");
							sb.Append("		<input type='hidden' name='changeCourseId' value='"+dataInfo.newCourse.id+"' />");
							sb.Append("		<a class='btn change_btn' href='javascript:void(0);'>변경처리</a>");
						}
						sb.Append("	</td>");

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
	
	// 선택 변경처리 클릭 시
	$("#dataListBody").on("click", ".change_btn", function() {
		var idx = $(".change_btn").index($(this));
		var data = new Object();

		// 변경신청데이터
		data.id = $(":hidden[name='changeId']").eq(idx).val();
		data["learnApp.id"] = $(":hidden[name='changeLearnAppId']").eq(idx).val();
		data["learnApp.course.id"] = $(":hidden[name='changeCourseId']").eq(idx).val();
			
		if(confirm("변경 처리 하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			/* $("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []);
			}); */

			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: changeUrl,
				data 	: data,
				success	: function(result) {
					if(result > 0) {
						alert("변경 처리 되었습니다.");
						
						setContentList();
					} else {
						alert("변경 처리 실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
});

</script>

<div class="content_wraper">
	<h3>수강변경관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 검색조건 -->
        	<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
			</select>
			
			<!-- 검색키워드 -->
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			
			<!-- 처리상태 -->
			<select name='state'>
				<option value="">처리상태</option>
				<option value="1" <c:if test="${search.state eq '1'}">selected</c:if>>변경신청</option>
				<option value="2" <c:if test="${search.state eq '2'}">selected</c:if>>변경완료</option>
				<option value="3" <c:if test="${search.state eq '3'}">selected</c:if>>변경불가</option>
			</select>
			
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>연번</th>
				<th>접수번호</th>
				<th>접수일자</th>
				<th>기수</th>
				<th>변경전과정</th>
				<th>변경후과정</th>
				<th>아이디</th>
				<th>성명</th>
				<th>연락처</th>
				<th>처리상태</th>
				<th>변경처리</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
	</div>
</div>