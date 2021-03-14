/**
 * DAUM MAP 기능을 제공하는 파일 - jQuery 기준
 * DAUM MAP 사용 시 해당 파일 사용 (참조 : mobile_map.js)
 * @author 김준석(2015-06-03)
 */

//http://192.168.0.80:8080
document.write("<script src='http://apis.daum.net/maps/maps3.js?apikey=4cdc7cc7927b33bf94366d23448871f071a96cad' charset='utf-8'></script>");
//http://bus.jeju.go.kr:8080
//document.write("<script src='http://apis.daum.net/maps/maps3.js?apikey=f9bae88dbab22611d58886f603c2af5d68b511fa' charset='utf-8'></script>");
//http://localhost:8080
//document.write("<script src='http://apis.daum.net/maps/maps3.js?apikey=b7ea53ddc2108c5eac45ecd4073cbb2c4d919bfd' charset='utf-8'></script>");
//http://bus.jeju.go.kr
//document.write("<script src='http://apis.daum.net/maps/maps3.js?apikey=13f3f56aa98cd08f4b4cdc6eac5223918740c338' charset='utf-8'></script>");

//http://192.168.20.60:8080
//document.write("<script src='http://apis.daum.net/maps/maps3.js?apikey=76cf2a9a08cc29492405d0c8efde4bb3bde55e8f' charset='utf-8'></script>");

// 인포윈도우 옵션 저장 객체
function InfoWindowOption(marker, position, content, removable, zIndex) {
	this.position = position ? position : null;
	this.content = content ? content : "";
	this.removable = removable ? removable : true;
	this.zIndex = zIndex ? zIndex : 1;
	this.marker = marker ? marker : null;
}

InfoWindowOption.prototype.setPosition = function(position) {
	this.position = position;
};

InfoWindowOption.prototype.setContent = function(content) {
	this.content = content;
};

InfoWindowOption.prototype.setRemovable = function(removable) {
	this.removable = removable;
};

InfoWindowOption.prototype.setZIndex = function(zIndex) {
	this.zIndex = zIndex;
};

InfoWindowOption.prototype.setMarker = function(marker) {
	this.marker = marker;
};

// 인포윈도우 관리 객체
function InfoWindow(name, infoWindowOption) {
	this.name = name?name:"";
	this.marker = infoWindowOption.marker;
	this.infoWindow = new daum.maps.InfoWindow({position:infoWindowOption.position?infoWindowOption.position:null,content:infoWindowOption.content?infoWindowOption.content:"",removable:infoWindowOption.removable,zIndex:infoWindowOption.zIndex});
}

InfoWindow.prototype.setName = function(name) {
	this.name = name;
};

InfoWindow.prototype.getName = function() {
	return this.name;
};

InfoWindow.prototype.setPosition = function(position) {
	this.infoWindow.setPosition(position);
};

InfoWindow.prototype.setContent = function(content) {
	this.infoWindow.setContent(content);
};

InfoWindow.prototype.setZIndex = function(zIndex) {
	this.infoWindow.setZIndex(zIndex);
};

InfoWindow.prototype.setMarker = function(marker) {
	this.marker = marker;
};

InfoWindow.prototype.open = function(map, marker) {
	this.infoWindow.open(map, marker?marker:this.marker);
};

InfoWindow.prototype.getMap = function() {
	return this.infoWindow.getMap();
};

InfoWindow.prototype.close = function() {
	if(this.getMap()) {
		this.infoWindow.close();
	}
};

function DaumMap() {
	this.map = null;
	this.infoWindow = null;
	this.line = null;
	this.circle = null;
	this.infoWindowList = new ArrayList();
}

/**
 * mapOptions : Map 생성 시 필요한 다음 지도 생성 시 필요한 option
 * eventOptions : Map에 등록할 이벤트 option
 * etcOption : Zoom, MapType, BusSymbol등 기타 option (key : isZoomControl, isMapTypeControl, isDisableBusSymbol)
 * @param mapOptions
 * @param eventOptions
 * @param etcOptions
 */
DaumMap.prototype.initMap = function(mapId, mapOptions,eventOptions,etcOptions) {
	this.map = new daum.maps.Map(document.getElementById(mapId), mapOptions);
	this.line = new daum.maps.Polyline({"strokeWeight" : 3, "strokeColor" : "#0000FF", "strokeOpacity" : 1});
	this.infoWindow =  new InfoWindow("base", new InfoWindowOption());
	
	if(eventOptions) {
		for(var event in eventOptions) {
			daum.maps.event.addListener(this.map, event, eventOptions[event]);
		}
	}
	if(etcOptions.isZoomControl) {
		var zoomControl = new daum.maps.ZoomControl();
		this.map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	}
	if(etcOptions.isMapTypeControl) {
		var mapTypeControl = new daum.maps.MapTypeControl();
		this.map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	}
	if(etcOptions.isDisableBusSymbol) {
		daum.maps.disableBusSymbol();
	}
	
	initDaumMap();
};
// 맵 layout 변경 시
DaumMap.prototype.relayout = function() {
	this.map.relayout();
};
// 좌표로부터 CSS 좌표 반환
DaumMap.prototype.pointFromCoords = function(latlng) {
	return this.map.getProjection().pointFromCoords(latlng);
};

