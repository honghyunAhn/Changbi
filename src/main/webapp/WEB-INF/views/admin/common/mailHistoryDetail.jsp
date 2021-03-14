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

<title>SMS - EMAIL 내역</title>

<link href="<c:url value="/resources/student/css/studentTable.css"/>" rel="stylesheet" type="text/css">
<style type="text/css">
ul.mylist li {
    padding: 5px 0px 5px 5px;
    margin-bottom: 5px;
    border-bottom: 1px solid #efefef;
    font-size: 12px;
    line-height: 20px;
}
ul.mylist li:before {
    display: inline-block;
    vertical-align: middle;
    padding: 0px 5px 6px 0px;
}

ol.myllist_ol li {
	float: left; margin-left: 20px;
} 
</style>
<script type="text/javascript">
var detailUrl = "<c:url value='/admin/common/emailHistory'/>"
var smsInfo = '${smsInfo}';
$(function(){
	$(document).on('click', '#listBtn', function(){
		contentLoad("상세정보조회", detailUrl, $('form.searchForm').serialize());
	})
	mailDetail();
})

function mailDetail() {
	var mail_seq = "${search.mail_seq}";
	$.ajax({
		type: "post"
		, url : "/admin/common/mailDetail"
		, dataType : "json"
		, data : {
			"mail_seq" : mail_seq
		} 
		, success : function(result) {
			var content = "";
			content += '<table id="dataTbl" class="table-hover" style="border-collapse: collapse; height: 100%;">';
			content += '<tbody id="dataListBody">';
			content += '<thead><tr><th>이름</th><th>아이디</th><th>이메일</th></tr></thead>';
			$.each(result.list, function(index,item) {
				content +='<tr>';
				content +=		'<td>' + item.USER_ID + '</td>';
				content +=		'<td>' + item.USER_NM + '</td>';
				content +=		'<td>' + item.USER_EMAIL + '</td>';
				content += '</tr>';
			})
			content+='</tbody></table>';
			$('.mylist').html(content);
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	})
}
</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
	<h3>SMS - EMAIL 내역</h3>
    <div class="tab_body">
    	<form class="searchForm" method="post">
	        <input type="hidden" name="start_date" value="<c:out value="${search.start_date}" />">
	        <input type="hidden" name="end_date" value="<c:out value="${search.end_date}" />">
	        <input type="hidden" name="searchCondition" value="${search.searchCondition}">
			<input type="hidden" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
       		<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<!-- n개씩 조회 -->
        	<input type="hidden" name="numOfRows" value='<c:out value="${search.numOfRows}" default="10" />' />
       		<!-- 페이징 처리 -->
        	<input type="hidden" name="pagingYn" value='Y' />
		</form>
		<table style="height: 410px;" class="tg">
			<tbody>
				<c:forEach items="${mailInfo}" var="item">
					<tr class="left_td">
						<th class="tg-0pky">발신대상</th>
						<td class="tg-0pky">
							<div class="mylist">
								<ul>
								
								</ul>
							</div>
						</td>
					</tr>
					<tr class="left_td">
						<th class="tg-0pky">발신날짜</th>
						<td class="tg-0pky"><input type="text" value='${item.MAIL_INS_DATE}' readonly="readonly" style="width: 500px;"></td>
					</tr>
					<tr class="left_td">
						<th class="tg-0pky">제목</th>
						<td class="tg-0pky"><input type="text" value="${item.SEND_TITLE}" readonly="readonly" style="width: 500px;"></td>
					</tr>
					<tr class="left_td">
						<th class="tg-0pky">메일내용</th>
						<td class="tg-0pky"><textarea readonly="readonly" style="resize: none; width: 640px; height: 230px;">${item.SEND_CONTENT}</textarea></td>
					</tr>
				</c:forEach>
			</tbody>
		</table> 
		<div style="text-align: center; margin-top: 10px;">
			<a id="listBtn" style="width: 20%;" class="btn align_right" href="javascript:void();">리스트</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>