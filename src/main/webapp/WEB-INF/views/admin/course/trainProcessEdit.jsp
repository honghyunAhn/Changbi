<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 분납정보 테이블 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/trainProcess.css" />">
<!-- 자동설문 템플릿 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/surveyCreate.css" />">
<!-- smarteditor javascript -->
<script src="<c:url value="/common/editor/js/HuskyEZCreator.js"/>"></script><!-- smarteditor javascript -->

<script type="text/javascript">
var crc_id = "${course.id}"; //자동설문 관련 함수에서 공통으로 사용하는 변수

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var regUrl	= "<c:url value='/data/course/trainProcessReg' />";
	var updUrl	= "<c:url value='/data/course/trainProcessUpd' />";
	var delUrl	= "<c:url value='/data/course/trainProcessDel' />";
	var listUrl	= "<c:url value='/admin/course/trainProcessList' />";
	var bookUrl = "<c:url value='/data/book/bookList' />";
	var courseListUrl = "<c:url value='/data/course/selectCourseList' />";
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	file_object[1] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'all'};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);


	
	//스마트 에디터 적용하기
/* 	$("textarea.editor").each(function(i) {

		var editor_id = $("textarea.editor").eq(i).attr("id");

		// 에디터 초기화
	});	 */
	var editor_object1 = [];
	var editor_object2 = [];
	var editor_object3 = [];
	var editor_object4 = [];
	var editor_object5 = [];
	
 	smartEditorSetup(editor_object1, "purpose_editor");
 	smartEditorSetup(editor_object2, "curriculum_editor");
	smartEditorSetup(editor_object3, "summary_editor");
	smartEditorSetup(editor_object4, "instructor_editor");
	smartEditorSetup(editor_object5, "note_editor");

	
	function smartEditorSetup(editor_obj, editor_id){

		nhn.husky.EZCreator.createInIFrame({
			oAppRef			: editor_obj,
			elPlaceHolder	: editor_id,
			sSkinURI		: '/common/editor/SmartEditor2Skin.html',
			htParams 		: { bUseToolbar : true
							  , bUseVerticalResizer : false
							  , bUseModeChanger : false },
			fOnAppLoad:function() {
				$("iframe").css("width","100%").css("height", "500px");
		 		$('iframe').each(function(){
		 			$(this).contents().find('.husky_seditor_editing_area_container').css('height', '500px');
		 			$(this).contents().find('.husky_seditor_editing_area_container').children().css('height', '100%'); 
		 			$(this).prop("scrolling","yes");
	 	 		});
				
//				$(".se2_input_wysiwyg").css("width","100%").css("height", "200px");

				// 강제로 iframe 사이즈 잡음. IE에서만 ?? 크롬에서도 안되던데.. 높이가 0으로 되버림.. hidden일때
				// $("iframe").css("width","100%").css("height", "206px");
				// initSmartEditor(i);
 				if(editor_obj==editor_object1){
					editor_obj.getById["purpose_editor"].exec("PASTE_HTML", ['${course.purpose}']);
 				} else if(editor_obj==editor_object2){
					editor_obj.getById["curriculum_editor"].exec("PASTE_HTML", ['${course.curriculum}']);
				} else if(editor_obj==editor_object3){
					editor_obj.getById["summary_editor"].exec("PASTE_HTML", ['${course.summary}']);					
				} else if(editor_obj==editor_object4){
					editor_obj.getById["instructor_editor"].exec("PASTE_HTML", ['${course.instructor}']);					
				} else if(editor_obj==editor_object5){
					editor_obj.getById["note_editor"].exec("PASTE_HTML", ['${course.note}']);					
				} 
			},
			fCreator: "createSEditor2"
		});

	}
	
	var data;
	$.ajax({
		type	: "post",
		url		: "<c:url value='/forFaith/base/cateCodeList' />",
		async : false,
		success	: function(result) {
			data=result;
		}
	});
	
	//trainProcessList.jsp와 약간 다름
	function setSearchCode(){

			$("#bigSelect").append('<option value="">대분류선택</option>');
			$("#middleSelect").append('<option value="">중분류선택</option>');
			$("#smallSelect").append('<option value="">소분류선택</option>');
			
			for(var i=0;i<data.length;i++){
			
				$("#bigSelect").append('<option value="'+ data[i].code+'">'+data[i].name+'</option>');
			
				if(data[i].code=='${course.subCourseCode.parentCode.code}'){
				
					for(var j=0;j<data[i].childCodeList.length;j++){
					
						$("#middleSelect").append('<option value="'+data[i].childCodeList[j].code+'">'+data[i].childCodeList[j].name+'</option>');
					
						if(data[i].childCodeList[j].code=='${course.subCourseCode.code}'){
						
							for(var k=0;k<data[i].childCodeList[j].childCodeList.length;k++){
							
								$("#smallSelect").append('<option value="'+data[i].childCodeList[j].childCodeList[k].code+'">'+data[i].childCodeList[j].childCodeList[k].name+'</option>');
							}
						}
					}
				}
			}
		
			$("#bigSelect option").each(function(index, item){
				if($(item).val() == '${course.subCourseCode.parentCode.code}'){
					$("#bigSelect").val($(item).val()).prop("selected",true);
				}
			});
		
			$("#middleSelect option").each(function(index, item){
				if($(item).val() == '${course.subCourseCode.code}'){
					$("#middleSelect").val($(item).val()).prop("selected",true);
				}
			});
		
			$("#smallSelect option").each(function(index, item){
				if($(item).val() == '${course.courseCode.code}'){
					$("#smallSelect").val($(item).val()).prop("selected",true);
				}
			});
	}
	
	setSearchCode();
	
	
	$("#bigSelect").change(function(){
		$("#middleSelect").html("");
		$("#smallSelect").html("");
		for(var i=0;i<data.length;i++){
			if(data[i].code==$("#bigSelect option:selected").val()){
				$("#middleSelect").append('<option value="">중분류선택</option>');
				for(var j=0;j<data[i].childCodeList.length;j++){

					$("#middleSelect").append('<option value="'+data[i].childCodeList[j].code+'">'+data[i].childCodeList[j].name+'</option>');
					$("#big").val($("#bigSelect option:selected").html());
					
				}
			}
		}
			$("#showCourseCode").val($("#bigSelect option:selected").html());
			$("#actionCourseCode").val($("#smallSelect option:selected").val());
			$("#parentSubCourseCode").val($("#bigSelect option:selected").val());
	});
	
	$("#middleSelect").change(function(){
		$("#smallSelect").html("");
		for(var i=0;i<data.length;i++){
			for(var j=0;j<data[i].childCodeList.length;j++){
				if(data[i].childCodeList[j].code==$("#middleSelect option:selected").val()){
					$("#smallSelect").append('<option value="">소분류선택</option>');
					for(var k=0;k<data[i].childCodeList[j].childCodeList.length;k++){
						$("#smallSelect").append('<option value="'+data[i].childCodeList[j].childCodeList[k].code+'">'+data[i].childCodeList[j].childCodeList[k].name+'</option>');
					}
				} 
			}
			
		}
			$("#showCourseCode").val($("#middleSelect option:selected").html());
			$("#actionCourseCode").val($("#smallSelect option:selected").val());
			$("#subCourseCodecode").val($("#middleSelect option:selected").val());
	});
	
	$("#smallSelect").change(function(){
		var name="";
		$("#showCourseCode").val($("#smallSelect option:selected").html());
		$("#actionCourseCode").val($("#smallSelect option:selected").val());
		$("#courseCodecode").val($("#smallSelect option:selected").val());
	});
	
	/** 이벤트 영역 **/
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	
	$("#regBtn").unbind("click").bind("click", function() {
		
		var _title = $(":text[name='id']").val() ? "수정" : "저장";
		var _url = $(":text[name='id']").val() ? updUrl : regUrl;	
		var gisu_flag = true;

		$.each($('.gisu_table').find('input'), function(index, item){
			if($(item).val().trim() == ""){
				gisu_flag = false;
				return false;
			}
		});
		
		if(!$(":text[name='name']").val()) {
			alert("과정명은 필수항목입니다..");
			$(":text[name='name']").focus();
		} /* else if(!$(":text[name='shortName']").val()) {
			alert("과정줄임말은 필수항목입니다..");
			$(":text[name='shortName']").focus();
		}  */
		 else if($(":text[name='selpPeriod']").val() < 1) {
			alert("1일 이상의 연수일수를 입력하세요..");
			$(":text[name='selpPeriod']").focus();
		}else if(!gisu_flag) {
			alert("기수 분납 정보를 입력하세요.");
		}else if(confirm(_title+"하시겠습니까?")) {
			// 모든 에디터 내용을 textarea Contents로 업데이트 시킴
			$("textarea.editor").each(function(i) {
				var editor_id = $("textarea.editor").eq(i).attr("id");
				
				/* editor_object.getById[editor_id].exec("UPDATE_CONTENTS_FIELD", []); */
			});
			
			editor_object1.getById["purpose_editor"].exec("UPDATE_CONTENTS_FIELD", []);
			editor_object2.getById["curriculum_editor"].exec("UPDATE_CONTENTS_FIELD", []);
			editor_object3.getById["summary_editor"].exec("UPDATE_CONTENTS_FIELD", []);
			editor_object4.getById["instructor_editor"].exec("UPDATE_CONTENTS_FIELD", []);
			editor_object5.getById["note_editor"].exec("UPDATE_CONTENTS_FIELD", []);

			// 저장 방식(직접호출X)
// 			contentLoad("회원추가", regUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: _url,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(_title == "저장" ? result.id : result > 0) {
						alert(_title+"되었습니다.");
						
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
		}
	});
	
	// 삭제 버튼
	$("#delBtn").unbind("click").bind("click", function() {
		if(confirm("해당 과정을 삭제하시겠습니까?")) {
			// 저장 방식(직접호출X)
			// contentLoad("회원삭제", delUrl, $("form[name='actionForm']").serialize());
			// ajax 처리방식 사용
			$.ajax({
				type	: "post",
				url		: delUrl,
				data 	: $("form[name='actionForm']").serialize(),
				dataType: 'json',
				success	: function(result) {
					if(result > 0) {
						alert("정상적으로 삭제 되었습니다.");
						
						// 리스트 페이지로 이동
						$("#listBtn").trigger("click");
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
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수과정관리", listUrl, $("form[name='searchForm']").serialize());
	});

	// 탭메뉴
	$(".tab_head .tablink").unbind("click").bind("click", function() {
		var index = $(".tab_head .tablink").index($(this));
	   
		$(".tab_head .tablink").removeClass("on");
		$(this).addClass("on");
	   
		$("#tabMenu>.tab_body").hide();
 
		$("#tabMenu>.tab_body").eq(index).show();

		
		// 탭의 내부에 있는 에디터에 포커스가 먹게 처리
		$("#tabMenu>.tab_body").eq(index).find("textarea.editor").each(function() {
			var editor_id = $(this).attr("id");
		});
	});
	
	
	//대분류 콤보박스 변경시 학습영역 데이터 로드  
	$("select[name='subCourseCode.code']").unbind("change").bind("change",function(){			
	})
	
	// 교재업체 콤보박스 변경시 주교재 및 부교재 콤보박스 데이터 로드
	$("select[name='bookCode.code']").unbind("change").bind("change", function() {
		var mainSb = new StringBuilder();
		var subSb = new StringBuilder();
		
		mainSb.Append("<option value='0'>주교재없음</option>");
		subSb.Append("<option value='0'>교구없음</option>");
		
		if($(this).val()) {
			var data = {"supply.code" : $(this).val(), "useYn" : "Y", "pagingYn" : "N"};
			
			$.ajax({
				type	: "post",
				url		: bookUrl,
				data	: data,
				success	: function(result) {
					if(result.list && result.list.length > 0) {
						var dataList = result.list;
						var mbId = $(":hidden[name='mbId']").val();
						var sbId = $(":hidden[name='sbId']").val();
						
						for(var i=0; i<dataList.length; ++i) {
							var dataInfo = dataList[i];
	
							if (dataInfo.mainYn == "Y") { // 주교재인경우
								mainSb.Append("<option value="+dataInfo.id+" "+(mbId == dataInfo.id ? "selected" : "")+">"+dataInfo.name+"</option>");
							} else { // 주교재가 아닌 경우 (N 부교재 인경우)
								subSb.Append("<option value="+dataInfo.id+" "+(sbId == dataInfo.id ? "selected" : "")+">"+dataInfo.name+"</option>");
							}
						}
					} 
					
					// 주교재, 부교재 콤보박스 아이템 바인딩
					$("select[name='mainBook.id']").html(mainSb.ToString());
					$("select[name='subBook.id']").html(subSb.ToString());
				},
				error	: function(e) {
					alert(e.responseText);
				}
			});
		} else {
			// 주교재, 부교재 콤보박스 아이템 바인딩
			$("select[name='mainBook.id']").html(mainSb.ToString());
			$("select[name='subBook.id']").html(subSb.ToString());
		}
	});
	
	
	// model로 받은 surveyYn값이 Y일 때, 설문자동배포란에 자동배포한 설문 리스트를 표시
	if("${course.surveyYn}" == 'Y'){
		var data = new Object();
		data.crc_id = crc_id;
		showAutoSurvey(data);
	}
	
	// 기수 추가 버튼 클릭 시(레이어팝업)
	$("#addCardinal").unbind("click").bind("click", function() {
		var data = new Object();
		
		data.learnType = "J,G";

		openLayerPopup("기수검색", "/admin/common/popup/cardinalList2", data);		

	});
	
	// 기수 선택삭제 버튼 클릭 시
	$("#delCardinal").unbind("click").bind("click", function() {
		if($(":checkbox[name='chkCardinalId']:checked").size() > 0) {
			$(":checkbox[name='chkCardinalId']:checked").each(function() {
				$(this).closest("tr").remove();
			});
			
			$("#cardinalList > tr").each(function(i){
				$(this).find("input[name^='cardinalList']").each(function(a){
					var arr = $(this).attr("name").split(".");
					var name = "";
					arr.forEach(function(item, index){
						if(index == 0) {
							name += "cardinalList["+i+"].";
						} else {
							name += arr[index]+".";	
						}
					});
					var fin = new StringBuilder();
					fin.Append(name.substring(0, name.length-1));
 					$(this).attr("name", fin.ToString());
				});
			});
		} else {
			alert("삭제 할 기수를 체크해주세요.");
		}
		
	});
	
	// 기수 전체 선택
	$("#selectCardinalAll").unbind("change").bind("change", function() {
		var isChecked = $(this).prop('checked');
		
		$(":checkbox[name='chkCardinalId']").prop('checked', isChecked);
	});
	
	//첨부파일 다운로드
	$('div.file_view').on('click', function(){
		var file_info = $(this).siblings().eq(0);
		var origin = file_info.children().eq(3).val();
		var saved = file_info.children().eq(0).val();
		var download_url = "/forFaith/file/file_download?origin=" + origin + "&saved=" + saved + "&path=uploadImage";
		location.href = download_url;
	});
	
	/* ---------------------------미리보기 관련 이벤트, 변수------------------------------ */
	
	var url;
	var popup;
	var newCodeTxt;
	//적용한 페이지 미리보기
	$('#appBtn').on('click', function(){
		newCodeTxt = $('#codeTxt_editor').val();
		//임시로 붙여놓음(추후수정필요)
		if($('#bigSelect').val() == 'CATESEQ292' || $('#bigSelect').val() == 'CATESEQ293') {
			url = 'https://www.softsociety.net/smtp/course/scmaster/scmaster-info?course_id=${course.id}';
		} else if( $('#bigSelect').val() == 'CATESEQ294'){
			url = 'https://www.softsociety.net/smtp/course/short-term/short-term-info?course_id=${course.id}';
		}
		//해당 페이지를 팝업시킴
		popup = window.open(url,'curPagePop', "toolbar=yes,scrollbars=yes,resizable=yes");
	});
	//팝업창에서 보낸 메세지를 받는 메소드
	function getMessage(event) {
		//현재까지 작성한 code값
		newCodeTxt = $('#codeTxt_editor').val();
		//팝업창에서 준비되었다는 메세지를 보냈을 때,
		if(event.data === 'opened') {
			//작성중인 code 값을 보내서 적용시킴
			popup.postMessage({"newCodeTxt": newCodeTxt}, url);
			
			$('#codeTxt_editor').on('propertychange change keyup paste input', function(){
				newCodeTxt = $('#codeTxt_editor').val();
				popup.postMessage({"newCodeTxt": newCodeTxt}, url);
			});
		}
	}
	//팝업창의 메세지를 받아야하므로 이벤트를 연결시킴
	window.addEventListener('message', getMessage, false);
	
	/* ---------------------------------------------------------------------------------*/
	// 삭제 버튼 ID 존재하면 보이고 없으면 사라짐
	if(!$(":text[name='id']").val()) {
		$("#delBtn").hide();
	}
	// 분납정보 추가
	$(document).off('click').on("click", '.addPmtBtn', function(){
		var tbody = $(this).closest('table tbody');
		var tr_length = $(tbody).find('tr').length;
		var td_length = $(tbody).find('td').length;
		var tr_index = $(this).closest('table').closest('tr').find('input').eq(1).attr('name').slice(-5).charAt(0);
		var cardinal_id = $(this).closest('table').closest('tr').find('input').eq(0).val();
		
		var sb = new StringBuilder();
		if(td_length == 1){
			sb.Append('<tr>');	
			sb.Append('<td>1차');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[0].pmtCnt" value="1">')
			sb.Append('</td>');
			sb.Append('<td class="datepicker_td">');
			sb.Append("<div class='input-group date datetimepicker'>");
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[0].pmtStartDate" class="form-control"/>');
			sb.Append("<span class='input-group-addon'>");
			sb.Append("<span class='glyphicon glyphicon-calendar'></span>");
			sb.Append('</span></div>');
			sb.Append('</td>');
			sb.Append('<td class="datepicker_td">');
			sb.Append("<div class='input-group date datetimepicker'>");
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[0].pmtEndDate" class="form-control"/>');
			sb.Append("<span class='input-group-addon'>");
			sb.Append("<span class='glyphicon glyphicon-calendar'></span>");
			sb.Append('</span></div>');
			sb.Append('</td>');
			sb.Append('<td class="divAmt_td">');
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[0].pmtAmount" />');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[0].payCrcSeq" value="0" />');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[0].gisuId" value="' + cardinal_id + '" />');
			sb.Append('</td>');
			sb.Append('<td>');
			sb.Append('<a class="addPmtBtn btn primary" href="javascript:void();">+</a> ');
			sb.Append('<a class="deletePmtBtn btn primary" href="javascript:void();">-</a>');
			sb.Append('</td>');
			sb.Append('</tr>');
		}else{
			var cnCourseSeq = $(this).closest('tr').find('input').eq(4).val();
			
			sb.Append('<tr>');	
			sb.Append('<td>');
			sb.Append((tr_length + 1) + '차');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].pmtCnt" value="' + (tr_length + 1) + '">')
			sb.Append('</td>');
			sb.Append('<td class="datepicker_td">');
			sb.Append("<div class='input-group date datetimepicker'>");
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].pmtStartDate" class="form-control"/>');
			sb.Append("<span class='input-group-addon'>");
			sb.Append("<span class='glyphicon glyphicon-calendar'></span>");
			sb.Append('</span></div>');
			sb.Append('</td>');
			sb.Append('<td class="datepicker_td">');
			sb.Append("<div class='input-group date datetimepicker'>");
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].pmtEndDate" class="form-control"/>');
			sb.Append("<span class='input-group-addon'>");
			sb.Append("<span class='glyphicon glyphicon-calendar'></span>");
			sb.Append('</span></div>');
			sb.Append('</td>');
			sb.Append('<td class="divAmt_td">');
			sb.Append('<input type="text" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].pmtAmount" />');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].payCrcSeq" value="0"/>');
			sb.Append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList[' + tr_length + '].gisuId" value="' + cardinal_id + '" />');
			sb.Append('</td>');
			sb.Append('<td>');
			sb.Append('<a class="addPmtBtn btn primary" href="javascript:void();">+</a> ');
			sb.Append('<a class="deletePmtBtn btn primary" href="javascript:void();">-</a>');
			sb.Append('</td>');
			sb.Append('</tr>');
		}
		
		if(td_length == 1){
			$(this).closest('tbody').html(sb.ToString());
		}else if(tr_length == 1 & td_length == 5){
			$(this).closest('tbody').append(sb.ToString());
		}else if(tr_length > 1){
			$(this).closest('tbody').append(sb.ToString());
		}
		
		$('.datetimepicker').datetimepicker({
	       	format				: 'YYYY-MM-DD',
	        dayViewHeaderFormat	: 'YYYY년 MM월',
	        locale				: moment.locale('ko'),
	        defaultDate			: new Date()
	    });
	});
	
	// 분납정보 삭제
	$(document).on("click", ".deletePmtBtn", function(){
		var tbody = $(this).closest('table tbody');
		var index = $(this).closest('tr').children('td').eq(0).text().charAt(0);
		var payCrcSeq = '.payCrcSeq_'.concat(index-1);
		var pay = $(payCrcSeq).val();
		
		if($(tbody).find('tr').length == 1){
			var sb = new StringBuilder();
			sb.Append('<tr><td>');
			sb.Append('<a class="addPmtBtn btn primary" href="javascript:void();">+</a>');
			sb.Append('</td></tr>');
			$(tbody).append(sb.ToString());
			$(this).closest('tr').remove();
		}else{
			var tr_index = $(this).closest('table').closest('tr').find('input').eq(1).attr('name').slice(-5).charAt(0);
			$(this).closest('tr').remove();
			
			$.each($(tbody).find('tr'), function(index, item){
				$(item).find('td').eq(0).html((index + 1) + '차');
				$(item).find('td').eq(0).append('<input type="hidden" name="cardinalList[' + tr_index + '].paymentList['+ index +'].pmtCnt" value="' + (index+1) + '">');
				$(item).find('input').eq(1).attr('name', 'cardinalList[' + tr_index + '].paymentList['+ index +'].pmtStartDate');
				$(item).find('input').eq(2).attr('name', 'cardinalList[' + tr_index + '].paymentList['+ index +'].pmtEndDate');
				$(item).find('input').eq(3).attr('name', 'cardinalList[' + tr_index + '].paymentList['+ index +'].pmtAmount');
				$(item).find('input').eq(4).attr('name', 'cardinalList[' + tr_index + '].paymentList['+ index +'].payCrcSeq');
				$(item).find('input').eq(5).attr('name', 'cardinalList[' + tr_index + '].paymentList['+ index +'].gisuId');
			});
		}
		
		if(pay) {
			$.ajax({
				type : "POST",
				url : "/data/course/deleteGisuPayment",
				data : {"pay" : pay},
				success : function(result) {
					
				},
				error : function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});

	// 기수 상세페이지로 이동
	$(document).on("click", ".content_edit", function() {
		var data = new Object();
		data.id = $(this).find('input').val();
		contentLoad("기수관리상세", "<c:url value='/admin/course/cardinalEdit' />", data);
	});
	
	// 젤 처음에 교재업체 선택된 경우로 북리스트 가지고 온다.
	$("select[name='bookCode.code']").trigger("change");
});

function setCardinal(cardinal) {
	var isExist = false;
	var sb = new StringBuilder();

	$(":checkbox[name^='chkCardinalId']").each(function() {
		if($(this).val() == cardinal.id) {
			isExist = true;
			return false;
		}
	});
	
	if(isExist) {
		alert("이미 존재하는 기수입니다.");
	} else {
		var idx = $(":checkbox[name^='chkCardinalId']").size();
		sb.Append("<tr>");
		sb.Append("	<td><input type='checkbox' name='chkCardinalId' value='"+cardinal.id+"' /></td>");
		sb.Append("	<td><input type='hidden' name='cardinalList["+idx+"].id' value='"+cardinal.id+"' readonly='readonly' />"+cardinal.id+"</td>");
		sb.Append("	<td>"+cardinal.name+"</td>");
		sb.Append("	<td>"+cardinal.appStartDate+" ~ "+cardinal.appEndDate+"</td>");
		sb.Append("	<td>"+cardinal.learnStartDate+" ~ "+cardinal.learnEndDate+"</td>");
		sb.Append('	<td class="pmt_table"><table class="pmt_tb"><tbody><tr><td><a class="addPmtBtn btn primary" href="javascript:void();">+</a></td></tr></tbody></table></td>');
		sb.Append('<td>'+cardinal.price+'</td>');
		sb.Append("	<td>"+(cardinal.complateYn == "N" ? "미처리" : "처리")+"</td>");
		sb.Append("	<td>"+(cardinal.useYn == "N" ? "중지" : "서비스")+"</td>");
		sb.Append("</tr>");
	 
		$("#cardinalList").append(sb.ToString());
	}
}

// 자동배포한 설문 리스트 조회해서 화면에 표시
function showAutoSurvey(data){	
	// data는 과정 아이디를 넣은 객체
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/selectAutoSurveyList' />",
		data	: data,
		dataType : "json",
		success : function(result){
			var sb = new StringBuilder();
			
			if(result.list && result.list.length > 0) {
				var dataList = result.list;
				
				sb.Append('<button type="button" class="btn primary pull-right" onClick="searchSurvey()">자동설문 추가</button>');
				sb.Append('<table>');
				sb.Append('<thead><tr>');
				sb.Append('<th>설문 제목</th><th>설문 시작일</th><th>설문 기간</th><th>통계</th>');
				sb.Append('</tr></thead>');
				sb.Append('<tbody>');
				
				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var start = dataInfo.autoSurveyStart;
					var period = dataInfo.autoSurveyPeriod;
					var type = dataInfo.autoSurveyType;
					
					switch(start){
					case 1 :
						start = "진도율이 50%이상일 때";
						break;
					case 2 :
						start = "개강일부터 30일 후";
						break;
					case 3 :
						start = "개강일부터 60일 후";
					}
					
					switch(period){
					case 1 :
						period = "연수종료일까지";
						break;
					case 2 :
						period = "일주일";
					}
					
					switch(type){
					case 'gisu' :
						type_kor = "기수별";
						break;
					case 'course' :
						type_kor = "과정별";
					}
					
					sb.Append('<tr>');
					sb.Append('<td>')
					sb.Append('<a href="javascript:void(0);" onclick="autoSurveyDetail(this);">' + dataInfo.survey_title + '</a>');
					sb.Append('<input type="hidden" name="survey_seq" value = "' + dataInfo.survey_seq + '">');
					sb.Append('<input type="hidden" name="survey_type" value = "' + type + '">');
					sb.Append('<input type="hidden" name="survey_gisu" value = "' + dataInfo.autoSurveyGisu + '">');
					sb.Append('</td>');
					sb.Append('<td>' + start + '</td>');
					sb.Append('<td>' + period + '</td>');
					sb.Append('<td>' + type_kor + '</td>');
					sb.Append('</tr>');
				}
				sb.Append('</tbody>');
				sb.Append('</table>');
			}else{
				sb.Append('<button type="button" class="btn primary" onClick="searchSurvey()">설문 검색</button>');
			}
			$('#survey_span').html(sb.ToString());
		}
	});
}