// Point의 X 값 반환
DaumMap.prototype.getX = function(point) {
	return point.x;
};

//Point의 Y 값 반환
DaumMap.prototype.getY = function(point) {
	return point.y;
};

// marker 이미지를 만듬.
DaumMap.prototype.MarkerImage = function(options, width, height) {
	return new daum.maps.MarkerImage(options.src
									,this.getSize(width, height)
									,options.offset ? options.offset : ""
									,options.shape ? options.shape : ""
									,options.coords ? options.coords : "");
};

// 사이즈를 만듬.
DaumMap.prototype.getSize = function(width, height) {
	return new daum.maps.Size(width, height);
};

// 지도의 중심좌표를 얻어온다.
DaumMap.prototype.getCenter = function() {
	return this.map.getCenter();
};

//지도의 중심좌표를 세팅한다.
DaumMap.prototype.setCenter = function(latLng) {
	this.map.setCenter(latLng);
};

//지도의 지정한 좌표로 부드럽게 이동한다.
DaumMap.prototype.panBy = function(x, y) {
	return this.map.panBy(x, y);
};

//지도의 중심좌표로 부드럽게 이동한다.
DaumMap.prototype.panTo = function(latLng) {
	this.map.panTo(latLng);
};

//지도의 확대Level을 얻어온다.
DaumMap.prototype.getLevel = function() {
	return this.map.getLevel();
};

//지도의 확대Level을 세팅한다.
DaumMap.prototype.setLevel = function(level) {
	this.map.setLevel(level);
};

//지도의  보여주고있는 영역을 반환합니다.
DaumMap.prototype.getBounds = function() {
	return this.map.getBounds();
};

//주어진 영역이 지도 화면 안에 전부 나타날 수 있도록 중심 좌표와 확대 수준을 조정합니다.
DaumMap.prototype.setBounds = function(bounds) {
	this.map.setBounds(bounds);
};

// 주어진 영역의 남서쪽 좌표를 반환
DaumMap.prototype.getSouthWest = function() {
	return this.map.getBounds().getSouthWest();
};

// 주어진 영역의 북동쪽 좌표를 반환
DaumMap.prototype.getNorthEast = function() {
	return this.map.getBounds().getNorthEast();
};

// 주어진 위도와 경도값에 따른 LatLng 객체 반환
DaumMap.prototype.getLatLng = function(lat, lng) {
	return new daum.maps.LatLng(lat, lng);
};

// 주어진 위도 경도에 대한 위도 값을 반환
DaumMap.prototype.getLat = function(latlng) {
	return latlng.getLat();
};

// 주어진 위도 경도에 대한 경도 값을 반환
DaumMap.prototype.getLng = function(latlng) {
	return latlng.getLng();
};

//주어진 영역의 남서쪽 좌표의 위도
DaumMap.prototype.getSouthWestLat = function() {
	return this.getSouthWest().getLat();
};

//주어진 영역의 남서쪽 좌표의 경도
DaumMap.prototype.getSouthWestLng = function() {
	return this.getSouthWest().getLng();
};

//주어진 영역의 북동쪽 좌표의 위도
DaumMap.prototype.getNorthEastLat = function() {
	return this.getNorthEast().getLat();
};

//주어진 영역의 북동쪽 좌표의 경도
DaumMap.prototype.getNorthEastLng = function() {
	return this.getNorthEast().getLng();
};

//주어진 좌표에 대한 LatLngBounds 객체 생성
DaumMap.prototype.getLatLngBounds = function(southWestLat, southWestLng, northEastLat, northEastLng) {
	return new daum.maps.LatLngBounds(this.getLatLng(southWestLat, southWestLng), this.getLatLng(northEastLat, northEastLng));
};

// 경도, 위도 좌표로 주소값 얻어오기 callBackfn 함수를 호출해준다.
DaumMap.prototype.getAddress = function(lat, lng, callBackfn) {	
	if (lat && lng) {
	    var s = document.createElement('script');
	    s.type ='text/javascript';
	    s.charset ='utf-8';
	    //s.src = 'http://apis.daum.net/maps/coord2addr?apikey=2236f340093839afb8ebd034d35f1d33270128b6&output=json&format=simple&callback='+callBackfn+'&inputCoordSystem=WGS84&latitude=' + lat + '&longitude=' + lng;
	    //s.src = 'http://apis.daum.net/local/geo/coord2addr?apikey=2dd09e3a56f578c472ce5185f0bbfbe471f6a7bd&output=json&format=simple&callback='+callBackfn+'&inputCoordSystem=WGS84&latitude=' + lat + '&longitude=' + lng;
	    s.src = 'http://apis.daum.net/local/geo/coord2addr?apikey=60572002d5e74baa1c492c75faef21a6ede498bd&output=json&format=simple&callback='+callBackfn+'&inputCoordSystem=WGS84&latitude=' + lat + '&longitude=' + lng;
	    document.getElementsByTagName('head')[0].appendChild(s);
	}
};

