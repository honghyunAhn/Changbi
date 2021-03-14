$(document).ready(function() {
	// 레이어 팝업 적용
	$('.popup, .overlay').hide();
	$('.popup_content').html("");
	
	$('.overlay').bind("click", function(e){ 
		e.preventDefault(); 
		$('.popup, .overlay').hide();
		$('.popup_content').html("");
	});
});

// 레이어 팝업 띄우기
function openLayerPopup(title, url, data) {
	// ajax 처리
	$.ajax({
		type	: "POST",
		url		: url,
		data	: data,
		dataType: "html",
		success	: function(result) {

			if(result) {

				$('.popup').css("top", (($(window).height()-$('.popup').outerHeight())/2+$(window).scrollTop())+"px");
				$('.popup').css("left", (($(window).width()-$('.popup').outerWidth())/2+$(window).scrollLeft())+"px");
				$('.popup').css("height", 800 +"px");
				$('.popup, .overlay').show();
				
				$('.popup_title').html("<div class='text' style='padding-top: 10px; width: 800px; height: 10px; text-align: center; font-size: 24px; font-weight: bold; color: #fff;'>"+title+"</div>");
				$('.popup_content').html(result);
				$('.popup_content').css("height" , 100+"%");
			} else {
				alert("페이지 호출 실패");
			}
		},
		error	: function(e) {
			alert(e.responseText);
		}
	});
}

// 레이어 팝업 없애기
function closeLayerPopup() {
	$(".overlay").trigger("click");
}

// 공통 부분 초기화 (에디터, 달력, 언어 선택 기능)
function setPageInit(editor_object, file_object) {
	// 스마트에디터 프레임생성
	/*
	$("textarea.editor").each(function(i) {
		var editor_id = $("textarea.editor").eq(i).attr("id");

		// 에디터 초기화
		nhn.husky.EZCreator.createInIFrame({
			oAppRef			: editor_object,
			elPlaceHolder	: editor_id,
			sSkinURI		: '/common/editor/SmartEditor2Skin.html',
			htParams 		: { bUseToolbar : false
							  , bUseVerticalResizer : false
							  , bUseModeChanger : false },
			fOnAppLoad:function() {
				// 강제로 iframe 사이즈 잡음. IE에서만 ?? 크롬에서도 안되던데.. 높이가 0으로 되버림.. hidden일때
				// $("iframe").css("width","100%").css("height", "206px");
				// initSmartEditor(i);
			}
		});
	});
	*/
	// 달력 초기화
	$('.datetimepicker').datetimepicker({
       	format				: 'YYYY-MM-DD',
        dayViewHeaderFormat	: 'YYYY년 MM월',
        locale				: moment.locale('ko'),
        defaultDate			: new Date()
    });

	// 언어선택(전체 선택 또는 전체 해제 시)
	$("#lang_all").click(function(){
        if ($(this).prop("checked")) {
        	$(":checkbox[name=langchk]").prop("checked", true);		// 언어 전체 선택
            
            $("li[role='presentation']").addClass("show");			// 모든 언어탭을 보여준다.
        }else {
        	$(":checkbox[name=langchk]").prop("checked", false);	// 언어 전체 해제
        	$("#lang_ko").prop("checked", true);					// 한국어 체크박스만 default로 체크 됨
        	
        	// 모든 언어 탭에서 첫번째 노드(한국어)만 제외하고 hide 시킴
        	$("li[role='presentation']:not(:first-child)").removeClass("show").addClass("hide");
        	
        	// 전체 언어 선택 삭제 시 무조건 한국어 상태로 변경 시킴
        	$("li[role='presentation']").removeClass("active");
        	$("li[role='presentation']:first-child").addClass("active");
        	
        	$("div.tab-pane").removeClass("active");
        	$("div.tab-pane:first-child").addClass("active");
        }
    });
	
	// 개별 언어 클릭 시
	$(":checkbox[name=langchk]").click(function(event){
		// 클릭 한 언어 index
		var idx = $(":checkbox[name=langchk]").index($(this));						// (0 : 한국어default)
		var parentList = $("li[role='presentation']:first-child").parent("ul");		// (언어 탭의 부모 리스트 가지고 온다.)

		// 한국어는 default로 사용 한국어 클릭 시 return 시킴.
		if(idx == 0){ return false; }
    	
		if($(this).is(":checked")) {
			parentList.each(function(i) {
				// 여기서 $this는 each 안에서 선택 된 parentList
				$(this).children("li").eq(idx).addClass("show");
			});
		} else {
			parentList.each(function(i) {
				// 여기서 $this는 each 안에서 선택 된 parentList
				var targetList	= $(this).children("li");
				var target		= targetList.eq(idx);
				
				// 해당 언어의 탭을 안 보이게 함.
				target.removeClass("show").addClass("hide");
				
				// 삭제하는 언어가 선택 된 상태였다면 무조건 한국어영역으로 바꿈.
				if(target.hasClass("active")) {
					target.removeClass("active");
					targetList.first().addClass("active");
		        	
		        	// 탭과 함께 컨텐츠 화면도 한국어로 바꿔줌.
		        	$("div.tab-pane:first-child").parent("div").eq(i).children("div.tab-pane").removeClass("active");
		        	$("div.tab-pane:first-child").parent("div").eq(i).children("div.tab-pane:first-child").addClass("active");
				}
			});
		}
		
		// 언어 선택 전체 체크 여부 판단 개별 언어의 갯수로 체크함.
		var len = $(":checkbox[name=langchk]:checked").length;
		
		if(len == 4){
			$("#lang_all").prop("checked", true);
		}else{
			$("#lang_all").prop("checked", false);
		}
    });
	
	// 파일 업로드 처리
	if(file_object && file_object.length > 0) {
		/* MULTIFILE 이용시 
		$(":file.with-preview").each(function(i) {
			$(this).MultiFile(file_object[i]);
		});
		
		// 사진보기 팝업
		$(".preview-list").on("click","li button.preview",function(event){
			event.preventDefault();
			
			var srcUrl = $(this).parent().find("span span img").attr("src");
			
			$('#imagePreviewModal img.modalImgPreview').attr('src', srcUrl);
		});
		*/

		for(var i=0; i<file_object.length; ++i) {
			file_object[i].index = i;
			
			var attachFile = new AttachFile(file_object[i]);
			
			attachFile.init();
		}
	}
}