function autoSurveyDetail(obj){
	var type = $(obj).siblings('input[name="survey_type"]').val();
	var data = new Object();
		data.crc_id = crc_id;
		data.autoSurveyType = type;
	
	switch(type){
	case "gisu" :
		data.page = "gisu";
		contentLoad('자동배포 설문 목록','/admin/studentManagement/studentSurveyAuto',data);
		break;
	case "course" :
		data.survey_seq = $(obj).siblings('input[name="survey_seq"]').val();
		data.page = "course";
		
		var obj = new Object();
			obj.data = JSON.stringify(data);
		contentLoad('설문조사 세부 내역','/admin/studentManagement/studentSurveyDetail',obj);
		break;
	}
}

function setSurvey(obj){
	var survey_state = $(obj).val();
	
	switch(survey_state){
	case "Y":
		var data = new Object();
		data.crc_id = crc_id;
		showAutoSurvey(data);
		break;
	case "N":
		$('#survey_span').html('');
		break;
	}
}

function searchSurvey(){
	var data = new Object();
	data.page = 'course';
	data.crc_id = crc_id;
	openLayerPopup("설문 템플릿", "/admin/common/popup/surveyTemplate", data);
}

function surveyDetail(seq){
	var data = new Object();
	data.page = 'course';
	data.survey_seq = seq;
	openLayerPopup("설문 템플릿", "/admin/common/popup/surveyTemplate", data);
}
</script>
	
