/**
 * 공통 함수 모음 - jQuery 기준
 * @author 김준석(2015-06-03)
 */

// 숫자형태 문자열 앞에 자릿수 만큼 0으로 채우는 기능 (n : 숫자, digit : 자릿수, add : n에 추가 숫자)
function leadingZeros(n, digit, add) {
	// 1 -> 01 로 변경
	var zero = '';

	if (add)
		n = n + add;
	
	// default 2(월이나 일자 표시시 default로)
	if (!digit)
		digit = 2;

	n = n.toString();

	if (n.length < digit) {
		for ( var i = 0; i < digit - n.length; ++i) {	
			zero += '0';
		}
	}
	return zero + n;
}

// 숫자형태의 문자열을 금액 형태로 변환
function formatMoney(str) {
	var result = "0";
	
	// 문자열로 바꾼다. 숫자로 넘어올지도 모름
	str += "";
	
	if(Number(str)) {
		var len	= str.length;
		var reverse	= "";
		
		result = str;

		if(len > 3) {
			result = "";
			
			for(var i=len-1; i>=0; i--) {
				// 역순으로 바꾼다.
				reverse += str.charAt(i);
			}

			for(var i=len-1; i>=0; i--) {
				// 역순을 다시 역순 시킴.
				result += reverse.charAt(i);
				
				if(i%3 == 0 && i != 0) {
					result += ",";
				}
			}
		}
	}
	
	return result;
}

// 지도 사이즈 조정
function mapResize() {
	var mapBgWidth = $("#searchContent").width() - 310;
	var mapBgHeight = document.documentElement.clientHeight - 120;
	var mapHeight = mapBgHeight - 20;

	$("#searchRightMapBg").width(mapBgWidth);
	$("#searchRightMapBg").height(mapBgHeight);
	$("#map").width("100%");
	$("#map").height(mapHeight);
	$("#searchLeft").height(mapBgHeight);
}

// 모바일 사이즈 조정
function fnMobileResize() { 
	var nBodyHeight = $('#body1').attr("clientHeight"); 
	alert(nBodyHeight); 
	var nHeader= $('#mheader').attr("clientHeight"); 
	var nHeight = nBodyHeight-(nHeader); 
	alert(nHeight); 
	//$('#lymap').attr("style","height:300px"); 
	$('#lymap').css("height",nHeight-5+"px"); 
}

// 버블 이벤트를 취소 시킨다. 현재 타켓에 해당되는 이벤트만 실행됨.(버블은 현재 타킷에서 부모에게 이벤트가 이어지는 걸 의미함 부모의 이벤트를 없애는 기능)
function cancelBubble(evt) {
	evt = evt ? evt : window.event;
	
	if(evt.stopPropagation) {
		evt.stopPropagation();
	} else {
		evt.cancelBubble = true;
	}
}

function eventCheck(evt) {
	evt = evt ? evt : window.event;
	
	if(evt.preventDefault) {
		evt.preventDefault();
	} else {
		evt.returnValue = false;
	}
}

// 엔터키 여부
function enterKeyPress() {
	var keyCode = 0;
	var isEnter = false;
	
	event = event || window.event;
	keyCode = (event.which) ? event.which : event.keyCode;

	if(keyCode == 13) {
		isEnter = true;
	}
	
	return isEnter;
};

// 숫자만 입력 가능하도록함
function numberKeydown() {
    var keyCode = 0;
    var isNumber = false;
    
    event = event || window.event;
    keyCode = (event.which) ? event.which : event.keyCode;

    if( keyCode == 46 || keyCode == 39 || keyCode == 37 || keyCode == 0 || keyCode == 45 || keyCode == 8 || keyCode == 9
      || (keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105)) {
        isNumber = true;
    } else {
        event.preventDefault ? event.preventDefault() : window.event.returnValue = false;
    }
    
    return isNumber;
}

// 숫자인 경우 포커스 아웃일 때 빈 값이면 0으로 변경
function numberBlur() {
    event = event || window.event;
    
    event.srcElement.value = event.srcElement.value ? event.srcElement.value : 0; 
}

function getOffsetXY(e) {
	var offsetXY = new Object();
	
	if(window.event) {
		offsetXY.X = window.event.offsetX;
		offsetXY.Y = window.event.offsetY;
	} else if(e) {
		var element = this;
		var offsetX = 0;
		var offsetY = 0;
		while(element.offsetParent) {
			offsetX += element.offsetLeft;
			offsetY += element.offsetTop;
			element = element.offsetParent;
		}
		
		offsetXY.X = e.pageX - offsetX;
		offsetXY.Y = e.pageY - offsetY;
	}
	
	return offsetXY;
};

function isMobile() {
	var userAgent = navigator.userAgent;
	
	return (/lgtelecom|blackberry|samsung|symbian|sony|SHC-|SPH-|iphone|ipad|ipod|android/i.test(userAgent.toLowerCase()));
}

function mobileName() {
	var mobileName = "nomobile";
	var userAgent = navigator.userAgent.toLowerCase();
	
	if(userAgent.search("android") > -1) {
		mobileName = "android";
	} else if((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1) || (userAgent.search("ipad") > -1)) {
		mobileName = "ios";
	}

	return mobileName;
}

function sumAjax(type, url, data, dataType, contentType) {
	dataType = dataType ? dataType : "html";
	contentType = contentType ? contentType : "application/x-www-form-urlencoded; charset=EUC-KR";
	var result = "";

	$.ajax({
		contentType: contentType,
		url: url,
		type: type,
		dataType: dataType,
		cache: false,
		
		success: function(data) {
			result = data;
		}
	});

	return result;
}

function openWindow(url, name, properties) {
	window.open(url, name, properties);
}

function setCookie(c_name, value, expires) {
	var c_value = escape(value)+(expires ? "; expires="+expires.toUTCString() : "");
	
	document.cookie = c_name+"="+c_value;
}

function getCookie(c_name) {
	var cookieArr = document.cookie.split(";");
	
	for(var i=0; i<cookieArr.length; ++i) {
		var key	= cookieArr[i].substr(0, cookieArr[i].indexOf("="));
		var value	= cookieArr[i].substr(cookieArr[i].indexOf("=")+1);
		
		key = key.replace(/^\s+|\s+$/g,"");
		
		if(key == c_name) {
			return unescape(value);
		}
	}
}

// 문자열 공백 제거
String.prototype.trim = function() {
	return this.replace(/\s/g, "");
}

// RGB to HEX
function componentToHex(c) {
    var hex = c.toString(16);
    
    return hex.length == 1 ? "0" + hex : hex;
}

function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}

// HEX to RGB
function hexToRgb(hex) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function(m, r, g, b) {
        return r + r + g + g + b + b;
    });

    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}