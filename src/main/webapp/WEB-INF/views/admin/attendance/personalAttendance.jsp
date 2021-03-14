<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
var userInfo = ${userInfo};
var user_nm = "${info.user_nm}";
$(document).ready(function(){
	setContent ();
	parse("${info.start_date}","${info.end_date}")
})

function parse(str1, str2) {
	var start = str1.split("-")[0] + "." + str1.split("-")[1] +"." + str1.split("-")[2]
	var end = str2.split("-")[0] + "." + str2.split("-")[1] +"." + str2.split("-")[2]
	$('.term').html(start + " ~ " + end);
}

function setContent () {
	var sb = new StringBuilder();
	var real = 0;
	
	if(userInfo.length == 0) {
		alert("출결 정보가 없습니다.");
		window.close();
		return;
	}
	
	$('.propose').html(userInfo.length);
	
	for(var i = 0; i < userInfo.length; i++) {
		sb.Append("<tr>")
		sb.Append("<td class='tg-9wq8'>"+userInfo[i].att_date.split("-")[1]+"</td>")
		sb.Append("<td class='tg-9wq8'>"+userInfo[i].att_date.split("-")[2]+"</td>")
		sb.Append("<td class='tg-9wq8'>"+userInfo[i].start_time+"</td>")
		sb.Append("<td class='tg-9wq8'>"+userInfo[i].end_time+"</td>")
		if(userInfo[i].in_time) {
			sb.Append("<td class='tg-9wq8'>"+userInfo[i].in_time+"</td>")	
		} else {
			sb.Append("<td class='tg-9wq8'>-</td>")
		} 
		if(userInfo[i].out_time) {
			sb.Append("<td class='tg-9wq8'>"+userInfo[i].out_time+"</td>")
		} else {
			sb.Append("<td class='tg-9wq8'>-</td>")
		}
		
		sb.Append("<td class='tg-9wq8'>-</td>")
		sb.Append("<td class='tg-9wq8'>1</td>")
		switch(userInfo[i].final_gubun) {
		case "출석":
			real++
			sb.Append("<td class='tg-9wq8'>1</td>")
			sb.Append("<td class='tg-9wq8'>-</td>")
			sb.Append("<td class='tg-9wq8'>-</td>")
			break;
		case "결석":
			sb.Append("<td class='tg-9wq8'>-</td>")
			sb.Append("<td class='tg-9wq8'>1</td>")
			sb.Append("<td class='tg-9wq8'>-</td>")
			break;
		case "지각/조퇴":
			real++
			sb.Append("<td class='tg-9wq8'>1</td>")
			sb.Append("<td class='tg-9wq8'>-</td>")
			var num = compareTime(userInfo[i].att_date, userInfo[i].start_time, 
					userInfo[i].end_time, userInfo[i].in_time, userInfo[i].out_time);
			sb.Append("<td class='tg-9wq8'>"+num+"</td>")
			break;
		}
		sb.Append("<td class='tg-9wq8'>"+user_nm+"</td>")
		sb.Append("<td class='tg-9wq8'>"+"${info.teacher_nm}"+"</td>")
		sb.Append("</tr>")
	}
	$('.real').html(real);
	var per = (real / userInfo.length) * 100;
	
	$('.percent').html(per.toFixed(1));
	$('.personal').html(sb.ToString())
}

function compareTime(uDate, start, end, in_time, out_time){
	var s = new Date(uDate.split("-")[0],uDate.split("-")[1]-1,uDate.split("-")[2],start.split(":")[0],start.split(":")[1])
	var e = new Date(uDate.split("-")[0],uDate.split("-")[1]-1,uDate.split("-")[2],end.split(":")[0],end.split(":")[1])
	var i = new Date(uDate.split("-")[0],uDate.split("-")[1]-1,uDate.split("-")[2],in_time.split(":")[0],in_time.split(":")[1])
	var o = new Date(uDate.split("-")[0],uDate.split("-")[1]-1,uDate.split("-")[2],out_time.split(":")[0],out_time.split(":")[1])
	var num = 0;
	
	if(s.getTime() - i.getTime() < 0) {
		Math.abs((s.getTime() - i.getTime()) / (1000 * 60))
		num += Math.abs((s.getTime() - i.getTime()) / (1000 * 60)) / 60
	}
	if(e.getTime() - o.getTime() > 0) {
		Math.abs((e.getTime() - o.getTime()) / (1000 * 60))
		num += Math.abs((e.getTime() - o.getTime()) / (1000 * 60)) / 60
	}
	
	return num.toFixed(1)
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
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-9wq8{border-color:inherit;text-align:center;vertical-align:middle}

	@page {
		margin: 0;
	}
	body {
		margin-left: 20px;
	}
	.modal-content {
		pwidth: 595px;
	    height: 841px;
	    padding: 0;
	    margin: 0 auto;
	    position: relative;
	}

	.modal-body > .ctf_textWrap {
	    top: 222px;
	    left: 300px;
	    font-size: 20px;
	    font-weight: bold;
	    line-height: 40px;
	}
	.modal-body > * {
		/* position: absolute; */
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
/* 	.pageBreak {
		page-break-before: always;
	} */
	@media print {
		@page {
			size: A4;
			margin: 0cm;
    	}
		body {
			max-width: 100%;
			margin-left: 20px;
			zoom:80%;
		}
		#print-body {
			page-break-before: always;
			margin-top: 10px;
		}
 		#print-body table {
			height:80%;
			table-layout: fixed;
			
		}
		#print-body table thead tr {
			height: 80%;
		}
		.table_style {
			margin-left: 80px;
		}
		.modal-footer {
			margin-right: 120px;
		}
	}
