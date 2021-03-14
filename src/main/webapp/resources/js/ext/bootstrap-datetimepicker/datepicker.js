/**
 * 
 */
$.datepicker.setDefaults({
	changeMonth : true,
	changeYear : true,
	showMonthAfterYear:true,
	showButtonPanel : true,
	closeText: '닫기',
	nextText : '다음 달',
	prevText : '이전 달',
	yearRange: '-20:+5',
	dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
	dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
			'9', '10', '11', '12' ],
	monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
			'8월', '9월', '10월', '11월', '12월' ],
	dateFormat : 'yy-mm-dd'
});

function minMax(frmId,endId){
	$("#"+frmId).datepicker({onSelect : function(selected) {
		$("#"+endId).datepicker("option", "minDate",selected);
	}});
	$("#"+endId).datepicker({onSelect : function(selected) {
		$("#"+frmId).datepicker("option", "maxDate",selected);
	}});
}


Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
