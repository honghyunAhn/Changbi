<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function () {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	/** 변수 영역 **/
	// 여기에서 URL 변경 시켜서 사용
	var chart1Url = "<c:url value='/data/stats/learnStatsGraph1' />";
	var chart2_1Url = "<c:url value='/data/stats/learnStatsGraph2_1' />";
	var chart2_2Url = "<c:url value='/data/stats/learnStatsGraph2_2' />";
	var chart3_1Url = "<c:url value='/data/stats/learnStatsGraph3_1' />";
	var chart3_2Url = "<c:url value='/data/stats/learnStatsGraph3_2' />";
	var chart4_1Url = "<c:url value='/data/stats/learnStatsGraph4_1' />";
	var chart4_2Url = "<c:url value='/data/stats/learnStatsGraph4_2' />";
	var chart5Url = "<c:url value='/data/stats/learnStatsGraph5' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart1() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart1Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList();
				var column2 = new ArrayList();
				var column3 = new ArrayList();
				var column4 = new ArrayList();
				
				column1.add("x");
				column2.add("미인증");
				column3.add("인증");
				column4.add("취소");	
				
				if(result && result.length > 0) {
					for(var i=0; i<result.length; ++i) {
						column1.add(result[i].SELECTED_DATE+"-01");
						column2.add(result[i].STATE_1);
						column3.add(result[i].STATE_2);
						column4.add(result[i].STATE_3);
					}
				}
				
				// Script
				var chart = bb.generate({
					bindto: "#chart1Area",
					data: {
						x: "x",
						columns: [
							column1.toArray(),
							column2.toArray(),
							column3.toArray(),
							column4.toArray()
						]
					},
				  	
					axis: {
				    	x: {
				      		type: "timeseries",
				      		tick: {
				        		format: "%Y-%m"
				      		}
				    	}
				  	}
				});
				
				setChart2_1();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart2_1() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart2_1Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList();
				var column2 = new ArrayList();
				var column3 = new ArrayList();
				var column4 = new ArrayList();
				var totalNum = 0;
				
				column1.add("직무연수");
				column2.add("단체연수");
				column3.add("집합연수");
				column4.add("자율연수");	
				
				if(result && result.length > 0) {
					for(var i=0; i<result.length; ++i) {
						result[i].LEARN_TYPE == "J" ? column1.add(result[i].CNT) 
													: (result[i].LEARN_TYPE == "G" ? column2.add(result[i].CNT)
													: (result[i].LEARN_TYPE == "M" ? column3.add(result[i].CNT) : column4.add(result[i].CNT)));
						
						totalNum += result[i].CNT;
					}
				}
				
				$("#title2_1Area").html("접수유형별(전체 : "+totalNum+"명)");
				
				// Script
				var chart = bb.generate({
					bindto: "#chart2_1Area",
					data: {
						type : "pie",
						columns: [
							column1.toArray(),
							column2.toArray(),
							column3.toArray(),
							column4.toArray()
						]
					}
				});
				
				setChart2_2();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
		
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart2_2() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart2_2Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList();
				var column2 = new ArrayList();
				var column3 = new ArrayList();
				var column4 = new ArrayList();
				var totalNum = 0;
				
				column1.add("1학점");
				column2.add("2학점");
				column3.add("3학점");
				column4.add("4학점");	
				
				if(result && result.length > 0) {
					for(var i=0; i<result.length; ++i) {
						result[i].CREDIT == "1" ? column1.add(result[i].CNT) 
												: (result[i].CREDIT == "2" ? column2.add(result[i].CNT)
												: (result[i].CREDIT == "3" ? column3.add(result[i].CNT) : column4.add(result[i].CNT)));
						
						totalNum += result[i].CNT;
					}
				}
				
				$("#title2_2Area").html("직무연수 학점별(전체 : "+totalNum+"명)");

				// Script
				var chart = bb.generate({
					bindto: "#chart2_2Area",
					data: {
						type : "pie",
						columns: [
							column1.toArray(),
							column2.toArray(),
							column3.toArray(),
							column4.toArray()
						]
					}
				});
				
				setChart3_1();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart3_1() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart3_1Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				google.charts.load('current', {packages: ['corechart', 'bar']});
				google.charts.setOnLoadCallback(drawBasic);
				
				function drawBasic() {
					var dataTable = new ArrayList();
					var data = new ArrayList();
					var styleList = new ArrayList(['#ac6233', '#f5e277', 'e3f521d', '#682190', '#3a6b7e']);
					var maxCnt = 0;
					var totalNum = 0;
					
					data.add("과정");
					data.add("접수");
					data.add({ role: 'style'});
					
					dataTable.add(data.toArray());
					
					for(var i=0; i<result.length; ++i) {
						data = new ArrayList();
						
						data.add(result[i].COURSE_NAME);
						data.add(result[i].CNT);
						data.add(styleList.get(i));
						
						dataTable.add(data.toArray());
						
						if(i == 0) {
							maxCnt = result[i].CNT;
						}
						
						totalNum += result[i].CNT;
					}
					
					$("#title3_1Area").html("최다접수과정 TOP5(전체 : "+totalNum+"명)");
					
					var data1 = google.visualization.arrayToDataTable(dataTable.toArray());
	                            		
					var view1 = new google.visualization.DataView(data1);
					
					view1.setColumns([0, 1, {	
												calc: "stringify",
	        									sourceColumn: 1,
	        									type: "string",
	        									role: "annotation" }, 2]);
	                            		
					var options1 = {
	                          			title: { position: "none" },
	                          			fontSize: 14,
	                          			chartArea:{left:'15%',top:0,width:'80%',height:'75%'},
	                          			bar: { groupWidth: "70%"},
	                          			legend: { position: "none" },
	                          			height: result.length * 55,
	                          			hAxis: {
	                          				title: { position: "none" },
	                          				gridlines: { count: maxCnt + 1},
	                          				format: 'decimal',
	                          				viewWindow: {
	                          					min: 0,
	                          					max: maxCnt
	                          				}
	                          			}
	                          		};
					
					var chart1 = new google.visualization.BarChart(document.getElementById('chart3_1Area'));
					chart1.draw( view1, options1);
					
					setChart3_2();
				}
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart3_2() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart3_2Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var columns = new ArrayList();
				var totalNum = 0;
				
				if(result && result.length > 0) {
					for(var i=0; i<result.length; ++i) {
						var column = new ArrayList();
						
						column.add(result[i].COURSE_NAME);
						column.add(result[i].CNT);
						
						columns.add(column.toArray());
						
						totalNum += result[i].CNT;
					}
				}
				
				$("#title3_2Area").html("교원선호과정 TOP5(전체 : "+totalNum+"명)");
				
				// Script
				var chart = bb.generate({
					bindto: "#chart3_2Area",
					data: {
						type : "pie",
						columns: columns.toArray()
					}
				});
				
				setChart4_1();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart4_1() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart4_1Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList();
				var column2 = new ArrayList();
				var column3 = new ArrayList();
				var totalNum = 0;
				
				column1.add("미이수");
				column1.add(result.ISSUE_1);
				column2.add("이수");
				column2.add(result.ISSUE_2);
				column3.add("과락");
				column3.add(result.ISSUE_3);
				
				totalNum += result.ISSUE_1 + result.ISSUE_2 + result.ISSUE_3;
				
				$("#title4_1Area").html("이수현황(인증건/무료연수제외)(전체 : "+totalNum+"명)");
				
				// Script
				var chart = bb.generate({
					bindto: "#chart4_1Area",
					data: {
						type : "pie",
						columns: [
							column1.toArray(),
							column2.toArray(),
							column3.toArray()
						]
					}
				});
				
				setChart4_2();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
		
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart4_2() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart4_2Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList(["x","무통장입금","계좌이체","가상계좌","신용카드","지난연기결제","무료","단체연수결제"]);
				var column2 = new ArrayList(["건수",result.PAYMENT_1,result.PAYMENT_2,result.PAYMENT_3
				                            ,result.PAYMENT_4,result.PAYMENT_5,result.PAYMENT_6,result.PAYMENT_7]);
				var totalNum = 0;
				
				totalNum += result.PAYMENT_1 + result.PAYMENT_2 + result.PAYMENT_3 + result.PAYMENT_4 + result.PAYMENT_5 + result.PAYMENT_6 + result.PAYMENT_7;

				$("#title4_2Area").html("결제형태(결제완료건)(전체 : "+totalNum+"명)");
				
				// Script
				var chart = bb.generate({
					bindto: "#chart4_2Area",
					data: {
						x: "x",
						columns: [
							column1.toArray(),
							column2.toArray()
						],
						type: "bar"
					},
				  	
					axis: {
				    	x: {
				      		type: "category"
				    	}
				  	}
				});
				
				setChart5();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setChart5() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: chart5Url,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				var column1 = new ArrayList(["x","유아","초등","중등","고등","특수","기관","기타"]);
				var column2 = new ArrayList();
				var column3 = new ArrayList();
				var credits = "";
				
				if(result && result.length > 0) {
					for(var i=0; i<result.length; ++i) {
						var targetColumn = null;
						
						if(credits != result[i].CREDITS) {
							column2 = new ArrayList();
							column3 = new ArrayList();
							
							column2.add("이수자");
							column3.add("과락자");
							
							// 현재 credits를 저장
							credits = result[i].CREDITS;
						}
						
						targetColumn = result[i].PASS_YN == 'Y' ? column2 : column3;
						
						targetColumn.add(result[i].CNT1);
						targetColumn.add(result[i].CNT2);
						targetColumn.add(result[i].CNT3);
						targetColumn.add(result[i].CNT4);
						targetColumn.add(result[i].CNT5);
						targetColumn.add(result[i].CNT6);
						targetColumn.add(result[i].CNT7);
						
						if(i % 2 == 1) {
							$("#title5_"+parseInt(i/2+1)+"Area").html(result[i].CREDITS+"학점");

							// Script
							var chart = bb.generate({
								bindto: "#chart5_"+parseInt(i/2+1)+"Area",
								data: {
									x: "x",
									columns: [
										column1.toArray(),
										column2.toArray(),
										column3.toArray()
									],
									type: "bar"
								},
							  	
								axis: {
							    	x: {
							      		type: "category"
							    	}
							  	}
							});
						}
					}
				}
				
				//setChart6();
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	/** 이벤트 영역 **/
	// 검색 버튼 클릭 시
	$("#searchBtn").unbind("click").bind("click", function() {
		// 1페이지로 이동 시키고 검색 조건에 해당하는 검색
		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 선택해주세요.");
		} else {
			// 기수와 과정을 임시값에서 정상값으로 세팅 한다.
			$(":hidden[name='cardinal.id']").val($(":hidden[name='cardinalId']").val());
			
			setChart1();
		}
	});

	// 기수선택 버튼 클릭 시
	$(":text[name='cardinal.name']").unbind("click").bind("click", function() {
		// 기수선택 레이어 팝업
		var data = {"learnType" : $("select[name='cardinal.learnType']").val()};
		
		openLayerPopup("기수검색", "/admin/common/popup/cardinalList", data);
	});
	
	// 과정선택 버튼 클릭 시
	$(":text[name='course.name']").unbind("click").bind("click", function() {
		if(!$(":hidden[name='cardinalId']").val()) {
			alert("기수를 먼저 선택해야 합니다.");
		} else {
			// 과정선택 레이어 팝업
			var data = new Object();
			
			data.cardinalId = $(":hidden[name='cardinalId']").val();
			data.learnTypes = $("select[name='cardinal.learnType']").val();
			
			openLayerPopup("과정검색", "/admin/common/popup/courseList", data);
		}
	});
});

