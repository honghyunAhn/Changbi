<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SMS - EMAIL 발송</title>

<link type="text/css" rel="stylesheet" href="/resources/css/ext/bootstrap-datetimepicker/jquery.timepicker.css">
<script type="text/javascript" src="/resources/js/ext/bootstrap-datetimepicker/jquery.timepicker.min.js"></script>
<script type="text/javascript">

var list = ${list};

//sms 관련 변수
var receiver; //01000001111,01011111111
var rec = new Object();
var sender;
var destination; //01011111111|홍길동,01011111111|길동홍 - 안씀

//mail 관련 변수
var to;
var nm_list;
var id_list;

$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var smsUrl	= "<c:url value='/data/common/sendSms' />";
	var mailUrl	= "<c:url value='/data/common/sendMail' />";
	var historyUrl = "<c:url value='/data/common/smsHistory' />";
	
	/** 함수 영역 **/
	
	//기본값:email
	setTakerList(0);
	
	/** 이벤트 영역 **/
	//timepicker 세팅
	$("#apply_future_time").timepicker({
		'minTime' : '00:00am', // 조회하고자 할 시작 시간 ( 00시 부터 선택 가능하다. )
        'maxTime' : '23:55pm', // 조회하고자 할 종료 시간 ( 23시59분 까지 선택 가능하다. )
        'timeFormat' : 'H:i',
        'step' : 30 //test로 5분단위
    // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
	});
	
	//전송하기
	$('#popupSendBtn').on('click', function(){
		if($('input[name=sendType]:checked').val() == 0) {
			sendMail();
		} else {
			sendMsg();
		}
	})
	
	//메일/sms/mms 라디오버튼 선택 이벤트
	$('input:radio[name=sendType]').on('click', function () {
		setTakerList($('input[name=sendType]:checked').val());
	})
	
	//내용 길이 체크
	$('#sendContent').on('keyup focusout mousedown mousehover', function() {
		textLengthCheck($(this));
	});
	$('#sendContent').keyup();
	
	//제목 길이 체크
	$('#title').on('keyup focusout mousedown mousehover',function(){
		byteCheck_putText($(this), 45);
	});
	$('#title').keyup();
	
	$("input:checkbox[name=is_check]").on('click', function() {
		if($("input:checkbox[name=is_check]").is(":checked")) {
			if($('input[name=sendType]:checked').val() == 0) {
				alert("메일 예약전송은 현재 지원하지 않습니다");
				return false;
			} else {
				$('#futureDiv').removeAttr('hidden');
			}
		} else {
			$('#apply_future_date').val('');
			$('#apply_future_time').val('');
			$('#futureDiv').attr('hidden', 'hidden');
		}
	})
	
});

//수신인 설정(mail일 경우/sms일 경우)
function setTakerList(sendType) {
	
	var content = "";
	
	to = '';
	receiver = '';
	destination = '';
	nm_list = '';
	id_list = '';
	rec['length'] = list.length;
	$.each(list, function(index, item) {
		content += '<tr>';
		content += '<th>' + item.stu_app_nm + '<th>';
		if(sendType == 0) {
			content += '<td>' + item.stu_app_email + '<td>';
			to += item.stu_app_email + ',';
			nm_list += item.stu_app_nm + ',';
			id_list += item.user_id + ',';
		} else {
			content += '<td>' + item.stu_app_phone + '<td>';
			if(item.stu_app_phone != '') {
				receiver += item.stu_app_phone + ',';
				rec['rec_' + (index+1)] = item.stu_app_phone; 
				rec['nm_' + (index+1)] = item.stu_app_nm;
				
				destination += item.stu_app_phone + '|' + item.stu_app_nm + ',';
			}
		} 
		content += '</tr>';
	});
	if(to != '') {
		to = to.substr(0, to.length -1);
	}
	if(receiver != '' && destination != '') {
		receiver = receiver.substr(0, receiver.length -1);
		destination = destination.substr(0, destination.length -1);
	}
	$('#takerList').html(content);
}

//textarea 글자수 카운터
function textLengthCheck(obj) {
	if($('input[name=sendType]:checked').val() == 0) {
		$('#countSpan').html(obj.val().length + '/2000자');
	} else if ($('input[name=sendType]:checked').val() == 1) {
		byteCheck_putText(obj, 90);
	} else if($('input[name=sendType]:checked').val() == 2) {
		byteCheck_putText(obj, 2000);
	}
}

//textarea 바이트수 카운터
function byteCheck(obj) {
	return (function(s,b,i,c){
	    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	        return b
		})(obj.val());
}
//바이트수 계산결과 화면표시
function byteCheck_putText(obj, maxByte) {
    // 문자열 BYTE 계산
    var stringByteLength = byteCheck(obj);
    // 설정 최대 바이트 수를 넘길 경우
    if (stringByteLength > maxByte) {
        obj.val(cutByLen(obj.val(), maxByte));
        stringByteLength = maxByte;
    }
    // 바이트수 화면출력
    $('#countSpan').html(stringByteLength + '/' + maxByte + 'byte');
}
//원하는 바이트수만큼 문자열 잘라내기
function cutByLen(str, maxByte) {
	for(b=i=0;c=str.charCodeAt(i);) {
		b+=c>>7?2:1;
		if (b > maxByte)
			break;
		i++;
	}
	return str.substring(0,i);
}

