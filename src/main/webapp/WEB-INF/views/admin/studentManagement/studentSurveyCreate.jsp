<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value="/resources/css/project/admin/surveyCreate.css"/>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
var oEditors = [];
var template_title;

$(function(){
	// 달력 초기화
	$('.datetimepicker').datetimepicker({
       	format				: 'YYYY-MM-DD',
        dayViewHeaderFormat	: 'YYYY년 MM월',
        locale				: moment.locale('ko'),
        defaultDate			: new Date()
    });
	
	var start = flatpickr('#startDate',{dateFormat : 'Y-m-d', mode: "range"});
	searchList();
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
       
}); //<----------readyFn 끝

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
		}
	});
}

function searchList(){
	var sb = new StringBuilder();
	var firstGisu = 0;
	var Url	= "<c:url value='/student/Counsel/searchCirriculumList' />";
	$.ajax({
		type	: "post",
		url		: Url,
		async	: false,
		success : function(result){
			$("#gwajeongSelector").html("");
			sb.Append('<select class="js-example-basic-single" name="state" id="gisuValue" onchange="searchListGisu(this.value);">">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				 if (i == 0) {
					 firstGisu = map.CRC_SEQ;
				sb.Append('<option value="" disabled selected hidden>과정 선택</option>');
				sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
					continue;
				} 
				sb.Append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
	 		}
	 		sb.Append('</select>');
			$('#gwajeongSelector').append(sb.ToString());
			$('.js-example-basic-single').select2();
	 	}
	});
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

//템플릿 팝업창 열기
function openTemplate(){
	var data = new Object();
	data.page = 'create';
	openLayerPopup("템플릿", "/admin/common/popup/surveyTemplate", data);
}

