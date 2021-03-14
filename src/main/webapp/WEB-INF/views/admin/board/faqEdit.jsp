<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>
<script type="text/javascript">
	
	var dataListUrl = '<c:url value="/data/board/faqList" />';
	var listPageUrl = '<c:url value="/admin/board/faqList" />';
	var deleteUrl = '<c:url value="/data/board/deleteFaq" />';
	var insertUrl = '<c:url value="/data/board/insertFaq" />';
	var detail;
	var consulting_seq = parseInt('${search.consulting_seq}');
	
	$(document).ready(function(){
		setContent();
		setEvent();
	});
	
	function setContent() {
		getDetail();
		setForm();
	}
	//상세정보 가져오기
	function getDetail() {
		var params = {"consulting_seq" : consulting_seq};
		$.ajax({
			type	: "post",
			url		: dataListUrl,
			data 	: params,
			async: false,
			success	: function(result) {
				detail=result[0];
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	//form 정보 세팅
	function setForm() {
		if(detail != null && detail !== undefined) {
			$('#delDiv').removeAttr('hidden');
			$('#consulting_type').val(detail.CONSULTING_TYPE).prop('selected', true);
			$('#consulting_tp').val(detail.CONSULTING_TP).prop('selected', true);
			$('input[name=consulting_title]').val(detail.CONSULTING_TITLE);
			$('#consulting_ct').html(detail.CONSULTING_CT);
			$('input[name=consulting_seq]').val(detail.CONSULTING_SEQ);
		}
	}
	//버튼 이벤트 연결
	function setEvent() {
		$('#listBtn').on('click', function(){
			var pageTitle = $('.content_wraper > h3').html();
			contentLoad(pageTitle, listPageUrl, $('form[name=searchForm]').serialize());
		});
		$('#delBtn').on('click', function(){
			var params = {"consulting_seq" : consulting_seq};
			$.ajax({
				type	: "post",
				url		: deleteUrl,
				data 	: params,
				async: false,
				success	: function(result) {
					if(result) {
						alert('삭제에 성공했습니다.');
						$('#listBtn').trigger('click');
					} else {
						alert('삭제에 실패했습니다.');
						return;
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
		$('#regBtn').on('click', function(){
			var params = $('form[name=actionForm]').serializeObject();
			$.ajax({
				type	: "post",
				url		: insertUrl,
				data 	: params,
				async: false,
				success	: function(result) {
					if(result) {
						alert('등록/수정에 성공했습니다.');
						$('#listBtn').trigger('click');
					} else {
						alert('등록/수정에 실패했습니다.');
						return;
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
	}
</script>

<div class="content_wraper">
	<h3>FAQ 상세</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='${search.searchCondition}'/>
			<input type='hidden' name='searchKeyword' value='${search.searchKeyword}' />
		</form>
		<!-- //searchForm end -->
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='consulting_seq' value='${search.consulting_seq}' />
			<dl>
				<dt>분류</dt>
				<dd class="half">
					<select id="consulting_type" name="consulting_type">
						<option value='001'>과정문의</option>
						<option value='002'>학습문의</option>
						<option value='003'>시스템문의</option>
						<option value='004'>결제문의</option>
					</select>
				</dd>
				<dt>위치</dt>
				<dd class="half">
					<select id="consulting_tp" name="consulting_tp">
						<option value='A0505'>두잇캠퍼스</option>
						<option value='A0506'>레인보우</option>
					</select>
				</dd>
				<dt>제목</dt>
				<dd>
					<input type="text" name="consulting_title" class="form-control" value="" />
				</dd>
				<dt>내용</dt>
				<dd>
					<textarea class="editor" id="consulting_ct" name="consulting_ct" rows="10" cols="100" style="width:100%; height:400px; resize: none;"></textarea>
				</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		<div>
			<div style="float: left; padding-right: 3px;"><a id="listBtn" class="btn align_right">리스트</a></div>
			<div id="delDiv" hidden="hidden" style="float: left; padding-right: 3px;">
				<a id="delBtn" class="btn align_right danger">삭제</a>
			</div>
			<div><a id="regBtn" class="btn align_right primary">저장</a></div>
		</div>
	</div>
</div>