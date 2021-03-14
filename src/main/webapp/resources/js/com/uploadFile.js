var bSupportDragAndDropAPI = false;

var bAttachEvent	= false;
var bDragArea		= null;

var nFileInfoCnt	= 0;					// file 정보 갯수
var htFileInfo		= [];					// file 정보 저장
	
var nTotalSize		= 0;					// 한번에 업로드 된 파일 사이즈
var nMaxSize		= 10*1024*1024;			// 한 파일 당 upload 사이즈
var nMaxTotalSize	= 50*1024*1024;			// 전체 업로드 파일 사이즈
var nMaxCount		= 10;					// 전체 업로드 수
var nFileCount		= 0;					// 한번에 업로드 된 갯수

var nUploadSize		= 0;					// 현재 업로드 된 사이즈
var nUploadCount	= 0;					// 현재 업로드 된 갯수

var imageFilter		= /^(image\/bmp|image\/gif|image\/jpg|image\/jpeg|image\/png)$/i;  
var imageFilter2	= /^(bmp|gif|jpg|jpeg|png)$/i;
var videoFilter		= /^(video\/mp4|video\/avi|video\/wmv|video\/x-ms-wmv|audio\/mp3)$/i;
var audioFilter		= /^(audio\/mp3)$/i;

// 업로드 객체 정의
var pop_container	= getElement("pop_container");
var pop_container2	= getElement("pop_container2");
var guide_text		= getElement("guide_text");
var btn_confirm		= getElement("btn_confirm");
var btn_cancel		= getElement("btn_cancel");
var drag_area		= getElement("drag_area");
var file_id			= getElement("file_id");
var drop_area		= getElement("drop_area");
var elTotalSizeTxt	= getElement("totalSizeTxt");
var elCountTxtTxt	= getElement("imageCountTxt");
var uploadDir		= getElement("upload_dir");
var fixFileName		= getElement("fix_file_name");
var removeFileName	= getElement("remove_file_name");
var accept			= getElement("accept");				// all : 전체, image : 이미지, excel : 엑셀, video : 비디오등
var maxSize			= getElement("max_size");
var maxTotalSize	= getElement("max_total_size");
var maxCount		= getElement("max_count");
var uploadSize		= getElement("upload_size");
var uploadCount		= getElement("upload_count");

// 파일 저장 후 받은 정보 저장
var fileList = new ArrayList();

$(function() {
	nMaxSize		= parseInt($(maxSize).val() ? $(maxSize).val() : 0)*1024*1024;				// 한 파일 당 upload 사이즈
	nMaxTotalSize	= parseInt($(maxTotalSize).val() ? $(maxTotalSize).val() : 0)*1024*1024;	// 전체 업로드 파일 사이즈
	nMaxCount		= parseInt($(maxCount).val() ? $(maxCount).val() : 0);						// 전체 업로드 수
	
	nUploadSize		= parseInt($(uploadSize).val() ? $(uploadSize).val() : 0);					// 이미 업로드 된 파일 크기
	nUploadCount	= parseInt($(uploadCount).val() ? $(uploadCount).val() : 0);				// 이미 업로드 된 파이 갯수
	
	checkDragAndDropAPI();								// html 5에서만 drag 가능 체크

	if(bSupportDragAndDropAPI){
		// html 5에서 dragAndDrop 기능 가능 시
		$(pop_container2).hide();
		$(pop_container).show();
			
		$(guide_text).removeClass("nobg");
		$(guide_text).addClass("bg");
		
		// 업로드 된 갯수와 사이즈가 최대 보다 작을 경우 이벤트 활성화 시킴 
		addDragAndDropEvent();
	} else {
		$(pop_container).hide();
		$(pop_container2).show();
	}
	
	$(btn_confirm).bind("click", uploadFile);
	$(btn_cancel).bind("click", closeWindow);
});

// ID로 객체 생성(무조건 ID로 사용함)
function getElement(id) {
	return document.getElementById(id);
}

// html 5에서만 drag 가능 체크
function checkDragAndDropAPI() {
	var oNavigator = makeNavigator();
	
	try {
		if(!oNavigator.ie){
			if(!!oNavigator.safari && oNavigator.version <= 5){
				bSupportDragAndDropAPI = false;
			}else{
				bSupportDragAndDropAPI = true;
			}
		}
	} catch(e) {
		bSupportDragAndDropAPI = false;
	}
	
	return bSupportDragAndDropAPI;
}