<div class="content_wraper">
	<h3>학습과정관리(상세)</h3>
	<div class="tab_body">
		<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />	
			<input type="hidden" name="subCourseCode.parentCode.code" value='${search.subCourseCode.parentCode.code }' id="parentSubCourseCode">
			<input type='hidden' name='subCourseCode.code' value='${search.subCourseCode.code}' id="subCourseCodecode" />		  
			<input type='hidden' name='courseCode.code' value='${search.courseCode.code}' id="courseCodecode"/>	 		 
			<input type='hidden' name='id' value='<c:out value="${search.id }"/>'/>
			<input type='hidden' name='company.id' value='<c:out value="${search.company.id}" default="" />' />
		</form>
		<!-- //searchForm end -->
		
		<!-- actionForm 시작 -->
		<form name="actionForm" method="post">
			<!-- 교재 select는 출판사 조회 후 새로 생성 되기 때문에 저장 되어진 교재를 세팅해둠 -->
			<input type='hidden' name='mbId' value='<c:out value="${course.mainBook.id}" default="0" />' />
			<input type='hidden' name='sbId' value='<c:out value="${course.subBook.id}" default="0" />' />
			<!-- <input type='hidden' id='actionCourseCode' name='courseCode.code' value='<c:out value="${course.courseCode.code}" default="0" />' /> -->
			<!-- <input type='hidden' id='actionSubCourseCode' name='subCourseCode.code' value='<c:out value="${course.subCourseCode.code}" default="0" />' />-->
			<!-- view start -->
			
			<dl>
			       
				<dt>대분류<span class='require'>*</span></dt>
				<dd class="half">
					<select id='bigSelect'/></select>
					<select id='middleSelect'/></select>
					<select id='smallSelect'></select>
				</dd>
				
				<dt>학습영역<span class='require'>*</span></dt>
				<dd class="half">			 
					<input type="text" value="${course.courseCode.name}" name="showCourseCode" id="showCourseCode" readonly>
					<input type="hidden" value="${course.courseCode.code}" name="courseCode.code" id="actionCourseCode">
				</dd>

				<dt>과정명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" name="name" value="<c:out value='${course.name}' />" placeholder="과정명" />
				</dd>
				
				<dt>과정코드</dt>
				<dd class="half">
					<input type='text' name='id' value='<c:out value="${course.id}" default="" />' readonly="readonly" />
				</dd>				
				<dt>연수일수<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" name="selpPeriod" value="<c:out value="${course.selpPeriod}" default="0" />" />
					<span>일</span>
				</dd>
				
				<dt>이수시간</dt>
				<dd class="half">
					<input type="text" name="completeTime" value="<c:out value="${course.completeTime}" default="0" />" />
					<span>시간</span>
				</dd>
				
				<dt>복습기간</dt>
				<dd class="half">
					<input type="text" name="reviewPeriod" value="<c:out value="${course.reviewPeriod }" default="0" />" />
					<span>일</span>
				</dd>
				
				<dt>온・오프라인</dt>
				<dd class="half">
					<select id=checkOnline name="checkOnline">
						<c:choose>
						<c:when test="${course.checkOnline eq 'online'}">
						<option value="online" selected>온라인</option>
						<option value="offline">오프라인</option>
						<option value="blended">블렌디드</option>
						</c:when>
						<c:when test="${course.checkOnline eq 'offline'}">
						<option value="online">온라인</option>
						<option value="offline" selected>오프라인</option>
						<option value="blended">블렌디드</option>
						</c:when>
						<c:otherwise>
						<option value="online">온라인</option>
						<option value="offline">오프라인</option>
						<option value="blended" selected>블랜디드</option>
						</c:otherwise>
						</c:choose>
						
					</select>
				</dd>
