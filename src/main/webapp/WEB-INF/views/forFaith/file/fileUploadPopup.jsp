<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge" />
<title>파일 업로드</title>

<style type="text/css">
/* NHN Web Standard 1Team JJS 120106 */ 
/* Common */
body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,select{margin:0;padding:0}
body,input,textarea,select,button,table{font-family:'돋움',Dotum,Helvetica,sans-serif;font-size:12px}
img,fieldset{border:0}
ul,ol{list-style:none}
em,address{font-style:normal}
a{text-decoration:none}
a:hover,a:active,a:focus{text-decoration:underline}

/* Contents */
.blind{visibility:hidden;position:absolute;line-height:0}
#pop_wrap{width:383px}
#pop_header{height:26px;padding:14px 0 0 20px;border-bottom:1px solid #ededeb;background:#f4f4f3}
.pop_container{padding:11px 20px 0}
#pop_footer{margin:21px 20px 0;padding:10px 0 16px;border-top:1px solid #e5e5e5;text-align:center}
h1{color:#333;font-size:14px;letter-spacing:-1px}
.btn_area{word-spacing:2px}
.pop_container .drag_area{overflow:hidden;overflow-y:auto;position:relative;width:341px;height:129px;margin-top:4px;border:1px solid #eceff2}
.pop_container .drag_area .bg{display:block;position:absolute;top:0;left:0;width:341px;height:129px;background:#fdfdfd url('<c:url value="/resources/images/com/fileUpload/bg_drag_image.png" />') 0 0 no-repeat}
.pop_container .nobg{background:none}
.pop_container .bar{color:#e0e0e0}
.pop_container .lst_type li{overflow:hidden;position:relative;padding:7px 0 6px 8px;border-bottom:1px solid #f4f4f4;vertical-align:top}
.pop_container :root .lst_type li{padding:6px 0 5px 8px}
.pop_container .lst_type li span{float:left;color:#222}
.pop_container .lst_type li em{float:right;margin-top:1px;padding-right:22px;color:#a1a1a1;font-size:11px}
.pop_container .lst_type li a{position:absolute;top:6px;right:5px}
.pop_container .dsc{margin-top:6px;color:#666;line-height:18px}
.pop_container .dsc_v1{margin-top:12px}
.pop_container .dsc em{color:#13b72a}
.pop_container2{padding:46px 60px 20px}
.pop_container2 .dsc{margin-top:6px;color:#666;line-height:18px}
.pop_container2 .dsc strong{color:#13b72a}
.upload{margin:0 4px 0 0;_margin:0;padding:6px 0 4px 6px;border:solid 1px #d5d5d5;color:#a1a1a1;font-size:12px;border-right-color:#efefef;border-bottom-color:#efefef;length:300px;}
:root  .upload{padding:6px 0 2px 6px;}
</style>

<!-- 외부 자바스크립트 -->
<script src='<c:url value="/resources/js/ext/jquery/jquery-1.11.0.min.js"/>'></script>
<script src='<c:url value="/resources/js/com/commonObj.js" />'></script>

<script type="text/javascript">
//취소 버튼 클릭 시
function closeWindow() {
	if(bSupportDragAndDropAPI){
		removeDragAndDropEvent();
	}
	
	window.close();
}

// 파일 업로드 후 처리
function setAttachFile(fileList) {
	var result = opener.setAttachFile($("#file_index").val(), $("#accept").val(), fileList, $("#callback").val());
	
	if(result) {
		closeWindow();
	} else {
		alert("파일은 저장 되었지만 FILE VIEW 생성 시 오류발생.");
		closeWindow();
	}
}
</script>
</head>
<body>
<div id="pop_wrap">
	<!-- header -->
    <div id="pop_header">
        <h1>파일업로드</h1>
    </div>
    <!-- //header -->
   
    <!-- container -->
    <!-- [D] HTML5인 경우 pop_container 클래스와 하위 HTML 적용
	    	 그밖의 경우 pop_container2 클래스와 하위 HTML 적용      -->
	<div id="pop_container2" class="pop_container2">
    	<!-- content -->
		<form action="/file/fileUpload.do" method="post" enctype="multipart/form-data; charset=UTF-8" onSubmit="return false;">
        <div id="pop_content2">
        	<input type='hidden'	id='file_id'			value='<c:out value="${uploadFile.fileId}" default="" />' />
        	<input type='hidden'	id='upload_dir'			value='<c:out value="${uploadFile.uploadDir}" />' />
        	<input type='hidden'	id='fix_file_name'		value='<c:out value="${uploadFile.fixFileName}" />' />
        	<input type='hidden'	id='remove_file_name'	value='<c:out value="${uploadFile.removeFileName}" />' />
        	<input type='hidden'	id='origin_file_name'	value='' />
        	
        	<input type='hidden'	id='file_index'			value='<c:out value="${uploadFile.fileIndex}" 		default="0" />' />
        	<input type='hidden'	id='upload_count'		value='<c:out value="${uploadFile.uploadCount}" 	default="0" />' />
        	<input type='hidden'	id='upload_size'		value='<c:out value="${uploadFile.uploadSize}" 		default="0" />' />
        	<input type='hidden'	id='max_size'			value='<c:out value="${uploadFile.maxSize}" 		default="10" />' />
        	<input type='hidden'	id='max_total_size'		value='<c:out value="${uploadFile.maxTotalSize}" 	default="50" />' />
        	<input type='hidden'	id='max_count'			value='<c:out value="${uploadFile.maxCount}" 		default="10" />' />
        	<input type='hidden'	id='accept'				value='<c:out value="${uploadFile.accept}"			default="all" />' />
        	<input type='hidden'	id='callback'			value='<c:out value="${uploadFile.callback}"		default="" />' />
			
			<input type="file"		id="file_data"			name="fileData" class="upload" />
            
            <p class="dsc" id="info"><strong><c:out value="${uploadFile.maxSize}" default="0" />MB</strong>이하의 파일만 등록할 수 있습니다.</p>
        </div>
		</form>
        <!-- //content -->
    </div>
    
    <div id="pop_container" class="pop_container" style="display:none;">
    	<!-- content -->
        <div id="pop_content">
	        <p class="dsc"><em id="imageCountTxt">0개</em>/<c:out value="${uploadFile.maxCount}" default="0" />개 <span class="bar">|</span> <em id="totalSizeTxt">0MB</em>/<c:out value="${uploadFile.maxTotalSize}" default="0" />MB</p>
        	<!-- [D] 첨부 이미지 여부에 따른 Class 변화 
            	 첨부 이미지가 있는 경우 : em에 "bg" 클래스 적용 //첨부 이미지가 없는 경우 : em에 "nobg" 클래스 적용   -->
				 
            <div class="drag_area" id="drag_area">
				<ul id="drop_area" class="lst_type" >
				</ul>
            	<em class="blind">마우스로 드래그해서 파일을 추가해주세요.</em><span id="guide_text" class="bg"></span>
            </div>
			<div style="display:none;" id="divImageList"></div>
            <p class="dsc dsc_v1"><em>한 장당 <c:out value="${uploadFile.maxSize}" default="0" />MB, 최대  <c:out value="${uploadFile.maxTotalSize}" default="0" />MB까지, <c:out value="${uploadFile.maxCount}" default="0" />개</em>의 파일을<br>등록할 수 있습니다.</p>
        </div>
        <!-- //content -->
    </div>
   	<!-- //container -->
    
    <!-- footer -->
    <div id="pop_footer">
	    <div class="btn_area">
	    	<a href="#"><img src='<c:url value="/resources/images/com/fileUpload/btn_confirm2.png" />' width="49" height="28" alt="확인" id="btn_confirm"></a>
            <a href="#"><img src='<c:url value="/resources/images/com/fileUpload/btn_cancel.png" />' width="48" height="28" alt="취소" id="btn_cancel"></a>
        </div>
    </div>
    <!-- //footer -->
</div>

<!-- 파일 처리 JS 추가 -->
<script src='<c:url value="/resources/js/com/uploadFile.js" />'></script>
<!-- //파일 처리 JS 추가 -->

</body>
</html>