function setCardinal(cardinal) {
	// 임시저장
	$(":hidden[name='cardinalId']").val(cardinal.id);
	$(":text[name='cardinal.name']").val(cardinal.name);
	
	setCourse();
}

function setCourse(course) {
	// 임시저장
	$(":hidden[name='course.id']").val(course ? course.id : "");
	$(":text[name='course.name']").val(course ? course.name : "과정선택");
}

</script>

<div class="content_wraper">
	<h3>기수/과정별 통계</h3>
	<div class="tab_body">
		<!-- searchForm start -->
       	<form name="searchForm" method="post">
        	<input type="hidden" name="id" value="" />
        	<!-- pagingYn(페이징 처리 안함) -->
        	<input type="hidden" name="pagingYn" value='N' />

        	<!-- 값이 세팅 되야 리스트와 등록 할수 있음 임시 저장 후 search 했을 때 저장시킨다. -->
        	<input type="hidden" name="cardinalId" value='<c:out value="${search.cardinal.id}" default="" />' />	<!-- 임시저장 -->
        	<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
        	<input type="hidden" name="course.id" value='<c:out value="${search.course.id}" default="" />' />
        	
        	<!-- 직무연수 -->
			<select name="cardinal.learnType">
				<option value='J'>직무연수</option>
				<option value='G' <c:if test="${search.cardinal.learnType eq 'G'}">selected</c:if>>단체연수</option>
			</select>
			
			<!-- 기수 선택 -->
			<input type='text' name='cardinal.name' value='<c:out value="${search.cardinal.name}" default="기수선택" />' readonly="readonly" />
			
			<!-- 과정 선택 -->
			<input type='text' name='course.name' value='<c:out value="${search.course.name}" default="과정선택" />' readonly="readonly" />

			<button id='searchBtn' class="btn-primary" type="button">검색</button>
			<!-- <button id='' class="btn-danger" type="button">리셋</button> -->
		</form>
		<!-- //searchForm end -->
		
		<!-- 월단위별 추이분석(25개월) -->
		<h4>월단위별 추이분석(25개월)</h4>
		<div id="chart1Area"></div>
		
		<!-- 연수형태별 분석(수강인증건) -->
		<h4>연수형태별 분석(수강인증건)</h4>
		<div>
			<div id="title2_1Area" style="width: 50%; float: left; text-align: center;"></div>
			<div id="title2_2Area" style="width: 50%; float: left; text-align: center;"></div>
		</div>
		<div>
			<div id="chart2_1Area" style="width: 50%; float: left"></div>
			<div id="chart2_2Area" style="width: 50%; float: left"></div>
		</div>
		
		<!-- 최다접수과정 TOP10 -->
		<h4>과정 TOP5</h4>
		<div style="clear: both;">
			<div id="title3_1Area" style="width: 50%; float: left; text-align: center;"></div>
			<div id="title3_2Area" style="width: 50%; float: left; text-align: center;"></div>
		</div>
		<div>
			<div class="column w-fix" style="width: 49%; float: left">
				<div class="section box">
					<div class="section-header">
						<h5></h5>
						<p class="side-legend">(접수건수)</p>
					</div>
					<div id="chart3_1Area" class="section-body"></div>
				</div><!--//.section-->
			</div><!--//.column-body-->
			<div id="chart3_2Area" style="width: 49%; float: left"></div>
		</div>
		
		<!-- 연수형태별 분석(수강인증건) -->
		<div style="clear: both;"></div>
		<h4>이수 및 결제형태 분석</h4>
		<div style="clear: both;">
			<div id="title4_1Area" style="width: 50%; float: left; text-align: center;"></div>
			<div id="title4_2Area" style="width: 50%; float: left; text-align: center;"></div>
		</div>
		<div>
			<div id="chart4_1Area" style="width: 50%; float: left"></div>
			<div id="chart4_2Area" style="width: 50%; float: left"></div>
		</div>
		
		<!-- 학점별 이수율분석 -->
		<h4>학점별 이수율분석</h4>
		<div style="clear: both;">
			<div id="title5_1Area" style="width: 33%; float: left; text-align: center;"></div>
			<div id="title5_2Area" style="width: 33%; float: left; text-align: center;"></div>
			<div id="title5_3Area" style="width: 33%; float: left; text-align: center;"></div>
		</div>
		<div>
			<div id="chart5_1Area" style="width: 33%; float: left"></div>
			<div id="chart5_2Area" style="width: 33%; float: left"></div>
			<div id="chart5_3Area" style="width: 33%; float: left"></div>
		</div>
	</div>
</div>