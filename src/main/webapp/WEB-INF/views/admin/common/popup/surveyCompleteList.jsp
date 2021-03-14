<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/surveyCompleteList.css" />">

<script type="text/javascript">
var completeList;
var noAnswerList;

$(document).ready(function(){
	completeList = ${completeList};
	noAnswerList = ${noAnswerList};
	showList();
});

function showList(){
	var sb = new StringBuilder();
	var ck = $('input:radio[name=surveyComplete]:checked').val();
	
	switch(ck){
	case 'Y':
		if(completeList.length > 0){
			for(var i=0; i<completeList.length; i++){
				sb.Append('<tr>');
				sb.Append('<td>' + (i+1) + '</td>');
				sb.Append('<td>' + completeList[i].USER_NM + '</td>');
				sb.Append('<td>' + completeList[i].USER_ID + '</td>');
				sb.Append('</tr>');
			}
		}else{
			sb.Append('<tr>');
			sb.Append('<td colspan=3>응답자가 없습니다.</td>')
			sb.Append('</tr>');
		}
		break;
	case 'N':
		if(noAnswerList.length > 0){
			for(var i=0; i<noAnswerList.length; i++){
				sb.Append('<tr>');
				sb.Append('<td>' + (i+1) + '</td>');
				sb.Append('<td>' + noAnswerList[i].USER_NM + '</td>');
				sb.Append('<td>' + noAnswerList[i].USER_ID + '</td>');
				sb.Append('</tr>');
			}
		}else{
			sb.Append('<tr>');
			sb.Append('<td colspan=3>미응답자가 없습니다.</td>')
			sb.Append('</tr>');
		}
		break;
	}
	$('#listBody').html(sb.ToString());
}
</script>

<div class="content_wraper tables_wrapper">
	<input type="radio" name="surveyComplete" value="Y" onchange="showList()" checked>응답
	<input type="radio" name="surveyComplete" value="N" onchange="showList()">미응답
	
	<table class="table-hover" style="border-collapse: collapse;">
		<thead>
			<tr>
				<th>NO</th>
				<th>이름</th>
				<th>ID</th>
			</tr>
		</thead>
		<tbody id="listBody"></tbody>
	</table>
</div>