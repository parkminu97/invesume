function fn_page(url, menu) {
	var path = url + "?menu="+menu;
	location.href = path;
}

function fn_resize() {
    var windowHeight = $(window).height();
    var minusVal = 240;
    $('.left_con').css('height', windowHeight-minusVal);
    $('.right_con').css('height', windowHeight-minusVal);
    $('#cont').css('height', windowHeight-minusVal);
}

function initDatePicker(id) {
	var receiptDates = $("#"+id).datepicker({
		changeMonth: true,
		numberOfMonths: 1,
		showOn: "button",
		buttonImageOnly: true,
		buttonImage: "../resources/img/cal.png",
		dateFormat: 'yy.mm.dd'
	});
	$('img.ui-datepicker-trigger').attr('style','margin-left:4px; vertical-align:middle; cursor:pointer;');
}

function initDatePicker2(id, maxDate) {
	var receiptDates = $("#"+id).datepicker({
		changeMonth: true,
		numberOfMonths: 1,
		showOn: "button",
		buttonImageOnly: true,
		buttonImage: "../resources/img/cal.png",
		minDate: '-0d',
		maxDate: maxDate + 'd',
		dateFormat: 'yy.mm.dd'
	});
	$('img.ui-datepicker-trigger').attr('style','margin-left:4px; vertical-align:middle; cursor:pointer;');
}

function popUp(url,title,w,h) {
	var x = (screen.availWidth - w) / 2;
	var y = (screen.availHeight - h) / 2;
	if(w == 0) w = screen.availWidth;
	if(h == 0) h = screen.availHeight;
	var option = "width="+w;
	option += ", height="+h;
	option += ", left="+x;
	option += ", top="+y;
	option += ", resizable=yes";
	option += ", scrollbars=yes";
	
	var newUrl = url;
	if(url.indexOf("?") > -1) {
		var param = url.substring(url.indexOf("?")+1);
		var paramData = param.split("&");
		newUrl = url.substring(0, url.indexOf("?")+1);
			
		for(var i = 0; i < paramData.length; i++) {
			var data = paramData[i].split("=");
			if(i > 0) newUrl += "&";
			newUrl += data[0];
			newUrl += "=";
			newUrl += encodeURIComponent(data[1]);
		}
	}
	window.open(newUrl, title, option);
}

/**
 * @Method Name  		: numFormat
 * @Method 설명  		: ,(콤마) 생성해주는 함수
 * @param num			: 숫자
 * return 				: 
 */
function numFormat(num) {
	num = num.replace(/,/g, "");
	var num_str = num.toString();
	var result = '';

	for(var i=0; i<num_str.length; i++) {
		var tmp = num_str.length-(i+1);
		if(i%3==0 && i!=0) result = ',' + result;
		result = num_str.charAt(tmp) + result;
	}

	return result;
}

/**
 * @Method Name  		: idCheck
 * @Method 설명  		: 영문+숫자+특수문자 - 아이디 생성
 * @param obj
 * (ex) onkeyup="idCheck(this)"
 */
function idCheck(obj){
	var value = obj.value.match(/[^0-9a-zA-Z_]/g);
	if(value != null) {
		obj.value = obj.value.replace(/[^0-9a-zA-Z_]/g,'');
	}  
} 

/**
 * @Method Name  		: pwdCheck
 * @Method 설명  		: 영문+숫자+특수문자 - 패스워드 생성
 * @param obj
 * (ex) onkeyup="pwdCheck(this)"
 */
