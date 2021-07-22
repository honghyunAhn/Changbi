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
		}else{
			bannerUpdate(bannername);
			buttonAction();
		}
	});
	
	function bannerMake(data){
		var content = '';
		content += '<form>'
		content += '<h4><input type="text" placeholder="배너의 이름을 입력하세요." style="border: none; width: 100%; height= 100%; text-align: center;"></h4>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';
		content += '<div>';
		content += '<h5 style="float: left;">&nbsp;&nbsp;사용중 배너</h5>';
		content += '<div class="BannerUpdate">';
		content += '<table>';
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
		content += '<td class="tdBorder" class="filename" id="pcfilename"></td>';
		content += '<td class="filename" id="mobilefilename"></td>';
		content += '</tr>';
		content += '<tr>';
		content += '<td class="tdBorder" style="height: 100px;"></td>';
		content += '<td></td>';
		content += '</tr>';
		content += '</table>';
		content += '<br>';	
		content += '<button style="background-color: #90caf9; margin-left: 0;">만들기</button>';	
		content += '<br>';
		content += '<hr style="border-top: solid 1px #cfd8dc;">';	
		content += '</div>';
		content += '</div>';
		content += '</form>'
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
		content += '<div>';
		content += '<button class="addButton" style="font-size: 35px; margin-left: 0">+</button>';
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
	
	function buttonAction(){
		$('.banner').show();

		//배너 닫기
		$("#closeBanner").on('click', function(){
			$(".banner").html("");
			$(".banner").hide();
			$("#bannerSelect").val("0");
			$("#bannerSelect > option[@value=0]").attr("selected", "true");
		});
		
		//pc이미지 url 표시
		$("#pcfile").on('change',function(){
			  var fileName = $("#pcfile").val();
			  $("#pcfilename").html(fileName);
		});
		
		//모바일이미지 url 표시
		$("#mobilefile").on('change',function(){
			  var fileName = $("#mobilefile").val();
			  $("#mobilefilename").html(fileName);
		});
	}
</script>
<div class="contentBox">
	<h3></h3>
	
	<section>
		<select id="bannerSelect">
			<option value="0" disabled selected hidden>작업할 배너를 선택하세요.</option>
			<optgroup label="배너">
				<c:forEach var="bannerName" items="${bannerNames}">
				<option value="${bannerName}">${bannerName}</option>
				</c:forEach>
			</optgroup>
			<optgroup label="배너 새로 만들기">
				<option value="만들기">만들기</option>
			</optgroup>
		</select>
	</section>
	<br>
	<section class="banner">
	</section>
</div>
