<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style type="text/css">
/* #grid {
display: grid;
grid-definition-columns: 1fr 1fr 1fr;
grid-definition-rows: 40px 150px 1fr 1fr 1fr 50px;
grid-template: "aside1 aside2 aside3";
}

#aside-1 { grid-area: aside1; }
#aside-2 { grid-area: aside2; }
#aside-3 { grid-area: aside3; }
 */
        .list-group {
            list-style: none;
            margin: 0;
            padding: 0;
            border: 1px solid #ccc;
            border-radius: .5em;
            width: 20em;
        }
		.
        .list-group li {
            border-top: 1px solid #ccc;
            padding: .5em;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .list-group li:first-child {
            border-top: 0;
        }

        .list-group .badge {
            background-color: rebeccapurple;
            color: #fff;
            font-weight: bold;
            font-size: 80%;
            border-radius: 10em;
            min-width: 1.5em;
            padding: .25em;
            text-align: center
        }
        
.rowss{
	margin-bottom: 5%;
}
input[type=number]::-webkit-inner-spin-button {
  opacity: 0;
}

.article, .aside{
	text-align: center;
min-height: 674px;
max-height:674px;
}

.factorsElements{
min-width: 40%;

}

.categoryList{
min-height: 540px;
max-height: 563px;
}
.titlee{
font-size: 1.5em;
}
.d-flex{
        display: flex;
        justify-content: space-between;
    }
    .content{
        width: 100%;
    }
    .content>.section{
        width: 33%;
/*         margin: 10px; */
        border: 1px solid #eee;
    }
    .content>.section>.article{
        width: 100%;
        padding: 20px;
    }
    .content>.section.wide{
        transition: .5s;
        border : 1px solid #ccc;
    }
    .content>.section.wide,
    .content>.section.wide>.article,
    .content>.section>.aside{
        width: 50%;

    }
    .content>.section>.aside{
        display: none;
        background-color: #ddd;
        padding: 20px;
    }
    .content>.section.wideOther{
        width: 25%;
    }

    .content>.section.wide>.aside{
        display: block;
    }
.aside, .article{
overflow-y: auto;
overflow-x: hidden;
}
.btnd {
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 0px 4px 4px;
  transition-duration: 0.4s;
  cursor: pointer;
  border-radius:4px;
}


.btnd-plus {
  background-color: transparent; 
  color: black; 
 
  
}

.btnd-plus:hover {
  background-color: #008CBA;
  color: white;
}

.btnd-remove {
  background-color: transparent; 
  color: black; 
  
}

.btnd-remove:hover {
  background-color: #f44336;
  color: white;
}

.bs-example {
  position: relative;
  padding: 45px 15px 15px;
  margin: 0 -15px 15px;
  border-color: #aaa;
  border-style: solid;
  border-width: 0px 0px 1px 0px;
  box-shadow: inset 0px -16px 6px rgba(0, 0, 0, .05);
}
.bs-example:after {
  position: absolute;
  top: 15px;
  left: 15px;
  font-size: 1.15em;
  font-weight: 700;
  color: #000;
  opacity:0.5;
  text-transform: uppercase;
  letter-spacing: 1px;
  content: attr(data-content);
}

.bigCategoryFactor ,.midCategoryFactor, .smallCategoryFactor{
border: solid;
border-color: #aaa;
border-width: 0.5px;
padding: 20px 15px 15px;
margin: 0 -15px 15px;
 

}

.bs-example-padded-bottom {
  padding-bottom: 24px;
}

.bs-example + .highlight,
.bs-example + .bs-clipboard + .highlight {
  margin: -15px -15px 15px;
  border-width: 0 0 1px;
  border-radius: 0;
}

@media (min-width: @screen-sm-min) {
  .bs-example {
    margin-right: 0;
    margin-left: 0;
    background-color: #fff;
    border-color: #ddd;
    border-width: 1px;
    border-radius: 4px 4px 0 0;
    box-shadow: none;
  }
  .bs-example + .highlight,
  .bs-example + .bs-clipboard + .highlight {
    margin-top: -16px;
    margin-right: 0;
    margin-left: 0;
    border-width: 1px;
    border-bottom-right-radius: 4px;
    border-bottom-left-radius: 4px;
}
.bs-example + .bs-clipboard .btn-clipboard {
    top: -15px; 
    border-top-right-radius: 0;
  }
  .bs-example-standalone {
    border-radius: 4px;
  }
}
.bs-example .container {
  width: auto;
}

.bs-example > p:last-child,
.bs-example > ul:last-child,
.bs-example > ol:last-child,
.bs-example > blockquote:last-child,
.bs-example > .form-control:last-child,
.bs-example > .table:last-child,
.bs-example > .navbar:last-child,
.bs-example > .jumbotron:last-child,
.bs-example > .alert:last-child,
.bs-example > .panel:last-child,
.bs-example > .list-group:last-child,
.bs-example > .well:last-child,
.bs-example > .progress:last-child,
.bs-example > .table-responsive:last-child > .table {
  margin-bottom: 0;
}
.bs-example > p > .close {
  float: none;
}

.bs-example-type .table .type-info {
  color: #767676;
  vertical-align: middle;
}
.bs-example-type .table td {
  padding: 15px 0;
  border-color: #eee;
}
.bs-example-type .table tr:first-child td {
  border-top: 0;
}
.bs-example-type h1,
.bs-example-type h2,
.bs-example-type h3,
.bs-example-type h4,
.bs-example-type h5,
.bs-example-type h6 {
  margin: 0;
}

.bs-example-bg-classes p {
  padding: 15px;
}

.bs-example > .img-circle,
.bs-example > .img-rounded,
.bs-example > .img-thumbnail {
  margin: 5px;
}

.bs-example > .table-responsive > .table {
  background-color: #fff;
}

.bs-example > .btn,
.bs-example > .btn-group {
  margin-top: 5px;
  margin-bottom: 5px;
}
.bs-example > .btn-toolbar + .btn-toolbar {
  margin-top: 10px;
}

.bs-example-control-sizing {
  select,
  input[type="text"] + input[type="text"] {
    margin-top: 10px;
  }
}
.bs-example-form .input-group {
  margin-bottom: 10px;
}
.bs-example > textarea.form-control {
  resize: vertical;
}

.bs-example > .list-group {
  max-width: 400px;
}

.bs-example .navbar:last-child {
  margin-bottom: 0;
}
.bs-navbar-top-example,
.bs-navbar-bottom-example {
  z-index: 1;
  padding: 0;
  overflow: hidden; 
}
.bs-navbar-top-example .navbar-header,
.bs-navbar-bottom-example .navbar-header {
  margin-left: 0;
}
.bs-navbar-top-example .navbar-fixed-top,
.bs-navbar-bottom-example .navbar-fixed-bottom {
  position: relative;
  margin-right: 0;
  margin-left: 0;
}
.bs-navbar-top-example {
  padding-bottom: 45px;
}
.bs-navbar-top-example:after {
  top: auto;
  bottom: 15px;
}
.bs-navbar-top-example .navbar-fixed-top {
  top: -1px;
}
.bs-navbar-bottom-example {
  padding-top: 45px;
}
.bs-navbar-bottom-example .navbar-fixed-bottom {
  bottom: -1px;
}
.bs-navbar-bottom-example .navbar {
  margin-bottom: 0;
}
@media (min-width: 768px) {
  .bs-navbar-top-example .navbar-fixed-top,
  .bs-navbar-bottom-example .navbar-fixed-bottom {
    position: absolute;
  }
}

.bs-example .pagination {
  margin-top: 10px;
  margin-bottom: 10px;
}

.bs-example > .pager {
  margin-top: 0;
}

.bs-example-modal {
  background-color: #f5f5f5;
}
.bs-example-modal .modal {
  position: relative;
  top: auto;
  right: auto;
  bottom: auto;
  left: auto;
  z-index: 1;
  display: block;
}
.bs-example-modal .modal-dialog {
  left: auto;
  margin-right: auto;
  margin-left: auto;
}

.bs-example > .dropdown > .dropdown-toggle {
  float: left;
}
.bs-example > .dropdown > .dropdown-menu {
  position: static;
  display: block;
  margin-bottom: 5px;
  clear: left;
}

.bs-example-tabs .nav-tabs {
  margin-bottom: 15px;
}

.bs-example-tooltips {
  text-align: center;
}
.bs-example-tooltips > .btn {
  margin-top: 5px;
  margin-bottom: 5px;
}
.bs-example-tooltip .tooltip {
  position: relative;
  display: inline-block;
  margin: 10px 20px;
  opacity: 1;
}
.bs-example-popover {
  padding-bottom: 24px;
  background-color: #f9f9f9;
}
.bs-example-popover .popover {
  position: relative;
  display: block;
  float: left;
  width: 260px;
  margin: 20px;
}

.scrollspy-example {
  position: relative;
  height: 200px;
  margin-top: 10px;
  overflow: auto;
}

.bs-example > .nav-pills-stacked-example {
  max-width: 300px;
}

#collapseExample .well {
  margin-bottom: 0;
}

#focusedInput {
  border-color: rgb(204, 204, 204); 
  border-color: rgba(82, 168, 236, .8);
  outline: 0;
  outline: thin dotted \9; 
  box-shadow: 0 0 8px rgba(82, 168, 236, .6);
}
.modal-content{
	max-width: 1000px;
	width: 1000px;
}
</style>

<script type="text/javascript">
var progressColors = new Array();
progressColors.push('');
progressColors.push('progress-bar-info');
progressColors.push('progress-bar-success');
progressColors.push('progress-bar-warning');
progressColors.push('progress-bar-danger');
var progressColor = Number(0);

$(document).ready(function () {
	
	var $wideSection = $('.content .section');
    // 너비 조절
    $wideSection.on("click",function() {
    	var id = $(this).attr('id');
    	
/* 	    	if ($(this).hasClass("wide")==true) {
    		$(this).removeClass('wide').siblings().removeClass('wideOther');
    		return;
		} */
    	
    	$(this).addClass('wide').siblings().addClass('wideOther');
    	if (id == 'bigCat') {
    		$('#smallCat').removeClass('wide').siblings().removeClass('wideOther');
    		$('#midCat').removeClass('wide').siblings().removeClass('wideOther');
		} else if (id == 'smallCat'){
			$('#bigCat').removeClass('wide').siblings().removeClass('wideOther');
    		$('#midCat').removeClass('wide').siblings().removeClass('wideOther');	
		} else{
			$('#bigCat').removeClass('wide').siblings().removeClass('wideOther');
    		$('#smallCat').removeClass('wide').siblings().removeClass('wideOther');	
	
		}      
    });
    // 너비 조절 해제
	$("input:text[numberOnly]").on("keyup", function() {
	    var val = $(this).val();
	   if(val < 0 || val > 100) {
	        alert("1~1000 범위로 입력해 주십시오.");
	        $(this).val('');
	    }
	});
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	
	/** 변수 영역 **/
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// 여기에서 URL 변경 시켜서 사용
	var listAll	= "<c:url value='/data/complete/completeListAll' />";
 	    
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	// 네이버 스마트 에디터 저장 객체
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일
	// file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, callback : "drawCourse"};
	
	// 에디터, 언어 선택 기능 초기화
	setPageInit(editor_object, file_object);
	
	$('.js-example-basic-single').select2();
	searchList();
	changeTestCategory('searchTestDiv');
	
	$('.totalAddScore').onkeyup = function(){
		if ($(this).value >100 && $(this).value < 0) {
			alert('점수가 초과했습니다..');
			$(this).value = 0;
		} 
	}	
});



function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}

var whichtab = self.document.location.hash.substring(1);
if (whichtab === "") {
//no tabs are specified, lets default to the first one
$("#tabs li").first().addClass("active");
}
else {
//show the selected tab
$('a[href$="'+whichtab+'"]').parent().addClass("active");
$(".tab_content").hide();
$("#" + whichtab).fadeIn(700);
}

//  When user clicks on tab, this code will be executed
$("#tabs li").click(function() {
//  First remove class "active" from currently active tab
$("#tabs li").removeClass('active');

//  Now add class "active" to the selected/clicked tab
$(this).addClass("active");
 
//  Hide all tab content
$(".tab_content").hide();
 
//  Here we get the href value of the selected tab
var selected_tab = $(this).find("a").attr("href");
 
//  Show the selected tab content
$(selected_tab).fadeIn(700);

//  At the end, we add return false so that the click on the link is not executed
return false;
});


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
			sb.Append('<select class="js-example-basic-single" id="gisuList" name="state" onchange="createUpperCategory()">');
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
	 			createUpperCategory();
	 			//searchClassList();
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
			$("#gwajeongSelector").html("");
			sb.Append('<select class="js-example-basic-single" name="state" id="gisuValue" onchange="searchListGisu(this.value);">">');
			for (var i = 0; i < result.length; i++) {
				var map = result[i];
				 if (i == 0) {
					 firstGisu = map.CRC_SEQ;
				sb.Append('<option value="" disabled selected hidden>과정명을 선택해주세요..</option>');
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


function categorySetting(){
	var sb = new StringBuilder();
	var value = $("#gisuList").val();
	var Url	= "<c:url value='/student/TestManagement/searchCategoryList' />";
	if(value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length)){
		$("#categoryRadio").html("");
		sb.ToString('<option value="" disabled hidden>카테고리를 선택해주세요</option>');
		alert("기수가 설정되지 않았습니다.");
		return;
		}
	var allData = {"gisu_id" : $("#gisuList").val(), "crc_id" : $("#gisuValue").val()};
		$.ajax({
			url		: Url,
			data 	: allData,
			type	: "post",
			success	: function(result){
				$("#categoryRadio").html("");
				if (result.length == 0) {
					alert("배율 설정을 부탁합니다.");
					$("#categoryRadio").html(sb.ToString());
					return;
				}
				sb.Append('');
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					sb.Append('<option value="'+map.CAT_SEQ+'">'+map.CAT_NM+'</option>');
				}
				$("#categoryRadio").html(sb.ToString());
			},
			complete:function(){
				$('.js-example-basic-single').select2();
			}
		});
	}

