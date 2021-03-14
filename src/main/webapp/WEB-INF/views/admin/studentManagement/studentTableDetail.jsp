<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="<c:url value="/resources/student/css/studentTable.css"/>" rel="stylesheet" type="text/css">

<script type="text/javascript">
$(document).ready(function () {
	//달력 초기화
 	$(document).on("click",".datetimepicker", function(){
 		var $this = $(this);
 		$this.datetimepicker({
 	       	format				: 'YYYY-MM-DD',
 	        dayViewHeaderFormat	: 'YYYY년 MM월',
 	        locale				: moment.locale('ko'),
 	        defaultDate			: new Date()
 	    });
 	}); 
	
	//학적부 항목 값 세팅
	var data = ${basic};
	var detail = ${detail};
	var benefit = ${benefit};
	
	var eduHistoryList = detail.eduHistoryList;
	var languageList = detail.languageList;
	var licenseList = detail.licenseList;
	var overseasList = detail.overseasList;
	var class_nm = data.stu_class.substring(1).replace(",", "<br>");
	var user_gender;

	switch(data.stu_user_gender){
	case "A0000":
		user_gender = "남성"
		break;
	case "A0001":
		user_gender = "여성"
		break;
	}
	
	var phone = data.stu_phone;
	if(phone.trim().length == 11){
		phone = phone.substr(0,3) + '-' + phone.substr(3,4) + '-' + phone.substr(7,4);
	}
	
	$('#stu_user_nm').text(data.stu_user_nm);
	$('#stu_user_nm_en').text(data.stu_user_nm_en);
	$('#stu_user_nm_jp').text(data.stu_user_nm_jp);
	$('#stu_user_birth').text(data.stu_user_birth);
	$('#stu_user_gender').text(user_gender);
	$('#stu_user_age').text(data.stu_user_age);
	$('#stu_addr').text(data.stu_addr);
	$('#stu_phone').text(phone);
	$('#stu_email').text(data.stu_email);
	$('#gisu_nm').text(data.gisu_nm);
	$('#stu_class').html(class_nm);
	$('#stu_memo').text(data.stu_memo);
	
	//연수생, 퇴교생 구분 출력
	switch(data.stu_state_ck){
	case "A1800":
		$('.drop_tr').css("display", "none");
		break;
	case "A1801":
		$('.drop_tr').css("display","table-row");
		$('#stu_quit_dt').text(data.stu_quit_dt);
		$('#stu_quit_reason').text(data.stu_quit_reason);
		break;
	}
	$("input:radio[name=stu_state_ck]:radio[value=" + data.stu_state_ck + "]").prop('checked', true);
	//$("input:radio[name=infoProcessing]:radio[value=" + data.infoProcessing + "]").prop('checked', true);
	
	//혜택사항 출력
	var sb = new StringBuilder();
	for(var i=0; i<benefit.length; i++)
		sb.Append('<label><input type="checkbox" name="stu_benefit_ck" value="' + benefit[i].CODE + '" > ' + benefit[i].CODE_NM + '</label>');
	$('#stu_benefit').html(sb.ToString());
	
	if(data.stu_benefit_ck.trim().length != 0){
		var stu_benefit = data.stu_benefit_ck.split(',');
		for(var i=0; i<stu_benefit.length; i++)
			$("input:checkbox[name=stu_benefit_ck][value=" + stu_benefit[i] + "]").attr('checked', true);
	}
	
	//mou사항 출력
	var mou_ck = data.stu_mou_ck
	
	if(mou_ck.trim().length != 0){
		switch(mou_ck){
		case "B4500":
			$('.mou_tr').css("display","table-row");
			$('#stu_mou_sc_nm').text(data.stu_mou_sc_nm);
			break;
		case "B4501":
			$('.mou_tr').css("display", "none");
			break;
		}
		$("input:radio[name=stu_mou_ck]:radio[value=" + mou_ck + "]").prop('checked', true);
	}
	
	//학력사항 출력
	sb.empty();
	for(var i=0; i<eduHistoryList.length; i++){
		var edu = eduHistoryList[i];
		var stu_gd_ck;
		var edu_field;
		
		switch(edu.stu_edu_gd_ck){
		case "B1000":
			stu_gd_ck = "졸업";
			break;
		case "B1001":
			stu_gd_ck = "예정";
			break;
		case "B1002":
			stu_gd_ck = "유예";
			break;
		}
		
		switch(edu.stu_edu_field){
		case "B2800":
			edu_field = "컴퓨터공학과"
			break;
		case "B2801":
			edu_field = "컴퓨터관련학과"
			break;
		case "B2802":
			edu_field = "일어관련학과"
			break;
		case "B2803":
			edu_field = "어문학"
			break;
		case "B2804":
			edu_field = "인문학"
			break;
		case "B2805":
			edu_field = "자연계열"
			break;
		case "B2806":
			edu_field = "공학"
			break;
		case "B2807":
			edu_field = "기타"
			break;
		}
		
		sb.Append('<tr>');
		sb.Append('<td>' + edu.stu_edu_sc_nm + '</td>');
		sb.Append('<td>' + edu_field + '</td>');
		sb.Append('<td>' + edu.stu_edu_major + '</td>');
		sb.Append('<td>' + stu_gd_ck + '</td>')
		sb.Append('<td>' + edu.stu_edu_gd_dt + '</td>');
		sb.Append('<td>' + edu.stu_edu_sc_lo + '</td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr><td colspan="6"></td></tr>')
	$('#eduHistoryBody').append(sb.ToString());
	
	for(var i=0; i<eduHistoryList.length; i++)
		$('select[name="eduHistoryList['+i+'].stu_edu_gd_ck"]').val(eduHistoryList[i].stu_edu_gd_ck).prop("selected", true);
	
	//어학사항 출력
	sb.empty();
	for(var i=0; i<languageList.length; i++){
		var lang = languageList[i];
		var lang_test_nm;
		
		switch(lang.stu_lang_test_nm){
		case "B2902":
			lang_test_nm = "JLPT1급";
			break;
		case "B2903":
			lang_test_nm = "JLPT2급";
			break;
		case "B2904":
			lang_test_nm = "JPT";
			break;
		case "B2905":
			lang_test_nm = "TOEIC";
			break;
		case "B2906":
			lang_test_nm = "기타";
			break;
		}
		
		sb.Append('<tr>');
		sb.Append('<td>' + lang_test_nm + '</td>');
		sb.Append('<td>' + lang.stu_lang_grade + '</td>');
		sb.Append('<td>' + lang.stu_lang_ag + '</td>');
		sb.Append('<td>' + lang.stu_lang_obtain_dt + '</td>');
		sb.Append('<td>' + lang.stu_lang_note + '</td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr><td colspan="5"></td></tr>')
	$('#languageBody').append(sb.ToString());

	//자격사항 출력
	sb.empty();
	for(var i=0; i<licenseList.length; i++){
		var license = licenseList[i];
		var license_nm
		
		switch(license.stu_license_nm){
		case "B2900":
			license_nm = "정보처리기사"
			break;
		case "B2901":
			license_nm = "정보처리산업기사"
			break;
		case "B2906":
			license_nm = "기타"
			break;
		}
		
		sb.Append('<tr>');
		sb.Append('<td>' + license_nm + '</td>');
		sb.Append('<td>' + license.stu_license_ag + '</td>');
		sb.Append('<td>' + license.stu_license_obtain_dt + '</td>');
		sb.Append('<td>' + license.stu_license_note + '</td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr><td colspan="4"></td></tr>')
	$('#licenseBody').append(sb.ToString());

	//해외경험 출력
	sb.empty();
	for(var i=0; i<overseasList.length; i++){
		var overseas = overseasList[i];
		
		sb.Append('<tr>');
		sb.Append('<td>' + overseas.stu_overseas_nm + '</td>');
		sb.Append('<td>' + overseas.stu_overseas_st + '</td>');
		sb.Append('<td>' + overseas.stu_overseas_et + '</td>');
		sb.Append('<td>' + overseas.stu_overseas_purpose + '</td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr><td colspan="4"></td></tr>')
	$('#overseasBody').append(sb.ToString());
	
	//첨부파일
	var photo_download_url;
	var edu_download_url; 
	var isr_download_url;
	var imm_download_url;
	var worknet_download_url;
	var quit_download_url;
	
	if(data.stu_photo_file != undefined){
		var photoFile_detail = data.stu_photo_file.detailList;
		
		if(photoFile_detail != undefined && photoFile_detail.length > 0){
			var photoFile = photoFile_detail[0];
			
			// urlPath null 유무 : 지원서를 학적부로 복사할 때 urlPath를 등록하지 않아서 null이 되고, 이 경우 다운로드 url은 smtp에서 저장한 파일경로를 사용한다.
			//						학적부에서 첨부파일을 새로 등록했을 때는 urlPath가 등록되고, 다운로드 url은 changbi에서 저장한 파일경로를 사용한다.
			if(photoFile.urlPath != null){
				$('.stu_photo_img').attr('src', photoFile.urlPath);
				//$('.stu_photo_img').attr('src', '/kim' + photoFile.urlPath);
				photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=uploadImage";
			}else{
				switch(data.gisu_id){
				case "n000000458" : //SWDO 1기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_53/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_53";
					break;
				case "n000000459" : //SWDO 2기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_58/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_58";
					break;
				case "n000000460" : //SWDO 3기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_60/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_60";
					break;
				case "n000000461" : //SWDO 4기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_94/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_94";
					break;
				case "n000000462" : //SWDO 5기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_10000/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_10000";
					break;
				case "n000000528" : //SWDO 6기
					$('.stu_photo_img').attr('src', '/edu/apply/photo/' + data.user_id + '_10006/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=edu/apply/photo/" + data.user_id + "_10006";
					break;
				default :
					$('.stu_photo_img').attr('src', '/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName);
					//$('.stu_photo_img').attr('src', '/kim/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName);
					photo_download_url = "/forFaith/file/file_download?origin=" + photoFile.originFileName + "&saved=" + photoFile.fileName + "&path=stu/apply/photo/" + data.user_id + "_" + data.gisu_id;
					break;
				}
			}
		}
	}else $('#area0').remove();
	
	if(data.stu_edu_file != undefined){
		var eduFile_detail = data.stu_edu_file.detailList;
		
		if(eduFile_detail != undefined && eduFile_detail.length > 0){
			var eduFile = eduFile_detail[0];
			$('#area1').find('#edu_fileName').text(eduFile.originFileName);
			
			if(eduFile.urlPath != null){
				edu_download_url = "/forFaith/file/file_download?origin=" + eduFile.originFileName + "&saved=" + eduFile.fileName + "&path=uploadImage";
			}else{
				edu_download_url = "/forFaith/file/file_download?origin=" + eduFile.originFileName + "&saved=" + eduFile.fileName + "&path=stu/apply/edu_history/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area1').remove();
	
	if(data.stu_isr_file != undefined){
		var isrFile_detail = data.stu_isr_file.detailList;
		
		if(isrFile_detail != undefined && isrFile_detail.length > 0){
			var isrFile = isrFile_detail[0];
			$('#area2').find('#isr_fileName').text(isrFile.originFileName);
			
			if(isrFile.urlPath != null){
				isr_download_url = "/forFaith/file/file_download?origin=" + isrFile.originFileName + "&saved=" + isrFile.fileName + "&path=uploadImage";
			}else{
				isr_download_url = "/forFaith/file/file_download?origin=" + isrFile.originFileName + "&saved=" + isrFile.fileName + "&path=stu/apply/insurance/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area2').remove();
	
	if(data.stu_imm_file != undefined){
		var immFile_detail = data.stu_imm_file.detailList;
		
		if(immFile_detail != undefined && immFile_detail.length > 0){
			var immFile = immFile_detail[0];
			$('#area3').find('#imm_fileName').text(immFile.originFileName);
			
			if(immFile.urlPath != null){
				imm_download_url = "/forFaith/file/file_download?origin=" + immFile.originFileName + "&saved=" + immFile.fileName + "&path=uploadImage";
			}else{
				imm_download_url = "/forFaith/file/file_download?origin=" + immFile.originFileName + "&saved=" + immFile.fileName + "&path=stu/apply/immigration/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area3').remove();
	
	if(data.stu_worknet_file != undefined){
		var worknetFile_detail = data.stu_worknet_file.detailList;
		
		if(worknetFile_detail != undefined && worknetFile_detail.length > 0){
			var worknetFile = worknetFile_detail[0];
			$('#area4').find('#worknet_fileName').text(worknetFile.originFileName);
			
			if(worknetFile.urlPath != null){
				worknet_download_url = "/forFaith/file/file_download?origin=" + worknetFile.originFileName + "&saved=" + worknetFile.fileName + "&path=uploadImage";
			}else{
				worknet_download_url = "/forFaith/file/file_download?origin=" + worknetFile.originFileName + "&saved=" + worknetFile.fileName + "&path=stu/apply/worknet/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area4').remove();
	
	if(data.stu_quit_file != undefined){
		var quitFile_detail = data.stu_quit_file.detailList;
		
		if(quitFile_detail != undefined && quitFile_detail.length > 0){
			var quitFile = quitFile_detail[0];
			
			$('#area5').find('#quit_fileName').text(quitFile.originFileName);
			quit_download_url = "/forFaith/file/file_download?origin=" + quitFile.originFileName + "&saved=" + quitFile.fileName + "&path=uploadImage";
		}	
	}else $('#area5').remove();
	
	$('.downloadBtn').on('click', function(){
		var type = $(this).closest('.file_td').attr('id');
		
		switch(type){
		case 'photoFile':
			location.href = photo_download_url;
			break;
		case 'eduFile':
			location.href = edu_download_url;
			break;
		case 'isrFile':
			location.href = isr_download_url;
			break;
		case 'immFile':
			location.href = imm_download_url;
			break;
		case 'worknetFile':
			location.href = worknet_download_url;
			break;
		case 'quitFile':
			location.href = quit_download_url;
			break;
		}
	});
	
	$('#updateBtn').click(function(){
		$('#searchStu_seq').val(data.stu_seq); 
		contentLoad('학적부 수정', '/admin/studentManagement/studentTableModify', $('form[name=searchForm]').serialize());
	});
	
	$("#listBtn").unbind("click").bind("click", function() {
		$('#searchStu_seq').val(0);
		contentLoad('학적부 관리', '/admin/studentManagement/studentTableManagement', $('form[name=searchForm]').serialize());
	});
	
}); //readyFunc 끝

//학적부 출력
function print_stuInfo(){
	var detail = ${detail};
	var str = '<input type="hidden" name="stu_seq" value="'+ detail.stu_seq +'">'
	$("#stuInfo_popup").html(str);
	
	var popupX = (window.screen.width / 2) - ( 1200 / 2 );
	var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
	var stuInfo_popup = document.stuInfo_popup;
	window.open('','stuInfo_print',"width=800,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
	stuInfo_popup.target = 'stuInfo_print';
	stuInfo_popup.submit();
}
</script>

<div class="content_wraper">
	<h3>학적부 수정</h3>
	<a class="btn" type="button" style="vertical-align: bottom;" onclick="print_stuInfo()">인쇄</a>
	
	<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
	<form name="searchForm" method="post">
		<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
		<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
		<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />	
		<input type="hidden" name="id" value="" />
       	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
       	<input type="hidden" name="crc_id" value="${search.crc_id }" id="searchCrc_id"/>
       	<input type="hidden" name="gisu_id" value="${search.gisu_id }" id="searchGisu_id"/>
       	<input type="hidden" name="stu_state_ck" value="${search.stu_state_ck }" id="searchStu_state_ck"/>
       	<input type="hidden" name="stu_seq" value="${search.stu_seq }" id="searchStu_seq"/> <!-- 수정화면으로 넘어갈 때 사용 -->
       	<!-- 정상회원만 조회 -->
       	<input type="hidden" name="useYn" value='Y' />
	</form>
	<!-- //searchForm end -->
	
	<form>
		<table class="tg">
			<tbody>
			  <tr class="left_td">
			  	<th class="file_td" id="photoFile" rowspan="6">
					<div class='file_info_area' id="area0" style='display:inline-block;'>
						<div class="img_view" style="padding-top: 5px;">
							<img class="stu_photo_img" alt="" width="150px" height="200px">
						</div>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" />
						</div>
					</div>
			    </th>
			    <th class="tg-0pky" colspan="1">이름</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_nm"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">영문명</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_nm_en">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">일문명</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_nm_jp">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">생년월일</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_birth"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">성별</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_gender"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">나이</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_age"></td>
			  </tr>
			  <tr class="left_td">
			  	<th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">주소</th>
			    <td class="tg-0pky" colspan="3" id="stu_addr"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">연락처</th>
			    <td class="tg-0pky" colspan="3" id="stu_phone">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">이메일</th>
			    <td class="tg-0pky" colspan="3" id="stu_email">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">기수</th>
			    <td class="tg-0pky" colspan="3" id="gisu_nm"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">구분</th>
			    <td class="tg-0pky" colspan="3" id="stu_state">
			    	<label class="state_radio">
						<input type="radio" name="stu_state_ck" value="A1800" onclick="return(false);"> 연수생
					</label>
					<label class="state_radio">
						<input type="radio" name="stu_state_ck" value="A1801" onclick="return(false);"> 퇴교생
					</label>
			    </td>
			  </tr>
			  <tr class="drop_tr left_td">
			  	<th class="tg-0pky"></th>
			  	<th class="tg-0pky">퇴교사유</th>
			  	<td id="stu_quit_reason"></td>
			  	<th>퇴교일자</th>
			  	<td id="stu_quit_dt"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">분반</th>
			    <td class="tg-0pky" colspan="3" id="stu_class"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky">혜택사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_benefit">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky">MOU사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_mou_ck">
			    	<label class="mou_radio">
						<input type="radio" name="stu_mou_ck" value="B4500" onclick="return(false);">해당
					</label>
					<label class="mou_radio">
						<input type="radio" name="stu_mou_ck" value="B4501" onclick="return(false);">해당없음
					</label>
			    </td>
			  </tr>
			  <tr class="mou_tr left_td">
			  	<th class="tg-0pky">MOU해당 학교</th>
			  	<td class="tg-0pky" colspan="4" id="stu_mou_sc_nm"></td>
			  </tr>
			  <tr class="stuTb_small_table">
			    <th class="tg-0pky">학력사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_eduHistory">
					<table>
						<thead>
							<tr>
								<th>학교명</th>
								<th>전공계열</th>
								<th>전공</th>
								<th>졸업상태</th>
								<th>졸업년월</th>
								<th>소재지</th>
							</tr>
						</thead>
						<tbody id="eduHistoryBody"></tbody>
					</table>
			    </td>
			  </tr>
			  <tr class="stuTb_small_table">
			    <th class="tg-0pky">공인어학성적</th>
			    <td class="tg-0pky" colspan="4" id="stu_language">
					<table>
						<thead>
							<tr>
								<th>시험명</th>
								<th>점수/등급</th>
								<th>발급기관</th>
								<th>취득일자</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="languageBody"></tbody>
					</table>
			    </td>
			  </tr>
			  <tr class="stuTb_small_table">
			    <th class="tg-0pky">자격사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_license">
			    	<table>
						<thead>
							<tr>
								<th>자격증명</th>
								<th>발급기관</th>
								<th>취득일자</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="licenseBody"></tbody>
					</table>
			    </td>
			  </tr>
			  <!-- <tr>
			    <th class="tg-0pky">정보처리기사 유무</th>
			    <td class="tg-0pky" colspan="2" id="infoProcessing">
			    	<label class="infoProcessing_radio">
						<input type="radio" name="infoProcessing" value="B2500">있다
					</label>
					<label class="infoProcessing_radio">
						<input type="radio" name="infoProcessing" value="B2501">없다
					</label>
			    </td>
			  </tr> -->
			  <tr class="stuTb_small_table">
			    <th class="tg-0pky">해외연수경험</th>
			    <td class="tg-0pky" colspan="4" id="stu_overseas">
			    	<table>
						<thead>
							<tr>
								<th>국가명</th>
								<th>시작년월</th>
								<th>종료년월</th>
								<th>목적</th>
							</tr>
						</thead>
						<tbody id="overseasBody"></tbody>
					</table>
			    </td>
			  </tr>
			  <tr class="files_tr left_td">
			    <th class="tg-0pky stu_files" rowspan="5">증빙서류</th>
			    <th class="tg-0pky">최종학력증명서</th>
			    <td class="file_td" colspan="3" id="eduFile">
				    <div class='file_info_area' id="area1" style='float: left;'>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<span id="edu_fileName"></span>
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" />
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			  	<th>고용보험 상실내역 확인서</th>
			    <td class="file_td" colspan="3" id="isrFile">
				    <div class='file_info_area' id="area2" style='float: left;'>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<span id="isr_fileName"></span>
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" />
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th>출입국 사실증명서</th>
			    <td class="file_td" colspan="3" id="immFile">
				    <div class='file_info_area' id="area3" style='float: left;'>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<span id="imm_fileName"></span>
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" />
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			  	<th>워크넷 직무평가 결과서</th>
			    <td class="file_td" colspan="3" id="worknetFile">
				    <div class='file_info_area' id="area4" style='float: left;'>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<span id="worknet_fileName"></span>
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" />
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="drop_tr left_td">
			  	<th>퇴교 서류</th>
			    <td class="file_td" colspan="3" id="quitFile">
				    <div class='file_info_area' id="area5" style='float: left;'>
						<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
							<span id="quit_fileName"></span>
							<input type="button" class="downloadBtn" value="다운로드" style="width: 200px; height: 30px;" /> <!-- 파일 오리지널 네임 -->
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky">메모</th>
			    <td class="tg-0pky" colspan="4" id="stu_memo"></td>
			  </tr>
			</tbody>
		</table>
	</form>
	<div>
		<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
		<a id="updateBtn" class="btn align_right primary" href="javascript:void();">수정</a>
	</div>
	<div id="stu_detail"></div>
	<div id="resultbody"></div>
	
	<form action="/admin/studentManagement/print_stuInfo" method="post" name="stuInfo_popup" id="stuInfo_popup"></form>
</div>


