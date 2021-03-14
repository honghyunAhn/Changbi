<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="<c:url value="/resources/css/project/admin/surveyDetail.css"/>" rel="stylesheet" type="text/css">
<script type="text/javascript">
var result = ${detail};
var answer_nmList = new Array();
var answer_idList = new Array();

$(document).ready(function (){
	setSurveyDetail();
});

//설문내용 세팅 : 질문, 응답내용, 응답자 등
function setSurveyDetail(){
	if(result.length == 0){
		alert("설문 내용이 없습니다.");
		return;
	}
	
	var sb = new StringBuilder();
	sb.Append('<div class="completionWrap d-flex">');
	
	for(var i=0; i<result.length; i++){
		var question = result[i];
		var type_seq = question.survey_type_seq;
		sb.Append('<div class="completion">');
		sb.Append('<div class="sub-section d-flex">');
		sb.Append('<div class="titleBar-hdr"><h6>' + question.survey_number + ". " + question.survey_question + '</h6></div>');
		sb.Append('</div>');
		
		switch(type_seq){
		case 1: // 설문 type1 : 객관식  설문 (중복선택)
			var arr = question.survey_answer_sample.split('|');
			var userList = question.answer_userList;
			var idList = question.answer_idList;
			var answer_nm = new Array();
			var answer_id = new Array();
			var total_cnt = "${info.TOTAL_CNT }"; // 설문 대상자 수
			sb.Append('<div class="type-hdr">중복선택 : 응답자 ${info.COMPLETE_CNT }명</div>');
			sb.Append('<div class="surveyAnswer_div type1-2-answerDiv">');
			
			for(var j=0; j<arr.length; j++){
				var answer_cnt = userList[j].length;
				if(total_cnt == 0) var share = 0;
				else
					var share = answer_cnt/total_cnt * 100;
				
				sb.Append('<div class="graphWrap">');
				sb.Append('<ul class="graphGroup d-flex">');
				sb.Append('<li class="condition">' + arr[j] + '</li>');
				sb.Append('<li class="graph">');
				sb.Append('<div class="graph graph1" style="width: calc(' + share + '%);"></div>');
				sb.Append('</li>')
				sb.Append('<li class="scoreWrap progress">');
				sb.Append('<a href="javascript:void(0);" onclick="stuList(this, '+ i +', '+ j +');">' + answer_cnt + '표</a>');
				sb.Append('</li></ul></div>')
				answer_nm[j] = userList[j];
				answer_id[j] = idList[j];
			}
			answer_nmList[i] = answer_nm;
			answer_idList[i] = answer_id;
			sb.Append('</div>');
			sb.Append('<div class="stuList">');
			sb.Append('<div class="titleBar-hdr"></div>');
			sb.Append('<div class="stuWrap">');
			sb.Append('</div>');
			sb.Append('</div>');
			sb.Append('</div>');
			break;
			
		case 2: // 설문 type2 : 객관식  설문 (단일선택)
			var arr = question.survey_answer_sample.split('|');
			var userList = question.answer_userList;
			var idList = question.answer_idList;
			var answer_nm = new Array();
			var answer_id = new Array();
			var total_cnt = "${info.TOTAL_CNT }"; //설문 대상자 수
			var noAnswer_cnt = total_cnt;		//미응답자 수 (초기값 설정)
			sb.Append('<div class="surveyAnswer_div type1-2-answerDiv">');
			
			for(var j=0; j<arr.length; j++){
				var answer_cnt = userList[j].length;
				if(total_cnt == 0) var share = 0;
				else
					var share = answer_cnt/total_cnt * 100;
				
				sb.Append('<div class="graphWrap">');
				sb.Append('<ul class="graphGroup d-flex">');
				sb.Append('<li class="condition">' + arr[j] + '</li>');
				sb.Append('<li class="graph">');
				sb.Append('<div class="graph graph1" style="width: calc(' + share + '%);"></div>');
				sb.Append('</li>')
				sb.Append('<li class="scoreWrap progress">');
				sb.Append('<a href="javascript:void(0);" onclick="stuList(this, '+ i +', '+ j +');">' + answer_cnt + '표</a> (' + (share !=0 ? share.toFixed(1) : 0) + '%)');
				sb.Append('</li></ul></div>')
				noAnswer_cnt -= answer_cnt;
				answer_nm[j] = userList[j];
				answer_id[j] = idList[j];
			}
			
			if(noAnswer_cnt > 0){
				var share = noAnswer_cnt/total_cnt * 100;
				
				sb.Append('<div class="graphWrap">');
				sb.Append('<ul class="graphGroup d-flex">');
				sb.Append('<li class="condition">미응답</li>');
				sb.Append('<li class="graph">');
				sb.Append('<div class="graph graph1" style="width: calc(' + share + '%);"></div>');
				sb.Append('</li>')
				sb.Append('<li class="scoreWrap progress">');
				sb.Append('<a href="javascript:void(0);" onclick="noAnswer_StuList(this);">' + noAnswer_cnt + '명</a> (' + (share !=0 ? share.toFixed(1) : 0) + '%)');
				sb.Append('</li></ul></div>')
			}
			sb.Append('</div>')
			sb.Append('<div class="stuList">');
			sb.Append('<div class="titleBar-hdr"></div>');
			sb.Append('<div class="stuWrap">');
			sb.Append('</div>');
			sb.Append('</div>');
			sb.Append('</div>');
			answer_nmList[i] = answer_nm;
			answer_idList[i] = answer_id;
			break;
			
		case 3: // 설문 type3 : 주관식 설문 (단답형)
		case 4: // 설문 type4 : 주관식 설문 (서술형)
			sb.Append('<div class="surveyAnswer_div">');
			sb.Append('<button type="button" class="btn primary pull-right" onClick="showUserName(this)">응답자 보기</button>');
			sb.Append('<table class="type3-4-table">');
			sb.Append('<th class="longAnswer_th">답 변</th><th>이름</th><th>아이디</th>');
			sb.Append('<tr>');
			sb.Append('</tr>');
			
			var answerList = question.answerList;
			if(answerList.length > 0){
				for(var j=0; j<answerList.length; j++){
					sb.Append('<tr>');
					sb.Append('<td class="type3-4-td">' + answerList[j].survey_answer + '</td>');
					sb.Append('<td>' + answerList[j].user_nm + '</td>');
					sb.Append('<td>' + answerList[j].user_id + '</td>');
					sb.Append('</tr>');
				}
			}else{
				sb.Append('<tr><td colspan=3>응답자가 없습니다.</td></tr>');
			}
			sb.Append('</table>');
			sb.Append('</div>');
			sb.Append('</div>');
			break;
		}
	}
	sb.Append('</div>');
	$('#resultBody').append(sb.ToString());
}

