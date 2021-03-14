<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>출결관리팝업</title>

<script type="text/javascript">

var presentDate='<c:out value="${attend.presentDate}"/>';

$(function(){
	// 여기에서 URL 변경 시켜서 사용
	var listUrl	= "<c:url value='/data/course/cardinalList2' />";
	
	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".popup_pagination"));
	
	//입과자 정보 리스트
	function setRegUserList(pageNo) {
		var regListUrl = "<c:url value='/data/attendance/learnAppList' />";
		var regPagingNavigation = new PagingNavigation($("#regPagination"));
		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $("form[name='regSearchForm']").find(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$("form[name='regSearchForm']").find(":hidden[name='pageNo']").val(pageNo);
		
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: regListUrl,
			data 	: $("form[name='regSearchForm']").serialize(),
			success	: function(result) {
				
				var sb = new StringBuilder();
				
				if(result.list && result.list.length > 0) {
					var dataList	= result.list;
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var regDate	 = dataInfo.regDate;

						sb.Append("<tr>");
						sb.Append("	<td  name='userName'>"+(dataInfo.user.name ? dataInfo.user.name : "")+"</td>");
						sb.Append("	<td class='userIds' class='content_edit'>"+((dataInfo.user && dataInfo.user.id) ? dataInfo.user.id : "")+"</td>");
						
						
						sb.Append('<td><select class="slave_attend_select">');
						
						if(dataInfo.attend){
							if(!dataInfo.attend.status){
								sb.Append('<option value="">정보없음</option>');
								sb.Append('<option value="출석">출석</option>');
								sb.Append('<option value="지각">지각</option>');
								sb.Append('<option value="조퇴">조퇴</option>');
								sb.Append('<option value="결석">결석</option>');
							}else{
								
							    if(dataInfo.attend.status=='출석'){
									sb.Append('<option value="출석" selected>출석</option>');
									sb.Append('<option value="지각">지각</option>');
									sb.Append('<option value="조퇴">조퇴</option>');
									sb.Append('<option value="결석">결석</option>');
							    }else if(dataInfo.attend.status=='지각'){

									sb.Append('<option value="출석">출석</option>');
									sb.Append('<option value="지각" selected>지각</option>');
									sb.Append('<option value="조퇴">조퇴</option>');
									sb.Append('<option value="결석">결석</option>');
							    }else if(dataInfo.attend.status=='조퇴'){

									sb.Append('<option value="출석">출석</option>');
									sb.Append('<option value="지각">지각</option>');
									sb.Append('<option value="조퇴" selected >조퇴</option>');
									sb.Append('<option value="결석">결석</option>');
							    }else{

									sb.Append('<option value="출석">출석</option>');
									sb.Append('<option value="지각">지각</option>');
									sb.Append('<option value="조퇴">조퇴</option>');
									sb.Append('<option value="결석" selected >결석</option>');
							    }
							}
						}else{
							sb.Append('<option value="">정보없음</option>');
							sb.Append('<option value="출석">출석</option>');
							sb.Append('<option value="지각">지각</option>');
							sb.Append('<option value="조퇴">조퇴</option>');
							sb.Append('<option value="결석">결석</option>');
						}
						
						
						
						
						sb.Append('</select></td>');
						
						sb.Append('<td><select class="slave_gone_select">');
						
						if(dataInfo.attend){
							if(!dataInfo.attend.isGone){
								sb.Append('<option value="Y">Y</option>');
								sb.Append('<option value="" selected>N</option>');
							}else{
								sb.Append('<option value="Y" selected>Y</option>');
								sb.Append('<option value="">N</option>');
							}
						}else{
							sb.Append('<option value="Y">Y</option>');
							sb.Append('<option value="" selected>N</option>');
						}
						
						
						sb.Append('</select></td>');
						

						sb.Append("	<td>");
						
						if(dataInfo.attend){
							if(!dataInfo.attend.memo){
								sb.Append(" <input type='text' class='memo' name='memo' value=''>");
							}else{
								sb.Append(" <input type='text' class='memo' name='memo' value='"+dataInfo.attend.memo+"'>");
							}
						}else{
							sb.Append(" <input type='text' class='memo' name='memo' value=''>");
						}
						
						sb.Append('</td>');
						
						
						
						/* sb.Append("	<td><button type='button' class='saveInfo'>개별저장<button></td>"); */
						
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='12'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#popupDataListBody").html(sb.ToString());
				regPagingNavigation.setData(result);				// 데이터 전달
				regPagingNavigation.setNavigation(setRegUserList);
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	

	$(".master_attend_select").change(function(){
		$(".slave_attend_select").val($(this).val()).attr("selected","selected");
	});
	
	$(".master_gone_select").change(function(){
		$(".slave_gone_select").val($(this).val()).attr("selected","selected");
	});
	
/* 	$("#dataListBody").find(":checkbox[name='selectCheckBox']:checked").each(function(i) {
		var idx = $("#dataListBody").find(":checkbox[name='selectCheckBox']").index($(this));
		var selectId = $("#dataListBody").find(":hidden[name='checkId']").eq(idx).val();
		var selectName = $("#dataListBody").find(":hidden[name='checkName']").eq(idx).val();
		 */
	$("#saveAll").on("click",function(){
		var ids=[];
		var attends=[];
		var gones=[];
		var memo=[];
		
		var data=[];

		$("#popupDataListBody").find(".userIds").each(function(i){
			ids.push($(this).html());
		});

		$("#popupDataListBody").find(".slave_attend_select").each(function(i){
			attends.push($(this).find("option:selected").val());
		});
		
		$("#popupDataListBody").find(".slave_gone_select").each(function(i){
			gones.push($(this).find("option:selected").val());
		});
		
		$("#popupDataListBody").find(".memo").each(function(i){
			memo.push($(this).val());
		});

		
			for(var i=0;i<ids.length;i++){
				
				data.push({
						userId:ids[i],
						presentDate:presentDate,
						status:attends[i],
						isGone:gones[i],
						memo:memo[i],
						courseId:'<c:out value="${attend.courseId}"/>',
						cardinalId:'<c:out value="${attend.cardinalId}"/>'
				});
				
			}
			
			$.ajax({
				
				type		: "POST",
				url			: "<c:url value='/data/attendance/attendanceCheck'/>",
				data		: JSON.stringify(data),
				dataType	: "json",
				contentType	: "application/json; charset=utf-8",
				processData	: false,
				success		: function(result) {

					alert("일괄저장 되었습니다.");
					
				}
				, error		: function(e) {

					alert("일괄저장 실패");
				
				}
			});
			
	});

	$(".saveInfo").on("click",function(){
		
	});
	
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#popupSearchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		setContentList(1);
	});
	
	// 클릭 시 상세 페이지 이동
	$("#popupDataListBody").on("click", ".popup_content_edit", function() {
		var idx = $(".popup_content_edit").index($(this));
		
		// 부모의 함수 호출해준다.
		var cardinal =	{ "id" : $(":hidden[name='popupId']").eq(idx).val()
						, "name" : $(":hidden[name='popupName']").eq(idx).val()
						, "learnType" : $(":hidden[name='popupLearnType']").eq(idx).val()
						, "appStartDate" : $(":hidden[name='popupAppStartDate']").eq(idx).val()
						, "appEndDate" : $(":hidden[name='popupAppEndDate']").eq(idx).val()
						, "learnStartDate" : $(":hidden[name='popupLearnStartDate']").eq(idx).val()
						, "learnEndDate" : $(":hidden[name='popupLearnEndDate']").eq(idx).val()
						, "complateYn" : $(":hidden[name='popupComplateYn']").eq(idx).val()
						, "useYn" : $(":hidden[name='popupUseYn']").eq(idx).val() };
		setCardinal(cardinal);
		
		closeLayerPopup();
		
	});
	
	setRegUserList();
});

