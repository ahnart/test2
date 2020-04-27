<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>캠페인등록 | SISCUS</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/ui.js"></script>
<script type="text/javascript" src="/resources/js/paging.js"></script>
<script type="text/javascript" src="/resources/js/commmon.js"></script>
<script type="text/javascript"> 

$(document).ready(function() {
	// left menu setting start
	$("#nav > ul > li > a").each(function() {
		$(this).removeClass('on');
		if('campaignMng' == $(this).attr('class')){
			$(this).addClass('on');
		}
	});
	// left menu setting end
	

	
	// only number check start
	$("#campaign_price").keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});
	// only number check end
	

});


function insertCampaign(){
		
	var startDate = jQuery("#start_date").val().replace(/-/g,'');
	var endDate = jQuery("#end_date").val().replace(/-/g,'');
	var campaignName = $("#campaign_name").val();
	var campaignPrice = $("#campaign_budget").val();
	
	
	if($("#advId").val() == "" || typeof($("#advId").val() ) == 'undefined'){
		alert("고객사를 선택하세요.");
		jQuery("#SELECT_ADV").focus();
		return false;
	}
	
 	if(startDate == "" || typeof(startDate) == 'undefined'  ){
 		alert("캠페인기간을 입력하세요");
		return;
	}
 	if(endDate == "" || typeof(endDate) == 'undefined'  ){
 		alert("캠페인기간을 입력하세요");
		return;
	}
 	
 	if(parseInt(startDate) > parseInt(endDate)){
		alert("캠페인 기간 설정이 잘 못 되었습니다.");
		return false;
	}

 	
 	if(campaignName == "" || typeof(campaignName) == 'undefined'  ){
 		alert("캠페인명을 입력하세요");
		$("#campaign_name").focus();
		return;
	}
 	if(campaignPrice == "" || typeof(campaignPrice) == 'undefined'  ){
 		alert("예상집행금액을 입력하세요");
		$("#campaign_price").focus();
		return;
	}

	if(confirm("등록 하시겠습니까?")){
		$("#frm").attr('action', '/send/insertCampaign.do');
		$("#frm").submit();	
	}
	
}

function setAdvInfo(){
	var advId = jQuery("#SELECT_ADV option:selected").val();
	jQuery("#advId").val(advId);
	jQuery("#advid_usergubun").val( jQuery("#SELECT_ADV option:selected").attr('id') );
}

</script>
</head>

<body>
<div id="wrap">

	<!-- Header start -->

<script type="text/javascript" src="/js/jquery/jquery.i18n.properties-1.0.9-min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>

<script type="text/javascript">

</script>
<script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript">

// menu setting
var gnbType = 'sendMng';

$(document).ready(function() {
	// gnb setting start
	$("#gnb > ul > li > a").each(function() {
		$(this).removeClass('on');
		if( "sendMng" == $(this).attr('class')){
			$(this).addClass('on');
		}
	});
	// gnb setting end
});

</script>
<header id="header" class="clearfix">
			<%@ include file="../include/header.jsp"%>
		</header>

		<!-- Header end -->
		
		<c:if test="${member != null}">
			<section id="gnb">
				<div class="container">
					<ul class="clearfix">
						<li><a href="/user/user_main" class="companyMng ">기업관리</a></li>
						<li><a href="/send/campaignList" class="sendMng on">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng">상품관리</a></li>
						<li><a href="/account/accountListDay.do" class="accountMng">정산관리</a></li>
						<li><a href="/user/user_list" class="systemMng">시스템관리</a></li>
					</ul>
				</div>
			</section>
			<!-- Header end -->
		</c:if>

	<!-- Header end -->
	
	<section id="container" class="clearfix">
		<!-- LNB start -->
		
<nav id="nav">
	<ul>
		<li><a href="/send/campaignList.do" class="campaignMng on">캠페인관리</a></li>
		<li><a href="/send/sendList.do" class="sendMng">발송관리</a></li>
	</ul>
</nav>
		<!-- LNB end -->
		
		<section id="section">
			<!-- gnb start -->
			<div class="bradcrumb">
				<a href="/">SISCUS</a> &gt; <a href="/send/campaignList.do">발송관리</a> &gt; <a href="/send/insertCampaignForm.do" class="on">캠페인 등록 화면</a>
			</div>
			<!-- gnb end -->
			<form name="frm" id="frm" method="post" >
			<input type="hidden" id="advId" name="advId" value=""/>
			<input type="hidden" id="advid_usergubun" name="advid_usergubun" value="" />
			<div id="content">
				<h2>기본정보</h2>
				<div class="comp">
					<table class="tbType02">
					<!-- 	<caption>캠페인관리</caption>	 -->
						<colgroup>
							<col style="width:15%;">
							<col style="width:85%">
						</colgroup>
						<tbody>
							<tr>
								<th>고객사</th>
								<td>
									<select id="SELECT_ADV" name="SELECT_ADV" onchange="javascript:setAdvInfo()">
										<option value="">선택</option>
										
									</select>
								</td>
							</tr>
							<tr>
								<th>캠페인기간</th>
								<td colspan="3">
									<div class="calendar">
										<input type="text" name="start_date" id="start_date" readonly value="2020-04-27" class="datepicker01">
									</div><span> ~ </span><div class="calendar">
										<input type="text" name="end_date" id="end_date" readonly value="2020-08-05" class="datepicker02">
									</div>
								</td>
							</tr>
							<tr>
								<th>캠페인명</th>
								<td colspan="3"><input type="text" id="campaign_name" name="campaign_name" value="" /></td>
							</tr>
							<tr>
								<th>예상집행금액</th>
								<td colspan="3"><input type="text" id="campaign_budget" name="campaign_budget" value="" /></td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
			</form>
			<div class="btnArea alignR">
				<a class="btnType05" onclick="javascript:insertCampaign();">등록</a>
				<a class="btnType04" href="/send/campaignList.do">목록보기</a>
			</div>
		</section>
	</section>
	
	<!-- Header start -->
	


<script type="text/javascript">
	var openPop;
	function goFooterMenu(type){
		if(openPop) openPop.close();
		
		switch(type){
			case "1":
				location.href="/customer/noticeList.do";
				break;
			case "2":
				location.href="/customer/terms.do";
				break;
			case "3":
				location.href="/customer/privacy.do";
				break;
			case "4":
				openPop = window.open("", "winPop", "width=550px, height=850px, scrollbars=0, resizable=0");
				break;
			case "5":
				location.href="/customer/trading.do";
				break;
			case "6":
				location.href="/customer/inquiryInsertForm.do";
				break;
		}
	}
</script>

		<footer>
			<%@ include file="../include/footer.jsp"%>
		</footer>


	<!-- Header end -->
</div>
</body>
</html>
