<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	/* var listUrl	= "<c:url value='/student/Counsel/counselList' />"; */
	var listUrl	= "<c:url value='/student/Counsel/counselStudentList' />";
	var cirriculumList;
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	//분류 세팅함수
	function setSearchCode() {
		if('${search.crc_id}' != '' && '${search.crc_id}' != null) {
			$("#gwajeongSelector").append('<option value="">과정 선택</option>');
			$("#gisuSelector").append('<option value="">과정 선택</option>');
			
			for (var i = 0; i < cirriculumList.length; i++) {
				var map = cirriculumList[i];
				$("#gwajeongSelector").append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
			}
			searchListGisu('${search.crc_id}');

			$("#gwajeongSelector option").each(function(index, item){
				if($(item).val() == '${search.crc_id}'){
					$("#gwajeongSelector").val($(item).val()).prop("selected",true);
				}
			});
			
			$("#gisuSelector option").each(function(index, item){
				if($(item).val() == '${search.gisu_id}'){
					$("#gisuSelector").val($(item).val()).prop("selected",true);
				}
			});
		} else {
			$("#gwajeongSelector").append('<option value="">과정 선택</option>');
			for (var i = 0; i < cirriculumList.length; i++) {
				var map = cirriculumList[i];
				$("#gwajeongSelector").append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
			}
		}
	}
	$("#gwajeongSelector").change(function(){
		$("#gisuSelector").html("");
		searchListGisu($(this).val());
		$("#searchCrc_id").val($("#gwajeongSelector option:selected").val());
	});
	
	$("#gisuSelector").change(function(){
		$("#searchGisu_id").val($("#gisuSelector option:selected").val());
	});
	
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
			success	: function(result) {
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var data = dataList[i];
						
						sb.Append("<tr>");
						sb.Append("	<td>" + (i+1) + "</td>");
						
						if(data.stu_photo_file != undefined){
							var photoFile_detail = data.stu_photo_file.detailList;
							
							if(photoFile_detail != undefined && photoFile_detail.length > 0){
								var photoFile = photoFile_detail[0];
								
								// urlPath null 유무 : 지원서를 학적부로 복사할 때 urlPath를 등록하지 않아서 null이 됨. 학적부에서 첨부파일을 수정할 때 urlPath가 등록됨.
								if(photoFile.urlPath != null){
									sb.Append('<td><img src="' + photoFile.urlPath + '" width="50px" height="70px"></td>');
									//sb.Append('<td><img src="/kim' + photoFile.urlPath + '" width="50px" height="70px"></td>');
								}else{
									switch(data.gisu_id){
									case "n000000458" : //SWDO 1기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_53/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									case "n000000459" : //SWDO 2기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_58/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									case "n000000460" : //SWDO 3기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_60/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									case "n000000461" : //SWDO 4기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_94/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									case "n000000462" : //SWDO 5기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_10000/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									case "n000000528" : //SWDO 6기
										sb.Append('<td><img src="/edu/apply/photo/' + data.user_id + '_10006/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									default :
										sb.Append('<td><img src="/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										//sb.Append('<td><img src="/kim/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName + '" width="50px" height="70px"></td>');
										break;
									}
								}
							}	
						}else sb.Append('<td></td>');
						
						sb.Append("	<td>")
						sb.Append('		<input type="button" style="color:blue;width:100%;border:0px;height:100%;" onclick="viewDetailList(this)" class="user_nm_input" value="'+ data.user_nm +'">');
						sb.Append("	</td>");
						sb.Append("	<td>" + data.totalCnt);
						sb.Append("		<input type='hidden' name='crc_id' value='" + data.crc_id + "' />");
						sb.Append("		<input type='hidden' name='gisu_id' value='"+ data.gisu_id + "' />");
						sb.Append("		<input type='hidden' name='user_id' value='"+ data.user_id + "' />");
						sb.Append("		<input type='hidden' name='crc_name' value='"+ data.crc_name + "' />");
						sb.Append("		<input type='hidden' name='gisu_name' value='"+ data.gisu_name + "' />");
						sb.Append("	</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan=4>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				$("#stuListBody").html(sb.ToString());
				if(result.list.length == 1) viewDetailList($('.user_nm_input'));
				
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
 			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		$('#counselListBody').html('');
		$('#stuInfoBody').html('');
		setContentList(1);
	});
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	$("#writeBtn").on("click", function() {
		$('#stuListBody').find('input').each(function(index, item){
			
			if($(item).css("background-Color") == 'rgb(224, 224, 224)'){
				$('#user_nm').val( $(item).val() );
				$('#crc_name').val( $(item).parents('tr').find('input[name="crc_name"]').val() );
				$('#gisu_name').val( $(item).parents('tr').find('input[name="gisu_name"]').val() );
				$('#course_id').val( $(item).parents('tr').find('input[name="crc_id"]').val() );
				$('#cardinal_id').val( $(item).parents('tr').find('input[name="gisu_id"]').val() );
				$('#user_id').val( $(item).parents('tr').find('input[name="user_id"]').val() );
				return false;
			}
		});
		contentLoad('상담내역추가','/admin/studentManagement/studentCounselCreate', $("form[name='searchForm']").serialize());
	});
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	//분류목록 세팅
	searchList();
	//분류 검색 정보 확인
	setSearchCode();
	//컨텐츠 로드
	setContentList();
	function searchListGisu(seq){
		var sb = new StringBuilder();
		var newSeq = seq;
		var Url	= "<c:url value='/student/TestManagement/searchGisuList' />";
		$.ajax({
			type	: "post",
			data 	: newSeq,
			url		: Url,
			async	: false,
			success : function(result){
				$("#gisuSelector").html("");
				sb.Append('<option value="">기수 선택</option>');
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
				}
				$('#gisuSelector').append(sb.ToString());
			}
		});
	}

	function searchList(){
		var sb = new StringBuilder();
		var firstGisu = 0;
		var Url	= "<c:url value='/student/TestManagement/searchCirriculumList' />";
		$.ajax({
			type	: "post",
			url		: Url,
			async	: false,
			success : function(result){
				cirriculumList=result;
			}
		});
	}
});

