<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">

<script type="text/javascript">

$(document).ready(function () {

	// 최초 호출 시 페이징 네비게이션 세팅(해당 영역에 이벤트가 생성 된다)
	var pagingNavigation = new PagingNavigation($(".pagination"));

	
	
	/** 변수 영역 **/
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// 여기에서 URL 변경 시켜서 사용
	var listAll	= "<c:url value='/data/complete/completeListAll' />";
	var procUrl	= "<c:url value='/data/complete/completeProc' />";
	var listUrl	= "<c:url value='/data/complete/completeProcList' />";
	var completeUrl = "<c:url value='/data/complete/doComplete' />";
	
	// 컨텐츠 타이틀 세팅
	contentTitle = ( $("#groupLearnYn").val() == "Y" ? "교육청(기관)이수관리" : "개별이수관리" );
	
	/** 함수 영역 **/
	
	function init(pageNo, courseId, cardinalId, userNm){

		// pageNo를 넘기지 않는다면 hidden의 pageNo를 사용한다.
		pageNo = pageNo ? pageNo : $(":hidden[name='pageNo']").val();
		
		// 변경 된 pageNo를 hidden의 pageNo에 저장한다.(검색용)
		$(":hidden[name='pageNo']").val(pageNo);
		
		
		// ajax 처리
			$.ajax({
				type	: "post",
				url		: listAll,
				data 	: {
					'pageNo' : pageNo,
					'courseId' : courseId,
					'cardinalId' : cardinalId,
					'userNm' : userNm
				},
				success	: function(result) {
					var sb = new StringBuilder();
					var pageNo		= result.pageNo		? result.pageNo		: 1;
					var numOfRows	= result.numOfRows	? result.numOfRows 	: 10;

					
 					var passNum = 0;
					var failNum = 0; 

					

					if(result.list && result.list.length > 0) {
						var dataList	= result.list;

						for(var i=0; i<dataList.length; ++i) {
							var dataInfo = dataList[i];
							
							if(dataInfo.issueYn=='Y'){
								passNum++;
							} else {
								failNum++;
							}
							
/* 							var sType = "";
							sType = (dataInfo.sType == "1" ? "초등" 
								  : (dataInfo.sType == "2" ? "중등" 
								  : (dataInfo.sType == "3" ? "고등"
								  : (dataInfo.sType == "4" ? "유아"
								  : (dataInfo.sType == "5" ? "특수"
								  : (dataInfo.sType == "6" ? "기관" : ""))))));
 */							
/* 							// 이수/미이수 인원명 구하기
							dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum; */

							sb.Append("<tr>");
							sb.Append(" <td><input type='checkbox' class='checkLearn'></td>");
							sb.Append("	<td class='tdCourseId'>"+dataInfo.course.id+"</td>");
							sb.Append("	<td class='tdCourseName'>"+dataInfo.course.name+"</td>");
							sb.Append("	<td class='tdCardinalId'>"+dataInfo.cardinal.id+"</td>");
							sb.Append("	<td class='tdCardinalName'>"+dataInfo.cardinal.name+"</td>");
							sb.Append("	<td class='tdUserId'>"+dataInfo.user.id+"</td>");
							sb.Append("	<td class='tdUserName'>"+dataInfo.user.name+"</td>");
							sb.Append("	<td class='tdUserBirthday'>"+dataInfo.user.birthDay+"</td>");
							sb.Append("	<td class='tdIssueYn'>"+dataInfo.issueYn+"</td>");
							//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
							if(dataInfo.issueDate!=null&&dataInfo.issuDate!=""){								
								sb.Append("	<td class='tdIssueDate'>"+dataInfo.issueDate+"</td>");
							} else{
								sb.Append("	<td class='tdIssueDate'></td>");								
							}
							sb.Append("</tr>");
						
						}
					} else {
						sb.Append("<tr>");
						sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
						sb.Append("</tr>");
					}
					
					$("#dataListBody").html(sb.ToString());
					$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
										 + "이수 : "+passNum+"명 / "
										 + "미이수 : "+failNum+"명" );

/* 					// 페이징 처리
					pagingNavigation.setData(result);				// 데이터 전달
					// 페이징(콜백함수 숫자 클릭 시)
					pagingNavigation.setNavigation(init);					
 */					
					
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});	
	}
		
	
	
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function completeProc() {
		if(confirm("이수처리 하시겠습니까?")) {
			// ajax 처리
			$.ajax({
				type	: "post",
				url		: procUrl,
				data 	: $("form[name='searchForm']").serialize(),
				success	: function(result) {
					// 이수 처리 후 리스트 조회
					var sb = new StringBuilder();
					var passNum = 0;
					var failNum = 0;

					if(result.list && result.list.length > 0) {
						var dataList	= result.list;

						for(var i=0; i<dataList.length; ++i) {
							var dataInfo = dataList[i];
							var sType = "";
							
							sType = (dataInfo.sType == "1" ? "초등" 
								  : (dataInfo.sType == "2" ? "중등" 
								  : (dataInfo.sType == "3" ? "고등"
								  : (dataInfo.sType == "4" ? "유아"
								  : (dataInfo.sType == "5" ? "특수"
								  : (dataInfo.sType == "6" ? "기관" : ""))))));
							
							// 이수/미이수 인원명 구하기
							dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum;

							sb.Append("<tr>");
							sb.Append("	<td>"+dataInfo.course.id+"</td>");
							sb.Append("	<td>"+(dataInfo.schoolName ? dataInfo.schoolName : "")+"</td>");
							sb.Append("	<td>"+sType+"</td>");
							sb.Append("	<td>"+((dataInfo.user && dataInfo.user.name) ? dataInfo.user.name : "")+"</td>");
							sb.Append("	<td>"+((dataInfo.user && dataInfo.user.birthDay) ? dataInfo.user.birthDay : "")+"</td>");
							sb.Append("	<td>"+dataInfo.objScore+"</td>");
							sb.Append("	<td>"+dataInfo.subScore+"</td>");
							//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
							sb.Append("	<td>"+dataInfo.partScore+"</td>");
							sb.Append("	<td>"+dataInfo.attScore+"</td>");
							sb.Append("	<td>"+dataInfo.totalScore+"</td>");
							sb.Append("	<td>"+(dataInfo.issueNum ? "이수" : "미이수")+"</td>");
							sb.Append("	<td>"+((dataInfo.region && dataInfo.region.name) ? dataInfo.region.name : "")+"</td>");
							sb.Append("	<td>"+(dataInfo.jurisdiction ? dataInfo.jurisdiction : "")+"</td>");
							sb.Append("	<td>"+(dataInfo.issueNum ? dataInfo.issueNum : "")+"</td>");
							sb.Append("</tr>");
						}
					} else {
						sb.Append("<tr>");
						sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
						sb.Append("</tr>");
					}
					
					$("#dataListBody").html(sb.ToString());
					$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
										 + "이수 : "+passNum+"명 / "
										 + "과락 : "+failNum+"명" );
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList(pageNo) {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var sb = new StringBuilder();
				var passNum = 0;
				var failNum = 0;

				if(result.list && result.list.length > 0) {
					var dataList	= result.list;

					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];
						var sType = "";
						
						sType = (dataInfo.sType == "1" ? "초등" 
							  : (dataInfo.sType == "2" ? "중등" 
							  : (dataInfo.sType == "3" ? "고등"
							  : (dataInfo.sType == "4" ? "유아"
							  : (dataInfo.sType == "5" ? "특수"
							  : (dataInfo.sType == "6" ? "기관" : ""))))));
						
						// 이수/미이수 인원명 구하기
						dataInfo.issueYn = "Y" && dataInfo.issueNum ? ++passNum : ++failNum;

						sb.Append("<tr>");
						sb.Append("	<td>"+dataInfo.course.id+"</td>");
						sb.Append("	<td>"+dataInfo.course.name+"</td>");
						sb.Append("	<td>"+dataInfo.cardinal.id+"</td>");
						sb.Append("	<td>"+dataInfo.cardinal.name+"</td>");
						sb.Append("	<td>"+dataInfo.user.id+"</td>");
						sb.Append("	<td>"+dataInfo.user.birthDay+"</td>");
						sb.Append("	<td>"+dataInfo.issueYn+"</td>");
						//sb.Append("	<td>"+(dataInfo.boardCnt+dataInfo.commentCnt > 0 ? 10 : 0)+"</td>");
						sb.Append("	<td>"+dataInfo.issueDate+"</td>");
						sb.Append("</tr>");
					}
				} else {
					sb.Append("<tr>");
					sb.Append("	<td colspan='14'>조회된 결과가 없습니다.</td>");
					sb.Append("</tr>");
				}
				
				$("#dataListBody").html(sb.ToString());
				$("#resultArea").html( "처리대상 : "+(result.list && result.list.length > 0 ? result.list.length : 0)+"명 / "
									 + "이수 : "+passNum+"명 / "
									 + "과락 : "+failNum+"명" );
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}

	function doComplete(courseId, cardinalId, completeList, flag){

		$.ajax({
			contentType : "application/json",
			dataType : "text",
			type	: "get",
			traditional : true,
			url		: completeUrl,
			data    : {
				"course_id" : courseId,
				"cardinal_id" : cardinalId,
				"flag" : flag,
 				"completeList" : JSON.stringify(completeList)
			},
			success	: function(data) {

				alert('처리 완료 : ' + data + '명');		        
				$('#checkAll').prop('checked', false);
				init(1, courseId, cardinalId, $('#userId').val());

			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}						
		});
	}		
	
	
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 과정, 기수, 이름에 선택된 값이 있으면 전달.
		
		var courseId = $('#courseId').val();
		var cardinalId = $('#cardinalId').val();
		var userId = $('#userId').val();

		if(courseId==''||courseId==null){
			alert('과정, 기수를 선택해주세요.');
			return;
		}
		if(cardinalId==''||cardinalId==null){
			alert('기수를 선택해주세요.');
			return;
		}
		
		init(1, courseId, cardinalId, userId);
		
		
/* 		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 선택해주세요.");
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($(":hidden[name='cardinalId']").val());
			
			completeProc();
		} */
	});
	
	//기수선택 >> 과정선택으로 변경함
	// 과정선택 버튼 클릭 시
	$("#courseName").unbind("click").bind("click", function() {
		
		// 과정선택 레이어 팝업
		var data = new Object();
		data.learnTypes = $(":hidden[name='groupLearnYn']").val() == "Y" ? "G" : $("#learnType").val();
		
		openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
	});
	
	// 기수선택 버튼 클릭 시
	$("#cardinalName").unbind("click").bind("click", function() {

		if($('#courseName').val()=='과정선택'){
			alert('과정을 먼저 선택해주세요.');
			return;
		} else {
			// 기수선택 레이어 팝업
			var data = new Object();
			data.learnTypes = "J,S,M";
			data.id = $("#courseId").val();

			if($(":hidden[name='groupLearnYn']").val() == "Y") {
				data.learnTypes = "G";
			}
		
			openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
		}		
	}); 
	$('#checkAll').on('click', function(){

		if($('#checkAll').prop('checked')){
			$('.checkLearn').each(function(){
				$(this).prop('checked', true);
			});
		} else {
			$('.checkLearn').each(function(){
				$(this).prop('checked', false);
			});
		}
		
	});

	$('#completeBtn').on('click', function(){
		
		if(confirm('이수처리하시겠습니까?')){
			var courseId = $('#courseId').val();
			var cardinalId = $('#cardinalId').val();
			var completeList = new Array();
			
			$('.checkLearn').each(function(){

				if($(this).prop('checked')){
					var userId = $(this).parent().parent().children('.tdUserId').html();		
					completeList.push({
						'user_id' : userId
					});
				};
			});

			doComplete(courseId, cardinalId, completeList, '1');

		}
		
	});

	$('#cancelBtn').on('click', function(){
		
		if(confirm('이수취소하시겠습니까?')){
			var courseId = $('#courseId').val();
			var cardinalId = $('#cardinalId').val();
			var completeList = new Array();
			
			$('.checkLearn').each(function(){

				if($(this).prop('checked')){
					var userId = $(this).parent().parent().children('.tdUserId').html();		
					completeList.push({
						'user_id' : userId
					});
				};
			});

			doComplete(courseId, cardinalId, completeList, '2');

		}
		
	});

	
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
});

