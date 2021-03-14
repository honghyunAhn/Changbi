<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/course/chapterList' />";
	var regUrl = "<c:url value='/data/course/chapterReg' />";
	var newRegUrl = "<c:url value='/data/course/newChapterReg' />";
	var delUrl = "<c:url value='/data/course/chapterDel' />";
	var courseUrl = "<c:url value='/admin/course/trainProcessList' />";
	
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
			data 	: $("form[name='actionForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						sb.Append("<tr>");
						sb.Append(" <input type='hidden' name='chkId' value='"+dataInfo.id+"' />");
						sb.Append("	<td class='order_num' style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap;'>"+dataInfo.orderNum+"</td>");
						sb.Append("	<td class='content_td' style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap; color:blue; cursor: pointer;'>"+dataInfo.name+"</td>");
						sb.Append("	<td class='study' style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap;'>"+dataInfo.study+"</td>");
						sb.Append("	<td class='chk' style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap;'>"+dataInfo.chk+"</td>");
						sb.Append("	<td class='main_url' style='overflow:auto;'>"+(dataInfo.mainUrl ? dataInfo.mainUrl : "")+"</td>");
						sb.Append("	<td class='mobile_url' style='overflow:auto;'>"+(dataInfo.mobileUrl ? dataInfo.mobileUrl : "")+"</td>");
						sb.Append("	<td class='teacher' style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap;'>"+(dataInfo.teacher ? dataInfo.teacher : "") +"</td>");
						sb.Append("	<td><button type='button' class='del_btn btn align_right danger' style='width: 50px; height: 40px; line-height: 40px;'>삭제</button></td>");
						sb.Append("</tr>");
					}
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
		// 초기화 시킴
		initForm();
		
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 분류 세팅
	$("#dataListBody").on("click", ".content_td", function() {
		var idx = $(".content_td").index($(this));
		
		// 선택 된 값 세팅
		$(":hidden[name='id']").val($(":hidden[name='chkId']").eq(idx).val());
		
		$(":text[name='orderNum']").val($(".order_num").eq(idx).text());
		$(":text[name='name']").val($(this).text());
		$(":text[name='study']").val($(".study").eq(idx).text());
		$(":text[name='chk']").val($(".chk").eq(idx).text());
		$(":text[name='mainUrl']").val($(".main_url").eq(idx).text());
		$(":text[name='mobileUrl']").val($(".mobile_url").eq(idx).text());
		$(":text[name='teacher']").val($(".teacher").eq(idx).text());
	});
	
	// 삭제 기능
	$("#dataListBody").on("click", ".del_btn", function() {
		if(confirm("삭제하시겠습니까?")) {
			var idx		= $(".del_btn").index($(this));
			var data	= {id : $(":hidden[name='chkId']").eq(idx).val()};
			
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: data,
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						
						// 삭제 후 id값을 0으로 초기화 시킴
						initForm();
						
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
			alert("연번을 입력하세요.")
			$(":text[name='orderNum']").focus();
		} else if(!$(":text[name='name']").val()) {
			alert("챕터명을 입력하세요.")
			$(":text[name='name']").focus();
		} else if(!$(":text[name='study']").val()) {
			alert("교육(분)을 입력하세요.")
			$(":text[name='study']").focus();
		} else if(!$(":text[name='chk']").val()) {
			alert("체크(분)을 입력하세요.")
			$(":text[name='chk']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			var flag=$("#insertid").val();
			if(flag==0){
				$.ajax({
					type	: "post",
					url		: newRegUrl,
					data 	: $("form[name='actionForm']").serialize(),
					success	: function(result) {
						if(result.id > 0) {
							alert("저장되었습니다.");
							
							// 삭제 후 id값을 0으로 초기화 시킴
							initForm();
							
							setContentList();
						} else {
							initForm();
							setContentList();
						}
					},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
			}else{
				$.ajax({
					type	: "post",
					url		: regUrl,
					data 	: $("form[name='actionForm']").serialize(),
					success	: function(result) {
						if(result.id > 0) {
							alert("저장되었습니다.");
							
							// 삭제 후 id값을 0으로 초기화 시킴
							initForm();
							
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
			
			
		}
	});
	
	// 신규버튼 클릭 시
	$("#newBtn").unbind("click").bind("click", function() {
		// 삭제 후 id값을 0으로 초기화 시킴
		initForm();
	});
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수과정관리", courseUrl, $("form[name='searchForm']").serialize());
	});
	
	// 처음 리스트 생성
	setContentList();
});

function initForm() {
	$(":hidden[name='id']").val("0");
	
	$(":text[name='orderNum']").val("1");
	$(":text[name='name']").val("");
	$(":text[name='study']").val("60");
	$(":text[name='chk']").val("20");
	$(":text[name='mainUrl']").val("");
	$(":text[name='mobileUrl']").val("");
	$(":text[name='teacher']").val("");
}
 
</script>

<div class="content_wraper">
	<h3>세부차시관리</h3>
	<!-- searchForm start -->
      	<form name="searchForm" method="post">
      		<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
		<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
		<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
		<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />		 
		<input type='hidden' name='courseCode.code' value='<c:out value="${search.courseCode.code}" default="" />' />
		<input type='hidden' name='company.id' value='<c:out value="${search.company.id}" default="" />' />
	</form>
	<!-- //searchForm end -->
	
	<!-- actionForm start -->
	<form name="actionForm" method="post">
       	<input type='hidden' id="insertid" name='id' value='0' />
		<input type="hidden" name="course.id" value="<c:out value="${course.id}" default="" />" />
		<input type="hidden" name="serviceType" value="P" />
		
		<dl>
			<dt>모바일서비스</dt>
			<dd class="half">
				<c:choose>
					<c:when test="${course.mobileYn eq 'Y'}">모바일 서비스 지원</c:when>
					<c:otherwise>모바일 서비스 안함</c:otherwise>
				</c:choose>
			</dd>
			<dt>과정명</dt>
			<dd class="half">
				<c:out value="${course.name}" default="" />
			</dd>
		</dl>
		
		
		<div id="tabMenu">
			<div class="tab">
				<ul class="tab_head">
					<li><a href="javascript:void(0)" class="tablink on">컨텐츠 관리 기능</a></li>
				</ul>
			</div>
		</div>
		
		<table style="border-collapse: collapse; table-layout:fixed;">
			<thead>
			<tr>
				<th style='width: 50px;'>연번</th>
				<th>차시명</th>
				<th style='width: 50px;'>교육(분)</th>
				<th style='width: 50px;'>체크(분)</th>
				<th>PC(URL)</th>
				<th>모바일(URL)</th>
				<th style='width: 100px;'>강사명</th>
				<th style='width: 110px;'>관리</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
			<tbody>
			<tr>
				<td colspan="8" style="height: 20px; line-height: 20px; border-bottom-color: red;"></td>
			</tr>
			<tr>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='orderNum' value="1" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='name' value="" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='study' value="60" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='chk' value="20" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='mainUrl' value="" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='mobileUrl' value="" /></td>
				<td style="border-color: red;"><input type='text' class='w100' style='height: 40px; line-height: 40px;' name='teacher' value="" /></td>
				<td style="border-color: red;">
					<button type='button' class="btn align_right standby" id='regBtn' style="width: 50px; height: 40px; line-height: 40px;">저장</button><button type='button' class="btn align_right primary" id='newBtn' style="width: 50px; height: 40px; line-height: 40px;">신규</button>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	<!-- //actionForm end -->
	
	<div>
		<a id="listBtn" class="btn align_right primary" href="javascript:void(0);">리스트</a>
	</div>
</div>
