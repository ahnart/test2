	if(window.addEventListener) window.addEventListener("load", readyStart, false);
	else if(window.attachEvent) window.attachEvent("onload", readyStart );
	else window.onload = readyStart;
	
	function readyStart(){
		setTimeout(loaded, 100);
	}
	
	function loaded() {
		window.scrollTo(0, 1);
	}
	
	// 특수문자 체크
	function common_valFilter(value) {
		var strobj = document.getElementById(value);
		re = /[\{\}\[\]\/,|\*`\<>\#$%&\'\"\\\\=]/gi;
		if(re.test(strobj.value)) {
			alert("특수문자는 입력하실 수 없습니다.");
			//strobj.value = "";
			strobj.value = strobj.value.replace(re, ""); 
			return;
		}
	}
	
	//날짜 스크립트 시작	============= start
	function to_date2(dateStr){
		var yyyyMMdd = String(dateStr);
		var sYear = yyyyMMdd.substring(0,4);
		var sMonth = yyyyMMdd.substring(5,7);
		var sDate = yyyyMMdd.substring(8,10);
		
		return new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
	}
	
	function common_selectNow() {
		var now = new Date();
	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	              
	    var chan_val = year + mon + day;
	    return chan_val;
	}
	
	function common_selectYear() {
		var now = new Date();
		var year= now.getFullYear();
		return year;
	}
	
	function common_selectMonth() {
		var now = new Date();
		var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		return mon;
	}
	
	function common_selectDay() {
		var now = new Date();
		var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
          
		return day;
	}
	
	function common_selectHours() {
		var now = new Date();
		var hours = now.getHours();
		return hours;
	}
	
	function common_selectMinutes() {
		var now = new Date();
		var minutes = now.getMinutes();
		return minutes;
	}
	
	/**
     * 두 날짜의 차이를 일자로 구한다.(조회 종료일 - 조회 시작일)
     *
     * @param val1 - 조회 시작일(날짜 ex.2002-01-01)
     * @param val2 - 조회 종료일(날짜 ex.2002-01-01)
     * @return 기간에 해당하는 일자
     */
    function calDateRange(val1, val2)
    {
        var FORMAT = "-";
        // FORMAT을 포함한 길이 체크
        if (val1.length != 10 || val2.length != 10)
            return null;
 
 
        // FORMAT이 있는지 체크
        if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
            return null;
 
        // 년도, 월, 일로 분리
        var start_dt = val1.split(FORMAT);
        var end_dt = val2.split(FORMAT);
 
        // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
        start_dt[1] = (Number(start_dt[1]) - 1) + "";
        end_dt[1] = (Number(end_dt[1]) - 1) + "";
 
        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);
 
        return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
    }
	
	//date script =================== end
	
	// date setting ( 1-1week, 2-1month, 3-2month, 4-3months )
	function setPeriod(val) {	
		
		var todayDate = new Date();
		var endDate	  = new Date();
		
		var year = todayDate.getFullYear();
		var month = todayDate.getMonth()+1;
		var nowDay = todayDate.getDate();
		
		var end_year = endDate.getFullYear();
		var end_month = endDate.getMonth()+1;
		var end_date = endDate.getDate();
		 
		if(val == '1') {
			todayDate.setDate(todayDate.getDate() - 7);
		}else if(val == '2') {
			todayDate.setMonth(todayDate.getMonth() - 1);
		}else if(val == '3') {
			todayDate.setMonth(todayDate.getMonth() - 2);
		}else if(val == '4') {
			todayDate.setMonth(todayDate.getMonth() - 3);
		}
		
		year = todayDate.getFullYear();
		month = todayDate.getMonth()+1;
		nowDay = todayDate.getDate();
		
		$("#startDate").val(year+'-'+((month < 10) ? ('0' + month) : month)+'-'+((nowDay < 10) ? ('0' + nowDay) : nowDay));
		$("#endDate").val(end_year+'-'+((end_month < 10) ? ('0' + end_month) : end_month)+'-'+((end_date < 10) ? ('0' + end_date) : end_date));
		
	}
	
	// limit date setting ( 1-1week, 2-1month, 3-2month, 4-3months )
	function setLimitDatePeriod(val, limitStartDate) {
		
		var startDate = to_date2(limitStartDate);
		var endDate	  = new Date();
		
		var year = startDate.getFullYear();
		var month = startDate.getMonth()+1;
		var nowDay = startDate.getDate();
		
		var end_year = startDate.getFullYear();
		var end_month = startDate.getMonth()+1;
		var end_date = startDate.getDate();
		 
		if(val == '1') {
			endDate.setDate(endDate.getDate() + 7);
		}else if(val == '2') {
			endDate.setMonth(endDate.getMonth() + 1);
		}else if(val == '3') {
			endDate.setMonth(endDate.getMonth() + 2);
		}else if(val == '4') {
			endDate.setMonth(endDate.getMonth() + 3);
		}
		
		year = endDate.getFullYear();
		month = endDate.getMonth()+1;
		nowDay = endDate.getDate();
		
		$("#startDate").val(end_year+'-'+((end_month < 10) ? ('0' + end_month) : end_month)+'-'+((end_date < 10) ? ('0' + end_date) : end_date));
		$("#endDate").val(year+'-'+((month < 10) ? ('0' + month) : month)+'-'+((nowDay < 10) ? ('0' + nowDay) : nowDay));
		
	}
	
	// show loading bar
	function showLoadingMessage(){
		document.all.loading.style.display = 'block';
		document.body.style.overflow = "hidden";
	}
	// hide loading bar
	function showComplateMessage(){
		document.all.loading.style.display = 'none';
	}
	
	function checkComplate(){
		try{
			iframe = document.getElementById('downloadIframe');
			var status = iframe.document.readyState;

			if(status == 'loading' || status == 'interactive'){
				setTimeout("checkComplate()", 1000);
			} else {
				//showComplateMessage();
			}
		} catch(e){
			showComplateMessage();
		}
	}
	
	// check email 
	function checkEmail(email){
		
		if(email.length > 0){
			var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
			if(regex.test(email) == false){
				return false;
			}else{
				return true;
			}
		}else{
			return false;
		}
	}
	
	// encode parameter function
	// encodeURIComponent : no english, no number
	function encParam(value){
		if( value != null && typeof(value) != 'undefined' )  return encodeURIComponent(value);
		else return "";
	}
	
	// get => post 
	function commonGetUrl(url, data){
		
		if( url != null && typeof(url) != 'undefined' ){
			if( data != null && typeof(data) != 'undefined' ){
				$("body").append("<form id='rFrm' name='rFrm' method='post' action='"+url+"'></form>");
				var dataSet = data.split("&");
				var value;
				var encValue = "";
				var innerInput = "";
				for(var i=0; i<dataSet.length; i++){
					value = dataSet[i].split("=");
					encValue = encParam(value[1]);
					innerInput += "<input name='"+value[0]+"' value='"+encValue+"'/>";
				}
				//console.log('innerInput : ' + innerInput);
				$("#rFrm").html(innerInput);
				$("#rFrm").submit();
			}
		}
		
	}
	
	// post encoding -> clone ( frm -> rFrm )
	function commonPostUrl(url) {
		if( url != null && typeof(url) != 'undefined' ){
			$("body").append("<form id='rFrm' name='rFrm' method='post' action='"+url+"'></form>");
			var innerInput = "";
			
			$("body #frm input").each(function() {
				var inputName = $(this).attr("name");
				var encValue = encParam($(this).val());
				if( inputName != null && typeof(inputName) != 'undefined' ) {
					innerInput += "<input name='"+inputName+"' value='"+encValue+"'/>";
				}
			});
			
			$("body #frm textarea").each(function() {
				var inputName = $(this).attr("name");
				var encValue = encParam($(this).val());
				if( inputName != null && typeof(inputName) != 'undefined' ) {
					innerInput += "<input name='"+inputName+"' value='"+encValue+"'/>";
				}
			});
			
			//console.log('innerInput : ' + innerInput);
			$("#rFrm").html(innerInput);
			$("#rFrm").submit();
		}
	}
	
	// check img type
	function checkImg(imgData){
		var extArr = new Array(".jpg", ".jpeg", ".png", ".gif", ".bmp");
		var extVal = "";
		var flag = "N";
		while(imgData.indexOf("\\") != -1){
			imgData = imgData.slice(imgData.indexOf("\\")+1);
			extVal = imgData.slice(imgData.indexOf(".")).toLowerCase();
			for(var i=0; i<extArr.length; i++){
				if(extArr[i] == extVal){
					flag = "Y";
					break;
				}
			}
		}              
		if(flag == "N"){
			return false;
		}else{
			return true;
		}
	}
	
	// 팝업
	var openPop;
	function findName(url, type){
		if(openPop) openPop.close();
		
		checkPopupParam(type);
		
		var w = 770;
		var h = 600;
		if("goodscom2"==type || "goodscom3"==type){
			w = 1880;
		}
		openPop = window.open(url, "searchPop", "width="+w+",height="+h);
	}
	
	// 팝업에 팝업
	var openPop2;
	function findName2(url, type){
		
		checkPopupParam(type);
		
		var w = 770;
		var h = 600;
		openPop2 = window.open(url, "searchPop2", "width="+w+",height="+h);
	}

	// 팝업 파라메터 확인
	function checkPopupParam(type){
		
		if("goodscom" == type ){
			$("#goods_com_id").val("");
			$("#goods_com_name").val("");
		}else if("goodscom2" == type ){
			$("#goods_com_id").val("");
			$("#goods_com_name").val("");
			$("#goods_seq").val("");
			$("#goods_name").val("");
		}else if("goodscom3" == type ){
			$("#goods_com_id").val("");
			$("#goods_com_name").val("");
			$("#goods_seq").val("");
			$("#goods_name").val("");
			$("#model_name").val("");
		}else if("disp" == type){
			$("#disp_no").val("");
			$("#disp_name").val("");
		}else if("brand" == type ){
			$("#brand_code").val("");
			$("#brand_name").val("");
		}else if("usecom" == type ){
			$("#usecom_code").val("");
			$("#usecom_code_name").val("");
		}else if('media' == type){
			$("#send_mass_id").val("");
			$("#send_mass_name").val("");
		}
		
	}

	
	
	var _lastAjaxObj = null;
	function ajax(url, params, callback) {
		var options = {
			url: url,
			type: "POST",
			data: params,
			//contentType: "application/json; charset=utf-8",
			//dataType: "json",
			timeout: 300000,
			success: callback
		};
		
		_lastAjaxObj = $.ajax(options);
	}