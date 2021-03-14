<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">

var oEditors = [];
$(function(){
	// 달력 초기화
	$('.datetimepicker').datetimepicker({
       	format				: 'YYYY-MM-DD',
        dayViewHeaderFormat	: 'YYYY년 MM월',
        locale				: moment.locale('ko'),
    });
	
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
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
            oEditors.getById["ir1"].exec("PASTE_HTML", [""]);
        },
        fCreator: "createSEditor2"
    });
      
    // 상담관리 페이지에서 특정 학생을 지정하지 않고 수정페이지로 넘어온 경우만 과정리스트 세팅
	if("${search.crc_name}" == '') searchList();
	else teacherSetting();
    
    /* var a = $("input[name='crc_id']").val();
    var b = $("input[name='gisu_id']").val();
    var c = $("input[name='searchCondition']").val();
    var d = $("input[name='searchKeyword']").val();

 */    
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
			sb.Append('<select class="js-example-basic-single" id="gisuList" name="state" onchange="studentSetting()">');
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
	 		studentSetting();
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

function studentSetting(){
	var sb = new StringBuilder();
	var value = $("#gisuList").val();
	var Url	= "<c:url value='/student/Counsel/searchStudent' />";
	if(value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length)){
		$("#studentSelector").html("");
		sb.ToString('<option value="" disabled hidden>학생명 선택</option>');
		alert("기수가 설정되지 않았습니다.");
		return;
		}
	var allData = {"gisu_id" : value, "crc_id" : $("#gisuValue").val()};
		$.ajax({
			url		: Url,
			data 	: allData,
			type	: "post",
			success	: function(result){
				$("#studentSelector").html("");
				if (result.length == 0) {
					alert("카테고리가 하나도없습니다.");
					$("#studentSelector").html(sb.ToString());
					return;
				}
				sb.Append('');
				for (var i = 0; i < result.length; i++) {
					if (result[i].USER_ID === undefined || result[i].USER_ID == 'undefined' || result[i].USER_NAME === undefined || result[i].USER_NAME == 'undefined') {
						continue;
					}
					var map = result[i];
					sb.Append('<option value="'+map.USER_ID+'">'+map.USER_NAME+'  ( '+map.USER_ID+' ) ['+map.BIRTH_DAY + ']</option>');
				}
				$("#studentSelector").html(sb.ToString());
			},
			complete:function(){
				$('.js-example-basic-single').select2();
				teacherSetting();
			}
		});
	}
	
function teacherSetting(){
	var sb = new StringBuilder();
	var gisu_id = $("#gisuList").val();;
	var crc_id = $("#gisuValue").val();;
	
	if(gisu_id == undefined) gisu_id = "${search.cardinal_id}";
	if(crc_id == undefined) crc_id = "${search.course_id}";
	
	var Url	= "<c:url value='/student/Counsel/searchTeacher' />";
	/*if(value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length)){
		$("#teacherSelector").html("");
		sb.ToString('<option value="" disabled hidden>상담자 선택</option>');
		return;
		}   					임시 주석처리, 변수 이름 맞춰서 다시 사용한는 것으로 바꾸겠습니다 :김성미 ****/

		var allData = {"gisu_id" : gisu_id, "crc_id" : crc_id};
		$.ajax({
			url		: Url,
			data 	: allData,
			type	: "post",
			success	: function(result){
				$("#").html("");
				if (result.length == 0) {
					$("#teacherSelector").html(sb.ToString());
					return;
				}
				sb.Append('');
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					sb.Append('<option value="'+map.USER_ID+'">'+map.USER_NM +'</option>');
				}
				$("#teacherSelector").html(sb.ToString());
			},
			complete:function(){
				$('.js-example-basic-single').select2();
			}
		});
	}
 
 function submitCounsel(){
	 oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	 if (validation()) {
			subm();
		}
	}
 
 function validation(){ 
	 var contents = $.trim(oEditors[0].getContents()); 
	 if(contents === '<p>&bnsp;</p>' || contents === '' || contents ==='<br>'){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
	 	alert("내용을 입력하세요."); 
 	 	oEditors.getById['ir1'].exec('FOCUS'); 
 		return false; 
 		}
	 return true; 
	 }
 
