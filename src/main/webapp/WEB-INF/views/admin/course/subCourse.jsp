<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/subCourse.css" />">

<script type="text/javascript">
$(document).ready(function() {
	// url을 여기서 변경
	var listUrl = "<c:url value='/forFaith/base/cateCodeList' />";
	var regUrl = "<c:url value='/forFaith/base/codeReg' />";	 
	var updYnUrl =  "<c:url value='/forFaith/base/codeYnUpt' />";
	var delUrl =  "<c:url value='/data/course/subCourseDelete' />";
	var data;
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		$("#bigSelect").html("");
		$("#middleSelect").html("");
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				if(result && result.length > 0) {
					data=result;
					$("#big").val(result[0].name);
					$("#bigSelect").html("");
					$("#middleSelect").html("");
					
					for(var i=0;i<result.length;i++){
						
						$("#bigSelect").append('<option value="'+result[i].code+'">'+result[i].name+'</option>');
						
						var grandFlag=true;
						
						if(result[i].childCodeList.length>0){
						for(var j=0;j<result[i].childCodeList.length;j++){

							if(i==0){
								$("#middleSelect").append('<option value="'+result[i].childCodeList[j].code+'">'+result[i].childCodeList[j].name+'</option>');
								$("#bigAlert").html("<font color='red'>기존값참조</font>");
								$("#middleAlert").html("<font color='red'>기존값참조</font>");
								$("#bigCode").val(data[0].code);
								$("#middleCode").val(data[i].childCodeList[0].code);
							}
							
							$("#middle").val(result[0].childCodeList[0].name);
							var flag=true;
							
							if(result[i].childCodeList[j].childCodeList.length>0){
							for(var k=0;k<result[i].childCodeList[j].childCodeList.length;k++){
								var useYn="";
								sb.Append("<tr>");
								if(grandFlag){
									if(result[i].useYn=='Y'){
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].code+'" data-yn="y" checked>';
									}else{
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].code+'"   data-yn="n">';
									}
									sb.Append("	<td class='order_num top'>"+result[i].name+"</td>");
									sb.Append("	<td class='top'><button type='button' class='del_btn' data-code='"+result[i].code+"'>삭제</button>"+useYn+"</td>");
								}else{
									sb.Append("	<td class='order_num'></td><td></td>");
								}
								grandFlag=false;
								
								if(flag){
									if(result[i].childCodeList[j].useYn=='Y'){
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].childCodeList[j].code+'"  data-yn="y" checked>';
									}else{
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].childCodeList[j].code+'"   data-yn="n">';
									}
									
									if(j==0){
										sb.Append("	<td class='code top'>"+result[i].childCodeList[j].name+"</td>");
										sb.Append("	<td class='top'><button type='button' class='del_btn' data-code='"+result[i].childCodeList[j].code+"'>삭제</button>"+useYn+"</td>");
									}else{
										sb.Append("	<td class='code'>"+result[i].childCodeList[j].name+"</td>");
										sb.Append("	<td><button type='button' class='del_btn' data-code='"+result[i].childCodeList[j].code+"'>삭제</button>"+useYn+"</td>");
									}
									
								}else{
									sb.Append("	<td class='code'></td>");
								}
								if(result[i].childCodeList[j].childCodeList[k].useYn=='Y'){
									//useYn='분류사용여부:<input type="checkbox" class="useYnCheck"  data-code="'+result[i].childCodeList[j].childCodeList[k].code+'"  data-yn="y" checked>';
								}else{
									//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].childCodeList[j].childCodeList[k].code+'"   data-yn="n">';
								}
								
									if(j==0){
										sb.Append("	<td class='content_edit top'>"+result[i].childCodeList[j].childCodeList[k].name+"</td>");
										sb.Append("	<td class='top'><button type='button' class='del_btn' data-code='"+result[i].childCodeList[j].childCodeList[k].code+"'>삭제</button>"+useYn+"</td>");
									}else{
										sb.Append("	<td class='content_edit'>"+result[i].childCodeList[j].childCodeList[k].name+"</td>");
										sb.Append("	<td><button type='button' class='del_btn' data-code='"+result[i].childCodeList[j].childCodeList[k].code+"'>삭제</button>"+useYn+"</td>");
									}
								sb.Append("</tr>");
								
								flag=false;
							}
							}else{
								sb.Append("<tr>");
								if(grandFlag){
									if(result[i].useYn=='Y'){
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck"  data-code="'+result[i].code+'"  data-yn="y" checked>';
									}else{
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck"  data-code="'+result[i].code+'"   data-yn="n">';
									}
									sb.Append("	<td class='order_num top'>"+result[i].name+"</td>");
									sb.Appedn("	<td class='top'><button type='button' class='del_btn' data-code='"+result[i].code+"'>삭제</button>"+useYn+"</td>");
								}else{
									sb.Append("	<td class='order_num'></td><td></td>");
								}
								grandFlag=false;
								
								if(flag){
									if(result[i].childCodeList[j].useYn=='Y'){
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck" data-code="'+result[i].childCodeList[j].code+'"  data-yn="y" checked>';
									}else{
										//useYn='분류사용여부:<input type="checkbox" class="useYnCheck"  data-code="'+result[i].childCodeList[j].code+'"  data-yn="n">';
									}
									sb.Append("	<td class='code'>"+result[i].childCodeList[j].name+"</td>");
									sb.Append("	<td><button type='button' class='del_btn' data-code='"+result[i].childCodeList[j].code+"'>삭제</button>"+useYn+"</td>");
								}else{
									sb.Append("	<td class='code'></td><td></td>");
								}
							
								sb.Append("	<td class='content_edit'></td><td></td>");
								sb.Append("</tr>");
								
								flag=false;
							}
						}
						}else{
							sb.Append("	<td class='order_num top'>"+result[i].name+"</td>");
							sb.Append("	<td class='top'><button type='button' class='del_btn' data-code='"+result[i].code+"'>삭제</button>"+useYn+"</td>");
							sb.Append("	<td class='code'></td><td></td>");
							sb.Append("	<td class='content_edit'></td><td></td>");
							sb.Append("</tr>");
						}
					}
				}else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='5'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString()); 
				
				
				$(".useYnCheck").each(function(){
					$(this).click(function(){
						
						
						var code=$(this).attr("data-code");
						var yn=$(this).attr("data-yn");
						
						if(yn=='y'){
							if(confirm("현재분류를 '미사용'으로 바꾸시겠습니까?\n(사용자메뉴에서 안보이게 됩니다.)")){
								updateYn(code,yn);
							}
						}else{
							if(confirm("현재분류를 '사용'으로 바꾸시겠습니까?\n(사용자메뉴에서 보이게 됩니다.)")){
								updateYn(code,yn);
							}
						}
						
						
					});
					

				});
				
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	
	
	/*
	** 페이지 별로 이벤트 등록 구간
	*/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	//검색어 치고 엔터 눌렀을 때
	$("#searchKeyword").unbind("keyup").bind("keyup", function(event) {
		if(event.keyCode === 13) {
			$("#searchBtn").trigger("click");
		}
	});
	// 클릭 시 분류 세팅
	$("#dataListBody").on("click", ".content_edit", function() {
		var idx = $(".content_edit").index($(this));
		
		// 선택 된 ID 의 orderNum 세팅
		$(":text[name='orderNum']").val($(".order_num").eq(idx).text());
		// 선택 된 ID 를 hidden id 값으로 세팅
		$(":text[name='code']").val($(".code").eq(idx).text());		 
		 
		// 선택 된 분류 명 세팅
		$(":text[name='name']").val($(this).text());		
	});
	
	$("#bigSelect").change(function(){
		$("#middleSelect").html("");
		for(var i=0;i<data.length;i++){
			if(data[i].code==$("#bigSelect option:selected").val()){
				if(data[i].childCodeList.length>0){
				for(var j=0;j<data[i].childCodeList.length;j++){

					$("#middleSelect").append('<option value="'+data[i].childCodeList[j].code+'">'+data[i].childCodeList[j].name+'</option>');
					$("#big").val($("#bigSelect option:selected").html());
					$("#middle").val(data[i].childCodeList[0].name);
					
					$("#bigAlert").html("<font color='red'>기존값참조</font>");
					$("#middleAlert").html("<font color='red'>기존값참조</font>");
					
					$("#bigCode").val($("#bigSelect option:selected").val());
					$("#middleCode").val(data[i].childCodeList[0].code);
				}
				}else{
					$("#big").val($("#bigSelect option:selected").html());
					$("#bigCode").val($("#bigSelect option:selected").val());
					$("#middleCode").val("");
					$("#middleAlert").html("<font color='black'>신규값생성</font>");
					$("#middleSelect").html("");
				}
			}
		}
	});
	
	$("#middleSelect").change(function(){
		for(var i=0;i<data.length;i++){
			
			for(var j=0;j<data[i].childCodeList.length;j++){
				
				if(data[i].childCodeList[j].code==$("#middleSelect option:selected").val()){
					$("#middle").val($("#middleSelect option:selected").html());
					$("#middleCode").val($("#middleSelect option:selected").val());
				} 
			}
			
		}
	});
	
	$("#middleSelect").change(function(){
		for(var i=0;i<data.length;i++){
			
			for(var j=0;j<data[i].childCodeList.length;j++){
				
				if(data[i].childCodeList[j].code==$("#middleSelect option:selected").val()){
					$("#middle").val($("#middleSelect option:selected").html());
					$("#middleCode").val($("#middleSelect option:selected").val());
				} 
			}
			
		}
	});
	
	function updateYn(code,yn){
		$.ajax({
			type	: "post",
			url		: updYnUrl,
			data 	: {code:code,yn:yn},
			success	: function(result) {
				
				if(yn=='y'){
					setContentList();
					alert("현재분류:미사용으로 등록되었습니다.");
				}else{
					setContentList();
					alert("현재분류:사용으로 등록되었습니다.");
				}
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		}); 
	}

	$("#big").on("keyup",function(){
		$("#bigAlert").html("<font color='black'>신규값생성</font>");
		$("#middleAlert").html("<font color='black'>신규값생성</font>");
		$("#middleCode").val("");
		$("#bigCode").val("");
	});
	$("#middle").on("keyup",function(){
		$("#middleAlert").html("<font color='black'>신규값생성</font>");
		$("#middleCode").val("");
	});
	$("#small").on("keyup",function(){
	});
	
	
	// 삭제 기능
	$("#dataListBody").on("click", ".del_btn", function() {
		if(confirm("대분류를 삭제하면 대분류에 속하는 학습영역도 모두 삭제됩니다. \n정말 삭제하시겠습니까?")) {
			var idx		= $(".del_btn").index($(this));
			var _target	= $(this);
			
			var data	= {code : _target.attr("data-code")};
			 $.ajax({
				type	: "post",
				url		: delUrl,
				data 	: data,
				success	: function(result) {
					if(result > 0) {
						alert("삭제되었습니다.");
						setContentList();
					} else {
						alert("삭제실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			}); 
		}
	});
	
	// 페이지 이벤트 등록(등록 버튼 클릭 시)
	$("#regBtn").unbind("click").bind("click", function() {
		
		if(!$(":text[name='big']").val()){
			alert("대분류를 입력하세요.")
			$(":text[name='big']").focus();
		}else if($(":text[name='middle']").val()&&!$(":text[name='big']").val()){
			alert("대분류 입력 후 중분류를 입력하세요.")
			$(":text[name='big']").focus();
		}else if($(":text[name='small']").val()&&(!$(":text[name='middle']").val()||!$(":text[name='big']").val())){
			alert("소분류는 대분류와 중분류 입력 후 입력하세요.")
			$(":text[name='big']").focus();
		}else if($("#bigCode").val()!=''&&$("#middleCode").val()!=''&&!$(":text[name='small']").val()){
			alert("대분류와 중분류 참조만하고 저장하실수 없습니다.")
		}else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result) {
						alert("저장되었습니다.");
						
						setContentList();
					} else {
						alert("저장실패했습니다.");
					}
					setContentList();
					$("#small").val("");
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			}); 
		}
		
		
		
		/* if(!$(":text[name='orderNum']").val()) {
			alert("순서를 입력하세요.")
			$(":text[name='orderNum']").focus();
		} else if(!$(":text[name='code']").val()) {
			alert("분류코드를 입력하세요.")
			$(":text[name='code']").focus();
		} else if(!$(":text[name='name']").val()) {
			alert("분류명을 입력하세요.")
			$(":text[name='name']").focus();
		} else if(confirm("저장하시겠습니까?")) {
			$.ajax({
				type	: "post",
				url		: regUrl,
				data 	: $("form[name='actionForm']").serialize(),
				success	: function(result) {
					if(result.code) {
						alert("저장되었습니다.");
						
						setContentList();
					} else {
						alert("저장실패했습니다.");
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		} */
	});
	
	// 처음 리스트 생성
	setContentList();
	
	// 컨텐츠 타이틀
	$('.content_wraper').children('h3').eq(0).html($('title').text());
});
 