// 여러개의 infoWindowList 만들고 관리하기
// 같은 이름의 InfoWindow는 생성되지 않는다.
DaumMap.prototype.addInfoWindow = function(name, infoWindowOption) {
	var infoWindow = new InfoWindow(name, infoWindowOption);
	var isDup = false;

	for(var i=0; i<this.infoWindowList.size(); ++i) {
		var temp = this.infoWindowList.get(i);
		
		if(temp.getName() == name) {
			isDup = true;
			break;
		}
	}
	
	if(!isDup) {
		this.infoWindowList.add(infoWindow);
		infoWindow.open(this.map);
	}
};

// 여러개의 infoWindowList 만들고 관리하기
// 해당 이름의 InfoWindow를 삭제한다.
DaumMap.prototype.removeInfoWindow = function(name) {
	for(var i=0; i<this.infoWindowList.size(); ++i) {
		var temp = this.infoWindowList.get(i);
		
		if(name) {
			if(temp.getName() == name) {
				temp.close();
				break;
			}
		} else {
			temp.close();
		}
	}
};

// 여러개의 infoWindowList 만들고 관리하기
// 여러개의 infoWindow를 보여준다.

// infoWindow를 띄우자!!
DaumMap.prototype.infoWindowOpen = function(content, type) {
	this.infoWindowClose();
	this.infoWindow.setContent(content);
	
	if(type) {
		if(type instanceof daum.maps.Marker) {
			//alert(type.getPosition().getLat()+","+type.getPosition().getLng());
			this.setCenter(type.getPosition());
			this.infoWindow.open(this.map, type);
		} else if(type instanceof daum.maps.LatLng) {
			this.setCenter(type);
			this.infoWindow.setPosition(type);
			this.infoWindow.open(this.map);
		}
	}
};

// infoWindow Close
DaumMap.prototype.infoWindowClose = function() {
	this.infoWindow.close();
};

// 마커 생성
DaumMap.prototype.marker = function(position, iconImg, eventOptions) {
	var marker = new daum.maps.Marker({
					position: position,
					image: iconImg});
	
	marker.setMap(this.map);
	
	if(eventOptions) {
		for(var event in eventOptions) {
			daum.maps.event.addListener(marker, event, eventOptions[event]);
		}
	}
	
	return marker;
};

//마커 표시
DaumMap.prototype.showMarker = function(marker) {
	marker.setMap(this.map);
};

// 마커 삭제
DaumMap.prototype.deleteMarker = function(marker) {
	marker.setMap(null);
};

// 선 그리기
DaumMap.prototype.drawLine = function(latLngArr) {
	this.line.setPath(latLngArr);
	this.line.setMap(this.map);
};

//선 지우기
DaumMap.prototype.dropLine = function() {
	if(this.line.getMap()) {
		this.line.setMap(null);
	}
};

DaumMap.prototype.createCircle = function(option) {
	if(this.circle) {
		this.circle.setMap(null);
	}

	this.circle = new daum.maps.Circle({
		map: this.map,
		center: option.center,
		fillColor: option.fillColor ? option.fillColor : "#F10000",
		fillOpacity: option.fillOpacity ? option.fillOpacity : 0,
		radius: option.radius ? option.radius : 500,
		strokeWeight: option.strokeWeight ? option.strokeWeight : 3,
		strokeColor:  option.strokeColor ? option.strokeColor : "#F10000",
		strokeOpacity: option.strokeOpacity ? option.strokeOpacity : 0.6,
		strokeStyle: option.strokeStyle ? option.strokeStyle : "solid",
		zIndex:  option.zIndex ? option.zIndex : 1
	});
	
	return this.circle;
};

DaumMap.prototype.removeCircle = function() {
	this.circle.setMap(null);
};

function CreateOverlay(position, node) {
    this.position_ = position;
    this.node_ = node;
}

function initDaumMap(){
	CreateOverlay.prototype = new daum.maps.AbstractOverlay;

	CreateOverlay.prototype.onAdd = function() {
	    var panel = this.getPanels().overlayLayer;
	    panel.appendChild(this.node_);
	};
	
	CreateOverlay.prototype.onRemove = function() {
	    this.node_.parentNode.removeChild(this.node_);
	};
	
	CreateOverlay.prototype.draw = function() {
	    var projection = this.getProjection();
	    var point = projection.pointFromCoords(this.position_);
	    var width = this.node_.offsetWidth;
	    var height = this.node_.offsetHeight;

	    this.node_.style.left = (point.x - width/2)+"px";
	    this.node_.style.top = (point.y - height-25)+"px";
	};
	
	CreateOverlay.prototype.setNode = function(position, node) {
		this.position_ = position;
	    this.node_ = node;
	};
};