function subm(){
	var ajaxUrl	= "<c:url value='/student/Counsel/insertCounsel' />";
	var allData;
	
	if("${search.crc_name}" == ''){
			allData = {	"gisu_id" 			: $("#gisuList").val(),
						"crc_id" 			: $("#gisuValue").val(),
						"user_id" 			: $("#studentSelector").val(),
						"counsel_type"		: $("#counsel_type").val(),
						"counsel_title"		: $("#counsel_title").val(),
						"counsel_content"	: $("#ir1").val(),
						"counsel_teacher"	: $("#teacherSelector").val(),
						"counsel_regdate"	: $("#counsel_regdate").val()
					  };
	}else{
		allData = {	"gisu_id" 			: "${search.cardinal_id}",
					"crc_id" 			: "${search.course_id}",
					"user_id" 			: "${search.user_id}",
					"counsel_type"		: $("#counsel_type").val(),
					"counsel_title"		: $("#counsel_title").val(),
					"counsel_content"	: $("#ir1").val(),
					"counsel_teacher"	: $("#teacherSelector").val(),
					"counsel_regdate"	: $("#counsel_regdate").val()
				  };
	}
	$.ajax({
		url		: ajaxUrl,
		data 	: allData,
		type	: "post",
		success	: function(){
			alert("저장에 성공했습니다.");
		},
		error: function(){
			alert("저장에 실패했습니다.");
		},
		complete:function(){
			returnList();
		}
});
	}

function returnList(){
	contentLoad('상담신청내역','/admin/studentManagement/studentCounselManagement', $("form[name='searchForm']").serialize());
}

</script>

<div class="content_wraper">
	<h3>상담 내용 등록</h3>
	
	<!-- searchForm start -->
    <form name="searchForm" method="post">
       	<input type="hidden" name="id" value="" />
       	<!-- pageNo -->
       	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
       	
       	<!-- 검색시 분류값 저장하는 곳 -->
       	<input type="hidden" name="crc_id" value="${search.crc_id }" id="searchCrc_id"/>
       	<input type="hidden" name="gisu_id" value="${search.gisu_id }" id="searchGisu_id"/>
       	<input type="hidden" name="searchCondition" value="${search.searchCondition }" />
       	<input type="hidden" name="searchKeyword" value="${search.searchKeyword}" />
       	
       	<!-- 정상회원만 조회 -->
       	<input type="hidden" name="useYn" value='Y' />
	</form>
	<!-- //searchForm end -->
	
	<form id="frm"  method="post" >
		<dl>
			<dt>과정명<span class='require'>*</span></dt>
			<dd class="half select2_dd" id="gwajeongSelector">
				<c:if test="${search.crc_name ne null }">${search.crc_name }</c:if>
			</dd>
			
			<dt>기수명<span class='require'>*</span></dt>
			<dd class="half select2_dd" id="gisuSelector">
				<c:choose>
					<c:when test="${search.gisu_name != '' }">
						${search.gisu_name }
					</c:when>
					<c:otherwise>
						<select class="js-example-basic-single" name="state" id="gisuSelector">
							<option hidden disabled selected>기수 선택</option>
						</select>
					</c:otherwise>
				</c:choose>
			</dd>
			
			<dt>학생명<span class='require'>*</span></dt>
			<dd class="half select2_dd">
				<c:choose>
					<c:when test="${search.user_nm != '' }">
						${search.user_nm }
					</c:when>
					<c:otherwise>
						<select class="js-example-basic-single" name="state" id="studentSelector">
							<option hidden disabled selected>학생명 선택</option>
						</select>
					</c:otherwise>
				</c:choose>
			</dd>
			
			<dt>상담자명<span class='require'>*</span></dt>
			<dd class="half select2_dd">
				<select class="js-example-basic-single" name="state" id="teacherSelector">
					<option hidden disabled selected>상담자 선택</option>
				</select>
			</dd>
			
			<dt>상담이유<span class='require'>*</span></dt>
			<dd class="half select2_dd" id="whyCounselSelector">
				<select class="js-example-basic-single" name="state" id="counsel_type">
					<option value="진로 상담">진로 상담</option>
					<option value="학사 문의">학사 문의</option>
					<option value="기타 문의">기타 문의</option>
				</select>
			</dd>
			
			<dt>상담일<span class='require'>*</span></dt></dt>
			<dd class="half">
				<div class='input-group date datetimepicker'>
                    <input type='text' id='counsel_regdate' class='form-control' />
                    <span class='input-group-addon'>
                        <span class='glyphicon glyphicon-calendar'></span>
                    </span>
                </div>
			</dd>
			
			<dt>상담명</dt>
			<dd>
				<input type="text" id="counsel_title" name="counsel_title" placeholder="상담명을 입력" style="width: 75%">
			</dd>
		
			<dt>상담내용</dt>
			<dd>
			    <textarea rows="30" cols="30" id="ir1" name="counsel_content" style="width:50%; height:400px;min-height: 250px; "></textarea>
			</dd>	 
		</dl>
	</form>
	<button class="btn" onclick="returnList()">리스트</button>
    <button class="btn" onclick="submitCounsel()">저장</button>
</div>

