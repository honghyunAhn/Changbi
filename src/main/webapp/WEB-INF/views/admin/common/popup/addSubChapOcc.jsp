<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목차추가</title>
<script type="text/javascript">
	//현재 차시 최대값
	var curOcc_num = parseInt('${curOcc_num}');
	var subchapVO = '${subchapVO}';
	
	$(document).ready(function(){
		var occ_num;
		var name;
		var addType;
		var obj = new Object();
		
		if('${subchapVO.name}' == null || '${subchapVO.name}' == '') {
		//값이 없을 때(목차추가)
			$('input[name=occ_num]').val(curOcc_num + 1);
			addType = 1;
		} else {
		//값이 있을 때(관리)
			$('input[name=occ_num]').val('${subchapVO.occ_num}');
			$('input[name=name]').val('${subchapVO.name}');
			addType = 3;
			obj.seq = parseInt('${subchapVO.seq}');
		}
		$('#addBtn').on('click', function() {
			
			occ_num = $('input[name=occ_num]').val();
			name = $('input[name=name]').val();
			
			if(checkForm(occ_num, name) == false) {
				return;
			}
			
			obj.occ_num = parseInt(occ_num);
			obj.name = name;
			
			addChapList(curOcc_num, obj, addType);
			$('.overlay').trigger('click');
		});
		$('#delBtn').on('click', function() {
			if(addType == 1) {
				if(confirm('등록을 취소하시겠습니까?')) {
					$('.overlay').trigger('click');
				}
			} else if(addType == 3) {
				if(confirm('목차를 삭제하시겠습니까?')) {
					delChap('${subchapVO.seq}');
					$('.overlay').trigger('click');
				}
			}
		});
	});
	//유효성 검사
	function checkForm(occ_num, name) {
		if(occ_num == null || occ_num == '') {
			alert('차시를 입력해주세요.');
			return false;
		}
		if(name == null || name == '') {
			alert('목차명을 입력해주세요.');
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
							<input type="number" name="occ_num" placeholder="차시 입력" style="width: 95%;">
						</td>
					</tr>
					<tr>
						<th>목차명</th>
						<td style="padding-bottom: 11px;">
							<input type="text" name="name" placeholder="목차명 입력" style="width: 95%;">
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