<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function viewTemplateDetail(obj){
	$('#templateInfo').html('');
	$('#popup_surveyForm').html('');
	$('td').css("background-Color","");
	$(obj).parents('td').css("background-Color","#E0E0E0");
	
	var template_seq = $(obj).siblings('.survey_template_seq').val();
	var template_title = $(obj).html();
	var template_content = $(obj).siblings('.survey_template_content').val();
	
	var data = new Object();
	data.survey_template_seq = template_seq;
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/surveyTemplateDetail' />",
		data	: data,
		dataType : "json",
		success : function(data){
			var sb= new StringBuilder();
 			sb.Append('<label>템플릿 제목</label><br>');
 			sb.Append('<input type="text" class="form-control" id="template_title" value="' + template_title + '" style="width: 100%"><br>');
 			sb.Append('<label>설문조사 목적</label><br>');
 			sb.Append('<textarea rows="30" cols="30" id="template_content" style="width:100%; height:80px; min-height:80px;">' + template_content + '</textarea><br>')
 			$("#templateInfo").append(sb.ToString());
			
			for(var i=0; i<data.length; i++){
				sb.empty();
		    	var q = data[i];
		    	switch(q.SURVEY_TYPE_SEQ){
		    	case 1:
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="margin-left: 5%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 45%;" data-minimum-results-for-search="Infinity">');
		    		sb.Append('<option value="1" selected>객관식(다중 선택)</option>');
		    		sb.Append('</select>');
		    		sb.Append('</div>');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="questionForm">');
		    		sb.Append('<label>질문</label>');
		    		sb.Append('<input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<table class="count-1">');
		    		
		    		for(var j=0; j<answerArr.length; j++){
		        		sb.Append('<tr><td style="width: 5%;"></td>');
		        		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control" value="'+ answerArr[j] +'"></td>');
		    		}
		    		sb.Append('</table>');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 2:
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="margin-left: 5%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 45%;" data-minimum-results-for-search="Infinity">');
		    		sb.Append('<option value="2" selected>객관식(단일 선택)</option>');
		    		sb.Append('</select>');
		    		sb.Append('</div>');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="questionForm">');
		    		sb.Append('<label>질문</label>');
		    		sb.Append('<input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<table class="count-1">');
		    		
		    		for(var j=0; j<answerArr.length; j++){
		        		sb.Append('<tr><td style="width: 5%;"></td>');
		        		sb.Append('<td style="width: 85%;"><input type="text" name="surveyAnswer" class="form-control" value="'+ answerArr[j] +'"></td>');
		    		}
		    		sb.Append('</table>');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 3:
		    		sb.Append('<div class="login-form" style="margin-left: 5%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 45%;" data-minimum-results-for-search="Infinity">');
		    		sb.Append('<option value="3" selected>주관식(단답형)</option>');
		    		sb.Append('</select>');
		    		sb.Append('</div>');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="questionForm">');
		    		sb.Append('<label>질문</label>');
		    		sb.Append('<input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 4:
		    		sb.Append('<div class="login-form" style="margin-left: 5%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 45%;" data-minimum-results-for-search="Infinity">');
		    		sb.Append('<option value="4" selected>주관식(장문형)</option>');
		    		sb.Append('</select>');
		    		sb.Append('</div>');
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="questionForm">');
		    		sb.Append('<label>질문</label>');
		    		sb.Append('<input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	}//swich-case 끝
		    }//for문 끝
		    sb.empty();
			sb.Append('<button class="btn btn-primary" style="margin-left: 5%; margin-top: 2.5%; border-radius: 5px;" onclick="updateTemplate(this)">수정</button>');
			sb.Append('<button class="btn btn-primary" style="margin-left: 1%; margin-top: 2.5%; border-radius: 5px;" onclick="deleteTemplate('+ template_seq +')">삭제</button>');
			
			switch("${page}"){
			case 'create': //설문생성 페이지에서 팝업창 오픈한 경우
				sb.Append('<button class="btn btn-danger pull-right" style="margin-top: 2%; border-radius: 5px;" onclick="applyTemplate(this)">적용</button><br>');
				break;
			case 'course': //과정 상세페이지에서 오픈한 경우 
				sb.Append('<input type="radio" name="where" value="eLearning" onchange="setAutoSurvey(this)"><span>이러닝</span>');
				sb.Append('<input type="radio" name="where" value="offline" onchange="setAutoSurvey(this)"><span>센터 과정</span>');
				sb.Append('<button class="btn btn-danger pull-right" style="margin-top: 2%; border-radius: 5px;" onclick="checkAutoTitle('+ template_seq +')">자동배포</button><br>');
				sb.Append('<div id="autoSurvey_option"></div>');
				sb.Append('<div id="autoSurvey_gisu"></div>');
				break;
			}
			sb.Append('<input type="hidden" class="survey_template_seq" value="' + template_seq + '">');
			sb.Append('<input type="hidden" class="survey_template_title" value="' + template_title + '">');
			sb.Append('<input type="hidden" class="survey_template_content" value="' + template_content + '">');
			$("#popup_surveyForm").append(sb.ToString());
		}
	});
}

// 이러닝・센터과정 선택에 따른 화면 표시
function setAutoSurvey(obj){
	var where = $(obj).val();
	var sb = new StringBuilder();
	
	switch(where){
	case 'eLearning' :
		sb.Append('설문배포일 : 진도율이 50% 이상일 때<br>');
		sb.Append('설문마감일 : 연수 종료일');
		sb.Append('<input type="hidden" name="autoSurveyStart" value="1">');
		sb.Append('<input type="hidden" name="autoSurveyPeriod" value="1">');
		sb.Append('<input type="hidden" name="autoSurveyType" value="course">');
		$('#autoSurvey_option').html(sb.ToString());
		break;
	case 'offline' :
		var sb = new StringBuilder();
		sb.Append('<select name="survey_startDate">');
	    sb.Append('<option value="0">설문시작일 선택</option>');
		sb.Append('<option value="2">개강일부터 30일 후</option>');
		sb.Append('<option value="3">개강일부터 60일 후</option>');
		sb.Append('</select>');
		sb.Append('<select name="survey_period">');
		sb.Append('<option value="0">설문기간 선택</option>');
		sb.Append('<option value="2">일주일</option>');
		sb.Append('<option value="1">연수종료일까지</option>');
		sb.Append('</select><br>');
		sb.Append('<lable>통계방법 선택 </lable>')
		sb.Append('<input type="radio" name="survey_type" value="gisu" onchange="setGisuStart(this)"><span>기수별</span>');
		sb.Append('<input type="radio" name="survey_type" value="course" onchange="setGisuStart(this)"><span>과정별</span>');
		$('#autoSurvey_option').html(sb.ToString());
		break;
	}
}

// 기수별 통계 선택시 시작 기수 설정
function setGisuStart(obj){
	var stat = $(obj).val();
	var sb = new StringBuilder();
	
	switch(stat){
	case 'gisu' :
		$.ajax({
			type	: "post",
			url		: "<c:url value='/student/Survey/selectGisuList' />",
			data	: { crc_id : "${crc_id}" },
			dataType : "json",
			success : function(result){
				if(result.length > 0){
					sb.Append('<select name="survey_gisu">');
					sb.Append('<option value="0">자동배포 시작 기수 선택</option>');
					
					for(var i=0; i < result.length; i++){
						sb.Append('<option value="' + result[i].GISU_ID + '">' + result[i].GISU_NM + '</option>');
					}
					sb.Append('</select>');
					$('#autoSurvey_gisu').html(sb.ToString());
				}else{
					alert("과정에 연결된 기수가 없습니다.\n기수 지정을 해주세요.");
					$('input:radio[name="survey_type"][value="course"]').prop('checked',true);
				}
			}
		});
		break;
	case 'course' :
		$('#autoSurvey_gisu').html('');
		break;
	}
}

// 자동설문 배포 전, 이미 등록된 설문인지 확인
function checkAutoTitle(templateSeq){
	var data = new Object();
	data.crc_id = "${crc_id}";
	data.survey_title = $('#template_title').val();
	data.survey_content = $('#template_content').val();
	data.survey_template_seq = templateSeq;
	data.autoYn = 'Y';
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/validationSurveyTitle'/>",
		data	: data,
		dataType : "json",
		success : function(result){
			if (result >= 1) {
				alert("중복된 설문조사명입니다.");
			}else{
				regAutoSurvey(data);
			}
		}
	});
}

