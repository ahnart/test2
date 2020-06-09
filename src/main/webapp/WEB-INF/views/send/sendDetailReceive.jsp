<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>발송관리 | SISCUS</title>
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

var iCurrPage = "";
var iTotalCount = "";
var iPageRow = "";
var iPageBlock = "";

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
		if('sendReceive' == $(this).attr('id')){
			$(this).addClass('on');
		}
	});
	// tab menu setting end
	
	// paging start
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	if($("#pagecount").val() == ""){
		$("#pagecount").val("10");
	}
	iCurrPage = $("#page").val();
	iTotalCount = $("#pagetotal").val();
	iPageRow = $("#pagecount").val();
	iPageBlock = "10";
	
	$(".paging").html(pageNavigator(iCurrPage, iTotalCount, iPageRow, iPageBlock, "goPageNo", "on"));
	// paging end
	
	// search selectbox change event start
	$("select[name='search_type']").bind('change', function(){
		$("#search_keyword").val("");
	});
	// search selectbox change event end
	
	
});

function goPageNo(pageNo){
	$("#page").val(pageNo);
	$("#frm").attr("action", "/send/sendDetailReceive.do");
	$("#frm").submit();
}

function goSearch(){
	goPageNo(1);
}

function goDetail(sendMngNo){
	commonGetUrl('/send/sendDetailReceive.do', 'sendmngno='+sendmngno+'&listpage='+iCurrPage);
}

function setAdvInfo(){
	var advId = jQuery("#SELECT_ADV option:selected").val();
	jQuery("#advId").val(advId);
	jQuery("#advid_usergubun").val( jQuery("#SELECT_ADV option:selected").attr('id') );
}

var iframe;
function goExcelDownload(){
	var $iframe = jQuery("#downloadIframe");
	var url = "/send/sendDetailReceiveExcel.do?sendmngno=${param.sendmngno}";
	$iframe.attr('src', url);
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
					if ("sendMng" == $(this).attr('class')) {
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
		
		
		<section id="container" class="clearfix">
			<!-- LNB start -->

			<nav id="nav">
				<ul>
					<li><a href="/send/campaignList.do" class="campaignMng">캠페인관리</a></li>
					<li><a href="/send/sendList.do" class="sendMng on">발송관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/send/campaignList.do">발송관리</a> &gt; <a href="/send/sendList.do" class="on">발송정보</a>
				</div>
				<!-- gnb end -->
					<!-- tab start -->
			<jsp:include page="../send/sendDetailTabMenu.jsp" />
			<!-- tab end -->
			
			<form name="frm" id="frm" method="post" >
			<input type="hidden" id="sendmngno" 	name="sendmngno" value="${param.sendmngno}"/>
			<input type="hidden" id="page" 				name="page" 			value="${param.page}" />
			<input type="hidden" id="pagecount"  		name="pagecount"  		value="${param.pagecount}" />
			<input type="hidden" id="pagetotal" 	 	name="pagetotal" 		value="${totalPage}" />
			
			<input type="hidden" id="advId" name="advId" value="<c:out value='${decryptAdvId}'/>"/>
			<input type="hidden" id="advid_usergubun" name="advid_usergubun" value="${advIdUserGubun }" />
			
			<div class="search clearfix">
				<div class="half-col">
					<div class="row">
						<strong>휴대폰번호</strong>
						<input type="text" name="srescustphoneno" id="srescustphoneno" class="input_mobile" maxlength="11"  value="${param.srescustphoneno}" />
					</div>
					<a class="btnType02 right" onclick="javascipt:goSearch();">goSearch</a>
				</div>
			
			</div>
			
			<div id="content">
				<h2>전체</h2><span class="topAdd right"><spring:message code='common.total'/>합계 : <strong><fmt:formatNumber value="2560" pattern="#,###" /></strong><spring:message code='common.count'/></span>
				<div class="comp">
					<table class="tbType01">
						<%-- <caption>발송정보</caption>	 --%>
						<thead>
							<tr>
								<th>번호</th>
								<th>휴대폰번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>상품단가</th>
								<th>유효기간</th>
								<th>발송시간</th>
								<th>수신시간</th>
								<th>수신상태</th>
								<th>교환시간</th>
								<th>교환상태</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${empty sendHistList}">
							<tr>
								<td colspan="10" class="alignC">등록된 정보가 없습니다 </td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${sendHistList}" var="list" varStatus="status" >
						<fmt:parseDate value="${list.mmsSendDate}" var="sendDate" pattern="yyyyMMddHHmmss"/>
						<fmt:parseDate value="${list.mmsRecDate}" var="receiveDate" pattern="yyyyMMddHHmmss"/>
						<fmt:parseDate value="${list.mmsTrdDate}" var="tradeDate" pattern="yyyyMMddHHmmss"/>
							<tr>
								<td class="alignC">${list.rNum}</td>
								<td class="alignC">${list.resCustPhoneNo}</td>
								<td class="alignC">${list.goodsName}</td>
								<td class="alignC"><fmt:formatNumber value="${list.goodsCnt}" pattern="#,###" /></td>
								<td class="alignC"><fmt:formatNumber value="${list.realAmount}" pattern="#,###" /></td>
								<td class="alignC"><fmt:formatNumber value="${list.limitDate}" pattern="#,###" /></td>
								<td class="alignC"><fmt:formatDate value="${sendDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td class="alignC"><fmt:formatDate value="${receiveDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td class="alignC">${list.mmsRecStatus}</td>
								<td class="alignC"><fmt:formatDate value="${tradeDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td class="alignC">${list.mmsTrdStatus}</td>
							</tr>
						</c:forEach>	
						</c:otherwise>
						</c:choose>
						</tbody>
						
					</table>
				</div>
			</div>
			</form>
			
			<div class="sortArea">
				<div class="paging mt20" id="paging"></div>
			</div>
			<div class="btnArea alignR">
				<a class="btnType05" href="javascript:goExcelDownload();">다운로드</a>
				<a class="btnType04" href="/send/sendList.do">목록보기></a>
			</div>
			</section>
		</section>

		<!-- Header start -->



		<script type="text/javascript">
			var openPop;
			function goFooterMenu(type) {
				if (openPop)
					openPop.close();

				switch (type) {
				case "1":
					location.href = "/customer/noticeList.do";
					break;
				case "2":
					location.href = "/customer/terms.do";
					break;
				case "3":
					location.href = "/customer/privacy.do";
					break;
				case "4":
					openPop = window
							.open("", "winPop",
									"width=550px, height=850px, scrollbars=0, resizable=0");
					break;
				case "5":
					location.href = "/customer/trading.do";
					break;
				case "6":
					location.href = "/customer/inquiryInsertForm.do";
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