// 익스플로우 종류와 버젼을 가지고 온다.
function makeNavigator() {
	var userAgent = navigator.userAgent;
	var appVersion = navigator.appVersion;
	
	var oNavigator = new Object();

	if (/MSIE/.test(userAgent)) {
		oNavigator.ie = true;
		oNavigator.version = /MSIE ([\d\.]+)\;/.exec(appVersion)[1];
	} else if(/Chrome/.test(userAgent)) {
		oNavigator.chrome = true;
		oNavigator.version = /Chrome\/([\d\.]+) Safari/.exec(appVersion)[1];
	} else if (/Firefox/.test(userAgent)) {
		oNavigator.firefox = true;
		oNavigator.version = /Firefox\/([\d\.]+)/.exec(appVersion)[1];
	} else if (/Safari/.test(userAgent)) {
		oNavigator.safari = true;
		oNavigator.version = /Version\/([\d\.]+) Safari/.exec(navigator.appVersion)[1];
	}
	
	return oNavigator;
}

// 파일 업로드 지역(drag지역)에서 drag drop 이벤트 적용
function addDragAndDropEvent() {
	bAttachEvent = true;
	
	drag_area.addEventListener("dragenter", dragEnter, false);
	drag_area.addEventListener("dragexit", dragExit, false);
	drag_area.addEventListener("dragover", dragOver, false);
	drag_area.addEventListener("drop", drop, false);
}

//파일 업로드 지역(drag지역)에서 drag drop 이벤트 삭제
function removeDragAndDropEvent(){
	bAttachEvent = false;
	
	drag_area.removeEventListener("dragenter", dragEnter, false);
	drag_area.removeEventListener("dragexit", dragExit, false);
	drag_area.removeEventListener("dragover", dragOver, false);
	drag_area.removeEventListener("drop", drop, false);	
}

//이벤트 핸들러 할당(drag 지역 enter 시)
function dragEnter(ev) {
	ev.stopPropagation();
	ev.preventDefault();
}
//이벤트 핸들러 할당(drag 지역 exit 시)
function dragExit(ev) {
 	ev.stopPropagation();
 	ev.preventDefault();
}
//이벤트 핸들러 할당(drag 지역 over 시)
function dragOver(ev) {
	ev.stopPropagation();
	ev.preventDefault();
}
	
/**
 * 드랍 영역에 사진을 떨구는 순간 발생하는 이벤트
 * @param {Object} ev
 */
function drop(ev) {
	ev.stopPropagation();
	ev.preventDefault();

	if (nUploadCount+nFileCount >= nMaxCount) {
		alert("최대 "+nMaxCount+"개 까지만 등록할 수 있습니다.");
		return;
	}

	// 파일 업로드는 한번에 default로 10개씩만 업로드 가능함.
	if (nFileCount >= 10){
		alert("한번에 10개 까지만 업로드 할 수 있습니다.");
		return;
	}

	if(typeof ev.dataTransfer.files == 'undefined') {
		alert("HTML5를 지원하지 않는 브라우저입니다.");
	} else {
		// 변수 선언
		var files,
			nCount,
			sListTag = '';
		
		// 초기화
		files	= ev.dataTransfer.files;
		nCount	= files.length;

		if (!!files && nCount === 0) {
			//파일이 아닌, 웹페이지에서 이미지를 드래서 놓는 경우.
			alert("정상적인 첨부방식이 아닙니다.");
			return ;
		}

		for (var i = 0, j = nFileCount ; i < nCount ; i++) {
			if(nUploadCount+j >= nMaxCount) {
				alert("최대 "+nMaxCount+"개 까지만 등록할 수 있습니다.");
				break;
			}
			
			if($(accept).val() == "image") {
				// 이미지 업로드인 경우
				if (!imageFilter.test(files[i].type)) {
					alert("이미지파일 (jpg,gif,png,bmp)만 업로드 가능합니다.");
					continue;
				}
			} else if($(accept).val() == "video") {
				// 동영상 업로드인 경우
				if (!videoFilter.test(files[i].type)) {
					alert("영상파일 (mp4,avi,wmv)만 업로드 가능합니다.");
					continue;
				}
			} else if($(accept).val() == "audio") {
				// 음성파일 업로드인 경우
				if (!audioFilter.test(files[i].type)) {
					alert("음성파일 (mp3)만 업로드 가능합니다.");
					continue;
				}
			}
			
			// 파일 중복 체크
			
			if(files[i].size > nMaxSize){
				alert("파일 용량이 "+nMaxSize+"MB를 초과하여 등록할 수 없습니다.");
			} else {
				var listTag = "";
				
				if(listTag = addFile(files[i])) {
					sListTag += listTag;
					
					// 총파일 갯수를 증가시킨다.
					++j;
					
					// 다음 사진을위한 셋팅
					nFileInfoCnt += 1;
				}
			}
		}
		
		if(j > 0){
			// 배경 이미지 변경
			startModeBG();

			if ( sListTag.length > 1){
				$(drop_area).prepend(sListTag);
			}
			
			//파일 총사이즈 view update 
			updateViewTotalSize();
			
			//파일 총 수
			nFileCount = j;
			
			// view update
			updateViewCount(nFileCount, 0);
		} else {
			// 설정 배경
			readyModeBG();
		}
	}
}