function initSmartEditor(i) {
	// 첫번째 에디터를 제외한 나머지를 hidden시킨다.
	var editor_id = $("textarea.editor").eq(i).attr("id");
	
	if(i != 0) {
		$("#"+editor_id).parent().hide();
	}
}

function attachFileReset(file_object) {
	// 파일 업로드 처리
	if(file_object && file_object.length > 0) {
		/* MULTIFILE 이용시 
		$(":file.with-preview").each(function(i) {
			$(this).MultiFile(file_object[i]);
		});
		
		// 사진보기 팝업
		$(".preview-list").on("click","li button.preview",function(event){
			event.preventDefault();
			
			var srcUrl = $(this).parent().find("span span img").attr("src");
			
			$('#imagePreviewModal img.modalImgPreview').attr('src', srcUrl);
		});
		*/

		for(var i=0; i<file_object.length; ++i) {
			file_object[i].index = i;
			
			var attachFile = new AttachFile(file_object[i]);
			
			attachFile.init();
		}
	}
}

// Daum 주소 서비스 API 연동
function daumPostcode(idx) {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
            
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if(data.buildingName !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
            
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
            
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if(fullRoadAddr !== ''){
				fullRoadAddr += extraRoadAddr;
			}

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            // document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
			$(".zipcode").eq(idx).val(data.zonecode);

            if(data.userSelectedType == 'R') {
            	// document.getElementById('addr').value = fullRoadAddr;
            	$(".addr").eq(idx).val(fullRoadAddr);
            } else if(data.userSelectedType == 'J') {
            	// document.getElementById('addr').value = data.jibunAddress;
            	$(".addr").eq(idx).val(data.jibunAddress);
            }

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                // document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                // document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                // document.getElementById('guide').innerHTML = '';
            }
            
            // document.getElementById('etcAddr').focus();
            $(".etc_addr").eq(idx).focus();
        }
    }).open();
}

//image click event
function imagePreview(src) {
	$('#imagePreviewModal img.modalImgPreview').attr('src', src);
	
	$('#imagePreviewModal').addClass("in");
	$('#imagePreviewModal').css("display", "block");
	$('#imagePreviewModal').after("<div class='modal-backdrop fade in'></div>");
	
	// 이미지 뷰 삭제 이벤트
	$('#imagePreviewModal').find(":button").bind("click", imagePreviewClose);
}

function imagePreviewClose() {
	// 삭제 이벤트 초기화
	$('#imagePreviewModal').find(":button").unbind("click");
	
	// 이미지 뷰 삭제
	$('#imagePreviewModal').removeClass("in");
	$('#imagePreviewModal').css("display", "");
	$('.modal-backdrop').remove();
}