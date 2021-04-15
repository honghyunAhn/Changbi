<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">
	// 여기에서 URL 변경 시켜서 사용
	var adminListUrl = "<c:url value='/data/adminManagement/adminList' />";
	var regUrl = "<c:url value='/data/adminManagement/adminReg' />";
	var pwUpdUrl = "<c:url value='/data/adminManagement/pwUpd' />";
	var isPwSameUrl = "<c:url value='/data/adminManagement/isPwSame' />";

$(document).ready(function () {
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
				alert('등록되었습니다.');
				setContentList(1);
			}, error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	});
	//비밀번호 변경
	$('#pwUpd').on('click', function() {
		var form = $('form[name=pwUpdForm]');
		var pwd = form.find('input[name=pw]').val();
		
		if(!checkPw(pwd)) return;
		if(isPwSameFunc(form)) {
			alert('동일한 비밀번호를 사용할 수 없습니다.');
			return false;
		}
		
		pwUpdAjax(form);
	});
	
	$('#pwUpdPrimary').on('click', function(){
		var form = $('form[name=pwUpdForm]');
		form.find('input[name=pw]').val('$2a$10$r118jrzeO2Edd1dop4PyaurojAEKcDF7W5rCZWIFmTp/lLoFYerdO');
		form.find('input[name=pwBefore]').val('$2a$10$r118jrzeO2Edd1dop4PyaurojAEKcDF7W5rCZWIFmTp/lLoFYerdO');
		pwUpdAjax(form);
	});
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});
//최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
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
			
			var content = '';
			
			$.each(result.list, function(index, item) {
				content += '<tr>';
				content += 		'<td>';
				content += 			(index + 1);
				content += 			'<input type="hidden" name="id" value="' + item.id + '">';
				content += 			'<input type="hidden" name="pw" value="' + item.pw + '">';
				content += 		'</td>';
				content += 		'<td>' + item.id + '</td>';
				content +=		'<td>';
				content +=			'<a class="btn btn-primary" type="button" onclick="pwUpd(\'' + item.id + '\',\''+ item.pw +'\')">변경</a>';
				content +=		'</td>';
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
// checkbox 체크한 행의 색깔 바꾸기
function changeTrColor(obj){
	if($(obj).prop("checked"))
		$(obj).closest('tr').css("background-Color","#E0E0E0");
	else
		$(obj).closest('tr').css("background-Color","");
}
//폼 유효성 검사
function checkForm() {
	
	if($('form[name=actionForm] input[name=id]').val() == '') {
		alert('ID를 입력하세요.');
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
	
	var pwd = $('form[name=actionForm] input[name=pw]').val();
	
	return checkPw(pwd);
}
//비밀번호 유효성검사
function checkPw(pwd) {
    
	var alpaBig= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var alpaSmall= "abcdefghijklmnopqrstuvwxyz";
    var checkCount = 0;
    
	if(pwd == '') {
		alert('비밀번호를 입력하세요.');
		return false;
	}

	if(/(\w)\1\1\1/.test(pwd)){
		alert('비밀번호안에 같은문자는 4번 이상 사용할 수 없습니다.');
		return false;
	}
	
	if(/(0123)|(1234)|(2345)|(3456)|(4567)|(5678)|(6789)|(7890)/.test(pwd)){
	    alert('비밀번호는 4회이상의 연속된 숫자를 사용할 수 없습니다.');
	    return false;
	}

	if(/(0987)|(9876)|(8765)|(7654)|(6543)|(5432)|(4321)|(3210)/.test(pwd)){
	    alert('비밀번호는 4회이상의 연속된 숫자를 사용할 수 없습니다.');
	    return false;
	}
	
	for(var i=0;i < alpaBig.length - pwd.length+1;i++){
        if(alpaBig.substring(i,i+pwd.length) == pwd)
        {
        	alert("ABCDEF처럼 연속된 문자는 사용할 수 없습니다.");
            return false;
        }
    }
    if (pwd.indexOf(' ') > -1) {
        alert("공백은 입력할 수 없습니다.");
        return false;
    }
    
    for(i=0;i < alpaSmall.length - pwd.length+1;i++){
        if(alpaSmall.substring(i,i+pwd.length) == pwd)
        {
            alert("abcdef처럼 연속된 문자는 사용할 수 없습니다.");
            return false;
        }
    }

	if(/[0-9]/.test(pwd)){ //숫자
	    checkCount++;
	}
	var pwChkCnt2 = 0;
	if(/[A-Z]/.test(pwd)){ //대문자
	    checkCount++;
	}
	var pwChkCnt3 = 0;
	if(/[~!@\#$%<>^&*\()\-=+_\’]/.test(pwd)){ //특수문자
	    checkCount++;
	}
	if(/[a-z]/.test(pwd)){ //소문자
	    checkCount++;
	}

	if(checkCount <= 2){
	    alert('비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3개이상의 조합으로 이루어진 8자리 이상이어야합니다.');
	    return false;
	}
	return true;
}
//비밀번호 변경
function pwUpd(id, pw) {
	var form = $('form[name=pwUpdForm]');
	form.removeAttr('hidden');
	
	var pwInput = '<input type="hidden" name="id" value="' + id + '">';
	var pwBeforeInput = '<input type="hidden" name="pwBefore" value="' + pw + '">';
	form.find('td:eq(1)').html('' + id + pwInput + pwBeforeInput);
}
//비밀번호 중복검사 decode가 안되기 때문에 서버에서 판단해야됨.. 서버에서 중복이면 true, 아니면 false를 반환함
function isPwSameFunc(form) {
	var result;
	
	$.ajax({
		type:"post",
		data: form.serialize(),
		url: isPwSameUrl,
		async: false,
		success : function(data) {
			result = data;
		}, error : function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
	
	return result;
}
//중복돼서 func으로 뺌
function pwUpdAjax(form) {
	$.ajax({
		type:"post",
		data: form.serialize(),
		url: pwUpdUrl,
		success : function(result) {
			alert('변경되었습니다.');
			form.attr('hidden', 'hidden');
			form.find('input[name=pw]').val('');
			setContentList(1);
		}, error : function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}
</script>
<div class="content_wraper">
	<h3></h3>
	<div class="tab_body">
		<!-- searchForm start -->
<!--        	<form name="searchForm" method="post"> -->
<!--        		<div> -->
<!--         		<table class="searchTable"> -->
<!-- 	        		<tr> -->
<!-- 	        			<th>키워드검색</th> -->
<!-- 	        			<td> -->
<%-- 							<input type="text" placeholder="ID로 검색" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />"> --%>
<!-- 	        			</td> -->
<!-- 	        		</tr> -->
<!-- 		       		<tr> -->
<!-- 		        		<td class="buttonTd" colspan="2"> -->
<!-- 		        			<button id='searchBtn' class="btn-primary" type="button">검색</button> -->
<!-- 		        		</td> -->
<!-- 		        	</tr> -->
<!-- 	        	</table> -->
<!-- 	        </div> -->
<!-- 		</form> -->
		<!-- //searchForm end -->
		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>번호</th>
                <th>아이디</th>
                <th>비밀번호</th>
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
		<form name="pwUpdForm" hidden="hidden">
			<table style="margin-top: 20px;">
				<tbody>
					<tr>
						<td style="width: 20%;">
							선택한 ID :
						</td>
						<td style="width: 30%;">
						</td>
						<td style="width: 40%;">
							<input type="text" name="pw" placeholder="변경할 PW 입력">
						</td>
<!-- 						<td style="width: 10%;"> -->
<!-- 							<a id="pwUpdPrimary" class="btn btn-primary" type="button">기본비밀번호로 초기화</a> -->
<!-- 						</td> -->
						<td style="width: 10%;">
							<a id="pwUpd" class="btn btn-danger" type="button">변경</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
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