// 오른쪽 섹션에 학생 기본 정보, 상담 리스트 불러오는 함수
function viewDetailList(obj){
	$('#stuListBody').find('input').css("background-Color","");
	$(obj).css("background-Color","#E0E0E0");
	
	var data = new Object();
	data.crc_id = $(obj).parents('tr').find('input[name="crc_id"]').val(); 
	data.gisu_id = $(obj).parents('tr').find('input[name="gisu_id"]').val();
	data.user_id =$(obj).parents('tr').find('input[name="user_id"]').val();
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Counsel/counselDetail' />",
		data	: data,
		dataType : "json",
		success : function(result){
			var stuInfo = result[0];
			var list = result[1];
			var class_nm = "";
			var sb = new StringBuilder();
			
			if(stuInfo != null){
				for(var i=0; i<stuInfo.classList.length; i++)
					class_nm += stuInfo.classList[i].stu_class + "<br>"
				
				var sc_nm = "";
				for(var i=0; i<stuInfo.eduHistoryList.length; i++)
					sc_nm += stuInfo.eduHistoryList[i].stu_edu_sc_nm + "<br>";
					
				var sc_major = "";
				for(var i=0; i<stuInfo.eduHistoryList.length; i++)
					sc_major += stuInfo.eduHistoryList[i].stu_edu_major + "<br>";
					
				var license_nm = new StringBuilder();
				for(var i=0; i<stuInfo.licenseList.length; i++){
					var license = stuInfo.licenseList[i];
					
					switch(license.stu_license_nm){
					case "B2900":
						license_nm.Append("정보처리기사 <br>");
						break;
					case "B2901":
						license_nm.Append("정보처리산업기사 <br>");
						break;
					case "B2906":
						license_nm.Append("기타<br>");
					}
				}
					
				var language = new StringBuilder();
				for(var i=0; i<stuInfo.languageList.length; i++){
					var lang = stuInfo.languageList[i];
					var lang_nm;
					
					switch(lang.stu_lang_test_nm){
					case "B2902":
						lang_nm = "JLPT 1급";
						break;
					case "B2903":
						lang_nm = "JLPT 2급";
						break;
					case "B2904":
						lang_nm = "JPT";
						break;
					case "B2905":
						lang_nm = "TOEIC";
						break;
					case "B2906":
						lang_nm = "기타"
					}
					language.Append(lang_nm + " " + lang.stu_lang_grade + "<br>");
				}
				
				sb = new StringBuilder();
 				sb.Append("<tr>");
				sb.Append("<td>" + stuInfo.stu_user_nm + "</td>");
				sb.Append("<td>" + stuInfo.stu_age + "</td>");
				sb.Append("<td>" + class_nm + "</td>")
				sb.Append("<td>" + sc_nm + "</td>")
				sb.Append("<td>" + sc_major + "</td>")
				sb.Append("<td>" + license_nm.ToString() +"</td>")
				sb.Append("<td>" + language.ToString() +"</td>")
				sb.Append("</tr>");
				$('#stuInfoBody').html(sb.ToString());
				
				sb = new StringBuilder();
				for(var i=0; i<list.length; i++){
					sb.Append("<tr>");
					sb.Append("	<td>" + (i+1));
					sb.Append(		'<input type="hidden" name="counsel_seq" value="'+ list[i].COUNSEL_SEQ +'">')
					sb.Append("</td>");
					sb.Append("	<td>" + list[i].COUNSEL_REGDATE + "</td>");
					sb.Append("	<td>" + list[i].COUNSEL_TYPE + "</td>");
					sb.Append("	<td>");
					sb.Append(		'<input type="button" style="color:blue;width:100%;border:0px;height:100%;" class="checc" onclick="olp(\''+list[i].COUNSEL_SEQ+'\')" value="'+ list[i].COUNSEL_TITLE +'">')
					sb.Append("	</td>");
					sb.Append("	<td>" + list[i].COUNSEL_TEACHER_NM + "</td>");
					sb.Append("</tr>");
				}
				$('#counselListBody').html(sb.ToString());
			
			} else {
				sb.Append("<tr>");
				sb.Append("	<td colspan=7>조회된 결과가 없습니다.</td>");
				sb.Append("</tr>");
				$('#stuInfoBody').html(sb.ToString());
				
				sb = new StringBuilder();
				sb.Append("<tr>");
				sb.Append("	<td colspan=5>조회된 결과가 없습니다.</td>");
				sb.Append("</tr>")
				$('#counselListBody').html(sb.ToString());
			}
		} 
	});
}