</style>
<div class="cl-popup-overlay" id="certificatepop">
	<div class="button-wrap">
		<input class="printBtn" type="button" onclick="printWindow()" value="출력">
	</div>
	<div id="print-body">
		<div class="main-body" id="main-body">
			<div class="moda fade show" id="myModal" role="dialog" style="display: block; padding-right: 17px;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header modal-titleGroup">
							<ul>
								<li><h3 class="modal-title h3" style="text-align: center;">출석부</h3></li>
								<li>
									<div style="float: left; width: 400px; height: 200px; ">
										<h3>훈련생 성명: <span class="user_name">${info.user_nm}</span></h3>
										<h3>훈련 기관명: (사)한국무역협회, ㈜소프트엔지니어소사이어티</h3>
										<h3>훈련 과정명: <span class="program_nm">${info.cardinal_nm}</span></h3>
										<h3>훈련 기간: <span class="term"></span></h3>
										<h3>소정훈련일수: <span class="propose"></span></h3>
										<h3>실제출석일수: <span class="real"></span> (출석률 : <span class="percent"></span> %)</h3>
										<h3>별도의 수당지급여부: □ 없음, □ 있음(금액:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;원)</h3>
									</div>
									<div class="" style="display:inline-block; float: left; width: 200px; height: 200px; margin-left: 100px;">
										<table class="tg">
											<thead>
												<tr>
													<th class="tg-9wq8" colspan="2">결제</th>
												</tr>
												<tr>
													<td class="tg-9wq8">담당</td>
													<td class="tg-9wq8">팀장</td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="tg-9wq8" style="width: 110px; height: 120px;"></td>
													<td class="tg-9wq8" style="width: 110px; height: 120px;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
							</ul>
							
						</div>
						<div class="modal-body" id="modal_body" style="margin: 10 auto;">						
							<div class="table_style">
				            	<table class="tg">
					            	<thead>
					            		<tr>
					            			<th class="tg-9wq8" colspan="2">훈련일자</th>
					            			<th class="tg-9wq8" colspan="2">훈련시간</th>
					            			<th class="tg-9wq8" colspan="3">실제 훈련참여 시간</th>
					            			<th class="tg-9wq8" rowspan="2">소<br>정<br>출<br>석<br>일</th>
					            			<th class="tg-9wq8" rowspan="2">실<br>제<br>출<br>석<br>일</th>
					            			<th class="tg-9wq8" rowspan="2">결<br>석<br>일<br>수</th>
					            			<th class="tg-9wq8" rowspan="2">지각<br>조퇴<br>외출<br>시간<br>합계</th>
					            			<th class="tg-9wq8" colspan="2">확인</th>
					            		</tr>
					            		<tr>
											<td class="tg-9wq8">월</td>
											<td class="tg-9wq8">일</td>
											<td class="tg-9wq8">시작시간</td>
											<td class="tg-9wq8">종료시간</td>
											<td class="tg-9wq8">시작시간</td>
											<td class="tg-9wq8">종료시간</td>
											<td class="tg-9wq8">지각, 조퇴, 외출시<br>해당 시간</td>
											<td class="tg-9wq8">훈련생</td>
											<td class="tg-9wq8">훈련교사</td>
										</tr>
					            	</thead>
				    	        	<tbody class="personal"></tbody>
				            	</table>
				            </div>
						</div>
  						<div class="modal-footer text-alignR">
				        	<h5>위 내용이 사실임을 확인합니다.</h5>
							<h5>제출자(취성패 참여자) 성명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(서명  또는 인)</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>