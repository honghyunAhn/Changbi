function makeAttachFile(fileObject) {
	if(fileObject && fileObject.length > 0) {
		// 파일 업로드 기능
		for(var i=0; i<fileObject.length; ++i) {
			fileObject[i].index = i;
			
			var attachFile = new AttachFile(fileObject[i]);
			
			attachFile.init();
		}
	}
}

// file object
function AttachFile(option) {
	this.option = {
			area			: $(".attach_file_area").eq(0),											// 파일 업로드가 진행 된 영역
			fileIndex		: option && option.index ? option.index : 0,							// 파일 업로드가 진행 되는 index	
			maxSize			: option && option.maxSize ? option.maxSize : 10,						// 한 파일 당 사이즈(Mbyte) default 10M
			maxTotalSize	: option && option.maxTotalSize ? option.maxTotalSize : 50,				// 전체 파일 당 사이즈(Mbyte) default 50M
			maxCount		: option && option.maxCount ? option.maxCount : 10,						// 전체 파일 업로드 수
			accept			: option && option.accept ? option.accept : 'all',						// 설정하지 않으면 전체 업로드
			callback		: option && option.callback ? option.callback : ''						// 파일 업로드 후 호출 되는 함수.
	}
}

AttachFile.prototype.init = function() {
	// 파일 위치 index
	this.option.area = $(".attach_file_area").eq(this.option.fileIndex);
	
	// upload button event
	uploadFileEvent(this.option);
	
	// delete button event
	deleteFileEvent(this.option);
	
	// 이미지 view event
	imageViewEvent(this.option);
};

AttachFile.prototype.download = function(no) {
	var f = document.formList;
  
	f.cmd.value = "download";
	f.no.value = no;
  
	f.target = "_blank";
	f.submit();
  
	return false;
};

// file upload button event
function uploadFileEvent(option) {
	// 이벤트 안에서는 this를 사용하지 못함.
	var area			= option.area;				// attach_file_area 위치
	var idx				= option.fileIndex;			// 파일 업로드 index
	var maxSize			= option.maxSize;			// 1개 파일 크기
	var maxTotalSize	= option.maxTotalSize;		// 토탈 파일 크기
	var maxCount		= option.maxCount;			// 토탈 업로드 파일 갯수
	var accept			= option.accept;			// 업로드 파일 종류
	var callback		= option.callback;			// 파일 업로드 후 호출 되는 함수
	
	// 파일 업로드 버튼 이벤트 적용
	option.area.find(':button.file_upload_btn').unbind("click").bind("click", function() {
		var fileId			= area.find(":hidden.attach_file_id").val() ? area.find(":hidden.attach_file_id").val() : "" ;				// 파일 ID
		var uploadDir		= area.find(":hidden.upload_dir").val() ? area.find(":hidden.upload_dir").val() : "/resources/upload";		// 업로드 경로
		var fixFileName		= area.find(":hidden.fix_file_name").val() ? area.find(":hidden.fix_file_name").val() : "";					// 고정시킬 파일명
		var removeFileName	= area.find(":hidden.remove_file_name").val() ? area.find(":hidden.remove_file_name").val() : "";			// 파일 업로드 시  삭제시킬 파일명
		var uploadCount	= 0;											// 이미 업로드 된 갯수
		var uploadSize	= 0;											// 이미 업로드 된 사이즈

		area.find(":hidden.attach_file_size").each(function() {
			if($(this).val() > 0) {
				uploadSize += parseInt($(this).val());
				++uploadCount;
			}
		});
		
		// 기본적인 파일 정보
		var queryString = "fileId="+fileId+"&uploadDir="+uploadDir+"&fixFileName="+fixFileName+"&removeFileName="+removeFileName+"&uploadCount="+uploadCount+"&uploadSize="+uploadSize;
		// 업로드 옵션
		queryString	   += "&fileIndex="+idx+"&maxSize="+maxSize+"&maxTotalSize="+maxTotalSize+"&maxCount="+maxCount+"&accept="+accept;
		queryString	   += "&callback="+callback;

		var url			= "/forFaith/file/fileUploadPopup?"+queryString;
		var name		= "upload_file_"+idx;
		var properties	= "left=300, top=200, width=403, height=359, scrollbars=yes, location=no, status=0, resizable=yes";
		
		openWindow(url, name, properties);
	});
};