function pwdCheck(obj){
	var value = obj.value.match(/[^a-zA-Z0-9\~!@#$%^&*()_+=\-]/g);
	if(value != null) {
		obj.value = obj.value.replace(/[^a-zA-Z0-9\~!@#$%^&*()_+=\-]/g,'');
	}
}

/**
 * @Method Name  		: checkEtcKey
 * @Method 설명  		: 특수문자 추출
 * @param passwdVal
 */
function checkEtcKey(passwdVal){
	var tmp = "";
	var etcVal = "";
	var checkPasswd = passwdVal;
	
	for (var i = 0; i < checkPasswd.length; i++) {
		tmp = checkPasswd.substring(i, i+1);

		if (!(tmp.charAt(0) >= '0' && tmp.charAt(0) <= '9') && !(tmp.charAt(0) >= 'a' && tmp.charAt(0) <= 'z') && !(tmp.charAt(0) >= 'A' && tmp.charAt(0) <= 'Z')) {
			etcVal += tmp;
		}
	}
	
	return etcVal;
}

/**
 * @Method Name  		: pNumber
 * @Method 설명  		: 자릿수에 따른 조합 체크
 * @param passwdVal
 */
function pNumber(passwdVal){
	var checkPasswd = passwdVal;
	var checkSEng = "abcdefghijklmnopqrstuvwxyz";
	var checkBEng = checkSEng.toUpperCase();
	var checkNum = "0123456789";
	var checkEtc = checkEtcKey(checkPasswd);

	var cnt1 = 0;
	var cnt2 = 0;
	var cnt3 = 0;
	var cnt4 = 0;
	var rsCnt = 0;
	var msg = "";

	for (var i = 0; i < checkPasswd.length; i++) {
		if (checkSEng.indexOf(checkPasswd.charAt(i)) > -1) { // 소문자 체크
			cnt1 = 1;
		}
		if (checkBEng.indexOf(checkPasswd.charAt(i)) > -1) { // 대문자 체크
			cnt1 = 1;
		}
		if (checkNum.indexOf(checkPasswd.charAt(i)) > -1) { // 숫자 체크
			cnt3 = 1;
		}
	}

//	if (checkEtc != "") { // 특수문자 체크
//		if (sPattern(checkEtc) == true) {
//			cnt4 = 1;
//		}
//	}
	
	rsCnt = cnt1 + cnt2 + cnt3 + cnt4;
	if(rsCnt == 1){
		//msg = "영문자, 숫자, 특수문자 중 2가지 이상 조합되어야 합니다."; 
		msg = "영문자, 숫자 중 2가지 이상 조합되어야 합니다.";
	}else if (rsCnt == 2) { // 2종류 조합 패스워드
		if (checkPasswd.length < 4) {
			msg = "2가지 조합의 패스워드는 4글자 이상이어야 합니다.";
		}else{
			return true;
		}
	}
//	}else if(rsCnt == 3){ // 3종류 조합 패스워드
//		if (checkPasswd.length < 8) {
//			msg = "3가지 조합의 패스워드는 8글자 이상이어야 합니다.";
//		}else{
//			return true;
//		}
//	}

	return msg;
}

/**
 * @Method Name  		: kPattern
 * @Method 설명  		: 키보드 배열상 연속된 4개의 문자 체크
 * @param passwdVal
 */
function kPattern(passwdVal){
	var rs_kPattern = false;
	var checkValue = "";
	var checkPasswd = passwdVal.toLowerCase();
	var checkKey = "~!@#$%^&*()_+|qwertyuiop[]asdfghjkl;'zxcvbnm,./";

	for (var i = 0; i < checkKey.length; i++) {
		checkValue = checkKey.substring(i, i+4);
		
		if (!((checkValue == "pasd") || (checkValue == "lzxc")) && checkPasswd.indexOf(checkValue) > -1) {
			rs_kPattern = true; // 값이 존재
			break;
		}
		
		if (checkValue == "vbnm") {
			break;
		}
	}
	
	return rs_kPattern;
}

/**
 * @Method Name  		: nPattern
 * @Method 설명  		: 1234와 같은 연속된 4개의 숫자 체크
 * @param passwdVal
 */
function nPattern(passwdVal){
	var rs_nPattern = false;
	var checkValue = "";
	var checkPasswd = passwdVal;
	var checkNum = "01234567890123";

	for (var i = 0; i < checkNum.length; i++) {
		checkValue = checkNum.substring(i, i+4);
		
		if (checkPasswd.indexOf(checkValue) > -1) {
			rs_nPattern = true; // 값이 존재
			break;
		}
		
		if (checkValue == "9012") {
			break;
		}
	}
	
	return rs_nPattern;
}

/**
 * @Method Name  		: sPattern
 * @Method 설명  		: 사용 가능한 문자 체크 : a-Z, 0-9, 특수문자(32자)
 * @param passwdVal
 */
function sPattern(passwdVal){
	var rs_sPattern = false;
	var checkPasswd = passwdVal;
	var checkEtc = /[a-zA-Z0-9\~\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\]\^\_\`\{\|\}]+$/;
	var lengthOfvalue = checkPasswd.length;
	var matchesCnt = 0;

	for (var i = 0; i < checkPasswd.length; i++) {
		if (checkEtc.test(checkPasswd.charAt(i)) == true) {
			matchesCnt++;
		}
	}

	if (lengthOfvalue == matchesCnt) {
		rs_sPattern = true;
	}
	
	return rs_sPattern;
}

/**
 * @Method Name  		: cPattern
 * @Method 설명  		: 동일한 문자 및 숫자 4자이상 체크 : aaaa, 1111 등 연속적인 4자 체크
 * @param passwdVal
 */
function cPattern(passwdVal){
	var rs_cPattern = false;
	var checkPasswd = passwdVal;
	//var checkPattern = /(\w)\1\1\1/;
	var checkPattern = /(\w)\1\1/; //3회
	
	if (checkPattern.test(checkPasswd) == true) {
		rs_cPattern = true; // 값이 존재
	}
	
	return rs_cPattern;
}

/**
 * @Method Name  		: ePattern
 * @Method 설명  		: 동일한 문자 및 숫자 4자이상 체크 : aaaa, 1111 등 연속적인 4자 체크
 * @param passwdVal
 */
function ePattern(passwdVal){
	var rs_ePattern = false;
	var checkValue = "";
	var checkPasswd = passwdVal.toLowerCase();
	var checkEng = "abcdefghijklmnopqrstuvwxyzabcd";

	for (var i = 0; i < checkEng.length; i++) {
		checkValue = checkEng.substring(i, i+4);

		if (checkPasswd.indexOf(checkValue) > -1) {
			rs_ePattern = true; // 값이 존재
			return rs_ePattern;
		}
		
		if (checkValue == "zabc") {
			break;
		}
	}
}

/**
 * @Method Name  		: onlyAlpaNum
 * @Method 설명  		: 영문+숫자
 * @param obj
 * (ex) onkeyup="onlyAlpaNum(this)"
 */
function onlyAlpaNum(obj){
	var value = obj.value.match(/[^a-zA-Z0-9]/g);
	if(value != null) {
		obj.value = obj.value.replace(/[^a-zA-Z0-9]/g,'');
	}  
} 


/**
 * 숫자만 입력 가능하도록
 * (ex) onkeyup="onlyNumber(this)"  
 * @param obj
 */
function onlyNumber(obj) {
	var value = obj.value.match(/[^0-9]/g);
	if(value != null) {
		obj.value = obj.value.replace(/[^0-9]/g,'');
	}
}

/**
 * @Method Name  		: onlyWideNumber
 * @Method 설명  		: 숫자 및 소수점 체크 함수
 * (ex) onkeyup="onlyWideNumber(this)"  
*/
function onlyWideNumber(obj){
	var value = obj.value.match(/[^0-9-.]/g);
	if(value != null) {
		obj.value = obj.value.replace(/[^0-9-.]/g,'');
	}
}


/**
 * @Method Name  		: isFloat
 * @Method 설명  		: 입력문자의 숫자 판별하여 실수형이 아니면 입력불가( .은 들어갈수있음 )
 * return 				: 
*/
function isFloat(value) {
	var count = 0;
	var ch;
	 
	for(var i=0; i<value.length; i++) {
	  ch = value.charAt(i);
	  if(isNaN(ch)) {
	   if(ch == "." || (i == 0 && ch == "-")) {
	    count++;
	   } else {
	    return false;
	   }
	  }    
	}
	 
	if(count > 2) {
	  return false;
	} else {
	  return true;
	}
	return result;
}

/**
 * @Method Name  		: checkBoxAll
 * @Method 설명  		: 체크박스 전체선택/해제
 * @param id			: 선택 체크박스 id
 * @param name			: 타겟 체크박스 name
 */
function checkBoxAll(id,name){
	$("input[name="+name+"]").each(function(){
		if(!$(this).attr("disabled")){
			$(this).attr("checked",$("#"+id).is(":checked"));
		}
	});
	
}

/**
 * @Method Name  		: checkRows
 * @Method 설명  		: 체크박스 선택 유무체크
 * @param name			: 체크박스 name
 * return 				: 체크된 밸류array (,)구분
 */
function checkRows(name){
	var checkValue = "";
	$("input[name="+name+"]").each(function(){
		if($(this).is(":checked")){
			if(checkValue.length == 0){
				checkValue = $(this).val();
			}else{
				checkValue += "," + $(this).val();
			}
		}
	});
	return checkValue;
}

function checkRows2(name, opt){
	var checkValue = "";
	$("input[name="+name+"]").each(function(){
		if($(this).is(":checked")){
			if(checkValue.length == 0){
				checkValue = $(this).val();
			}else{
				checkValue += opt + $(this).val();
			}
		}
	});
	
	return checkValue;
}

/**
 * @Method Name  		: trim
 * @Method 설명  		: 공백제거
 * @param str			: str
 * return 				: String
 */
function trim(str){
	var newStr = str.replace(/^\s+/,"").replace(/\s+$/,"");
	return newStr;
}

/**
 * @Method Name  		: checkRanged
 * @Method 설명  		: 공백제거
 * @param elem			: params
 * @param min			: 최소 자리수
 * @param max			: 최대 자리수
 * @param msgArgs		: 메시지 내용
 * return 				: String
 */
function checkRanged(elem, min, max, msgArgs) {
	var val = trim($("#" + elem).val());
	var len = val.length;

	if (min > 0 && len < min) {
		alert(msgArgs + " 항목은 " + min + " 글자 이상 입력하셔야 합니다.");
		$("#" + elem).focus();
		return false;
	}
	if (max > 0 && len > max) {
		alert(msgArgs + " 항목은 " + max + " 글자 이하로 입력하셔야 합니다.");
		$("#" + elem).focus();
		return false;
	}

	return true;
}

/**
 * @Method Name  		: checkBizSN
 * @Method 설명  		: 사업자 번호 체크 ex)111-11-11111
 * @param bizID			: bizID
 * return 				: Boolean
 */
function checkBizSN(bizID) {
	var re = /-/g;
	var tmpBizID = bizID.replace(re, '');
	var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
	var i, chkSum = 0, c2, remander;
	for (i = 0; i <= 7; i++) {
		chkSum += checkID[i] * tmpBizID.charAt(i);
	}
	
	c2 = "0" + (checkID[8] * tmpBizID.charAt(8));
	c2 = c2.substring(c2.length - 2, c2.length);

	chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
	remander = (10 - (chkSum % 10)) % 10;

	return Math.floor(tmpBizID.charAt(9)) == remander;
}

/**
 * @Method Name  		: fillZero
 * @Method 설명  		: 앞자리 0으로 채우기
 * @param p1,p2			: p1=변수 , p2=자리수
 * return 				: String
 */
function fillZero(p1,p2) {
	var zero = "";
	for (var i=0; i<p2; i++) zero += "0";
	return zero.toString().concat(p1).match(new RegExp("\\d{" + p2 + "}$"));
}

/**
 * @Method Name  		: getToDay
 * @Method 설명  		: 현재 년월일 구하기(YYYY-mm-dd)
 * 						: ex) var currentDate = getToDate()
 * @param 				: 
 * return 				: String
 */
function getToDay() {
	var today 	= new Date();
	var toStr;

	toStr = today.getFullYear().toString();
	toStr += "-" + fillZero(today.getMonth()+1,2);
	toStr += "-" + fillZero(today.getDate(),2);
	
	return toStr;
}

function getIntDay(str) {
	str = str.replace(/-/g, "");
	var toInt = parseInt(str);
	
	return toInt;
}

/**
 * @Method Name  		: getByte
 * @Method 설명  		: 텍스트 바이트 수 체크
 * 						: ex) onkeypress="getByte(this,90);
 * 						:     <span id="byte">0</span>
 * @param 				: 
 * return 				: object,String
 */
function getByte(obj,ibyte){
	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;
	tmpStr = new String(obj.value);
	temp = tmpStr.length;
	for (var k=0;k<temp;k++){
		onechar = tmpStr.charAt(k);
		if (escape(onechar).length > 4) {
			tcount += 2;
		}
		else {
			tcount++;
		}
	}
	if(tcount>ibyte) {
		alert("작성하신 메시지가 "+ibyte+"바이트를 초과하였습니다.\r\n\초과된 부분은 자동 삭제됩니다."); 
		cutText(obj,ibyte);
		return;
	}
	$("#byte").text(tcount);
}

function cutText(pStr,ibyte){
	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;
	tmpStr = new String(pStr.value);
	temp = tmpStr.length;

	for(var k=0;k<temp;k++){
		onechar = tmpStr.charAt(k);
		if (escape(onechar).length > 4) {
			tcount += 2;
		} else {
			tcount++;
		}
		if (tcount>ibyte) {
			tmpStr = tmpStr.substring(0,k);
			break;
		} else {
			cbyte = tcount;
		}
	}
	pStr.value = tmpStr;
}

function isEmail(email) {
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	if(!regex.test(email)) {
		return false;
	}
	
	return true;
}

function isDateFormat(d) {
	var regex = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
	if(!regex.test(d)) {
	    return false;
	}
	return true;
}

function fn_setCookie(name, value, expiredays) {
    var todayDate= new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape(value)+"; path=/; expires=" + todayDate.toGMTString();
}

function fn_getCookie(name) {
    var search = name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)  end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}