// 파일 드래그 가능 상태 배경
function startModeBG(){
	var className = $(guide_text).attr("class");
	
	if(className.indexOf('nobg') < 0){
		$(guide_text).removeClass("bg");
		$(guide_text).addClass("nobg");
	}
}

/** 
 * 파일 첨부 전 안내 텍스트가 나오는 배경으로 '설정'하는 함수.
 * @return
 */
function readyModeBG (){
	var className = $(guide_text).attr("class");
	
	if(className.indexOf('nobg') >= 0){
		$(guide_text).removeClass("nobg");
		$(guide_text).addClass("bg");
	}
}

//--------------------- html5  지원되는 브라우저에서 사용하는 함수  --------------------------
/**
 * 팝업에 노출될 업로드 예정 사진의 수.
 * @param {Object} nCount 현재 업로드 예정인 사진 장수
 * @param {Object} nVariable 삭제되는 수
 */
function updateViewCount(nCount, nVariable){
	var nCnt = nCount + nVariable;
	
	elCountTxtTxt.innerHTML = nCnt +"개";
	nFileCount = nCnt;
	
	return nCnt;
}

/**
 * 팝업에 노출될 업로드될 사진 총 용량
 */
function updateViewTotalSize(){
	var nViewTotalSize = Number(parseInt((nTotalSize || 0), 10) / (1024*1024));
	elTotalSizeTxt.innerHTML = nViewTotalSize.toFixed(2) +"MB";
}

/**
 * 파일 전체 용량 재계산.
 * @param {Object} sParentId
 */
function refreshTotalImageSize(sParentId){
	var nDelImgSize = htFileInfo[sParentId].size;
	
	if(nTotalSize - nDelImgSize > -1 ){
		nTotalSize = nTotalSize - nDelImgSize;
	}
}

/**
 * hash table에서 파일 정보 초기화.
 * @param {Object} sParentId
 */
function removeImageInfo(sParentId){
	// 삭제된 파일의 공간을 초기화 한다.
	htFileInfo[sParentId] = null;
}

/**
 * 파일를 추가하기 위해서 file을 저장하고, 목록에 보여주기 위해서 string을 만드는 함수.
 * @param ofile 한개의 파일
 * @return
 */
function addFile(ofile){
	// 파일 사이즈
	var bExceedLimitTotalSize = false,
		sFileSize	= 0,
		sFileName	= "",
		sLiTag		= "",
		aFileList	= [];
	
	sFileSize = setUnitString(ofile.size);
	sFileName = cuttingNameByLength(ofile.name, 15);
	bExceedLimitTotalSize = checkTotalImageSize(ofile.size);

	if( !!bExceedLimitTotalSize ){
		alert("전체 파일 용량이 "+nMaxTotalSize+"MB를 초과하여 등록할 수 없습니다. \n\n (파일명 : "+sFileName+", 사이즈 : "+sFileSize+")");
	} else {
		// 파일 정보 저장
		htFileInfo['img'+nFileInfoCnt] = ofile;
		
		// List 마크업 생성하기
		aFileList.push('<li id="img'+nFileInfoCnt+'" class="imgLi"><span>'+ sFileName +'</span>');
		aFileList.push('<em>'+ sFileSize +'</em>');
        aFileList.push('<a onclick="delFile(\'img'+nFileInfoCnt+'\')" style="cursor: pointer;"><img class="del_button" src="/resources/images/com/fileUpload/btn_del.png" width="14" height="13" alt="첨부 파일 삭제"></a>');
		aFileList.push('</li> ');   
		
		sLiTag = aFileList.join(" ");
		aFileList = [];
	}
	
	return sLiTag.toString();
}