// file delete button event
function deleteFileEvent(option) {
	// 파일 이름 클릭 시 삭제 기능
	option.area.find(".attach_file_del_btn").unbind("click").bind("click", function() {
		var attachFile = new Object();

		attachFile.detailList = new Array();
		
		attachFile.fileId	= $(":hidden.attach_file_id").eq(option.fileIndex).val();
		
		// 갯수만큼 더한다?
		for(var i=0; i<1; ++i) {
			var attachFileDetail = new Object();
			
			attachFileDetail.fileName		= $(this).siblings(":hidden.attach_file_name").val();
			attachFileDetail.filePath		= $(this).siblings(":hidden.attach_file_path").val();
			attachFileDetail.originFileName	= $(this).siblings(":hidden.attach_origin_file_name").val();
			
			attachFile.detailList[i] = attachFileDetail;
		}
		
		attachFileDel(attachFile, $(this).parents(".file_info_area"));
	});
};

// image click event
function imageViewEvent(option) {
	option.area.find(".image_view img").unbind("click").bind("click", function(event) {
		event.preventDefault();
		
		var srcUrl = $(this).attr("src");
		
		$('#imagePreviewModal img.modalImgPreview').attr('src', srcUrl);
		
		$('#imagePreviewModal').addClass("in");
		$('#imagePreviewModal').css("display", "block");
		$('#imagePreviewModal').after("<div class='modal-backdrop fade in'></div>");
		
		// 이미지 뷰 삭제 이벤트
		$('#imagePreviewModal').find(":button").bind("click", imageViewClose);
	});
}

function imageViewClose() {
	// 삭제 이벤트 초기화
	$('#imagePreviewModal').find(":button").unbind("click");
	
	// 이미지 뷰 삭제
	$('#imagePreviewModal').removeClass("in");
	$('#imagePreviewModal').css("display", "");
	$('.modal-backdrop').remove();
}

// file delete
function attachFileDel(file, fileInfoArea) {
	if(!file.fileId) {
		alert("파일이 생성되지 않았습니다.");
	} else {
		if(confirm("파일을 삭제하시겠습니까?\n파일 삭제를 하시면 실제 파일이 삭제가 됩니다.")) {
			jQuery.ajax({
				url			: "/forFaith/file/attachFileDel",
				type		: "post",
				dataType	: "json",
				data		: JSON.stringify(file),
				contentType : "application/json; charset=UTF-8",
				success		: function(result) {
					if(result > 0) {
						fileInfoArea.remove();
					} else {
						alert("파일 삭제 실패!!")
					}
				},
				error		: function(request, status, error) {
					alert("error[olle] ===> "+error);
				}
			});
		}
	}
};

// after file upload process
function setAttachFile(fileIndex, accept, fileList, callback) {
	var sb = new StringBuilder();
	
	// 파일 영역 과 index를 지정해준다.
	var option	= new Object();
	
	// 처리 결과
	var result = false;
	
	// 파일 wrap 영역지정
	option.area	= $(".attach_file_area").eq(fileIndex);
	// 파일 wrap index
	option.fileIndex = fileIndex;
	// callback 함수 등록
	option.callback = callback;

	if(fileList != null && fileList.size() > 0) {
		var attachFile	= fileList.get(0);

		if(attachFile.fileId) {
			var urlPath = attachFile.detailList[0].urlPath;
			
			// FileID가 없거나 0이면 생성 된 fileId로 설정함.
			if(!$(":hidden.attach_file_id").eq(fileIndex).val()) {
				$(":hidden.attach_file_id").eq(fileIndex).val(attachFile.fileId);
			}

			for(var i=0; i<fileList.size(); ++i) {
				attachFile = fileList.get(i);
				
				if(attachFile.detailList != null && attachFile.detailList.length > 0) {
					for(var j=0; j<attachFile.detailList.length; ++j) {
						var file = attachFile.detailList[j];
						
						sb.Append("<div class='file_info_area' style='float: left;'>");

						if(accept == 'image') {
							sb.Append("<div class='image_view' style='padding-left: 5px; padding-top: 5px;'>");
							sb.Append("<img style='width: 200px; height: 200px; cursor: pointer;' src='"+file.urlPath+"' />");
							sb.Append("</div>");
						} else if(accept == 'video') {
							sb.Append("<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>");
							sb.Append("<input type='button' value='"+file.originFileName+"' style='width: 200px; height: 30px;' />");
							sb.Append("</div>");
						} else if(accept == 'audio') {
							sb.Append("<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>");
							sb.Append("<input type='button' value='"+file.originFileName+"' style='width: 200px; height: 30px;' />");
							sb.Append("</div>");
						} else {
							sb.Append("<div class='file_view' style='padding-left: 5px; padding-top: 5px;'>");
							sb.Append("<input type='button' value='"+file.originFileName+"' style='width: 200px; height: 30px;' />");
							sb.Append("</div>");
						}
						
						sb.Append("<div class='file_info' style='padding-left: 5px;'>");
						sb.Append("<input type='hidden' class='attach_file_name' 		value='"+file.fileName+"' />");
						sb.Append("<input type='hidden' class='attach_file_path'		value='"+file.filePath+"' />");
						sb.Append("<input type='hidden' class='attach_file_size'		value='"+(file.fileSize ? file.fileSize : 0)+"' />");
						sb.Append("<input type='hidden'	class='attach_origin_file_name'	value='"+file.originFileName+"' />");
						sb.Append("<input type='hidden'	class='attach_url_path'			value='"+file.urlPath+"' />");
						sb.Append("<input type='button' class='attach_file_del_btn'		value='삭제' style='width: 200px; height: 30px;' />");
						sb.Append("</div>");
						sb.Append("</div>");
					}
				}
			}
			
			$(".attach_file_area").eq(fileIndex).append(sb.ToString());
			
			// 삭제 이벤트를 다시 걸어준다.
			deleteFileEvent(option);
			// 이미지 뷰 이벤트 다시 걸기
			imageViewEvent(option);
			
			result = true;
			
			// 콜백함수 호출해준다.
			if(callback) {
				eval(callback)(urlPath);
			}
		} else {
			alert("파일 저장 시 오류");
		}
	}
	
	return result;
};

