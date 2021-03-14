<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
input.noout:focus {
	outline: none;
}
</style>

<div class="content_wraper" style="height: 740px; overflow: auto;">
	<form id="frm" name="updateForm" method="post" >
	<dl>
			<dt>과정명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" class="noout" style="cursor:default; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" value='<c:out value='${counsel.CRC_NAME}' default="" />' readonly="readonly"> 
					<input type="hidden" id='CRC_ID' value='<c:out value='${counsel.CRC_ID}' default="" />'>
				</dd>
				<dt>기수명<span class='require'>*</span></dt>
				<dd class="half" >
 					<input type="text" class="noout" style="cursor:default; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" value='<c:out value='${counsel.GISU_NAME}' default="" />' readonly="readonly">
			        <input type='hidden' id='GISU_ID' value='<c:out value='${counsel.GISU_ID}' default="" />' />
			 </dd>
			<dt>학생명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" class="noout" style="cursor:default; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" value='<c:out value='${counsel.USER_NM}' default="" />' readonly="readonly">
			        <input type='hidden' id='USER_ID' value='<c:out value='${counsel.USER_ID}' default="" />' />
				</dd>
			<dt>상담자명<span class='require'>*</span></dt>
				<dd class="half">
					<input type="text" id='TEACHER_NM' value='<c:out value='${counsel.COUNSEL_TEACHER}' default="" />'>
				</dd>
			
			<dt>상담구분<span class='require'>*</span></dt>
				<dd class="half">
					<select class="js-example-basic-single" name="state" id="counsel_type">
						<option ${counsel.COUNSEL_TYPE == '진로 상담'?'selected=\"selected\"':''} value="진로 상담">진로 상담</option>
						<option ${counsel.COUNSEL_TYPE == '학사 문의'?'selected=\"selected\"':''} value="학사 문의">학사 문의</option>
						<option ${counsel.COUNSEL_TYPE == '기타 문의'?'selected=\"selected\"':''} value="기타 문의">기타 문의</option>
					</select>
				</dd>
			<dt>상담일<span class='require'>*</span></dt>
				<dd class="half">
					<div class='input-group date datetimepicker'>
	                    <input type='text' id='counsel_regdate' class='form-control' value="${counsel.COUNSEL_REGDATE}" />
	                    <span class='input-group-addon'>
	                        <span class='glyphicon glyphicon-calendar'></span>
	                    </span>
                	</div>
				</dd>
				
			<dt>상담명</dt>
					<dd>
				<input type="text" id="counsel_title" name="counsel_title" placeholder="상담명을 입력" value="${counsel.COUNSEL_TITLE}" style="width: 75%">
				</dd>
				
			<dt>상담내용</dt>							 
				<dd>
				    <textarea rows="30" cols="30" id="ir1" name="counsel_content" style="width:100%; height:400px;min-height: 250px; "></textarea>
       
				</dd>	 
			 
			 
			 
			 </dl>

</form>
		<button class="btn" onclick="deleteCounsel()">삭제</button>
       <button class="btn" onclick="updateCounsel()">수정</button>
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
              oEditors.getById["ir1"].exec("PASTE_HTML", ["${counsel.COUNSEL_CONTENT}"]);
          },
          fCreator: "createSEditor2"
      });
});

 function updateCounsel(){
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
	var ajaxUrl	= "<c:url value='/student/Counsel/updateCounsel' />";
	var seq = "${counsel.COUNSEL_SEQ}";
	var allData = { "counsel_seq"		: seq,
					"gisu_id" 			: $("#GISU_ID").val(),
					"crc_id" 			: $("#CRC_ID").val(),
					"user_id" 			: $("#USER_ID").val(),
					"counsel_type"		: $("#counsel_type").val(),
					"counsel_title"		: $("#counsel_title").val(),
					"counsel_content"	: $("#ir1").val(),
					"counsel_teacher"	: $("#TEACHER_NM").val(),
					"counsel_regdate"	: $("#counsel_regdate").val()
				  };
	$.ajax({
		url		: ajaxUrl,
		data 	: allData,
		type	: "post",
		success	: function(list){
			alert("변경에 성공했습니다.");
			
			var sb = new StringBuilder();
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
			$('#counselListBody', document).html(sb.ToString());
		},
		error: function(){
			alert("변경에 실패했습니다.");
		},
		complete:function(){
// 			returnList();
			closeLayerPopup();
		}
	});
}

function deleteCounsel() {
	var Url	= "<c:url value='/student/Counsel/deleteCounsel' />";
	var seq = "${counsel.COUNSEL_SEQ}";
	var allData = { "counsel_seq"		: seq,
					"gisu_id" 			: $("#GISU_ID").val(),
					"crc_id" 			: $("#CRC_ID").val(),
					"user_id" 			: $("#USER_ID").val(),
				  };
	$.ajax({
		url		: Url,
		data 	: allData,
		type	: "post",
		success : function(list){
			alert("삭제에 성공했습니다.");
			
			var sb = new StringBuilder();
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
			$('#counselListBody', document).html(sb.ToString());
		},
		error : function() {
			alert("삭제에 실패했습니다.");
		},
	 	complete:function(){
	 		closeLayerPopup();
	 	}
	});
}

function returnList(){
	contentLoad('상담신청내역','/admin/studentManagement/studentCounselManagement');
}
</script>
</div>