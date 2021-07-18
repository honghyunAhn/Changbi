<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function(){
		//컨텐츠 타이틀
		$('.content_wraper').children('h3').eq(0).html($('title').text());
		
	});
	$('#bannerSelect').on('change',function(){
		var bannername = $(this).val();
		if(bannername == "만들기"){
			alert("만들기");
		} else{
			alert(bannername);
		}
	});
</script>
<div class="content_wraper">
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
	
	<section class="banner use" style="background-color: #eceff1; width: 100%; text-align: center;">
		<h4>이름</h4>
		<br>
		<div>
			<h5>&nbsp;사용중</h5>
			<div class="BannerUpdate" style="align-items: center;">
				<table class="content" style="background-color:white; width: 97%; margin: auto;">
					<tr>
						<th>순서</th>
						<td><select></select></td>
					</tr>
					<tr>
						<th>url</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>alt</th>
						<td><input type="text"></td>
					</tr>
				</table>
				<table class="img">
					<tr>
						<th>이미지 - PC</th>
						<th>이미지 - 모바일</th>
					</tr>
					<tr>
						<td><input type="file" accept=".bmp, .gif, .jpg, .png" value="등록"></td>
						<td><input type="file" accept=".bmp, .gif, .jpg, .png" value="등록"></td>
					</tr>
					<tr>
						<td>이미지 이름</td>
						<td>이미지 이름</td>
					</tr>
					<tr>
						<td>이미지 미리보기</td>
						<td>이미지 미리보기</td>
					</tr>
				</table>
				<br>
				<button>수정</button>
				<button>삭제</button>
				<button>미사용</button>
			</div>
			<br>
			<button>배너 추가</button>
		</div>
	</section>
	
	<section class="banner useNot">
	</section>
</div>