//템플릿에 추가
function addTemplate(){
	if(template_title == "undefined")
		template_title = prompt("템플릿 제목을 입력해주세요",""); 
	else 
		template_title = prompt("템플릿 제목을 입력해주세요", template_title);
	
	oEditors.getById["ir2"].exec("UPDATE_CONTENTS_FIELD", []);
	var content = $("#ir2").val().trim(); //설문조사 목적 설명
	
	var list = new Array();
	var template = new Object();
		template.survey_template_title = template_title;
		template.survey_template_content = content;
		list.push(template);
	
	var num_of_questions = $("#survey-form").find('.login-form').length; //질문 갯수
	if(num_of_questions == 0){
		alert("질문 유형과 내용을 입력해주세요.");
		return;
	}
	
	for (var i = 0; i < num_of_questions; i++) {
		var survey_type = $("#survey-form").find(".login-form").eq(i).find('select[name=formList] option:selected').val();
		var question = $("#survey-form").find(".login-form").eq(i).find('input[name=questions]').val().trim();
		
		var type_flag = (survey_type != "설문 유형" ? true : false);
		var question_flag = (question != "" ? true : false);
		var answer_flag = true;
		
		var sb = new StringBuilder();
		if (survey_type == '1' || survey_type == '2') {
			$.each($("#survey-form").find(".login-form").eq(i).find("input[name=surveyAnswer]"), function(index, item){
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
			questions.survey_type_seq = survey_type;
			questions.survey_number = (i+1);
			questions.survey_question = question;
			questions.survey_answer_sample = answer_sample;
			list.push(questions);
	}
	//템플릿 정보 전송
	$.ajax({
		url:"<c:url value='/student/Survey/insertSurveyTemplate'/>",
		type:		"post",
		data:		JSON.stringify(list),
		dataType:	"json",
		contentType:'application/json; charset=UTF-8',
		success:function(result){
			if(result) alert("템플릿에 추가되었습니다.");
			else alert("템플릿 저장에 실패했습니다.");
		},
	});
}

//리스트로 이동
function goList(){
	var data = $("form[name='searchForm']").serialize();
	contentLoad('설문조사 내역',"<c:url value='/admin/studentManagement/studentSurveyManagement' />", data);
}

//설문 저장
function saveItem(){
	if(typeof checkBasicInfo() === 'object') {
		var list = new Array();
		list.push(checkBasicInfo());
	}else return;

	var num_of_questions = $("#survey-form").find('.login-form').length;
	for (var i = 0; i < num_of_questions; i++) {
		var survey_type = $("#survey-form").find(".login-form").eq(i).find('select[name=formList] option:selected').val();
		var question = $("#survey-form").find(".login-form").eq(i).find('input[name=questions]').val().trim();
		
		var type_flag = (survey_type != "설문 유형" ? true : false);
		var question_flag = (question != "" ? true : false);
		var answer_flag = true;
		
		var sb = new StringBuilder();
		if (survey_type == '1' || survey_type == '2') {
			$.each($("#survey-form").find(".login-form").eq(i).find("input[name=surveyAnswer]"), function(index, item){
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
		var info = new Object();
			info.survey_type_seq = survey_type;
			info.survey_number = (i+1);
			info.survey_question = question;
			info.survey_answer_sample = answer_sample;
			list.push(info);
	}
	//설문 기본정보, 질문정보 전송
	$.ajax({
		url:"<c:url value='/student/Survey/insertSurveyList'/>",
		type:		"post",
		dataType:	"json",
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify(list),
		success:function(result){
			if(result){
				alert("저장 완료");
				contentLoad('설문조사 내역','/admin/studentManagement/studentSurveyManagement');
			}else{
				alert("저장 실패");
			}
		},
	});
}

//설문저장시 호출되는 함수 : 설문 기본정보 유효성 검사
function checkBasicInfo(){
	oEditors.getById["ir2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var crc_id = $("#gisuValue option:selected").val();
	var gisu_id = $("#gisuList option:selected").val();
	var startDate = $("input[name=survey_start_date]").val();
	var endDate = $("input[name=survey_end_date]").val();
	var title = $("input[name=survey_title]").val().trim();
	var content = $("#ir2").val().trim();
	var num_of_questions = $("#survey-form").find('.login-form').length; //질문 갯수
	
	var crc_flag = (crc_id != "" ? true : false);
	var startDt_flag = (startDate != "" ? true : false);
	var endDt_flag = (endDate != "" ? true : false);
	var title_flag = (title != "" ? true : false);
	var content_flag = (content != "<br>" ? true : false); //아무것도 입력안했을 때도 <br>이 입력되어 있음
	var question_flag = (num_of_questions != 0 ? true : false);
	
	if(!crc_flag || !startDt_flag || !endDt_flag || !title_flag || !content_flag || !question_flag){
		alert("항목을 입력해주세요.");
		return;
	}
	var info = new Object();
		info.crc_id = crc_id;
		info.gisu_id = gisu_id;
		info.survey_start_date = startDate;
		info.survey_end_date = endDate;
	 	info.survey_title = title;
		info.survey_content = content;
	return info;
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
	var data = {	"gisu_id" 		: gisu_id,
					"crc_id"		: crc_id,
					"survey_title"	: survey_title,
					"autoYn"		: 'N' };
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
	
	<h3>설문조사 생성</h3>

	<dl>
		<dt>과정명<span class='require'>*</span></dt>
			<dd class="half select2_dd" id="gwajeongSelector">
				<%-- <input type="text" name='name' value='<c:out value='${cardinal.name}' default="" />'> --%>
				<select class="js-example-basic-single" name="state">
				</select>
			</dd>
		<dt>기수명<span class='require'>*</span></dt>
			<dd class="half select2_dd" id="gisuSelector">
			<select class="js-example-basic-single" name="state" id="gisuSelector">
			<option hidden disabled selected>기수 선택</option>
			</select>
					<%-- <input type="text" name='name' value='<c:out value='${cardinal.name}' default="" />'> --%>
		           <%-- 		<input type='text' name='id' value='<c:out value='${cardinal.id}' default="" />' readonly="readonly" />	<!-- Id가 존재 하면 update 없으면 insert --> --%>	
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
				<div>
					<input type="text" class="form-control" name="survey_title" onblur="validTitle(this)" placeholder="상담명을 입력" style="width: 66%">
					<a class="btn" type="button" onclick="openTemplate()">설문 템플릿</a>
				</div>
			</dd>
		
			
		<dt>설문조사 목적 설명</dt>
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
		<button class="btn btn-secondary" onclick="addTemplate()" style="border-radius: 5px;">템플릿에 추가</button>
		<button class="btn btn-secondary" onclick="goList()" style="border-radius: 5px;">리스트</button>
		<button class="btn btn-primary" onclick="saveItem()" style="border-radius: 5px;">저장</button>
	</div>
</div>