function olp(seq){
	//data-toggle="modal" data-target="#myModal'+name+'"
	var data = {};
/* 	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val(); */
	data.counsel_seq = seq;
	data.gisu_id = $("#gisuList").val();
	data.crc_id  = $("#gisuValue").val();
 	var d = $('form[name="searchForm"]').serialize();
 	/*	d += "&counsel_seq="+seq;
	d += "&gisu_id="+gisu_id;
	d += "&crc_id="_crc_id;
 */	
	openLayerPopup("상담 상세", "/admin/common/popup/counselDetail", data);
	//alert(obj);
	//$('#myModal'+obj+'').focus();
}
</script>

<div class="content_wraper" id="modalsContentss">
	<h3>상담 내역</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 검색시 분류값 저장하는 곳 -->
        	<input type="hidden" name="crc_id" value="${search.crc_id }" id="searchCrc_id"/>
        	<input type="hidden" name="gisu_id" value="${search.gisu_id }" id="searchGisu_id"/>
<%--         	<input type="hidden" name="stu_state_ck" value="${stu_state_ck }" id="searchStu_state_ck"/> --%>
        	
        	<!-- 상담작성 페이지 이동시 사용할 학생 정보 저장하는 곳 -->
        	<input type="hidden" name="crc_name" id="crc_name"/>
        	<input type="hidden" name="gisu_name" id="gisu_name"/>
        	<input type="hidden" name="user_nm" id="user_nm"/>
        	<input type="hidden" name="course_id" id="course_id"/>
        	<input type="hidden" name="cardinal_id" id="cardinal_id"/>
        	<input type="hidden" name="user_id" id="user_id"/>
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
        	<div>
        		<table class="searchTable">
        		<tr>
        			<th>과정명</th>
        			<td>
						<select class="selector" id="gwajeongSelector"></select>
        			</td>
        		</tr>
        		<tr>
        			<th>기수명</th>
        			<td>
						<select class="selector" id="gisuSelector"></select>
        			</td>
        		</tr>
        		<tr>
        			<th>키워드검색</th>
        			<td>
	        			<select class="searchConditionBox" name="searchCondition">
<!-- 							<option value='all'>전체</option> -->
							<option value='all' <c:if test="${search.searchCondition eq 'all'}">selected</c:if>>전체</option>
							<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
							<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
							<option value='title' <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>상담명</option>
						</select>
						<input type="text" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
        			</td>
        		</tr>
        		<tr>
        			<td class="buttonTd" colspan="2">
	        			<a id='searchBtn' class="btn btn-primary" type="button" style="vertical-align: bottom;">검색</a>
						<a class="btn btn-danger" style="vertical-align: bottom;" href="javascript:contentLoad('상담내역','/admin/studentManagement/studentCounselManagement');">전체초기화</a>
						<a id="writeBtn" class="btn" style="vertical-align: bottom;">상담일지 작성</a>
        			</td>
        		</tr>
        		</table>
			</div>
		</form>
		<!-- //searchForm end -->
		
		<div class="ccontent dd-flex">
	        <div class="counselSection leftSection">
	            <table style="border-collapse: collapse;">
					<thead>
						<tr>
							<th>#</th>
							<th>사진</th>
							<th>이름</th>
							<th>상담횟수</th>
						</tr>
					</thead>
					<tbody id="stuListBody"></tbody>
				</table>
	        </div>
	        <div class="ccontent rightSection">
		        <div class="counselSection infoSection">
		        	<table style="border-collapse: collapse;">
						<thead>
							<tr>
								<th>이름</th>
								<th>나이</th>
								<th>반</th>
								<th>학교</th>
								<th>전공</th>
								<th>자격사항</th>
								<th>어학성적</th>
							</tr>
						</thead>
						<tbody id="stuInfoBody"></tbody>
					</table>
		        </div>
		        <div class="counselSection detailSection">
		        	<table style="border-collapse: collapse;">
						<thead>
						<tr>
							<th>#</th>
							<th>상담일</th>
							<th>상담유형</th>
							<th>제목</th>
							<th>상담자</th>
						</tr>
						</thead>
						<tbody id="counselListBody"></tbody>
					</table>
		        </div>
	        </div>
	    </div>
		
		<!-- <table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th>상담번호</th>
				<th>이름</th>
				<th>과정</th>
				<th>기수</th>
				<th>휴대전화</th>
				<th>상담 유형</th>
				<th>상담 제목</th>
				<th>상담자</th>
				<th>상담일</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging">
			<a class="btn" href="javascript:contentLoad('상담내역추가','/admin/studentManagement/studentCounselCreate');">추가하기</a>
		</div> -->
	</div>
</div>