<%-- 				<dt>협력업체</dt>
				<dd>
					<select name="company.id">
						<option value="">협력업체선택</option>
						<c:forEach items="${companyList}" var="company" varStatus="status">
							<option value='<c:out value="${company.id}" />' <c:if test="${company.id eq course.company.id}">selected</c:if>><c:out value="${company.name}" /></option>
						</c:forEach>						
					</select>
					<span>정산지급(%) : </span>
					<input type="text" name="comCal" value="<c:out value="${course.comCal}" default="" />" />
				</dd>
 --%>				
				<dt>강사</dt>
				<dd>
					<select name="teacher.id">
						<option value="">강사선택</option>
						<c:forEach items="${teacherList}" var="teacher" varStatus="status">
							<option value='<c:out value="${teacher.id}" />' <c:if test="${teacher.id eq course.teacher.id}">selected</c:if>><c:out value="${teacher.name}" /></option>
						</c:forEach>						
					</select>
					<span>강사지급(%) : </span>
					<input type="text" name="teachCal" value="<c:out value="${course.teachCal}" default="" />" />
					<span>튜터지급(%) : </span>
					<input type="text" name="tutorCal" value="<c:out value="${course.tutorCal}" default="" />" />
				</dd>
<%-- 				
				<dt>교재업체</dt>
				<dd class="half">
					<select name="bookCode.code">
						<option value="">교재업체선택</option>
						<c:forEach items="${publishList}" var="publish" varStatus="status">
							<option value='<c:out value="${publish.code}" />' <c:if test="${publish.code eq course.bookCode.code}">selected</c:if>><c:out value="${publish.name}" /></option>
						</c:forEach>
					</select>
				</dd>
 --%>
 <%-- 				
				<dt>화면표시순번</dt>
				<dd class="half">
					<input type="text" name="orderNum" value="<c:out value="${course.orderNum}" default="1" />" />
				</dd>
 --%>