/* preview Image */
function previewImage(inputFile, opt) {
	var defaultOpt = {
		inputFile: inputFile,
		img: null,
		w: 200,
		h: 200
	};
	
	$.extend(defaultOpt, opt);
		
    if (!defaultOpt.inputFile || !defaultOpt.img) {
    	return;
    }
 
    var inputFile = defaultOpt.inputFile.get(0);
    var img       = defaultOpt.img.get(0);
 
        // FileReader
    if (window.FileReader) {
        // image file
        if (!inputFile.files[0].type.match(/image\//)) {
        	alert("이미지 파일만 업로드 가능합니다.");
            return;
        }
 
        // preview
        try {
            var reader = new FileReader();
            reader.onload = function(e) {
                img.src = e.target.result;
                img.style.width  = defaultOpt.w+'px';
                img.style.height = defaultOpt.h+'px';
                img.style.display = '';
            };
            
            reader.readAsDataURL(inputFile.files[0]);
        } catch (e) {
            // exception...
        }
    // img.filters (MSIE)
    } else if (img.filters) {
    	inputFile.select();
    	inputFile.blur();
    	var imgSrc = document.selection.createRange().text;
 
    	img.style.width  = defaultOpt.w+'px';
        img.style.height = defaultOpt.h+'px';
        img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";            
        img.style.display = '';
    // no support
    } else {
        // Safari5, ...
    }
	 
	/* size check
	var nMaxSize = 4 * 1024 * 1024; // 4 MB
	var nFileSize = objFile.files[0].size;

	if (nFileSize > nMaxSize) {
		alert(4MB보다 큼!!\n" + nFileSize + " byte");
	} else {
		alert("4MB보다 작음!!\n" + nFileSize + " byte");
	} 
	*/
	 
	/* ext check
	var strFilePath = objFile.value;	 

	var RegExtFilter = /\.(zip)$/i;
	if (strFilePath.match(RegExtFilter) == null) alert("허용하지 않는 확장자 (1)");
	if (RegExtFilter.test(strFilePath) == false) alert("허용하지 않는 확장자 (2)");	 

	// inArray
	var strExt = strFilePath.split('.').pop().toLowerCase();
	if ($.inArray(strExt, ["zip"]) == -1) {
		alert("허용하지 않는 확장자 (3)");
		objFile.outerHTML = objFile.outerHTML;
	}
	*/
};

//이미지 파일 미리 보기 파일 변경 시 처리(미리보기 기능)
/*$("#typicalImage").bind("change", function(event) {
	var inputFile = null;
	
	var opt = {
		imgArea: $("#typicalImagePreviewArea"),
		width: 200,
		previewHeight: 200,
		fileNameHeight: 20,
		paddingLeft: 5,
		paddingTop: 5
	};
	var defaultOpt = {
		inputFile: event.target,
		imgArea: null,
		width: 200,
		previewHeight: 200,
		fileNameHeight: 20,
		paddingLeft: 5,
		paddingTop: 5
	};
	
	$.extend(defaultOpt, opt);
	
    if (!defaultOpt.inputFile || !defaultOpt.imgArea) {
    	return false;
    }

    inputFile = defaultOpt.inputFile;

    // FileReader
    if (window.FileReader) {
    	if(inputFile.files.length > 0) {
    		var count = 0;
    		
        	// image file
            for(var i=0; i<inputFile.files.length; ++i) {
            	var file = inputFile.files[i];
            	
            	if (!file.type.match(/image\//)) {
                	// 파일 업로드 시 파일에 업로드 하려면 업로드 하려던 데이터가 남아버리기 때문에 이전 데이터는 지워줘야함.
                	inputFile.value = "";
                	$(".typicalImageArea").remove();
                	
                	alert("이미지 파일만 업로드 가능합니다. 다시 선택해 주세요.");
                	
                	return false;
                }
            }

        	// preview
            try {
            	var fileReader = new FileReader();
            	var file = inputFile.files[count];
            	
            	// 먼저 이전 파일 미리보기 삭제 시킴
               	$(".typicalImageArea").remove();
            	
            	if(file) {
               		fileReader.readAsDataURL(file);
            	}
            	
            	fileReader.onload = function(e) {
                	var sb = new StringBuilder();
                	
                	sb.Append("<div class='typicalImageArea' style='width: "+(defaultOpt.width+defaultOpt.paddingLeft)+"px; height: "+(defaultOpt.previewHeight+defaultOpt.fileNameHeight+defaultOpt.paddingTop)+"px; float: left;'>");
                	sb.Append("<div class='typicalImagePreview' style='width: "+defaultOpt.width+"px; height: "+defaultOpt.previewHeight+"px; padding-left: "+defaultOpt.paddingLeft+"px; padding-top: "+defaultOpt.paddingTop+"px;'>");
                	sb.Append("<img style='width: "+defaultOpt.width+"px; height: "+defaultOpt.previewHeight+"px;' src='"+e.target.result+"' />");
					sb.Append("</div>");
					sb.Append("<div class='typicalImageOriginName' style='width: "+defaultOpt.width+"px; height: "+defaultOpt.fileNameHeight+"px; padding-left: "+defaultOpt.paddingLeft+"px;'>");
					sb.Append("<input type='text' style='width: "+defaultOpt.width+"px; height: "+defaultOpt.fileNameHeight+"px; border: 0;' value='"+file.name+"' readonly='readonly' />");
					sb.Append("</div>");
					sb.Append("</div>");
					
					defaultOpt.imgArea.append(sb.ToString());
					
					file = inputFile.files[++count];
					
					if(file) {
	               		fileReader.readAsDataURL(file);
	            	}
                };
            } catch (e) {
                // exception...
            }
    	}
    // img.filters (MSIE)
    } else if (img.filters) {
        inputFile.select();
        inputFile.blur();
        var imgSrc = document.selection.createRange().text;

        img.style.width  = defaultOpt.w+'px';
        img.style.height = defaultOpt.h+'px';
        img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";            
        img.style.display = '';
    // no support
    } else {
        // Safari5, ...
    }
	 
	// 사이즈 체크
	var nMaxSize = 4 * 1024 * 1024; // 4 MB
	var nFileSize = objFile.files[0].size;

	if (nFileSize > nMaxSize) {
		alert("4MB보다 큼!!\n" + nFileSize + " byte");
	} else {
		alert("4MB보다 작음!!\n" + nFileSize + " byte");
	} 
	
	 
	// 확장자 체크
	var strFilePath = objFile.value;	 

	// 정규식
	var RegExtFilter = /\.(zip)$/i;
	if (strFilePath.match(RegExtFilter) == null) alert("허용하지 않는 확장자 (1)");
	if (RegExtFilter.test(strFilePath) == false) alert("허용하지 않는 확장자 (2)");	 

	// inArray
	var strExt = strFilePath.split('.').pop().toLowerCase();
	if ($.inArray(strExt, ["zip"]) == -1) {
		alert("허용하지 않는 확장자 (3)");
		objFile.outerHTML = objFile.outerHTML;
	}
	
});*/