</script>
 
<div class="content_wraper">
	<h3><c:out value="${codeGroup.name}" default="" /></h3>
	<div class="tab_body">
		<!-- actionForm start -->
       	<form name="actionForm" method="post">
		<input type="hidden" name="codeGroup.id" value="<c:out value="${codeGroup.id}" default="${codeGroup.id}" />" />
		<input type="hidden" name="parentCode.code" value="" /> 
		<input type="hidden" name="depth" value="1" />
	   
	   	<input type="hidden" name="bigCode" id="bigCode" value="">
	   	<input type="hidden" name="middleCode" id="middleCode" value="">
	   	<input type="hidden" name="smallCode" id="smallCode" value="">
	   
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th colspan="2">대분류</th>
				<th colspan="2">중분류</th>
				<th colspan="2">소분류</th>
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
			<tbody>
			<tr>
				<td colspan="6" style="height: 10px; line-height: 10px;"></td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 10px;"><select id='bigSelect' style="width: 80%;"/></select></td>
				<td colspan="2" style="padding-bottom: 10px;"><select id='middleSelect' style="width: 80%;"/></select></td>
				<td colspan="2"></td>
			</tr>
			
			<tr>
				<td colspan="2"><input type='text' name='big' id="big" style="width: 80%;"/><div id="bigAlert"></div></td>
				<td colspan="2"><input type='text' name='middle' id="middle" style="width: 80%;"/><div id="middleAlert"></div></td>
				<td><input type='text' name='small' id="small" style="width: 80%;"/><div id="smallAlert"></div></td>
				<td><button type='button' id='regBtn'>저장</button></td>
			</tr>
			</tbody>
		</table>
 
		</form>
		<!-- //actionForm end -->
	</div>
</div>
