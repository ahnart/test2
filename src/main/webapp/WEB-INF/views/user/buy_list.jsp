<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">
<link rel="stylesheet" href="/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/resources/css/jquery-ui.css" />

<title>구매관리 | POPKON</title>
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
<script>
        function popup(){
            var url = "/company/searchMediaList";
            var name = "popup test";
            var option = "width = 500, height = 500, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
</script>
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
					if ('buyList' == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// left menu setting end

				// paging start
				if ($("#page").val() == "") {
					$("#page").val("1");
				}

				if ($("#pagecount").val() == "") {
					$("#pagecount").val("50");
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
				
				// 팝업창
				$(".btnBase").click(function() {
					$("#popup").fadeIn();
				})
				$(".button").click(function() {
					$("#popup").fadeOut();
				})
				
			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/buy/buyList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(tradeNo, sendMassId, payId, pinNo) {
		commonGetUrl('/buy/buyDetail.do', 'trade_no=' + tradeNo
				+ '&send_mass_id=' + sendMassId + '&pay_id=' + payId
				+ '&pin_no=' + pinNo + '&listpage=' + iCurrPage);
	}

	
	
</script>
</head>

<body>
	
	<div id="wrap">

		<!-- Header start -->

		<script type="text/javascript" src="/resources/js/jquery.i18n.properties-1.0.9-min.js"></script>
		<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>

		<script type="text/javascript">
			
		</script>
		<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>
		<script type="text/javascript">
			// menu setting
			var gnbType = 'buyMng';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("buyMng" == $(this).attr('class')) {
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
						<li><a href="/send/campaignList" class="sendMng">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng on">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng">상품관리</a></li>
						<li><a href="/account/accountListDay.do" class="accountMng">정산관리</a></li>
						<li><a href="/user/user_list" class="systemMng">시스템관리</a></li>
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
					<a href="/">SISCUS</a> &gt; <a href="/buy/buyList.do">구매관리</a> &gt; <a href="/buy/buyList.do" class="on">구매목록</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> 
					<input type="hidden" id="pagecount" name="pagecount" value="" /> 
					<input type="hidden" id="pagetotal" name="pagetotal" value="15" /> 
					<input type="hidden" id="send_mass_id" name="send_mass_id" value="" /> 
					<input type="hidden" id="goods_com_id" name="goods_com_id" value="" />

					<div class="search clearfix">
						<div class="half-col">
							<div class="row">
								<strong>구매날짜</strong>
								<div class="calendar">
									<input type="text" name="start_date" id="start_date" value="2020-04-13" class="datepicker01"> <img class="ui-datepicker-trigger" src="/resources/images/btn_cal.png" alt="Select date"
										title="Select date">
								</div>
								<span> ~ </span>
								<div class="calendar">
									<input type="text" name="end_date" id="end_date" value="2020-04-13" class="datepicker02"> <img class="ui-datepicker-trigger" src="/resources/images/btn_cal.png" alt="Select date"
										title="Select date">
								</div>
							</div>
							<div class="row">
								<strong>매체사</strong> 
								<input type="text" id="send_mass_name" name="send_mass_name" value="" readonly="readonly" /> 
								<span class="flowType"> 
									<a class="btnBase" style="cursor: pointer;" onclick="javascript:findName('/company/searchMediaList.do', 'media');">찾기</a>
									
								</span>
							</div>
							<div class="row">
								<strong>구매자</strong> <input type="text" placeholder="(번호/이메일)" name="b2c_buy_user_phone_no" id="b2c_buy_user_phone_no" value="" />
							</div>
							<div class="row">
								<strong>결제번호</strong> <input type="text" placeholder="결제번호" name="pay_id" id="pay_id" value="" />
							</div>
							<div class="row">
								<strong>핀번호</strong> <input type="text" placeholder="핀번호" name="pin_no" id="pin_no" value="" />
							</div>
							<div class="row">
								<strong>TR_ID</strong> <input type="text" placeholder="고객주문번호" name="b2b2c_tr_id" id="b2b2c_tr_id" value="" />
							</div>
						</div>
						<div class="half-col">
							<div class="row">
								<strong>검색어</strong> <select name="search_type" id="search_type">
									<option value="">선택</option>
									<option value="goods_name">상품명</option>
									<option value="goods_seq">상품번호</option>
									<option value="model_id">모델명</option>
								</select> <input type="text" name="search_keyword" id="search_keyword" value="" />
							</div>
							<div class="row">
								<strong>상품공급사명</strong> <input type="text" id="goods_com_name" name="goods_com_name" value="" readonly="readonly" /> <span class="flowType"><a class="btnBase"
									style="cursor: pointer;" onclick="javascript:findName('/company/searchMediaList.do', 'goodscom');">찾기</a></span>
							</div>
							<div class="row">
								<strong>수신자</strong> <input type="text" placeholder="(번호/이메일)" name="res_cust_phone_no" id="res_cust_phone_no" value="" />
							</div>
							<div class="row">
								<strong>구매 번호</strong> <input type="text" placeholder="구매 번호" name="buy_no" id="buy_no" value="" />
							</div>
							<div class="row">
								<strong>핀상태</strong> <select name="pin_status" id="pin_status">
									<option value="">선택</option>

									<option value="A">등록</option>

									<option value="B">발행</option>

									<option value="C">교환</option>

									<option value="R">반품</option>

									<option value="D">관리폐기</option>

									<option value="F">환불</option>

									<option value="E">등록취소</option>

									<option value="G">재발행(대체)</option>

									<option value="H">구매취소(폐기)</option>

									<option value="I">재발행(복구)</option>

									<option value="J">기간만료</option>

								</select>
							</div>
							<a class="btnType02 right" onclick="javascipt:goSearch();">조회</a>
						</div>

					</div>

					<div id="content">
						<h2>구매목록</h2>
						<span class="topAdd right">전체 : <strong>15</strong>개
						</span>
						<div class="comp scrollTb xScroll">
							<table class="tbType01">
								<!-- 	<caption>구매목록</caption> -->
								<thead>
									<tr>
										<th>구매번호</th>
										<th>결제번호</th>
										<th>매체사이름</th>
										<th>상품명</th>
										<th>유효기간</th>
										<th>수신자<br />(번호/이메일)
										</th>
										<th>핀번호</th>
										<th>핀상태</th>
										<th>TR_ID</th>
									</tr>
								</thead>
								<tbody>

									<tr style="cursor: pointer;"  onclick="location.href='/buy/buyDetail'">
										<td class="alignC">C0041312420363010013</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">2020-04-13 ~ 2020-06-12</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911618161734</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000024</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('02004131237274651003', 'comang', '', '911642442750');">
										<td class="alignC">C0041312372623410012</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">2020-04-13 ~ 2020-06-12</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911642442750</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000023</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('02004130234519851002', 'comang', '', '911597259935');">
										<td class="alignC">C0041302345058410011</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">2020-04-13 ~ 2020-06-12</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911597259935</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000021</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('02004130200346751002', 'comang', '', '911285722166');">
										<td class="alignC">C0041302003376410010</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911285722166</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000019</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('02004130154118921002', 'comang', '', '911673434330');">
										<td class="alignC">C0041301541100410009</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911673434330</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000018</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('20200413014037117177', 'comang', '', '911847489812');">
										<td class="alignC">C0041301403694810008</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">2020-04-13 ~ 2020-06-12</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911847489812</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000015</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('20200413013551068176', 'comang', '', '911431812258');">
										<td class="alignC">C0041301355092610007</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911431812258</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000011</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('20200413013403059175', 'comang', '', '911571938752');">
										<td class="alignC">C0041301340301310006</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911571938752</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000010</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('20200413011319442174', 'comang', '', '911390175437');">
										<td class="alignC">C0041301131930610005</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911390175437</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000009</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:goDetail('20200413010540589173', 'comang', '', '911972228456');">
										<td class="alignC">C0041301054052310004</td>
										<td class="alignC"></td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">2020-04-13 ~ 2020-07-14</td>
										<td class="alignC">01027464681</td>
										<td class="alignC">911972228456</td>
										<td class="alignC">발행</td>
										<td class="alignC">com_00000000000008</td>
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
