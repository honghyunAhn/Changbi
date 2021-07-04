<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
.crc_select{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
.crc_selected{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
#tolist{color:white;background-color:#333;}
table.gisu_crc_table{text-align:left;}
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
		removeButtons: 'Save'
	});
});

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
		<span class="detailTd onlineConsultingEdit">온라인 상담 관리</span>
	</div>
	
	<div class="custom_div" style="margin-top:20px; margin:auto">
	<form action="/edu/admin/online_manager_contents_update" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
    <table class="gisu_crc_table" style="border: none; width:1000px; margin-right:auto; text-align:center;">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col" style="text-align:center; border-right: none;" colspan="2">상담 신청 내용</th>
            </tr>
        </thead>
        <tbody class="custom_tbody">
            <tr>
                <td class="name first">번호</td>
                <td class="first" style="border-right: none;"><input type="text" name="consulting_seq" value="${result.CONSULTING_SEQ}" readonly="readonly" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td class="name">작성자</td>
                <td style="border-right: none;"><input type="text" name="consulting_ins_id" value="${result.CONSULTING_INS_ID}" readonly="readonly" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td class="name">공개여부</td>
                <td class="open" style="border-right: none;">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_o" value="0" style="width:42%; margin: 1px;">공개</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_c" value="1" style="width:42%; margin: 1px;">비공개</a>
				<input type="hidden" id="consulting_open" name="consulting_open" value="${result.CONSULTING_OPEN}">
                </td>
            </tr>
            <tr>
                <td class="name">처리현황</td>
				<td class="check" style="border-right: none;">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_a" value="0" style="width:26.6%; margin: 1px;">삭제처리</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_b" value="1" style="width:26.6%; margin: 1px;">답변대기</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_c" value="2" style="width:26.65%; margin: 1px;">답변완료</a>
				<input type="hidden" id="consulting_check" name="consulting_check" value="${result.CONSULTING_CHECK}">
            </tr>
            <tr>
                <td class="name">신청제목</td>
                <td style="border-right: none;"><input type="text" id="consulting_title" name="consulting_title" value="${result.CONSULTING_TITLE}" style="border: none; width: 100%; text-align:center;"/></td>
            </tr>
            <tr>
                <td colspan="2" class="name" style="background-color: #f5f5f5; border-right: none;">신청내용</td>
            </tr>
            <tr>
                <td colspan="2"><textarea id="consulting_ct" name="consulting_ct" style="width:100%; height: 600px; resize: none;">${result.CONSULTING_CT}</textarea></td>
            </tr>
        </tbody>
    </table>
    <input type="submit" class="crc_submit" id="onlineUpdateBtn" value="상담내용 수정하기" />
    <input type="button" class="onlineConsulting" value="목록보기" />
	<input type="hidden" name="consulting_udt_id" value="${loginedId}">
    <input type="hidden" name="curPage" value="${curPage}">
    <input type="hidden" name="pageCount" value="${pageCount}">
    <input type="hidden" name="orderValue" value="${orderValue}">
    <input type="hidden" name="orderType" value="${orderType}">
    <input type="hidden" name="searchId" value="${searchId}">
    </form>
    <br><br><br><br><br>
	<c:if test="${result.RE_INS_ID == null}">
	    <form action="/edu/admin/online_manager_reply_insert" method="post" enctype="multipart/form-data" onsubmit="return formCheck_re();">
	    <table class="gisu_crc_table">
	        <colgroup>
	            <col width="20%"/>
	            <col width="80%"/>
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col" style="text-align:center;">온라인상담 답변작성란</th>
	            </tr>
	        </thead>
	        <tbody>
		        <tr>
		        	<td>아직 답변이 등록되지 않은 상담글 입니다.</td>
		        </tr>
	        </tbody>
	        <tbody class="custom_tbody">
	            <tr>
	                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)" style="height: 400px; width: 100%; resize: vertical; margin: 0; padding: 0;">${result.re_ct }</textarea></td>
	            </tr>
	        </tbody>
	    </table>
		<input type="submit" class="crc_submit" id="onlineReInsertBtn" value="등록하기" />
		<input type="button" class="onlineConsulting" value="목록보기" />	
	    <input type="hidden" name="curPage" value="${curPage}">
	    <input type="hidden" name="pageCount" value="${pageCount}">
	    <input type="hidden" name="orderValue" value="${orderValue}">
	    <input type="hidden" name="orderType" value="${orderType}">
	    <input type="hidden" name="searchId" value="${searchId}">
	    <input type="hidden" name="consulting_seq" value="${result.consulting_seq }">
	    <input type="hidden" name="re_ins_id" value="${loginedId}">
	    <input type="hidden" name="re_udt_id" value="${loginedId}">
	    </form>
	</c:if>
	<c:if test="${result.RE_INS_ID != null}">
	    <form action="/edu/admin/online_manager_reply_update" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
	    <table class="gisu_crc_table">
	        <colgroup>
	            <col width="20%"/>
	            <col width="80%"/>
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col" style="text-align:center;">온라인상담 답변작성란</th>
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
	                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)" style="height: 400px; width: 100%; resize: vertical; margin: 0; padding: 0;">${result.re_ct}</textarea></td>
	            </tr>
	        </tbody>
	    </table>
		<input type="submit" class="crc_submit" id="onlineReUpdateBtn" value="수정하기" />
		<input type="button" class="onlineConsulting" value="목록보기" />
			
	    <input type="hidden" name="curPage" value="${curPage}">
	    <input type="hidden" name="pageCount" value="${pageCount}">
	    <input type="hidden" name="orderValue" value="${orderValue}">
	    <input type="hidden" name="orderType" value="${orderType}">
	    <input type="hidden" name="searchId" value="${searchId}">
	    <input type="hidden" name="consulting_seq" value="${result.consulting_seq }">
	    <input type="hidden" name="re_ins_id" value="${loginedId}">
	    <input type="hidden" name="re_udt_id" value="${loginedId}">
	    
	    </form>
	</c:if>
</div>
</div>