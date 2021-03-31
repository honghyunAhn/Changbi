<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 검색영역 css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/project/admin/searchForm.css" />">
<script type="text/javascript">

	$(function() {
		
		if("${contentDetail.board_content_imp}"=="A1100"){
		$('input:checkbox[name="board_content_imp"]').prop("checked",true);
		}
		
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
		});

		//목록으로
		$("#boardManagerBtn").on("click", function() {
			$("#boardHiddenManagerForm").submit();
		});
	})
	var myApp = angular.module('myapp', []);
	myApp.controller('BoardController', [ '$scope', function($scope) {

		var boardJson = '${fileList }';
		$scope.boardFile = JSON.parse(boardJson);

		$scope.file_change = function(file) {
			var val = file.files[0].name;
			var size = file.files[0].size;

			if (val == "") {
				file.value = '';
				return;
			}
			if (!fileSizeCheck(size)) {
				file.value = '';
				alert("파일 사이즈는 10MB 까지 입니다.");
				return;
			}
		}

	} ]);

	function fileSizeCheck(size) {
		//10MB
		var maxSize = 10485760;
		var fileSize = Math.round(size);
		if (fileSize > maxSize) {
			return false;
		}
		return true;
	}

	function formCheck() {
		var title = $("#board_content_title").val();

		if (title.length == 0) {
			alert("제목을 입력해 주세요.");
			return false;
		}
		var check = confirm("수정하시겠습니까?");
		if (!check) {
			return false;
		}
		return true;
	}
</script>
<body id="myBody" ng-app="myapp" ng-controller="BoardController">
	<div id="page">
		<div class="page-inner">
			<div class="gtco-section border-bottom">
				<div class="gtco-container">
					<!-- ********************************************************************************************************** -->
					<div class="page_title">
						<h2>게시판의 게시물 수정</h2>
					</div>
					<div class="page_title">
						<h2>게시물 수정 페이지</h2>
						
					</div>
					<form action="/smp/admin/board/update" method="post"
						enctype="multipart/form-data" onsubmit="return formCheck();">
						<table class="board_view">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tbody>
							<tr>
							<th scope="row">중요공지(체크)</th>
							<td>
							 <input type="checkbox" name="board_content_imp"value="A1100">
							</td>
							<td colspan="2">
							</td>
							</tr>
								<tr>
									<th scope="row">조회수</th>
									<td>${contentDetail.board_content_hit }</td>
									<th scope="row">작성자</th>
									<td>${contentDetail.board_content_nm }</td>
								</tr>
								<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3">
										<div ng-repeat="i in [1,2,3]">
											<div ng-switch="!!boardFile[{{$index}}].board_file_origin">
												<div ng-switch-when="true">
													<input type="hidden"
														name="boardFileList[{{$index}}].board_file_origin"
														value="{{boardFile[$index].board_file_origin}}"> <input
														type="hidden"
														name="boardFileList[{{$index}}].board_file_saved"
														value="{{boardFile[$index].board_file_saved}}"> <a
														ng-href="/file_download?origin={{boardFile[$index].board_file_origin}}&saved={{boardFile[$index].board_file_saved}}&path=${path }">
														{{boardFile[$index].board_file_origin}} </a> <img
														class="x_icon"
														ng-click="boardFile[$index].board_file_origin=false"
														src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />"
														alt="" />
												</div>
												<div ng-switch-default>
													<input type="hidden"
														name="boardFileList[{{$index}}].board_file_saved"
														value="{{boardFile[$index].board_file_saved}}"> <input
														type="file" class="board_files"
														name="boardFileList[{{$index}}].board_file"
														onchange="angular.element(this).scope().file_change(this)">
												</div>
											</div>
										</div> <input type="hidden" name="boardFilePath" value="${path }">
										<input type="hidden" name="board_content_seq"
										value="${contentDetail.board_content_seq }">
									</td>
								</tr>
								<tr>
									<th scope="row">제목</th>
									<td colspan="3"><input type="text"
										name="board_content_title" id="board_content_title"
										value="${contentDetail.board_content_title }" /></td>
								</tr>
								<tr>
									<td colspan="4" class="view_text"><textarea
											id="board_content_ct" name="board_content_ct" rows="40"
											cols="60">${contentDetail.board_content_ct } </textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="boardManagerDiv">
							<input type="submit" id="boardUpdateBtn" value="수정하기" /> 
							<input	type="button" id="boardManagerBtn" value="목록으로" /> 
							<input	type="hidden" name="search_division" id="search_division"value="${search_division}" /> 
							<input type="hidden"name="search_type" id="search_type" value="${search_type}" />
						</div>
						<input type="hidden" name="board_gb" id="board_gb"	value="${boardGroup.board_gb}" /> 
						<input type="hidden"name="board_tp" id="board_tp" value="${boardGroup.board_tp}" /> 
						<input	type="hidden" name="board_nm" id="board_nm"	value="${boardGroup.board_nm}" />
						<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >
					</form>
					<form action="/smp/admin/board"
						id="boardHiddenManagerForm" method="get">
						<input type="hidden" name="search_division" id="search_division"value="${search_division}" /> 
						<input type="hidden"name="search_type" id="search_type" value="${search_type}" /> 
						<input	type="hidden" name="board_seq" id="board_seq"value="${contentDetail.board_seq}" /> 
						<input type="hidden"name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
						<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >
					</form>

					<!-- ************************************************************************************** -->

				</div>
			</div>
		</div>
	</div>
</body>
