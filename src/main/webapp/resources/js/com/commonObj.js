/**
 * 공통 객체 제공 - jQuery 기준
 * @author 김준석(2015-06-03)
 */

// StringBuilder 기능구현
function StringBuilder() {
	this.buffer = new Array();
}
StringBuilder.prototype.Append = function(strValue) {
	this.buffer[this.buffer.length] = strValue;
	//this.buffer.push(strValue);	//IE5.5, NS4
};
StringBuilder.prototype.AppendFormat = function() {
	var count = arguments.length;
	if(count < 2) return "";
	
	var strValue = arguments[0];
	for(var i=1; i<count; ++i)
		strValue = strValue.replace("{"+(i-1)+"}", arguments[i]);
	this.buffer[this.buffer.length] = strValue;
};
StringBuilder.prototype.Insert = function(idx, strValue) {
	this.buffer.splice(idx, 0, strValue);	//IE5.5, NS4
};
StringBuilder.prototype.Replace = function(from, to) {
	for(var i=this.buffer.length-1; i>=0; --i)
		this.buffer[i] = this.buffer[i].replace(new RegExp(from, "g"), to);	//IE4, NS3
};
StringBuilder.prototype.ToString = function() {
	return this.buffer.join("");	//IE4, NS3
};
StringBuilder.prototype.empty = function() {
	this.buffer = new Array();
};

// ArrayList 기능 구현
function ArrayList(arr) {
	this.buffer = new Array();
	if(arr)
		this.buffer = arr;
}
ArrayList.prototype.set = function(arr) {
	if(arr)
		this.buffer = arr;
};
ArrayList.prototype.add = function(value) {
	this.buffer[this.buffer.length] = value;
	//this.buffer.push(strValue);	//IE5.5, NS4
};
ArrayList.prototype.remove = function(obj) {
	var temp = new Array();
	var count = 0;
	
	for(var i in this.buffer) {
		if(this.buffer[i] != obj) {
			temp[count++] = this.buffer[i];
		}
	}
	
	this.buffer = temp;
};
ArrayList.prototype.removeByIndex = function(idx) {
	var temp = new Array();
	var count = 0;
	
	for(var i in this.buffer) {
		if(idx != i) {
			temp[count++] = this.buffer[i];
		}
	}
	
	this.buffer = temp;
};
ArrayList.prototype.get = function(idx) {
	return idx < this.buffer.length ? this.buffer[idx] : null;
};
ArrayList.prototype.push = function() {			// 배열의 맨 마지막에 원소 추가
	return this.buffer.push();
};
ArrayList.prototype.pop = function() {			// 배열의 맨 마지막에 원소 제거
	return this.buffer.pop();
};
ArrayList.prototype.unshift = function() {		// 배열의 맨 앞에 원소 추가
	return this.buffer.unshift();
};
ArrayList.prototype.shift = function() {		// 배열의 맨 앞 원소 제거
	return this.buffer.shift();
};
ArrayList.prototype.size = function() {
	return this.buffer.length;
};
ArrayList.prototype.indexOf = function(value) {
	var idx = -1;
	for(var i in this.buffer) {
		if(this.buffer[i] == value) {
			idx = i;
			break;
		}
	}
	return idx;
};
ArrayList.prototype.isEmpty = function() {
	return this.buffer.length > 0 ? false : true;
};
ArrayList.prototype.clear = function() {
	this.buffer = new Array();
};
ArrayList.prototype.contains = function(obj) {
	var isContain = false;
	
	for(var i in this.buffer) {
		if(this.buffer[i] == obj) {
			isContain = true;
			break;
		}
	}
	
	return isContain;
};
// 두개의 ArrayList에서 좌우 값이 동일한 Index에 위치하는지 체크하는 함수
ArrayList.prototype.indexCheck = function(arrayList, leftValue, rightValue) {
	var idx = -1;
	
	for(var i in this.buffer) {
		var thisValue = this.buffer[i];
		var tempValue = arrayList.get(i);
		
		if(thisValue == leftValue && tempValue == rightValue) {
			idx = i;
			break;
		}
	}
	
	return idx;
};
// ArrayList 안의 데이터를 주어진 문자열로 연결해서 String으로 리턴
ArrayList.prototype.join = function(exp) {
	var sb = new StringBuilder("");
	
	for(var i in this.buffer) {
		sb.Append(this.buffer[i]);
		
		if(this.buffer.length-1 != i)
			sb.Append(exp?exp:"");
	}
	
	return sb.ToString();
};
// 배열의 첫번째 값 가져오기.
ArrayList.prototype.first = function() {
	return (this.buffer.length > 0 ? this.buffer[0] : "");
};
//배열의 마지막 값 가져오기.
ArrayList.prototype.last = function() {
	return (this.buffer.length > 0 ? this.buffer[this.buffer.length-1] : "");
};
ArrayList.prototype.toArray = function() {
	return this.buffer;	//IE4, NS3
};

