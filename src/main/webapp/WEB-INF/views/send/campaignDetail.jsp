<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>캠페인관리 | 캠페인 등록</title>
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
	
	// paging start
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	if($("#pagecount").val() == ""){
		$("#pagecount").val("50");
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
	$("#frm").attr("action", "/send/campaignList.do");
	$("#frm").submit();
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

	<!-- Header end -->
	
	<section id="container" class="clearfix">
		<!-- LNB start -->
		
<nav id="nav">
	<ul>
		<li><a href="/send/campaignList.do" class="campaignMng on">캠페인관리</a></li>
		<li><a href="/send/sendList.do" class="sendMng">발송관리</a></li>
	</ul>
</nav>
		<section id="section">
			<!-- gnb start -->
			<div class="bradcrumb">
				<a href="/"></a> &gt; <a href="/send/campaignList.do"></a> &gt; <a href="/send/campaignList.do" class="on">캠페인등록</a>
			</div>
			<!-- gnb end -->
			<form name="frm" id="frm" method="post" >
			<input type="hidden" id="campaignno" name="campaignno" value="<c:out value='${param.campaignno}'/>" />
			<input type="hidden" id="advId" name="advId" value="${sendMngInfo.advId}"/>
			<input type="hidden" id="redirectURL" name="redirectURL" value="/send/campaignDetail.do"/>


			<div id="content">
				
				<h2>캠페인등록</h2>
				<div class="comp">
					<fmt:parseDate value="${campaignInfo.campaignStartDate}" var="campaignStartDate" pattern="yyyymmdd"/>
					<fmt:parseDate value="${campaignInfo.campaignEndDate}" var="campaignEndDate" pattern="yyyymmdd"/>
					<table class="tbType02">
						
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%">
							<col style="width:15%;">
							<col style="width:35%">
						</colgroup>
						<tbody>
							<tr>
								<th>캠페인 명</th>
								<td colspan="3">${campaignInfo.campaignName}</td>
							</tr>					
							<tr>
								<th>고객사</th>
								<td colspan="3">${campaignInfo.advName}</td>
							</tr>
							<tr>
								<th>캠페인 기간</th>
								<td colspan="3"><fmt:formatDate value="${campaignStartDate}" pattern="yyyy-mm-dd"/> ~ <fmt:formatDate value="${campaignEndDate}" pattern="yyyy-mm-dd"/></td>
							</tr>
							<tr>
								<th>집행예상금액</th>
								<td colspan="3"><strong><fmt:formatNumber value="${campaignInfo.exeEstAmt}" pattern="#,###" /></strong>원</td>
							</tr>
						</tbody>
					</table>
				</div>

				<h2>상세정보</h2>
				<div class="comp">
					<table class="tbType01">
					
						<thead>
							<tr>
								<th>번호</th>
								<th>발송명</th>
								<th>상품명</th>
								<th>발송기간</th>
								<th>발송건수</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${empty buyHistVoList}">
							<tr>
								<td colspan="6" class="alignC">검색 결과가 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${buyHistVoList}" var="buylist" varStatus="status" >
						<fmt:parseDate value="${buylist.resDate}" var="resDate" pattern="yyyyMMdd"/>
						<fmt:parseDate value="${buylist.resTime}" var="resTime" pattern="HHmmss"/>
							<tr>
								<td class="alignC">${status.count}</td>
								<td class="alignC">${buylist.sendName}</td>
								<td class="alignC">${buylist.goodsName}</td>
								<td class="alignC"><fmt:formatDate value="${resDate}" pattern="yyyy-MM-dd"/> <fmt:formatDate value="${resTime}" pattern="HH:mm:ss"/></td>								
								<td class="alignC"><fmt:formatNumber value="${buylist.goodsTotalCount}" pattern="#,###" /> 건</td>
								<td class="alignC">${buylist.mmsSendStatus}</td>
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
				<a class="btnType04" href="/send/campaignList.do">목록보기</a>
			</div>
		</section>
	</section>
	
	
	<footer>
			<%@ include file="../include/footer.jsp"%>
		</footer>
</div>
</body>
</html>