/**
 * 사진 삭제 시에 호출되는 함수
 * @param {Object} sParentId 
 */
function delFile (sParentId) {
	var elLi = getElement(sParentId);
	
	// 업로드 된 사이즈 조정
	refreshTotalImageSize(sParentId);
	updateViewTotalSize();
	
	// 업로드 된 갯수 조정
	updateViewCount(nFileCount, -1);

	// file array에서 정보 삭제.
	removeImageInfo(sParentId);
	
	// 해당 li삭제
	$(elLi).remove();
	
	//마지막 파일인경우.
	if(nFileCount === 0){
		readyModeBG();
	}
	
	// drop 영역 이벤트 다시 활성화.
	if(!bAttachEvent){
		addDragAndDropEvent();
	}
}

/**
 * byte로 받은 파일 용량을 화면에 표시를 위해 포맷팅
 * @param {Object} nByte
 */
function setUnitString(nByte) {
	var nImageSize;
	var sUnit;
	
	if(nByte < 0 ){
		nByte = 0;
	}
	
	if( nByte < 1024) {
		nImageSize = Number(nByte);
		sUnit = 'B';
		return nImageSize + sUnit;
	} else if( nByte > (1024*1024)) {
		nImageSize = Number(parseInt((nByte || 0), 10) / (1024*1024));
		sUnit = 'MB';
		return nImageSize.toFixed(2) + sUnit;
	} else {
		nImageSize = Number(parseInt((nByte || 0), 10) / 1024);
		sUnit = 'KB';
		return nImageSize.toFixed(0) + sUnit;
	}
}

/**
 * 화면 목록에 적당하게 이름을 잘라서 표시.
 * @param {Object} sName 파일명
 * @param {Object} nMaxLng 최대 길이
 */
function cuttingNameByLength(sName, nMaxLng) {
	var sTemp, nIndex;
	if(sName.length > nMaxLng){
		nIndex = sName.indexOf(".");
		sTemp = sName.substring(0,nMaxLng) + "..." + sName.substring(nIndex,sName.length) ;
	} else {
		sTemp = sName;
	}
	return sTemp;
}

/**
 * Total Image Size를 체크해서 추가로 파일를 넣을지 말지를 결정함.
 * @param {Object} nByte
 */
function checkTotalImageSize(nByte){
	if( nUploadSize + nTotalSize + nByte < nMaxTotalSize){
		nTotalSize = nTotalSize + nByte;
		return false;
	} else {
		return true;
	}
}

//확인 버튼 클릭 시
function uploadFile() {
	if(!bSupportDragAndDropAPI) {
		// IE html 5가 아닐때(일반적인 파일 업로드)
		var file_data	= getElement("file_data");
		var fileData	= file_data.files[0];
		
		var uploadURL	= "/forFaith/file/attachFileReg"; 	//upload URL
		
		if($(file_data).val() == "") {
			alert("업로드 파일이 없습니다.");
			return;
		}
		
		if(nUploadCount >= nMaxCount) {
			alert("최대 "+nMaxCount+"개 까지만 등록할 수 있습니다.");
			return;
		}
		
		if($(accept).val() == "image") {
			// 이미지 업로드인 경우
			if (!imageFilter.test(fileData.type)) {
				alert("이미지파일 (jpg,gif,png,bmp)만 업로드 가능합니다.");
				return;
			}
		} else if($(accept).val() == "video") {
			// 동영상 업로드인 경우
			if (!videoFilter.test(fileData.type)) {
				alert("영상파일 (mp4,avi,wmv)만 업로드 가능합니다.");
				return;
			}
		} else if($(accept).val() == "audio") {
			// 음성파일 업로드인 경우
			if (!audioFilter.test(files[i].type)) {
				alert("음성파일 (mp3)만 업로드 가능합니다.");
				return;
			}
		}
		
		if(nUploadSize+fileData.size > nMaxTotalSize) {
			var fileSize = setUnitString(fileData.size);
			var fileName = cuttingNameByLength(fileData.name, 15);
			
			alert("전체 파일 용량이 "+nMaxTotalSize+"MB를 초과하여 등록할 수 없습니다. \n\n (파일명 : "+fileName+", 사이즈 : "+fileSize+")");
			return;
		}
		
		if(fileData.size > nMaxSize){
			alert("파일 용량이 "+nMaxSize+"MB를 초과하여 등록할 수 없습니다.");
		} else {
			try {
				if(confirm("파일을 등록하시겠습니까?")) {
					fileUpload(uploadURL, fileData);
				}
			} catch(e) {}
			
			fileData = null;
		}
	} else {
		if(nFileInfoCnt > 0) {
			if(confirm("파일을 업로드 하시겠습니까?")) {
				//html5Upload();
				html5UploadAll();
			}
		} else {
			alert("업로드 파일이 없습니다. 파일을 드래그해주세요.");
		}
	}
}

