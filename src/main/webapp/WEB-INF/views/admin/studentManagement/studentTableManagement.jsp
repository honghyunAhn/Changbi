<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/student/studentTb/studentList' />";
	var cirriculumList;
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));
	
	/** 함수 영역 **/
	//분류 세팅함수
	function setSearchCode() {
		if('${search.crc_id}' != '' && '${search.crc_id}' != null) {
			$("#gwajeongSelector").append('<option value="">과정 선택</option>');
			$("#gisuSelector").append('<option value="">과정 선택</option>');
			$("#stuStateSelector").append('<option value="">학적 상태</option>');
			
			for (var i = 0; i < cirriculumList.length; i++) {
				var map = cirriculumList[i];
				$("#gwajeongSelector").append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
			}
			searchListGisu('${search.crc_id}');
			$("#stuStateSelector").append('<option value="A1800">연수생</option>');
			$("#stuStateSelector").append('<option value="A1801">퇴교생</option>');
			$("#searchStu_state_ck").val('${search.stu_state_ck}');
			
			$("#gwajeongSelector option").each(function(index, item){
				if($(item).val() == '${search.crc_id}'){
					$("#gwajeongSelector").val($(item).val()).prop("selected",true);
				}
			});
			
			$("#gisuSelector option").each(function(index, item){
				if($(item).val() == '${search.gisu_id}'){
					$("#gisuSelector").val($(item).val()).prop("selected",true);
				}
			});
			
			$("#stuStateSelector option").each(function(index, item){
				if($(item).val() == '${search.stu_state_ck}'){
					$("#stuStateSelector").val($(item).val()).prop("selected",true);
				}
			});
		} else {
			$("#gwajeongSelector").append('<option value="">과정 선택</option>');
			for (var i = 0; i < cirriculumList.length; i++) {
				var map = cirriculumList[i];
				$("#gwajeongSelector").append('<option value="'+map.CRC_CLASS+ '">'+map.CRC_NM+'</option>');
			}
		}
	}
	
	$("#gwajeongSelector").change(function(){
		$("#gisuSelector").html("");
		$("#stuStateSelector").html("");
		searchListGisu($(this).val());
		$("#searchCrc_id").val($("#gwajeongSelector option:selected").val());
	});
	
	$("#gisuSelector").change(function(){
		$("#stuStateSelector").html("");
		$('#stuStateSelector').append('<option value="">학적 상태</option>');
		$("#stuStateSelector").append('<option value="A1800">연수생</option>');
		$("#stuStateSelector").append('<option value="A1801">퇴교생</option>');
		$("#searchGisu_id").val($("#gisuSelector option:selected").val());
	});
	
	$("#stuStateSelector").change(function(){
		$("#searchStu_state_ck").val($("#stuStateSelector option:selected").val());
	});
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
 			data 	: $("form[name='searchForm']").serialize(),
 			async: false,
			success	: function(result) {
				var sb = new StringBuilder();
				var sbModal = new StringBuilder();
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;
					
					for(var i=0; i<dataList.length; ++i) {
						var data = dataList[i];
						var license = data.stu_license.substring(1).replace(",", "<br>");
						var language = data.stu_language.substring(1).replace(",", "<br>");
						var overseas = data.stu_overseas.substring(1).replace(",", "<br>");
						var class_nm = data.stu_class.substring(1).replace(",", "<br>");
						var stu_gender;
						var stu_gd_ck;
						var stu_infoProcessing;
						var stu_benefit;
						var stu_mou;
						var stu_state;
						
						switch(data.stu_user_gender){
						case "A0000":
							stu_gender = "남성";
							break;
						case "A0001":
							stu_gender = "여성";
							break;
						}
						
						switch(data.stu_edu_gd_ck){
						case "B1000":
							stu_gd_ck = "졸업";
							break;
						case "B1001":
							stu_gd_ck = "예정";
							break;
						case "B1002":
							stu_gd_ck = "유예";
							break;
						default:
							stu_gd_ck = ""; //학력사항 기재 안한 경우
						}
						
						/* switch(data.infoProcessing){
						case "B2500":
							stu_infoProcessing = "있다";
							break;
						case "B2501":
							stu_infoProcessing = "없다";
							break;
						} */
						
						var stu_benefit = "";
						if(data.stu_benefit_ck.trim().length != 0){
							var benefit_arr = data.stu_benefit_ck.split(',');
							
							for(var j=0; j<benefit_arr.length; j++){
								
								switch(benefit_arr[j]){
								case "B4400":
									stu_benefit += "산인공<br>";
									break;
								case "B4401":
									stu_benefit += "강남구<br>";
									break;
								case "B4402":
									stu_benefit += "광주시<br>";
									break;
								case "B4403":
									stu_benefit += "지자체<br>";
									break;
								}
							}
						}
						
						switch(data.stu_mou_ck){
						case "B4500":
							stu_mou = "대상";
							break;
						case "B4501":
							stu_mou = "비대상";
							break;
						default:
							stu_mou = "";
						}
						
						switch(data.stu_state_ck){
						case "A1800":
							stu_state = "연수";
							break;
						case "A1801":
							stu_state = "퇴교";
							break;
						default:
							stu_state = "";
						}
						sb.Append("<tr>");
						sb.Append("<td><input type='checkbox' name='checkbox'></td>");
						sb.Append('<td>');
						sb.Append('<input type="hidden" class="stu_seq" value="'+ data.stu_seq +'">');
						sb.Append('<input type="hidden" class="cardinal_id" value="'+ data.gisu_id +'">');
						sb.Append('<input type="hidden" class="user_id" value="'+ data.user_id +'">');
						
						if(data.stu_photo_file != undefined){
							var photoFile_detail = data.stu_photo_file.detailList;
							
							if(photoFile_detail != undefined && photoFile_detail.length > 0){
								var photoFile = photoFile_detail[0];
								
								// urlPath null 유무 : 지원서를 학적부로 복사할 때 urlPath를 등록하지 않아서 null이 됨. 학적부에서 첨부파일을 수정할 때 urlPath가 등록됨.
								if(photoFile.urlPath != null){
									sb.Append('<img src="' + photoFile.urlPath + '" width="50px" height="70px">');
									//sb.Append('<img src="/kim' + photoFile.urlPath + '" width="50px" height="70px">');
								}else{
									switch(data.gisu_id){
									case "n000000458" : //SWDO 1기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_53/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									case "n000000459" : //SWDO 2기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_58/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									case "n000000460" : //SWDO 3기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_60/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									case "n000000461" : //SWDO 4기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_94/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									case "n000000462" : //SWDO 5기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_10000/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									case "n000000528" : //SWDO 6기
										sb.Append('<img src="/edu/apply/photo/' + data.user_id + '_10006/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									default :
										sb.Append('<img src="/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName + '" width="50px" height="70px">');
										//sb.Append('<img src="/kim/stu/apply/photo/' + data.user_id + '_' + data.gisu_id + '/' + photoFile.fileName + '" width="50px" height="70px">');
										break;
									}
								}
							}
						}
						
						var phone = data.stu_phone;
						if(phone.trim().length == 11){
							phone = phone.substr(0,3) + '-' + phone.substr(3,4) + '-' + phone.substr(7,4);
						}
						sb.Append('</td>');
						sb.Append('<td><a href="javascript:void(0);" onclick="showDetail(\''+data.stu_seq+'\');">' + data.stu_user_nm + '</a></td>');
						sb.Append("<td>");
						sb.Append('<button class="btn-primary" type="button" onclick="showCounsel(this);">상담</button>');
						sb.Append('<form method="post">');
						sb.Append('<input type="hidden" name="crc_id" value="' + data.crc_id + '" />');
						sb.Append('<input type="hidden" name="gisu_id" value="' + data.gisu_id +'" />');
						sb.Append('<input type="hidden" name="searchCondition" value="name" />');
						sb.Append('<input type="hidden" name="searchKeyword" value="' + data.stu_user_nm +'" />');
						sb.Append("</form>");
						sb.Append("</td>");
						sb.Append("<td>" + data.stu_user_nm_en + "</td>");
						sb.Append("<td>" + data.stu_user_birth + "</td>");
						sb.Append("<td>" + data.stu_user_age + "</td>");
						sb.Append("<td>" + class_nm + "</td>");
						sb.Append("<td>" + data.stu_addr + "</td>");
						sb.Append("<td>" + phone + "</td>");
						sb.Append("<td>" + data.stu_email + "</td>");
						sb.Append("<td>" + stu_gender + "</td>");
						sb.Append("<td>" + data.stu_edu_sc_nm + "</td>");
						sb.Append("<td>" + data.stu_edu_major + "</td>");
						sb.Append("<td>" + data.stu_edu_sc_lo + "</td>");
						sb.Append("<td>" + stu_gd_ck + "</td>");
						sb.Append("<td>" + license + "</td>");
						sb.Append("<td>" + language + "</td>");
						sb.Append("<td>" + overseas + "</td>");
						sb.Append("<td>" + stu_benefit + "</td>");
						sb.Append("<td>" + stu_mou + "</td>");
						sb.Append("<td>" + stu_state + "</td>");
						sb.Append("<td>" + data.stu_memo + "</td>");
						sb.Append("</tr>");
						
						/* sbModal.Append('<div class="modal fade bs-example-modal-lg" id="myModal'+name+'" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">');
						sbModal.Append('<div class="modal-dialog modal-lg">');
						sbModal.Append('<div class="modal-content"><div style="margin:1%;margin-bottom:10%;">');
						sbModal.Append('<h1 style="margin-bottom:5%;margin-top:5%;">'+dataInfo.user_nm+' - '+dataInfo.counsel_title+" [" +regDate.substring(0,10) +']</h1>');
						sbModal.Append(dataInfo.counsel_content);
						sbModal.Append('</div></div></div></div>');
						sb.Append("	<td>"+(dataInfo.counsel_teacher_name ? dataInfo.counsel_teacher_name : "")+"</td>");
						sb.Append(" <td>"+regDate.substring(0,19)+"</td>")
						sb.Append("</tr>");
						$("#modalsContentss").append(sbModal.ToString()); */
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				setPrint();
				// 페이징 처리
				pagingNavigation.setData(result);				// 데이터 전달
				// 페이징(콜백함수 숫자 클릭 시)
				pagingNavigation.setNavigation(setContentList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
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
				for (var i = 0; i < result.length; i++) {
					var map = result[i];
					sb.Append('<option value="'+map.gisu_seq+ '">'+map.gisu_crc_nm+'</option>');
		 		}
				$('#gisuSelector').append('<option value="">과정 선택</option>');
		 		$('#gisuSelector').append(sb.ToString());
		 	}
		});
	}

	function searchList(){
		var firstGisu = 0;
		var Url	= "<c:url value='/student/TestManagement/searchCirriculumList' />";
		$.ajax({
			type	: "post",
			url		: Url,
			async	: false,
			success : function(result){
				cirriculumList = result;
			}
		});
	}
	function setPrint() {
		
		//학적부 전체인쇄
		$('#printAll_schoolRegister').on('click', function() {
			var sb = new StringBuilder();
			var list;
			
			$.ajax({
				type: "post",
				url: "<c:url value='/admin/studentManagement/studentTableList' />",
				data: $("form[name='searchForm']").serialize(),
				async: false,
				success: function(result){
					list = result;
				}
			})
			
			if(list.length == 0) {
				alert('검색 조건에 해당하는 데이터가 없습니다.');
				$('#currentInfoDiv').attr('hidden');
				return false;
			}
			
			if($('#gwajeongSelector option:checked').val() != '' && $('#gwajeongSelector option:checked').val() != null) {
				$('#currentInfoDiv').removeAttr('hidden');
				$('#courseName').html($('#gwajeongSelector option:checked').text());
				$('#cardinalName').html($('#gisuSelector option:checked').text());
			}
			$.each(list, function(index, item) {
				var stu_seq = item.stu_seq;
				sb.Append('<input type="hidden" name="stu_seq" value="'+ stu_seq +'">');
			})
			$('#schoolRegister').html(sb.ToString());
			var popupX = (window.screen.width / 2) - ( 1200 / 2 );
			var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
			
			var schoolRegisterForm = document.schoolRegister;
			
			window.open('','학적부 전체인쇄',"width=1100,height=700,left='"+popupX+"',top='"+popupY+"',screenX='"+popupX+"',screenY='"+popupY+"',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,copyhistory=no,scrollbars=yes");
			schoolRegisterForm.target = '학적부 전체인쇄';
			schoolRegisterForm.submit();
		})
		
		//연수확인증 전체인쇄
		$('#printAll_trainingCertificate').on('click', function() {
			var sb = new StringBuilder();
			var list;
			
			$.ajax({
				type: "post",
				url: "<c:url value='/admin/studentManagement/studentTableList' />",
				data: $("form[name='searchForm']").serialize(),
				async: false,
				success: function(result){
					list = result;
				}
			})
			if(list.length == 0) {
				alert('검색 조건에 해당하는 데이터가 없습니다.');
				$('#currentInfoDiv').attr('hidden');
				return false;
			}
			if($('#gwajeongSelector option:checked').val() != '' && $('#gwajeongSelector option:checked').val() != null) {
				$('#currentInfoDiv').removeAttr('hidden');
				$('#courseName').html($('#gwajeongSelector option:checked').text());
				$('#cardinalName').html($('#gisuSelector option:checked').text());
			}
			$.each(list, function(index, item) {
				var cardinal_id = item.gisu_id;
				var user_id = item.user_id;
				sb.Append('<input type="hidden" name="cardinal_id" value="'+ cardinal_id +'"/>');
				sb.Append('<input type="hidden" name="user_id" value="'+ user_id +'"/>');
			})
			$('#trainingCertificate').html(sb.ToString());
			
			var trainingCertificateForm = document.trainingCertificate;
			window.open('','연수확인증 전체인쇄',"width=800px, height=900px,scrollbars=yes");
			trainingCertificateForm.target = '연수확인증 전체인쇄';
			trainingCertificateForm.submit();
		})
		
		//학적부 선택인쇄
		$('#print_schoolRegister').on('click', function() {
			if ($("input:checkbox[name=checkbox]:checked").length == 0) {
	        	alert("선택된 데이터가 없습니다.\n데이터를 선택해주세요.");
	        	return false;
	    	}
			var sb = new StringBuilder();
			$("input:checkbox[name='checkbox']:checked").each(function(index,item){
				var stu_seq = $(this).closest('tr').find('td:eq(1)').children('input.stu_seq').val();
				sb.Append('<input type="hidden" name="stu_seq" value="'+ stu_seq+'"/>')
			})
			$('#schoolRegister').html(sb.ToString());
			var popupX = (window.screen.width / 2) - ( 1200 / 2 );
			var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
			
			var schoolRegisterForm = document.schoolRegister;
			window.open('','학적부 선택인쇄',"width=1100,height=700,left='"+popupX+"',top='"+popupY+"',screenX='"+popupX+"',screenY='"+popupY+"',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,copyhistory=no,scrollbars=yes");
			schoolRegisterForm.target = '학적부 선택인쇄';
			schoolRegisterForm.submit();
		})
		
		//연수확인증 선택인쇄
		$('#print_trainingCertificate').on('click', function() {
			if ($("input:checkbox[name=checkbox]:checked").length == 0) {
	        	alert("선택된 데이터가 없습니다.\n데이터를 선택해주세요.");
	        	return false;
	    	}
			var sb = new StringBuilder();
			$("input:checkbox[name='checkbox']:checked").each(function(index,item){
				var cardinal_id = $(this).closest('tr').find('td:eq(1)').children('input.cardinal_id').val();
				var user_id = $(this).closest('tr').find('td:eq(1)').children('input.user_id ').val();
				sb.Append('<input type="hidden" name="cardinal_id" value="'+ cardinal_id +'"/>');
				sb.Append('<input type="hidden" name="user_id" value="'+ user_id +'"/>');
			})
			$('#trainingCertificate').html(sb.ToString());
			
			var trainingCertificateForm = document.trainingCertificate;
			window.open('','연수확인증 선택인쇄',"width=800px, height=900px,scrollbars=yes");
			trainingCertificateForm.target = '연수확인증 선택인쇄';
			trainingCertificateForm.submit();
		})
	}
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		$('#currentInfoDiv').removeAttr('hidden');
		$('#courseName').html($('#gwajeongSelector option:checked').text());
		$('#cardinalName').html($('#gisuSelector option:checked').text());
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	$('#checkAll').on('click', function() {
		if($('#checkAll').prop('checked')){
			$('input[name="checkbox"]').each(function(){
				$(this).prop('checked', true);
			});
		} else {
			$('input[name="checkbox"]').each(function(){
				$(this).prop('checked', false);
			});
		}
	})
	
	/** 페이지 시작 **/
	// 최초 리스트 페이지 호출 한다.
	//분류목록 세팅
	searchList();
	//분류 검색 정보 확인
	setSearchCode();
	//컨텐츠 로드
	setContentList();
	
	//엑셀 다운로드용 테이블
	$('#stuInfo_excel').css("display", "none");
});// <-----ready function 끝

