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
	
	// tab menu setting start
	$(".tabType01 > ul > li").each(function() {
		$(this).removeClass('on');
		if('sendBasic' == $(this).attr('id')){
			$(this).addClass('on');
		}
	});
	// tab menu setting end	
	
	$("#sendtype1").hide();
	$("input[name=sendtyperad]").click(function() {
		sendTypeSelect($(this).val());
	});
	
});

jQuery(function(){
	jQuery(document).on("keyup", "input:text[numberOnly]", function() {jQuery(this).val( jQuery(this).val().replace(/[^0-9]/gi,"") );});
});

//선택
function sendTypeSelect(type) {
	if (type == "5"){
		$("#sendtype2").show();
		$("#sendtype1").hide();
	}else {
		$("#sendtype1").show();
		$("#sendtype2").hide();
	}
	$("#sendtype").val(type);

}

function goUpdateStatus(){
	if(confirm("발송 상태 변경 하시겠습니까?")){
		jQuery("#frm").attr("action","/send/sendUpdateStatus.do");
		jQuery("#frm").submit();
	}
}



function goRegDone(){
	if(confirm("대량발송 등록을 완료 하시겠습니까?")){
		jQuery("#frm").attr("action","/send/sendRegDone.do");
		jQuery("#frm").submit();
	}
}

