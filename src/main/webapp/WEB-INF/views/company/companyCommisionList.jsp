<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<title>수수료정보 | EPOPKON</title>
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
					if ('companyCommission' == $(this).attr('id')) {
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
		$("#frm").attr("action", "/company/companyCommissionList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetailForm(goodsComId, goodsComName, goodsName, goodsSeq,
			commission) {

		//form initialize
		$("#detail_frm")[0].reset();
		$("#detail_div").show();
		
		// value setting
		$("#detail_frm").find("#goods_com_id").val(goodsComId);
		$("#detail_frm").find("#goods_com_name").val(goodsComName);
		$("#detail_frm").find("#goods_name").val(goodsName);
		$("#detail_frm").find("#goods_seq").val(goodsSeq);
		$("#detail_frm").find("#commission").val(commission);

		$("#detail_frm").find("#goods_com_name").attr("disabled", "disabled");
		$("#detail_frm").find("#goods_name").attr("disabled", "disabled");
		$("#detail_frm").find("#goods_seq").attr("disabled", "disabled");

	}

	function updateCommission() {

		var userId = 'comang';
		var user_gubun = '';
		var goods_com_id = $("#goods_com_id").val();
		var goods_com_name = $("#goods_com_name").val();
		var goods_name = $("#goods_name").val();
		var goods_seq = $("#goods_seq").val();
		var commission = $("#commission").val();

		console
				.log('userId : ' + userId + ', user_gubun : ' + user_gubun
						+ ', goods_com_id : ' + goods_com_id
						+ ', goods_com_name : ' + goods_com_name
						+ ', goods_name : ' + goods_name + ', goods_seq : '
						+ goods_seq + ', commission : ' + commission);

		if (confirm("수수료를 변경하시겠습니까?")) {

			var param = "user_id=" + encParam($.trim(userId));
			param += "&user_gubun=" + encParam($.trim(user_gubun));
			param += "&goods_com_id=" + encParam($.trim(goods_com_id));
			param += "&goods_name=" + encParam($.trim(goods_name));
			param += "&goods_seq=" + encParam($.trim(goods_seq));
			param += "&commission=" + encParam($.trim(commission));

			$.ajax({
				type : 'post', // type : post or get
				async : false, // default : false
				url : '/company/updateCommission.do',
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

				<!-- tab start -->



				<div class="tabType01">
					<ul class="clearfix">
						<li id="companyBasic"><a href="/company/companyDetail">기본정보</a></li>
						<li id="companyPoint"><a href="/company/companyPointList">금액정보</a></li>
						<li id="companyCommission" class="on"><a href="/company/companyCommisionList">수수료정보</a></li>
						<!--<li id="companyDeco"><a onclick="javascript:commonGetUrl('/company/companyDecoList.do', 'user_id=comang');" >꾸미기정보</a></li>-->
					</ul>
				</div>
				<!-- tab end -->

				<div id="content">
					<form name="frm" id="frm" method="post">
						<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="4676" /> <input
							type="hidden" id="user_id" name="user_id" value="comang" /> <input type="hidden" id="user_gubun" name="user_gubun" value="" />

						<h2>수수료정보</h2>
						<span class="topAdd right">전체 : <strong>4,676</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>금액이력</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>공급사명</th>
										<th>상품명</th>
										<th>상품번호</th>
										<th>수수료</th>
									</tr>
								</thead>
								<tbody>




									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'beansnberries',
																	 '빈스앤베리즈',
																	 '카푸치노(R)',
																	 'G00000000010',
																	 '0'
								);">
										<td class="alignC">10</td>
										<td class="alignC">빈스앤베리즈</td>
										<td class="alignC">카푸치노(R)</td>
										<td class="alignC">G00000000010</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '요거트 드롭치노',
																	 'G00000000009',
																	 '0'
								);">
										<td class="alignC">9</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">요거트 드롭치노</td>
										<td class="alignC">G00000000009</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'beansnberries',
																	 '빈스앤베리즈',
																	 '카라멜 마끼아또(R)',
																	 'G00000000008',
																	 '0'
								);">
										<td class="alignC">8</td>
										<td class="alignC">빈스앤베리즈</td>
										<td class="alignC">카라멜 마끼아또(R)</td>
										<td class="alignC">G00000000008</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '에스프레소 드롭치노',
																	 'G00000000007',
																	 '0'
								);">
										<td class="alignC">7</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">에스프레소 드롭치노</td>
										<td class="alignC">G00000000007</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'beansnberries',
																	 '빈스앤베리즈',
																	 '카페 라떼(R)',
																	 'G00000000006',
																	 '0'
								);">
										<td class="alignC">6</td>
										<td class="alignC">빈스앤베리즈</td>
										<td class="alignC">카페 라떼(R)</td>
										<td class="alignC">G00000000006</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'beansnberries',
																	 '빈스앤베리즈',
																	 '아메리카노 오리지널(R)',
																	 'G00000000005',
																	 '0'
								);">
										<td class="alignC">5</td>
										<td class="alignC">빈스앤베리즈</td>
										<td class="alignC">아메리카노 오리지널(R)</td>
										<td class="alignC">G00000000005</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '민트초코 드롭치노',
																	 'G00000000004',
																	 '0'
								);">
										<td class="alignC">4</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">민트초코 드롭치노</td>
										<td class="alignC">G00000000004</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '모카 드롭치노',
																	 'G00000000003',
																	 '0'
								);">
										<td class="alignC">3</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">모카 드롭치노</td>
										<td class="alignC">G00000000003</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '리얼초코 드롭치노',
																	 'G00000000002',
																	 '0'
								);">
										<td class="alignC">2</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">리얼초코 드롭치노</td>
										<td class="alignC">G00000000002</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( 'droptop',
																	 '드롭탑',
																	 '그린티 드롭치노',
																	 'G00000000001',
																	 '0'
								);">
										<td class="alignC">1</td>
										<td class="alignC">드롭탑</td>
										<td class="alignC">그린티 드롭치노</td>
										<td class="alignC">G00000000001</td>
										<td class="alignC">0</td>
									</tr>



								</tbody>
							</table>
						</div>
						<div class="comp sortArea">
							<div class="paging mt20" id="paging">
								<span class="paginator">
								<a class="on" href="javascript:goPageNo(1)" title="1" alt="1">1</a>
								</span>
								<span class="paginator">
								<a class="" href="javascript:goPageNo(2)" title="2" alt="2">2</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(3)" title="3" alt="3">3</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(4)" title="4" alt="4">4</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(5)" title="5" alt="5">5</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(6)" title="6" alt="6">6</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(7)" title="7" alt="7">7</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(8)" title="8" alt="8">8</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(9)" title="9" alt="9">9</a>
								</span><span class="paginator">
								<a class="" href="javascript:goPageNo(10)" title="10" alt="10">10</a>
								</span>
								<a class="next" href="javascript:goPageNo(11)" alt="11">다음</a>
							</div>
						</div>
					</form>

					<form name="detail_frm" id="detail_frm" method="post">
						<input type="hidden" name="goods_com_id" id="goods_com_id" value="" />

						<div class="comp" id="detail_div" style="display: none;">
							<h2>수수료 변경</h2>
							<table class="tbType02">
								<caption></caption>
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *%">
								</colgroup>
								<tbody>
									<tr>
										<th>상품공급사</th>
										<td><input type="text" id="goods_com_name" name="goods_com_name" placeholder="" value="" /></td>
									</tr>
									<tr>
										<th>상품명</th>
										<td><input type="text" id="goods_name" name="goods_name" placeholder="" value="" /></td>
									</tr>
									<tr>
										<th>상품번호</th>
										<td><input type="text" id="goods_seq" name="goods_seq" placeholder="" value="" /></td>
									</tr>
									<tr>
										<th>수수료</th>
										<td><input type="text" id="commission" name="commission" placeholder="" value="" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>


				<div class="btnArea alignR">

					<a class="btnType05" onclick="javascript:updateCommission();">변경</a> <a class="btnType04" href="/user/user_main">목록보기</a>
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