function setCardinal(cardinal) {
	// 기수 정보 저장
	$("#cardinalId").val(cardinal.id);		// 임시저장
	
	$("#cardinalName").val(cardinal.name);
	$("#learnType").val(cardinal.learnType);
}

function setCourse(course) {
	// 과정 정보 저장
	$("#courseId").val(course ? course.id : "");
	$("#courseName").val(course ? course.name : "과정선택");
}



</script>

<div class="content_wraper">
	<h3 class='content_title'></h3>			
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
	       	<div>
	        	<table class="searchTable">
		        	<tr>
		        		<th>과정명</th>
		        		<td>
		        			<!-- 과정 선택 -->
							<input type='text' id='courseName' name='course.name' value='<c:out value="${search.course.name}" />' placeholder="과정선택" readonly="readonly" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>기수명</th>
		        		<td>
		        			<!-- 기수 선택 -->
							<input type='text' id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" />' placeholder="기수선택" readonly="readonly" />
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>성명</th>
		        		<td>
		        			<input type='text' id="userId" name='user.id' value='<c:out value="${search.user.id}" default="" />'  placeholder="빈칸: 전체 검색"/>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class="buttonTd" colspan="2">
			        		<button id='searchBtn' class="btn-primary" type="button">검색</button>
							<button id='completeBtn' class="btn-danger" type="button">선택이수처리</button>
							<button id='cancelBtn' class="btn-primary" type="button">선택이수취소</button>
		        		</td>
		        	</tr>
	        	</table>
	        </div>
        	<input type="hidden" name="id" value="0" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />
        	
        	<!-- 이수처리 후 넘어온 id 리스트 저장하는 위치 -->
        	<div id="idListArea"></div>
        	
        	<!-- 그룹연수 구분 -->
        	<input type="hidden" id="groupLearnYn" name="groupLearnYn" value='<c:out value="${search.groupLearnYn}" default="" />' />
        	
        	<!-- 기수와 과정 ID 세팅 -->
        	<input type="hidden" id="courseId" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