function doComplete(courseId, cardinalId, completeList, flag){

	$.ajax({
		contentType : "application/json",
		dataType : "text",
		type	: "get",
		traditional : true,
		url		: completeUrl,
		data    : {
			"course_id" : courseId,
			"cardinal_id" : cardinalId,
			"flag" : flag,
			"completeList" : JSON.stringify(completeList)
		},
		success	: function(data) {

			alert('처리 완료 : ' + data + '명');		        
			$('#checkAll').prop('checked', false);
			init(1, courseId, cardinalId, $('#userId').val());

		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}						
	});
}
function init(pageNo, courseId, cardinalId, userNm){

	// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
	pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
	
	// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
	$(":hidden[name='pageNo']").val(pageNo);
	
	
	// ajax 처리
		$.ajax({
			type	: "post",
			url		: listAll,
			data 	: {
				'pageNo' : pageNo,
				'courseId' : courseId,
				'cardinalId' : cardinalId,
				'userNm' : userNm
			},
			success	: function(result) {
				var sb = new StringBuilder();
				var pageNo		= result.pageNo		? result.pageNo		: 1;
				var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

				
					var passNum = 0;
				var failNum = 0; 

				

				if(result.list && result.list.length > 0) {
					var dataList	= result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						
						if(dataInfo.issueYn=='Y'){
							passNum++;
						} else {
							failNum++;
						}
						
/* 							var sType = "";
						sType = (dataInfo.sType == "1" ? "초등" 
							  : (dataInfo.sType == "2" ? "중등" 
							  : (dataInfo.sType == "3" ? "고등"
							  : (dataInfo.sType == "4" ? "유아"
							  : (dataInfo.sType == "5" ? "특수"
							  : (dataInfo.sType == "6" ? "기관" : ""))))));
*/							
/* 							// 이수/미이수 인원명 구하기
						dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum; */

						sb.Append("<tr>");
						sb.Append("	<td class='tdCourseId'>"+dataInfo.course.id+"</td>");
						sb.Append("	<td class='tdCourseName'>"+dataInfo.course.name+"</td>");
						sb.Append("	<td class='tdCardinalId'>"+dataInfo.cardinal.id+"</td>");
						sb.Append("	<td class='tdCardinalName'>"+dataInfo.cardinal.name+"</td>");
						sb.Append("	<td class='tdUserId'>"+dataInfo.user.id+"</td>");
						sb.Append("	<td class='tdUserName'>"+dataInfo.user.name+"</td>");
						sb.Append("	<td class='tdUserBirthday'>"+dataInfo.user.birthDay+"</td>");
						sb.Append("	<td class='tdIssueYn'>"+dataInfo.issueYn+"</td>");
						//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
						if(dataInfo.issueDate!=null&&dataInfo.issuDate!=""){								
							sb.Append("	<td class='tdIssueDate'>"+dataInfo.issueDate+"</td>");
						} else{
							sb.Append("	<td class='tdIssueDate'></td>");								
						}
						sb.Append("</tr>");
					
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
									 + "이수 : "+passNum+"명 / "
									 + "미이수 : "+failNum+"명" );

/* 					// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(init);					
*/					
				
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});	
}
//리스트 페이지 세팅(ajax 방식) 함수
function completeProc() {
	if(confirm("이수처리 하시겠습니까?")) {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: procUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				// 이수 처리 후 리스트 조회
				var sb = new StringBuilder();
				var passNum = 0;
				var failNum = 0;

				if(result.list && result.list.length > 0) {
					var dataList	= result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var sType = "";
						
						sType = (dataInfo.sType == "1" ? "초등" 
							  : (dataInfo.sType == "2" ? "중등" 
							  : (dataInfo.sType == "3" ? "고등"
							  : (dataInfo.sType == "4" ? "유아"
							  : (dataInfo.sType == "5" ? "특수"
							  : (dataInfo.sType == "6" ? "기관" : ""))))));
						
						// 이수/미이수 인원명 구하기
						dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum;

						sb.Append("<tr>");
						sb.Append("	<td>"+dataInfo.course.id+"</td>");
						sb.Append("	<td>"+(dataInfo.schoolName ? dataInfo.schoolName : "")+"</td>");
						sb.Append("	<td>"+sType+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td>"+((dataInfo.user && dataInfo.user.birthDay) ? dataInfo.user.birthDay : "")+"</td>");
						sb.Append("	<td>"+dataInfo.objScore+"</td>");
						sb.Append("	<td>"+dataInfo.subScore+"</td>");
						//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
						sb.Append("	<td>"+dataInfo.partScore+"</td>");
						sb.Append("	<td>"+dataInfo.attScore+"</td>");
						sb.Append("	<td>"+dataInfo.totalScore+"</td>");
						sb.Append("	<td>"+(dataInfo.issueNum ? "이수" : "미이수")+"</td>");
						sb.Append("	<td>"+((dataInfo.region && dataInfo.region.name) ? dataInfo.region.name : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.jurisdiction ? dataInfo.jurisdiction : "")+"</td>");
						sb.Append("	<td>"+(dataInfo.issueNum ? dataInfo.issueNum : "")+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
									 + "이수 : "+passNum+"명 / "
									 + "과락 : "+failNum+"명" );
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
}

function submitt(){
	var alldata = 
				{	"gisu_id"			:	$("#gisuList").val(),
					"crc_id"			:	$("#gisuValue").val(),
					"cat_seq"			:	$("#categoryRadio").val(),
					"total_score"		:	$("#total").val(),
					"retest_time"		:	$("#reTest").val(),
					"test_nm"			:	$("#recruit").val(),
					"test_start_date"	:	$("#startDate").val(),
					"test_end_date"		:	$("#endDate").val(),
					"test_content"		:	$("#content").val()
				};
	

	if (checkDate($("#startDate").val()) > checkDate($("#endDate").val())) {
		alert("일정 설정이 잘못되었습니다..");
		return false;
	}
	if ($("#gisuList").val() == null || $("#gisuList").val() == '' || $("#gisuValue").val() == null || $("#gisuValue").val() == '') {
		alert('과정과 기수 설정이 안되있습니다.');
		return false;
	}
	if ($("#recruit").val() == '' ||  $("#recruit").val() == ' ' || $("#recruit").val() == null) {
		alert('시험명을 입력해주세요.');
		return false;
	}
	var Url = "<c:url value='/student/TestManagement/insertTestInfo' />";
	$.ajax({
		url		: Url,
		data 	: alldata,
		type	: "post",
		success : function(){
			alert("저장완료!!");
			},
		complete:function(){
			$("#recruit").val("");
			$('#content').val("");
			changeTestCategory('searchTestDiv');
			createUpperCategory();
			categorySetting();
		}
		});
	
	
}
function checkDate(str) {
    var y = str.substr(0, 4);
    var m = str.substr(5, 2);
    var d = str.substr(8, 2);
    return new Date(y,m-1,d);
}

function isNumberKey(obj,evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    var _value = event.srcElement.value;
    var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
    if (_pattern0.test(_value)) {
        if (charCode == 46) {
            return false;
        }
    }

    var _pattern1 = /^\d{3}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
    if (_pattern1.test(_value)) {
        if (charCode != 46) {
            return false;
        }
        alert("100 이하의 숫자만 입력가능합니다");
        $(obj).val('');
    }

    var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
    if (_pattern2.test(_value)) {
        alert("소수점 둘째자리까지만 입력가능합니다.");
        return false;
    }     
    return true;
}
// 리스트 페이지 세팅(ajax 방식) 함수
function setContentList(pageNo) {
	// ajax 처리
	$.ajax({
		type	: "post",
		url		: listUrl,
		data 	: $("form[name='searchForm']").serialize(),
		success	: function(result) {
			var sb = new StringBuilder();
			var passNum = 0;
			var failNum = 0;

			if(result.list && result.list.length > 0) {
				var dataList	= result.list;

				for(var i=0; i<dataList.length; ++i) {
					var dataInfo = dataList[i];
					var sType = "";
					
					sType = (dataInfo.sType == "1" ? "초등" 
						  : (dataInfo.sType == "2" ? "중등" 
						  : (dataInfo.sType == "3" ? "고등"
						  : (dataInfo.sType == "4" ? "유아"
						  : (dataInfo.sType == "5" ? "특수"
						  : (dataInfo.sType == "6" ? "기관" : ""))))));
					
					// 이수/미이수 인원명 구하기
					dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum;

					sb.Append("<tr>");
					sb.Append("	<td>"+dataInfo.course.id+"</td>");
					sb.Append("	<td>"+dataInfo.course.name+"</td>");
					sb.Append("	<td>"+dataInfo.cardinal.id+"</td>");
					sb.Append("	<td>"+dataInfo.cardinal.name+"</td>");
					sb.Append("	<td>"+dataInfo.user.id+"</td>");
					sb.Append("	<td>"+dataInfo.user.birthDay+"</td>");
					sb.Append("	<td>"+dataInfo.issueYn+"</td>");
					//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
					sb.Append("	<td>"+dataInfo.issueDate+"</td>");
					sb.Append("</tr>");
				}
			} else {
				sb.Append("<tr>");
				sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
				sb.Append("</tr>");
			}
			
			$("#dataListBody").html(sb.ToString());
			$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
								 + "이수 : "+passNum+"명 / "
								 + "과락 : "+failNum+"명" );
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}

function clearSetting(obj){
	var Obj = $(obj).closest('div');
	Obj.remove();
}
function addSetting(obj){
	
	var Obj = $(obj).closest('div').prev();
	/* alert(Obj.attr('class'));
	 */
	 var sb = new StringBuilder();
	var bigSeq = $(obj).closest('div').parent().find("input[name=bigCategorySeqInMid]").val();
	if ($(obj).closest('div').prev().attr('class') == 'bigCategoryFactors') {
		sb.Append('<div class="bigCategoryFactor">');
		sb.Append('<input type="text" name="bigCategoryName" style="margin-bottom: 10px" placeholder="카테고리 이름">');
	    sb.Append('<input type="text" name="bigCategoryRate" numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
	    sb.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');
	    $(obj).closest('div').prev().append(sb.ToString());
	} else if($(obj).closest('div').prev().attr('class') == 'midCategoryFactors'){
		sb.Append('<div class="midCategoryFactor">');
		sb.Append('<input type="hidden" name="midCategorySeq" value="0">');
		sb.Append('<input type="text" name="midCategoryName" style="margin-bottom: 10px" placeholder="카테고리 이름">');
	    sb.Append('<input type="text" name="midCategoryRate" numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
	    sb.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');
	    Obj.append(sb.ToString());
	} else {
		sb.Append('<div class="smallCategoryFactor">');
		sb.Append('<input type="hidden" name="smallCategorySeq" value="0">');
		sb.Append('<input type="text" name="smallCategoryName" style="margin-bottom: 10px" placeholder="카테고리 이름">');
	    sb.Append('<input type="text" name="smallCategoryRate" numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
	    sb.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');
	    Obj.append(sb.ToString());
	}
}

function saveCategory(obj){
	var id = $(obj).closest('div').parent().attr('id');
	var j = $(obj).closest('div').prev().children().attr('class');
	var categoryNameList = new Array();
	var categoryRateList = new Array();
	var categorySeqList = new Array();
	var checkUC = $(obj).closest('div').parent().find('.bs-example').length;
	var checking = new Array();
	var totals = new Array();
	if (id =='midC') {
		for (var i = 0; i < checkUC; i++) {
			checking.push($(obj).closest('div').parent().children().eq(i).find('.midCategoryFactor').length);
			totals[i] = 0;
		}	
	} else if (id =='smallC') {
		for (var i = 0; i < checkUC; i++) {
			checking.push($(obj).closest('div').parent().children().eq(i).find('.smallCategoryFactor').length);
			totals[i] = 0;
		}	
	}
  	/* alert("상위 카테고리 개수 : "+ checkUC);
	alert("총 합계 배열 개수 : "+ totals.length);
	var sbss = new StringBuilder();
	for (var i = 0; i < checking.length; i++) {
		sbss.Append(checking[i] + " , ");
	}
	alert("토탈 상위카테고리 별 하위 카테고리 개수 모임 : " + sbss.ToString());
	alert(id);  */
	
	 	if (id=='bigC') {
	 		categoryNameList = $("input[name$=bigCategoryName]");
	 		categoryRateList = $("input[name$=bigCategoryRate]");
	 		categorySeqList = $("input[name$=bigCategorySeq]");
	 		
	} else if (id =='midC'){
		categoryNameList = $("input[name$=midCategoryName]");
		categoryRateList = $("input[name$=midCategoryRate]");
		categorySeqList = $("input[name$=midCategorySeq]");
		bigCategorySeq = $("input[name$=bigCategorySeqInMid]");
		
	} else {
		categoryNameList = $("input[name$=smallCategoryName]");
		categoryRateList = $("input[name$=smallCategoryRate]");
		categorySeqList = $("input[name$=smallCategorySeq]");
		bigCategorySeq = $("input[name$=bigCategorySeqInSmall]");
		midCategorySeq = $("input[name$=midCategorySeqInSmall]");
	}
	
	/* 
	
	var categoryInfo = new Object();
	var categoryList = new Array();
	var total = 0;
	var count = 0;
	
	for (var i = 0; i < categoryNameList.length-1; i++) {
		for (var j = i+1; j < categoryNameList.length; j++) {
			if (categoryNameList[i].value == categoryNameList[j].value) {
				alert("중복된 이름이 존재합니다..");
				return;
			}
		}
	}
	for (var i = 0; i < categoryNameList.length; i++) {
		count += 1;
		categoryInfo = new Object();
		categoryInfo.crc_id = $("#gisuValue").val();
		categoryInfo.gisu_id = $("#gisuList").val();
		
		if(categorySeqList[i] == null || categorySeqList[i] == undefined || categorySeqList[i] == 0) {
		} else {
			categoryInfo.cat_seq = categorySeqList[i].value;
		}
		
		categoryInfo.cat_nm = categoryNameList[i].value;
		categoryInfo.cat_percent = categoryRateList[i].value;
		categoryInfo.obj = id;
		if (id == 'bigC') {
			total += parseFloat(categoryRateList[i].value);	
		}
		
		if (id == 'midC' || id =='smallC') {
			for (var j = 0; j < checking.length; j++) {
				
				if (checking[j] != 0 ) {
		
					categoryInfo.big_cat_seq = bigCategorySeq[j].value;
					if(id == 'smallC') {
						categoryInfo.mid_cat_seq = midCategorySeq[j].value;
					}
					/* alert("checking["+j+"] : " + checking[j]);
					alert(j + " 번째 카테고리리스트: " + parseFloat(Number(categoryRateList[i].value)));
					alert(j + "번째 total : " + parseFloat(totals[j]));
					alert("totals 합 : " + parseFloat(totals[j]+Number(categoryRateList[i].value)));
					alert("카테고리 타입 : "+typeof Number(categoryRateList[i].value));
					alert("토탈 타입 : "+ typeof totals[j]);  */
// 					totals[j] =  parseFloat(totals[j]+Number(categoryRateList[i].value));
// 					checking[j] -= 1;
// 					break;
// 				}
// 			}
			
// 		} else if (id == 'smallC') {
// 			categoryInfo.upper_cat_seq = "2";
// 		}
// 		categoryList.push(categoryInfo);
// 	}
	for (var i = 0; i < totals.length; i++) {
		if ((totals[i] > 100 || totals[i] < 99.99) && id != 'bigC') {
			alert(totals[i]+" 안맞습니다.");
			//alert("totals 배율이 안맞습니다. 확인해주세요.");	
			return;
		}
	}
	if ((total > 100 || total < 99.99) && id == 'bigC') {
		alert("배율이 안맞습니다. 확인해주세요.");
		return;
	}
	var jsonStr = JSON.stringify(categoryList);
	
	$.ajax({
		url:"<c:url value='/student/TestManagement/insertCategoryList'/>",
		type:		"post",
		dataType:	"json",
		contentType: 'application/json; charset=UTF-8',
		data: jsonStr,
		success:function(result){
			
				alert("저장을 성공하였습니다.");
				createUpperCategory();
		},
		error:function(error){
			alert(error.statusText);
		}
	});
}

function createUpperCategory(){
	$("#bigC").html('');
	$("#midC").html('');
	$("#smallC").html('');
	$("#midProgress").html('');
	$("#bigProgress").html('');
	$("#smallProgress").html('');
	$("#bigCL").html('');
	$("#midCL").html('');
	$("#smallCL").html('');
	var check = false;
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	var sb1 = new StringBuilder();
	var sb2 = new StringBuilder();
	var sb3 = new StringBuilder();
	var sbCB = new StringBuilder();
	var sbCM = new StringBuilder();
	var sbCS = new StringBuilder();
	var sbPrB = new StringBuilder();
	var sbPrM = new StringBuilder();
	var sbPrS = new StringBuilder();
	var checkNumBig = 0;
	var checkNumMid = 0;
	var checkBig = false;
	var checkMid = false;
	var checkWidth = 0;
/* $("#midC"); */	
	$.ajax({
		url	:	"<c:url value='/student/TestManagement/createUpperCategory'/>",
		type:	"post",
		async: false,
		data:	{
			"crc_id" : crc_id,
			"gisu_id": gisu_id,		
		},
		success:function(result){
			
			sb1.Append('<div class="bigCategoryFactors">');
			progressColor =0;
				for (var i = 0; i < result.length; i++) {
				if (result[i].BIG_CAT_SEQ == '0' && result[i].MID_CAT_SEQ == '0') {
					
					sbPrB.Append('<div class="progress-bar '+progressColors[progressColor%5]+' progress-bar-striped active" style="width: '+result[i].CAT_PERCENT+'%">'+result[i].CAT_NM+'('+result[i].CAT_PERCENT+'%)</div>');
					progressColor = Number(Number(progressColor) + 1);
					sbCB.Append('<div class="row rowss row-no-gutters">');
	       			sbCB.Append('<div class="col-xs-6" style="font-size: 1.5rem;">'+result[i].CAT_NM+'</div>');
	       			sbCB.Append('<div class="col-xs-6"><div class="progress">');
	       			sbCB.Append('<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'+result[i].CAT_PERCENT+'" aria-valuemin="0" aria-valuemax="100" style="width: '+result[i].CAT_PERCENT+'%;">');
	       			sbCB.Append(''+result[i].CAT_PERCENT+'%</div></div></div></div>');
					
	       			sb1.Append('<div class="bigCategoryFactor">');
	       			sb1.Append('<input type="hidden" name="bigCategorySeq" value="'+result[i].CAT_SEQ+'">');
					sb1.Append('<input type="text" name="bigCategoryName" value="'+result[i].CAT_NM+'" style="margin-bottom: 10px" placeholder="카테고리 이름">');
				    sb1.Append('<input type="text" name="bigCategoryRate" value="'+result[i].CAT_PERCENT+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
				    sb1.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');
				    
				    
				    sb2 = new StringBuilder();
					sbCM = new StringBuilder();
					
				    sb2.Append('<div class="bs-example" data-example-id="simple-pre" data-content="'+result[i].CAT_NM +'">');	
					sb2.Append('<input type="hidden" name="bigCategorySeqInMid" value="'+result[i].CAT_SEQ+'">');
					sb2.Append('<div class="midCategoryFactors">');
					
					sbCM.Append('<div class="bs-example" data-example-id="simple-pre" style="color:#fcf8e3;" data-content="'+result[i].CAT_NM +'">');
					progressColor = 0;
					for (var j = 0; j < result.length; j++) {
						if (result[i].CAT_SEQ == result[j].BIG_CAT_SEQ && result[j].MID_CAT_SEQ == '0') {
							checkWidth = Number(100 / Number(result[i].CAT_PERCENT));
							checkWidth2 = Number(result[j].CAT_PERCENT)/checkWidth;
							sbPrM.Append('<div class="progress-bar '+progressColors[progressColor%5]+' progress-bar-striped active" style="width: '+checkWidth2+'%">'+result[j].CAT_NM+'('+checkWidth2+'%)</div>');
							progressColor = Number(Number(progressColor) + 1);
							
							sb2.Append('<div class="midCategoryFactor">');
							sb2.Append('<input type="hidden" name="midCategorySeq" value="'+result[j].CAT_SEQ+'">');
							sb2.Append('<input type="text" name="midCategoryName" value="'+result[j].CAT_NM+'" style="margin-bottom: 10px" placeholder="카테고리 이름">');
							sb2.Append('<input type="text" name="midCategoryRate"value="'+result[j].CAT_PERCENT+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
							sb2.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');		
							
							sb3.Append('<div class="bs-example" data-example-id="simple-pre" data-content="'+result[j].CAT_NM +'">');
							sb3.Append('<input type="hidden" name="bigCategorySeqInSmall" value="'+result[i].CAT_SEQ+'">');
							sb3.Append('<input type="hidden" name="midCategorySeqInSmall" value="'+result[j].CAT_SEQ+'">');
							sb3.Append('<div class="smallCategoryFactors" id="'+result[j].CAT_SEQ+'small">');
							
							sbCS.Append('<div class="bs-example" data-example-id="simple-pre" id="small'+result[j].CAT_SEQ+'" style="color:#fcf8e3;" data-content="'+result[j].CAT_NM +'">');
			       			
							for(var z = 0; z < result.length; z++) {
								if(result[i].CAT_SEQ == result[z].BIG_CAT_SEQ && result[j].CAT_SEQ == result[z].MID_CAT_SEQ) {
									
									sb3.Append('<div class="smallCategoryFactor">');
									sb3.Append('<input type="hidden" name="smallCategorySeq" value="'+result[z].CAT_SEQ+'">');
									sb3.Append('<input type="text" name="smallCategoryName" value="'+result[z].CAT_NM+'" style="margin-bottom: 10px" placeholder="카테고리 이름">');
									sb3.Append('<input type="text" name="smallCategoryRate" value="'+result[z].CAT_PERCENT+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율">');
									sb3.Append('<button class="btn align_right danger" onclick="clearSetting(this)" style="width: 80%">삭제하기</button></div>');		
								
									sbCS.Append('<div class="row rowss row-no-gutters">');
									sbCS.Append('<div class="col-xs-6" style="font-size: 1.5rem;">'+result[z].CAT_NM+'</div>');
									sbCS.Append('<div class="col-xs-6"><div class="progress">');
									sbCS.Append('<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'+result[z].CAT_PERCENT+'" aria-valuemin="0" aria-valuemax="100" style="width: '+result[z].CAT_PERCENT+'%;">');
									sbCS.Append(''+result[z].CAT_PERCENT+'%</div></div></div></div>');
								}
							}
							sbCS.Append('</div>');
							sb3.Append('</div><div><button class="btn align_right" style="width:80%" onclick="addSetting(this)">추가하기</button></div></div></div>');
							
							sbCM.Append('<div class="row rowss row-no-gutters">');
			       			sbCM.Append('<div class="col-xs-6" style="font-size: 1.5rem;">'+result[j].CAT_NM+'</div>');
			       			sbCM.Append('<div class="col-xs-6"><div class="progress">');
			       			sbCM.Append('<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'+result[j].CAT_PERCENT+'" aria-valuemin="0" aria-valuemax="100" style="width: '+result[j].CAT_PERCENT+'%;">');
			       			sbCM.Append(''+result[j].CAT_PERCENT+'%</div></div></div></div>');
						}
					}
					
					sbCM.Append('</div>');
					sb2.Append('</div><div><button class="btn align_right" style="width:80%" onclick="addSetting(this)">추가하기</button></div>');
					$("#midC").append(sb2.ToString());
					$("#midCL").append(sbCM.ToString());
				}
			}	
				sb1.Append('</div>');
				sb1.Append('<div class="btnCategory footers">');
				sb1.Append('<button class="btn btn-primary" onclick="saveCategory(this)">저장하기</button>');
				sb1.Append('<button class="btn align_right" onclick="addSetting(this)">추가하기</button>');
				sb1.Append('</div>');	
				sb1.Append('</div>');
				sb2 = new StringBuilder();
				sb2.Append('<div class="btnCategory footers">');
				sb2.Append('<button class="btn btn-primary" onclick="saveCategory(this)" style="width:80%" ">저장하기</button>');
				sb2.Append('</div>');	
				
				sb3.Append('<div class="btnCategory footers">');
				sb3.Append('<button class="btn btn-primary" onclick="saveCategory(this)" style="width:80%">저장하기</button>');
				sb3.Append('</div>');
				$("#bigCL").append(sbCB.ToString());
				$("#bigProgress").append(sbPrB.ToString());
				$("#midProgress").append(sbPrM.ToString());
				$("#smallProgress").append(sbPrS.ToString());
				$("#bigC").append(sb1.ToString());
				$("#midC").append(sb2.ToString()); 
				$("#smallC").append(sb3.ToString());
				$("#smallCL").append(sbCS.ToString());
				
/* 				for (var i = 0; i < result.length; i++) {
					if (result[i].MID_CAT_SEQ != '0' && result[i].MID_CAT_SEQ !='') {
						var nm = '';
						for (var j = 0; j < result.length; j++) {
							if (result[i].MID_CAT_SEQ == result[j].CAT_SEQ) {
								nm = result[j].CAT_NM;	
								break;
							}
						}
						sb3 = new StringBuilder();
						sb3.Append('<div class="smallCategoryFactor">');
						sb3.Append('<input type="text" name="smallCategoryName" value="'+result[i].CAT_NM+'" style="margin-bottom: 10px" readonly placeholder="카테고리 이름">');
						sb3.Append('<input type="text" name="smallCategoryRate"value="'+result[i].CAT_PERCENT+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율"></div>');
	
						$('#'+result[i].MID_CAT_SEQ+nm+'').append(sb3.ToString());
					}
				} */
		},
		error:function(error){
			alert(error.statusText);
		},
		complete:function(){
			reloadData();
			searchClassList();
		}
	});
	

}
function createSmallCat(){
	var check = false;
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	var sb1 = new StringBuilder();
	var sb2 = new StringBuilder();
	var sb3 = new StringBuilder();
	var sbCB = new StringBuilder();
	var sbCM = new StringBuilder();
	var sbCS = new StringBuilder();
	var sbPrB = new StringBuilder();
	var sbPrM = new StringBuilder();
	var sbPrS = new StringBuilder();
	var checkNumBig = 0;
	var checkNumMid = 0;
	var checkBig = false;
	var checkMid = false;
	var checkWidth = 0;
	/* $.ajax({
		url	:	"<c:url value='/student/TestManagement/callSmallCategory'/>",
		type:	"post",
		data:	{
			"crc_id" : crc_id,
			"gisu_id": gisu_id,		
		},
		success: function(result){
			var check = false;
			var checkPer = 0;
			for (var i = 0; i < result.length; i++) {
					
					sb3 = new StringBuilder();
					if (result[i].CAT_PERCENT === undefined) {
						check = true;
						sb3.Append('<div class="row rowss row-no-gutters">');
	       				sb3.Append('<div class="col-xs-6" style="font-size: 1.5rem;">'+result[i].TEST_NM+'</div>');
	       				sb3.Append('<div class="col-xs-6"><div class="progress" style=" color:black; text-align: center;">');
	       				sb3.Append('<div class="progress-bar style="color:black;" progress-bar-striped active" role="progressbar" aria-valuenow="'+0+'" aria-valuemin="0" aria-valuemax="100" style="width: '+0+'%;">');
	       				sb3.Append('<p style="color:#000000;margin-left: 19px;">0%</p></div></div></div></div>');
						
					} else{
						sb3.Append('<div class="row rowss row-no-gutters">');
	       				sb3.Append('<div class="col-xs-6" style="font-size: 1.5rem;">'+result[i].TEST_NM+'</div>');
	       				sb3.Append('<div class="col-xs-6"><div class="progress">');
	       				sb3.Append('<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'+result[i].CAT_PERCENT+'" aria-valuemin="0" aria-valuemax="100" style="width: '+result[i].CAT_PERCENT+'%;">');
	       				sb3.Append(''+result[i].CAT_PERCENT+'%</div></div></div></div>');
							
					}
					$('#small'+result[i].MID_CAT_SEQ+'').append(sb3.ToString());
					checkPer = Number(Number(checkPer) + Number(result[i].CAT_PERCENT));
					
					sb3 = new StringBuilder();
					sb3.Append('<div class="smallCategoryFactor">');
					sb3.Append('<input type="text" name="smallCategoryName" value="'+result[i].TEST_NM+'" style="margin-bottom: 10px" readonly placeholder="카테고리 이름">');
					if (result[i].CAT_PERCENT === undefined) {
						sb3.Append('<input type="text" name="smallCategoryRate" value=""  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율"></div>');
					} else{
						sb3.Append('<input type="text" name="smallCategoryRate" value="'+result[i].CAT_PERCENT+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="배율"></div>');	
					}
					 /* alert("result["+i+"].CAT_SEQ : " + result[i].CAT_SEQ + " , result["+i+"].CAT_NM : " + result[i].CAT_NM); 
					 
					 $('#'+result[i].MID_CAT_SEQ+'small').append(sb3.ToString());
					
			}
			
		if (check==true && checkPer%100 !=0) {
			//alert("소분류에 배율 설정이 필요합니다.");
				} 
			}
		}); */
		
	//if (check==false) {
		$.ajax({
			url	:	"<c:url value='/student/TestManagement/makeProgressInSmall'/>",
			type:	"post",
			data:	{
				"crc_id" : crc_id,
				"gisu_id": gisu_id,		
			},
			success: function(result){
				var BigCat = new Array();
				var MidCat = new Array();
				var SmallCat = new Array();
				progressColor = 0;
				for (var i = 0; i < result.length; i++) {
					if (result[i].BIG_CAT_SEQ ==0 && result[i].MID_CAT_SEQ ==0 ) {
						BigCat.push(result[i]);
					} else if (result[i].BIG_CAT_SEQ !=0 && result[i].MID_CAT_SEQ == 0) {
						MidCat.push(result[i]);
					}else if (result[i].BIG_CAT_SEQ != 0 && result[i].MID_CAT_SEQ != 0) {
						SmallCat.push(result[i]);
					}
				}
				
				
				for (var i = 0; i < SmallCat.length; i++) {
					big_seqq = 0;
					big_percent = 0;
					mid_percent = 0;
					for (var j = 0; j < MidCat.length; j++) {
						if (SmallCat[i].MID_CAT_SEQ == MidCat[j].CAT_SEQ) {
							big_seqq = MidCat[j].BIG_CAT_SEQ;
							mid_percent = MidCat[j].CAT_PERCENT;
							break;
						}
					}
					for (var j = 0; j < BigCat.length; j++) {
						if (big_seqq == BigCat[j].CAT_SEQ) {
							big_percent = BigCat[j].CAT_PERCENT;
							break;
						}
					}
					var sbbb = new StringBuilder();
					var width1 = 0;
					width1 = Number(SmallCat[i].CAT_PERCENT*mid_percent*big_percent)/10000;
					
					sbbb.Append('<div class="progress-bar '+progressColors[progressColor%5]+' progress-bar-striped active" style="width: '+width1+'%">'+SmallCat[i].CAT_NM+'('+width1+'%)</div>');
					progressColor = Number(Number(progressColor) + 1);
					$("#smallProgress").append(sbbb.ToString());
				}
				
				
				}
			});
	//}
}

function findTest(){
	var sb = new StringBuilder();
	var sb2 = new StringBuilder();
	var sb3= new StringBuilder();
	var firstCheck = false;
	$("#testCategory").html('');
	$("#memberTestTable").html('');
	$("#TestTable").html('');
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	var first = 0;
	var check = false;
	$.ajax({
		url	:	"<c:url value='/student/TestManagement/searchTestList'/>",
		type:	"post",
		data:	{
			"crc_id" : crc_id,
			"gisu_id": gisu_id,	
		},
		success:function(result){
			var ok = 'glyphicon glyphicon-ok';
			var no = 'glyphicon glyphicon-remove';
			sb3.Append('<tr>');
			sb3.Append('<td class="active">분류</td>');
			sb3.Append('<td class="active">시험명</td>');
			sb3.Append('<td class="active">총점수</td>');
			sb3.Append('<td class="active">재응시횟수</td>');
			sb3.Append('<td class="active">시작일</td>');
			sb3.Append('<td class="active">종료일</td>');
			sb3.Append('<td class="active">등록일</td>');
			sb3.Append('<td class="active">채점여부</td>');
			sb3.Append('<td class="active"></td></tr>');
			
			if (result.length != 0) {
				first = result[0].TEST_SEQ;	
				check = true;
			}
			for (var i = 0; i < result.length; i++) {
/* 				if (result[i].MID_CAT_NM === undefined || result[i].MID_CAT_NM =='undefined') {
					continue;
				} */
				if (result[i].SMALL_CAT_NM === undefined || result[i].SMALL_CAT_NM =='undefined') {
					continue;
				}
				if (result[i].TEST_NM === undefined || result[i].TEST_NM =='undefined') {
					continue;
				}
				if (firstCheck==false) {
					sb.Append('<option value='+result[i].TEST_SEQ+' selected>'+result[i].TEST_NM+'</option>"');
					firstCheck = true;
				}
				else sb.Append('<option value='+result[i].TEST_SEQ+'>'+result[i].TEST_NM+'</option>"');
				
				sb2.Append('<option value='+result[i].TEST_SEQ+'>'+result[i].TEST_NM+'</option>"');
				
				sb3.Append('<tr>');
				//sb3.Append('<td>'+ result[i].MID_CAT_NM +'</td>');
				sb3.Append('<td>'+ result[i].SMALL_CAT_NM +'</td>');
				sb3.Append('<td>'+ result[i].TEST_NM +'</td>');
				sb3.Append('<td>'+ result[i].TOTAL_SCORE +'</td>');
				sb3.Append('<td>'+ result[i].RETEST_TIME +'</td>');
				sb3.Append('<td>'+ new Date(result[i].TEST_START_DATE).toString().substring(0,15) +'</td>');
				sb3.Append('<td>'+ new Date(result[i].TEST_END_DATE).toString().substring(0,15) +'</td>');
				sb3.Append('<td>'+ new Date(result[i].TEST_REGDATE).toString().substring(0,15) +'</td>');
				if (result[i].TEST_YN == 'FALSE') {
					sb3.Append('<td><span class="'+ no +'"></span></td>');
				} else if (result[i].TEST_YN == 'TRUE') {
					sb3.Append('<td><span class="'+ ok +'"></span></td>');
				}
				//sb3.Append('<td><button class="btn" style="margin-right: 2%" onclick="updateTestData('+result[i].TEST_SEQ+',1)">수정</button><button class="btn" onclick="updateTestData('+result[i].TEST_SEQ+',2)">삭제</button></td></tr>');
				sb3.Append('<td><button class="btn" onclick="updateTestData('+result[i].TEST_SEQ+',2)">삭제</button></td></tr>');
			}
			$("#testCategory").append(sb.ToString());
			$("#TestTable").append(sb3.ToString());
			},
			complete:function(){
				TestListAll();
			}
		});
}
/* 

	<tr>
	<td>일본어</td>
	<td>1차역량</td>
	<td>100점</td>
	<td>3회</td>
	<td>2020-07-07</td>
	<td>2020-07-07</td>
	<td>2020-01-01</td>
	<td><span class="glyphicon glyphicon-ok"></span></td>
	<td><button class="btn" style="margin-right: 2%">수정</button><button class="btn">삭제</button></td>
</tr>
 */


function TestListAll(value){
	var sb = new StringBuilder();
	var sb2 = new StringBuilder();
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	var test_seq = 0;
	$("#searchMs").html('');
	var test_seq = $("#testCategory option:selected").val();
	if (test_seq == '시험을 선택해주세요.') {
		test_seq = '-1';
	}
	$.ajax({
		url	:	"<c:url value='/student/TestManagement/TestListAll'/>",
		type:	"post",
		data:	{
			"crc_id" : crc_id,
			"gisu_id": gisu_id,
			"test_seq": test_seq
		},
		success:function(result){
			if (result.length == 0) {
				return;
			}
			$("#memberTestTable").html('');
			sb.Append('<tr>'); 
			sb.Append('<td class="active">기수</td>');
			sb.Append('<td class="active">학생이름</td>');
			sb.Append('<td class="active">학생ID</td>');
			sb.Append('<td class="active">생년월일</td>');
			sb.Append('<td class="active">점수</td>');
			sb.Append('<td class="active">가산점</td>');
			sb.Append('<td class="active">비고</td>');
			/* sb.Append('<td class="active">재응시</td>'); */
			sb.Append('</tr>');
			sb.Append('<tr>'); 
			sb.Append('<td class="active">'+result[0].CARDINAL_NAME+'</td>');
			sb.Append('<td>'+'<label>전체</label>'+'</td>');
			sb.Append('<td>'+'<label>전체</label>'+'</td>');
			sb.Append('<td>'+'<label>0000-00-00</label>'+'</td>');
			sb.Append('<td><input type="text" name="totalAddScore" value=""  numberOnly onkeypress="return Enter_Check(this,event)" style="margin-bottom: 10px" placeholder="입력 후 Enter를 누르시면"></td>');
			sb.Append('<td><input type="text" name="totalAddPlusScore" value=""  numberOnly onkeypress="return Enter_Check(this,event)" style="margin-bottom: 10px" placeholder="데이터가 누적됩니다."></td>');
			sb.Append('<td> <button class="btn" onclick="clearScoreData(this)" value="score" style="margin-left: 10px;">점수초기화</button><button class="btn" value="plusScore" onclick="clearScoreData(this)"  style="margin-left: 10px;">가산점초기화</button> </td>');
			/* sb.Append('<td style="width: 5%;"><label>-</label> </td>'); */
			sb.Append('</tr>');
			sb2.Append('<option value="" disabled hidden>이름 검색</option>');
			sb2.Append('<option value="">[전체 검색]</option>');
			for (var i = 0; i < result.length; i++) {
				if (result[i].USER_NAME === undefined) {
					continue;
				}
				sb2.Append('<option value="'+result[i].USER_ID+'">'+result[i].USER_NAME+'</option>');
				sb.Append('<tr>'); 
				sb.Append('<td class="active" name="lcardinal_id" data-info="'+result[i].CARDINAL_ID+'">'+result[i].CARDINAL_NAME+'</td>');
				sb.Append('<td><input type="hidden" name="luser_name" value="'+result[i].USER_NAME+'">'+result[i].USER_NAME+'</td>');
				sb.Append('<td><input type="hidden"  name="luser_id" value="'+result[i].USER_ID+'">'+result[i].USER_ID+'</td>');
				sb.Append('<td><input type="hidden"  name="lbirth_day" value="'+result[i].BIRTH_DAY+'">'+result[i].BIRTH_DAY+'</td>');
				if (result[i].SCORE === undefined) {
					sb.Append('<td style="width:5%;"><input type="text" name="lscore" value=""  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px;" placeholder=" 점수입력"></td>');
					sb.Append('<td style="width:5%;"><input type="text" name="lplus_score" value=""  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="미입력시 0점"></td>');
					sb.Append('<td><input type="text" name="lcomment" value=""></td>');	
				}else{
					sb.Append('<td><input type="text" name="lscore" value="'+result[i].SCORE+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder=" 점수입력"></td>');
					sb.Append('<td><input type="text" name="lplus_score" value="'+result[i].PLUS_SCORE+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder="미입력시 0점"></td>');
					sb.Append('<td><input type="text" name="lcomment" value="'+result[i].CONTENT+'"></td>');
				}
				/* sb.Append('<td style="width: 5%;"><select name="lretest"><option>0</option><option>1</option></select></td>'); */
				sb.Append('</tr>');
			}
			$("#searchMs").append(sb2.ToString());
			$("#memberTestTable").append(sb.ToString());
		},
		complete:function(){
			searchMemberScore();
		}
	});
}

function saveTestData(){
	
	var test_seq = $("#testCategory option:selected").val();
 	var crc_id = $("td[name$=lcardinal_id]").data('info');
 	var user_name = $("input[name$=luser_name]");
 	var user_id = $("input[name$=luser_id]");
 	var score = $("input[name$=lscore]");
	var plus_score = $("input[name$=lplus_score]");
 	var comment = $("input[name$=lcomment]");
 	/* var retest = $("select[name$=lretest] option:selected");
	 */var userInfo = new Object();
	var TestScoreList = new Array();
	var total = 0;
	var count = 0;
	var first = true;
	for (var i = 0; i < score.length; i++) {
		/* alert("score["+i+"] : " + score[i].value); */
		if (score[i].value == 0 || score[i].value == '') {
			
			if (first == true) {
				var check = confirm('미입력된 값 또는 0점이 존재합니다. 진행하겠습니까?');
				first = false;
			}
			
			if (check == false) {
				return;
			}
			if (check==true) {
				score[i].value = 0;
			}
		}
	}
	for (var i = 0; i < plus_score.length; i++) {
		if (plus_score[i].value == 0 || plus_score[i].value == '' ||plus_score[i].value==null) {
			plus_score[i].value = 0;
		}
	}

for (var i = 0; i < user_id.length; i++) {
	userInfo = new Object();
	userInfo.test_seq = test_seq;
	userInfo.user_id = user_id[i].value;
	userInfo.crc_id = crc_id;
	userInfo.score = score[i].value;
	userInfo.plus_score = plus_score[i].value;
	userInfo.comment = comment[i].value;
	TestScoreList.push(userInfo);
}


var jsonStr = JSON.stringify(TestScoreList);

		$.ajax({
			url:"<c:url value='/student/TestManagement/saveTestData'/>",
			type:		"post",
			dataType:	"json",
			contentType: 'application/json; charset=UTF-8',
			data: jsonStr,
			success:function(result){
					alert('저장에 성공했습니다.');
			},
			complete:function(){
				findTest();
			}
		});
}

function Enter_Check(obj,evt){
	
if(evt.keyCode == 13){
	if ($(obj).attr('name')=='totalAddPlusScore') {
		totalAdd(obj,'totalAddPlusScore',$(obj).val());	
		alert('누적되었습니다..');
		$(obj).val('');
	}else if ($(obj).attr('name')=='totalAddScore') {
		totalAdd(obj,'totalAddScore',$(obj).val());
		alert('누적되었습니다..');
		$(obj).val('');
	}
	return false;
	}
var charCode = (evt.which) ? evt.which : event.keyCode;
if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
    return false;
var _value = event.srcElement.value;       
var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
if (_pattern0.test(_value)) {
    if (charCode == 46) {
        return false;
    }
}

var _pattern1 = /^\d{3}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
if (_pattern1.test(_value)) {
    if (charCode != 46) {
        alert("100 이하의 숫자만 입력가능합니다");
        $(obj).val('');
        return false;
    }
}

var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
if (_pattern2.test(_value)) {
    alert("소수점 둘째자리까지만 입력가능합니다.");
    return false;
}     
return true;
}

function totalAdd(obj,name,scores){
 	var score = $("input[name$=lscore]");
	var plus_score = $("input[name$=lplus_score]");
	
	if (name == 'totalAddPlusScore') {
		for (var i = 0; i < plus_score.length; i++) {
				
			if (plus_score[i].value == 0 || plus_score[i].value == '' ||plus_score[i].value==null) {
					plus_score[i].value = Number(Number(0)+Number(scores));
				}else{
					plus_score[i].value = Number(Number(plus_score[i].value)+Number(scores));
				}
			}
		} else if (name == 'totalAddScore') {
		for (var i = 0; i < score.length; i++) {
			if (score[i].value == 0 || score[i].value == '' ||score[i].value==null) {
				score[i].value = Number(Number(0)+Number(scores));
			}else{
				score[i].value = Number(Number(score[i].value)+Number(scores));
			}
		
		}
	}
}


function clearTestData(){
	var test_seq = $("#testCategory option:selected").val();
	if (confirm("데이터를 삭제하시겠습니까?(전체 삭제)")) {
		$.ajax({
			url	:	"<c:url value='/student/TestManagement/ClearTesting'/>",
			type:	"post",
			data:	{
				"test_seq": test_seq
			},
			success:function(result){
				var score = $("input[name$=lscore]");
				var plus_score = $("input[name$=lplus_score]");
				var comment = $("input[name$=lcomment]");
				for (var i = 0; i < score.length; i++) {
					score[i].value = '';
					plus_score[i].value = '';
					comment[i].value = '';
				}	
			}			
		});
	
	}
	
	
	
}

function clearScoreData(obj){
	var score = $("input[name$=lscore]");
	var plus_score = $("input[name$=lplus_score]");
	
	if ($(obj).val()=="plusScore") {
		for (var i = 0; i < plus_score.length; i++) {
			plus_score[i].value = '';
			}
	} else if ($(obj).val()=="score") {
		for (var i = 0; i < score.length; i++) {
			score[i].value = '';
		}
	}
}


function changeTestCategory(check){
	if (check == 'searchTestDiv') {
		$(".searchTestDiv").show();
		$(".createTestDiv").hide();
	} else if(check =='createTestDiv'){
		$(".searchTestDiv").hide();
		$(".createTestDiv").show();
	}
}

/* <tr> 
<td class="active">기수</td>
	<td class="active">학생이름</td>
	<td class="active">클래스</td>
	<td class="active">학생ID</td>
	<td class="active">생년월일</td>
	<td class="active">전체 점수</td>
	<td class="active">전체 등급</td>
</tr> */
function searchMemberScore(){
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	$(".modalcont").remove();
	var sb = new StringBuilder();
	var sbH = new StringBuilder();
	var sbS1 = new StringBuilder();
	var sbS2 = new StringBuilder();
	var sbModal = new StringBuilder();
	
	var bB = new StringBuilder();
	var bM = new StringBuilder();
	var bS = new StringBuilder();
	var bT = new StringBuilder();
	var ss = new StringBuilder();
	var testName = new Array();
	var testnm = new Array();
	var count = new Object();
	var all = new Array();
	var B = new Array();
	var M = new Array();
	var S = new Array();
	var tS = new StringBuilder();
	var sH = new StringBuilder();
	
	var allData = {"gisu_id" : $("#gisuList").val(), "crc_id" : $("#gisuValue").val()};
	$("#searchMemberTestTable").html("");
	$("#searchMemberTestTableHide").html("");
	
	$.ajax({
		url:"<c:url value='/student/TestManagement/searchtUserTestInfo'/>",
		type:		"post",
		data: allData,
		success:function(result){
			var sp = 0;
			var rank = 1;
			var user_id = '';
			if ($("#searchMs").val() != '') {
				user_id = $("#searchMs").val();
			}
 			result.sort(function(a,b) {
				return parseFloat(b.TOTAL) - parseFloat(a.TOTAL);
			});
 
			for (var i = 0; i < result.length; i++) {
							
				var test=result[i];
				
				if (i == 0) {
					bB.Append('<thead><tr><td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">등수</td>');
					bB.Append('<td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">이름</td>');
					bB.Append('<td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">아이디</td>');
					
					for (var key in test) {
						if (key=='USER_ID' || key == 'TOTAL' || key =='USER_NM') continue;
						var str = key.split('▨');
						if (key.indexOf('대분류▨') != -1) {
							var big = new Object();
							big.cat_nm = str[1];
							big.big_cat_nm = 0;
							big.mid_cat_nm = 0;
							all.push(big);
							sH.Append('<td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">'+str[1]+'</td>');
						} else if(key.indexOf('중분류▨') != -1){
							var mid = new Object();
							mid.cat_nm = str[2];
							mid.big_cat_nm = str[1];
							mid.mid_cat_nm = 0;
							all.push(mid);
						} else if(key.indexOf('소분류▨') != -1) {
							var small = new Object();
							small.big_cat_nm = str[1];
							small.mid_cat_nm = str[2];
							small.cat_nm = str[3];
							all.push(small);
						}
					}
					
					for (var key in test) {
						if (key=='USER_ID' || key == 'TOTAL' || key =='USER_NM') continue;
						var str = key.split('▨');
						
						if(key.indexOf('소분류▨') != -1 || key.indexOf('중분류▨') != -1 || key.indexOf('대분류▨') != -1) {
							continue;	
						} else {
							all.forEach(function(item){
								if(item.cat_nm == str[0] && item.big_cat_nm != 0 && item.mid_cat_nm != 0) {
									var test = new Object();
									test.small_cat_nm = str[0];
									test.test_nm = str[1];
									testName.push(test);
								}
							})	
						}
					}
					
					testName.sort(function(a, b){
						return a.test_nm < b.test_nm ? -1 : a.test_nm > b.test_nm ? 1 : 0;
					})
					
					
					all.forEach(function(item){
						if(item.big_cat_nm != 0 && item.mid_cat_nm != 0) {
							S.push(item.cat_nm);
						} else if(item.big_cat_nm != 0 && item.mid_cat_nm == 0) {
							M.push(item.cat_nm);
						} else {
							B.push(item.cat_nm);
						}
					})
					
					B.sort();
					M.sort();
					S.sort();
					
					
					for(var a = 0; a < S.length; a++) {
						var ck = 0;
						testName.forEach(function(item){
							if(item.small_cat_nm == S[a]) {
								ck++;
							}
						})
						count[S[a]] = ck;
					}
					
					
					for(var a = 0; a < B.length; a++) {
						var cat = B[a];
						var ck = 0;
						var small = new Array();
						
						all.forEach(function(item){
							if(item.big_cat_nm == cat && item.mid_cat_nm != 0) {
								small.push(item.cat_nm);
							}
						})
						
						
						for(var key in count) {
							for(var z = 0; z < small.length; z++) {
								if(key == small[z]) {
									ck += count[key];
								}
							}
						}
						if(ck == 0) {
							bB.Append('<td class="success">'+cat+'</td>');
						} else {
							bB.Append('<td colspan="'+ck+'" class="success">'+cat+'</td>');	
						}
					}
					
					sH.Append('<td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">종합</td>');
					sbH.Append(bB.ToString()+sH.ToString()+'</tr>');
					bB.Append('<td rowspan="4" style="text-align: center; vertical-align: middle;" class="active">종합</td></tr>');
					
					bM.Append('<tr>');
					
					for(var a = 0; a < B.length; a++) {
						for(var b = 0; b < M.length; b++) {
							var big = B[a];
							var mid = M[b];
							
							
							var ck = 0;
							var small = new Array();
							
							all.forEach(function(item){
								if(item.mid_cat_nm == mid && item.big_cat_nm == big) {
									small.push(item.cat_nm);
								}
							})
							
							if(!small.length) {
								continue;
							}
							
							
							for(var key in count) {
								for(var z = 0; z < small.length; z++) {
									if(key == small[z]) {
										ck += count[key];
									}
								}
							}
							if(ck == 0) {
								bM.Append('<td class="warning">'+mid+'</td>');
							} else {
								bM.Append('<td colspan="'+ck+'" class="warning">'+mid+'</td>');	
							}
						}
					}
					
					bM.Append('</tr>');
					
					bS.Append('<tr>');
					var sss = new Array();
					
					
					for(var a = 0; a < B.length; a++) {
						for(var b = 0; b < M.length; b++) {
							for(var c = 0; c < S.length; c++) {
								var big = B[a];
								var mid = M[b];
								var sm = S[c];
					
								var ck = 0;
								var small = new Array();
					
								all.forEach(function(item){
									if(item.cat_nm == sm && item.mid_cat_nm == mid && item.big_cat_nm == big) {
										small.push(item.cat_nm);
									}
								})
					
								if(!small.length) {
									continue;
								}
					
					
								for(var key in count) {
									for(var z = 0; z < small.length; z++) {
										if(key == small[z]) {
											ck += count[key];
										}
									}
								}
								if(ck == 0) {
									bS.Append('<td class="info">'+sm+'</td>');
								} else {
									bS.Append('<td colspan="'+ck+'" class="info">'+sm+'</td>');	
								}
								sss.push(sm);
							}
						}
					}
					
					bS.Append('</tr>');
					
					bT.Append('<tr>');
					for(var a = 0; a < sss.length; a++) {
						testName.forEach(function(item){
							if(sss[a] == item.small_cat_nm) {
								bT.Append('<td class="danger">'+item.test_nm+'</td>')
								testnm.push(item.test_nm);
							}
						})
					}
					bT.Append('</tr>');
					ss.Append(bB.ToString()+bM.ToString()+bS.ToString()+bT.ToString()+"</thead>");
					sbH.Append(bM.ToString()+bS.ToString()+bT.ToString()+"</thead>");
				}
 				if (result[i].TOTAL === undefined) {
					continue;
				}
				if (i != 0) {
					if (result[i-1].TOTAL == result[i].TOTAL) {
						var sp = sp+1;
						var rank = (i+1)-sp;
					}	else{
						sp = 0;
						rank = i+1;
					}
				}
				
				sb = new StringBuilder();
				
				
				if (user_id == '' || user_id == result[i].USER_ID) {
					ss.Append('<tbody><tr><td class="active">'+rank+' / '+result.length+'</td>');
					ss.Append('<td>'+result[i].USER_NM+'</td>');
					ss.Append('<td>'+result[i].USER_ID+'</td>');
					sb.Append('<tbody><tr><td class="active">'+(i+1)+'등</td>');
					sb.Append('<td>'+result[i].USER_NM+'</td>');
					sb.Append('<td>'+result[i].USER_ID+'</td>');
				
				} else if (user_id != result[i].USER_ID){
					continue;
				}

				sbS1 = new StringBuilder();
				sbS2 = new StringBuilder();
				sbModal = new StringBuilder();
				tS = new StringBuilder();
				
				for(var a = 0; a < testnm.length; a++) {
					for (var key in test) {
						var str = key.split('▨');
						if (key=='USER_ID' || key == 'TOTAL' || key =='USER_NM') continue;
						if(testnm[a] == str[1]) {
							tS.Append('<td>'+test[key].split('/')[0]+'</td>');
						}
						if(a == 0) {
							if (key.indexOf('대분류▨') != -1) {
								sbS1.Append('<td class="active">'+str[1]+'</td>');
								sbS2.Append('<td>'+test[key]+' '+gradeSelect(test[key])+'</td>');
							}
						}
					}
				}
				sbS1.Append('<td class="active">종합</td>');
				sbS2.Append('<td>'+result[i].TOTAL+' '+gradeSelect(result[i].TOTAL)+'</td>');
				
				sbH.Append(sb.ToString()+tS.ToString()+sbS2.ToString()+'</tr>');
				
				var name = result[i].USER_ID;
				ss.Append(tS.ToString());
				ss.Append('<td><button type="button" class="btn btn-primary" data-toggle="modal" onclick="modals(\''+name+'\')" data-target="#myModal'+name+'">종합</button></td>');
				sbModal.Append('<div class="modal fade bs-example-modal-lg modalcont" id="myModal'+name+'" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">');
				sbModal.Append('<div class="modal-dialog modal-lg">');
				sbModal.Append('<div class="modal-content"><div align="center" style="margin:1%;margin-bottom:10%;align-items:center; vertical-align:middle;">');
				sbModal.Append('<h1 style="margin-bottom:5%;margin-top:5%;">'+result[i].USER_NM+'의 종합 성적 내역</h1>');
				sbModal.Append('<table class="table table-bordered table-hover" style=" width:90%; text-align:center;">');
				sbModal.Append('<thead><tr id="smallTable-'+name+'"></tr></thead>');
				sbModal.Append('<tbody><tr id="smallTableData-'+name+'"></tr></tbody>');
				sbModal.Append('</table></div>');
				sbModal.Append('</div></div></div>');
				ss.Append('</tr>');
				$("#modalContents").append(sbModal.ToString());
				$("#smallTable-"+name).append(sbS1.ToString());
				$("#smallTableData-"+name).append(sbS2.ToString());
			}
 			
			$("#searchMemberTestTable").append(ss.ToString()+'</tbody>');
			$("#searchMemberTestTableHide").append(sbH.ToString()+'</tbody>');
		},
		complete:function(){
			
			if ($("#searchMemberTestTable").html() == null || $("#searchMemberTestTable").html() == '' || $("#searchMemberTestTable").html() == ' ' || $("#searchMemberTestTable").html() == 'null') {
				$("#searchMemberTestTable").append('<tr><td>해당하는 정보가 없습니다.</td></tr>');
			}
		}
	});
}
function gradeSelect(score){
	var grade = "(Bronze)";
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	allData = {
		"cardinal_id": gisu_id,
		"course_id": crc_id
	};
	$.ajax({
		url:"<c:url value='/student/TestManagement/searchGrade'/>",
		type:		"POST",
		data: allData,
		async: false,
		success:function(result){
			if(result == 'undefined' || result == 'null' || result === undefined || result == null || result =='') {
				if (score == 100) {
					grade = "(Diamond)";
				} else if (score>=90) {
					grade = "(Gold)";
				} else if (score>=80) {
					grade = "(Silver)";
				} else {
					grade = "(Bronze)";
				}
			} else {
				for(var i = 0; i < result.length; i++) {
					if(parseFloat(result[i].START_SCORE) > score && parseFloat(result[i].END_SCORE) <= score) {
						grade = "(" + result[i].GRADE + ")";
						break;
					}
				}
			}
		}
	});
	
	return grade;
}

function findGrade(){
	var sb3= new StringBuilder();
	var name = $("#gisuList option:selected").text();
	$("#gradeTable").html('');
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();

	$.ajax({
		url	:	"<c:url value='/student/TestManagement/searchGrade'/>",
		type: "POST",
		data:	{
			"cardinal_id": gisu_id,
			"course_id": crc_id
		},
		success:function(result){
			
			sb3.Append('<tr>');
			sb3.Append('<td class="active">최고 점수</td>');
			sb3.Append('<td class="active">최저 점수</td>');
			sb3.Append('<td class="active">등급</td><td class="active"></td></tr>');
			
			if(result.length == 0) {
				//alert("등급 점수를 설정해주세요. 임시 점수로 구분합니다.");
				//$("#gradeTable").append(sb3.ToString());
				return;
			}
			
			for(var i = 0; i < result.length; i++) {
				sb3.Append('<tr class="gradeC">');
				sb3.Append('<input type="hidden" name="grade_seq" value='+result[i].GRADE_SEQ+'>');
				sb3.Append('<input type="hidden" name="gcourse_id" value="'+result[i].COURSE_ID+'">');
				sb3.Append('<input type="hidden" name="gcardinal_id" value="'+result[i].CARDINAL_ID+'">');
				sb3.Append('<td><input type="text" name="gstart" value="'+result[i].START_SCORE+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder=" 점수입력"></td>');
				sb3.Append('<td><input type="text" name="gend" value="'+result[i].END_SCORE+'"  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder=" 점수입력"></td>');
				sb3.Append('<td><input type="text" name="ggrade" value="'+result[i].GRADE+'" style="margin-bottom: 10px" placeholder=" 등급입력"></td>');
				sb3.Append('<td><button class="btn" onclick="deleteGrade('+result[i].GRADE_SEQ+')">삭제</button></td>');
				sb3.Append('</tr>');
			}

			$("#gradeTable").append(sb3.ToString());
		}
	});
}
function deleteGrade(seq) {
	if(!confirm("등급을 삭제하시겠습니까?")) {
		return;
	} else {
		$.ajax({
			url:"<c:url value='/student/TestManagement/deleteGrade'/>",
			type: "POST",
			data: {
				"grade_seq" : seq
			},
			success:function(result){
				if(result == "FALSE") {
					alert('삭제에 실패했습니다.');
				} else if(result == "TRUE") {
					alert('삭제에 성공했습니다.');
				}
			},
			complete:function(){
				findGrade();
				searchMemberScore();
			}
		});	
	}
}

function saveGradeData() {
	var crc_id = $("#gisuValue").val();
	
	var gradeList = new Array();
	var gradeInfo = new Object();
	var grade_seq;
	var course_id;
	var cardinal_id;
	var start_score;
	var end_score;
	var grade;
	
	$('tr.gradeC').each(function(){
		grade_seq = $(this).find('input[name$=grade_seq]').val();
		course_id = $(this).find('input[name$=gcourse_id]').val();
		cardinal_id = $(this).find('input[name$=gcardinal_id]').val();
		start_score = $(this).find('input[name$=gstart]').val();
		end_score = $(this).find('input[name$=gend]').val();
		grade = $(this).find('input[name$=ggrade]').val();
		
		if(start_score == '' || start_score == 'null' || start_score == null || start_score == undefined || start_score == 'undefined') {
			$(this).find('input[name$=gstart]').focus();
			return;
		}
		
		if(end_score == '' || end_score == 'null' || end_score == null || end_score == undefined || end_score == 'undefined') {
			alert("최저 점수가 미입력됐습니다.");
			$(this).find('input[name$=gend]').focus();
			return;
		}
		
		if(grade == '' || isNaN(Number(grade)) == false) {
			alert('등급을 제대로 입력하세요.');
			$(this).find('input[name$=ggrade]').focus();
			return;
		}
		
		gradeInfo = new Object();
		gradeInfo.grade_seq = grade_seq;
		gradeInfo.course_id = course_id;
		gradeInfo.cardinal_id = cardinal_id;
		gradeInfo.start_score = start_score;
		gradeInfo.end_score = end_score;
		gradeInfo.grade = grade;
		
		gradeList.push(gradeInfo);
	})
	

	var jsonStr = JSON.stringify(gradeList);
		 $.ajax({
			url:"<c:url value='/student/TestManagement/saveGrade'/>",
			type: "POST",
			contentType: 'application/json; charset=UTF-8',
			data: jsonStr,
			success:function(result){
				if(result == "FALSE") {
					alert('저장에 실패했습니다.');
				} else if(result == "TRUE") {
					alert('저장에 성공했습니다.');
				}
			},
			complete:function(){
				findGrade();
				searchMemberScore();
			}
		});
}

function addGrade() {
	var car_nm = $("#gisuList option:selected").text();
	var crc_nm = $("#gisuValue option:selected").text();
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	
	var sb3= new StringBuilder();
	
	sb3.Append('<tr class="gradeC">');
	sb3.Append('<input type="hidden" name="grade_seq" value="0">');
	sb3.Append('<input type="hidden" name="gcourse_id" value="'+crc_id+'">');
	sb3.Append('<input type="hidden" name="gcardinal_id" value="'+gisu_id+'">');
	sb3.Append('<td><input type="text" name="gstart" value=""  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder=" 점수입력"></td>');
	sb3.Append('<td><input type="text" name="gend" value=""  numberOnly onkeypress="return isNumberKey(this,event)" style="margin-bottom: 10px" placeholder=" 점수입력"></td>');
	sb3.Append('<td><input type="text" name="ggrade" value="" style="margin-bottom: 10px" placeholder=" 등급입력"></td>');
	sb3.Append('<td class="active"><button class="btn deletebtn">삭제</button></td>');
	sb3.Append('</tr>');
	$("#gradeTable").append(sb3.ToString());
	
	$('.deletebtn').on('click', function(){
		$(this).parent().parent().remove();
	});
}

function clearGradeData() {
	var score = $("input[name$=gscore]");
	
	for (var i = 0; i < score.length; i++) {
		plus_score[i].value = '';
	}
}

function modals(obj){
	//alert(obj);
	$('#myModal'+obj+'').focus();
}

function updateTestData(seq, mode){
	var gisu_id = $("#gisuList").val();
	var crc_id = $("#gisuValue").val();
	if (mode == 1 ) {
		alert(seq + ' , ' + 'update');
	}else if(mode == 2){
		if (confirm('삭제하시겠습니까??')) {
			$.ajax({
				url	:	"<c:url value='/student/TestManagement/deleteTestInfo'/>",
				type:	"post",
				data:	{
					"crc_id" : crc_id,
					"gisu_id": gisu_id,
					"test_seq": seq
				},
				complete:function(){
					createUpperCategory();
				},
				error:function(error){
					alert(error.statusText);
				}
			});
		}
	}
}

function reloadData(){
	createSmallCat();
	categorySetting();
	findTest();
	findGrade();
}



function checkTestName(obj){
	var allData = {"gisu_id" : $("#gisuList").val(), "crc_id" : $("#gisuValue").val(), "cat_nm" : obj.value};
	var jsonStr = JSON.stringify(allData);
		$.ajax({
		url:"<c:url value='/student/TestManagement/checkTestName'/>",
		type:		"post",
		data: allData,
		success:function(result){
				if (result >= 1) {
					alert('중복된 제목입니다..');
					obj.value = '';
			}
		}
	});
}

function createUpperClass(){
	var sb = new StringBuilder();
	sb.Append('<li class="classssection">');
	sb.Append('<div class="gnb dd-flex">');
	sb.Append('<input type="text" class="form-control" name="className bigName" placeholder="상위 반 이름" onblur="checkClassInfo(this)" style="width: 50%;margin: 4px 0px 4px 4px;"><div>');
	sb.Append('<button type="button" class="btnd btnd-plus" style="z-index:1;" onclick="plusClass(this)"><span class="glyphicon glyphicon-plus"></span></button>');
	sb.Append('<input type="hidden" name="classSeq classBigSeq" value="-1">');
	sb.Append('<button type="button" class="btnd btnd-remove" style="float: right;z-index: 1;" onclick="removeClass(this)"><span class="glyphicon glyphicon-remove"></span></button></div></div>');
	sb.Append('<ul class="lnb">');
	sb.Append('</ul>');
	sb.Append('</li>');	
	$("#classGroup").append(sb.ToString());
}



function plusClass(obj){
	var sb = new StringBuilder();
	sb.Append('<li><input type="text" class="form-control" name="className" placeholder="반 이름" onblur="checkClassInfo(this)" style="width: 50%; margin: 4px 0px 4px 4px;">');
	sb.Append('<input type="hidden" name="classSeq" value="-1">');
	sb.Append('<button type="button" class="btnd btnd-remove" style="float: right;margin: 4px 10px;z-index: 1;" onclick="removeClass(this)">');
	sb.Append('<span class="glyphicon glyphicon-remove"></span></button></li>');
	$(obj).closest('li').find('ul').append(sb.ToString());
}


function saveClassInfo(){
	var classSeqList = new Array();
	var classNameList = new Array();
	var classBigSeqList = new Array();
	var classBigNameList = new Array();
	var classBigInfoList = new Array();
	var classInfoList = new Array();
	var classBigNameList = new Array();
	var classInfo = new Object();
	classBigSeqList = $("input[name*=classBigSeq]");
	classBigNameList = $("input[name*=bigName]");
	classSeqList = $("input[name*=classSeq]");
	classNameList = $("input[name*=className]");
	
	var gisu_id = $("#gisuList").val();
	var crc_id =  $("#gisuValue").val();
	if (gisu_id == 'undefined' || gisu_id == 'null' || gisu_id === undefined || gisu_id == null || gisu_id =='') {
		return alert('과정 및 기수 설정이 안되있습니다.');
	}
	
	for (var i = 0; i < classBigNameList.length; i++) {
		if (classBigNameList[i].value === undefined || classBigNameList[i].value == '' || classBigNameList[i].value == ' ') {
			return alert('반 이름이 설정되지 않았습니다.');
		}
		classInfo = new Object();
		classInfo.class_seq = classBigSeqList[i].value;
		classInfo.class_name = classBigNameList[i].value;
		classInfo.gisu_id = gisu_id;
		classInfo.crc_id = crc_id;
		classBigInfoList.push(classInfo);
	}
	for (var i = 0; i < classNameList.length; i++) {
		if (classNameList[i].value === undefined || classNameList[i].value == '' || classNameList[i].value == ' ') {
			return alert('반 이름이 설정되지 않았습니다.');
		}
		classInfo = new Object();
		classInfo.class_seq = classSeqList[i].value;
		classInfo.class_name = classNameList[i].value;
		classInfo.gisu_id = gisu_id;
		classInfo.crc_id = crc_id;
		classInfoList.push(classInfo);
	}
	var upper_name = '';
	var upper_seq = '';
	for (var i = 0; i < classBigInfoList.length; i++) {
		for (var j = 0; j < classInfoList.length; j++) {
			if (classBigInfoList[i].class_name == classInfoList[j].class_name && classBigInfoList[i].class_seq == classInfoList[j].class_seq) {
				upper_name = classBigInfoList[i].class_name;
				upper_seq = classBigInfoList[i].class_seq;
			} 
			classInfoList[j].upper_class_name = upper_name;
			classInfoList[j].upper_class_seq = upper_seq;
		}
	}
	
	
	var jsonStr = JSON.stringify(classInfoList);
	$.ajax({
		url:"<c:url value='/student/TestManagement/insertClassList'/>",
		type:		"post",
		dataType:	"text",
		contentType: 'application/json; charset=UTF-8',
		data: jsonStr,
		success:function(result){
				alert("저장을 성공하였습니다.");
			
		},
		error:function(error){
			alert(error.statusText);
		},
		complete:function(){
			searchClassList();
		}
	});
	
	
}

function checkClassInfo(obj){
	if ($(obj).val() == '' || $(obj).val() == ' ') {
		$(obj).val('');
		return;
	}
	var classNameList = new Array();
	var count = 0;
	if ($(obj).closest('ul').attr('class') =='classGroup') {
		classNameList = $("input[name$=bigName]");	
	}
	if ($(obj).closest('ul').attr('class') == 'lnb') {
		classNameList = $(obj).closest('ul').find('input[type="text"]');
	}
	for (var i = 0; i < classNameList.length; i++) {
		if ($(obj).val() == classNameList[i].value) {
			count = count +1;
		}
		if (count == 2) {
			alert('중복된 이름이 존재합니다.');
			$(obj).val('');
		}
	}
}


function searchClassList(){
	$("#classGroup").html('');
	$("#selectClasss").html('');
	var allData = {"gisu_id" : $("#gisuList").val(), "crc_id" : $("#gisuValue").val()};
	$.ajax({
		url:"<c:url value='/student/TestManagement/searchClassList'/>",
		type:		"post",
		data: allData,
		success:function(result){
			var check = false;
			$("#selectClasss").append('<option value="" disabled hidden>반 선택</option>');
			$("#selectClasss").append('<option value="" selected>전체</option>');
				for (var i = 0; i < result.length; i++) {
					var data = result[i];
					var sb2 = new StringBuilder();
					if (data.class_upper_seq == 0 || data.class_upper_seq == '0') {
						var sb = new StringBuilder();
						sb.Append('<li class="classssection">');
						sb.Append('<div class="gnb dd-flex">');
						sb.Append('<input type="text" class="form-control" value="'+data.class_name+'" name="className bigName" placeholder="상위 반 이름" onblur="checkClassInfo(this)" style="width: 50%;margin: 4px 0px 4px 4px;"><div>');
						sb.Append('<button type="button" class="btnd btnd-plus" style="z-index:1;" onclick="plusClass(this)"><span class="glyphicon glyphicon-plus"></span></button>');
						sb.Append('<input type="hidden" name="classSeq classBigSeq" value="'+data.class_seq+'">');
						sb.Append('<button type="button" class="btnd btnd-remove" style="float: right;z-index: 1;" onclick="removeClass(this)"><span class="glyphicon glyphicon-remove"></span></button></div></div>');
						sb.Append('<ul class="lnb">');
						for (var j = 0; j < result.length; j++) {
							if (data.class_seq == result[j].class_upper_seq) {
								sb.Append('<li><input type="text" class="form-control" value="'+result[j].class_name+'"name="className" placeholder="반 이름" onblur="checkClassInfo(this)" style="width: 50%; margin: 4px 0px 4px 4px;">');
								sb.Append('<input type="hidden" name="classSeq" value="'+result[j].class_seq+'">');
								sb.Append('<button type="button" class="btnd btnd-remove" style="float: right;margin: 4px 10px;z-index: 1;" onclick="removeClass(this)">');
								sb.Append('<span class="glyphicon glyphicon-remove"></span></button></li>');
								sb2.Append('<option value="'+result[j].class_seq+'_'+data.class_seq+'">'+data.class_name +' - ' + result[j].class_name +'</option>');
							}
						}
						sb.Append('</ul>');
						sb.Append('</li>');	
						$("#classGroup").append(sb.ToString());
						
					}
					$("#selectClasss").append(sb2.ToString());
				}
				
			
		},
		error:function(error){
		},
		complete:function(){
			selectableUser();
		}
	});
}
function removeClass(obj){
	if (confirm('삭제하시겠습니까?')) {
		if ($(obj).prev().val() != -1) {
			var class_seq = $(obj).prev().val();
			$.ajax({
				url:"<c:url value='/student/TestManagement/deleteClassList'/>",
				type:"post",
				data: {"class_seq" : class_seq},
				success:function(result){
					alert('삭제했습니다.');
					},
					complete:function(){						
						searchClassList();
					}
				});
	}
		$(obj).closest('li').remove();	
		selectableUser();
}
}

/* 	<thead>
<tr class="info">
<td>이름</td>
<td>과정</td>
<td>기수</td>
<td>생년월일</td>
<td>전화번호</td>
<td>일본어</td>
<td>IT</td>
</tr>
</thead>
<tbody>
</tbody> */

/* function classInfo(){
	
	var AllData = {
			"crc_id" : $("#gisuValue").val(),
			"gisu_id": $("#gisuList").val(),
			"class_seq": class_seq,
			"user_id" : $("#selectUserInClass").val(),
			"class_upper_seq" : class_upper_seq,
			
	};
	$.ajax({
		url:"<c:url value='/student/TestManagement/selectableUser'/>",
		type:		"post",
		contentType: 'application/json; charset=UTF-8',
		data: jsonStr,
		success:function(result){
			
		}
	});

	
} */


function selectableUser(){

	var sb = new StringBuilder();
	var sb2 = new StringBuilder();
	var sb3 = new StringBuilder();
	var sb4 = new StringBuilder();
	var seq = $("#selectClasss").val();
/* 	if (seq == '' || seq == null || seq === undefined) {
		return alert("반 정보가 없습니다.");
	} */
	var class_seq = seq.split('_')[0];
	var class_upper_seq = seq.split('_')[1];
	var id = $("#selectUserInClass").val();
	if ($("#hdrdd").text() != $("#selectClasss option:selected").text()) {
		id='';
	}
	var AllData = {
			"crc_id" : $("#gisuValue").val(),
			"gisu_id": $("#gisuList").val(),
			"class_seq": class_seq,
			"user_id" : id,
			"class_upper_seq" : class_upper_seq,
			
	};
	var jsonStr = JSON.stringify(AllData);
	/* if (seq == '') {
		return;
	} */
	$.ajax({
		url:"<c:url value='/student/TestManagement/selectableUser'/>",
		type:		"post",
		contentType: 'application/json; charset=UTF-8',
		data: jsonStr,
		success:function(result){
			//$("#selectUserInClass").html('');
			$("#selectableUser").html("");
			$("#selectedUser").html("");
			$("#classInfoUser").html('');
			if (id == 'null' || id==null || id =='') {
				sb3.Append('<option value="" selected>전체</option>');	
			}
			var count = 0;
			if (result.length != 0) {
				var name = result[0].user_id;
				for (var i = 0; i < result.length; i++) {
					if (name != result[i].user_id) {
						break;
					}
					count = count +1;
				}
				/* alert(count); */
				for (var i = 0; i < result.length; i++) {
					if (result[i].class_seq ==0 && class_seq != 0) {
						sb.Append('<tr><td><input type="checkbox" name="user_CheckBox"></td>');
						sb.Append('<td>'+result[i].user_name+'</td>');
						sb.Append('<td>'+result[i].user_id+'</td>');
						sb.Append('<td>'+result[i].birth_day+'</td></tr>');	
					}
					if (class_seq == result[i].class_seq && class_seq != 0) {
						sb2.Append('<tr><td><input type="checkbox" name="user_CheckBox"></td>');
						sb2.Append('<td>'+result[i].user_name+'</td>');
						sb2.Append('<td>'+result[i].user_id+'</td>');
						sb2.Append('<td>'+result[i].birth_day+'</td></tr>');
						sb3.Append('<option value="'+result[i].user_id+'">'+result[i].user_name+'</option>');
					}
					if (i%count == 0 && class_seq == 0) {
						sb3.Append('<option value="'+result[i].user_id+'">'+result[i].user_name+'</option>');
					}	
				}
				 
		 		 for (var i = 0; i < result.length; i=i+count) {
					if (i==0) {
						sb4.Append('<thead><tr class="info">');
						sb4.Append('<td>이름</td>');
						sb4.Append('<td>ID</td>');
						sb4.Append('<td>과정</td>');
						sb4.Append('<td>기수</td>');
						sb4.Append('<td>생년월일</td>');
						sb4.Append('<td>전화번호</td>');
						for (var j = i; j < count+i; j++) {
							sb4.Append('<td>'+result[j].class_upper_name+'</td>');
						}
						sb4.Append('</tr>');	
						sb4.Append('<tbody>');
					}
					sb4.Append('<tr>');
					if (class_seq == result[i].class_seq && class_seq != 0) {
						sb4.Append('<td>'+ result[i].user_name+'</td>');
						sb4.Append('<td>'+ result[i].user_id+'</td>');
						sb4.Append('<td>'+ result[i].crc_name+'</td>');
						sb4.Append('<td>'+ result[i].gisu_name+'</td>');
						sb4.Append('<td>'+ result[i].birth_day+'</td>');
						sb4.Append('<td>'+ result[i].user_phone+'</td>');
						for (var j = i; j < count+i; j++) {
							if (result[j].class_name == '' || result[j].class_name == null || result[j].class_name ===undefined) {
								sb4.Append('<td class="danger""></td>');
							} else{
								sb4.Append('<td>'+result[j].class_name+'</td>');
							}
						}
						sb4.Append('</tr>');	
					} else if (class_seq == '') {
						sb4.Append('<td>'+ result[i].user_name+'</td>');
						sb4.Append('<td>'+ result[i].user_id+'</td>');
						sb4.Append('<td>'+ result[i].crc_name+'</td>');
						sb4.Append('<td>'+ result[i].gisu_name+'</td>');
						sb4.Append('<td>'+ result[i].birth_day+'</td>');
						sb4.Append('<td>'+ result[i].user_phone+'</td>');
						for (var j = i; j < count+i; j++) {
							if (result[j].class_name == '' || result[j].class_name == null || result[j].class_name ===undefined) {
								sb4.Append('<td class="danger"></td>');
							} else{
								sb4.Append('<td>'+result[j].class_name+'</td>');
							}
						}
						sb4.Append('</tr>');
					}
				}  
			}
			
		 		 
		/* 	
			for (var i = 0; i < result.length; i++) {
				if (i==0) {
					sb4.Append('<thead><tr class="info">');
					sb4.Append('<td>이름</td>');
					sb4.Append('<td>ID</td>');
					sb4.Append('<td>과정</td>');
					sb4.Append('<td>기수</td>');
					sb4.Append('<td>생년월일</td>');
					sb4.Append('<td>전화번호</td>');
					sb4.Append('<td>반</td>');
					sb4.Append('</tr>');	
					sb4.Append('<tbody>');
				}
				if ($("#selectClasss").val() == '') {
					sb4.Append('<tr>');
					sb4.Append('<td>'+ result[i].user_name+'</td>');
					sb4.Append('<td>'+ result[i].user_id+'</td>');
					sb4.Append('<td>'+ result[i].crc_name+'</td>');
					sb4.Append('<td>'+ result[i].gisu_name+'</td>');
					sb4.Append('<td>'+ result[i].birth_day+'</td>');
					sb4.Append('<td>'+ result[i].user_phone+'</td>');
					if (result[i].class_seq == 0) {
						sb4.Append('<td>'+result[i].class_upper_name+' - 미배정 </td>');
					} else{
						sb4.Append('<td>'+result[i].class_upper_name+' - '+result[i].class_name+'</td>');	
					}
					sb4.Append('</tr>');
				} else if (class_seq == result[i].class_seq && class_seq != 0) {
					sb4.Append('<tr>');
					sb4.Append('<td>'+ result[i].user_name+'</td>');
					sb4.Append('<td>'+ result[i].user_id+'</td>');
					sb4.Append('<td>'+ result[i].crc_name+'</td>');
					sb4.Append('<td>'+ result[i].gisu_name+'</td>');
					sb4.Append('<td>'+ result[i].birth_day+'</td>');
					sb4.Append('<td>'+ result[i].user_phone+'</td>');
					sb4.Append('<td>'+result[i].class_upper_name+' - '+result[i].class_name+'</td>');
					sb4.Append('</tr>');
				}
					
				// 중복해서 나오는 데이터들 하나로 뭉쳐서 나오게끔 변경..
				// >< 화살표 누르면 insert delete 되게 설정하면 끝
			}
			sb4.Append('</tbody>'); */
			$("#selectableUser").append(sb.ToString());
			$("#selectedUser").append(sb2.ToString());
			if ((id == 'null' || id==null || id =='') || ($("#hdrdd").text() != $("#selectClasss option:selected").text())) {
				$("#selectUserInClass").html('');
				$("#selectUserInClass").append(sb3.ToString());
			}	
			$("#classInfoUser").append(sb4.ToString());
			$("#hdrdd").html('');
			$("#hdrdd").html($("#selectClasss option:selected").text());
		},
		error:function(error){
			alert(error.statusText);
		},
		complete:function(){
		}
	});
	
	
	
}


function fnExcelReport() {
	var gisuName = $("#gisuList option:selected").text();
	if ($("#searchMs option:selected").text() == '[전체 검색]') {
		gisuName += gisuName + '_전체_성적표';
	}else{
		gisuName += gisuName + '_'+$("#searchMs option:selected").text()+'_성적표';
	}
	var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
	tab_text = tab_text + '<head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">';
	tab_text = tab_text + '<xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>'
	tab_text = tab_text + '<x:Name>Test Sheet</x:Name>';
	tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
	tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';
	tab_text = tab_text + "<table border='1px'>";
	var exportTable = $('#searchMemberTestTableHide').clone();
	exportTable.find('input').each(function (index, elem) { $(elem).remove(); });
	tab_text = tab_text + exportTable.html();
	tab_text = tab_text + '</table></body></html>';
	var data_type = 'data:application/vnd.ms-excel';
	var ua = window.navigator.userAgent;
	var msie = ua.indexOf("MSIE ");
	var fileName = gisuName + '.xls';
	//Explorer 환경에서 다운로드
	if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
	if (window.navigator.msSaveBlob) {
	var blob = new Blob([tab_text], {
	type: "application/csv;charset=utf-8;"
	});
	navigator.msSaveBlob(blob, fileName);
	}
	} else {
	var blob2 = new Blob([tab_text], {
	type: "application/csv;charset=utf-8;"
	});
	var filename = fileName;
	var elem = window.document.createElement('a');
	elem.href = window.URL.createObjectURL(blob2);
	elem.download = filename;
	document.body.appendChild(elem);
	elem.click();
	document.body.removeChild(elem);
	}

	};


/// 내일 업데이트 문 해야됨..
// 카테고리 seq 번호 있는놈 업데이트 시키는걸로.. 상위카테고리랑 하위카테고리 어떻게 나눌지 생각해둘것



</script>
<div style="display:none;">asdasd</div>
<div class="content_wraper" id="modalContents">
	<h3>성적관리</h3>	
	<div>
							 </div>
<div id="tabs_container">
    <ul id="tabs">
        <li><a href="#tab1" style="font-size: 1.3em;">정보 검색</a></li>
        <li><a href="#tab2" style="font-size: 1.3em;">성적 입력</a></li>
        <li><a href="#tab3" style="font-size: 1.3em;">시험 관리</a></li>
        <li><a href="#tab4" style="font-size: 1.3em;">배율 관리</a></li>
        <li><a href="#tab5" style="font-size: 1.3em;">등급 관리</a></li>
        <li><a href="#tab6" style="font-size: 1.3em;">반 관리</a></li>
    </ul>
</div>
			<dl>
				<dt>과정명<span class='require'>*</span></dt>
				<dd class="half select2_dd" id="gwajeongSelector">
					<select class="js-example-basic-single" name="state">

					</select>
				</dd>
				<dt>기수명<span class='require'>*</span></dt>
				<dd class="half select2_dd" id="gisuSelector">
				<select class="js-example-basic-single" name="state" id="gisuSelector" onchange="settingCat(this.value)">
				</select>
			 </dd>
			 </dl>

<div id="tabs_content_container" style="padding: 0px;">
    <div id="tab1" class="tab_content" style="display: block;">
<div>
<div class="panel panel-default" style="overflow-x:scroll;height: 539px;">
  <!-- Default panel contents -->
  <div class="panel-heading" style="width: 1200px;">
  <label style="margin-bottom:0px;margin-left: 2%;margin-right: 1%;">이름 : </label>
  <select class="js-example-basic-single" style="width: 12%;" name="state" id="searchMs" onchange="searchMemberScore()">
  <option value="" disabled hidden>이름을 검색해주세요..</option>
  <option value="">[전체 검색]</option>
  </select>
  <button class="btn btn-primary" onclick="fnExcelReport()">excel 다운로드</button>	
  	
  	
  </div>

  <!-- Table -->
  <table class="table table-hover" id="searchMemberTestTable" style="overflow-x:scroll;width: 1200px;">
  	
  </table>
</div>


<table class="table table-hover" id="searchMemberTestTableHide" style="overflow-x:scroll;width: 1200px;display: none;visibility: hidden;">
  	
  </table>
</div>


	</div>    
    <div id="tab2" class="tab_content">
		<div>
<div class="panel panel-default">
  <!-- Default panel contents -->
  <div class="panel-heading"><label style="margin-bottom:0px;margin-left: 2%;margin-right: 1%;">시험명 : </label><select class="js-example-basic-single" id="testCategory" onchange="TestListAll(this.value);" style="width: 30%;" name="state">
  <option value="" disabled selected hidden>시험을 선택해주세요.</option>
  </select>
 	 <button class="btn align_right danger" onclick="clearTestData()"  style="margin-left: 10px;float: right;">초기화하기</button>
 	 <button class="btn align_right primary"  onclick="saveTestData()" style="margin-left: 10px;float:right;">저장하기</button>
  	
  	
  	
  </div>

  <!-- Table -->
  <table class="table table-hover" id="memberTestTable" style="width: 100%;overflow: auto;">
  <tr>
			<td class="active">기수</td>
			<td class="active">학생이름</td>
			<td class="active">학생ID</td>
			<td class="active">생년월일</td>
			<td class="active">점수</td>
			<td class="active">가산점</td>
			<td class="active">비고</td>
</tr>
  </table>
</div>
</div>

     
    
</div>


    <div id="tab3" class="tab_content">
    <!-- <div class="panel panel-primary" style="width: 25%;">
    <div class="panel-heading">시험 관리 카테고리</div>
  <div class="panel-body">
    <select class="js-example-basic-single" name="state" id="testManagemt" onchange="changeTestCategory(this)" style="width: 100%:">
    <option value="searchTestDiv">시험 검색</option>
    <option value="createTestDiv">시험 생성</option>
    <option value="updateTestDiv">시험 수정</option>
	</select>
  </div>
    
	</div>
	 -->
	 <div class="searchTestDiv">
	  <table class="table table-hover" id="TestTable">
  	<tr>
			<td class="active">분류</td>
			<td class="active">시험명</td>
			<td class="active">총점수</td>
			<td class="active">재응시횟수</td>
			<td class="active">시작일</td>
			<td class="active">종료일</td>
			<td class="active">등록일</td>
			<td class="active">채점여부</td>
			<td class="active"></td>
	</tr>
  </table>
	
	<button class="btn align_right primary" onclick="changeTestCategory('createTestDiv')">추가하기</button>
		
    </div>
    
    
    <div class="createTestDiv">
     <form name="actionForm" method="post">

			<dl>
				<dt>카테고리<span class='require'>*</span></dt>
				<dd  class="half select2_dd">
	<select class="js-example-basic-single" style="width: 75%;" name="state" id="categoryRadio">
  <option value="" disabled hidden>카테고리를 선택해주세요</option>
  </select>
				</dd>
				<dt>총 점수 설정</dt>
				<dd class="half">
					<input type="text" id="total" numberOnly style="margin: 0px;border-radius: 3px; cursor: default;width: 39.5%;" placeholder="숫자 입력" value="100">
				</dd>
				<dt>시험명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" id="recruit" name="recruit" onblur="checkTestName(this)" placeholder="시험명 입력" style="margin: 0px;border-radius: 3px;width: 75%;">
				</dd>
				<dt>재응시 횟수</dt>
				<dd class="half">
					<select id="reTest" name='dupLimit' class="js-states form-control" style="width: 39.5%;">
						<option value="0">0번</option>
						<c:forEach var="i" begin="1"  end="3" step="1">
						<option value="${i}" <c:if test="${cardinal.dupLimit eq i}">selected="selected"</c:if>>${i}번</option>
						</c:forEach>
					</select>
				</dd>

				<dt>시험 일정</dt>
				<dd>
					<div class='input-group date datetimepicker'  id="appStartDate" style="width: 40%;margin-right: 1%;">
	                    <input type='text' name='appStartDate' id="startDate" class='form-control'/>
	                    <span class='input-group-addon' id="startDate2">
	                        <span class='glyphicon glyphicon-calendar' id="startDate3" ></span>
	                    </span>
	                </div>
	                ~
	                <div class='input-group date datetimepicker' id='appEndDate' style="width: 40%;margin-left: 1%">
	                    <input type='text' name='appEndDate' id="endDate" class='form-control'/>
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
	                </div>
				</dd>
				<dt>추가 내용</dt>
				<dd class="half">
					<input type="file" style="margin: 0px;"id="uploadFile">
  				</dd>
				<dt>제출파일 여부</dt>
				<dd class="half">
					 <label>
     					 <input type="checkbox" name="checkNeedFile"> 유
   					 </label>
   					 <label>
     					 <input type="checkbox" name="checkNeedFile"> 무
   					 </label>
 					
				</dd>
				<dt>시험내용<span class='require'>*</span></dt>
				<dd>
					<textarea cols="50" id="content" rows="10" style="resize: none;overflow: scroll;overflow-x: hidden;border-radius: 3px; " placeholder="[시험 범위 및 내용]"></textarea>
				</dd>

				
				
				
			</dl>
			</form>
			<div>
			<a id="listBtn" onclick="changeTestCategory('searchTestDiv')" class="btn align_right">리스트</a>
			<a onclick="submitt()" class="btn align_right primary">저장</a>
		</div>
     
    </div>
    </div>
    <div id="tab4" class="tab_content">
    <div class="content d-flex">
    <div class="section d-flex" id="bigCat" style="background-color: #333333;">
        <div class="article">
       		<div class="titlee">대분류</div>
       		<div class="progress" id="bigProgress">
<!--   <div class="progress-bar progress-bar-success progress-bar-striped active" style="width: 50%">
    성적(50%)
  </div>
  <div class="progress-bar progress-bar-warning progress-bar-striped active" style="width: 50%">
    Basic(50%)
  </div> -->
</div>
 
       		<hr>
       			
        		<div class="categoryList" id="bigCL" style="background-color: #333333; height: 300px;">
        		
        		
        		
        		</div>
        </div>
        <div class="aside">
        <div class="titlee" style="color: black">설정하기</div>
        <hr>
        <div id="bigC">
 
        </div>
        </div>
    </div>
    <div class="section d-flex" id="midCat" style="background-color: #666666;">
        <div class="article">
       		<div class="titlee">중분류</div>
       		<div class="progress" id="midProgress">

</div>
 
       		<hr>
        		<div class="categoryList" id="midCL" style="background-color: #666666; height: 300px;">
        		
        		
        		</div>
        </div>
        <div class="aside">
        <div class="titlee" style="color: black">설정하기</div>
        <hr>
        <div id="midC">
        
		
		</div>
        
        </div>


    </div>
    <div class="section d-flex" id="smallCat" style="background-color: #888888;">
                <div class="article">
       		<div class="titlee">소분류</div>
       		<div class="progress" id="smallProgress">
<!--   <div class="progress-bar progress-bar-success progress-bar-striped active" style="width: 33.33%">
    성적(33.33%)
  </div>
  <div class="progress-bar progress-bar-warning progress-bar-striped active" style="width: 33.33%">
    Basic(33.33%)
  </div>
    <div class="progress-bar progress-bar-info progress-bar-striped active" style="width: 33.33%">
    Basic(33.33%)
  </div> -->
</div>
 
       		<hr>
        		<div class="categoryList" id="smallCL" style="background-color: #888888; height: 300px;">
        		
        		
        		
        		</div>
        </div>
        <div class="aside">
        <div class="titlee" style="color: black">설정하기</div>
        <hr>
        <div id="smallC">
        
        </div>
        </div>
        </div>
        
</div>
    
    
    </div>
    <div id="tab5" class="tab_content">
		<div class="gradeDiv">
			<table class="table table-hover" id="gradeTable">
				<tr>
					<td class="active">최고 점수</td>
					<td class="active">최저 점수</td>
					<td class="active">등급</td>
					<td class="active"></td>
				</tr>
		  	</table>
		  	<button class="btn align_right primary" onclick="addGrade()">추가하기</button>
	 		<button class="btn align_right danger" onclick="clearGradeData()"  style="margin-left: 10px;float: right;">초기화하기</button>
	 		<button class="btn align_right primary changebtn"  onclick="saveGradeData()" style="margin-left: 10px;float:right;">저장하기</button>
    	</div>
	</div>
    <div id="tab6" class="tab_content">
    
    <div class="panel panel-default" style="margin: 10px;">
  <!-- Default panel contents -->
  <div class="panel-heading">
  <label style="margin-bottom:0px;margin-left: 2%;margin-right: 1%;">반 : </label><select class="js-example-basic-single" id="selectClasss" onchange="selectableUser()" style="width: 25%;" name="state">
  
  
  </select>
  <label style="margin-bottom:0px;margin-left: 2%;margin-right: 1%;">이름 : </label><select class="js-example-basic-single" id="selectUserInClass" onchange="selectableUser()" style="width: 25%;" name="state">
  
  
  </select>
  	
  	
  	
  </div>
<div style="min-height: 260px;max-height: 260px;overflow-y: auto;overflow-x:hidden;">
  <!-- Table -->
<table class="table table-hover" style="margin-bottom: 0px;" id="classInfoUser">
		
		
	</table>
	</div>
</div>
    <div style="width: 100%;">
    
    </div>
    
      <div class="ccontent dd-flex">
        <div class="ssection">
            <header class="hdr">반 설정</header>
            <ul class="classGroup" id="classGroup">
               
            </ul>
            <button class="btn" onclick="createUpperClass()">상위 분류 추가</button>
            <button class="btn" onclick="saveClassInfo()">저장하기</button>
        </div>
        <div class="ssectionWrap dd-flex">
            <div class="ssection">
                <header class="hdr">선택 가능 인원</header>
                <table class="table">
                    <thead>
                        <tr class="">
                            <th>선택</th>
                            <th class="sortThis dd-flex">
                                <span>이름</span>
                                <div class="btn img-icon sort-down"></div>
                            </th>
                            <th>아이디</th>
                            <th>생년월일</th>
                        </tr>
                    </thead>
                    <tbody id="selectableUser">
                        
                    </tbody>
                </table>
            </div>
            <div class="btnWrapper">
                <div class="btnWrap">
                    <div class="btn selectBtn img-icon caret-right"></div>
                    <div class="btn backBtn img-icon caret-left"></div>
                </div>
            </div>
            <div class="ssection">
                <header class="hdr" id="hdrdd">
                
				 <button class="btn btn-primary" onclick="searchClassList()">저장하기</button>
                </header>
                <table class="table">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th class="sortThis dd-flex">
                                <span>이름</span>
                                <div class="btn img-icon sort-down"></div>
                            </th>
                            <th>아이디</th>
                            <th>생년월일</th>
                        </tr>
                    </thead>
                    <tbody id="selectedUser">
                       
                    </tbody>
                </table>
       
            </div>
        </div>
    </div>
    
    
    <script type="text/javascript">
 // admin_02_classManagement_script.js
    $(document).ready(function() {

        // 반 구성원 이동
        // 선택가능한인원 > 기존인원
        $(".selectBtn").click(function() {
			if (confirm("등록하시겠습니까?")) {
				var list = new Array();
				var ob = new Object();
				$("#selectableUser input[name=user_CheckBox]:checked").each(function() {
					var ob = new Object();
					var tr1 = $(this).parent().parent();
	                var td1 = tr1.children();
	                var user_id = td1.eq(2).text();
	            	var seq = $("#selectClasss").val();
	            	var class_seq = seq.split('_')[0];
	            	var class_upper_seq = seq.split('_')[1];
	            	ob.user_id = user_id;
	            	ob.class_seq = class_seq;
	            	list.push(ob);
	                tr1.appendTo('#selectedUser').find('input[name=user_CheckBox]').prop("checked", false);
	            });
				var jsonStr = JSON.stringify(list);
				$.ajax({
            		url:"<c:url value='/student/TestManagement/insertUserInClass'/>",
            		type:		"post",
            		contentType: 'application/json; charset=UTF-8',
            		data: jsonStr,
            		success:function(result){
            			
            		},
            		complete:function(result){
            			selectableUser();
            		}
            	});
			}
            
        });
        // 선택가능한인원 > 기존인원 끝

        // 기존인원 > 선택가능한인원
        $(".backBtn").click(function() {
            if (confirm("삭제하시겠습니까?")) {
            	var list = new Array();
				var ob = new Object();
            	$("#selectedUser input[name=user_CheckBox]:checked").each(function() {
            		var ob = new Object();
                    var tr2 = $(this).parent().parent();
                    var td2 = tr2.children();
                    var user_id = tr2.children().eq(2).text();
                    var seq = $("#selectClasss").val();
	            	var class_seq = seq.split('_')[0];
	            	var class_upper_seq = seq.split('_')[1];
	            	ob.user_id = user_id;
	            	ob.class_seq = class_seq;
	            	list.push(ob);	            	
	                tr2.appendTo('#selectableUser').find('input[name=user_CheckBox]').prop("checked", false);
                });
            	var jsonStr = JSON.stringify(list);
            	$.ajax({
            		url:"<c:url value='/student/TestManagement/deleteUserInClass'/>",
            		type:		"post",
            		contentType: 'application/json; charset=UTF-8',
            		data: jsonStr,
            		success:function(result){
            			
            		},
            		complete:function(){
            			selectableUser();
            		}
            	});
			}
            
        });
        // 기존인원 > 선택가능한인원 끝
        // 반 구성원 이동 끝 (출처 https://all-record.tistory.com/172)

        // 테이블 헤더(이름) 클릭시 오름차순 정렬
        $('table.table').each(function() {
            var $table = $(this);

            $('th', $table).each(function(column) {
                if ($(this).is('.sortThis')) {
                    var direction = -1;
                    $(this).click(function() {
                        direction = -direction;
                        var rows = $table.find('tbody > tr').get();

                        rows.sort(function(a, b) {
                            var keyA = $(a).children('td').eq(column).text().toUpperCase();
                            var keyB = $(b).children('td').eq(column).text().toUpperCase();

                            if (keyA < keyB) return -direction;
                            return 0;
                        });
                        $.each(rows, function(index, row) {
                            $table.children('tbody').append(row)
                        });
                    });
                };
            });
        });
        // 테이블 헤더(이름) 클릭시 오름차순 정렬 끝

    });
    
    </script>
    
    
    
    </div>
</div>
	
</div>















