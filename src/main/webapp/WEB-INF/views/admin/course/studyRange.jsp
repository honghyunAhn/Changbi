<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/course/studyRangeList' />";
	var regUrl = "<c:url value='/forFaith/base/codeReg' />";
	var delUrl =  "<c:url value='/data/course/studyRangeDelete' />";
	 
	
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
									   
						sb.Append("<tr>");
						sb.Append("	<td class='order_num'>"+dataInfo.orderNum+"</td>");
						sb.Append("	<td class='parentName'>"+dataInfo.parentCode.name+"</td>");
						sb.Append("	<td class='code'>"+dataInfo.code+"</td>");
						sb.Append("	<td class='content_edit'>"+dataInfo.name+"</td>");
						sb.Append("	<td><button type='button' class='del_btn'>삭제</button>");
						sb.Append("     <input type='hidden' class='parentCode' value=\'"+dataInfo.parentCode.code+"\' />");
						sb.Append("	</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='5'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
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
	
	// 클릭 시 분류 세팅
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 의 orderNum 세팅
		$(":text[name='orderNum']").val($(".order_num").eq(idx).text());
		// 선택 된 ID 를 hidden id 값으로 세팅
		$(":text[name='code']").val($(".code").eq(idx).text());		 
	 
		//대분류 selectbox 세팅
		$("#parentCode_old").val($(".parentCode").eq(idx).val());	 		
		var oldSelectedParentCodeVal = $("#parentCode_old").val();		  
		$("select[name='parentCode.code'] option").each(function(index, item){					 
			if($(item).val() == oldSelectedParentCodeVal ){				 
				$(item).attr("selected","selected");
			}
		})
		 
		// 선택 된 분류 명 세팅
		$(":text[name='name']").val($(this).text());
		
	});
	
	// 삭제 기능
	$("#dataListBody").on("click", ".del_btn", function() {
		if(confirm("삭제하시겠습니까?")) {
			var idx		= $(".del_btn").index($(this));
			var _target	= $(this);
			var data	= {code : $(".code").eq(idx).text()};			
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
	
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		if(!$(":text[name='orderNum']").val()) {
			alert("순서를 입력하세요.")
			$(":text[name='orderNum']").focus();
		} else if(!$(":text[name='code']").val()) {
			alert("분류코드를 입력하세요.")
			$(":text[name='code']").focus();
		} else if(!$("#select_parentCode").val()) {
			alert("대분류를 선택하세요.")			 
		} else if(!$(":text[name='name']").val()) {
			alert("분류명을 입력하세요.")
			$(":text[name='name']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			
			 	 
			//확인			
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.code) {
						alert("저장되었습니다.");
						
						setContentList();
					} else {
						alert("저장실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 처음 리스트 생성
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});
 
</script>
 
<div class="content_wraper">
	<h3><c:out value="${codeGroup.name}" default="" /></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<input type="hidden" name="codeGroup.id" value="<c:out value="${search.codeGroup.id}" default="${codeGroup.id}" />" />
       		 
			<select name="searchCondition">
				<option value='all'>전체</option>
				<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>분류명</option>
			</select>
			
			<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
		 
			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm start -->
       	<form name="actionForm" method="post">
		<input type="hidden" name="codeGroup.id" value="<c:out value="${codeGroup.id}" default="" />" />
		<input type="hidden" name="depth" value="1" />
 		
		<table style="border-collapse: collapse;">
			<thead>
				<tr>
					<th>순서</th>
					<th>대분류</th>
					<th>분류코드</th>
					<th>분류명</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
			<tbody>
				<tr>
					<td colspan="5" style="height: 10px; line-height: 10px;">&nbsp;</td>
				</tr>
				<tr>
					<td><input type='text' name='orderNum' /></td>
					<td>						 
						<select id="select_parentCode" name="parentCode.code" >	
							<option value="">선택하세요</option>	
							<c:forEach items="${subCourseList }"  var="parent" >
								<option value='<c:out value="${parent.code}"/>'> ${parent.name }</option>
							</c:forEach>													 
						</select>
								<input type="hidden" id="parentCode_old" value="${parentCode.code }"/>
					</td>
					<td><input type='text' name='code'  /></td>
					<td><input type='text' name='name' /></td>
					<td><button type='button' id='regBtn'>저장</button></td>
				</tr>
			</tbody>
		</table>
		
		</form>
		<!-- //actionForm end -->
	</div>
</div>
