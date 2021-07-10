<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<style>
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.btn_fore_black{background-color: #90a4ae; border: none;}
.btn_b{background-color: #37474f; border: none;}
.btn_b:hover{background-color: #37474f; border: none;}
</style>
<script>
var onlineadviceUrl = '<c:url value="/admin/board/onlineConsulting"/>';
var editUrl = '<c:url value="/admin/board/onlineConsultingEdit"/>';

$(function() {
	
	/* CKEditor */
	CKEDITOR.replace('consulting_ct', {
		filebrowserUploadUrl : '/board/imageUpload',
		enterMode: CKEDITOR.ENTER_BR,
		shiftEnterMode:  CKEDITOR.ENTER_P,
		fullPage: true,
		allowedContent:  true,
		removeButtons: 'Save',
		removePlugins: 'resize',
		height: 250
	});
	CKEDITOR.replace('re_ct', {
		filebrowserUploadUrl : '/board/imageUpload',
		enterMode: CKEDITOR.ENTER_BR,
		shiftEnterMode:  CKEDITOR.ENTER_P,
		fullPage: true,
		allowedContent:  true,
		removeButtons: 'Save',
		removePlugins: 'resize',
		height: 250
	});
});

$(function(){
	// 공개설정 라디오버튼
	$.each($('td.open > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_open);
	});
	
	$.each($('td.check > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_check);
	});

	// 공개여부 설정 로드
	$.each($('td.open > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_open);
	});
	var consulting_open = ${result.CONSULTING_OPEN}
	if (consulting_open == '0') {
		$("#consulting_open_o").trigger("click");
	} else {
		$("#consulting_open_c").trigger("click");
	}
	
	$.each($('td.check > a.radio'), function(index, button) {
		$(button).on('check', radioOnChange_check);
	});
	var consulting_check = ${result.CONSULTING_CHECK}
	if (consulting_check == '0') {
		$("#consulting_check_a").trigger("click");
	}
	if (consulting_check == '1') {
		$("#consulting_check_b").trigger("click");
	}
	if (consulting_check == '2') {
		$("#consulting_check_c").trigger("click");
	}
});

function radioOnChange_open(evt) {
	$.each($('td.open > a.btn'), function(index, button) {
		var obj_button = $(button);
		var input_consulting_open = $('#consulting_open');
		if (evt.currentTarget == button) {
			obj_button.addClass('btn_b');
			obj_button.removeClass('btn_gray btn_fore_black');
			input_consulting_open.val(obj_button.attr('value'));
		} else {
			obj_button.addClass('btn_gray btn_fore_black');
			obj_button.removeClass('btn_b');
		}
	});
}

function radioOnChange_check(evt) {
	$.each($('td.check > a.btn'), function(index, button) {
		var obj_button = $(button);
		var input_consulting_open = $('#consulting_check');
		if (evt.currentTarget == button) {
			obj_button.addClass('btn_b');
			obj_button.removeClass('btn_gray btn_fore_black');
			input_consulting_open.val(obj_button.attr('value'));
		} else {
			obj_button.addClass('btn_gray btn_fore_black');
			obj_button.removeClass('btn_b');
		}
	});
}

//상담내용 수정
function onlineUpdate(){
	var onlineUpdateForm = $("#onlineUpdateForm").serializeObject();
	var consulting_ct = CKEDITOR.instances.consulting_ct.getData();
	onlineUpdateForm.consulting_ct = consulting_ct;
	if (onlineUpdateForm.consulting_title.length == 0) {
		alert("제목을 입력해 주세요.");
		return false;
	}
	
	var check = confirm("온라인상담 내용을 수정 하시겠습니까?");
	if (!check) {
		return false;
	}
	
	$.ajax({
        url : "/data/board/onlineUpdateForm",
        type : 'POST',
        data : onlineUpdateForm,
        success : function(result){
        	if(result > 0){
        		CKEDITOR.instances.consulting_ct.destroy();
        		var params = $('form[name=searchForm]').serializeObject();
         		contentLoad('온라인 상담 관리', onlineadviceUrl, params);
        	} else{
        		alert("등록실패했습니다.");
        	}
        },
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
	return true;
};

//상담내용 답변 입력
function onlineConsultingInsert(){
	var onlineConsultingInsertForm = $("#onlineConsultingInsertForm").serializeObject();
	var re_ct = CKEDITOR.instances.re_ct.getData();
	onlineConsultingInsertForm.re_ct = re_ct;
	
	var check = confirm("답변을 등록 하시겠습니까?");
	if (!check) {
		return false;
	}
	
	$.ajax({
        url : "/data/board/onlineConsultingInsertForm",
        type : 'POST',
        data : onlineConsultingInsertForm,
        success : function(result){
        	if(result > 0){
        		CKEDITOR.instances.re_ct.destroy();
        		var params = $('form[name=searchForm]').serializeObject();
         		contentLoad('온라인 상담 관리', onlineadviceUrl, params);
        	} else{
        		alert("등록실패했습니다.");
        	}
        },
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
	return true;
};

//상담내용 답변 수정
function onlineConsultingUpdate(){
	var onlineConsultingUpdateForm = $("#onlineConsultingUpdateForm").serializeObject();
	console.log(onlineConsultingUpdateForm);
	var re_ct = CKEDITOR.instances.re_ct.getData();
	onlineConsultingUpdateForm.re_ct = re_ct;
	console.log(onlineConsultingUpdateForm);
	var check = confirm("답변을 수정 하시겠습니까?");
	if (!check) {
		return false;
	}
	
	$.ajax({
        url : "/data/board/onlineConsultingUpdateForm",
        type : 'POST',
        data : onlineConsultingUpdateForm,
        success : function(result){
        	if(result > 0){
        		CKEDITOR.instances.re_ct.destroy();
        		var params = $('form[name=searchForm]').serializeObject();
         		contentLoad('온라인 상담 관리', onlineadviceUrl, params);
        	} else{
        		alert("등록실패했습니다.");
        	}
        },
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
	return true;
};

//컨텐츠 타이틀
$('.content_wraper').children('h3').eq(0).html($('title').text());

/* 온라인 상담 관리 페이지 이동 */
$('.onlineConsulting').on('click', function() {
	var params = $('form[name=searchForm]').serializeObject();
	// ajax로 load
	contentLoad('온라인 상담 관리', onlineadviceUrl, params);
});

/* 온라인 상담 관리 페이지 이동 */
$('.onlineConsultingEdit').on('click', function() {
	var params = $('form[name=searchForm]').serializeObject();
	params.consulting_seq = $("#consulting_seq").val();
	// ajax로 load
	contentLoad('온라인 상담 상세', editUrl, params);
});
</script>

<div class="content_wraper">
	<h3></h3>
	
	<div style="justify-content: center;">
		<span class="detailTd onlineConsulting">온라인 상담 관리</span>
		<strong>></strong>
		<span class="detailTd onlineConsultingEdit">온라인 상담상세</span>
	</div>
	
	<div class="custom_div" style="margin-top:20px; margin:auto">
	<form id="onlineUpdateForm">
    <table style="width:100%; margin-right:auto; text-align:center;">
        <thead>
            <tr>
                <th scope="col" style="text-align:center;" colspan="2">상담 신청 내용</th>
            </tr>
        </thead>
        <tbody class="custom_tbody">
            <tr>
                <td class="name first">번호</td>
                <td class="first"><input type="text" name="consulting_seq" value="${result.CONSULTING_SEQ}" readonly="readonly" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td class="name">작성자</td>
                <td><input type="text" name="consulting_ins_id" value="${result.CONSULTING_INS_ID}" readonly="readonly" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td class="name">공개여부</td>
                <td class="open">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_o" value="0" style="width:42%; margin: 1px;">공개</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_c" value="1" style="width:42%; margin: 1px;">비공개</a>
				<input type="hidden" id="consulting_open" name="consulting_open" value="${consulting_open}">
                </td>
            </tr>
            <tr>
                <td class="name">처리현황</td>
				<td class="check">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_a" value="0" style="width:26.6%; margin: 1px;">삭제처리</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_b" value="1" style="width:26.6%; margin: 1px;">답변대기</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_c" value="2" style="width:26.65%; margin: 1px;">답변완료</a>
				<input type="hidden" id="consulting_check" name="consulting_check" value="${consulting_check}">
            </tr>
            <tr>
                <td class="name">신청제목</td>
                <td><input type="text" id="consulting_title" name="consulting_title" value="${result.CONSULTING_TITLE}" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td colspan="2" class="name" style="background-color: #f5f5f5;">신청내용</td>
            </tr>
            <tr>
                <td colspan="2"><textarea id="consulting_ct" name="consulting_ct">${result.CONSULTING_CT}</textarea></td>
            </tr>
        </tbody>
    </table>
    <input type="button" value="상담내용 수정하기" onclick="onlineUpdate(); return false;" 
    style="color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>
    <input type="button" class="onlineConsulting" value="목록보기" 
    style="color:white;font-weight:bold;font-size:120%;background-color:#ff5252;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>
    </form>
    <br><br>
	<c:if test="${result.RE_INS_ID == null}">
	    <form id="onlineConsultingInsertForm" style="width: 100%; text-align:center;">
	    <table style="width:100%; margin-right:auto; text-align:center;">
	        <thead>
	            <tr>
	                <th scope="col" style="text-align:center; width: 100%">온라인상담 답변작성란</th>
	            </tr>
	        </thead>
	        <tbody>
		        <tr>
		        	<td>아직 답변이 등록되지 않은 상담글 입니다.</td>
		        </tr>
	        </tbody>
	        <tbody class="custom_tbody">
	            <tr>
	                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)">${result.RE_CT}</textarea></td>
	            </tr>
	        </tbody>
	    </table>
		<input type="button" value="등록하기" onclick="onlineConsultingInsert(); return false;"
		style="color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>
		<input type="button" class="onlineConsulting" value="목록보기"
		style="color:white;font-weight:bold;font-size:120%;background-color:#ff5252;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>	
	    <input type="hidden" name="consulting_seq" value="${result.CONSULTING_SEQ}">
	    </form>
	</c:if>
	<c:if test="${result.RE_INS_ID != null}">
	    <form id="onlineConsultingUpdateForm" style="width: 100%; text-align:center;" >
	    <table style="width:100%; margin-right:auto; text-align:center;">
	        <thead>
	            <tr>
	                <th scope="col" style="text-align:center; width: 100%;">온라인상담 답변작성란</th>
	            </tr>
	        </thead>
	        <tbody>
		        <tr>
		        	<td>답변자: ${result.RE_INS_ID} / 최초 작성일시: [${result.RE_INS_DT}]</td>
		        </tr>
		        <tr>
		        	<td>답변 수정자: ${result.RE_UDT_ID} / 최종 수정일시: [${result.RE_UDT_DT}]</td>
		        </tr>
	        </tbody>
	        <tbody class="custom_tbody">
	            <tr>
	                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)">${result.RE_CT}</textarea></td>
	            </tr>
	        </tbody>
	    </table>
		<input type="button" value="수정하기" onclick="onlineConsultingUpdate(); return false;"
		style="color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>
		<input type="button" class="onlineConsulting" value="목록보기" 
		style="color:white;font-weight:bold;font-size:120%;background-color:#ff5252;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;"/>
	    <input type="hidden" name="consulting_seq" value="${result.CONSULTING_SEQ}">
	    </form>
	</c:if>
	<input type="hidden" id="consulting_seq" name="consulting_seq" value="${result.CONSULTING_SEQ}">
	<form name="searchForm">
		<input type="hidden" name="pageNo" value="${search.pageNo}">
	    <input type="hidden" name="pageCount" value="${search.pagingYn}">
	    <input type="hidden" name="searchCondition" value="${search.searchCondition}">
	    <input type="hidden" name="searchKeyword" value="${search.searchKeyword}">
	</form>
</div>
</div>