<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<title>기업관리 | EPOPKON</title>
<meta name="Description" content="Qool Solutions">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" />
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/js/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/js/common/ui.js"></script>
<script type="text/javascript" src="/js/common/paging.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
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
					if ('companyList' == $(this).attr('class')) {
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

				$("select[name='search_type']").bind('change', function() {
					$("#search_keyword").val("");
				});

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/company/companyList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(userId, userGubun) {
		commonGetUrl('/company/companyDetail.do', 'user_id=' + userId
				+ '&user_gubun=' + userGubun + '&listpage=' + iCurrPage);
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
			var gnbType = 'companyMng';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("companyMng" == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// gnb setting end
			});
		</script>
		<header id="header" class="clearfix">
			<%@ include file="../include/header.jsp"%>
		</header>

		<c:if test="${member != null}">
			<section id="gnb">
				<div class="container">
					<ul class="clearfix">
						<li><a href="/user/user_main" class="companyMng on">기업관리</a></li>
						<li><a href="/send/campaignList" class="sendMng">발송관리</a></li>
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
					<li><a href="/user/user_main" class="companyList on">기업관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">CouponCMS</a> &gt; <a href="/user/user_main">기업관리</a> &gt; <a href="/user/user_main" class="on">기업목록</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="1" />

					<div class="search">
						<select name="search_type">
							<option value="">선택</option>
							<option value="user_id">ID</option>
							<option value="biz_name">기업명</option>
							<option value="cust_user_name">담당자</option>
							<!-- option value="sales_name"  >매출담당</option-->
						</select> <input type="text" name="search_keyword" id="search_keyword" value="" /> <select name="user_gubun">
							<option value="">기업구분</option>
							<option value="M002">매체사</option>
							<option value="G002">상품공급사</option>
							<option value="Y002">영업대행사</option>
							<option value="Y003">광고주</option>
						</select> <select name="user_status">
							<option value="">상태</option>
							<option value="1">거래중</option>
							<option value="2">거래중지</option>
							<option value="3">승인대기</option>
							<option value="4">해지</option>
						</select> <a class="btnType02" onclick="javascipt:goSearch();">조회</a>
					</div>
					<div id="content">
						<h2>기업목록</h2>
						<span class="topAdd right">전체 : <strong>1</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- 	<caption>기업목록</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>기업서비스구분</th>
										<th>ID</th>
										<th>기업명[법인명]</th>
										<th>담당자</th>
										<!-- th>매출담당</th-->
										<th>상태</th>
										<th>가입일짜</th>
									</tr>
								</thead>
								<tbody>





									<tr style="cursor: pointer;">
										<td class="alignC">1</td>
										<td class="alignC">매체사</td>
										<td class="alignC">comang</td>
										<td class="alignC"><a href="/company/companyDetail">꼬망세[(주)꼬망세미디어]</a></td>
										<td class="alignC">고미정</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2015-10-16</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('testmhouse','G002');">
										<td class="alignC">1</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">testmhouse</td>
										<td class="alignC">(테)엠하우스[(테)엠하우스]</td>
										<td class="alignC">(테)엠하우스</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2020-04-12</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('itemroad','M002');">
										<td class="alignC">2</td>
										<td class="alignC">매체사</td>
										<td class="alignC">itemroad</td>
										<td class="alignC">아이템로드2[(주)아이템로드2]</td>
										<td class="alignC">방충기</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2017-03-17</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('baemin','G002');">
										<td class="alignC">3</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">baemin</td>
										<td class="alignC">배달의민족[(주)우아한형제들]</td>
										<td class="alignC">권용철</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2017-03-16</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('dgmit','M002');">
										<td class="alignC">4</td>
										<td class="alignC">매체사</td>
										<td class="alignC">dgmit</td>
										<td class="alignC">디지엠정보기술 (주)[디지엠정보기술 (주)]</td>
										<td class="alignC">박정민</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2017-02-21</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('cmmarketing','M002');">
										<td class="alignC">5</td>
										<td class="alignC">매체사</td>
										<td class="alignC">cmmarketing</td>
										<td class="alignC">씨엠마케팅[씨엠마케팅컴퍼니(주)]</td>
										<td class="alignC">강현우</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-09-09</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('smilecon','G002');">
										<td class="alignC">6</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">smilecon</td>
										<td class="alignC">스마트콘[(주)즐거운]</td>
										<td class="alignC">정원호</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-09-04</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('dstar','G002');">
										<td class="alignC">7</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">dstar</td>
										<td class="alignC">와이지리테일[(주)와이지리테일]</td>
										<td class="alignC">이동우</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-06-21</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('aram','M002');">
										<td class="alignC">8</td>
										<td class="alignC">매체사</td>
										<td class="alignC">aram</td>
										<td class="alignC">아람커뮤니케이션[(주)아람커뮤니케이션]</td>
										<td class="alignC">손상기</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-06-08</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('omnitel','G002');">
										<td class="alignC">9</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">omnitel</td>
										<td class="alignC">옴니텔[(주)옴니텔]</td>
										<td class="alignC">이현주</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-05-24</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('moneycon','G002');">
										<td class="alignC">10</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">moneycon</td>
										<td class="alignC">머니콘[(주)이포르테]</td>
										<td class="alignC">소유정</td>
										<!-- td class="alignC"></td-->
										<td class="alignC"></td>
										<td class="alignC">2016-04-18</td>
									</tr>


								</tbody>

							</table>
						</div>
					</div>
				</form>

				<div class="sortArea">
					<div class="paging mt20" id="paging">
						<span class="paginator"><a class="on" href="javascript:goPageNo(1)" title="1" alt="1">1</a></span>
						<span class="paginator"><a class="" href="javascript:goPageNo(2)" title="2" alt="2">2</a></span>
						<span class="paginator"><a class="" href="javascript:goPageNo(3)" title="3" alt="3">3</a></span>
					</div>

				</div>

				<div class="btnArea alignR">
					<a class="btnType05" href="/company/companyForm">등록</a>
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

	</div>
	<!-- Header end -->

</body>
</html>