//엑셀 다운로드
function fnExcelReport(){
	var sbExcel = new StringBuilder();
	var sb = new StringBuilder();
	
	$.ajax({
		type: "post",
		url: "<c:url value='/admin/studentManagement/studentTableList' />",
		data: $("form[name='searchForm']").serialize(),
		async: false,
		success: function(result){
			var list = result;
			
			for(var i=0; i<list.length; ++i) {
				var data = list[i];
				
				var license = data.stu_license.substring(1).replace(",", "<br>");
				var language = data.stu_language.substring(1).replace(",", "<br>");
				var overseas = data.stu_overseas.substring(1).replace(",", "<br>");
				var class_nm = data.stu_class.substring(1).replace(",", "<br>");
				var stu_gender;
				var stu_gd_ck;
				var stu_infoProcessing;
				var stu_benefit;
				var stu_mou;
				var stu_state;
				
				switch(data.stu_user_gender){
				case "A0000":
					stu_gender = "남성";
					break;
				case "A0001":
					stu_gender = "여성";
					break;
				}
				
				switch(data.stu_edu_gd_ck){
				case "B1000":
					stu_gd_ck = "졸업";
					break;
				case "B1001":
					stu_gd_ck = "예정";
					break;
				case "B1002":
					stu_gd_ck = "유예";
					break;
				default:
					stu_gd_ck = ""; //학력사항 기재 안한 경우
				}
				
				var stu_benefit = "";
				if(data.stu_benefit_ck.trim().length != 0){
					var benefit_arr = data.stu_benefit_ck.split(',');
					
					for(var j=0; j<benefit_arr.length; j++){
						
						switch(benefit_arr[j]){
						case "B4400":
							stu_benefit += "산인공<br>";
							break;
						case "B4401":
							stu_benefit += "강남구<br>";
							break;
						case "B4402":
							stu_benefit += "광주시<br>";
							break;
						case "B4403":
							stu_benefit += "지자체<br>";
							break;
						}
					}
				}
				
				switch(data.stu_mou_ck){
				case "B4500":
					stu_mou = "대상";
					break;
				case "B4501":
					stu_mou = "비대상";
					break;
				default:
					stu_mou = "";
				}
				
				switch(data.stu_state_ck){
				case "A1800":
					stu_state = "연수";
					break;
				case "A1801":
					stu_state = "퇴교";
					break;
				default:
					stu_state = "";
				}
				
				var phone = data.stu_phone;
				if(phone.trim().length == 11){
					phone = phone.substr(0,3) + '-' + phone.substr(3,4) + '-' + phone.substr(7,4);
				}
				sbExcel.Append('<tr>');
				sbExcel.Append('<td>' + data.stu_user_nm + '</td>');
				sbExcel.Append('<td>' + data.stu_user_nm_en + '</td>');
				sbExcel.Append('<td>' + data.stu_user_birth + '</td>');
				sbExcel.Append('<td>' + data.stu_user_age + '</td>');
				sbExcel.Append('<td>' + class_nm + '</td>');
				sbExcel.Append('<td>' + data.stu_addr + '</td>');
				sbExcel.Append('<td>' + phone + '</td>');
				sbExcel.Append('<td>' + data.stu_email + '</td>');
				sbExcel.Append("<td>" + stu_gender + "</td>");
				sbExcel.Append("<td>" + data.stu_edu_sc_nm + "</td>");
				sbExcel.Append("<td>" + data.stu_edu_major + "</td>");
				sbExcel.Append("<td>" + data.stu_edu_sc_lo + "</td>");
				sbExcel.Append("<td>" + stu_gd_ck + "</td>");
				sbExcel.Append("<td>" + license + "</td>");
				sbExcel.Append("<td>" + language + "</td>");
				sbExcel.Append("<td>" + overseas + "</td>");
				sbExcel.Append("<td>" + stu_benefit + "</td>");
				sbExcel.Append("<td>" + stu_mou + "</td>");
				sbExcel.Append("<td>" + stu_state + "</td>");
				sbExcel.Append("<td>" + data.stu_memo + "</td>");
				sbExcel.Append('</tr>');
			}
			$("#excelBody").html(sbExcel.ToString());
			
			var gisuName = $("#gisuSelector option:selected").text();
			if(gisuName == '기수 선택') gisuName = '전체';
			
			if($("#searchKeyword option:selected").text() == '검색어입력') gisuName += '_학적부';
			else
				gisuName += $("#searchKeyword option:selected").text()+'_학적부';
			
			sb.Append('<html xmlns:x="urn:schemas-microsoft-com:office:excel">');
			sb.Append('<head>');
			sb.Append('<meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">');
			sb.Append('<xml>');
			sb.Append('<x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>');
			sb.Append('<x:Name>Student_info</x:Name>');
			sb.Append('<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions>');
			sb.Append('</x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook>');
			sb.Append('</xml></head>');
			sb.Append('<body>');
			sb.Append('<table border="1px">');
			sb.Append($('#stuInfo_excel').clone().html());
			sb.Append('</table>');
			sb.Append('</body>');
			sb.Append('</html>');
			
			var data_type = 'data:application/vnd.ms-excel';
			var ua = window.navigator.userAgent;
			var msie = ua.indexOf("MSIE ");
			var fileName = gisuName + '.xls';
			
			//Explorer 환경에서 다운로드
			if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
				if (window.navigator.msSaveBlob) {
					var blob = new Blob([sb.ToString()], {type: "application/csv;charset=utf-8;"});
					navigator.msSaveBlob(blob, fileName);
				}
			} else {
				var blob2 = new Blob([sb.ToString()], {type: "application/csv;charset=utf-8;"});
			
				var filename = fileName;
				var elem = window.document.createElement('a');
				elem.href = window.URL.createObjectURL(blob2);
				elem.download = filename;
				document.body.appendChild(elem);
				elem.click();
				document.body.removeChild(elem);
			}
		}
	});
}

