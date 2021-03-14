<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="<c:url value="/resources/student/css/studentTable.css"/>" rel="stylesheet" type="text/css">

<script type="text/javascript">
$(document).ready(function () {
	// 네이버 스마트 에디터 저장 객체 : 이 페이지에서는 스마트 에디터를 사용하지 않지만 객체 생성을 하지않으면 아래의 setPageInit 실행시 오류가 나기 때문에 객체생성함.
	//						setPageInit 이벤트는 달력, 파일 업로드 설정을 위해서 필요함
	var editor_object = [];
	
	// 파일 업로드 정보 객체 생성 및 전달
	var file_object = [];

	// 파일 총 6개 : 사진, 학력증명서, 고용보험, 출입국, 워크넷, 퇴교 서류
	file_object[0] = { maxCount : 1, maxSize : 10, maxTotalSize : 10, accept : 'image'};
	file_object[1] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[2] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[3] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[4] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	file_object[5] = { maxCount : 1, maxSize : 100, maxTotalSize : 100, accept : 'all'};
	
	// 에디터, 달력 등 초기화
	setPageInit(editor_object, file_object);
	
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
	
	$("input[name=stu_seq]").val(data.stu_seq);
	$("input[name=gisu_id]").val(data.gisu_id);
	$("input[name=user_id]").val(data.user_id);
	$('#stu_user_nm').text(data.stu_user_nm);
	$("input[name=stu_user_nm_en]").val(data.stu_user_nm_en);
	$("input[name=stu_user_nm_jp]").val(data.stu_user_nm_jp);
	$('#stu_user_birth').text(data.stu_user_birth);
	$('#stu_user_gender').text(user_gender);
	$("input[name=stu_user_gender]").val(data.stu_user_gender);
	$('#stu_user_age').text(data.stu_user_age);
	$("input[name=stu_zipcode]").val(detail.stu_zipcode);
	$("input[name=stu_addr]").val(detail.stu_addr);
	$("input[name=stu_addr_detail]").val(detail.stu_addr_detail);
	$("input[name=stu_phone]").val(data.stu_phone);
	$("input[name=stu_email]").val(data.stu_email);
	$('#gisu_nm').text(data.gisu_nm);
	$('#stu_class').html(class_nm);
	$("textarea[name=stu_memo]").val(data.stu_memo);
	
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
	switch(data.stu_mou_ck){
	case "B4500":
		$('.mou_tr').css("display","table-row");
		$('#stu_mou_sc_nm').val(data.stu_mou_sc_nm);
		break;
	case "B4501":
		$('.mou_tr').css("display", "none");
	}
	$("input:radio[name=stu_mou_ck]:radio[value=" + data.stu_mou_ck + "]").prop('checked', true);
	
	var edu_download_url;
	var isr_download_url;
	var imm_download_url;
	var worknet_download_url;
	var quit_download_url;
	
	//사진 파일 데이터 세팅
	if(data.stu_photo_file != undefined){
		$('input[name="stu_photo_file.fileId"]').val(data.stu_photo_file.fileId);
		var photoFile_detail = data.stu_photo_file.detailList;
		
		if(photoFile_detail != undefined && photoFile_detail.length > 0){
			var photoFile = photoFile_detail[0];
			
			$('#area0').find('.attach_file_name').val(photoFile.fileName);
			$('#area0').find('.attach_file_path').val(photoFile.filePath);
			$('#area0').find('.attach_file_size').val(photoFile.fileSize);
			$('#area0').find('.attach_origin_file_name').val(photoFile.originFileName);
			$('#area0').find('.attach_url_path').val(photoFile.urlPath);
			
			// urlPath null 유무 : 지원서를 학적부로 복사할 때 urlPath를 등록하지 않아서 null이 되고, 이 경우 다운로드 url은 smtp에서 저장한 파일경로를 사용한다.
			//						학적부에서 첨부파일을 새로 등록했을 때는 urlPath가 등록되고, 다운로드 url은 changbi에서 저장한 파일경로를 사용한다.
			if(photoFile.urlPath != null){
				$('#area0').find('img').attr('src', photoFile.urlPath);
				//$('#area0').find('img').attr('src', '/kim' + photoFile.urlPath);
			}else{
				switch(data.gisu_id){
				case "n000000458" : //SWDO 1기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_53/' + photoFile.fileName);
					break;
				case "n000000459" : //SWDO 2기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_58/' + photoFile.fileName);
					break;
				case "n000000460" : //SWDO 3기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_60/' + photoFile.fileName);
					break;
				case "n000000461" : //SWDO 4기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_94/' + photoFile.fileName);
					break;
				case "n000000462" : //SWDO 5기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_10000/' + photoFile.fileName);
					break;
				case "n000000528" : //SWDO 6기
					$('#area0').find('img').attr('src', '/edu/apply/photo/' + data.user_id + '_10006/' + photoFile.fileName);
					break;
				default :
					$('#area0').find('img').attr('src', '/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName);
					//$('#area0').find('img').attr('src', '/kim/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName);
					break;
				}
			}
		}
	}else {
		$('#area0').remove();
	}
	
	//최종학력증명서 첨부파일 데이터 세팅
	if(data.stu_edu_file != undefined){
		$('input[name="stu_edu_file.fileId"]').val(data.stu_edu_file.fileId);
		var eduFile_detail = data.stu_edu_file.detailList;
		
		if(eduFile_detail != undefined && eduFile_detail.length > 0){
			var eduFile = eduFile_detail[0];
			
			$('#area1').find('.downloadBtn').val(eduFile.originFileName);
			$('#area1').find('.attach_file_name').val(eduFile.fileName);
			$('#area1').find('.attach_file_path').val(eduFile.filePath);
			$('#area1').find('.attach_file_size').val(eduFile.fileSize);
			$('#area1').find('.attach_origin_file_name').val(eduFile.originalFileName);
			$('#area1').find('.attach_url_path').val(eduFile.urlPath);
			
			if(eduFile.urlPath != null){
				edu_download_url = "/forFaith/file/file_download?origin=" + eduFile.originFileName + "&saved=" + eduFile.fileName + "&path=uploadImage";
			}else{
				edu_download_url = "/forFaith/file/file_download?origin=" + eduFile.originFileName + "&saved=" + eduFile.fileName + "&path=stu/apply/edu_history/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area1').remove();
	
	//고용보험 상실내역 확인서 첨부파일 데이터 세팅
	if(data.stu_isr_file != undefined){
		$('input[name="stu_isr_file.fileId"]').val(data.stu_isr_file.fileId);
		var isrFile_detail = data.stu_isr_file.detailList;
		
		if(isrFile_detail != undefined && isrFile_detail.length > 0){
			var isrFile = isrFile_detail[0];
			
			$('#area2').find('.downloadBtn').val(isrFile.originFileName);
			$('#area2').find('.attach_file_name').val(isrFile.fileName);
			$('#area2').find('.attach_file_path').val(isrFile.filePath);
			$('#area2').find('.attach_file_size').val(isrFile.fileSize);
			$('#area2').find('.attach_origin_file_name').val(isrFile.originalFileName);
			$('#area2').find('.attach_url_path').val(isrFile.urlPath);
			
			if(isrFile.urlPath != null){
				isr_download_url = "/forFaith/file/file_download?origin=" + isrFile.originFileName + "&saved=" + isrFile.fileName + "&path=uploadImage";
			}else{
				isr_download_url = "/forFaith/file/file_download?origin=" + isrFile.originFileName + "&saved=" + isrFile.fileName + "&path=stu/apply/insurance/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area2').remove();
	
	//출입국 사실증명서 첨부파일 데이터 세팅
	if(data.stu_imm_file != undefined){
		$('input[name="stu_imm_file.fileId"]').val(data.stu_imm_file.fileId);
		var immFile_detail = data.stu_imm_file.detailList;
		
		if(immFile_detail != undefined && immFile_detail.length > 0){
			var immFile = immFile_detail[0];
			
			$('#area3').find('.downloadBtn').val(immFile.originFileName);
			$('#area3').find('.attach_file_name').val(immFile.fileName);
			$('#area3').find('.attach_file_path').val(immFile.filePath);
			$('#area3').find('.attach_file_size').val(immFile.fileSize);
			$('#area3').find('.attach_origin_file_name').val(immFile.originalFileName);
			$('#area3').find('.attach_url_path').val(immFile.urlPath);
			
			if(immFile.urlPath != null){
				imm_download_url = "/forFaith/file/file_download?origin=" + immFile.originFileName + "&saved=" + immFile.fileName + "&path=uploadImage";
			}else{
				imm_download_url = "/forFaith/file/file_download?origin=" + immFile.originFileName + "&saved=" + immFile.fileName + "&path=stu/apply/immigration/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area3').remove();
	
	//워크넷 직무평가 결과서 첨부파일 데이터 세팅
	if(data.stu_worknet_file != undefined){
		$('input[name="stu_worknet_file.fileId"]').val(data.stu_worknet_file.fileId);
		var worknetFile_detail = data.stu_worknet_file.detailList;
		
		if(worknetFile_detail != undefined && worknetFile_detail.length > 0){
			var worknetFile = worknetFile_detail[0];
			
			$('#area4').find('.downloadBtn').val(worknetFile.originFileName);
			$('#area4').find('.attach_file_name').val(worknetFile.fileName);
			$('#area4').find('.attach_file_path').val(worknetFile.filePath);
			$('#area4').find('.attach_file_size').val(worknetFile.fileSize);
			$('#area4').find('.attach_origin_file_name').val(worknetFile.originalFileName);
			$('#area4').find('.attach_url_path').val(worknetFile.urlPath);
			
			if(worknetFile.urlPath != null){
				worknet_download_url = "/forFaith/file/file_download?origin=" + worknetFile.originFileName + "&saved=" + worknetFile.fileName + "&path=uploadImage";
			}else{
				worknet_download_url = "/forFaith/file/file_download?origin=" + worknetFile.originFileName + "&saved=" + worknetFile.fileName + "&path=stu/apply/worknet/" + data.user_id + "_" + data.gisu_id;
			}
		}
	}else $('#area4').remove();
	
	//퇴교서류 첨부파일 데이터 세팅
	if(data.stu_quit_file != undefined){
		$('input[name="stu_quit_file.fileId"]').val(data.stu_quit_file.fileId);
		var quitFile_detail = data.stu_quit_file.detailList;
		
		if(quitFile_detail != undefined && quitFile_detail.length > 0){
			var quitFile = quitFile_detail[0];
			
			$('#area5').find('.downloadBtn').val(quitFile.originFileName);
			$('#area5').find('.attach_file_name').val(quitFile.fileName);
			$('#area5').find('.attach_file_path').val(quitFile.filePath);
			$('#area5').find('.attach_file_size').val(quitFile.fileSize);
			$('#area5').find('.attach_origin_file_name').val(quitFile.originalFileName);
			$('#area5').find('.attach_url_path').val(quitFile.urlPath);
			quit_download_url = "/forFaith/file/file_download?origin=" + quitFile.originFileName + "&saved=" + quitFile.fileName + "&path=uploadImage";
		}
	}else $('#area5').remove();
	
	//학력사항 데이터 세팅
	sb.empty();
	for(var i=0; i<eduHistoryList.length; i++){
		var edu = eduHistoryList[i];
		
		sb.Append('<tr>');
		sb.Append('<td>');
		sb.Append('<input type="hidden" name="eduHistoryList['+i+'].stu_seq" value="' + data.stu_seq +'">');
		sb.Append('<input type="hidden" name="eduHistoryList['+i+'].gisu_id" value="' + data.gisu_id +'">');
		sb.Append('<input type="hidden" name="eduHistoryList['+i+'].user_id" value="' + data.user_id +'">');
		sb.Append('<input type="text" name="eduHistoryList['+i+'].stu_edu_sc_nm" value="' + edu.stu_edu_sc_nm +'">');
		sb.Append('</td>');
		sb.Append('<td><select name="eduHistoryList['+i+'].stu_edu_field">');
		sb.Append('<option disabled>선택</option>');
		sb.Append('<option value="B2800">컴퓨터공학과</option>');
		sb.Append('<option value="B2801">컴퓨터관련학과</option>');
		sb.Append('<option value="B2802">일어관련학과</option>');
		sb.Append('<option value="B2803">어문학</option>');
		sb.Append('<option value="B2804">인문학</option>');
		sb.Append('<option value="B2805">자연계열</option>');
		sb.Append('<option value="B2806">공학</option>');
		sb.Append('<option value="B2807">기타</option>');
		sb.Append('</select></td>');
		sb.Append('<td><input type="text" name="eduHistoryList['+i+'].stu_edu_major" value="' + edu.stu_edu_major +'"></td>');
		sb.Append('<td><select name="eduHistoryList['+i+'].stu_edu_gd_ck">');
		sb.Append('<option disabled>선택</option>');
		sb.Append('<option value="B1000">졸업</option>');
		sb.Append('<option value="B1001">예정</option>');
		sb.Append('<option value="B1002">유예</option>');
		sb.Append('</select></td>');
		sb.Append('<td>');
		sb.Append('<div class="input-group date datetimepicker">');
		sb.Append('<input type="text" name="eduHistoryList['+i+'].stu_edu_gd_dt" class="form-control" value="' + edu.stu_edu_gd_dt +'">');
		sb.Append('<span class="input-group-addon">');
		sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
		sb.Append('</span></div></td>');
		sb.Append('<td><input type="text" name="eduHistoryList['+i+'].stu_edu_sc_lo" value="' + edu.stu_edu_sc_lo +'"></td>');
		sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr id="eduHistory_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createEduHistory()">항목 추가</button></td></tr>')
	$('#eduHistoryBody').append(sb.ToString());
	
	for(var i=0; i<eduHistoryList.length; i++){
		$('select[name="eduHistoryList['+i+'].stu_edu_field"]').val(eduHistoryList[i].stu_edu_field).prop("selected", true);
		$('select[name="eduHistoryList['+i+'].stu_edu_gd_ck"]').val(eduHistoryList[i].stu_edu_gd_ck).prop("selected", true);
	}
	
	//어학사항 데이터 세팅
	sb.empty();
	for(var i=0; i<languageList.length; i++){
		var lang = languageList[i];
		
		sb.Append('<tr>');
		sb.Append('<td>');
		sb.Append('<input type="hidden" name="languageList['+i+'].stu_seq" value="' + data.stu_seq +'">');
		sb.Append('<input type="hidden" name="languageList['+i+'].gisu_id" value="' + data.gisu_id +'">');
		sb.Append('<input type="hidden" name="languageList['+i+'].user_id" value="' + data.user_id +'">');
		sb.Append('<select name="languageList['+i+'].stu_lang_test_nm">');
		sb.Append('<option disabled>선택</option>');
		sb.Append('<option value="B2902">JLPT1급</option>');
		sb.Append('<option value="B2903">JLPT2급</option>');
		sb.Append('<option value="B2904">JPT</option>');
		sb.Append('<option value="B2905">TOEIC</option>');
		sb.Append('<option value="B2906">기타</option>');
		sb.Append('</select></td>');
		sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_grade" value="' + lang.stu_lang_grade +'"></td>');
		sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_ag" value="' + lang.stu_lang_ag +'"></td>');
		sb.Append('<td>');
		sb.Append('<div class="input-group date datetimepicker">');
		sb.Append('<input type="text" name="languageList['+i+'].stu_lang_obtain_dt" class="form-control" value="' + lang.stu_lang_obtain_dt +'">');
		sb.Append('<span class="input-group-addon">');
		sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
		sb.Append('</span></div></td>');
		sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_note" value="' + lang.stu_lang_note +'"></td>');
		sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr id="language_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createLanguage()">항목 추가</button></td></tr>')
	$('#languageBody').append(sb.ToString());
	
	for(var i=0; i<languageList.length; i++)
		$('select[name="languageList['+i+'].stu_lang_test_nm"]').val(languageList[i].stu_lang_test_nm).prop("selected", true);
	
	//자격증 사항 데이터 세팅
	sb.empty();
	for(var i=0; i<licenseList.length; i++){
		var license = licenseList[i];
		
		sb.Append('<tr>');
		sb.Append('<td>');
		sb.Append('<input type="hidden" name="licenseList['+i+'].stu_seq" value="' + data.stu_seq +'">');
		sb.Append('<input type="hidden" name="licenseList['+i+'].gisu_id" value="' + data.gisu_id +'">');
		sb.Append('<input type="hidden" name="licenseList['+i+'].user_id" value="' + data.user_id +'">');
		sb.Append('<select name="licenseList['+i+'].stu_license_nm">');
		sb.Append('<option disabled>선택</option>');
		sb.Append('<option value="B2900">정보처리기사</option>');
		sb.Append('<option value="B2901">정보처리산업기사</option>');
		sb.Append('<option value="B2906">기타</option>');
		sb.Append('</select></td>');
		sb.Append('<td><input type="text" name="licenseList['+i+'].stu_license_ag" value="' + license.stu_license_ag +'"></td>');
		sb.Append('<td>');
		sb.Append('<div class="input-group date datetimepicker">');
		sb.Append('<input type="text" name="licenseList['+i+'].stu_license_obtain_dt" class="form-control" value="' + license.stu_license_obtain_dt +'">');
		sb.Append('<span class="input-group-addon">');
		sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
		sb.Append('</span></div></td>');
		sb.Append('<td><input type="text" name="licenseList['+i+'].stu_license_note" value="' + license.stu_license_note +'"></td>');
		sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr id="license_tr"><td colspan="5"><button type="button" class="btn primary" onclick="createLicense()">항목 추가</button></td></tr>')
	$('#licenseBody').append(sb.ToString());
	
	for(var i=0; i<licenseList.length; i++)
		$('select[name="licenseList['+i+'].stu_license_nm"]').val(licenseList[i].stu_license_nm).prop("selected", true);
	
	//해외경험 데이터 세팅
	sb.empty();
	for(var i=0; i<overseasList.length; i++){
		var overseas = overseasList[i];
		
		sb.Append('<tr>');
		sb.Append('<td>');
		sb.Append('<input type="hidden" name="overseasList['+i+'].stu_seq" value="' + data.stu_seq +'">');
		sb.Append('<input type="hidden" name="overseasList['+i+'].gisu_id" value="' + data.gisu_id +'">');
		sb.Append('<input type="hidden" name="overseasList['+i+'].user_id" value="' + data.user_id +'">');
		sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_nm" value="' + overseas.stu_overseas_nm +'">');
		sb.Append('</td>');
		sb.Append('<td>');
		sb.Append('<div class="input-group date datetimepicker">');
		sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_st" class="form-control" value="' + overseas.stu_overseas_st +'">');
		sb.Append('<span class="input-group-addon">');
		sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
		sb.Append('</span></div></td>');
		sb.Append('<td>');
		sb.Append('<div class="input-group date datetimepicker">');
		sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_et" class="form-control" value="' + overseas.stu_overseas_et +'">');
		sb.Append('<span class="input-group-addon">');
		sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
		sb.Append('</span></div></td>');
		sb.Append('<td><input type="text" name="overseasList['+i+'].stu_overseas_purpose" value="' + overseas.stu_overseas_purpose +'"></td>');
		sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
		sb.Append('</tr>');
	}
	sb.Append('<tr id="overseas_tr"><td colspan="5"><button type="button" class="btn primary" onclick="createOverseas()">항목 추가</button></td></tr>')
	$('#overseasBody').append(sb.ToString());
	
	$('#regBtn').click(function(){
//		checkItems();

		if(confirm('저장하시겠습니까?')){
			$.ajax({
				type	: "post",
				url		: "<c:url value='/student/studentTb/updateStudentTb'/>",
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result > 0){
						alert("저장되었습니다.");
						$("#listBtn").trigger("click");
					}else{
						alert("저장에 실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	});
	
	$('.downloadBtn').on('click', function(){
		var type = $(this).closest('.file_td').attr('id');
		
		switch(type){
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
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		$('#searchStu_seq').val(0);
		contentLoad('학적부 관리', '/admin/studentManagement/studentTableManagement', $('form[name=searchForm]').serialize());
	});
	
}); //readyFunc 끝

//mou대학 리스트 팝업
function popup_mou(){
	openLayerPopup("MOU대학", "/admin/common/popup/studentTableMOU", "");
}

function createEduHistory(){
	var data = ${basic};
	var sb = new StringBuilder();
	var lastName = $('#eduHistory_tr').prev('tr').find('input').eq(0).attr('name');
	var i = 0;
	
	if(lastName != undefined)  i = Number(lastName.charAt(15)) + 1;
	
	sb.Append('<tr>');
	sb.Append('<td>');
	sb.Append('<input type="hidden" name="eduHistoryList['+i+'].stu_seq" value="' + data.stu_seq +'">');
	sb.Append('<input type="hidden" name="eduHistoryList['+i+'].gisu_id" value="' + data.gisu_id +'">');
	sb.Append('<input type="hidden" name="eduHistoryList['+i+'].user_id" value="' + data.user_id +'">');
	sb.Append('<input type="text" name="eduHistoryList['+i+'].stu_edu_sc_nm">');
	sb.Append('</td>');
	sb.Append('<td><select name="eduHistoryList['+i+'].stu_edu_field">');
	sb.Append('<option>선택</option>');
	sb.Append('<option value="B2800">컴퓨터공학과</option>');
	sb.Append('<option value="B2801">컴퓨터관련학과</option>');
	sb.Append('<option value="B2802">일어관련학과</option>');
	sb.Append('<option value="B2803">어문학</option>');
	sb.Append('<option value="B2804">인문학</option>');
	sb.Append('<option value="B2805">자연계열</option>');
	sb.Append('<option value="B2806">공학</option>');
	sb.Append('<option value="B2807">기타</option>');
	sb.Append('</select></td>');
	sb.Append('<td><input type="text" name="eduHistoryList['+i+'].stu_edu_major"></td>');
	sb.Append('<td><select name="eduHistoryList['+i+'].stu_edu_gd_ck">');
	sb.Append('<option hidden disabled selected>선택</option>');
	sb.Append('<option value="B1000">졸업</option>');
	sb.Append('<option value="B1001">예정</option>');
	sb.Append('<option value="B1002">유예</option>');
	sb.Append('</select></td>');
	sb.Append('<td>');
	sb.Append('<div class="input-group date datetimepicker">');
	sb.Append('<input type="text" name="eduHistoryList['+i+'].stu_edu_gd_dt" class="form-control">');
	sb.Append('<span class="input-group-addon">');
	sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
	sb.Append('</span></div></td>');
	sb.Append('<td><input type="text" name="eduHistoryList['+i+'].stu_edu_sc_lo"></td>');
	sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
	sb.Append('</tr>');
	
	if(i == 0) {
		sb.Append('<tr id="eduHistory_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createEduHistory()">항목 추가</button></td></tr>')
		$('#eduHistoryBody').append(sb.ToString());
		$('#eduHistory_tr').remove();
	}else $('#eduHistory_tr').before(sb.ToString());
}

function createLanguage(){
	var data = ${basic};
	var sb = new StringBuilder();
	var lastName = $('#language_tr').prev('tr').find('input').eq(0).attr('name');
	var i = 0;
	
	if(lastName != undefined)  i = Number(lastName.charAt(13)) + 1;
	
	sb.Append('<tr>');
	sb.Append('<td>');
	sb.Append('<input type="hidden" name="languageList['+i+'].stu_seq" value="' + data.stu_seq +'">');
	sb.Append('<input type="hidden" name="languageList['+i+'].gisu_id" value="' + data.gisu_id +'">');
	sb.Append('<input type="hidden" name="languageList['+i+'].user_id" value="' + data.user_id +'">');
	sb.Append('<select name="languageList['+i+'].stu_lang_test_nm">');
	sb.Append('<option>선택</option>');
	sb.Append('<option value="B2902">JLPT1급</option>');
	sb.Append('<option value="B2903">JLPT2급</option>');
	sb.Append('<option value="B2904">JPT</option>');
	sb.Append('<option value="B2905">TOEIC</option>');
	sb.Append('<option value="B2906">기타</option>');
	sb.Append('</select></td>');
	sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_grade"></td>');
	sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_ag"></td>');
	sb.Append('<td>');
	sb.Append('<div class="input-group date datetimepicker">');
    sb.Append('<input type="text" name="languageList['+i+'].stu_lang_obtain_dt" class="form-control">');
    sb.Append('<span class="input-group-addon">');
    sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
    sb.Append('</span></div></td>');
    sb.Append('<td><input type="text" name="languageList['+i+'].stu_lang_note"></td>');
    sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
	sb.Append('</tr>');
	
	if(i == 0) {
		sb.Append('<tr id="language_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createLanguage()">항목 추가</button></td></tr>')
		$('#languageBody').append(sb.ToString());
		$('#language_tr').remove();
	}else $('#language_tr').before(sb.ToString());
}

function createLicense(){
	var data = ${basic};
	var sb = new StringBuilder();
	var lastName = $('#license_tr').prev('tr').find('input').eq(0).attr('name');
	var i = 0;
	
	if(lastName != undefined)  i = Number(lastName.charAt(12)) + 1;
	
	sb.Append('<tr>');
	sb.Append('<td>');
	sb.Append('<input type="hidden" name="licenseList['+i+'].stu_seq" value="' + data.stu_seq +'">');
	sb.Append('<input type="hidden" name="licenseList['+i+'].gisu_id" value="' + data.gisu_id +'">');
	sb.Append('<input type="hidden" name="licenseList['+i+'].user_id" value="' + data.user_id +'">');
	sb.Append('<select name="licenseList['+i+'].stu_license_nm">');
	sb.Append('<option>선택</option>');
	sb.Append('<option value="B2900">정보처리기사</option>');
	sb.Append('<option value="B2901">정보처리산업기사</option>');
	sb.Append('<option value="B2906">기타</option>');
	sb.Append('</select></td>');
	sb.Append('<td><input type="text" name="licenseList['+i+'].stu_license_ag"></td>');
	sb.Append('<td>');
	sb.Append('<div class="input-group date datetimepicker">');
    sb.Append('<input type="text" name="licenseList['+i+'].stu_license_obtain_dt" class="form-control">');
    sb.Append('<span class="input-group-addon">');
    sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
    sb.Append('</span></div></td>');
    sb.Append('<td><input type="text" name="licenseList['+i+'].stu_license_note"></td>');
    sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
	sb.Append('</tr>');
	
	if(i == 0) {
		sb.Append('<tr id="license_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createLanguage()">항목 추가</button></td></tr>')
		$('#licenseBody').append(sb.ToString());
		$('#license_tr').remove();
	}else $('#license_tr').before(sb.ToString());
}

function createOverseas(){
	var data = ${basic};
	var sb = new StringBuilder();
	var lastName = $('#overseas_tr').prev('tr').find('input').eq(0).attr('name');
	var i = 0;
	
	if(lastName != undefined)  i = Number(lastName.charAt(13)) + 1;
	
	sb.Append('<tr>');
	sb.Append('<td>');
	sb.Append('<input type="hidden" name="overseasList['+i+'].stu_seq" value="' + data.stu_seq +'">');
	sb.Append('<input type="hidden" name="overseasList['+i+'].gisu_id" value="' + data.gisu_id +'">');
	sb.Append('<input type="hidden" name="overseasList['+i+'].user_id" value="' + data.user_id +'">');
	sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_nm">');
	sb.Append('</td>');
	sb.Append('<td>');
	sb.Append('<div class="input-group date datetimepicker">');
    sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_st" class="form-control">');
    sb.Append('<span class="input-group-addon">');
    sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
    sb.Append('</span></div></td>');
    sb.Append('<td>');
	sb.Append('<div class="input-group date datetimepicker">');
    sb.Append('<input type="text" name="overseasList['+i+'].stu_overseas_et" class="form-control">');
    sb.Append('<span class="input-group-addon">');
    sb.Append('<span class="glyphicon glyphicon-calendar"></span>');
    sb.Append('</span></div></td>');
	sb.Append('<td><input type="text" name="overseasList['+i+'].stu_overseas_purpose"></td>');
	sb.Append('<td><button type="button" class="btn primary" onClick="deleteItem(this)">삭제</button></td>');
	sb.Append('</tr>');
	
	if(i == 0) {
		sb.Append('<tr id="overseas_tr"><td colspan="6"><button type="button" class="btn primary" onclick="createLanguage()">항목 추가</button></td></tr>')
		$('#overseasBody').append(sb.ToString());
		$('#overseas_tr').remove();
	}else $('#overseas_tr').before(sb.ToString());
}

function deleteItem(obj){
	$(obj).closest('tr').remove();
}

function checkItems(){
	alert("유효성 검사");
}

function dropCourse(obj){
	var stu_state = $(obj).val();
	
	switch(stu_state){
	case "A1800":
		$('.drop_tr').css("display", "none");
		break;
	case "A1801":
		$('.drop_tr').css("display","table-row");
		break;
	}
}

function checkMOU(obj){
	var stu_mou = $(obj).val();
	
	switch(stu_mou){
	case "B4500":
		$('.mou_tr').css("display","table-row");
		break;
	case "B4501":
		$('.mou_tr').css("display", "none");
		break;
	}
}
</script>

<div class="content_wraper">
	<h3>학적부 수정</h3>
	
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
	
	<form name="actionForm">
		<input type="hidden" name="stu_seq">
		<input type="hidden" name="gisu_id">
		<input type="hidden" name="user_id">
		
		<table class="tg">
			<tbody>
			  <tr class="left_td">
			    <th class="file_td" rowspan="7">
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type="hidden" class='attach_file_id'	name='stu_photo_file.fileId' />
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
						</div>
						
						<div class='file_info_area' id="area0" style='display:inline-block;'>
							<div class='image_view' style='padding-top: 5px;'>
								<img style='width: 150px; height: 200px; cursor: pointer;' />
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </th>
			    <th class="tg-0pky" colspan="1">이름</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_nm"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">영문명</th>
			    <td class="tg-0pky" id="stu_user_nm_en" colspan="3">
			    	<input type="text" name="stu_user_nm_en">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">일문명</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_nm_jp">
			    	<input type="text" name="stu_user_nm_jp">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">생년월일</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_birth"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">성별
			    	<input type="hidden" name="stu_user_gender">
			    </th>
			    <td class="tg-0pky" colspan="3" id="stu_user_gender"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">나이</th>
			    <td class="tg-0pky" colspan="3" id="stu_user_age"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" colspan="1">주소</th>
			    <td class="tg-0pky" colspan="3" id="stu_addr">
			    	우편번호 <input type="text" name="stu_zipcode">
			    	주소 <input type="text" name="stu_addr">
			    	상세주소 <input type="text" name="stu_addr_detail">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">연락처</th>
			    <td class="tg-0pky" colspan="3" id="stu_phone">
			    	<input type="text" name="stu_phone">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">이메일</th>
			    <td class="tg-0pky" colspan="3" id="stu_email">
			    	<input type="text" name="stu_email">
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
						<input type="radio" name="stu_state_ck" value="A1800" onchange="dropCourse(this)"> 연수생
					</label>
					<label class="state_radio">
						<input type="radio" name="stu_state_ck" value="A1801" onchange="dropCourse(this)"> 퇴교생 
					</label>
			    </td>
			  </tr>
			  <tr class="drop_tr left_td">
			  	<th class="tg-0pky"></th>
			  	<th class="tg-0pky">퇴교사유</th>
			  	<td><textarea rows="2" cols="70" id="stu_quit_reason" name="stu_quit_reason"></textarea></td>
			  	<th>퇴교일자</th>
			  	<td>
			  		<div class="input-group date datetimepicker">
			  		<input type="text" name="stu_quit_dt" class="form-control">
			  		<span class="input-group-addon">
			  		<span class="glyphicon glyphicon-calendar"></span>
			  		</span></div></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky"></th>
			    <th class="tg-0pky" colspan="1">분반</th>
			    <td class="tg-0pky" colspan="3" id="stu_class"></td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky" >혜택사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_benefit">
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky">MOU사항</th>
			    <td class="tg-0pky" colspan="4" id="stu_mou_ck">
			    	<label class="mou_radio">
						<input type="radio" name="stu_mou_ck" value="B4500" onchange="checkMOU(this)">해당
					</label>
					<label class="mou_radio">
						<input type="radio" name="stu_mou_ck" value="B4501" onchange="checkMOU(this)">해당없음
					</label>
			    </td>
			  </tr>
			  <tr class="mou_tr left_td">
			  	<th class="tg-0pky">MOU해당 학교</th>
			  	<td class="tg-0pky" colspan="4">
			  		<input type="text" id="stu_mou_sc_nm">
			  		<input type="hidden" name="stu_mou_sc">
			  		<a class="btn" type="button" onclick="popup_mou()">대학 검색</a>
			  	</td>
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
								<th></th>
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
								<th></th>
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
								<th></th>
							</tr>
						</thead>
						<tbody id="licenseBody"></tbody>
					</table>
			    </td>
			  </tr>
			  <!-- <tr>
			    <th class="tg-0pky">정보처리기사 유무</th>
			    <td class="tg-0pky" colspan="4" id="infoProcessing">
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
								<th></th>
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
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='stu_edu_file.fileId' /> <!-- 디비에 파일 저장된 이름 -->
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<div class='file_info_area' id="area1" style='float: left;'>
							<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
								<input type="button" class="downloadBtn" style="width: 200px; height: 30px;" /> <!-- 파일 오리지널 네임 -->
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			  	<th class="tg-0pky">고용보험 상실내역 확인서</th>
			    <td class="file_td" colspan="3" id="isrFile">
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='stu_isr_file.fileId' />
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<div class='file_info_area' id="area2" style='float: left;'>
							<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
								<input type="button" class="downloadBtn" style="width: 200px; height: 30px;" />
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			  	<th class="tg-0pky">출입국 사실증명서</th>
			    <td class="file_td" colspan="3" id="immFile">
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='stu_imm_file.fileId' />
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<div class='file_info_area' id="area3" style='float: left;'>
							<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
								<input type="button" class="downloadBtn" style="width: 200px; height: 30px;" />
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			  	<th class="tg-0pky">워크넷 직무평가 결과서</th>
			    <td class="file_td" colspan="3" id="worknetFile">
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='stu_worknet_file.fileId' />
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<div class='file_info_area' id="area4" style='float: left;'>
							<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
								<input type="button" class="downloadBtn" style="width: 200px; height: 30px;" />
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="drop_tr left_td">
			  	<th class="tg-0pky">퇴교 서류</th>
			    <td class="file_td" colspan="3" id="quitFile">
			    	<div class='attach_file_area' style="clear: both;">
						<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
						<input type='hidden' class='attach_file_id'	name='stu_quit_file.fileId' />
						<input type='hidden' class='upload_dir' value="/upload/course/mainImg"/>
						
						<div class='file_upload_btn_area' style="clear: both;">
							<input type='button' class='file_upload_btn' style="cursor: pointer; margin: 5px;" value='파일검색' />
							<span class='file_upload_info'>(파일갯수 : 1개, 파일크기 : 100M )</span>
						</div>
						<div class='file_info_area' id="area5" style='float: left;'>
							<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
								<input type="button" class="downloadBtn" style="width: 200px; height: 30px;" />
							</div>
							<div class="file_info" style="padding-left: 5px;">
								<input type="hidden" class="attach_file_name" />
								<input type="hidden" class="attach_file_path" />
								<input type="hidden" class="attach_file_size" />
								<input type="hidden" class="attach_origin_file_name" />
								<input type="hidden" class="attach_url_path" />
								<input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
							</div>
						</div>
					</div>
			    </td>
			  </tr>
			  <tr class="left_td">
			    <th class="tg-0pky">메모</th>
			    <td class="tg-0pky" colspan="4" id="stu_memo">
			    	<textarea rows="3" cols="100" name="stu_memo"></textarea>
			    </td>
			  </tr>
			</tbody>
		</table>
	</form>
	<div>
		<a id="listBtn" class="btn align_right" href="javascript:void();">리스트</a>
		<a id="regBtn" class="btn align_right primary" href="javascript:void();">저장</a>
	</div>
	
	<div id="stu_detail">
	</div>
	
	<div id="resultbody">
	</div>
</div>
<!-- image Modal -->
<jsp:include page="/WEB-INF/views/admin/common/imagePreviewModal.jsp" />