<%--  				
				<dt>메인표시</dt>
				<dd>
					<select name="mainYn">
						<option value="N">표시안함</option>
						<option value="Y" <c:if test="${course.mainYn eq 'Y'}">selected</c:if>>표시함</option>
					</select>
					/
					<input type="radio" id="mainDisplay1" name='mainDisplay' value="1" checked="checked"><label for="mainDisplay1">창비추천</label>
					<input type="radio" id="mainDisplay2" name='mainDisplay' value="2" <c:if test="${'2' eq course.mainDisplay}">checked="checked"</c:if>><label for="mainDisplay2">초등추천</label>
					<input type="radio" id="mainDisplay3" name='mainDisplay' value="3" <c:if test="${'3' eq course.mainDisplay}">checked="checked"</c:if>><label for="mainDisplay3">중등추천</label>
				</dd>
 --%>				
				<dt>아이콘표시</dt>
				<dd>
					<input type="checkbox" name="iconDisplays" value="1" <c:if test="${fn:contains(course.iconDisplays, '1')}">checked="checked"</c:if> /><span>신규</span>
					<span>/</span>
					<input type="checkbox" name="iconDisplays" value="2" <c:if test="${fn:contains(course.iconDisplays, '2')}">checked="checked"</c:if> /><span>추천</span>
					<span>/</span>
					<input type="checkbox" name="iconDisplays" value="3" <c:if test="${fn:contains(course.iconDisplays, '3')}">checked="checked"</c:if> /><span>인기</span>
					<span>/</span>
					<input type="checkbox" name="iconDisplays" value="4" <c:if test="${fn:contains(course.iconDisplays, '4')}">checked="checked"</c:if> /><span>교재</span>
					<span>/</span>
					<input type="checkbox" name="iconDisplays" value="5" <c:if test="${fn:contains(course.iconDisplays, '5')}">checked="checked"</c:if> /><span>할인</span>
				</dd>
				<dt>지원서 유무 여부</dt>
				<dd class='half'>
					<input type="radio" name="applyFormYn" value="Y" <c:if test="${course.applyFormYn eq 'Y'}">checked="checked"</c:if> /><span>유</span>
					<input type="radio" name="applyFormYn" value="N" <c:if test="${course.applyFormYn eq 'N' or empty course.applyFormYn}">checked="checked" </c:if>/><span>무</span>
				</dd>			
				<dt>성적 산출 여부</dt>
				<dd class='half'>
					<input type="radio" name="recordYn" value="Y" <c:if test="${course.recordYn eq 'Y'}">checked="checked"</c:if> /><span>유</span>
					<input type="radio" name="recordYn" value="N" <c:if test="${course.recordYn eq 'N' or empty course.recordYn}">checked="checked" </c:if>/><span>무</span>
				</dd>		 				
