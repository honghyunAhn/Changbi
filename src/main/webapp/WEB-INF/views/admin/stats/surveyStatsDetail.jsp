<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style type="text/css">
	div.bb-tooltip-container > table > tbody > tr > th {background-color:#aaa;}
</style>

<script type="text/javascript">
var refreshList = null;

$(document).ready(function() {
	// 한 화면으로 여러가지 타이틀을 구현할 경우
	var contentTitle = "";
	
	// url을 여기서 변경
	var surveyUrl = "<c:url value='/admin/stats/surveyStatsList' />";
	var listUrl = "<c:url value='/data/stats/surveyStatsDetail' />";
	
	/** 함수 영역 **/
	// 리스트 페이지 세팅(ajax 방식) 함수
	function setContentList() {
		// ajax 처리
		$.ajax({
			type	: "post",
			url		: listUrl,
			data 	: $("form[name='searchForm']").serialize(),
			success	: function(result) {
				if(result.list && result.list.length > 0) {
					var dataList = result.list;
					var chartId = "";

					$('.survey').children('p').text('총 응답자 수 ' + dataList[0].TOTAL_COUNT || '0' + '명');
					
					for(var i=0; i<dataList.length; ++i) {
						var dataInfo = dataList[i];

						// 1. 차트가 담길 골격을 생성한다.
						chartId = "surveychart"+i;
						$('.survey_item_list').append('<div id="'+chartId+'"></div>');
						
						// 2. 차트 데이터로 활용하기 위해 데이터 오브젝트를 유효성 검사하여 가공한다.
						//dataInfo = customData(dataInfo);
						
						// 3. 가공한 데이터를 기반으로 차트를 생성한다.
						drawChart(dataInfo, chartId);
					}
				}
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	}
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수설문관리", surveyUrl, $("form[name='searchForm']").serialize());
	});
	
	// 컨텐츠 타이틀 값 세팅
	$(".content_title").text(contentTitle);
	
	// 외부 함수에 내부 함수 연결
	refreshList = setContentList;
	
	// 처음 리스트 생성
	setContentList();
	
	// 기수 선택시
	$("select[name='cardinal.name']").on("change", function() {
		$(":hidden[name='cardinal.id']").val($(this).val());
		$(".survey_item_list").empty();
		setContentList();
	});
});

// 데이터 오브젝트의 유효성을 검증하고 불필요한 항목을 삭제 한다. ★사용안함★
function customData(data) {
	
	for (var i=1; i<8; i++) {
		if (eval('data.EXAM'+i) == '') {
			eval('delete data.EXAM'+i);
			eval('delete data.ANSWER'+i);
			eval('delete data.ANSWER'+i+'_PER');
		}
	}
	
	return data;
}

function drawChart(data, target) {
	var chart = bb.generate({
		title: {
		    text: data.SURVEY_ITEM_TITLE,
		  	position: "top-left"
	  	},
		data: {
			x : "x",
			columns: [
				["x", data.EXAM1, data.EXAM2, data.EXAM3, data.EXAM4, data.EXAM5, data.EXAM6, data.EXAM7],
				["응답율(%)", data.ANSWER1_PER, data.ANSWER2_PER, data.ANSWER3_PER, data.ANSWER4_PER, data.ANSWER5_PER, data.ANSWER6_PER, data.ANSWER7_PER]
			],
			type: "bar"
		},
		axis: {
		 	rotated: true,
		 	x: {
		 		type: "category"
		 	},
		 	y: {
	            min: 0,
	            max: 100,
	            padding : 10,
	            tick: {
	            	format: function(d) { return d+"%"; }
	            }
	        }
		},
		bar: {
	        width: {
	            max: 20
	        }
	    },
		interaction: {
			inputType: {
				touch: {
					preventDefault: true
				}
			}
		},
		bindto: '#'+target
	});
}
</script>

<div class="content_wraper">
	<h3 class="content_title"></h3>
	<div class="tab_body">
	   	<!-- searchForm start(리스트 이동 시 기존 검색 조건을 그대로 넘김) -->
		<form name="searchForm" method="post">
			<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
			<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
			<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="name" />' />
			<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />
			<input type='hidden' name='survey.id' value='<c:out value="${search.survey.id}" default="" />' />
			<input type='hidden' name='survey.surveyCode.code' value='<c:out value="${search.survey.surveyCode.code}" default="" />' />
			
			<!-- 기수 -->
			<input type="hidden" name="cardinal.id" value='<c:out value="${search.cardinal.id}" default="" />' />
		</form>
		<!-- //searchForm end -->
	
       	<form name="parentForm" method="post">
			<h4>연수설문정보</h4>
			<dl>
				<dt>등록일시</dt>
				<dd>
					<c:out value="${survey.regDate}" />
				</dd>
				
				<dt>설문제목</dt>
				<dd>
					<c:out value="${survey.title}" />
				</dd>
				<dt>게시상태</dt>
				<dd>
					<c:choose>
						<c:when test="${survey.useYn eq 'Y'}">서비스</c:when>
						<c:otherwise>보류</c:otherwise>
					</c:choose>
				</dd>
				<dt>안내머리글</dt>
				<dd>
					<c:out value="${survey.aLead}" />
				</dd>
				<dt>기수선택</dt>
				<dd>
					<c:choose>
						<c:when test="${empty cardinalList}">
							등록 된 기수정보가 없습니다.
						</c:when>
						<c:otherwise>
							<select name="cardinal.name">
								<option value="">전체</option>
								<c:forEach items="${cardinalList}" var="cardinal" varStatus="status">
									<option value='<c:out value="${cardinal.id}" />'><c:out value="${cardinal.name}" /></option>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
				</dd>
				<%-- <dt>포함기수코드</dt>
				<dd class="half">"src/main/webapp/WEB-INF/views/admin/stats/satisStatsGraph.jsp"
					<c:out value="${survey.concatCardinalId}" />
				</dd> --%>
			</dl>
		</form>
		<div>
			<a id="listBtn" class="btn align_left" href="javascript:void();">리스트</a>
		</div>
			
		<div class="survey">
			<h4>연수설문조사 통계</h4>
			<p style="padding-left:10px; font-weight:bold;">총 응답자수 0명</p>				
			<ul class="survey_item_list"></ul>
		</div>
	</div>
</div>
