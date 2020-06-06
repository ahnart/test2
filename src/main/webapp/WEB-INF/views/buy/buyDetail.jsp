<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title> | buyDetail</title>
<meta name="Description" content="Qool Solutions">
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
			if ('buyList' == $(this).attr('class')) {
				$(this).addClass('on');
			}
		});
		// left menu setting end

		// tab menu setting start
		$(".tabType01 > ul > li").each(function() {
			$(this).removeClass('on');
			if ('buyBasic' == $(this).attr('id')) {
				$(this).addClass('on');
			}
		});
		// tab menu setting end

		onLoadSetting();

	});
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
						<li><a href="/send/campaignList" class="sendMng ">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng on">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng">상품관리</a></li>
						<li><a href="/account/accountListDay.do" class="accountMng">정산관리</a></li>
						<li><a href="/user/user_list" class="systemMng ">시스템관리</a></li>
					</ul>
				</div>
			</section>
		</c:if>
		
		<section id="container" class="clearfix">
			<!-- LNB start -->
			<nav id="nav">
				<ul>
					<li><a href="/user/buy_list.do" class="buyList on">구매조회</a></li>
					<li><a href="/send/sendFailList.do" class="sendFailMng">발송실패관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->
			
			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">타이틀</a> &gt; 
					<a href="/buy/buyList.do">타이틀</a> &gt; 
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" enctype="multipart/form-data" method="post">
					
					<!-- tab start -->
					
					<!-- tab end -->
					
					<div id="content">
						<div class="comp">
							<table class="tbType02">
								
								<tbody>
									<tr>
										<th>타이틀</th>
										<td>타이틀</td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td colspan="3">
											<div class="col-three">
												<span class="flowType">타이틀</span> 
												<a class="btnBase" id="resendMmsBtn" onclick="javascript:openPopResend('1')">MMS </a> 
												<a class="btnBase" id="resendSmsBtn" onclick="javascript:openPopResend('2')">SMS </a> 
												<a class="btnBase" id="reissueBtn" onclick="javascript:openPopResend('3')">SNS</a>
											</div>
										</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td colspan="3">
											<div class="col-three">
												<select name="pin_status" id="pin_status">
													<option value="">타이틀
												</select> <a class="btnBase" id="changePinBtn">타이틀</a>
											</div>
										</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td>타이틀</td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td>타이틀</td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td><span class="flowType">
										<input type="text" id="res_cust_phone_no" name="res_cust_phone_no" value="'buyBasicVo.resCustPhoneNo}" /></span> 
										<a class="btnBase" id="changeResBtn" onclick="javascript:openPopChangeResCustPhoneNoPop();">타이틀</a></td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td colspan="3">타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td>타이틀</td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td>타이틀</td>
										<th>타이틀</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td colspan="3">
											<div class="calendar">
												<input type="text" name="startDate" id="startDate" readonly value="'buyBasicVo.limitStartDate}" class="datepicker01">
											</div>
											<span> ~ </span>
										<div class="calendar">
												<input type="text" name="endDate" id="endDate" readonly value="'buyBasicVo.limitEndDate}" class="datepicker02">
											</div> <span id="changeLimitDateBtn"> <a class="btnBase" onclick="javascript:openPopChangeLimitDate();">ㅇㅇㅇ</a> 
										</span>
										</td>
									</tr>
									<tr>
										<th>타이틀</th>
										<td><a class="btnBase" onclick="javascript:mmsImgPreview();"></a></td>
										<th>MMS</th>
										<td>타이틀</td>
									</tr>
									<tr>
										<th>MMS</th>
										<td>타이틀</td>
										<th>MMS</th>
										<td>타이틀</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</form>
				<div class="btnArea alignR">
					<a class="btnType04" href="/user/buy_list">목록보기</a>
				</div>
			</section>
		</section>

		<footer>
			<%@ include file="../include/footer.jsp"%>
		</footer>
	</div>
</body>
</html>
