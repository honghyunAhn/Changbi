/**
 * 애니메이션 처리 제공 - jQuery 기준
 * @author 김준석(2015-06-03)
 */
 
function Fading(obj) {
	this.slider = obj.slider;
	this.slideArray = obj.slideArray;
	this.slideMax = obj.slideArray.length - 1;
	this.delay = obj.delay;
	this.curSlideNo = 0;
	this.nextSlideNo = null;
	this.fadeStart = false;
	this.curSlideLevel = 1;
	this.nextSlideLevel = 0;
	this.autoSlide = "";

	for (var i=0; i<=this.slideMax; i++) {
		if (i == this.curSlideNo) this.changeOpacity(this.slideArray[i], 1);
		else this.changeOpacity(this.slideArray[i], 0);
	}
}
 
Fading.prototype.startSlide = function(dir) {
	if (this.fadeStart === true) return;

	if( dir == "prev" ) {
		this.nextSlideNo = this.curSlideNo - 1;
		if (this.nextSlideNo < 0) this.nextSlideNo = this.slideMax;
	}
	else if(dir == "next") {
		this.nextSlideNo = this.curSlideNo + 1;
		if ( this.nextSlideNo > this.slideMax ) this.nextSlideNo = 0;
	} else {
		this.fadeStart = false;

		return;
	}

	this.fadeStart = true;
	this.changeOpacity(this.slideArray[this.curSlideNo], this.curSlideLevel);
	this.changeOpacity(this.slideArray[this.nextSlideNo], this.nextSlideLevel);
	this.fadeInOutAction(dir);
};

Fading.prototype.fadeInOutAction = function(dir) {
	var fading = this;

	this.curSlideLevel = this.curSlideLevel - 0.1;
	this.nextSlideLevel = this.nextSlideLevel + 0.1;

	if(this.curSlideLevel <= 0) {
		this.changeOpacity(this.slideArray[this.curSlideNo], 0);
		this.changeOpacity(this.slideArray[this.nextSlideNo], 1);

		if(dir == "prev") {
			this.curSlideNo = this.curSlideNo - 1;
			if (this.curSlideNo < 0) this.curSlideNo = this.slideMax;
		} else {
			this.curSlideNo = this.curSlideNo + 1;
			if (this.curSlideNo > this.slideMax) this.curSlideNo = 0;
		}

		this.curSlideLevel = 1;
		this.nextSlideLevel = 0;
		this.fadeStart = false;
		
		return;
	}

	this.changeOpacity(this.slideArray[this.curSlideNo], this.curSlideLevel);
	this.changeOpacity(this.slideArray[this.nextSlideNo], this.nextSlideLevel);
	
	setTimeout(function () {
		fading.fadeInOutAction(dir);
	}, 100);
};

Fading.prototype.changeOpacity = function(obj,level) {
	obj.style.opacity = level; 
	obj.style.MozOpacity = level; 
	obj.style.KhtmlOpacity = level;
	obj.style.MsFilter = "'progid:DXImageTransform.Microsoft.Alpha(Opacity=" + (level * 100) + ")'";
	obj.style.filter = "alpha(opacity=" + (level * 100) + ");"; 
};

Fading.prototype.start = function() {
	var fading = this;

	this.autoSlide = setInterval(function() {
		fading.startSlide('next');
	}, this.delay);
};

Fading.prototype.stop = function() {
	clearInterval(this.autoSlide);
};