// 객관식 답변 응답자 리스트
function stuList(obj, i, j){
	var sb = new StringBuilder();
	var nameArr = answer_nmList[i][j];
	var idArr = answer_idList[i][j];
	var answer = $(obj).parents('.graphGroup').find('.condition').html();
	
	sb.Append('<h6>' + answer + ' 선택</h6>');
	sb.Append('<table>');
	sb.Append('<tr>');
	sb.Append('<th class="stuList_no">No</th>');
	sb.Append('<th class="stuList_nm">이름</th>');
	sb.Append('<th class="stuList_id">ID</th>');
	sb.Append('</tr>');
	
	if(nameArr.length > 0){
		for(var k=0; k<nameArr.length; k++){
			sb.Append('<tr>');
			sb.Append('<td>' + (k+1) + '</td>');
			sb.Append('<td>' + nameArr[k] + '</td>');
			sb.Append('<td>' + idArr[k] + '</td>');
			sb.Append('</tr>');
		}
	}else{
		sb.Append('<tr>');
		sb.Append('<td colspan=3>응답자가 없습니다.</td>')
		sb.Append('</tr>');
	}
	sb.Append('</table>');
	$(obj).parents('.surveyAnswer_div').next('div').html(sb.ToString());
}

// 설문 미응답자 리스트 (객관식 설문 그래프 바에서 미응답 클릭시)
function noAnswer_StuList(obj){
	var Url	= "<c:url value='/student/Survey/noAnswerList' />";
	var data = new Object();
	data.survey_seq = $('#survey_seq').val();
	data.crc_id = $('#crc_id').val();
	data.gisu_id = $('#gisu_id').val();
	
	$.ajax({
		url		: Url,
		type	: "post",
		data 	: data,
		dataType: "json",
		success : function(result){
			var sb = new StringBuilder();
			sb.Append('<h6>미응답</h6>')
			sb.Append('<table>');
			sb.Append('<tr>');
			sb.Append('<th class="stuList_no">No</th>');
			sb.Append('<th class="stuList_nm">이름</th>');
			sb.Append('<th class="stuList_id">ID</th>');
			sb.Append('</tr>');
			
			for(var i=0; i<result.length; i++){
				sb.Append('<tr>');
				sb.Append('<td>' + (i+1) + '</td>');
				sb.Append('<td>' + result[i].USER_NM + '</td>');
				sb.Append('<td>' + result[i].USER_ID + '</td>');
				sb.Append('</tr>');
			}
			sb.Append('</table>');
			$(obj).parents('.surveyAnswer_div').next('div').html(sb.ToString());
		},
	});
}

