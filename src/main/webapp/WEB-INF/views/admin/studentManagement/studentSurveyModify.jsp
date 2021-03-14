<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value="/resources/css/project/admin/surveyCreate.css"/>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
var oEditors = [];

$(function(){
	// 달력 초기화
	$('.datetimepicker').datetimepicker({
       	format				: 'YYYY-MM-DD',
        dayViewHeaderFormat	: 'YYYY년 MM월',
        locale				: moment.locale('ko'),
        defaultDate			: new Date()
    });
	
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir2", //textarea에서 지정한 id와 일치해야 합니다. 
        //SmartEditor2Skin.html 파일이 존재하는 경로
        sSkinURI: "/resources/se2/SmartEditor2Skin.html",  
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,         
            fOnBeforeUnload : function(){
                 
            }
        }, 
        fOnAppLoad : function(){
            //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
            oEditors.getById["ir2"].exec("PASTE_HTML", [""]);
        },
        fCreator: "createSEditor2"
    });
       
    //설문조사 항목 값 세팅
    var data = ${survey};
    searchList(data);
	setGisu(data);
    $("input[name=survey_start_date]").val(data.survey_start_date.substring(0,10));
    $("input[name=survey_end_date]").val(data.survey_end_date.substring(0,10));
    $("input[name=survey_title]").val(data.survey_title);
    $("textarea[name=survey_content]").text(data.survey_content);
    
    for(var i=0; i<data.question.length; i++){
    	var q = data.question[i];
    	var sb= new StringBuilder();
    	
    	switch(q.survey_type_seq){
    	case 1:
    		var answerArr = q.survey_answer_sample.split('|');
    		
    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
    		sb.Append('<div class="settingForm" style="text-align: left">');
    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 25%;" data-minimum-results-for-search="Infinity">');
    		sb.Append('<option hidden disabled>설문 유형</option>');
    		sb.Append('<option value="1" selected>객관식(다중 선택)</option>');
    		sb.Append('<option value="2">객관식(단일 선택)</option>');
    		sb.Append('<option value="3">주관식(단답형)</option>');
    		sb.Append('<option value="4">주관식(장문형)</option>');
    		sb.Append('</select>');
    		sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="deleteSurvey(this)">삭제</button>');
    		sb.Append('</div>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="questionForm">');
    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.survey_question+'">');
    		sb.Append('</div>')
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="answerForm">');
    		sb.Append('<label>답변  [  \' , \' (comma)  사용 금지 ] </label>');
    		sb.Append('<button class="btn btn-primary" style="float: right;border-radius: 5px; margin-right: 10px;" onclick="addCols(this)">항목 추가</button>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<table class="count-1">');
    		
    		for(var j=0; j<answerArr.length; j++){
        		sb.Append('<tr><td style="width: 5%;"></td>');
        		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control" value="'+ answerArr[j] +'"></td>');
        		sb.Append('<td style="width: 10%;"><button class="btn danger" style="border-radius: 5px;" onclick="deleteCol(this)">삭제</button></td></tr>');
    		}
    		sb.Append('</table>');
    		sb.Append('</div></div>');
    		$("#survey-form").append(sb.ToString());
    		$('.js-example-basic-single').select2();
    		break;
    	case 2:
    		var answerArr = q.survey_answer_sample.split('|');
    		
    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
    		sb.Append('<div class="settingForm" style="text-align: left">');
    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 25%;" data-minimum-results-for-search="Infinity">');
    		sb.Append('<option hidden disabled>설문 유형</option>');
    		sb.Append('<option value="1">객관식(다중 선택)</option>');
    		sb.Append('<option value="2" selected>객관식(단일 선택)</option>');
    		sb.Append('<option value="3">주관식(단답형)</option>');
    		sb.Append('<option value="4">주관식(장문형)</option>');
    		sb.Append('</select>');
    		sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="deleteSurvey(this)">삭제</button>');
    		sb.Append('</div>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="questionForm">');
    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.survey_question+'">');
    		sb.Append('</div>')
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="answerForm">');
    		sb.Append('<label>답변  [  \' , \' (comma)  사용 금지 ] </label>');
    		sb.Append('<button class="btn btn-primary" style="float: right;border-radius: 5px; margin-right: 10px;" onclick="addCols(this)">항목 추가</button>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<table class="count-1">');
    		
    		for(var j=0; j<answerArr.length; j++){
        		sb.Append('<tr><td style="width: 5%;"></td>');
        		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control" value="'+ answerArr[j] +'"></td>');
        		sb.Append('<td style="width: 10%;"><button class="btn danger" style="border-radius: 5px;" onclick="deleteCol(this)">삭제</button></td></tr>');
    		}
    		sb.Append('</table>');
    		sb.Append('</div></div>');
    		$("#survey-form").append(sb.ToString());
    		$('.js-example-basic-single').select2();
    		break;
    	case 3:
    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
    		sb.Append('<div class="settingForm" style="text-align: left">');
    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 25%;" data-minimum-results-for-search="Infinity">');
    		sb.Append('<option hidden disabled>설문 유형</option>');
    		sb.Append('<option value="1">객관식(다중 선택)</option>');
    		sb.Append('<option value="2">객관식(단일 선택)</option>');
    		sb.Append('<option value="3" selected>주관식(단답형)</option>');
    		sb.Append('<option value="4">주관식(장문형)</option>');
    		sb.Append('</select>');
    		sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="deleteSurvey(this)">삭제</button>');
    		sb.Append('</div>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="questionForm">');
    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.survey_question+'">');
    		sb.Append('</div>')
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="answerForm">');
    		sb.Append('</div></div>');
    		$("#survey-form").append(sb.ToString());
    		$('.js-example-basic-single').select2();
    		break;
    	case 4:
    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
    		sb.Append('<div class="settingForm" style="text-align: left">');
    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 25%;" data-minimum-results-for-search="Infinity">');
    		sb.Append('<option hidden disabled>설문 유형</option>');
    		sb.Append('<option value="1">객관식(다중 선택)</option>');
    		sb.Append('<option value="2">객관식(단일 선택)</option>');
    		sb.Append('<option value="3">주관식(단답형)</option>');
    		sb.Append('<option value="4" selected>주관식(장문형)</option>');
    		sb.Append('</select>');
    		sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="deleteSurvey(this)">삭제</button>');
    		sb.Append('</div>');
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="questionForm">');
    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.survey_question+'">');
    		sb.Append('</div>')
    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
    		sb.Append('<div class="answerForm">');
    		sb.Append('</div></div>');
    		$("#survey-form").append(sb.ToString());
    		$('.js-example-basic-single').select2();
    		break;
    	}
    } //설문조사 항목 값 세팅 끝
});  //readyFn 끝

