<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지추가</title>
<script type="text/javascript">

	//현재 차시 최대 페이지 수
	var curOrder_num = parseInt('${curOrder_num}');
	var subchapVO = '${subchapVO}';
	
	$(document).ready(function(){
		
		var occ_num;
		var order;
		var name;
		var filepath;
		var content_type;
		var obj = new Object();
		
		if('${subchapVO.name}' == null || '${subchapVO.name}' == '') {
		//값이 없을 때(페이지 추가)
			if('${subchapVO.depth}' == 2) {
				order = $('input[name=order]').val("1");
			} else {
				order = $('input[name=order]').val(curOrder_num + 1);
			}
			occ_num = $('input[name=occ_num]').val('${subchapVO.occ_num}');
			name = $('input[name=name]').val();
			filepath = $('input[name=filepath]').val();
			content_type = $('input[name=content_type]').val();
			addType = 2;
		} else {
		//값이 있을 때(페이지 관리)
			$('input[name=occ_num]').val('${subchapVO.occ_num}');
			$('input[name=order]').val('${subchapVO.order}');
			$('input[name=name]').val('${subchapVO.name}');
			$('input[name=filepath]').val('${subchapVO.filepath}');
			$('input[name=content_type]').val('${subchapVO.content_type}');
			addType = 3;
		}
		$('#addBtn').on('click', function() {
			occ_num = $('input[name=occ_num]').val();
			order = $('input[name=order]').val();
			name = $('input[name=name]').val();
			filepath = $('input[name=filepath]').val();
			content_type = $('input[name=content_type]').val();
			
			if(checkForm(name, filepath, content_type) == false) return;
			
			obj.seq = parseInt('${subchapVO.seq}');
			obj.occ_num = parseInt(occ_num);
			obj.order = parseInt(order);
			obj.name = name;
			obj.filepath = filepath;
			obj.content_type = content_type;
			
			addChapList(0, obj, addType);
			
			$('.overlay').trigger('click');
		});
		$('#delBtn').on('click', function() {
			if(addType == 2) {
				if(confirm('등록을 취소하시겠습니까?')) {
					$('.overlay').trigger('click');
				}
			} else if(addType == 3) {
				if(confirm('페이지를 삭제하시겠습니까?')) {
					delPage('${subchapVO.seq}');
					$('.overlay').trigger('click');
				}
			}
		});
	})
	//유효성 체크
	function checkForm(name, filepath, content_type) {
		if(name == null || name == '') {
			alert('목차명을 입력해주세요.');
			return false;
		}
		if(filepath == null || filepath == '') {
			alert('파일명을 입력해주세요.');
			return false;
		}
		if(content_type == null || content_type == '') {
			alert('컨텐츠유형을 입력해주세요.');
			return false;
		}
	}
</script>
</head>
<body>
	<div class="content_wraper" id="wrapper" style="text-align: center;">
		<form name="popSubChapForm" method="post" class="form-inline">
			<div>
				<table>
					<tr>
						<th>차시</th>
						<td style="padding-bottom: 11px;">
							<input type="number" name="occ_num" placeholder="차시 입력" min="0" style="width: 95%;">
						</td>
					</tr>
					<tr>
						<th>페이지 순서</th>
						<td style="padding-bottom: 11px;">
							<input type="number" name="order" placeholder="페이지순서 입력" min="1" style="width: 95%;">
						</td>
					</tr>
					<tr>
						<th>목차명</th>
						<td style="padding-bottom: 11px;">
							<input type="text" name="name" placeholder="목차명 입력" style="width: 95%;">
						</td>
					</tr>
					<tr>
						<th>파일명</th>
						<td style="padding-bottom: 11px;">
							<input type="text" name="filepath" placeholder="예) /01/001.htm" style="width: 95%;">
						</td>
					</tr>
					<tr>
						<th>컨텐츠유형</th>
						<td style="padding-bottom: 11px;">
							<input type="text" name="content_type" placeholder="예) htm" style="width: 95%;">
						</td>
					</tr>
				</table>
				<br>
				<input type="button" id="addBtn" class="btn btn-primary" value="추가">
				<input type="button" id="delBtn" class="btn btn-danger" value="삭제">
			</div>
		</form>
	</div>
</body>
</html>