// 주관식 설문 응답자 보여주기, 숨기기
function showUserName(obj){
	var btnName = $(obj).html();
	
	if(btnName == '응답자 보기'){
		$(obj).next('table').find('th').css("display","table-cell");
		$(obj).next('table').find('td').css("display","table-cell");
		$(obj).html('응답자 숨기기');
	
	}else if(btnName == '응답자 숨기기'){
		$(obj).next('table').find('th:nth-child(n+2)').css("display","none");
		$(obj).next('table').find('td:nth-child(n+2)').css("display","none");
		$(obj).html('응답자 보기');
	}
}

// 설문 배포 취소
function cancelSurvey(seq){
	var Url	= "<c:url value='/student/Survey/cancelSurvey' />";
	if(!confirm("설문 배포를 취소하시겠습니까?")) return;
	
	var flag = false;
	var complete_cnt = $('#complete_cnt').val();
	if( complete_cnt > 0){
		flag = confirm(complete_cnt + '명의 설문 답변이 존재합니다.\n답변 내용을 삭제하시겠습니까?');
	}
	
	var data = new Object();
	data.survey_seq = seq;
	data.flag = flag;
	
	$.ajax({
		url		: Url,
		type	: "post",
		data 	: JSON.stringify(data),
		dataType: "json",
		contentType: 'application/json; charset=UTF-8',
		success : function(result){
			if(result){
				alert('설문배포취소 완료');
				goList('survey');
			}else alert('설문배포취소 실패');
		},
	});
}

// 자동설문 배포 취소
function cancelAutoSurvey(seq){
	var Url	= "<c:url value='/student/Survey/cancelAutoSurvey' />";
	var flag = false;
	var complete_cnt = $('#complete_cnt').val();
	if( complete_cnt > 0){
		flag = confirm(complete_cnt + '명의 설문 답변이 존재합니다.\n자동설문 배포가 취소되면 모두 삭제됩니다.');
	}else{
		flag = confirm('자동배포를 취소하시겠습니까?');
	}
	if(!flag) return;
	var data = { 'survey_seq' : seq };
	
	$.ajax({
		url		: Url,
		type	: "post",
		data	: data,
		dataType : "json",
		success : function(result){
			if(result){
				alert('설문배포취소 완료');
				goCourse();
			}else alert('설문배포취소 실패');
		},
	});
}

// 설문 응답.미응답 명단 팝업
function surveyCompleteList(){
	var data = new Object();
	data.survey_seq = $('#survey_seq').val();
	data.crc_id = $('#crc_id').val();
	data.gisu_id = $('#gisu_id').val();
	openLayerPopup("설문 응답여부", "/admin/common/popup/surveyCompleteList", data);
}

// 설문내역 리스트로 이동
function goList(str){
	var data = $("form[name='searchForm']").serialize();
	
	switch(str){
	case "survey" : //설문조사 리스트 페이지로 이동
		contentLoad('설문조사 내역',"<c:url value='/admin/studentManagement/studentSurveyManagement' />", data);
		break;
	case "course" : //과정상세 페이지로 이동
		var obj = {id : $('#crc_id').val()};
		contentLoad("학습과정관리", "<c:url value='/admin/course/trainProcessEdit' />", obj);
		break;
	case "auto" : //자동배포 설문목록 페이지로 이동
		contentLoad('설문조사 내역',"<c:url value='/admin/studentManagement/studentSurveyAuto' />", data);
		break;
	case "gisu" : //설문조사 리스트 페이지로 이동
		contentLoad('설문조사 내역',"<c:url value='/admin/studentManagement/studentSurveyManagement' />", data);
		break;
	}
}

