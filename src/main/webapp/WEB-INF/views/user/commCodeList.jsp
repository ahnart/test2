<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.apache.commons.lang.ObjectUtils" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/jquery-ui.css" />
<title>시스템관리 | SISCUS</title>
<meta name="Description" content="Qool Solutions">
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/ui.js"></script>
<script type="text/javascript" src="/resources/js/paging.js"></script>
<script type="text/javascript" src="/resources/js/commmon.js"></script>
<script type="text/javascript" src="/resources/js/main.js"></script>
<script type="text/javascript">
	var iCurrPage = "";
	var iTotalCount = "";
	var iPageRow = "";
	var iPageBlock = "";

	$(document).ready(
			function() {
				// left menu setting start
				$("#nav > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ('commCodeList' == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// left menu setting end

				// paging start
				if ($("#page").val() == "") {
					$("#page").val("1");
				}

				if ($("#pagecount").val() == "") {
					$("#pagecount").val("10");
				}
				iCurrPage = $("#page").val();
				iTotalCount = $("#pagetotal").val();
				iPageRow = $("#pagecount").val();
				iPageBlock = "10";

				$(".paging").html(
						pageNavigator(iCurrPage, iTotalCount, iPageRow,
								iPageBlock, "goPageNo", "on"));
				// paging end

				// search selectbox change event start
				$("select[name='search_type']").bind('change', function() {
					$("#search_keyword").val("");
				});
				// search selectbox change event end

				// enterKey event start
				$('#search_keyword').keydown(function(key) {
					if (key.keyCode == 13) {/* 13 == enter key@ascii */
						goSearch();
					}
				});
				// enterKey event end

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/user/commCodeList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(codeGrpId) {
		commonGetUrl('/user/commCodeDetail', 'code_grp_id=' + codeGrpId
				+ '&listpage=' + iCurrPage);
	}
</script>

<script type="text/javascript" src="/resources/js/jquery/jquery.i18n.properties-1.0.9-min.js"></script>
		<script type="text/javascript" src="/resources/js/jquery/jquery-ui.js"></script>
		<script type="text/javascript">
		</script>
		<script type="text/javascript" src="/resources/js/jquery/jquery.cookie.js"></script>
		<script type="text/javascript">
		<%
		String url = request.getRequestURL().toString();
		String gnbType = "";
		if( url.indexOf("company/") > 0 ) 		gnbType = "companyMng";
		else if( url.indexOf("send/") > 0 ) 	gnbType = "sendMng";
		else if( url.indexOf("buy/") > 0 ) 		gnbType = "buyMng";
		else if( url.indexOf("goods/") > 0 ) 	gnbType = "goodsMng";
		else if( url.indexOf("account/") > 0 ) 	gnbType = "accountMng";
		else if( url.indexOf("system/") > 0 ) 	gnbType = "systemMng";

		%>
			// menu setting
			var gnbType = '<%=gnbType%>';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("<%=gnbType%>" == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// gnb setting end
			});
		</script>
</head>

<body>
	<div id="wrap">
		<!-- Header start -->
		
		<header id="header" class="clearfix">
			<%@ include file="../include/header.jsp"%>
		</header>

		<c:if test="${member != null}">
			<section id="gnb">
				<div class="container">
					<ul class="clearfix">
						<li><a href="/user/user_main" class="companyMng ">기업관리</a></li>
						<li><a href="/send/campaignList" class="sendMng ">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng">상품관리</a></li>
						<li><a href="/account/accountListDay.do" class="accountMng">정산관리</a></li>
						<li><a href="/user/user_list" class="systemMng on">시스템관리</a></li>
					</ul>
				</div>
			</section>
		</c:if>

		<section id="container" class="clearfix">
			<!-- LNB start -->

			<nav id="nav">
				<ul>
					<li><a href="/user/user_list" class="userList">계정관리</a></li>
					<li><a href="/user/commCodeList.do" class="commCodeList on">공통코드관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/user/commCodeList.do">시스템관리</a> &gt; <a href="/user/commCodeList.do" class="on">공통코드 목록</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="8" />

					<div class="search">
						<select name="search_type">
							<option value="">선택</option>
							<option value="code_grp_id">공통코드 구분 ID</option>
							<option value="code_name">공통코드 구분 명</option>
						</select> <input type="text" name="search_keyword" id="search_keyword" value="" /> <a class="btnType02" onclick="javascipt:goSearch();">조회</a>
					</div>

					<div id="content">
						<h2>공통코드 목록</h2>
						<span class="topAdd right">전체 : <strong>8</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>공통코드 목록</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>공통코드 구분 ID</th>
										<th>공통코드 구분 명</th>
										<th>사용유무</th>
										<th>등록일짜</th>
									</tr>
								</thead>
								<tbody>

									<tr onclick="location.href='/user/commCodeDetail'" style="cursor: pointer;">
										<td class="alignC">1</td>
										<td class="alignC">B2B_USER_TYPE</td>
										<td class="alignC">고객 구분</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-08-13</td>
									</tr>


									<tr onclick="javascript:goDetail('GIFTCARD');" style="cursor: pointer;">
										<td class="alignC">2</td>
										<td class="alignC">GIFTCARD</td>
										<td class="alignC">GIFTCARD</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-12-15</td>
									</tr>


									<tr onclick="javascript:goDetail('GOODS_GUBUN');" style="cursor: pointer;">
										<td class="alignC">3</td>
										<td class="alignC">GOODS_GUBUN</td>
										<td class="alignC">상품구분</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-10-16</td>
									</tr>


									<tr onclick="javascript:goDetail('GOODS_MMS_IMG_TYPE');" style="cursor: pointer;">
										<td class="alignC">4</td>
										<td class="alignC">GOODS_MMS_IMG_TYPE</td>
										<td class="alignC">MMS발송이미지</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-11-29</td>
									</tr>


									<tr onclick="javascript:goDetail('GOODS_STATUS');" style="cursor: pointer;">
										<td class="alignC">5</td>
										<td class="alignC">GOODS_STATUS</td>
										<td class="alignC">상품상태</td>
										<td class="alignC">사용</td>
										<td class="alignC">2016-06-08</td>
									</tr>


									<tr onclick="javascript:goDetail('PIN_STATUS');" style="cursor: pointer;">
										<td class="alignC">6</td>
										<td class="alignC">PIN_STATUS</td>
										<td class="alignC">핀상태코드</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-08-13</td>
									</tr>


									<tr onclick="javascript:goDetail('REA');" style="cursor: pointer;">
										<td class="alignC">7</td>
										<td class="alignC">REA</td>
										<td class="alignC">REA</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-10-16</td>
									</tr>


									<tr onclick="javascript:goDetail('USECOM_CODE');" style="cursor: pointer;">
										<td class="alignC">8</td>
										<td class="alignC">USECOM_CODE</td>
										<td class="alignC">교환처코드</td>
										<td class="alignC">사용</td>
										<td class="alignC">2015-10-16</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</form>

				<div class="sortArea">
					<div class="paging mt20" id="paging">
					<span class="paginator"><a class="on" href="javascript:goPageNo(1)" title="1" alt="1">1</a></span>
					</div>
				</div>
				<div class="btnArea alignR">
					<a class="btnType05" href="/user/insertCommCodeForm.do">등록</a>
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
