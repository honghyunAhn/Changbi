<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
//일괄등록용 List
var chapList = [];
// url을 여기서 변경
var dataListUrl = "<c:url value='/data/course/subChapList' />";
var regUrl = "<c:url value='/data/course/chapterReg' />";
var newRegUrl = "<c:url value='/data/course/newChapterReg' />";
var delUrl = "<c:url value='/data/course/chapterDel' />";
var trainProcessListUrl = "<c:url value='/admin/course/trainProcessList' />";

$(document).ready(function() {
	
	// 페이지 리스트 이동
	$("#listBtn").unbind("click").bind("click", function() {
		// ajax로 load
		contentLoad("연수과정관리", trainProcessListUrl, $("form[name='searchForm']").serialize());
	});
	
	// 처음 리스트 생성
	setContentList();
	//이벤트 연결
	setBtnEvent();
	saveFunc();
});

//포팅 컨텐츠 세팅
function setContentList() {
	$.ajax({
		type	: "post",
		url		: dataListUrl,
		data 	: $("form[name='actionForm']").serialize(),
		success	: function(result) {
			chapList = result.list;
			console.log(chapList);
			//array 재정렬
			sortChapList();
			//페이지/목차 화면상 crud 를 위한 seq 정리
			modSeq();
			//화면상에 적용(#subChapList)
			setExcelContent(chapList);
		}
	});
}