// 자동설문 해당과정의 상세페이지로 이동
function goCourse(){
	var editUrl	= "<c:url value='/admin/course/trainProcessEdit' />";
	var data = { 'id' : $('#crc_id').val() }
	contentLoad("학습과정관리", editUrl, data);
}
</script>

<div class="content_wraper">
	<!-- script에서 사용하는 값 -->
	<input type="hidden" id="survey_seq" value='<c:out value="${info.SURVEY_SEQ}" default="0" />'>
	<input type="hidden" id="crc_id" value="${info.CRC_ID }">
	<input type="hidden" id="gisu_id" value="${info.GISU_ID }">
	<input type="hidden" id="complete_cnt" value="${info.COMPLETE_CNT }">

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

	<div id="survey_info">
		<!-- page 값에 따라 설문 기본 정보을 다르게 보여준다. -->
		<c:choose>
			<c:when test="${page eq 'survey' }"> <!-- 일반설문 통계 : 일반설문조사 리스트 페이지에서 이동해 온 경우  -->
				<div class="jumbotron">
					<div class="container">
						<div>
							<h1 id="bedgeList">
								${info.SURVEY_TITLE }
								
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:parseDate value="${info.SURVEY_START_DATE }" pattern="yyyy-mm-dd" var="startDate" />
								<fmt:parseDate value="${info.SURVEY_END_DATE }" pattern="yyyy-mm-dd" var="endDate" />
								<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
								<fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd" var="openDate" />
								<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd" var="closedDate" />
								<c:choose>
									<c:when test="${nowDate >= openDate }">
										<c:choose>
											<c:when test="${nowDate >= closedDate }">
												<span class="label label-danger" style="font-size:.3em;">종료</span>
											</c:when>
											<c:otherwise>
												<span class="label label-primary" style="font-size:.3em;">진행중</span>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<span class="label label-info" style="font-size:.3em;">진행예정</span>
									</c:otherwise>
								</c:choose>
								<button type="button" class="btn primary" onClick="cancelSurvey(${info.SURVEY_SEQ })" style="font-size:.3em;">배포 취소</button>
								
								<c:choose>
									<c:when test="${info.TOTAL_CNT eq 0}">
										<fmt:formatNumber value="0" var="share" />
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${info.COMPLETE_CNT/info.TOTAL_CNT * 100 }" pattern="#.#" var="share" />
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${share == 100.0 }">
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.COMPLETE_CNT }명 완료 (100%)</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.TOTAL_CNT }명 중 ${info.COMPLETE_CNT }명 완료 (${share }%)</button>
									</c:otherwise>
								</c:choose>
							</h1>
						</div>
						<h4><label>설문조사 일정 :  </label>${info.SURVEY_START_DATE } ~ ${info.SURVEY_END_DATE }</h4>
						<h6><label>설문조사 최종수정일 :  </label>${info.SURVEY_UPDATE }</h6>
						${info.SURVEY_CONTENT }
					</div>
				</div>
			</c:when>
			<c:when test="${page eq 'course' || page eq 'auto'}"> <!-- 자동설문 과정별 통계 : 과정상세 페이지 or 자동배포 설문목록 페이지에서 이동해 온 경우 -->
				<div class="jumbotron">
					<div class="container">
						<div>
							<h1 id="bedgeList">
								${info.SURVEY_TITLE }
								<span class="label label-danger" style="font-size:.3em;">자동설문</span>
								<button type="button" class="btn primary" onClick="cancelAutoSurvey(${info.SURVEY_SEQ })" style="font-size:.3em;">배포 취소</button>
								<c:choose>
									<c:when test="${info.TOTAL_CNT eq 0}">
										<fmt:formatNumber value="0" var="share" />
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${info.COMPLETE_CNT/info.TOTAL_CNT * 100 }" pattern="#.#" var="share" />
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${share == 100.0 }">
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.COMPLETE_CNT }명 완료 (100%)</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.TOTAL_CNT }명 중 ${info.COMPLETE_CNT }명 완료 (${share }%)</button>
									</c:otherwise>
								</c:choose>
							</h1>
						</div>
						<h6><label>과정명 : </label>
							<a onclick="goCourse()" href="javascript:void(0);">${info.CRC_NM }</a>
						</h6>
						<h6><label>설문조사 시작일 :  </label>
							<c:choose>
								<c:when test="${info.AUTO_SURVEY_START eq 1}">진도율이 50%이상일 때</c:when>
								<c:when test="${info.AUTO_SURVEY_START eq 2}">개강일부터 30일 후</c:when>
								<c:when test="${info.AUTO_SURVEY_START eq 3}">개강일부터 60일 후</c:when>
							</c:choose>
						</h6>
						<h6><label>설문조사 기간 :  </label>
							<c:choose>
								<c:when test="${info.AUTO_SURVEY_PERIOD eq 1}">연수종료일까지</c:when>
								<c:when test="${info.AUTO_SURVEY_PERIOD eq 2}">일주일</c:when>
							</c:choose>
						</h6>
						${info.SURVEY_CONTENT }
					</div>
				</div>
			</c:when>
			<c:when test="${page eq 'gisu' }"> <!-- 자동설문 기수별 통계 : 자동배포설문 리스트 페이지에서 이동해 온 경우 -->
				<div class="jumbotron">
					<div class="container">
						<div>
							<h1 id="bedgeList">
								${info.SURVEY_TITLE }
								<span class="label label-danger" style="font-size:.3em;">자동설문</span>
								<button type="button" class="btn primary" onClick="cancelAutoSurvey(${info.SURVEY_SEQ })" style="font-size:.3em;">배포 취소</button>
								<c:choose>
									<c:when test="${info.TOTAL_CNT eq 0}">
										<fmt:formatNumber value="0" var="share" />
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${info.COMPLETE_CNT/info.TOTAL_CNT * 100 }" pattern="#.#" var="share" />
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${share == 100.0 }">
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.COMPLETE_CNT }명 완료 (100%)</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn primary" onClick="surveyCompleteList()" style="font-size:.3em;">
										${info.TOTAL_CNT }명 중 ${info.COMPLETE_CNT }명 완료 (${share }%)</button>
									</c:otherwise>
								</c:choose>
							</h1>
						</div>
						<h6><label>과정명 : </label>
							<a onclick="goCourse()" href="javascript:void(0);">${info.CRC_NM }</a>
						</h6>
						<h6><label>기수명 : </label>
							${info.GISU_NM}
						</h6>
						<h6><label>설문조사 시작일 : </label>
							<c:choose>
								<c:when test="${info.AUTO_SURVEY_START eq 2}">${info.SURVEY_START_DATE}</c:when>
								<c:when test="${info.AUTO_SURVEY_START eq 3}">${info.SURVEY_START_DATE}</c:when>
							</c:choose>
						</h6>
						<h6><label>설문조사 마감일 : </label>
							<c:choose>
								<c:when test="${info.AUTO_SURVEY_PERIOD eq 1}">${info.SURVEY_END_DATE}</c:when>
								<c:when test="${info.AUTO_SURVEY_PERIOD eq 2}">${info.SURVEY_END_DATE}</c:when>
							</c:choose>
						</h6>
						${info.SURVEY_CONTENT }
					</div>
				</div>
			</c:when>
		</c:choose>
	</div> <!-- survey_info 끝 -->
	
	<div id="resultBody"></div>
	<div id="btnArea">
		<c:choose>
			<c:when test="${page eq 'survey'}"> <!-- 일반설문 통계 : 일반설문조사 리스트 페이지에서 이동해 온 경우  -->
				<button class="btn btn-secondary" onclick="goList('survey')" style="border-radius: 5px;">리스트</button>
			</c:when>
			<c:when test="${page eq 'course'}"> <!-- 자동설문 : 과정상세 페이지에서 이동해 온 경우 -->
				<button class="btn btn-secondary" onclick="goList('course')" style="border-radius: 5px;">이전</button>
			</c:when>
			<c:when test="${page eq 'auto' or page eq 'gisu'}"> <!-- 자동설문 : 자동배포설문 리스트 페이지에서 이동해 온 경우 -->
				<button class="btn btn-secondary" onclick="goList('auto')" style="border-radius: 5px;">리스트</button>
			</c:when>
		</c:choose>
	</div>
</div>