<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자 비밀번호 변경</title>
<link href="<c:url value="/resources/css/ext/bootstrap/bootstrap.min.css"/>" rel="stylesheet"><!-- Bootstrap Core CSS -->

<script src="<c:url value="/resources/js/ext/jquery/jquery-1.11.0.min.js"/>"></script>
<script src="<c:url value="/resources/js/ext/bootstrap/bootstrap.min.js"/>"></script><!-- bootstrap core javascript -->

</head>

<body>

    <div class="container" style="height:264px; position:absolute; top:calc(50% - 132px); left:0; right:0;">
            <div style="margin: 0 auto; width:360px;">
                <div class="login-panel panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-key"></i>비밀번호 변경</h3>
                    </div>
                    <div class="panel-body">
                        <form name="pwUpdForm" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="변경할 비밀번호 입력" name="pw" type="text" maxlength="20">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="변경할 비밀번호 재입력" name="pwBefore" type="password" maxlength="20">
                                </div>
                                <a id="pwUpd" href="javascript:actionLogin()" class="btn btn-lg btn-success btn-block">비밀번호 변경</a>
                            </fieldset>
                        </form>
                        <c:if test="${not empty member.msg}">
							<div style="color: #ff0000; margin-top: 10px;"><c:out value="${member.msg}"/></div>
						</c:if>
                    </div>
                </div>
            </div>
    </div>
</body>

</html>
