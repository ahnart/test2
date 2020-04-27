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
<title>계정관리 | EPOPKON</title>
<meta name="Description" content="Qool Solutions">
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/ui.js"></script>
<script type="text/javascript" src="/js/paging.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
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
					if ('userList' == $(this).attr('class')) {
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
				$('#brand_name').keydown(function(key) {
					if (key.keyCode == 13) {/* 13 == enter key@ascii */
						goSearch();
					}
				});
				// enterKey event end

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/system/userList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(userNo) {
		commonGetUrl('/system/userDetail.do', 'user_no=' + userNo
				+ '&listpage=' + iCurrPage);
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
			var gnbType = 'systemMng';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("systemMng" == $(this).attr('class')) {
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
					<li><a href="/user/user_list" class="userList on">계정관리</a></li>
					<li><a href="/user/commCodeList.do" class="commCodeList">공통코드관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/system/commCodeList.do">시스템관리</a> &gt; <a href="/system/userList.do" class="on">계정관리</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="3" />

					<div class="search">
						<div class="row">
							<strong>검색조건</strong> <select name="search_type">
								<option value="">선택</option>
								<option value="id">계정</option>
								<option value="name">회원명</option>
							</select> <input type="text" name="search_keyword" id="search_keyword" value="" /> <a class="btnType02" onclick="javascipt:goSearch();">조회</a>
						</div>
					</div>

					<div id="content">
						<h2>회원목록</h2>
						<span class="topAdd right">전체 : <strong>3</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>회원목록</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>계정</th>
										<th>회원명</th>
										<th>소속(팀)</th>
										<th>연락처(HP)</th>
										<th>등록일짜</th>
									</tr>

								</thead>
								<tbody>
								
									<tr onclick="javascript:goDetail('2');" style="cursor: pointer;">
										<td class="alignC">1</td>
										<td class="alignC"><a href="/company/userDetail">test</a></td>
										<td class="alignC"><a href="/company/userDetail">테스트</a></td>
										<td class="alignC"><a href="/company/userDetail">테스트</a></td>
										<td class="alignC">01012341234</td>
										<td class="alignC">2016-05-27</td>
									</tr>

									<tr onclick="javascript:goDetail('1');" style="cursor: pointer;">
										<td class="alignC">1</td>
										<td class="alignC">couponadmin</td>
										<td class="alignC">관리자</td>
										<td class="alignC">운영관리팀</td>
										<td class="alignC">01012341234</td>
										<td class="alignC"></td>
									</tr>
								
								
									<tr onclick="javascript:goDetail('3');" style="cursor: pointer;">
										<td class="alignC">3</td>
										<td class="alignC">baemin</td>
										<td class="alignC">배달의민족</td>
										<td class="alignC">COO</td>
										<td class="alignC">01012341234</td>
										<td class="alignC">2017-03-16</td>
									</tr>
								
								
									<tr onclick="javascript:goDetail('4');" style="cursor: pointer;">
										<td class="alignC">4</td>
										<td class="alignC">ahnart</td>
										<td class="alignC">안아트</td>
										<td class="alignC">SYSCUSS</td>
										<td class="alignC">01043215432</td>
										<td class="alignC">2020-04-16</td>
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
					<a class="btnType05" href="/company/userForm">등록</a>
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
