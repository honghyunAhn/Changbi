<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="<c:url value="/resources/css/project/admin/bannerManagement.css"/>"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	$(document).ready(function(){
		//컨텐츠 타이틀
		$('.contentBox').children('h3').eq(0).html($('title').text());
		
	});
	$('#bannerSelect').on('change',function(){
		var bannername = $(this).val();
		if(bannername == "만들기"){
			alert("만들기");
		} else{
			alert(bannername);
		}
	});
	
	$("#pcfile").on('change',function(){
		  var fileName = $("#pcfile").val();
		  $("#pcfilename").html(fileName);
	});
	
	$("#mobilefile").on('change',function(){
		  var fileName = $("#mobilefile").val();
		  $("#mobilefilename").html(fileName);
	});
</script>
<div class="contentBox">
	<h3></h3>
	
	<section>
		<select id="bannerSelect">
			<option disabled selected hidden>작업할 배너를 선택하세요.</option>
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
	
	<section class="banner use">
		<h4>이름</h4>
		<hr style="border-top: solid 1px #cfd8dc;">
		<div>
			<h5 style="float: left;">&nbsp;&nbsp;사용중 배너</h5>
			<div class="BannerUpdate">
				<table>
					<tr>
						<th>순서</th>
						<td style="margin-left: 1000px"><select></select></td>
					</tr>
					<tr>
						<th>url</th>
						<td><input type="text"></td>
					</tr>
					<tr class="trBorder">
						<th>alt</th>
						<td><input type="text"></td>
					</tr>
				</table>
				<table>
					<tr>
						<th class="tdBorder">이미지 - PC</th>
						<th>이미지 - 모바일</th>
					</tr>
					<tr>
						<td class="tdBorder" style="width: 50%;">
							<label class="file" for="pcfile">업로드</label> 
 							<input type="file" id="pcfile" style="display: none;" accept=".bmp, .gif, .jpg, .png"> 
						</td>
						<td>
							<label class="file" for="mobilefile">업로드</label>
							<input type="file" id="mobilefile" style="display: none;" accept=".bmp, .gif, .jpg, .png">
						</td>
					</tr>
					<tr>
						<td class="tdBorder" class="filename" id="pcfilename"></td>
						<td class="filename" id="mobilefilename"></td>
					</tr>
					<tr>
						<td class="tdBorder" style="height: 100px;"></td>
						<td></td>
					</tr>
				</table>
				<br>
				<button style="background-color: #90caf9;">수   정</button>
				<button style="background-color: #ffab91;">삭   제</button>
				<button style="background-color: #a5d6a7;">미사용</button>
				<br>
				<hr style="border-top: solid 1px #cfd8dc;">
			</div>
		</div>
		<div>
			<button class="addButton" style="font-size: 35px; margin-left: 0">+</button>
			<hr style="border-top: solid 1px #cfd8dc;">
		</div>
		<div>
			<h5 style="float: left;">&nbsp;&nbsp;비 사용중 배너</h5>
			<table style="width: 97%;">
				<tr>
					<td style="width: 20%; height: 40px" class="tdBorder"></td>
					<td style="width: 60%;" class="tdBorder"></td>
					<td style="width: 10%;" class="tdBorder"><button style="margin-left: 0; background-color: #a5d6a7;">사용</button></td>
					<td style="width: 10%;"><button style="margin-left: 0; background-color: #ffab91;">삭제</button></td>
				</tr>
			</table>
			<hr style="border-top: solid 1px #cfd8dc;">
		</div>
		<div>
			<button class="addButton" style="font-size: 25px; background-color: #d1c4e9; margin-left: 0">배너 닫기</button>
			<br>
			<br>
		</div>
		
	</section>
	
	<!-- <section class="banner make">
	</section> -->
</div>
