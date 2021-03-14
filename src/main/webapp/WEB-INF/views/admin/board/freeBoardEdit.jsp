<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />

<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script>

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/board/boardReg' />";
	var delUrl	= "<c:url value='/data/board/boardDel' />";
	var listUrl	= "<c:url value='/admin/board/freeBoardList' />";	 
	var editUrl	= "<c:url value='/admin/board/freeBoardEdit' />";	
	
	var replyRegUrl = "<c:url value='/admin/board/freeBoardReplyReg' />";
	
	var commentRegUrl = "<c:url value='data/board/boardCommentReg'/>";
	var commentUpdUrl = "<c:url value='data/board/boardCommentUpdate'/>";
	var commentDelUrl = "<c:url value='data/board/boardCommentDel'/>";
	
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[1] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);

	//등록시 댓글영역 숨김
	var boardIdVal = $(":hidden[name=boardId]").val();
	if(boardIdVal ==''){		
		 $("#cmt_list_area").css("display","none");			
		 $("#cmt_insert_area").css("display","none");			
	}

	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		
		if (!validation()) return false;
		
		if(false) {
			alert("코스번호는 필수입니다.");
			//$(":text[name='courseNum']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.id) {
						alert("저장되었습니다.");
						$(".listBtn").trigger("click");
					} else {
						alert("저장실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 삭제 버튼
	$("#delBtn").unbind("click").bind("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("정상적으로 삭제 되었습니다.");
						
						// 리스트 페이지로 이동
						$(".listBtn").trigger("click");
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	// 답글 폼으로 이동
	 $("#replyBtn").on("click",function(){
		 contentLoad("자유게시판", replyRegUrl, {"id": $(":hidden[name='id']").val()});	
	 })
	
	
	//댓글 입력
	$(".cmtIstBtn").on("click",function(){
		var categoryVal = $(":hidden[name=category]").val();
		//원글의 댓글/ 답글의 댓글 구분 
		var data = categoryVal== 'M'?  $("form[name='cmtInsertForm']").serialize() : $("form[name='cmtReplyInsertForm']").serialize();
		if(false) {
			alert("값을 입력해 주세요.");			 
		} else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: commentRegUrl,
				data 	: data,
				success	: function(result) {
					if(result>0) {
						alert("등록되었습니다.");
						contentLoad("자유게시판", listUrl, $("form[name='searchForm']").serialize());
					} else {
						alert("입력실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	})
	
	//댓글 삭제 
	$(".cmtDelBtn").on("click", function(){
		var categoryVal = $(":hidden[name=category]").val();
		//원글의 댓글
		if(categoryVal =='M'){
			var idx = $("#cmt_list_area .cmtDelBtn").index($(this));
			var data = {id : $("#cmt_list_area .cmtListId").eq(idx).val()};
		//답글의 댓글
		}else if (categoryVal=='S'){
			var idx = $("#cmt_list_area_reply .cmtDelBtn").index($(this));
			var data = {id : $("#cmt_list_area_reply .cmtListId").eq(idx).val()};
		}
		if(false) {
			alert("값을 입력해 주세요.");			 
		} else if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: commentDelUrl,
				data 	: data,
				success	: function(result) {
					if(result>0) {
						alert("삭제되었습니다.");						 
						contentLoad("자유게시판", listUrl, $("form[name='searchForm']").serialize());
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}		
	})
	
	//댓글 수정  
	$(".cmtUpdBtn").on("click", function(){
		var categoryVal = $(":hidden[name=category]").val();
		//원글의 댓글
		if(categoryVal =='M'){
				var idx = $("#cmt_list_area .cmtUpdBtn").index($(this));
				var data =  {
									id : $("#cmt_list_area .cmtListId").eq(idx).val(),
									comment  :$("#cmt_list_area .cmtListCmt").eq(idx).val()
									};	 
		//답글의 댓글		
		}else if(categoryVal =='S'){
				var idx = $("#cmt_list_area_reply .cmtUpdBtn").index($(this));
				var data =  {
									id : $("#cmt_list_area_reply .cmtListId").eq(idx).val(),
									comment  :$("#cmt_list_area_reply .cmtListCmt").eq(idx).val()
									};	 
		}  
		if(false) {
			alert("값을 입력해 주세요.");			 
		} else if(confirm("수정하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: commentUpdUrl,
				data 	:  data,
				success	: function(result) {			
					if(result>0) {
						alert("수정되었습니다.");						 
						contentLoad("자유게시판", listUrl, $("form[name='searchForm']").serialize());
					} else {
						alert("수정실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}		
	})
	
	// 페이지 리스트 이동
	$(".listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad(pageTitle, listUrl, $("form[name='searchForm']").serialize());	  
	});
	
	var boardType = '<c:out value="${search.boardType}" />';
	var noticeType = '<c:out value="${search.noticeType}" />';
	var pageTitle;
	
	switch (boardType) {
		case '1' : 
			pageTitle = '공지사항';
			if (noticeType == '7') pageTitle = '연수모집공문관리'
			break;
		case '2' : pageTitle = '자료실관리'; break;
		case '3' : pageTitle = '자주묻는질문'; break;
		case '4' : pageTitle = '1:1상담관리'; break;
		case '5' : pageTitle = '연수후기관리'; break;
		case '8' : pageTitle = '자유게시판'; break;
		default : pageTitle = ''; break;
	}
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html(pageTitle);
});

// 데이터 유효성 체크
function validation() {
	var faqCode = $("select[name='faqCode']");
	
	if (faqCode.length > 0 && faqCode.val() == '') {
		alert("분류를 선택하셔야 합니다.");
		return false;
	}
	
	return true;
}
</script>
		
<div class="content_wraper">
	<h3>게시물 상세</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="" />' />
			<input type='hidden' name='noticeType' value='<c:out value="${search.noticeType}" default="" />' />
		</form>
		<!-- //searchForm end -->	
	 		<input type="hidden" name="category" value="${category}">
	<!-- 원글 -->		
	<div id="actionArea">
		<form name="actionForm" method="post">
			<!-- hidden 데이터 -->
			<input type='hidden' name='id' value='<c:out value='${board.id}' default="0" />' />	<!-- Id가 존재 하면 update 없으면 insert -->
			<input type='hidden' name='boardType' value='<c:out value="${search.boardType}" default="" />' />
			<dl>	
				<dt>제목</dt>
				<dd>
					<input type="text" name="title" class="form-control" value="<c:out value='${board.title}'/>" />
				</dd>
				<dt>내용</dt>
				<dd>
					<textarea class="editor" id="comment_editor" name="comment" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${board.comment}" /></textarea>
				</dd>
				<!-- 파일 -->
				<c:if test="${search.boardType ne '5'}">
					<dt>파일#1</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file1.fileId' value='<c:out value="${board.file1.fileId}" default="" />' />
							<input type='hidden' class='upload_dir'	value='/upload/board/files' />
							
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
							</div>
							
							<c:if test="${board.file1 ne null and board.file1.detailList ne null and fn:length(board.file1.detailList) > 0}">
								<c:forEach items="${board.file1.detailList}" var="file" varStatus="status">
								<div class='file_info_area' style='float: left;'>
									<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>
										<input type='button' value='<c:out value="${file.originFileName}" />' style='width: 200px; height: 30px;' />
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
							</c:if>
						</div>
					</dd>
					<dt>파일#2</dt>
					<dd class="half">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' class='attach_file_id'	name='file2.fileId' value='<c:out value="${board.file2.fileId}" default="" />' />
							<input type='hidden' class='upload_dir'	value='/upload/board/files' />
							
							<div class='file_upload_btn_area' style="clear: both;">
								<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
								<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M)</span>
							</div>
							
							<c:if test="${board.file2 ne null and board.file2.detailList ne null and fn:length(board.file2.detailList) > 0}">
								<c:forEach items="${board.file2.detailList}" var="file" varStatus="status">
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
							</c:if>
						</div>
					</dd>
				</c:if>
			</dl>			
			<div>
			   <a class="listBtn btn align_right" href="javascript:void();">리스트</a>
				<c:if test="${not empty board.id}">
					<a id="delBtn" class="btn align_right danger" href="javascript:void();">삭제</a>
				</c:if>
				<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
			    <a id="replyBtn" class="btn align_right" href="javascript:void();" >답글</a> 			 
			</div>
			<br>					
			<!-- view end -->
		</form>	 
		<!-- actionForm end -->
		
		<!-- 댓글입력-->
		<div id="cmt_insert_area">
		<form name="cmtInsertForm" method="post">
		    <dl>				 
				<dt>댓글</dt>
				<dd> 		
					<input type="hidden" name="category" value="${category }">	    
				    <input type="hidden" name="boardId"  value="${board.id}">
					<input type="text" name="comment" class="form-control w80"  />  
					<a  class="cmtIstBtn btn align_right primary" href="javascript:void();" >입력</a>  					
				</dd>				 
			</dl>
		</form>
		</div>
		<!--댓글입력 end  -->
		
			<!-- 등록된 댓글리스트 -->			
			   <div id="cmt_list_area">	 		 	
					<input type="hidden" name="boardId"   value="${board.id}">
						<dl>	
							<c:forEach items="${boardCmtList}" var="boardCmt">
								<dt>${boardCmt.userId}</dt>
								<dd>  							   									 
									<input type="hidden" name="id" class="cmtListId" value="${boardCmt.id}">
									<input type="text" name="comment" class="cmtListCmt form-control w80" value="<c:out value='${boardCmt.comment}'/>" />  
									 <a class="cmtUpdBtn btn align_right primary" href="javascript:void();" >수정</a>  
									 <a class="cmtDelBtn btn align_right danger" href="javascript:void();" >삭제</a>  
								</dd>
							</c:forEach>
						</dl>							
				</div>		
			<!--등록된 댓글리스트 end -->			
		</div>
		</div>
	</div>
 

<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->