// 자동설문 배포
function regAutoSurvey(data){
	// 설문 제목, 내용, 질문 등 유효성 검사 필요 *********************
	
	
	var where = $('input:radio[name="where"]:checked').val();
	
	switch(where){
	case 'eLearning' :
		data.autoSurveyStart = $('input[name="autoSurveyStart"]').val();
		data.autoSurveyPeriod = $('input[name="autoSurveyPeriod"]').val();
		data.autoSurveyType = $('input[name="autoSurveyType"]').val();
		break;
	case 'offline' :
		//유효성 검사 후 데이터 저장
		var start = $('select[name="survey_startDate"]').val();
		var period = $('select[name="survey_period"]').val();
		var type = $('input:radio[name="survey_type"]:checked').val();
		
		if(start == 0 || period == 0 || type == undefined){
			alert("세부항목을 선택해주세요.");
			return;
		}
		if(type == "gisu"){
			var gisu = $('select[name="survey_gisu"]').val();
			if(gisu == 0){
				alert("세부항목을 선택해주세요.");
				return;
			}else{
				data.autoSurveyGisu = gisu;
			}
		}
		data.autoSurveyStart = start;
		data.autoSurveyPeriod = period;
		data.autoSurveyType = type;
		break;
	default :
		alert('이러닝/센터과정 여부를 선택해주세요.');
		return;
	}
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/regAutoSurvey' />",
		data	: data,
		dataType : "json",
		success : function(result){
			if(result){
				alert("설문 자동배포가 등록되었습니다.");
				
				var obj = {crc_id : data.crc_id};
				showAutoSurvey(obj); /* 부모창(trainProcessEdit.jsp)에 있는 함수 호출해, 부모창에 자동배포된 설문 리스트 보여준다. */
				closeLayerPopup();
			}else{
				alert("등록 실패");
			}
		}
	});
}