function showDetail(seq){
	$('#searchStu_seq').val(seq);
	contentLoad('학적부 상세', '/admin/studentManagement/studentTableDetail', $('form[name=searchForm]').serialize());
}

// 선택한 학생 상담페이지로 이동
function showCounsel(obj){
	var counselForm = $(obj).siblings('form');
	contentLoad('상담 내역', '/admin/studentManagement/studentCounselManagement', $(counselForm).serialize());
}

</script>

<div class="content_wraper" id="modalsContentss">
	<h3>학적부 관리</h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post" onsubmit="return false;">
        	<input type="hidden" name="id" value="" />
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	<input type="hidden" name="crc_id" value="${search.crc_id }" id="searchCrc_id"/>
        	<input type="hidden" name="gisu_id" value="${search.gisu_id }" id="searchGisu_id"/>
        	<input type="hidden" name="stu_state_ck" value="${search.stu_state_ck }" id="searchStu_state_ck"/>
        	<input type="hidden" name="stu_seq" value="${search.stu_seq }" id="searchStu_seq"/> <!-- 학생 상세화면으로 넘어갈 때 사용 -->
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
        	<div>
        		<table class="searchTable">
        		<tr>
        			<th>과정명</th>
        			<td>
						<select class="selector" id="gwajeongSelector"></select>
        			</td>
        		</tr>
        		<tr>
        			<th>기수명</th>
        			<td>
						<select class="selector" id="gisuSelector"></select>
        			</td>
        		</tr>
        		<tr>
        			<th>학적 상태</th>
        			<td>
						<select class="selector" id="stuStateSelector"></select>
        			</td>
        		</tr>
        		<tr>
        			<th>키워드검색</th>
        			<td>
        				<select name="searchCondition">
							<option value='all'>전체</option>
							<option value='name' <c:if test="${search.searchCondition eq 'name'}">selected</c:if>>성명</option>
							<option value='id' <c:if test="${search.searchCondition eq 'id'}">selected</c:if>>아이디</option>
						</select>
						<input type="text" placeholder="검색어입력" class="searchKeywordBox" id="searchKeyword" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
        			</td>
        		</tr>
        		<tr>
	        			<th>전체 인쇄</th>
	        			<td>
	        				<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id="printAll_schoolRegister">학적부 전체인쇄</a>
	        				<a class="btn btn-primary" type="button" style="vertical-align: bottom;" id="printAll_trainingCertificate">연수확인증 전체인쇄</a>
	        				<span>검색 조건에 해당하는 데이터를 모두 인쇄합니다.</span>
	        			</td>
	        		</tr>
	        		<tr>
	        			<th>선택 인쇄</th>
	        			<td>
	        				<a class="btn" type="button" style="vertical-align: bottom;" id="print_schoolRegister">학적부 선택인쇄</a>
	        				<a class="btn" type="button" style="vertical-align: bottom;" id="print_trainingCertificate">연수확인증 선택인쇄</a>
	        				<span>선택한 데이터만 인쇄합니다.</span>
	        			</td>
	        		</tr>
        		<tr>
        			<td class="buttonTd" colspan="2">
						<a id='searchBtn' class="btn btn-primary" type="button">검색</a>
						<a class="btn btn-danger"href="javascript:contentLoad('학적부 관리','/admin/studentManagement/studentTableManagement');">전체초기화</a>
						<a class="btn btn-primary" type="button" href="javascript:void(0);" onclick="fnExcelReport()">엑셀 다운로드</a>
        			</td>
        		</tr>
        		</table>
			</div>
		</form>
		<!-- //searchForm end -->
		<div id="currentInfoDiv" hidden="hidden">과정명 : <span id="courseName"></span> / 기수명 : <span id="cardinalName"></span></div>
		<br>
		
		<div class="tableWrapperScr">
			<table id="stuInfo_table" style="border-collapse: collapse;">
				<thead>
				<tr>
					<th><input type="checkbox" id="checkAll"></th>
					<th>사진</th>
					<th>이름</th>
					<th>상담</th>
					<th>영문명</th>
					<th>생년월일</th>
					<th>나이(만)</th>	
					<th>분반</th>
					<th>주소</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>성별</th>
					<th>대학교</th>
					<th>전공</th>
					<th>학교소재</th>
					<th>졸업여부</th>
					<th>자격사항</th>
					<th>공인어학성적</th>
					<!-- <th>정보처리</th> -->
					<th>해외연수경험</th>
					<th>혜택사항</th>
					<th>MOU</th>
					<th>재적상태</th>
					<th>기타</th>
				</tr>
				</thead>
				<tbody id="dataListBody"></tbody>
			</table>
		</div>
		<div class="pagination"></div>
		<div class="paging"></div>
		
		<form action="/admin/studentManagement/print_stuInfo" method="post" name="schoolRegister" id="schoolRegister"></form>
		<form action="/admin/studentManagement/print_trainingCertificate" method="post" name="trainingCertificate" id="trainingCertificate"></form>
		
		<table id="stuInfo_excel">
			<thead>
				<tr>
					<th>이름</th>
					<th>영문명</th>
					<th>생년월일</th>
					<th>나이(만)</th>	
					<th>분반</th>
					<th>주소</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>성별</th>
					<th>대학교</th>
					<th>전공</th>
					<th>학교소재</th>
					<th>졸업여부</th>
					<th>자격사항</th>
					<th>공인어학성적</th>
					<th>해외연수경험</th>
					<th>혜택사항</th>
					<th>MOU</th>
					<th>재적상태</th>
					<th>기타</th>
				</tr>
			</thead>
			<tbody id="excelBody"></tbody>
		</table>
	</div>
</div>