<%-- 				<dt>학습대상</dt>
				<dd>
					<input type="checkbox" name="targetTypes" value="1" <c:if test="${fn:contains(course.targetTypes, '1')}">checked="checked"</c:if> /><span>유아</span>
					<span>/&nbsp;</span>
					<input type="checkbox" name="targetTypes" value="2" <c:if test="${fn:contains(course.targetTypes, '2')}">checked="checked"</c:if> /><span>초등</span>
					<span>/&nbsp;</span>
					<input type="checkbox" name="targetTypes" value="3" <c:if test="${fn:contains(course.targetTypes, '3')}">checked="checked"</c:if> /><span>중등</span>
					<span>/&nbsp;</span>
					<input type="checkbox" name="targetTypes" value="4" <c:if test="${fn:contains(course.targetTypes, '4')}">checked="checked"</c:if> /><span>전문직</span>
					<span>/&nbsp;</span>
					<input type="checkbox" name="targetTypes" value="5" <c:if test="${fn:contains(course.targetTypes, '5')}">checked="checked"</c:if> /><span>기타</span>
					<span>연수대상</span>
					<input type="text" name="learnTarget" value="<c:out value="${course.learnTarget}" default="" />" />
				</dd>
				 --%>
				<dt>수강금액</dt>
				<dd>
					<input type="text" name="price" value="<c:out value="${course.price}" default="0" />" /><span>원</span>
				</dd>
				<dt>마일리지 사용 여부</dt>
				<dd class='half'>
					<input type="radio" name="mileageYn" value="Y" <c:if test="${course.mileageYn eq 'Y' or empty course.mileageYn}">checked="checked"</c:if> /><span>유</span>
					<input type="radio" name="mileageYn" value="N" <c:if test="${course.mileageYn eq 'N'}">checked="checked" </c:if>/><span>무</span>
				</dd>
				<dt>설문 자동배포</dt>
				<dd class='half'>
					<input type="radio" name="surveyYn" value="Y" <c:if test="${course.surveyYn eq 'Y'}">checked="checked"</c:if> onchange="setSurvey(this)" /><span>유</span>
					<input type="radio" name="surveyYn" value="N" <c:if test="${course.surveyYn eq 'N' or empty course.surveyYn}">checked="checked" </c:if> onchange="setSurvey(this)"/><span>무</span>
					<span id="survey_span"></span>
				</dd>
				
				<dt>과정오픈일</dt>
				<dd class='half'>
					<div class='input-group date datetimepicker' id='openDate'>
	                    <input type='text' name='openDate' class='form-control' value='<c:out value="${course.openDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				
				<dt>심사신청일</dt>
				<dd class='half'>
					<div class='input-group date datetimepicker' id='appDate'>
	                    <input type='text' name='appDate' class='form-control' value='<c:out value="${course.appDate}" />' />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				
				<dt>모집인원</dt>
				<dd class='half'>
					<input type="text" name="recruit" value="<c:out value="${course.recruit}" default="0" />" /><span>'0' 제한없음</span>
				</dd>
				
				<%-- 출석고사가 있는 4학점과정의 경우 출석고사장의 출석시험교시를 알려주기 위한 항목 이라고 함. --%>
<%-- 
				<dt>시험교시</dt>
				<dd class='half'>
					<select name="examPeriod">
						<option value="1" <c:if test="${course.examPeriod eq '1'}">selected</c:if>>1교시</option>
						<option value="2" <c:if test="${course.examPeriod eq '2'}">selected</c:if>>2교시</option>
						<option value="3" <c:if test="${course.examPeriod eq '3'}">selected</c:if>>3교시</option>
					</select>
				</dd>
 --%>				
				<dt>진도체크</dt>
				<dd class='half'>
					<input type="text" name="progCheck" value="<c:out value="${course.progCheck}" default="0" />" /><span>분(차시당)</span>
				</dd>
				
				<dt>주 교재설정</dt>
				<dd class='half'>
					<select name="mainBook.id">
						<option value="0">주교재없음</option>
					</select>
					<span>가격</span>
					<input type="text" name="mainPrice" value="<c:out value="${course.mainPrice}" default="0" />" />
				</dd>
				
				<dt>부 교재설정</dt>
				<dd class='half'>
					<select name="subBook.id">
						<option value="0">교구없음</option>
					</select>
					<span>가격</span>
					<input type="text" name="subPrice" value="<c:out value="${course.subPrice}" default="0" />" />
				</dd>

                 <!--  	
				<dt>모바일서비스</dt>
				<dd class='half'>
					<input type="radio" id="mobileN" name='mobileYn' value="N" checked="checked"><label for="mobileN">서비스불가</label>
					<input type="radio" id="mobileY" name='mobileYn' value="Y" <c:if test="${'Y' eq course.mobileYn}">checked="checked"</c:if>><label for="mobileY">서비스가능</label>
				</dd>
				--> 