function goBuyHistInsert(){

	if($("#mmsTitle").val() == ""){
		alert("MMS 제목을 입력하세요.");
		$("#mmsTitle").focus();
		return false;
	}
	
	if($("#goods_seq").val() == ""){
		alert("상품을 선택해주세요.");
		$("#goodsname").focus();
		return false;
	}
		
	if ($("#sendtype").val() == "5") {
		if($("#phoneno").val() == ""){
			alert("수신자번호를 입력하세요.");
			$("#phoneno").focus();
			return false;
		}	
		if($("#sendcnt").val() == ""){
			alert("발송수량을 입력하세요.");
			$("#sendcnt").focus();
			return false;
		}
	}else {
		if($("#sendListFile").val() == ""){
			alert("발송 리스트를 선택해주세요.");
			$("#sendListFile").focus();
			return false;
		}
	}
	
	
	if(jQuery("#mmsSendMsg").val() == ""){
		alert("전송 메시지를 입력하세요.");
		$("#mmsSendMsg").focus();
		return false;
	}
	
	//var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?\.\,]/gi;
	var special_pattern = /`~@#$%&*|\\\'\";:]/gi;
	if( special_pattern.test(jQuery("#mmsSendMsg").val()) == true ){
		alert('특수문자는 사용할 수 없습니다.');
		$("#mmsSendMsg").focus();
		return false;
	}
	
	var str = $("#mmsSendMsg").val(); 
	if(new RegExp(/[<]/).test(str) || new RegExp(/[>]/).test(str)){
		alert('특수문자는 사용할 수 없습니다.');
		jQuery("#mmsSendMsg").focus();
		return false;
	}
	
	
	if(confirm("등록하시겠습니까?")){
		$("#frm").attr("action","/send/sendBuyHistInsert.do");
		$("#frm").submit();
	}
	
}

var iframe;
function goExcelDownload(advName, camName){

	var $iframe = jQuery("#downloadIframe");
	var url = "/send/sendReceiveSampleExcel.do?advname="+encParam(encParam(advName))+"&camname="+encParam(encParam(camName));
	$iframe.attr('src', url);
}

</script>
</head>

<body>
<div id="wrap">

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
	<section id="container" class="clearfix">
	<!-- Header end -->
	<nav id="nav">
	<ul>
		<li><a href="/send/campaignList.do" class="campaignMng on">캠페인관리</a></li>
		<li><a href="/send/sendList.do" class="sendMng">발송관리</a></li>
	</ul>
</nav>
		<!-- LNB end -->
	
		<section id="section">
			<div class="bradcrumb">
				<a href="/"><spring:message code='common.gnb.giftishow.cms'/></a> &gt; <a href="/send/campaignList.do"><spring:message code='common.gnb.send.mng'/></a> &gt; <a href="/send/sendList.do" class="on">발송등록</a>
			</div>
			
			<form name="frm" id="frm" enctype="multipart/form-data" method="post" >
			<input type="hidden" id="sendmngno" name="sendmngno" value="<c:out value='${sendMngInfo.sendMngNo}'/>" />
			<input type="hidden" id="advId" name="advId" value="${sendMngInfo.advId}"/>
			<input type="hidden" id="redirectURL" name="redirectURL" value="/send/sendDetail.do"/>
			<input type="hidden" id="goods_seq" 	name="goods_seq" 	value="${param.goods_seq}" />
			<input type="hidden" id="real_amt" 		name="real_amt" 		value="${param.real_amt}" />
			<input type="hidden" id="real_vat" 		name="real_vat" 		value="${param.real_vat}" />
			<input type="hidden" id="sendtype" 		name="sendtype" 		value="5" />
			
				<jsp:include page="../send/sendDetailTabMenu.jsp" />
		<!-- LNB start -->
				
		
		
			<div id="content">
				
				<h2>발송등록</h2>
				<div class="comp">
					<fmt:parseDate value="${sendMngInfo.campaignStartDate}" var="campaignStartDate" pattern="yyyymmdd"/>
					<fmt:parseDate value="${sendMngInfo.campaignEndDate}" var="campaignEndDate" pattern="yyyymmdd"/>
					<fmt:parseDate value="${sendMngInfo.sendStartDate}" var="sendStartDate" pattern="yyyymmdd"/>
					<fmt:parseDate value="${sendMngInfo.sendEndDate}" var="sendEndDate" pattern="yyyymmdd"/>
					<table class="tbType02">
						
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%">
							<col style="width:15%;">
							<col style="width:35%">
						</colgroup>
						<tbody>
							<tr>
								<th>고객사/영업대행사</th>
								<td>${sendMngInfo.advName}/${sendMngInfo.agencyName}</td>
								<th>담당자명</th>
								<td>${sendMngInfo.contactName}</td>
							</tr>
							<tr>
								<th>담당자 연락처</th>
								<td>${sendMngInfo.telNumber}</td>
								<th>회신 전화번호</th>
								<td>${sendMngInfo.redTelNo}</td>
							</tr>
							<tr>
								<th>캠페인 명</th>
								<td colspan="3">${sendMngInfo.campaignName}</td>
							</tr>
							<tr>
								<th>캠페인 기간</th>
								<td colspan="3"><fmt:formatDate value="${campaignStartDate}" pattern="yyyy-mm-dd"/> ~ <fmt:formatDate value="${campaignEndDate}" pattern="yyyy-mm-dd"/></td>
							</tr>
							<tr>
								<th>대량발송 명</th>
								<td colspan="3">${sendMngInfo.sendName}</td>
							</tr>
							<tr>
								<th>대량발송 기간</th>
								<td colspan="3"><fmt:formatDate value="${sendStartDate}" pattern="yyyy-mm-dd"/> ~ <fmt:formatDate value="${sendEndDate}" pattern="yyyy-mm-dd"/></td>
							</tr>
							<tr>
								<th>승인상태</th>
								<c:if test="${sendAdminFlag == 'Y'}">
								<c:choose>
									<c:when test="${sendMngInfo.recStatus == '승인대기'}">
									<td colspan="1">
										${sendMngInfo.recStatus}
									</td>
									<td colspan="1">
									<select name="recStatus">
										<option value="" selected>선택</option>
										<option value="2">발송대기</option>
										<option value="5">반려</option>
									</select>
									</td>
									<td colspan="1">
									<a class="btnBase" onclick="javascript:goUpdateStatus();">변경</a>
									</td>
									<td colspan="1">
									</td>
									</c:when>
									<c:when test="${sendMngInfo.recStatus == '발송대기'}">
									<td colspan="1">
										${sendMngInfo.recStatus}
									</td>
									<td colspan="1">
									<select name="recStatus">
										<option value="" selected>선택</option>
										<option value="6">발송중지</option>
										<option value="5">반려</option>
									</select>
									</td>
									<td colspan="1">
									<a class="btnBase" onclick="javascript:goUpdateStatus();">변경</a>
									</td>
									</c:when>
									<c:otherwise>
									<td colspan="3">
										${sendMngInfo.recStatus}<c:if test="${sendMngInfo.recStatus == '반려'}">(<c:out value="${sendMngInfo.backComment}"/>)</c:if>
									</td>
									</c:otherwise>
								</c:choose>
								</c:if>
								<c:if test="${sendAdminFlag != 'Y'}">
									<td colspan="3">
										${sendMngInfo.recStatus}<c:if test="${sendMngInfo.recStatus == '반려'}">(<c:out value="${sendMngInfo.backComment}"/>)</c:if>
									</td>
								</c:if>
							</tr>
						</tbody>
					</table>
				</div>
				
				<c:if test="${sendMngInfo.recStatus == '등록중'}">
				<h2>대량발송 등록</h2>
				<div class="comp">
					<table class="tbType02">
						<caption>대량발송 등록</caption>	
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%">
							<col style="width:15%;">
							<col style="width:35%">
						</colgroup>
						<tbody>
							<tr>
								<th>MMS제목 (최대 20자)</th>
								<td colspan="3">
									<input type="text" name="mmsTitle" id="mmsTitle" placeholder="MMS제목" value=""  onkeyup="javascript:common_valFilter('mmsTitle');"/>
								</td>
							</tr>
							<tr>
								<th>발송일</th>
								<td colspan="1">
									<input type="text" name="resDate" id="resDate" width="50%" readonly value="" class="datepicker03">
								</td>
								<td colspan="1">
									<select name="resTime">
										<option value="090000"<c:if test="${nowTime eq '09'}"> selected</c:if>>09</option>
										<option value="100000"<c:if test="${nowTime eq '10'}"> selected</c:if>>10</option>
										<option value="110000"<c:if test="${nowTime eq '11'}"> selected</c:if>>11</option>
										<option value="120000"<c:if test="${nowTime eq '12'}"> selected</c:if>>12</option>
										<option value="130000"<c:if test="${nowTime eq '13'}"> selected</c:if>>13</option>
										<option value="140000"<c:if test="${nowTime eq '14'}"> selected</c:if>>14</option>
										<option value="150000"<c:if test="${nowTime eq '15'}"> selected</c:if>>15</option>
										<option value="160000"<c:if test="${nowTime eq '16'}"> selected</c:if>>16</option>
										<option value="170000"<c:if test="${nowTime eq '17'}"> selected</c:if>>17</option>
										<option value="180000"<c:if test="${nowTime eq '18'}"> selected</c:if>>18</option>
										<option value="190000"<c:if test="${nowTime eq '19'}"> selected</c:if>>19</option>
										<option value="200000"<c:if test="${nowTime eq '20'}"> selected</c:if>>20</option>
									</select>
								</td>
								<td colspan="1">
								</td>
							</tr>
							<tr>
								<th>상품</th>
								<td colspan="1">
									<input type="text" id="goods_name" name="goods_name" value="${param.goods_name}" readonly="readonly" />
								</td>
								<td colspan="1">
									<a class="btnBase" onclick="javascript:findName('/goods/searchGoodsList.do', 'goodscom2');"><spring:message code='common.search'/></a>
								</td>
								<td colspan="1">
								</td>																								
							</tr>
							<tr>
								<th>발송구분</th>
								<td>
									<span class="flowType"><input type="radio" name="sendtyperad" value="5" checked><label for="radio6">단일 수신자</label></span>
									<span class="flowType"><input type="radio" name="sendtyperad" value="1" ><label for="radio7">엑셀업로드</label></span>
								</td>
							</tr>
							
							<tr id="sendtype1">
								<th>수신자목록</th>
								<td colspan="2">
									<input type="file" name="sendListFile" id="sendListFile"  />
								</td>
								<td colspan="1">
								<a class="btnBase" onclick="javascript:goExcelDownload('${sendMngInfo.advName}', '${sendMngInfo.campaignName}');">샘플다운</a>
								</td>
							</tr>
							<tr id="sendtype2">
								<th>수신자번호</th>
								<td>
									<input type="text" name="sendphoneno" id="sendphoneno"  class="input_mobile" maxlength="11" value="" numberonly="true"/>
								</td>
								<th>수량</th>
								<td>
									<input type="text" name="sendcnt" id="sendcnt"  class="input_mobile" maxlength="4" value="" numberonly="true"/>
								</td>
							</tr>
							
							<tr>
								<th>MMS전송메세지(200자)</th>
								<td colspan="3">
									<textarea id="mmsSendMsg" name="mmsSendMsg" style="width:100%;height:100px;" onkeyup="javascript:mmsHtmlLengthChk(this); common_valFilter('mmsSendMsg');" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btnArea alignC"><a class="btnType05" href="javascript:goBuyHistInsert()"><spring:message code='common.registration'/></a></div>
				</div>

				</c:if>
				
				
				
				
				
				
				<h2>상세정보</h2>
				<div class="comp">
					<table class="tbType01">
					
						<thead>
							<tr>
								<th>번호</th>
								<th>발송번호</th>
								<th>상품번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>단가</th>
								<th>유효기간</th>
								<th>MMS제목</th>
								<th>예약시간</th>
								<th>발송상태</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${empty buyHistInfoList}">
							<tr>
								<td colspan="10" class="alignC">검색 결과가 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${buyHistInfoList}" var="buylist" varStatus="status" >
						<fmt:parseDate value="${buylist.resDate}" var="resDate" pattern="yyyyMMdd"/>
						<fmt:parseDate value="${buylist.resTime}" var="resTime" pattern="HHmmss"/>
							<tr>
								<td class="alignC">${status.count}</td>
								<td class="alignC">${buylist.buyNo}</td>
								<td class="alignC">${buylist.goodsSeq}</td>
								<td class="alignC">${buylist.goodsName}</td>
								<td class="alignC"><fmt:formatNumber value="${buylist.sendCount}" pattern="#,###" /> 건</td>
								<td class="alignC"><fmt:formatNumber value="${buylist.realAmount}" pattern="#,###" /> 원</td>
								<td class="alignC"><fmt:formatNumber value="${buylist.limitDate}" pattern="#,###" /> 일</td>
								<td class="alignC">${buylist.mmsTitle}</td>
								<td class="alignC"><fmt:formatDate value="${resDate}" pattern="yyyy-MM-dd"/> <fmt:formatDate value="${resTime}" pattern="HH:mm:ss"/></td>
								<td class="alignC">${buylist.mmsSendStatus}</td>
							</tr>
						</c:forEach>	
						</c:otherwise>
						</c:choose>
						</tbody>
						
					</table>
				</div>
				

				<h2>대량발송 총 합계</h2>
				<div class="comp">
					<table class="tbType02">
					
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:15%;">
							<col style="width:35%;">
						</colgroup>
						<tbody>
							<tr>
								<th>총 발송 건수</th>
								<td colspan="3">총 <strong><fmt:formatNumber value="${sendMngInfo.totSendEstCnt}" pattern="#,###" /></strong> 건</td>
							</tr>
							<tr>
								<th>총 합계 금액</th>
								<td colspan="3"><strong><fmt:formatNumber value="${sendMngInfo.totSendEstAmt}" pattern="#,###" /></strong> 원</td>
							</tr>
						</tbody>
					</table>
				</div>
				
			</div>
			</form>
			<div class="btnArea alignR">
				<%-- <c:if test="${sendMngInfo.recStatus == '등록중'}"> --%>
				<a class="btnType05" href="javascript:goRegDone();">등록완료</a>
				<%-- </c:if> --%>
				<a class="btnType04" href="/send/sendList.do">목록보기</a>
			</div>
		</section>
	</section>

	<footer>
			<%@ include file="../include/footer.jsp"%>
		</footer>
</div>
<iframe name="downloadIframe" id="downloadIframe" src="" height="0"></iframe>
</body>
</html>