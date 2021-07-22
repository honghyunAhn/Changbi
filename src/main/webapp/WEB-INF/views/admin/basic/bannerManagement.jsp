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
		<div st>
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
				<button>수정</button>
				<button>삭제</button>
				<button>미사용</button>
			</div>
			<br>
			<br>
			<button style="width: 97%; height: 50px">배너 추가</button>
		</div>
	</section>
	
	<section class="banner useNot">
	</section>
</div>