//일괄등록 엑셀업로드
function uploadExcel() {
	var form = new FormData(document.getElementById('excelForm'));
	$.ajax({
		url : '<c:url value="/data/course/subChapxls" />'
		,dataType : "json"
		,data : form
		,processData : false
		,contentType : false
		,type : "post"
		,success : function(data) {
			chapList = data;
			$.each(chapList, function(index,item) {
				item.course_id = '${course.id}';
			});
			chapList.splice(0,1);
			setExcelContent(chapList);
		}
	});
}
//읽어온 엑셀 화면에 세팅
function setExcelContent(chapList) {
	var content = '';
	content += '<tr>';
	content += '<td>0</td>';
	content += '<td>0</td>';
	content += '<td></td>';
	content += '<td>${course.name}</td>';
	content += '<td></td>';
	content += '<td></td>';
	content += '<td style="padding-bottom: 11px;">';
	content += '<input type="button" class="addOcc" value="목차추가">  ';
	content += '</td>';
	if(chapList.length != 0) {
		$.each(chapList, function(index, item) {
			content += '<tr>';
			content += '<td>'+ (index +1) +'</td>';
			content += '<td>'+ item.occ_num +'</td>';
			if(item.depth != 3) {
				content += '<td></td>';
			} else {
				content += '<td>'+ item.order +'</td>';
			}
			content += '<td>'+ item.name +'</td>';
			if(item.filepath != null) {
				content += '<td>'+ item.filepath+'</td>';
			} else {
				content += '<td></td>';
			}
			content += '<td></td>';
			if(item.depth == 2) {
				content += '<td style="padding-bottom: 11px;">';
				content += '<input type="button" class="addPage" value="페이지추가">  ';
				content += '<input type="button" class="mod" value="관리">';
				content += '</td>';
			} else if(item.depth == 3){
				content += '<td style="padding-bottom: 11px;">';
				content += '<input type="button" class="mod" value="관리">';
				content += '</td>';
			}
			content += '</tr>';
		});
	}
	$('#subChapList').html(content);
	setBtnEvent();
}
//화면구성 후 이벤트 연결
function setBtnEvent() {
	
	var obj;
	var data;
	var seq;
	
	//목차 추가
	$('input.addOcc').on('click', function() {
		var curOcc_num;
		
		//현재 최대 차시 값
		//차시가 없는 경우
		if(chapList.length == 0) curOcc_num = 0;
		//차시가 있는 경우
		else curOcc_num = chapList[chapList.length -1].occ_num;
		
		data = {"occ_num" : curOcc_num, "seq":seq};
		openLayerPopup('목차 추가', '/admin/common/popup/addSubChapOcc', data);
	});
	//페이지 추가
	$('input.addPage').on('click', function() {
		
		var depth;
		var occ_num = parseInt($(this).closest('tr').find('td:eq(1)').text());
		var curOrder_num;
		
		var temp = [];
		$.each(chapList, function(index,item) {
			if(item.occ_num == occ_num) temp.push(item);
		});
		if(temp.length == 1) {
			depth = 2;
			curOrder_num = occ_num;
		}
		else curOrder_num = temp[temp.length-1].order;

		seq = temp[temp.length-1].seq;
		data = {"order" : curOrder_num, "occ_num" : occ_num, "seq":seq, "depth" : depth};
		
		openLayerPopup('페이지 추가', '/admin/common/popup/addSubChapPage', data);
	});
	//관리
	$('input.mod').on('click', function() {
		var index = parseInt($(this).closest('tr').find('td:eq(0)').text())-1;
		var curVal = chapList[index];
		var data = {"chap_id" : curVal.chap_id, "content_type" : curVal.content_type, "course_id" : curVal.course_id, "depth" : curVal.depth, "filepath" : curVal.filepath, "mo_filepath" : curVal.mo_filepath, "name" : curVal.name, "occ_num" : curVal.occ_num, "order":curVal.order, "seq" : curVal.seq}
		if(curVal.depth == 1 || curVal.depth == 2) {
			openLayerPopup('목차 관리', '/admin/common/popup/addSubChapOcc', data);
		} else {
			openLayerPopup('페이지 관리', '/admin/common/popup/addSubChapPage', data);
		}
	});
}
//추가(목차, 페이지 일괄처리)
function addChapList(index, obj, addType) {
// 	레이어 팝업은 팝업이 아니라 레이어를 띄운것이기 때문에 window로 주고받을 수 없음
	var newChap;
	
	if(addType == 1) {
	//목차 추가일 경우
		newChap = new Object();
	
		newChap.seq = 0;
		newChap.chap_id = 0;
		newChap.occ_num = obj.occ_num;
		newChap.name = obj.name;
		newChap.filepath = null;
		newChap.depth = 2;
		newChap.order = obj.occ_num;
		newChap.content_type = null;
		newChap.course_id = '${course.id}';
		
		chapList.push(newChap);
		setExcelContent(chapList);
	} else if(addType == 2) {
	//페이지 추가일 경우
		newChap = new Object();
	
		newChap.seq = 0;
		newChap.chap_id = 0;
		newChap.occ_num = obj.occ_num;
		newChap.name = obj.name;
		newChap.filepath = obj.filepath;
		newChap.depth = 3;
		newChap.order = obj.order;
		newChap.content_type = obj.content_type;
		newChap.course_id = '${course.id}';
		
		chapList.splice(obj.seq,0,newChap);
		setExcelContent(chapList);
	} else if(addType == 3){
	//관리일 경우
		$.each(chapList, function(index, item) {
			if(item.seq == obj.seq) {
				if(Object.keys(obj).length > 3) {
					item.occ_num = obj.occ_num;
					item.order = obj.order;
					item.name = obj.name;
					item.filepath = obj.filepath;
					item.content_type = obj.content_type;
				} else {
					item.occ_num = obj.occ_num;
					item.name = obj.name;
				}
			}
		});
	}
	sortChapList();
	modSeq();
	setExcelContent(chapList);
}
//페이지 삭제
function delPage(seq) {
	delFunc(seq,1);
	chapList.splice(seq-1, 1);
	alert("삭제완료되었습니다.");
	modSeq();
	setExcelContent(chapList);
}
//목차 삭제
function delChap(seq) {
	//바로 뒤가 목차이거나 자신이 마지막 목차인 경우 본인만 삭제
	if(seq == chapList.length || chapList[seq].depth == 2) {
		delFunc(seq,2);
		chapList.splice(seq-1, 1);
		
	} else {
	//하위 페이지가 있는 경우 하위 페이지까지 전부 삭제
		if(confirm('하위 페이지가 있는 경우, 하위 페이지까지 모두 삭제됩니다. 진행하시겠습니까?')) {
			
			var occ_num = chapList[seq-1].occ_num;
			var delLen =0;
			var delPageList = [];
			
			$.each(chapList, function(index,item) {
				if(item.occ_num == occ_num) {
					delPageList.push(item);
					delLen ++;
				}
			});
			delFunc(seq,2);
			$.each(delPageList, function(index, item) {
				delFunc(item.seq,1);
			});
			chapList.splice(seq-1, delLen);
		}
	}
	alert("삭제완료되었습니다.");
	sortChapList();
	modSeq();
	setExcelContent(chapList);
}
//DB상에서 삭제
function delFunc(seq,delType) {
	if(delType == 1) {
		$.ajax({
			url : '<c:url value="/data/course/delSubPage" />'
			,data : chapList[seq-1]
			,async : false
			,type : "post"
			,success : function(data) {
			}
		});
	}
	else if(delType == 2) {
		$.ajax({
			url : '<c:url value="/data/course/delSubChap" />'
			,data : chapList[seq-1]
			,async : false
			,type : "post"
			,success : function(data) {
			}
		});
	}
}
//화면작업을 위한 seq 조정(페이지 추가, 삭제시)
function modSeq() {
	$.each(chapList, function(index,item) {
		item.seq = index + 1;
	})
}
//재정렬
function sortChapList() {
	//차시
	chapList.sort(function(a,b) {
		if(a.occ_num > b.occ_num) return 1;
		if(a.occ_num < b.occ_num) return -1;
		return 0;
	});
	//페이지
	chapList.sort(function(a,b) {
		if(a.occ_num == b.occ_num) {
			if(a.order > b.order) return 1;
			if(a.order < b.order) return -1;
			return 0;
		}
	});
}