// 하단 네비게이션 기능 구현
function PagingNavigation(target, obj) {
	var _navigation	= this;
	
	this.pageNo		= obj && obj.pageNo		? obj.pageNo		: 1;
	this.numOfRows	= obj && obj.numOfRows	? obj.numOfRows 	: 10;
	this.numOfNums	= obj && obj.numOfNums	? obj.numOfNums 	: 10;
	this.totalCount	= obj && obj.totalCount	? obj.totalCount	: 0;
	this.pagingYn	= obj && obj.pagingYn	? obj.pagingYn		: "Y";
	this.target		= target;
	this.callback	= null;

	this.navigationStyle = new Object();
	//this.navigationStyle.firstNaviImg = "/resources/images/navi/firstNaviImg.png";
	//this.navigationStyle.prevNaviImg = "/resources/images/navi/prevNaviImg.png";
	//this.navigationStyle.nextNaviImg = "/resources/images/navi/nextNaviImg.png";
	//this.navigationStyle.lastNaviImg = "/resources/images/navi/lastNaviImg.png";
	//this.navigationStyle.activeStyle = "z-index: 2;color: #ffffff;cursor: default;background-color: #428bca;border-color: #428bca;";
	//this.navigationStyle.disabledStyle = "color: #999999;cursor: not-allowed;background-color: #ffffff;border-color: #dddddd;";

	// 페이지 네비게이션 클릭 기능
	target.on("click", "a", function() {
		var currPageNo = _navigation.pageNo;							// 현재 페이지 번호
		var movePageNo = currPageNo;									// 이동할 페이지 번호	
		
		// 이전 버튼, 다음 버튼, 숫자 버튼 클릭 시
		if($(this).hasClass("prev")) {
			if($(this).hasClass("active")) {
				movePageNo = currPageNo - 1;
			}
		} else if($(this).hasClass("next")) {
			if($(this).hasClass("active")) {
				movePageNo = currPageNo + 1;
			}
		} else {
			movePageNo = $(this).attr("data-num");
		}

		// 현재 페이지와 이동할 페이지가 같지 않아야 처리
		if(currPageNo != movePageNo) {
			// 리스트를 다시 불러온다.
			_navigation.callBackfn(movePageNo);
		}
	});
}
// 사용자 정의 스타일 적용 default가 맘에 안들때 사용자가 사용할 style을 적용 할수 있다.
PagingNavigation.prototype.setNavigationStyle = function(navigationStyle) {
	// firstNaviImg, prevNaviImg, nextNaviImg, lastNaviImg, activeStyle, disabledStyle
	this.navigationStyle = navigationStyle;
};
PagingNavigation.prototype.setData = function(obj) {
	this.pageNo		= obj && obj.pageNo		? obj.pageNo		: 1;
	this.numOfRows	= obj && obj.numOfRows	? obj.numOfRows 	: 10;
	this.numOfNums	= obj && obj.numOfNums	? obj.numOfNums 	: 10;
	this.totalCount	= obj && obj.totalCount	? obj.totalCount	: 0;
	this.pagingYn	= obj && obj.pagingYn	? obj.pagingYn		: "Y";
};
PagingNavigation.prototype.setPageNo = function(pageNo) {
	this.pageNo = pageNo;
};
PagingNavigation.prototype.getPageNo = function() {
	return this.pageNo;
};
PagingNavigation.prototype.setNumOfRows = function(numOfRows) {
	this.numOfRows = numOfRows;
};
PagingNavigation.prototype.getNumOfRows = function() {
	return this.numOfRows;
};
PagingNavigation.prototype.setNumOfNums = function(numOfNums) {
	this.numOfNums = numOfNums;
};
PagingNavigation.prototype.getNumOfNums = function() {
	return this.numOfNums;
};
PagingNavigation.prototype.setTotalCount = function(totalCount) {
	this.totalCount = totalCount;
};
PagingNavigation.prototype.getTotalCount = function() {
	return this.totalCount;
};
PagingNavigation.prototype.setPagingYn = function(pagingYn) {
	this.pagingYn = pagingYn;
};
PagingNavigation.prototype.getPagingYn = function() {
	return this.pagingYn;
};
// default 네비게이션 구성
PagingNavigation.prototype.setNavigation = function(callBackfn) {
	var count = 0;
	// countOfNums ====> 네비게이션 숫자들의 총 수 total 136 이고 10개의 데이터를 보여준다면 네비게이션 숫자는 14가 됨.
	var countOfNums = (this.totalCount%this.numOfRows == 0) ? Math.floor(this.totalCount/this.numOfRows) : Math.floor(this.totalCount/this.numOfRows)+1;
	// countOfPaging ====> 네비게이션 숫자를 몇개씩 보여주는지에 따라 나오는 숫자 묶음의 갯수  네비게이션 숫자를 10개씩 보여준다면 14까지의 숫자를 보여주기 위해서 1이 됨. 10단위로 -1을 해서 0부터 시작함.
	var countOfPaging = (countOfNums%this.numOfNums == 0) ? Math.floor(countOfNums/this.numOfNums)-1 : Math.floor(countOfNums/this.numOfNums);
	// startNum ===> 현재 페이지가 보여지는 네비게이션 숫자의 처음 시작값 보통 10개씩 보여진다면 1 11 21 31 이렇게 보여짐.

	var startNum = ((this.pageNo%this.numOfNums == 0) ? Math.floor(this.pageNo/this.numOfNums)-1 : Math.floor(this.pageNo/this.numOfNums))*this.numOfNums+1;
	// 화면에 보여줄 네비게이션 숫자 갯수
	var countNum = (startNum+this.numOfNums <= countOfNums) ? this.numOfNums : countOfNums-startNum+1;
	
	var sb = new StringBuilder();
	
	if(this.totalCount > 0) {
		sb.Append("<a class='prev"+((this.pageNo == 1) ? " disabled" : " active")+"' href='javascript:void(0);'>&laquo;</a>");
		
		while(count++ < countNum) {
			sb.Append("<a data-num='"+startNum+"' class='"+((this.pageNo == startNum) ? "on" : "")+"' href='javascript:void(0);'>"+startNum+"</a>");
			++startNum;
		}
		
		sb.Append("<a class='next"+((this.pageNo == countOfNums) ? " disabled" : " active")+"' href='javascript:void(0);'>&raquo;</a>");
	}
	
	this.target.html(sb.ToString());
	
	this.callBackfn = callBackfn;
};

function ScrollBar(overflow, size) {
	//스크롤 바 형태 (x or X, y or Y)
	this.overflow = overflow?overflow:'y';
	this.width = (this.overflow == 'y' || this.overflow == 'Y') ? "15px": size;
	this.height = (this.overflow == 'x' || this.overflow == 'X') ? "15px": size;
}

// 높이와 넓이를 임의로 주고 싶을 경우
ScrollBar.prototype.set = function(width, height) {
	this.width = width;
	this.height = height;
};

// 스크롤 바를 놓는다.
ScrollBar.prototype.setScrollBar = function(targetObj) {
};