<%-- 
				<dt>인덱스</dt>
				<dd>
					<input type="text" name="indexUrl" value="<c:out value="${course.indexUrl}" default="" />" /><a href="<c:out value="${course.indexUrl}" default="" />">[링크]</a><span>./ 상대경로 또는 http://절대경로명 예)aa.html</span>
				</dd>
 --%>				
				<dt>맛보기링크</dt>
				<dd>
					<input type="text" name="tastingUrl" value="<c:out value="${course.tastingUrl}" default="" />" /><a href="<c:out value="${course.tastingUrl}" default="" />">[링크]</a><span>./ 상대경로 또는 http://절대경로명 예)aa.html</span>
				</dd>
				<dt>포팅여부</dt>
				<dd>
					<select name="portYn">
						<option value="N" <c:if test="${'N' eq course.portYn}">selected</c:if>>링크</option>
						<option value="Y" <c:if test="${'Y' eq course.portYn}">selected</c:if>>포팅</option>
					</select>
				</dd>
				<!-- 
				<dt>교재샘플링크</dt>
				<dd>
					<input type="text" name="sampleUrl" value="<c:out value="${course.sampleUrl}" default="" />" /><a href="<c:out value="${course.sampleUrl}" default="" />">[링크]</a><span>./guide_files/book/이하파일명 예)aa.html</span>
				</dd>
				 -->
				<dt>학습창사이즈</dt>
				<dd>
					<input type="text" name="width" value="<c:out value="${course.width}" />" /><span>Width</span> 
					<input type="text" name="height" value="<c:out value="${course.height}" />" /><span>Height</span>
					<span>※ 입력 없을 시 기본 사용자모니터 FullSize</span>
				</dd>
				<%-- 				
				<dt>수시학습기간</dt>
				<dd>
					<input type="text" name="selpPeriod" value="<c:out value="${course.selpPeriod}" default="0" />" /><span>일 ※ 수시(자율)연수인 경우 학습기간설정 (인증일로부터 00일까지)</span>
				</dd>
				 --%>
				<dt>대표이미지</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='mainImg.fileId' value='<c:out value="${course.mainImg.fileId}" default="" />' />
						<input type='hidden' class='upload_dir'	value='/upload/course/mainImg' />
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 10M, 파일종류 : IMAGE, 해상도 : 280*200px 혹은 비율 가로/세로 3:2 가 가장 적합합니다. )</span>
						</div>
						
						<c:if test="${course.mainImg ne null and course.mainImg.detailList ne null and fn:length(course.mainImg.detailList) > 0}">
							<c:forEach items="${course.mainImg.detailList}" var="file" varStatus="status">
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
<%-- 				
				<dt>중복할인허용</dt>
				<dd>
					<input type="checkbox" name="dupDisYn" value="Y" <c:if test="${'Y' eq course.dupDisYn}">checked="checked"</c:if> />
					<span>쿠폰+단체할인등 중복할인을 허용하는경우 체크바랍니다.</span>
				</dd>
 --%>				
				<dt>접수상태</dt>
				<dd class='half'>
					<select name="acceptYn">
						<option value="Y">신청가능</option>
						<option value="N" <c:if test="${'N' eq course.acceptYn}">selected</c:if>>신청불가</option>
					</select>
				</dd>
				
				<dt>과정상태</dt>
				<dd class='half'>
					<select name="useYn">
						<option value="Y">서비스</option>
						<option value="N" <c:if test="${'N' eq course.useYn}">selected</c:if>>중지</option>
					</select>
				</dd>
				
				<dt>수료조건</dt>
				<dd>
					<table>
						<thead>
							<th colspan="2">평가방법</th>
							<th>비중</th>
							<th>배점</th>
						</thead>
						<tbody>
							<tr>
								<td rowspan="3">평가 항목</td>
								<td>과제</td>
								<td><input type="text" id="compPercentQuiz" name="compPercentQuiz" value="<c:out value="${course.compPercentQuiz}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreQuiz" name="compScoreQuiz" value="<c:out value="${course.compScoreQuiz}" default="0" />" />
								<span>점</span></td>
							</tr>
							
							<tr>
								<td>시험</td>
								<td><input type="text" id="compPercentExam" name="compPercentExam" value="<c:out value="${course.compPercentExam}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreExam" name="compScoreExam" value="<c:out value="${course.compScoreExam}" default="0" />" />
								<span>점</span></td>
							</tr>
							<tr>
								<td>진도율</td>
								<td><input type="text" id="compPercentProg" name="compPercentProg" value="<c:out value="${course.compPercentProg}" default="0" />" />
					<span>%</span></td>
								<td><input type="text" id="compScoreProg" name="compScoreProg" value="<c:out value="${course.compScoreProg}" default="0" />" />
								<span>점</span></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th colspan="2">수료기준</th>
								<td colspan="2"><span>총점</span><input type="text" name="completeTotal" value="<c:out value="${course.completeTotal}" default="0" />" />
					<span>점 이상</span></td></td>
							</tr>
						</tfoot>
					</table>
				</dd>
				<dt>커리큘럼 파일</dt>
				<dd>
					<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='curriculumFile.fileId' value='<c:out value="${course.curriculumFile.fileId}" default="" />' />
						<input type='hidden' class='upload_dir' name='upload_dir'	value='/upload/board/files' />
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<c:if test="${course.curriculumFile ne null and course.curriculumFile.detailList ne null and fn:length(course.curriculumFile.detailList) > 0}">
							<c:forEach items="${course.curriculumFile.detailList}" var="file" varStatus="status">
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
			</dl>
				
			<!-- 하단 Tab Menu 시작 -->
			<div id="tabMenu">
				<div class="tab">
					<ul class="tab_head">
						<li><a href="javascript:void(0)" class="tablink on">과정목표</a></li>
						<li><a href="javascript:void(0)" class="tablink">커리큘럼</a></li>
						<li><a href="javascript:void(0)" class="tablink">기타사항</a></li>                    
						<li><a href="javascript:void(0)" class="tablink">강사진 안내</a></li>                    
						<li><a href="javascript:void(0)" class="tablink">수강자 유의사항</a></li>                    
						<li><a href="javascript:void(0)" class="tablink">컨텐츠 시스템기록</a></li>
						<!-- <li><a href="javascript:void(0)" class="tablink">모바일 과정개요</a></li> -->   
<!-- 						<li><a href="javascript:void(0)" class="tablink">페이지수정</a></li>                 				 -->
					</ul>
				</div>
				<div id="tab1" class="tab_body" style="display:block">                	
					<textarea class="editor" id="purpose_editor" name="purpose" rows="30" cols="100" style="width:100%; height:200px;">
<%-- 						<c:out value="${course.purpose}" /> --%>
		  			</textarea>
				</div>
				<div id="tab2" class="tab_body" style="display:none">                	
					<textarea class="editor" id="curriculum_editor" name="curriculum" rows="30" cols="100" style="width:100%; height:200px;">
<%-- 						<c:out value="${course.curriculum}" /> --%>
		  			</textarea>
				</div>
				<div id="tab3" class="tab_body" style="display:none">
					<textarea class="editor" id="summary_editor" name="summary" rows="30" cols="100" style="width:100%; height:200px;">
<%-- 						<c:out value="${course.summary}" /> --%>
		  			</textarea>
				</div>
				<div id="tab4" class="tab_body" style="display:none">
					<textarea class="editor" id="instructor_editor" name="instructor" rows="30" cols="100" style="width:100%; height:200px;">
<%-- 						<c:out value="${course.instructor}" /> --%>
		  			</textarea>
				</div>
				<div id="tab5" class="tab_body" style="display:none">
					<textarea class="editor" id="note_editor" name="note" rows="30" cols="100" style="width:100%; height:200px;">