//챕터리스트 일괄등록
/* 일괄등록이 돌아가는 방식:
	전체 챕터를 지워버리고(cb_chapter) 다시 등록함 */
function saveFunc() {
	$('#saveBtn').on('click', function(index, item) {
		if(chapList.length == 0) {
			var obj = new Object();
			obj.course_id = '${course.id}';
			chapList.push(obj);
		}
		if(confirm('등록하시겠습니까?')) {
			$.ajax({
				url : '<c:url value="/data/course/insertChap" />'
				,dataType: 'json'
                ,contentType: 'application/json'
				,data : JSON.stringify(chapList)
				,type : 'post'
				,success : function(data) {
					if(data) {
						alert('저장되었습니다.');
						setContentList();
					} 
					else {
						alert('저장에 실패했습니다');
						return false;
					}
				}
			});
		}
	});
}
//목차 샘플 엑셀 수정
</script>

<div class="content_wraper">
	<h3>세부차시관리</h3>
	<!-- searchForm start -->
   	<form name="searchForm" method="post">
   		<!-- 조회조건(리스트 페이지로 이동 시 사용) -->
		<input type='hidden' name='pageNo' value='<c:out value="${search.pageNo}" default="1" />' />
		<input type='hidden' name='searchCondition' value='<c:out value="${search.searchCondition}" default="all" />' />
		<input type='hidden' name='searchKeyword' value='<c:out value="${search.searchKeyword}" default="" />' />		 
		<input type='hidden' name='courseCode.code' value='<c:out value="${search.courseCode.code}" default="" />' />
		<input type='hidden' name='company.id' value='<c:out value="${search.company.id}" default="" />' />
	</form>
	<!-- //searchForm end -->
	<div class="searchForm">
		<form name="actionForm" method="post">
			<input type='hidden' id="insertid" name='id' value='0' />
			<input type="hidden" name="course.id" value="<c:out value="${course.id}" default="" />" />
			<input type="hidden" name="serviceType" value="P" />
		</form>
		<dl style="margin-bottom: 10px;">
			<dt>모바일서비스</dt>
			<dd class="half">
				<c:choose>
					<c:when test="${course.mobileYn eq 'Y'}">모바일 서비스 지원</c:when>
					<c:otherwise>모바일 서비스 안함</c:otherwise>
				</c:choose>
			</dd>
			<dt>과정명</dt>
			<dd class="half">
				<c:out value="${course.name}" default="" />
			</dd>
			<dt style="display: flex; align-items: center;">목차일괄등록</dt>
			<dd>
				<div style="display: flex; justify-content: flex-start; align-items: center;">
					<form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data" style="width: 90%; padding-bottom: 17px;">
						<input type="file" id="fileInput" name="fileInput">
					</form>
					<input type="button" value="엑셀업로드" onclick="uploadExcel()">
				</div>
			</dd>
			<dt>목차샘플 다운로드</dt>
			<dd>
				<a href="/forFaith/file/file_download?origin=SES목차등록샘플_포팅.xlsx&saved=portGuide.xlsx&path=uploadImage">SES목차등록샘플_포팅.xls</a>
				<div hidden="hidden" id="sampleFileDiv">
					<form id="sampleForm" name="sampleForm" method="post" enctype="multipart/form-data">
						<input type="file" id="sampleFileInput" name="sampleFileInput">
					</form>
				</div>
			</dd>
		</dl>
	</div>
	<div class="tab">
		<ul class="tab_head">
			<li><a href="javascript:void(0)" class="tablink on">컨텐츠 관리 기능</a></li>
		</ul>
	</div>
	<br>
	<table style="border-collapse: collapse; table-layout:fixed;" id="portTable">
		<thead>
			<tr>
				<th style='width: 50px;'>순번</th>
				<th style='width: 50px;'>차시</th>
				<th style='width: 50px;'>페이지순서</th>
				<th>목차명</th>
				<th>PC파일경로</th>
				<th>모바일파일경로</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody id="subChapList">
		</tbody>
	</table>
	<br>
	<div>
		<div id="listBtnDiv" style="float: left; padding-right: 6px;">
			<a id="listBtn" class="btn align_right primary" href="javascript:void(0);">리스트</a>
		</div>
		<div id="savBtnDiv">
			<a id="saveBtn" class="btn align_right danger" href="javascript:void(0);">저장</a>
		</div>
	</div>
</div>