function applyTemplate(obj){
	template_seq = $(obj).siblings('.survey_template_seq').val();
	template_content = $(obj).siblings('.survey_template_content').val();
	
 	$("textarea[name=survey_content]").val(template_content);
	$('#survey-form').html('');
	
	var data = new Object();
	data.survey_template_seq = template_seq
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/surveyTemplateDetail' />",
		data	: data,
		dataType : "json",
		success : function(data){
			for(var i=0; i<data.length; i++){
		    	var sb= new StringBuilder();
				var q = data[i];
		    	
		    	switch(q.SURVEY_TYPE_SEQ){
		    	case 1:
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
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
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
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
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#survey-form").append(sb.ToString());
		    		$('.js-example-basic-single').select2();
		    		break;
		    	case 4:
		    		sb.Append('<div class="login-form" style="width: 80%;margin-left: 10%;margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#survey-form").append(sb.ToString());
		    		$('.js-example-basic-single').select2();
		    		break;
		    	}
		    }
		}
	});
	closeLayerPopup();
}

function updateTemplate(obj){
	template_seq = $(obj).siblings('.survey_template_seq').val();
	template_title = $(obj).siblings('.survey_template_title').val();
	template_content = $(obj).siblings('.survey_template_content').val();
	
	var sb= new StringBuilder();
	sb.Append('<div class="templateSection templateModify">');
	sb.Append('<dl>');
	sb.Append('<dt>템플릿 제목</dt>');
	sb.Append('<dd><input type="text" class="form-control" id="template_title" value="' + template_title + '" onblur="checkTemplateTitle(this)" style="width: 66%"></dd>');
	sb.Append('<dt>설문조사<br>목적 설명</dt>');
	sb.Append('<dd>');
	sb.Append('<textarea rows="30" cols="30" id="template_content" style="width:550px; height:80px; min-height:80px; ">' + template_content + '</textarea>')
	sb.Append('</dd>');
	sb.Append('</dl>');
	sb.Append('<div id="popup_surveyForm">');
	sb.Append('</div>');
	sb.Append('</div>');
	$(".dd-flex").html(sb.ToString());
	
	var data = new Object();
	data.survey_template_seq = template_seq;
	
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/surveyTemplateDetail' />",
		data	: data,
		dataType : "json",
		success : function(data){
			for(var i=0; i<data.length; i++){
				sb.empty();
				var q = data[i];
		    	
		    	switch(q.SURVEY_TYPE_SEQ){
		    	case 1:
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="width: 100%; margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 40%;" data-minimum-results-for-search="Infinity">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
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
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 2:
		    		var answerArr = q.SURVEY_ANSWER_SAMPLE.split('|');
		    		
		    		sb.Append('<div class="login-form" style="width: 100%; margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 40%;" data-minimum-results-for-search="Infinity">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
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
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 3:
		    		sb.Append('<div class="login-form" style="width: 100%; margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 40%;" data-minimum-results-for-search="Infinity">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	case 4:
		    		sb.Append('<div class="login-form" style="width: 100%; margin-top: 2.5%;">');
		    		sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
		    		sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 40%;" data-minimum-results-for-search="Infinity">');
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
		    		sb.Append(' <label>질문</label><input type="text" name="questions" class="form-control" style="width: 100%;" value="'+q.SURVEY_QUESTION+'">');
		    		sb.Append('</div>')
		    		sb.Append('<hr style="width: 100%;color: white;size: 10px;">');
		    		sb.Append('<div class="answerForm">');
		    		sb.Append('</div></div>');
		    		$("#popup_surveyForm").append(sb.ToString());
		    		$('.js-example-basic-single').select2({
		    			dropdownParent: $('.popup')
		    		});
		    		break;
		    	}
		    }
		    sb.empty();
		    sb.Append('<div style="width: 100%;margin-top: 2.5%;text-align: center;">');
		    sb.Append('	<button class="btn primary" style="width:100%;border-radius: 5px;" onclick="addQuestion()">질문 추가</button>');
		    sb.Append('</div>');
		    sb.Append('<div style="width: 100%;margin-top: 2.5%;">');
		    sb.Append('<button class="btn btn-secondary" onclick="templateList()" style="border-radius: 5px;">리스트</button>');
		    sb.Append('<button class="btn btn-primary" onclick="saveTemplate(' + template_seq + ')" style="border-radius: 5px; margin-left: 0.5%">저장</button>');
		    sb.Append('</div>');
		    $(".templateModify").append(sb.ToString());
		}
	});
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

function addQuestion(){
	var sb= new StringBuilder();
	sb.Append('<div class="login-form" style="width: 100%; margin-top: 2.5%;">');
	sb.Append('<div class="settingForm select2_dd" style="text-align: left">');
	sb.Append('<select class="js-example-basic-single" name="formList" onchange="answerForm(this)" style="width: 40%;" data-minimum-results-for-search="Infinity">');
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
	$("#popup_surveyForm").append(sb.ToString());
	$('.js-example-basic-single').select2({
		dropdownParent: $('.popup')
	});
}

function saveTemplate(template_seq){
	var template_content = $('#template_content').val().trim();
	var template_title = $('#template_title').val().trim();
	if(template_title == ""){
		alert("템플릿 제목을 입력해주세요.");
		return; 
	} 
	
	var list = new Array();
	var template = new Object();
		template.survey_template_seq = template_seq;
		template.survey_template_title = template_title;
		template.survey_template_content = template_content;
		list.push(template);
	
	var num_of_questions = $("#popup_surveyForm").find('.login-form').length; //질문 갯수
	if(num_of_questions == 0){
		alert("질문 유형과 내용을 입력해주세요.");
		return;
	}
	
	for (var i = 0; i < num_of_questions; i++) {
		var survey_type = $("#popup_surveyForm").find(".login-form").eq(i).find('select[name=formList] option:selected').val();
		var question = $("#popup_surveyForm").find(".login-form").eq(i).find('input[name=questions]').val().trim();
		
		var type_flag = (survey_type != "설문 유형" ? true : false);
		var question_flag = (question != "" ? true : false);
		var answer_flag = true;
		
		var sb = new StringBuilder();
		if (survey_type == '1' || survey_type == '2') {
			$.each($("#popup_surveyForm").find(".login-form").eq(i).find("input[name=surveyAnswer]"), function(index, item){
				if(item.value.trim() == ""){
					answer_flag = false;
					return false;
				}sb.Append(item.value.trim() + "|");
			});
		}
		var tempStr = sb.ToString();
		var answer_sample = tempStr.substring(0, tempStr.length-1);
		
		if(!type_flag | !question_flag | !answer_flag){
			alert("질문 유형과 내용을 입력해주세요.");
			return;
		}
		
		var questions = new Object();
			questions.survey_template_seq = template_seq;
			questions.survey_type_seq = survey_type;
			questions.survey_number = (i+1);
			questions.survey_question = question;
			questions.survey_answer_sample = answer_sample;
			list.push(questions);
	}
	
	$.ajax({
		url:"<c:url value='/student/Survey/updateSurveyTemplate'/>",
		type:		"post",
		data:		JSON.stringify(list),
		dataType:	"json",
		contentType:'application/json; charset=UTF-8',
		success:function(result){
			if(result){
				alert("템플릿이 수정되었습니다.");
				templateList();
			}
			else alert("템플릿 수정에 실패했습니다.");
		},
	});
}

function deleteTemplate(template_seq){
	if(confirm("템플릿을 삭제하시겠습니까?")){
		var data = new Object();
		data.survey_template_seq = template_seq
		
		$.ajax({
			type	: "post",
			url		: "<c:url value='/student/Survey/deleteSurveyTemplate' />",
			data	: data,
			dataType : "json",
			success : function(result){
				if(result){
					alert("템플릿이 삭제되었습니다.");
					templateList();
				}
				else alert("템플릿 삭제에 실패했습니다.");
			}
		});
	}
}

function templateList(){
	$.ajax({
		type	: "post",
		url		: "<c:url value='/student/Survey/selectSurveyTemplate' />",
		dataType : "json",
		success : function(list){
			var sb= new StringBuilder();
			sb.Append('<div class="templateSection templateList">');
			sb.Append('<table class="table-hover" style="border-collapse: collapse;">');
			sb.Append('<thead>');
			sb.Append('<tr>');
			sb.Append('<th>#</th>');
			sb.Append('<th>템플릿 제목</th>');
			sb.Append('</tr>');
			sb.Append('</thead>');
			sb.Append('<tbody id="templateListBody">');
			
			for(var i=0; i<list.length; i++){
				var template = list[i];
				sb.Append('<tr>');
				sb.Append('	<td>' + (i+1) + '</td>');
				sb.Append('	<td>');
				sb.Append('		<a onclick="viewTemplateDetail(this)">' + template.survey_template_title + '</a>');
				sb.Append('		<input type="hidden" class="survey_template_seq" value="' + template.survey_template_seq + '" />');
				sb.Append('		<input type="hidden" class="survey_template_content" value="' + template.survey_template_content + '" />');
				sb.Append('	</td>');
				sb.Append('<tr>')
			}
			sb.Append('</tbody>');
			sb.Append('</table>');
			sb.Append('</div>');
			sb.Append('<div class="ccontent templateDetail" style="overflow-y: auto;overflow-x:hidden;">');
			sb.Append('<div id="templateInfo" style="margin-left: 5%;margin-top: 2.5%;"></div>');
			sb.Append('<div id="popup_surveyForm"></div>');
			sb.Append('<div style="width: 80%;margin-left: 10%;margin-top: 2.5%;text-align: center;"></div>');
			sb.Append('</div>');
			$('.dd-flex').html(sb.ToString());
		}
	});
}

function checkTemplateTitle(obj){
	
}
</script>

<div class="content_wraper" style="height: 740px; overflow: auto;">
	<div class="tab_body">
		<div class="ccontent dd-flex">
			<div class="templateSection templateList">
				<table class="table-hover" style="border-collapse: collapse;">
					<thead>
						<tr>
							<th>#</th>
							<th>템플릿 제목</th>
						</tr>
					</thead>
					<tbody id="templateListBody">
						<c:forEach var="template" items="${templateList }" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>
									<a onclick="viewTemplateDetail(this)">${template.survey_template_title }</a>
									<input type="hidden" class="survey_template_seq" value="${template.survey_template_seq }" />
									<input type="hidden" class="survey_template_content" value="${template.survey_template_content }" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="ccontent templateDetail" style="overflow-y: auto;overflow-x:hidden;">
				<div id="templateInfo" style="margin-left: 5%;margin-top: 2.5%;">
				
				</div>
				<div id="popup_surveyForm">
				
				</div>
				<div style="width: 80%;margin-left: 10%;margin-top: 2.5%;text-align: center;">
				
				</div>
			</div>
		</div>
	</div>
</div>