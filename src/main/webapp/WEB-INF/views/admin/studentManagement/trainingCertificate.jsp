<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/student/js/jquery-3.5.1.js" />"></script>
<script src="<c:url value="/resources/student/js/jquery-ui.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/student/css/img-icon.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/student/css/reset.css" />">
<script src="<c:url value="/resources/js/com/commonObj.js"/>"></script>

<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">

var certificateInfo = ${certificateInfo};
var userInfo = ${userInfo};

$(document).ready(function(){
	setContent ();
})

function setContent () {
	
	var contentList = [];
	
	for(var i = 0; i < certificateInfo.length; i++) {
		
		$('.ctf_name').html(userInfo[i].name);
		var birthArr = (userInfo[i].birthDay).split('-');
		$('.ctf_birth').html(birthArr[0] + '년 ' + birthArr[1] + '월 ' + birthArr[2] + '일');
		$('.ctf_course').html(certificateInfo[i].NAME);
		$('.ctf_terms').html(certificateInfo[i].LEARN_START_DATE + ' - ' + certificateInfo[i].LEARN_END_DATE);
		$('.ctf_time').html('8:30 - 20:00');
		$('.cardinal_nm').html(certificateInfo[i].CARDINAL_NAME);
		
		var sb = new StringBuilder();
		
		if(i == 0) {
			sb.Append('<div class="modal-content">');
		} else {
			sb.Append('<div class="modal-content pageBreak">');
		}
		sb.Append($('.modal-content').html());
		sb.Append('</div>');
		contentList.push(sb.ToString());
	}
	
	$('div.modal-dialog > div.modal-content').remove();
	
	for(var i = 0; i < contentList.length; i++) {
		$(contentList[i]).appendTo('div.modal-dialog');
	}
}


function printWindow() {
	var initBody;
	
	window.onbeforeprint = function(){
		initBody = document.body.innerHTML;
		document.body.innerHTML = document.getElementById("print-body").innerHTML;
	};
	window.onafterprint = function(){
		document.body.innerHTML = initBody;
	};
	
	$(".modal-content").css("margin", "5% auto");
	
	window.print();
	
	$(".modal-content").css("margin", "0px 0px");
	
	return false;
	}
</script>
<style>
	@page {
		margin: 0;
	}
	
	* {
		margin: 0;
		padding: 0;
	}
	
	.modal-content {
		pwidth: 595px;
	    height: 841px;
	    padding: 0;
	    margin: 0 auto;
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: auto;
	    position: relative;
		background-image: url('/resources/student/img/print_certificate_of_training.jpg');
	}
	.modal-body > .ctf_textWrap {
	    top: 222px;
	    left: 300px;
	    font-size: 20px;
	    font-weight: bold;
	    line-height: 40px;
	}
	.modal-body > * {
		position: absolute;
	    font-family: serif;
	    color: #86602e;
	    cursor: default;
	}
	.modal-header {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-align: start;
		align-items: flex-start;
		-ms-flex-pack: justify;
		justify-content: space-between;
		padding: 1rem;
		border-bottom: 1px solid #e9ecef;
		border-radius: 0.3rem 0.3rem 0.3rem;
	}
	
	.modal-title {
		margin-bottom: 0;
		line-height: 1.5;		
	}
	
	.modal-header .close {
		padding: 1rem;
		margin: -1rem -1rem -1rem auto;
	}
	
	.close {
		float: right;
		font-size: 1.5rem;
		font-weight: 700;
		line-height: 1;
		color: #000;
		text-shadow: 0 1px 0 #fff;
		opacity: .5;
	}
	
	.modal-body {
		position: relative;
		-ms-flex: 1 1 auto;
		flex: 1 1 auto;
		padding: 1 rem;
	} 
	
	.modal-footer {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-align: center;
		align-items: center;
		-ms-flex-pack: end;
		justify-content: flex-end;
        padding: 1rem;
	}
	.modal-footer.text-alignR{
		display : block;
	}
	.modal-footer.text-alignR>h5{
		text-align:right;
	}
	.modal-header,
	.modal-body,
	.modal-footer {
		padding: 10px;
		color: #333;
		line-height: 20px;
	}
	
	.modal-header {
		border-radius: 0;
	}
	
	.modal-header .close {
		padding: 0;
		margin: 0;
	}
	
	.modal-subGroup {
		/* border: 1px solid #ddd; */
		padding: 10px;
	}
	
	.modal-subGroup>.hideTab {
		display: none;
	}
	
	.modal-titleGroup {
		display: flex;
		justify-content: center;
	}
	
	.printBtn {
		margin: 0 auto;
		width: 200px;
	}
	.tbody-content {
		text-align: left;
	}
	.pageBreak {
		page-break-before: always;
	}
	/* 	배경 img 프린트 */
		@media print
		{
			* {/*Chrome, Safari */
				-webkit-print-color-adjust: exact !important;
				/*Firefox*/
				color-adjust: exact !important;
			}
			.button-wrap{display: none;}
		}
</style>
<div class="cl-popup-overlay" id="certificatepop">
	<div class="button-wrap">
		<input class="printBtn" type="button" onclick="printWindow()" value="출력">
	</div>
	<div id="print-body">
		<div class="main-body" id="main-body">
			<div class="moda fade show" id="myModal" role="dialog" style="display: block; padding-right: 17px;">
				<div class="modal-dialog" style="max-width: 1200px;">
					<div class="modal-content">
						<div class="modal-body">
							<ul class="ctf_textWrap">
				                <li class="ctf_name"></li>
				                <li class="ctf_birth"></li>
				                <li class="ctf_course"></li>
				                <li class="ctf_terms"></li>
				                <li class="ctf_time"></li>
				            </ul>
				            <div class="ctf_endDate"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>