<%--         	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 --> --%>
			<input type="hidden" id="cardinalId" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
			<input type="hidden" id="learnType" value='<c:out value="${search.cardinal.learnType}" default="" />' />
			<%-- <!-- 기수 선택 -->
			<input type='text' id='cardinalName' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" /> --%>

			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		<div id="resultArea"></div>		
		<table style="border-collapse: collapse;">
			<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>과정코드</th>
				<th>과정명</th>
				<th>기수코드</th>
				<th>기수명</th>
<!-- 				<th>학교명</th> -->
<!-- 				<th>구분</th> -->
				<th>아이디</th>
				<th>성명</th>
				<th>생년월일</th>
<!-- 				<th>온라인시험</th>
				<th>온라인과제</th>
				<th>학습참여도</th>
				<th>출석시험</th>
				<th>최종환산점수</th> -->
				<th>이수현황</th>
				<th>이수날짜</th>
<!-- 				<th>시도교육청</th>
				<th>관할교육청</th>
				<th>이수번호</th> -->
			</tr>
			</thead>
			<tbody id="dataListBody"></tbody>
		</table>
		<div class="pagination"></div>
		<div class="paging"></div>
<!-- 	<form name="learnRegForm" method="post">
		<input type="hidden" name="courseId">
		<input type="hidden" name="cardinalId">
	</form>
 -->

	</div>
</div>