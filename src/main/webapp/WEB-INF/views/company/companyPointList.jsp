<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<title>금액정보 | SISCUS</title>
<meta name="Description" content="Qool Solutions">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
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

				// tab menu setting start
				$(".tabType01 > ul > li").each(function() {
					$(this).removeClass('on');
					if ('companyPoint' == $(this).attr('id')) {
						$(this).addClass('on');
					}
				});
				// tab menu setting end

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

				// only number check start
				$("#amount").keyup(function() {
					$(this).val($(this).val().replace(/[^0-9]/gi, ""));
				});
				// only number check end

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/company/companyPointList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function insertPoint() {

		var operation = $("#operation").val();
		var operationName = $("#operation").val() == 'P' ? "충전 하시겠습니까?"
				: "사용 하시겠습니까?";
		var amount = $("#amount").val();
		var comment = $("#comment").val();
		var userId = 'comang';

		if (operation == "" || typeof (operation) == 'undefined') {
			alert("사용 구분을 선택하세요.");
			$("#operation").focus();
			return;
		}
		if (amount == "" || typeof (amount) == 'undefined') {
			alert("금액을 입력하세요.");
			$("#amount").focus();
			return;
		}
		if (comment == "" || typeof (comment) == 'undefined') {
			alert("내용을 입력하세요.");
			$("#comment").focus();
			return;
		}
		console.log('userId : ' + userId + ', operation : ' + operation
				+ ', amount : ' + amount + ', comment : ' + comment);

		if (confirm(operationName)) {

			var param = "operation=" + encParam($.trim(operation));
			param += "&amount=" + encParam($.trim(amount));
			param += "&comment=" + encParam($.trim(comment));
			param += "&user_id=" + encParam($.trim(userId));

			$.ajax({
				type : 'post', // type : post or get
				async : false, // default : false
				url : '/company/insertPointInfo.do',
				data : param,
				dataType : 'jsonp', // type : json, script , xml ...
				timeout : 10000,
				error : function(xhr, ajaxOptions, thrownError) {
					alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
					return;
				},
				success : function(data, textStatus) {
					if (data.errorCode == '0000') {
						alert(data.errorMsg);
						history.go(0);
						return;
					} else {
						alert(operationName + " FAIL(" + data.errorMsg + ")");
						return;
					}
				}
			});

		}

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

		<!-- Header end -->
		
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
					<li><a href="/company/companyList.do" class="companyList">기업관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/company/companyList.do">기업관리</a> &gt; <a onclick="javascript:commonGetUrl('/company/companyListDetail.do', 'user_id=');" class="on">기업관리상세</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="285" /> <input
						type="hidden" id="user_id" name="user_id" value="comang" />

					<!-- tab start -->



					<div class="tabType01">
						<ul class="clearfix">
							<li id="companyBasic"><a href="/company/companyDetail">기본정보</a></li>
							<li id="companyPoint" class="on"><a href="/company/companyPointList">금액정보</a></li>
							<li id="companyCommission"><a href="/company/companyCommisionList">수수료정보</a></li>
							<!--<li id="companyDeco"><a onclick="javascript:commonGetUrl('/company/companyDecoList.do', 'user_id=comang');" >꾸미기정보</a></li>-->
						</ul>
					</div>
					<!-- tab end -->

					<div id="content">
						<h2>금액정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>금액정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *">
								</colgroup>
								<tbody>
									<tr>
										<th>사용가능금액</th>
										<td>9,400,200</td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2>금액이력</h2>
						<span class="topAdd right">전체 : <strong>285</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
							<!-- 	<caption>금액이력</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>일자</th>
										<th>내용</th>
										<th>사용구분</th>
										<th>금액</th>
										<th>사용가능금액</th>
										<th>요청자</th>
									</tr>
								</thead>
								<tbody>





									<tr>
										<td class="alignC">1</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000028)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,400,200</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">2</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000027)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,435,000</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">3</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000026)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,469,800</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">4</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000025)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,504,600</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">5</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000024)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,539,400</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">6</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000023)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,574,200</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">7</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000021)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,609,000</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">8</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000019)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">19,500</td>
										<td class="alignC">9,643,800</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">9</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000018)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">19,500</td>
										<td class="alignC">9,663,300</td>
										<td class="alignC">APISVR</td>
									</tr>


									<tr>
										<td class="alignC">10</td>
										<td class="alignC">2020-04-13</td>
										<td class="alignC">comang(com_00000000000015)_매체사 실시간 발송</td>
										<td class="alignC">사용</td>
										<td class="alignC">34,800</td>
										<td class="alignC">9,682,800</td>
										<td class="alignC">APISVR</td>
									</tr>




								</tbody>

							</table>
						</div>
						<div class="comp sortArea">
							<div class="paging mt20" id="paging"></div>
						</div>

						<h2>금액 등록</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>금액 등록</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *">
								</colgroup>
								<tbody>
									<tr>
										<th>사용구분</th>
										<td colspan="3"><select name="operation" id="operation">
												<option value="">선택</option>
												<option value="P">충전</option>
												<option value="M">사용</option>
										</select></td>
									</tr>
									<tr>
										<th>금액</th>
										<td colspan="3"><input type="text" placeholder="금액" id="amount" name="amount" value="" /></td>
									</tr>
									<tr>
										<th>내용</th>
										<td colspan="3"><input type="text" placeholder="내용" id="comment" name="comment" value="" /></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
				</form>

				<div class="btnArea alignR">

					<a class="btnType05" onclick="javascript:insertPoint();">등록</a> <a class="btnType04" href="/user/user_main">목록보기</a>
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