</script>
</head>

<body>
<form name="regSearchForm" method="post">
        	<input type="hidden" name="id" value="0" />
        	<input type="hidden" name="cardinal.id" value="<c:out value="${attend.cardinalId}"/>" />
        	<input type="hidden" name="attend.presentDate" value="<c:out value="${attend.presentDate}"/>" />
        	<input type="hidden" name="paymentState" value="2" />
        	
        	<!-- pageNo -->
        	<input type="hidden" name="pageNo" value='<c:out value="${search.pageNo}" default="1" />' />
        	
        	<!-- 정상회원만 조회 -->
        	<input type="hidden" name="useYn" value='Y' />
        	
			<input type="hidden" placeholder="검색어입력" name="searchKeyword" value="<c:out value="${search.searchKeyword}" />">
			<input type="hidden" placeholder="검색어입력" name="searchCondition" value="all">
			
		</form>
<div id="wrapper">
    <div>
        <div>     	
			<%-- <h1><c:out value="${attend.presentDate}"/></h1> --%>
			<div class="col-lg-12" style='margin-top: 10px;'>
				<table class="table dataTable table-bordered table-hover">
					<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>출결구분
						</th>
						<th>외출여부
						</th>
						<th>비고</th>
					</tr>
					<tr>
						<th>일괄처리</th>
						<th></th>
						<th>
							<select class="master_attend_select">
								<option value="">정보없음</option>
								<option value="출석">출석</option>
								<option value="지각">지각</option>
								<option value="조퇴">조퇴</option>
								<option value="결석">결석</option>
							</select>
						</th>
						<th>
							<select class="master_gone_select">
								<option value="">N</option>
								<option value="Y">Y</option>
							</select>
						</th>
						<th></th>
					</tr>
					</thead>
					<tbody id="popupDataListBody"></tbody>
					
				</table>
				<div style="float: right;"><button type='button' id='saveAll'>일괄저장</button></div>
			</div>
			
			<div class="popup_pagination"><div id="regPagination" class="pagination"></div></div>
			
        </div>
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>