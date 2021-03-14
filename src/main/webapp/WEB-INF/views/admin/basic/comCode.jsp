<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/comCode.css" />">

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var listUrl = "<c:url value='/data/basic/comCodeList' />";
	
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
			success	: function(data) {
				var sb = new StringBuilder();
				
				if(data && data.length > 0) {
					for(var i=0; i<data.length; i++){
						var flag = true;
						codeGroup = data[i];
						
						if(codeGroup.codeList.length>0){
							for(var j=0;j<codeGroup.codeList.length;j++){
								code = data[i].codeList[j];
								
								if(flag){
									sb.Append('<tr class="top">');
									sb.Append('<td class="groupWidth">' + codeGroup.group_id);
									sb.Append('<input type="hidden" value="' + codeGroup.group_id + '"</td>')
									sb.Append('<td>' + codeGroup.group_nm + '</td>');
									sb.Append('<td>' + codeGroup.group_detail + '</td>');
								}else{
									sb.Append('<tr>');
									sb.Append('<td><input type="hidden" value="' + codeGroup.group_id + '"></td>');
									sb.Append('<td></td>');
									sb.Append('<td></td>');
								}
								flag = false;
								
								if(code.code == null){
									sb.Append('<td></td><td></td><td></td><td></td><td></td>');
								}else{
									sb.Append('<td class="codeWidth">' + code.code + '</td>');
									sb.Append('<td>' + code.code_nm + '</td>');
									sb.Append('<td>' + code.code_nm_ja + '</td>');
									sb.Append('<td class="engWidth">' + code.code_nm_en + '</td>');
									sb.Append('<td>' + code.code_detail + '</td>');
									sb.Append('</tr>');
								}
							}
							
						}else{
							sb.Append('<tr class="top">');
							sb.Append('<td class="groupWidth">' + codeGroup.group_id + '</td>');
							sb.Append('<td>' + codeGroup.group_nm + '</td>');
							sb.Append('<td>' + codeGroup.group_detail + '</td>');
							sb.Append('<td></td>');
							sb.Append('<td></td>');
							sb.Append('<td></td>');
							sb.Append('<td></td>');
							sb.Append('<td></td>');
							sb.Append('</tr>');
						}
					}
				}else{
					sb.Append("<tr>");
					sb.Append("	<td colspan='8'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				$('#dataListBody').html(sb.ToString());
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
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	// 전체검색 버튼 클릭 시
	$("#searchAllBtn").unbind("click").bind("click", function() {
		contentLoad('공통코드관리','/admin/basic/comCode');
	});
	
	// 처음 리스트 생성
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
	
	// 공통코드 추가
	$('.addGroupCodeBtn').on('click', function(){
		if($('select[name="group_id"]').val() == ''){
			alert('그룹코드 항목을 입력해주세요.');
			return;
		}
		
		var flag = true;
		$('.code_table').find('input[type=text]').each(function(index, item){
			if($(item).val().trim() == ''){
				alert('그룹코드 항목을 입력해주세요.');
				flag = false;
				return false;
			}
		});
		if(!flag) return;
		
		$.ajax({
			type	: "post",
			url		: "<c:url value='/data/basic/insertGroupCode' />",
			data 	: $("form[name='groupCodeForm']").serialize(),
			success	: function(result) {
				if(result){
					alert("그룹코드를 추가하였습니다.");
					$('select[name="group_id"] option:eq(0)').prop("selected", true);
					$('input[type="text"]').val('');
					setContentList(1);
				}
				else alert("추가 실패");
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	});
	
	// 공통코드 수정 팝업
	$(document).off('click').on("click", '#dataListBody tr', function(){
		var search = $("form[name='searchForm']").serializeObject();
		var data = { group_id : $(this).find('input').val() };
		var obj = new Object();
			obj.search = JSON.stringify(search);
			obj.data = JSON.stringify(data);
		openLayerPopup("공통코드 수정", "/admin/common/popup/comCodeEdit", obj);
	});
	
});
</script>
 
<div class="content_wraper">
	<h3><c:out value="${codeGroup.name}" default="" /></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
       		<div>
	        	<table class="searchTable">
		        	<tr>
		        		<th>코드 그룹</th>
		        		<td>
		        			<select name="code_group">
								<option value=''>전체</option>
								<option value='A' <c:if test="${search.code_group eq 'A'}">selected</c:if>>A그룹</option>
								<option value='B' <c:if test="${search.code_group eq 'B'}">selected</c:if>>B그룹</option>
								<option value='C' <c:if test="${search.code_group eq 'C'}">selected</c:if>>C그룹</option>
								<option value='D' <c:if test="${search.code_group eq 'D'}">selected</c:if>>D그룹</option>
								<option value='E' <c:if test="${search.code_group eq 'E'}">selected</c:if>>E그룹</option>
								<option value='F' <c:if test="${search.code_group eq 'F'}">selected</c:if>>F그룹</option>
							</select>
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>키워드검색</th>
		        		<td>	
		        			<select name="searchCondition">
								<option value='all'>전체</option>
								<option value='group_nm' <c:if test="${search.searchCondition eq 'group_nm'}">selected</c:if>>그룹명</option>
								<option value='code_nm' <c:if test="${search.searchCondition eq 'code_nm'}">selected</c:if>>코드명</option>
								<option value='com_code' <c:if test="${search.searchCondition eq 'com_code'}">selected</c:if>>공통코드</option>
							</select>
							
							<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class="buttonTd" colspan="2">
		        			<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
		        			<a id='searchAllBtn' class="btn btn-danger" type="button">전체검색</a>
		        		</td>
		        	</tr>
		        </table>
		    </div>
		</form>
		<!-- //searchForm end -->
		<br>

		<form name="groupCodeForm">
			<table class="table-hover codeTable">
				<thead>
					<tr>
						<td>
							<select name="group_id">
								<option value="">그룹 선택</option>
								<option value="A">A그룹</option>
								<option value="B">B그룹</option>
								<option value="C">C그룹</option>
								<option value="D">D그룹</option>
								<option value="E">E그룹</option>
								<option value="F">F그룹</option>
							</select>
						</td>
						<td><input type="text" name="group_nm" placeholder="그룹명"></td>
						<td><input type="text" name="group_detail" placeholder="그룹설명" size=30></td>
						<td colspan="5"><button type="button" class="btn primary addGroupCodeBtn">그룹코드 추가</button></td>
					</tr>
					<tr>
						<th>그룹코드</th>
						<th>그룹명</th>
						<th>설 명</th>
						<th>코드</th>
						<th>코드명</th>
						<th>일본어</th>
						<th>영어</th>
						<th>설 명</th>
					</tr>
				</thead>
				<tbody id="dataListBody"></tbody>
			</table>
		</form>
	</div>
</div>