//이메일 전송(%고객명% 처리 mailservice에서 함)
function sendMail() {
	if(!checkSendForm ()) {
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "/admin/common/send_mail",
		data : {
			"to" : to,
			"nm_list" : nm_list,
			"id_list" : id_list,
			"subject" : $('#title').val(),
			"content" : $('#sendContent').val()
		},
		success : function(result) {
			var jsonObj = JSON.parse(result);
			var resultStr = '전송결과: \n전송성공: '+ jsonObj.successCnt + '건 , 전송실패: ' + jsonObj.failCnt + '건';
			alert(resultStr);
		},
		error : function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
		
	})
}
//단문문자 전송 (%고객명%처리 여기에서 함)
function sendMsg() {
	if(!checkSendForm()) {
		return false;
	}
	var data = new Object();
	data.rdate = $('#apply_future_date').val().replaceAll('-','');
	data.rtime = $('#apply_future_time').val().replace(':','');
	data.title = $('#title').val();
	data.cnt = rec['length'];
	data.msg = $('#sendContent').val();
	
	if ($('input[name=sendType]:checked').val() == 1) {
		data.msg_type = "SMS";
	} else if($('input[name=sendType]:checked').val() == 2) {
		data.msg_type = "LMS";
	}
	
	for(var i = 1; i < Number(rec['length'])+1; i++) {
		data['rec_' + i] = rec['rec_' + i];
		data['msg_' + i] = $('#sendContent').val().replaceAll('%고객명%', rec['nm_' + i]);
	}
	var dataStr = JSON.stringify(data);
/* 	{
		"msg" : $('#sendContent').val(),
		"title" : $('#title').val(),
		"receiver" : receiver,
		"destination" : destination,
		"rdate" : $('#apply_future_date').val().replaceAll('-',''),
		"rtime" : $('#apply_future_time').val().replace(':','')
	} */
	
 	$.ajax({
		type	: "post",
		url		: '/admin/common/send_sms',
		data 	: data,
		success	: function(result) {
			var jsonObj = JSON.parse(result);
			alert('성공적으로 전송하였습니다.');
			$('#title').val('');
			$('#sendContent').val('');
			$('input[name=sendType][value=0]').prop('checked',true);
			if($('input[name=is_check]').prop('checked', true)) {
				$('input[name=is_check]').trigger('click');
			}
			setTakerList(0);
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	});
}
//유효성검사
function checkSendForm () {
	
	var flag = true;
	
	if(!$('#title').val()) {
		alert('제목을 입력해주세요.');
		$('#title').focus();
		flag = false;
	} else if(!$('#sendContent').val()) {
		alert('내용을 입력해주세요.');
		$('#sendContent').focus();
		flag = false;
	} else if($('input[name=is_check]').is(":checked")) {
		if($('#apply_future_date').val() == '') {
			alert('날짜를 선택해주세요.');
			$('#apply_future_date').focus();
			flag = false;
			return;
		}
		if($('#apply_future_time').val() == '') {
			alert('시간을 선택해주세요.');
			$('#apply_future_time').focus();
			flag = false;
			return;
		}
		
		var today = new Date();
		var dateArr = $('#apply_future_date').val().split('-');
		var apply_future_date = new Date(dateArr[0], dateArr[1]-1, dateArr[2], 
				$('#apply_future_time').val().substr(0,2), $('#apply_future_time').val().substr(3,2));
		
		if(apply_future_date < today) {
			alert('오늘 현재시간 이후의 일정만 가능합니다.');
			$('#apply_future_date').focus();
			flag = false;
		}
	}
	return flag;
}

</script>
</head>

<body>
<div class="content_wraper" id="wrapper">
    <div class="tab_body">
		<form action="popupActionForm" method="post">
			<table style="height: 410px;">
				<thead>
					<tr>
						<th style="width: 42%;">받는 사람</th>
						<th style="width: 58%;">내용 작성</th>
					</tr>
					<tr>
						<td>
							<label><input type="radio" name="sendType" value="0" checked="checked"> 메일</label>
							<label><input type="radio" name="sendType" value="1"> SMS(단문)</label>
							<label><input type="radio" name="sendType" value="2"> SMS(장문)</label>
						</td>
						<td style="text-align: right; padding-right: 2%;">
							<span id="countSpan"></span>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<label><input type="checkbox" name="is_check" style="height: 90%; margin-top: 2px; margin-bottom: 5px;"> 예약발송</label>
						</td>
						<td>
							<div id="futureDiv" style="width: 100%; height: 100%;" hidden="hidden">
								<input type="date" id="apply_future_date" name="apply_future_date" max="9999-12-31" placeholder="yyyy-mm-dd" value="" style="width: 200px; height: 90%; margin-top: 2px; margin-bottom: 3px;">
								<input type="text" id="apply_future_time" name="apply_future_time" placeholder="시간선택" style="width: 200px; height: 90%; margin-top: 2px; margin-bottom: 3px;">
							</div>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: left; margin: 0; padding: 0;">
							<div style="height: 412px; overflow: auto;">
								<table id="takerList"></table>
							</div>
						</td>
						<td style="text-align: left;">
							<table style="height: 100%;">
								<tr>
									<td>
										<div style="width: 100%; height: 100%;">
											<input id="title" type="text" style="width: 99%; height: 10%; margin-top:2px;  margin-bottom: 4px;" placeholder="제목(50자 이내)">
											<textarea id="sendContent" style="width: 99%; height: 88%; resize: none; border-color: #C0C0C0; padding-left: 10px; padding-right: 10px;" placeholder="내용(문자의 경우, %고객명%을 사용하면 해당 부분에 개개인의 이름이 대입되어 발송됩니다. ex. %고객명%님 안녕하세요.)"></textarea>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div style="text-align: center;">
			<a id="popupSendBtn" style="width: 50%;" class="btn align_right primary" href="javascript:void();">보내기</a>
		</div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>