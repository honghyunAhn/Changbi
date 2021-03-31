<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var adminListUrl = "<c:url value='/data/adminManagement/adminList' />";
	var regUrl = "<c:url value='/data/adminManagement/adminReg' />";
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		var params = $('form[name=searchForm]').serializeObject();
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: adminListUrl,
			data 	: params,
			success	: function(result) {
				console.log(result);
				var content = '';
				
				$.each(result.list, function(index, item) {
					content += '<tr>';
					content += 		'<td>' + (index + 1);
					content += 			'<input type="hidden" name="id" value="' + item.id + '">';
					content += 			'<input type="hidden" name="pw" value="' + item.pw + '">';
					content += 		'</td>';
					content += 		'<td>' + item.id + '</td>';
					content += 		'<td>';
					content +=			'<input type="text" name="name" value="'+item.name+'">';
					content +=		'</td>';
					content += 		'<td>';
					content += 			'<select name="grade">';
					switch(item.grade) {
					case 9:
						content += 		'<option value="9" selected>최고관리자</option>';
						content += 		'<option value="1">일반관리자</option>';
						break;
					case 1:
						content += 		'<option value="9">최고관리자</option>';
						content += 		'<option value="1" selected>일반관리자</option>';
						break;
					}
					content +=			'</select>';
					content += 		'</td>';
					content += 		'<td>';
					content +=			'<select name="useYn">';
					switch(item.useYn) {
					case 'Y':
						content += 		'<option value="Y" selected>사용</option>';
						content += 		'<option value="N">비사용</option>';
						break;
					case 'N':
						content += 		'<option value="Y">사용</option>';
						content += 		'<option value="N" selected>비사용</option>';
						break;
					}
					content += 			'</select>';
					content += 		'</td>';
					content += 		'<td>';
					content += 			'<input type="date" name="authExpiredSt" value="' + item.authExpiredSt + '">';
					content += 		'</td>';
					content += 		'<td>';
					content += 			'<input type="date" name="authExpiredEt" value="' + item.authExpiredEt + '">';
					content += 		'</td>';
					content += 		'<td>';
					content +=			'<a class="btn btn-primary updBtn" type="button">적용</a>';
					content += 		'</td>';
					content += '</tr>';
				});
				
				$("#dataListBody").html(content);
				
				// 페이징 처리
				pagingNavigation.setData(result);	// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	setContentList();
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	$('#dataListBody').on('click','.updBtn', function(){
		var tr = $(this).closest('tr');
		
		var id = tr.find(':hidden[name=id]').val();
		var pw = tr.find(':hidden[name=pw]').val();
		var name = tr.find('input[name=name]').val();
		var grade = tr.find('select[name=grade] :selected').val();
		var useYn = tr.find('select[name=useYn] :selected').val();
		var authExpiredSt = tr.find('input[name=authExpiredSt]').val();
		var authExpiredEt = tr.find('input[name=authExpiredEt]').val();
		
		$.ajax({
			type	: "post",
			url		: regUrl,
			data 	: {
				'id' : id
				,'pw' : pw
				, 'name' : name
				, 'grade' : grade
				, 'useYn' : useYn
				, 'authExpiredSt' : authExpiredSt
				, 'authExpiredEt' : authExpiredEt
			},
			success	: function(result) {
				alert('수정되었습니다.');
				setContentList(1);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	});
	
	$('#regBtn').on('click', function(){
		
		if(!checkForm()) return;
		
		$.ajax({
			type:"post",
			data: $('form[name=actionForm]').serialize(),
			url: regUrl,
			success : function(result) {
				if(result > 0) {
					alert('등록되었습니다.');
					setContentList(1);
				} else {
					alert('등록에 실패했습니다.');
					return;
				}
			}, error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	});
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
})

function checkForm() {
	
	if($('form[name=actionForm] input[name=id]').val() == '') {
		alert('ID를 입력하세요.');
		return false;
	}
	if($('form[name=actionForm] input[name=pw]').val() == '') {
		alert('비밀번호를 입력하세요.');
		return false;
	}
	if($('form[name=actionForm] input[name=name]').val() == '') {
		alert('이름을 입력하세요.');
		return false;
	}
	if($('form[name=actionForm] input[name=authExpiredSt]').val() == '' 
		|| $('form[name=actionForm] input[name=authExpiredEt]').val() == '') {
		alert('권한 기간을 입력하세요.');
		return false;
	}
	return true;
}
</script>
<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
       		<div>
        		<table class="searchTable">
	        		<tr>
	        			<th>키워드검색</th>
	        			<td>
							<input type="text" placeholder="ID로 검색" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
	        			</td>
	        		</tr>
		       		<tr>
		        		<td class="buttonTd" colspan="2">
		        			<button id='searchBtn' class="btn-primary" type="button">검색</button>
		        		</td>
		        	</tr>
	        	</table>
	        </div>
		</form>
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
				<th>상태</th>
				<th>권한 기간 시작일</th>
				<th>권한 기간 종료일</th>
				<th>적용</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<form name="actionForm">
			<table style="margin-top: 20px;">
				<tbody>
					<tr>
						<td>
							<input type="text" name="id" placeholder="ID입력">
						</td>
						<td>
							<input type="text" name="pw" placeholder="pw입력">
						</td>
						<td>
							<input type="text" name="name" placeholder="이름입력">
						</td>
						<td>
							<select name="grade">
								<option value="9">최고관리자</option>
								<option value="1">일반관리자</option>
							</select>
						</td>
						<td>
							<select name="useYn">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</td>
						<td>
							<input type="date" name="authExpiredSt">
						</td>
						<td>
							<input type="date" name="authExpiredEt">
						</td>
						<td>
							<a id="regBtn" class="btn btn-primary" type="button">등록</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="pagination"></div>
		<div class="paging">
		</div>
	</div>
</div>
