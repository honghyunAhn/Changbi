<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="<c:url value="/resources/css/project/admin/bannerManagement.css"/>"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	$(document).ready(function(){
		//컨텐츠 타이틀
		$('.contentBox').children('h3').eq(0).html($('title').text());
		$('.banner').hide();
		
	});
	
	$('#bannerSelect').on('change',function(){
		var bannername = $(this).val();
		if(bannername == "만들기"){
			bannerMake();
			buttonAction();
			$("#bannerMake").on('click',makeFormCheck);
		}else{
			bannerUpdate(bannername);
			buttonAction();
			
			$("#bannerCreate").on('click',function(){
				var content = ''
				content += bannerCreateForm();
				$(".bannerCreate").html(content);
			});
		}
	});
	
	function bannerMake(data){
		var content = '';
		
		content += '<h4><input type="text" id="edu_ban_nm" placeholder="배너의 이름을 입력하세요." style="border: none; width: 100%; height= 100%; text-align: center;"></h4>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';
		content += '<div>';
		content += '<h5 style="float: left;">&nbsp;&nbsp;사용중 배너</h5>';
		content += '<div class="BannerUpdate">';
		content += bannerCreateForm();
		content += '</div>';
		content += '</div>';
		content += '<div>';
		content += '<button class="addButton" id="closeBanner" style="font-size: 25px; background-color: #d1c4e9; margin-left: 0">배너 닫기</button>';
		content += '<br>';
		content += '<br>';
		content += '</div>';
		$(".banner").html(content);
	}
	
	function bannerUpdate(data){
		var content = '';
		content += '<h4>'+data+'</h4>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';
		content += '<div>';
		content += '<h5 style="float: left;">&nbsp;&nbsp;사용중 배너</h5>';
		content += '<div class="BannerUpdate">';
		content += '<table>';
		content += '<tr>';
		content += '<th>순서</th>';
		content += '<td style="margin-left: 1000px"><select></select></td>';
		content += '</tr>';
		content += '<tr>';
		content += '<th>url</th>';
		content += '<td><input type="text"></td>';
		content += '</tr>';
		content += '<tr class="trBorder">';
		content += '<th>alt</th>';
		content += '<td><input type="text"></td>';
		content += '</tr>';
		content += '</table>';
		content += '<table>';
		content += '<tr>';
		content += '<th class="tdBorder">이미지 - PC</th>';
		content += '<th>이미지 - 모바일</th>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="tdBorder" style="width: 50%;">';
		content += '<label class="file" for="pcfile">업로드</label> ';
		content += '<input type="file" id="pcfile" style="display: none;" accept=".bmp, .gif, .jpg, .png"> ';
		content += '</td>';
		content += '<td>';
		content += '<label class="file" for="mobilefile">업로드</label>';
		content += '<input type="file" id="mobilefile" style="display: none;" accept=".bmp, .gif, .jpg, .png">';
		content += '</td>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="filename tdBorder" id="pcfilename"></td>';
		content += '<td class="filename" id="mobilefilename"></td>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="tdBorder" style="height: 100px;"></td>';
		content += '<td></td>';
		content += '</tr>';
		content += '</table>';
		content += '<br>';	
		content += '<button style="background-color: #90caf9;">수   정</button>';	
		content += '<button style="background-color: #ffab91;">삭   제</button>';
		content += '<button style="background-color: #a5d6a7;">미사용</button>';
		content += '<br>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';	
		content += '</div>';
		content += '</div>';
		content += '<div class="bannerCreate">';
		content += '<button class="addButton" id="bannerCreate" style="font-size: 35px; margin-left: 0">+</button>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';
		content += '</div>';
		content += '<div>';
		content += '<h5 style="float: left;">&nbsp;&nbsp;비 사용중 배너</h5>';		
		content += '<table style="width: 97%;">';
		content += '<tr>';
		content += '<td style="width: 20%; height: 40px" class="tdBorder"></td>';
		content += '<td style="width: 60%;" class="tdBorder"></td>';
		content += '<td style="width: 10%;" class="tdBorder"><button style="margin-left: 0; background-color: #a5d6a7;">사용</button></td>';
		content += '<td style="width: 10%;"><button style="margin-left: 0; background-color: #ffab91;">삭제</button></td>';
		content += '</tr>';
		content += '</table>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';
		content += '</div>';
		content += '<div>';
		content += '<button class="addButton" id="closeBanner"style="font-size: 25px; background-color: #d1c4e9; margin-left: 0">배너 닫기</button>';
		content += '<br>';
		content += '<br>';
		content += '</div>';
		$(".banner").html(content);
	}
	
	function bannerCreateForm(data){
		var content = '';
		content += '<form id="bannerCreateForm" enctype="multipart/form-data">'
		content += '<table>';
		content += '<tr>';
		content += '<th>url</th>';
		content += '<td><input name="edu_ban_link" type="text"></td>';
		content += '</tr>';
		content += '<tr class="trBorder">';
		content += '<th>alt</th>';
		content += '<td><input name="edu_ban_alt" type="text"></td>';
		content += '</tr>';
		content += '</table>';
		content += '<table>';
		content += '<tr>';
		content += '<th class="tdBorder">이미지 - PC</th>';
		content += '<th>이미지 - 모바일</th>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="tdBorder" style="width: 50%;">';
		content += '<label class="file" for="pcfile">업로드</label> ';
		content += '<input type="file" multiple="multiple" name="file" id="pcfile" style="display: none;" accept=".bmp, .gif, .jpg, .png" onchange="getThumbnailPrivew(this, '+"avatar_info_image1"+', '+"pcfilename"+')"> ';
		content += '</td>';
		content += '<td>';
		content += '<label class="file" for="mobilefile">업로드</label>';
		content += '<input type="file" multiple="multiple" name="file" id="mobilefile" style="display: none;" accept=".bmp, .gif, .jpg, .png" onchange="getThumbnailPrivew(this, '+"avatar_info_image2"+', '+"mobilefilename"+')">';
		content += '</td>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="filename tdBorder"><input type="text" id="pcfilename" readonly></input></td>';
		content += '<td class="filename"><input type="text" id="mobilefilename" readonly></input></td>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="tdBorder" style="height: 200px;"><img alt="배너 등록 이미지 미리보기" id="avatar_info_image1"/></td>';
		content += '<td style="height: 200px;"><img alt="배너 등록 이미지 미리보기" id="avatar_info_image2"/></td>';
		content += '</tr>';
		content += '</table>';
		content += '<br>';	
		content += '<input type="button" value="생성" id="bannerMake" style="background-color: #90caf9; margin-left: 0;">';	
		content += '<br>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';	
		content += '</form>'
		return content;
	}
	
	//배너 생성 폼
	function makeFormCheck(){
		var form = $("#bannerCreateForm")[0];
		var formData = new FormData(form);
		
		var edu_ban_nm = $("#edu_ban_nm").val();
		var edu_ban_link = formData.get("edu_ban_link");
		var edu_ban_orgin_pc = $("#pcfilename").val();
		var edu_ban_orgin_mo = $("#mobilefilename").val();
		formData.set("edu_ban_nm", edu_ban_nm);
		
	    if (edu_ban_nm.length == 0) {
			alert('이름 입력해 주시기 바랍니다.');
			selectAndFocus($("#edu_ban_nm"));
			return false;
		}
		if (edu_ban_link.length == 0) {
			alert('링크를 입력해 주시기 바랍니다.');
			selectAndFocus($("input[name='edu_ban_link']"));
			return false;
		}
		if (edu_ban_orgin_pc.length == 0) {
			alert("PC 이미지를 등록해 주세요.")
			return false;
		}
		if (edu_ban_orgin_mo.length == 0) {
			alert("모바일 이미지를 등록해 주세요.")
			return false;
		}
		
		$.ajax({
	        url : "/data/basic/bannerInsert",
	        processData: false,
	        contentType: false,
	        type : 'POST',
	        data : formData,
	        success : function(result){
	        	if(result > 0){
	        		console.log(edu_ban_nm);
	        		alert(edu_ban_nm);
	        		$('#bannerSelect').val(0);
	        		bannerUpdate(edu_ban_nm);
	        	}
	        },
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	//엘리먼트를 선택한다
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}
	
	//이미지 크기 확인, 이미지 미리보기, 이미지 이름 출력
	function getThumbnailPrivew(input, targetId, inputID) {
		targetId = targetId.id;
		if(targetId == "avatar_info_image1"){
			var width = "1920";
			var height = "600";
		}
		if(targetId == "avatar_info_image2"){
			var width = "760";
			var height = "300";
		}
		// 필드 채워지면
		if ($(input).val() != "") {
			// 확장자 체크
			var ext = $(input).val().split(".").pop().toLowerCase();
			if ($.inArray(ext, [ "bmp", "gif", "jpg", "jpeg", "png" ]) == -1) {
				alert("bmp, gif, jpg, jpeg, png 파일만 업로드 해주세요.");
				$(input).val("");
				return;
		}
			// 가로,세로 길이
			var file = input.files[0];
			var _URL = window.URL || window.webkitURL;
			var img = new Image();
			img.src = _URL.createObjectURL(file);
			img.onload = function() {
				if(img.width != width && img.height != height){
					alert("이미지 크기가 "+width+" X "+height+" 이어야 합니다.");
					return;
				}
				var fileName = $("#"+input.id).val();
				$("#"+inputID.id).val(fileName);
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						var element = window.document.getElementById(targetId);
						element.setAttribute("src", e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				}
			}
		}
	}
	
	function buttonAction(){
		$('.banner').show();

		//배너 닫기
		$("#closeBanner").on('click', function(){
			$(".banner").html("");
			$(".banner").hide();
			$("#bannerSelect").val("0");
		});
	}
</script>
<div class="contentBox">
	<h3>배너 관리</h3>
	
	<section>
		<select id="bannerSelect">
			<option value="0" disabled selected hidden>작업할 배너를 선택하세요.</option>
			<optgroup label="배너">
				<c:forEach var="bannerName" items="${bannerNames}">
				<option value="${bannerName}">${bannerName}</option>
				</c:forEach>
			</optgroup>
			<optgroup label="배너 새로 만들기">
				<option value="만들기">배너 생성</option>
			</optgroup>
		</select>
	</section>
	<br>
	<section class="banner">
	</section>
</div>
