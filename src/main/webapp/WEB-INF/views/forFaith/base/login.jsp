<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>로그인</title>
<link href="<c:url value="/resources/css/ext/bootstrap/bootstrap.min.css"/>" rel="stylesheet"><!-- Bootstrap Core CSS -->

<script src="<c:url value="/resources/js/ext/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/resources/js/ext/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->

<!-- 내부 자바스크립트 -->
<script src='<c:url value="/resources/js/com/commonFunc.js" />'></script>

<script type="text/javascript">
$(document).ready(function() {
	$("#id").bind("keyup", function(event) {
		if(event.keyCode == 13){
			$("#passwd").focus();
		}
	});
	
	$("#passwd").bind("keyup", function(event) {
		if(event.keyCode == 13){
			actionLogin();
		}
	});
	
	//initNextFocus();	// next focusing initialize
	
	getid(document.loginForm);	// 쿠키아이디불러오기
	
	if($(":text[name='id']").val()) {
	    $(":password[name='pw']").focus();
	} else {
	    $(":text[name='id']").focus()
	}
});


function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    
    if (form.saveid.checked) {
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    } else {
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    }
    
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
   	form.saveid.checked = (form.id.value = getCookie("saveid") ? getCookie("saveid") : "");
}

function actionLogin() {
	var f = document.loginForm;
	
	if (f.id.value =="") {
        alert("아이디를 입력하세요");
        f.id.focus();
        
        return false;
    } else if (f.pw.value =="") {
        alert("비밀번호를 입력하세요");
        f.pw.focus();
        
        return false;
    } else {
    	saveid(f);

        f.action = "<c:url value='/forFaith/base/actionLogin'/>";
        f.submit();
    }
}
</script>
</head>

<body>

    <div class="container" style="height:264px; position:absolute; top:calc(50% - 132px); left:0; right:0;">
            <div style="margin: 0 auto; width:360px;">
                <div class="login-panel panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-key"></i>로그인</h3>
                    </div>
                    <div class="panel-body">
                        <form:form name="loginForm" method="post">
                        	<!-- 로그인 후 이동할 페이지 저장(로그인 후 이동할 페이지가 존재하면 사용) -->
                        	<input type="hidden" name='link' value="<c:out value="${member.link}" default="" />">
                        	
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control nextfocus" data-nextfocus='passwd' placeholder="아이디" id="id" name="id" type="text" maxlength="100">
                                </div>
                                <div class="form-group">
                                    <input class="form-control nextfocus" data-nextfocus='btnLogin' placeholder="패스워드" id="passwd" name="pw" type="password" maxlength="100">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input id="saveid" name="saveid" type="checkbox" value="Remember Me">아이디저장
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a id="btnLogin" href="javascript:actionLogin()" class="btn btn-lg btn-success btn-block">로그인</a>
                            </fieldset>
                        </form:form>
                        <c:if test="${not empty member.msg}">
							<div style="color: #ff0000; margin-top: 10px;"><c:out value="${member.msg}"/></div>
						</c:if>
                    </div>                    
                </div>
            </div>
    </div>
</body>

</html>
