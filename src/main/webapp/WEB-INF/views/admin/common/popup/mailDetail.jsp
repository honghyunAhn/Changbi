<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>SMS 상세내역 조회</title>
<script type="text/javascript">
	var list = ${list};
	$(document).ready(function() {
		setContent();
	})
	function setContent() {
		var content = "";
		$.each(list, function(index,item) {
			content +='<tr>';
			content +=		'<td>' + (index+1)+'</td>';
			content +=		'<td>' + item.USER_ID + '</td>';
			content +=		'<td>' + item.USER_NM + '</td>';
			content +=		'<td>' + item.USER_EMAIL + '</td>';
			content += '</tr>';
		})
	$('#dataListBody').html(content);
	}
</script>
</head>
<body>
	<div class="content_wraper" id="modalsContentss" style="height: 600px; overflow: auto;">
	<div class="tab_body">
		<table id="dataTbl" class="table-hover" style="border-collapse: collapse; height: 100%;">
			<thead>
				<tr>
					<th>순번</th>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		
	</div>
</div>
</body>
</html>