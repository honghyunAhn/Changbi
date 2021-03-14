<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
	//변수
	var insertUrl = '<c:url value="/data/toefl/insertToefl" />';
	var dataListUrl = '<c:url value="/data/toefl/toeflList" />';
	var listPageUrl = '<c:url value="/admin/toefl/toeflList" />';
	var deleteUrl = '<c:url value="/data/toefl/deleteToefl" />';
	
	var detail;
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];
	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'image'};
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	$(document).ready(function(){
		setEvent();
		
		if($(':hidden[name=id]').val() != 0) $('.delBtnDiv').removeAttr('hidden');
	});
	
	function setEvent() {
		//리스트로
		$('#listBtn').on('click', function() {
			contentLoad("서비스목록", listPageUrl, $("form[name='searchForm']").serialize());
		});
		//삭제
		$('#delBtn').on('click', function() {
			if(confirm('삭제하시겠습니까?')) {
				var id = $(':hidden[name=id]').val();
				var params = {"id" : id};
				//list에서의 선택삭제 메소드 재활용
				
				var list = new Array();
				list.push(params);
				$.ajax({
					type	: "post",
					url		: deleteUrl,
					data 	: JSON.stringify(list),
					dataType	: "json",
					contentType	: "application/json; charset=utf-8",
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
			}
		});
		//저장
		$('#insBtn').on('click', function() {
			
			if(!checkForm()) return false;
			
			var title = $('input[name=title]');
			switch($('input[name=type]:checked').val()) {
			case '1':
				title.val(title.val().slice(0,14) + ' Complete ' + title.val().slice(15))
				break;
			case '2':
				title.val(title.val().slice(0,14) + ' Half ' + title.val().slice(15) + ' (R/L)');
				break;
			case '3':
				title.val(title.val().slice(0,14) + ' Half ' + title.val().slice(15) + ' (S/W)');
				break;
			}
			
			var params = $("form[name='actionForm']").serialize();
			
			$.ajax({
				type	: "post",
				url		: insertUrl,
				data 	: params,
				success	: function(result) {
					if(result.id > 0) {
						alert("저장되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
					} else {
						alert("실패했습니다.");
					}
				},
				
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
	}
	//유효성 검사
	function checkForm() {
		var flag = true;
		if($('input[name=type]:checked').length < 1) {
			alert('시험유형을 체크해주세요.');
			flag = false;
		} else if($('input[name=volum]').val() == 0) {
			alert('0이 아닌 볼륨을 입력해주세요.');
			flag = false;
			$('input[name=volum]').focus();
		} else if($('input[name=price]').val() == 0) {
			alert('0이 아닌 가격을 입력해주세요.');
			flag = false;
			$('input[name=price]').focus();
		}
		return flag;
	}
</script>
	
<div class="content_wraper">
	<h3>서비스관리(상세)</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<input type="hidden" name="searchCondition" value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type="hidden" name="searchKeyword" value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<input type="hidden" name="id" value="<c:out value="${toeflDetail.id}" default="0" />">
			<!-- view start -->
			<dl>
				<dt>시험구분</dt>
				<dd>
					<input type="radio" name="type" value="1" <c:if test="${toeflDetail.type eq '1'}">checked="checked" </c:if>><span>Complete</span>
					<input type="radio" name="type" value="2" <c:if test="${toeflDetail.type eq '2'}">checked="checked" </c:if>><span>Half(R/L)</span>
					<input type="radio" name="type" value="3" <c:if test="${toeflDetail.type eq '3'}">checked="checked" </c:if>><span>Half(S/W)</span>
				</dd>
				<dt>제목</dt>
				<dd>
					<input type="text" name="title" value="ETS 공식 토플 모의고사 Practice Test Volume" readonly="readonly" style="width: 400px;">
				</dd>
				<dt>볼륨선택</dt>
				<dd class="half">
					<input type="number" name="volum" min="0" placeholder="볼륨입력" value="<c:out value="${toeflDetail.volum}" default="0" />">
				</dd>
				<dt>가격</dt>
				<dd class="half">
					<input type="number" name="price" min="0" placeholder="가격입력" value="<c:out value="${toeflDetail.price}" default="0" />">
				</dd>
				<dt>대표이미지</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='imgFile.fileId' value='<c:out value="${toeflDetail.imgFile.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/course/mainImg' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE, 해상도 : 280*200px 혹은 비율 가로/세로 3:2 가 가장 적합합니다. )</span>
						</div>
							<c:forEach items="${toeflDetail.imgFile.detailList}" var="file" varStatus="status">
							<div class='file_info_area' style='float: left;'>
								<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>
									<img style='width: 200px; height: 200px; cursor: pointer;' src='<c:out value="${file.urlPath}" />' />
								</div>
								<div class='file_info' style='padding-left: 5px;'>
									<input type='hidden' class='attach_file_name'			value='<c:out value="${file.fileName}" />' />
									<input type='hidden' class='attach_file_path'			value='<c:out value="${file.filePath}" />' />
									<input type='hidden' class='attach_file_size'			value='<c:out value="${file.fileSize}" default="0" />' />
									<input type='hidden' class='attach_origin_file_name'	value='<c:out value="${file.originFileName}" />' />
									<input type='hidden' class='attach_url_path'			value='<c:out value="${file.urlPath}" />' />
									<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />
								</div>
							</div>
							</c:forEach>
					</div>
				</dd>
			</dl>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		 
		<div>
			<div style="float: left; margin-right: 3px;">
				<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			</div>
			<div class="delBtnDiv" style="float: left; margin-right: 3px;" hidden="hidden">
				<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
			</div>
			<div>
				<a id="insBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			</div>
		</div>
	</div>
</div>
<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
