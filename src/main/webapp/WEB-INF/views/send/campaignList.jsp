<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>구매관리 | SISCUS</title>
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

	$(document).ready(
			function() {
				// left menu setting start
				$("#nav > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ('campaignMng' == $(this).attr('class')) {
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

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/send/campaignList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(campaignNo) {
		commonGetUrl('/send/campaignDetail.do', 'campaignno=' + campaignNo
				+ '&listpage=' + iCurrPage);
	}

	function setAdvInfo() {
		var advId = jQuery("#SELECT_ADV option:selected").val();
		jQuery("#advId").val(advId);
		jQuery("#advid_usergubun").val(
				jQuery("#SELECT_ADV option:selected").attr('id'));
	}
</script>
</head>

<body>
	<div id="wrap">
		<!-- Header start -->
		<script type="text/javascript" src="/resources/js/jquery/jquery.i18n.properties-1.0.9-min.js"></script>
		<script type="text/javascript" src="/resources/js/jquery/jquery-ui.js"></script>

		<script type="text/javascript">
			
		</script>
		<script type="text/javascript" src="/resources/js/jquery/jquery.cookie.js"></script>
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
					<li><a href="/send/campaignList.do" class="campaignMng on">캠페인관리</a></li>
					<li><a href="/send/sendList.do" class="sendMng">발송관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/send/campaignList.do">발송관리</a> &gt; <a href="/send/campaignList.do" class="on">캠페인관리</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="campaignSeq" name="campaignSeq" /> <input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input
						type="hidden" id="pagetotal" name="pagetotal" value="0" /> <input type="hidden" id="advId" name="advId" value="" /> <input type="hidden" id="advid_usergubun" name="advid_usergubun" value="" />

					<div class="search clearfix">
						<div class="half-col">
							<div class="row">
								<strong>캠페인기간</strong>
								<div class="calendar">
									<input type="text" name="sstartdate" id="sstartdate" value="2020-01-12" class="datepicker01">
								</div>
								<span> ~ </span>
								<div class="calendar">
									<input type="text" name="senddate" id="senddate" value="2020-04-21" class="datepicker02">
								</div>
							</div>
							<div class="row">
								<strong>캠페인명</strong> <input type="text" name="sCampaignName" id="sCampaignName" value="" />
							</div>



						</div>
						<div class="half-col">
							<div class="row">
								<strong>캠페인상태</strong> <select name="scampaignstatus">
									<option value="" selected>전체</option>
									<option value="Y">캠페인 중</option>
									<option value="N">캠페인 종료</option>
								</select>
							</div>
							<div class="row">
								<strong>캠페인번호</strong> <input type="text" name="scampaignmngno" id="scampaignmngno" value="" />
							</div>
							<a class="btnType02 right" onclick="javascipt:goSearch();">조회</a>
						</div>

					</div>

					<div id="content">
						<h2>캠페인 목록</h2>
						<span class="topAdd right">전체 : <strong>0</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>구매목록</caption> -->
								<thead>
									<tr>
										<th>번호</th>
										<th>캠페인번호</th>
										<th>고객사명</th>
										<th>캠페인명</th>
										<th>캠페인기간</th>
										<th>집행예상금액</th>
										<th>캠페인상태</th>
									</tr>
								</thead>
								<tbody>


									<tr>
										<td colspan="7" class="alignC">검색 결과가 없습니다.</td>
									</tr>




								</tbody>

							</table>
						</div>
					</div>
				</form>

				<div class="sortArea">
					<div class="paging mt20" id="paging"></div>
				</div>
				<div class="btnArea alignR">
					<a class="btnType05" href="/send/insertCampaignForm.do">등록</a>
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
