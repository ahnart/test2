<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발송관리 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>발송관리 | SISCUS / 발송관리 등록</title>
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
		if('sendMng' == $(this).attr('class')){
			$(this).addClass('on');
		}
	});
	// left menu setting end
	

});

jQuery(function(){
	jQuery(document).on("keyup", "input:text[numberOnly]", function() {jQuery(this).val( jQuery(this).val().replace(/[^0-9]/gi,"") );});
});

function insertSend(){
			
	if(jQuery("#advId").val() == ""){
		alert("ê³ ê°ì¬ë¥¼ ì ííì¸ì.");
		jQuery("#SELECT_ADV").focus();
		return false;
	}
		
	if(jQuery("#sendName").val() == ""){
		alert("ë°ì¡ ëªì ìë ¥í´ ì£¼ì¸ì.");
		jQuery("#sendName").focus();
		return;
	}
	
	if(jQuery("#redTelNo").val() == ""){
		alert("íì  ì íë²í¸ë¥¼ ìë ¥íì¸ì.");
		jQuery("#redTelNo").focus();
		return false;
	}

	var startDate = jQuery("#startDate").val();
	var endDate = jQuery("#endDate").val();
	
	if(startDate == ""){
		alert("ë°ì¡ ììì¼ìë¥¼ ì ííì¸ì.");
		return false;
	}
	if(endDate == ""){
		alert("ë°ì¡ ì¢ë£ì¼ìë¥¼ ì ííì¸ì.");
		return false;
	}	
	
	if(parseInt(startDate) > parseInt(endDate)){
		alert("ë°ì¡ ì¼ì ì¤ì ì´ ì ëª» ëììµëë¤.");
		return false;
	}
	

	if(confirm("<spring:message code='common.register.question'/>")){
		$("#frm").attr('action', '/send/insertSend.do');
		$("#frm").submit();	
	}
	
}

function setAdvInfo(){
	var advId = $("#SELECT_ADV option:selected").val();
	var advName = $("#SELECT_ADV option:selected").text();
	var advUserGubun = $("#SELECT_ADV option:selected").attr('id');

	$("#advId").val(advId);
	$("#advName").val(advName);
	
	if(advId != ""){
		ajax(
			'/common/getCampaignListAjax.do',
			{
				'advId':advId,
				'advid_usergubun':advUserGubun
			},
			setCampaignSelectBox
		);
	}

}

function setCampaignSelectBox(msg){
	$("#cSbox").html(msg); 
}

function setCampaignInfo(){
	var campaignInfo = jQuery("#SELECT_CAMPAIGN option:selected").val();
	
	if(campaignInfo != ""){
		var cArray = campaignInfo.split("|");
		$("#CAMPAIGN_DATE_DIV").html(cArray[1] + "~" + cArray[2]);
		$("#campaignMngNo").val(cArray[0]);
	}
}

</script>
</head>
<body>

<div id="wrap">

		
		<header id="header" class="clearfix">
			<%@ include file="../include/header.jsp"%>
		</header>
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
	<section id="container" class="clearfix">
		<!-- LNB start -->
	
		<!-- LNB end -->
		
		<section id="section">
			<!-- gnb start -->
			<div class="bradcrumb">
				<a href="/">메뉴</a> &gt; <a href="/send/campaignList.do">메뉴</a> &gt; <a href="/send/insertCampaignForm.do" class="on">발송등록</a>
			</div>
			<!-- gnb end -->
			<form name="frm" id="frm" method="post" >
			<input type="hidden" id="campaignMngNo" name="campaignMngNo" value=""/>
			<input type="hidden" id="userGubun" name="userGubun" value="<c:out value='${userGubun}'/>"/>
			<input type="hidden" id="advName" name="advName" value="<c:out value='${advName}'/>"/>
			<input type="hidden" id="advId" name="advId" value="<c:out value='${advId}'/>"/>
			<input type="hidden" id="agencyName" name="agencyName" value="<c:out value='${S_b2bCompanyInfo.companyName}'/>"/>
			<input type="hidden" id="agencyId" name="agencyId" value="<c:out value='${S_b2bCompanyInfo.userId}'/>"/>
			<div id="content">
				<h2>발송관리</h2>
				<div class="comp">
					<table class="tbType02">
					
						<tbody>
							<tr>
								<th>고객사</th>
								<td>
									<select id="SELECT_ADV" name="SELECT_ADV" onchange="javascript:setAdvInfo()">
										<option value="">선택</option>
										<c:forEach var="b2bCompanyInfo" items="${companyList}" varStatus="status">
										<option value="<c:out value='${b2bCompanyInfo.b2bcode}'/>"<c:if test="${b2bCompanyInfo.b2bcode eq decryptAdvId}"> selected</c:if>  id="${b2bCompanyInfo.userGubun }" >
											<c:out value="${b2bCompanyInfo.companyName }"/>
										</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>캠페인</th>
								<td>
								<div id="cSbox">
									<select id="SELECT_CAMPAIGN" name="SELECT_CAMPAIGN" onchange="javascript:setCampaignInfo()">
										<option value="">선택하세요</option>
										<c:forEach var="campaignInfo" items="${campaignInfoList}" varStatus="status">
										<option value="<c:out value='${campaignInfo.campaignMngNo}'/>|<c:out value='${campaignInfo.campaignStartDate}'/>|<c:out value='${campaignInfo.campaignEndDate}'/>"><c:out value="${campaignInfo.campaignName}"/></option>
										</c:forEach>
									</select>
								</div>
								</td>
							</tr>
							<tr>
								<th>캠페인 기간</th>
								<td colspan="3"><div id="CAMPAIGN_DATE_DIV"></div></td>
							</tr>
							<tr>
								<th>대량발송 명</th>
								<td colspan="3"><input type="text" id="sendName" name="sendName"  onkeyup="javascript:common_valFilter('sendName');" maxlength="50" value="" /></td>
							</tr>
							<tr>
								<th>회신 전화번호</th>
								<td colspan="3"><input type="text" id="redTelNo" name="redTelNo" class="input_mobile" maxlength="11" value="" numberonly="true" /></td>
							</tr>
							
							
							<tr>
								<th>대량발송 기간</th>
								<td colspan="3">
									<div class="calendar">
										<input type="text" name="startDate" id="startDate" readonly value="${startDate}2020-0101" class="datepicker01">
									</div><span> ~ </span><div class="calendar">
										<input type="text" name="endDate" id="endDate" readonly value="${endDate}2020-0201" class="datepicker02">
									</div>
								</td>
							</tr>
							
							
						</tbody>
					</table>
				</div>

			</div>
			</form>
			<div class="btnArea alignR">
				<!-- <a class="btnType05" onclick="javascript:insertSend();">스프링메시지</a> -->
				
				<a class="btnType04" href="/send/sendDetail.do">작성 완료</a>
				<a class="btnType04" href="/send/sendList.do">목록보기</a>
			</div>
		</section>
	</section>
	
	<footer>
			<%@ include file="../include/footer.jsp"%>
		</footer>
</div>
</body>
</html>