/**
 * HTML5 DragAndDrop으로 파일을 추가하고, 확인버튼을 누른 경우에 동작한다.(한파일당 하나씩 등록)
 * @return
 */
function html5Upload() {
	var fileData;
	
	var uploadURL = "/forFaith/file/attachFileReg"; 	//upload URL

	// 파일을 하나씩 보내고, 결과를 받음.
	for(var j=0; j < nFileInfoCnt; j++) {
		fileData = htFileInfo['img'+j];
		
		try {
    		if(!!fileData) {
    			//Ajax통신하는 부분. 파일과 업로더할 url을 전달한다.
    			fileUpload(uploadURL, fileData);
    		}
    	} catch(e) {}
		
    	fileData = null;
	}
}

// 파일 업로드 (한개씩)
function fileUpload(uploadURL, fileData) {
	var formData = new FormData();
	
	formData.append("multipartFile", fileData);
	formData.append("originFileName", encodeURIComponent(fileData.name));
	formData.append("fileId", $(file_id).val());
	formData.append("uploadDir", $(uploadDir).val());
	formData.append("fixFileName", $(fixFileName).val());
	formData.append("removeFileName", $(removeFileName).val());

	jQuery.ajax({
		url			: uploadURL,
		type		: "post",
		dataType	: "json",
		data		: formData,
		processData	: false,
		contentType	: false,
		success		: function(attachFile) {
			if(attachFile != null && attachFile.fileId) {
				fileList.add(attachFile);

				if(!bSupportDragAndDropAPI) {
					// 1개씩 파일 업로드 인 경우
					setAttachFile(fileList);
				} else if(nFileCount == fileList.size()) {
					// 한꺼번에 업로드 하는 경우
					setAttachFile(fileList);
				}
			}
		},
		error		: function(request, status, error) {
			alert("error ===> "+error);
		}
	});
}

/**
 * HTML5 DragAndDrop으로 파일을 추가하고, 확인버튼을 누른 경우에 동작한다.(한번에 모두 등록)
 * @return
 */
function html5UploadAll() {
	var fileDataList
	  , uploadURL;
	
	fileDataList	= new ArrayList();
	uploadURL		= "/forFaith/file/attachFileReg"; 	//upload URL

	// 파일을 하나씩 보내고, 결과를 받음.
	for(var j=0; j < nFileInfoCnt; j++) {
		fileDataList.add(htFileInfo['img'+j]);
	}
	
	try {
		if(!!fileDataList && fileDataList.size() > 0) {
			//Ajax통신하는 부분. 파일과 업로더할 url을 전달한다.
			fileUploadAll(uploadURL, fileDataList);
		}
	} catch(e) {}
}

//html5 호출해준다.
function fileUploadAll(uploadURL, fileDataList) {
	var formData = new FormData();

	for(var i=0; i<fileDataList.size(); ++i) {
		var fileData = fileDataList.get(i);
		
		formData.append("fileList["+i+"].fileId", $(file_id).val());
		formData.append("fileList["+i+"].uploadDir", $(uploadDir).val());
		formData.append("fileList["+i+"].fixFileName", $(fixFileName).val());
		formData.append("fileList["+i+"].removeFileName", $(removeFileName).val());
		formData.append("fileList["+i+"].multipartFile", fileData);
		formData.append("fileList["+i+"].originFileName", encodeURIComponent(fileData.name));
	}

	jQuery.ajax({
		url			: uploadURL,
		type		: "post",
		dataType	: "json",
		data		: formData,
		processData	: false,
		contentType	: false,
		success		: function(attachFile) {
			if(attachFile != null && attachFile.fileId) {
				fileList.add(attachFile);

				// 한꺼번에 업로드 하는 경우
				setAttachFile(fileList);
			}
		},
		error		: function(request, status, error) {
			alert("error[upload] ===> "+error);
		}
	});
}