function searchListGisu(seq){
	var sb = new StringBuilder();
	var newSeq = seq;
	var Url	= "<c:url value='/student/Counsel/searchGisuList' />";
	$.ajax({
		type	: "post",
		data 	: newSeq,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<select class="js-example-basic-single" id="gisuList" name="state"">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				
				if (i == 0) {
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
					continue;
				}
				sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
			}
			sb.Append('</select>');
			$('#gisuSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
			},
		complete:function(){
		
		}
	});
}

function searchList(data){
	var sb = new StringBuilder();
	var Url	= "<c:url value='/student/Counsel/searchCirriculumList' />";
	$.ajax({
		type	: "post",
		url		: Url,
		async	: false,
		success : function(result){
			$("#gwajeongSelector").html("");
			sb.Append('<select class="js-example-basic-single" name="state" id="gisuValue" onchange="searchListGisu(this.value);">">');
			sb.Append('<option value="" disabled selected hidden>과정 선택</option>');
			
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				
				if(map.CRC_NM == data.crc_nm) sb.Append('<option value="'+map.CRC_CLASS+ '" selected>'+map.CRC_NM+'</option>');
				else sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
			}
			sb.Append('</select>');
			$('#gwajeongSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
			}
	});
}

function setGisu(data){
	var sb = new StringBuilder();
	var Url	= "<c:url value='/student/Counsel/searchGisuList' />";
	$.ajax({
		type	: "post",
		data	: data.crc_id,
		url		: Url,
		async	: false,
		success : function(result){
			$("#gisuSelector").html("");
			sb.Append('<select class="js-example-basic-single" id="gisuList" name="state"">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				
				if(map.gisu_seq == data.gisu_id) sb.Append('<option value="'+map.gisu_seq+ '" selected>'+map.gisu_crc_nm+'</option>');
				else sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
			}
			sb.Append('</select>');
			$('#gisuSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
			},
		complete:function(){
			}
	});
}

function validation(){ 
	 var contents = $.trim(oEditors[0].getContents()); 
	 if(contents === '<p>&bnsp;</p>' || contents === '' || contents ==='<br>'){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
	 	alert("내용을 입력하세요."); 
 	 	oEditors.getById['ir2'].exec('FOCUS'); 
 		return false; 
 		}
	 return true; 
 }
 
function deleteCol(obj){
	$(obj).closest('tr').remove();
	
}
function addCols(obj){
	var sb = new StringBuilder();
	sb.Append('<tr><td style="width: 5%;"></td>');
	sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control"></td>');
	sb.Append('<td style="width: 10%;"><button class="btn danger" style="border-radius: 5px;" onclick="deleteCol(this)">삭제</button></td></tr>');
	$(obj).closest('div').find('table').append(sb.ToString());
	
}

function createSurvey(){
	var sb= new StringBuilder();
	sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
	sb.Append('<div class="settingForm" style="text-align: left">');
	sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 25%;" data-minimum-results-for-search="Infinity">');
	sb.Append('<option hidden disabled selected>설문 유형</option>');
	sb.Append('<option value="1">객관식(다중 선택)</option>');
	sb.Append('<option value="2">객관식(단일 선택)</option>');
	sb.Append('<option value="3">주관식(단답형)</option>');
	sb.Append('<option value="4">주관식(장문형)</option>');
	sb.Append('</select>');
	sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="deleteSurvey(this)">삭제</button>');
	/* sb.Append('<button class="btn danger" style="float: right; margin-left: 1%; border-radius: 5px;" onclick="cloneItem(this)">복사</button>'); */
	sb.Append('</div>');
	sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
	sb.Append('<div class="questionForm">');
	sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;">');
	sb.Append('</div>');
	sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
	sb.Append('<div class="answerForm">');
	sb.Append('</div></div>');
	$("#survey-form").append(sb.ToString());
	$('.js-example-basic-single').select2();
}

function deleteSurvey(obj){
	if (confirm('삭제하시겠습니까?')) {
		$(obj).closest('div').parent().remove();
	}
}

function answerForm(obj){
	var sb = new StringBuilder();
	switch ($(obj).val()) {
	case '1':
		sb.Append('<label>답변  [  \' , \' (comma)  사용 금지 ] </label>');
		sb.Append('<button class="btn btn-primary" style="float: right;border-radius: 5px; margin-right: 10px;" onclick="addCols(this)">항목 추가</button>');
		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		sb.Append('<table class="count-1">');
		sb.Append('<tr><td style="width: 5%;"></td>');
		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control"></td>');
		sb.Append('<td style="width: 10%;"><button class="btn danger" style="border-radius: 5px;" onclick="deleteCol(this)">삭제</button></td></tr></table>');
		break;
	case '2':
		sb.Append('<label>답변  [  \' , \' (comma)  사용 금지 ] </label>');
		sb.Append('<button class="btn btn-primary" style="float: right;border-radius: 5px;margin-right: 10px;" onclick="addCols(this)">항목 추가</button>');
		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		sb.Append('<table class="count-1">');
		sb.Append('<tr><td style="width: 5%;"></td>');
		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control"></td>');
		sb.Append('<td style="width: 10%;"><button class="btn danger" style="border-radius: 5px;" onclick="deleteCol(this)">삭제</button></td></tr></table>');
		break;
	default:
		break;
	}
	$(obj).closest('div').parent().find('.answerForm').html('');
	$(obj).closest('div').parent().find('.answerForm').append(sb.ToString());
}

function upItem(obj){
	var name = $(obj).closest('div').parent().prev().attr('class');
	
} 
/* one이 three밑으로 가기 $(".item.one").insertAfter(".item.three"); */
 
function downItem(obj){
	var name = $(obj).closest('div').parent().attr('class');
	
}

function confirmMsg(){
	if(confirm("수정하시겠습니까?")) saveItem();
}

function saveItem(){
	oEditors.getById["ir2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var crc = $("#gisuValue option:selected").text();
	var gisu = $("#gisuList option:selected").text();
	var crc_id = $("#gisuValue option:selected").val();
	var gisu_id = $("#gisuList option:selected").val();
	var startDate = $("input[name=survey_start_date]").val();
	var endDate = $("input[name=survey_end_date]").val();
	var title = $("input[name=survey_title]").val();
	var list_length = $("#survey-form").find('.login-form').length; //질문 갯수
	
	//설문 기초정보 유효성 검사 시작
	var crc_flag = true;
	var startDt_flag = true;
	var endDt_flag = true;
	var title_flag = true;
	var list_flag = true;
	
	if(crc_id == "") crc_flag = false;
	if(startDate == "") startDt_flag = false;
	if(endDate == "") endDt_flag = false;
	if(title == "") title_flag = false;
	if(list_length == 0) list_flag = false;
	
	if(!crc_flag | !startDt_flag | !endDt_flag | !title_flag | !list_flag){
		alert("항목을 입력해주세요.");
		return;
	} //설문 기초정보 유효성 검사 끝
	
	var info = new Object();
	var list = new Array();
	var data = ${survey};
	
		info.survey_seq = data.survey_seq;
		info.crc_name = crc;
		info.gisu_name = gisu;
		info.crc_id = crc_id;
		info.gisu_id = gisu_id;
		info.survey_start_date = startDate;
		info.survey_end_date = endDate;
	 	info.survey_title = title;
		info.survey_content = $("#ir2").val();
		list.push(info);
	
	 for (var i = 0; i < list_length; i++) {
		var question = $("#survey-form").find(".login-form").eq(i).find('input[name=questions]').val();
		var form = $("#survey-form").find(".login-form").eq(i).find('select[name=formList] option:selected').val();
		var forms = $("#survey-form").find(".login-form").eq(i).find('select[name=formList] option:selected').text();
		
		var answers = new Array();
		var sb = new StringBuilder();
		
		if (form == '1' || form == '2') {
			var answers = $("#survey-form").find(".login-form").eq(i).find("input[name=surveyAnswer]");			
			for (var j = 0; j < answers.length; j++) {
				 if (j != answers.length-1) {
					 sb.Append(answers[j].value + "|");	
				} else{
					sb.Append(answers[j].value);
				}
			}
		}
		
		//설문조사 질문 파트 유효성 검사 시작
		var answer_sample = sb.ToString();
		var type_flag = true;
		var question_flag = true;
		var answer_flag = true;
		
		if(form == "설문 유형") type_flag = false;
		if(question == "") question_flag = false;
		if(form == 1 || form == 2){
			if(answer_sample == "") answer_flag = false;
		}
		
		if(!type_flag | !question_flag | !answer_flag){
			alert("질문 유형과 내용을 입력해주세요.");
			return;
		} //설문조사 질문 파트 유효성 검사 끝
		
			info = new Object();
			info.survey_seq = data.survey_seq;
			info.survey_number = (i+1);
			info.survey_question = question;
			info.survey_type_seq = form;
			info.survey_type_name = forms;
			info.survey_answer_sample = answer_sample;
			list.push(info);
	}
	
	$.ajax({
		url:"<c:url value='/student/Survey/updateSurveyList'/>",
		type:		"post",
		dataType:	"json",
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify(list),
		success:function(result){
			if (result){
				alert("저장 완료");
				contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyManagement');
			}else{
				alert("저장에 실패하였습니다.");
			}
		}
	});
} //saveItem 이벤트 종료

function deleteItem(){
	if(confirm("삭제하시겠습니까?")){
		var data = ${survey};
		var survey_seq = data.survey_seq;
		
		$.ajax({
			url:"<c:url value='/student/Survey/deleteSurvey'/>",
			type:		"post",
			dataType:	"json",
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify(survey_seq),
			success:function(result){
				if (result) {
					alert("삭제 완료");
					contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyManagement');
				}else{
					alert("삭제 실패");
				}
			}
		});
	}
}

function goList(){
	var data = $("form[name='searchForm']").serialize();
	contentLoad('설문조사 내역',"<c:url value='/admin/studentManagement/studentSurveyManagement' />", data);
}

//설문조사명 중복 검사
function validTitle(obj){
	if ($(obj).val() == '' || $(obj).val() == ' ') {
		$(obj).val('');
		return;
	}
	var gisu_id = $("#gisuList option:selected").val();
	var crc_id = $("#gisuValue option:selected").val();
	if (gisu_id == '' || crc_id == '' || gisu_id == null || gisu_id === undefined || crc_id == null || crc_id === undefined) {
		alert("과정 및 기수 설정 해주세요.");
	}
	var survey_title = $(obj).val();
	var survey = ${survey};
	var data = {	"gisu_id" 		: gisu_id,
					"crc_id"		: crc_id,
					"survey_title"	: survey_title,
					"autoYn"		: 'N' ,
					"survey_seq"	: survey.survey_seq };
	$.ajax({
		type:		"post",
		url:"<c:url value='/student/Survey/validationSurveyTitle'/>",
		data: data,
		dataType:	"json",
		success:function(result){
			if (result >= 1) {
				alert("중복된 설문조사명입니다.");
				$(obj).val('');
			}
		}
	});
}
</script>

<div class="content_wraper">
	<!-- searchForm (리스트 페이지로 이동할 때 기존 검색조건을 전달하기 위해 사용) -->
	<form name="searchForm" method="post">
		<!-- 공통 -->
		<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />'> 
		<input type="hidden" name="page" value='<c:out value="${search.page}" default="" />'> <!-- 어느 페이지에서 이동해왔는지 알려주는 구분값(survey/course/auto/gisu)-->
		<input type="hidden" name="survey_seq" value='<c:out value="${search.survey_seq}" default="0" />'>
		<input type="hidden" name="crc_id" value='<c:out value="${search.crc_id }" default="" />'>
		
		<!-- 설문조사 내역 페이지 검색조건 -->
		<input type="hidden" name="gisu_id" value='<c:out value="${search.gisu_id }" default="" />'>
		<input type="hidden" name="autoYn" value='<c:out value="${search.autoYn }" default="" />'>
		<input type="hidden" name="autoSurveyGisu" value='<c:out value="${search.autoSurveyGisu}" default="" />'>
		
		<!-- 자동배포 설문 페이지 검색조건 -->
		<input type="hidden" name="autoSurveyType" value='<c:out value="${search.autoSurveyType}" default="" />'>
		<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />'>	
	</form>
	
	<h3>설문조사 수정</h3>
	 
	<dl>
			<dt>과정명<span class='require'>*</span></dt>
				<dd class="half select2_dd" id="gwajeongSelector">
					<select class="js-example-basic-single" name="state">
					</select>
				</dd>
			<dt>기수명<span class='require'>*</span></dt>
				<dd class="half select2_dd" id="gisuSelector">
					<select class="js-example-basic-single" name="state" id="gisuSelector">
					<option hidden disabled selected>기수 선택</option>
				</select>
			</dd>
			<dt>설문 시작일<span class='require'>*</span></dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='survey_start_date'>
            			<input type='text' name='survey_start_date' class='form-control' />
           				 <span class='input-group-addon'>
                			<span class='glyphicon glyphicon-calendar'></span>
            			</span>
        			</div>
				</dd>
				
			<dt>설문 종료일<span class='require'>*</span></dt>
				<dd class="half">
					<div class='input-group date datetimepicker' id='survey_end_date'>
            			<input type='text' name='survey_end_date' class='form-control' />
           				 <span class='input-group-addon'>
                			<span class='glyphicon glyphicon-calendar'></span>
            			</span>
        			</div>
				 </dd>
			<dt>설문조사명<span class='require'>*</span></dt>
				<dd>
					<input type="text" class="form-control" name="survey_title" onblur="validTitle(this)" style="width: 66%">
				</dd>
			<dt>설문조사 목적 설명 </dt>
				<dd>
					<textarea rows="30" cols="30" id="ir2" name="survey_content" style="width:50%; height:400px;min-height: 250px; "></textarea>
				</dd>
			<dt>설문조사 내용<span class='require'>*</span>
				<br>  |  ( \ + Shift )  사용 금지
			</dt>
				<dd class="select2_dd" style="overflow-y: auto;overflow-x:hidden;">
					<div id="survey-form">
					
					</div>
					<div style="width: 80%;margin-left: 10%;margin-top: 2.5%;text-align: center;">
						<button class="btn primary" style="width:100%;border-radius: 5px;" onclick="createSurvey()">질문 추가</button>
					</div>
				</dd>
			 </dl>
		<div>
			<button class="btn btn-secondary" onclick="goList()" style="border-radius: 5px;">리스트</button>
			<button class="btn btn-primary" onclick="confirmMsg()" style="border-radius: 5px;">저장</button>
			<button class="btn btn-danger" onclick="deleteItem()" style="border-radius: 5px;">삭제</button>
		</div>
</div>