<%-- 						<c:out value="${course.note}" /> --%>
		  			</textarea>
				</div>
				<div id="tab6" class="tab_body" style="display:none">
					<dl>
						<dt>과정개발자</dt>
						<dd class='half'>
							<input type='text' name='developer' value="<c:out value="${course.developer}" default="" />" />
						</dd>
						<dt>담당전화</dt>
						<dd class='half'>
							<input type='text' name='resTel' value="<c:out value="${course.resTel}" default="" />" />
						</dd>
						<dt>제작업체명</dt>
						<dd class='half'>
							<input type='text' name='comName' value="<c:out value="${course.comName}" default="" />" />
						</dd>
						<dt>업체전화</dt>
						<dd class='half'>
							<input type='text' name='comTel' value="<c:out value="${course.comTel}" default="" />" />
						</dd>
						<dt>제작일</dt>
						<dd class='half'>
							<input type='text' name='produceDate' value="<c:out value="${course.produceDate}" default="" />" />
						</dd>
						<dt>보관위치</dt>
						<dd class='half'>
							<input type='text' name='storageLoc' value="<c:out value="${course.storageLoc}" default="" />" />
						</dd>
						<dt>제작히스토리</dt>
						<dd>
							<textarea class="editor" id="history_editor" name="history" rows="10" cols="100" style="width:100%; height:200px;">
								<c:out value="${course.history}" />
				  			</textarea>
						</dd>
						<dt>특이사항 및 비고</dt>
						<dd>
							<textarea class="editor" id="remarks_editor" name="remarks" rows="10" cols="100" style="width:100%; height:200px;">
								<c:out value="${course.remarks}" />
				  			</textarea>
						</dd>
					</dl>
				</div>
<!-- 				<div id="tab6" class="tab_body" style="display:none"> -->
<!-- 					<textarea class="editor" id="mobile_summary_editor" name="mobileSummary" rows="10" cols="100" style="width:100%; height:200px;"> -->
<%-- 						<c:out value="${course.mobileSummary}" /> --%>
<!-- 		  			</textarea> -->
<!-- 				</div> -->
<!-- 				<div id="tab7" class="tab_body" style="display:none"> -->
<!-- 					<textarea class="editor" id="codeTxt_editor" name="codeTxt" rows="30" cols="100" style="width:100%; height:200px;"> -->
<%-- 						<c:out value="${course.codeTxt}" /> --%>
<!-- 		  			</textarea> -->
<!-- 				</div>		 -->
			</div>
<!-- 			기능 보완해서 수정할 것 -->
<!-- 			<div style="text-align: right;"> -->
<!-- 				<input type="button" value="미리보기" id="appBtn"> -->
<!-- 			</div> -->
			<!-- 추가 화면 -->
			<div class='cardinal_add'>
				<h4>과정별 기수지정</h4>
				
				<button type='button' id='addCardinal'>기수추가</button>
				<button type='button' id='delCardinal'>기수선택삭제</button>
				<table class="gisu_table">
					<thead>
						<tr>
							<th><input type='checkbox' id='selectCardinalAll' /></th>
							<th>기수코드</th>
							<th>기수명</th>
							<th>접수기간</th>
							<th>연수기간</th>
							<th>납부정보</th>
							<th>교육비</th>
							<th>이수구분</th>
							<th>상태구분</th>
						</tr>
					</thead>

					<tbody id='cardinalList'>
						<c:forEach items="${course.cardinalList}" var="cardinal" varStatus="status">
							<c:if test="${not empty cardinal.id}">
							<tr>
								<td><input type='checkbox' name='chkCardinalId' value='<c:out value="${cardinal.id}" />' /></td>
								<td class="content_edit">
									<input type='hidden' name='cardinalList[<c:out value="${status.index}" />].id' value='<c:out value="${cardinal.id}" />' readonly="readonly" />
									${cardinal.id}
								</td>
								<td><c:out value="${cardinal.name}" default="" /></td>
								<td><c:out value="${cardinal.appStartDate}" default="" /> ~ <c:out value="${cardinal.appEndDate}" default="" /></td>
								<td><c:out value="${cardinal.learnStartDate}" default="" /> ~ <c:out value="${cardinal.learnEndDate}" default="" /></td>
								
									<td class="pmt_table">
										<table class="pmt_tb">
											<c:forEach items="${cardinal.paymentList }" var="payment" varStatus="status2">
												<c:choose>
													<c:when test="${payment ne null }">
														<tr>
															<td><c:out value="${payment.pmtCnt}" />차<input type="hidden" name="cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].pmtCnt" value="${payment.pmtCnt}"></td>
															<td class="datepicker_td">
																<div class='input-group date datetimepicker'>
							                    					<input type='text' name='cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].pmtStartDate' class='form-control' value='<c:out value="${payment.pmtStartDate}" />' />
							                    					<span class='input-group-addon'>
							                        					<span class='glyphicon glyphicon-calendar'></span>
							                    					</span>
							                					</div>
							                				</td>
							                				<td class="datepicker_td">
																<div class='input-group date datetimepicker'>
							                    					<input type='text' name='cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].pmtEndDate' class='form-control' value='<c:out value="${payment.pmtEndDate}" />' />
							                    					<span class='input-group-addon'>
							                        					<span class='glyphicon glyphicon-calendar'></span>
							                    					</span>
							                    				</div>
							                    			</td>
							                    			<td class="divAmt_td">
																<input type='text' name='cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].pmtAmount' value='<c:out value="${payment.pmtAmount}" />' />
							                    				<input type='hidden' class="payCrcSeq_${status2.index}" name='cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].payCrcSeq' value='<c:out value="${payment.payCrcSeq}" />' />
							                    				<input type='hidden' name='cardinalList[<c:out value="${status.index}" />].paymentList[<c:out value="${status2.index}" />].gisuId' value='<c:out value="${payment.gisuId}" />' />
							                    			</td>
					                						<td>
					                							<a class="addPmtBtn btn primary" href="javascript:void();">+</a>
					                							<a class="deletePmtBtn btn primary" href="javascript:void();">-</a>
					                						</td>
				                						</tr>
													</c:when>
													<c:otherwise>
														<tr>
															<td><a class="addPmtBtn btn primary" href="javascript:void();">+</a></td>
														</tr>
													</c:otherwise>
												</c:choose>
											</c:forEach>
			                			</table>
									</td>

									<td><fmt:formatNumber type="number" value="${cardinal.price }"/></td>
								
								<td>
									<c:choose>
										<c:when test="${cardinal.complateYn eq 'N'}">미처리</c:when>
										<c:otherwise>처리</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${cardinal.useYn eq 'N'}">중지</c:when>
										<c:otherwise>서비스</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- view end -->
		</form>
		<!-- actionForm end -->
		 
		<div>
			<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
			<a id="delBtn" class="btn align_right danger" href="javascript:void();">과정삭제</a>
			<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
		</div>
		<form id="viewerForm">
			<input type="hidden" name="url" id="url" value="">
		</form>
		<iframe id="viewer" hidden="hidden">
		</iframe>
	</div>
</div>
<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />
<!-- // Navigation -->