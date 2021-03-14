<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/comCodeEdit.css" />">

<script type="text/javascript">

function makeObj(data){
	var search = $("form[name='popupSearchForm']").serializeObject();
	var obj = new Object();
		obj.search = JSON.stringify(search);
		obj.data = JSON.stringify(data);
	return obj;
}

function updateGroupCode(obj){
	var search = $("form[name='popupSearchForm']").serialize();
	var data = new Object();
	data.group_id = $(obj).closest('tr').find('td').eq(0).text();
	data.group_nm = $(obj).closest('tr').find('input').eq(0).val();
	data.group_detail = $(obj).closest('tr').find('input').eq(1).val();
	
	$.ajax({
		url:"<c:url value='/data/basic/updateGroupCode' />",
		type:		"post",
		data:		data,
		dataType:	"json",
		success:function(result){
			if(result){
				alert("그룹코드를 수정하였습니다.");
				openLayerPopup("공통코드 수정", "/admin/common/popup/comCodeEdit", makeObj(data));
				contentLoad('공통코드관리','/admin/basic/comCode', search);
			}
			else alert("수정 실패");
		},
	});
}

function updateCode(obj){
	var search = $("form[name='popupSearchForm']").serialize();
	var data = new Object();
	data.code_seq = $(obj).closest('tr').find('input').eq(0).val();
	data.group_id = $(obj).closest('tr').find('input').eq(1).val();
	data.code = $(obj).closest('tr').find('input').eq(2).val();
	data.code_nm = $(obj).closest('tr').find('input').eq(3).val();
	data.code_nm_ja = $(obj).closest('tr').find('input').eq(4).val();
	data.code_nm_en = $(obj).closest('tr').find('input').eq(5).val();
	data.code_detail = $(obj).closest('tr').find('input').eq(6).val();
	
	$.ajax({
		url:"<c:url value='/data/basic/updateComCode' />",
		type:		"post",
		data:		data,
		dataType:	"json",
		success:function(result){
			if(result){
				alert("공통코드를 수정하였습니다.");
				openLayerPopup("공통코드 수정", "/admin/common/popup/comCodeEdit", makeObj(data));
				contentLoad('공통코드관리','/admin/basic/comCode', search);
			}
			else alert("수정 실패");
		},
	});
}

function deleteCode(obj){
	if(!confirm("공통코드를 삭제하시겠습니까?")) return;
	
	var search = $("form[name='popupSearchForm']").serialize();
	var data = new Object();
	data.group_id = $(obj).closest('tr').find('input').eq(1).val();
	data.code = $(obj).closest('tr').find('input').eq(2).val();
	
	$.ajax({
		url:"<c:url value='/data/basic/deleteComCode' />",
		type:		"post",
		data:		data,
		dataType:	"json",
		success:function(result){
			if(result){
				alert("공통코드가 삭제되었습니다.");
				openLayerPopup("공통코드 수정", "/admin/common/popup/comCodeEdit", makeObj(data));
				contentLoad('공통코드관리','/admin/basic/comCode', search);
			}
			else alert("삭제 실패");
		},
	});
}

function insertCode(){
	var search = $("form[name='popupSearchForm']").serialize();
	var data = new Object();
	data.group_id = $('#groupIdBody').find('td').eq(0).text();
	data.code = $('#code').val();
	data.code_nm = $('#code_nm').val();
	data.code_nm_ja = $('#code_nm_ja').val();
	data.code_nm_en = $('#code_nm_en').val();
	data.code_detail = $('#code_detail').val();
	
	for(key in data){
		if(data[key] == ''){
			alert('모든 항목에 입력해주세요.');
			return;
		}
	}
	
	$.ajax({
		url:"<c:url value='/data/basic/insertComCode' />",
		type:		"post",
		data:		data,
		dataType:	"json",
		success:function(result){
			if(result){
				alert("공통코드가 추가되었습니다.");
				openLayerPopup("공통코드 수정", "/admin/common/popup/comCodeEdit", makeObj(data));
				contentLoad('공통코드관리','/admin/basic/comCode', search);
			}
			else alert("코드 저장 실패");
		},
	});
}

</script>

<div class="content_wraper tables_wrapper">
	<form name="popupSearchForm" method="post">
		<input type="hidden" name="code_group" value="${search.code_group}">
		<input type="hidden" name="searchCondition" value="${search.searchCondition}">
		<input type="hidden" name="searchKeyword" value="${search.searchKeyword}">
	</form>
	
	<table class="table-hover" style="border-collapse: collapse;">
		<thead>
			<tr>
				<th>그룹ID</th>
				<th>그룹명</th>
				<th>설 명</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="groupIdBody">
			<tr>
				<td>${codeInfo.group_id }</td>
				<td><input type="text" value="${codeInfo.group_nm }"></td>
				<td><input type="text" value="${codeInfo.group_detail }" size=40></td>
				<td><button type="button" class="btn primary" onclick="updateGroupCode(this)">수정</button></td>
			</tr>
		</tbody>
	</table>
	<br><br><br>
	
	<table class="table-hover" style="border-collapse: collapse;">
		<thead>
			<tr>
				<th>코드</th>
				<th>코드명</th>
				<th>일본어</th>
				<th>영어</th>
				<th>설 명</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="codeListBody">
			<c:forEach var="code" items="${codeInfo.codeList }">
				<c:if test="${code.code ne null }">
					<tr>
						<td>
							<input type="hidden" value="${code.code_seq }">
							<input type="hidden" value="${code.group_id }">
							<input type="text" value="${code.code }" size=1 maxlength=2>
						</td>
						<td><input type="text" value="${code.code_nm }"></td>
						<td><input type="text" value="${code.code_nm_ja }" size=5></td>
						<td><input type="text" value="${code.code_nm_en }" size=3></td>
						<td><input type="text" value="${code.code_detail }"></td>
						<td>
							<button type="button" class="btn primary" onclick="updateCode(this)">수정</button>
							<button type="button" class="btn primary" onclick="deleteCode(this)">삭제</button>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td><input type="text" id="code" size=1 maxlength=2></td>
				<td><input type="text" id="code_nm"></td>
				<td><input type="text" id="code_nm_ja" size=5></td>
				<td><input type="text" id="code_nm_en" size=3></td>
				<td><input type="text" id="code_detail"></td>
				<td><button type="button" class="btn primary danger" onclick="insertCode()">추가</button></td>
			</tr>
		</tbody>
	</table>
</div>