<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<title>상품전시관리 | SISCUS</title>
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
<script type="text/javascript">
	var upperAllCheckFlag = false;
	var downAllCheckFlag = false;
	
	$(document)
			.ready(
					function() {
						// left menu setting start
						$("#nav > ul > li > a").each(function() {
							$(this).removeClass('on');
							if ('dispGoodsList' == $(this).attr('class')) {
								$(this).addClass('on');
							}
						});
						// left menu setting end

						// tab menu setting start
						$(".tabType01 > ul > li").each(function() {
							$(this).removeClass('on');
							if ('dispGoods' == $(this).attr('id')) {
								$(this).addClass('on');
							}
						});
						// tab menu setting end
						
						// all check start
						$("#upperCheckAll").click(function() {
							if (!upperAllCheckFlag) {
								upperCheckAll();
								upperAllCheckFlag = true;
							} else {
								upperUncheckAll();
								upperAllCheckFlag = false;
							}
						});
						$("#downCheckAll").click(function() {
							if (!downAllCheckFlag) {
								downCheckAll();
								downAllCheckFlag = true;
							} else {
								downUncheckAll();
								downAllCheckFlag = false;
							}
						});
						// all check end

						// move up/down start
						$("#moveUp")
								.click(
										function() {
											var checkDispGoodsInfo = "";
											$("input[name=downCheck]:checked")
													.each(
															function() {
																checkDispGoodsInfo += $(
																		this)
																		.val()
																		+ ",";
															});
											checkDispGoodsInfo = checkDispGoodsInfo
													.substr(
															0,
															checkDispGoodsInfo
																	.lastIndexOf(','));
											if (checkDispGoodsInfo != ""
													&& typeof (checkDispGoodsInfo) != 'undefined') {
												insertDispGoods(checkDispGoodsInfo);
											}

										});
						$("#moveDown")
								.click(
										function() {
											var checkGoodsDispSeq = "";
											$("input[name=upperCheck]:checked")
													.each(
															function() {
																checkGoodsDispSeq += $(
																		this)
																		.val()
																		+ ",";
															});
											checkGoodsDispSeq = checkGoodsDispSeq
													.substr(
															0,
															checkGoodsDispSeq
																	.lastIndexOf(','));
											if (checkGoodsDispSeq != ""
													&& typeof (checkGoodsDispSeq) != 'undefined') {
												deleteDispGoods(checkGoodsDispSeq);
											}
										});
						// move up/down end

						// search selectbox change event start
						$("select[name='search_type']").bind('change',
								function() {
									$("#search_keyword").val("");
								});
						// search selectbox change event end

					});

	function upperCheckAll() {
		$("input[name=upperCheck]").not(":checked").prop("checked", true);
	}
	function upperUncheckAll() {
		$("input[name=upperCheck]:checked").prop("checked", false);
	}
	function downCheckAll() {
		$("input[name=downCheck]").not(":checked").prop("checked", true);
	}
	function downUncheckAll() {
		$("input[name=downCheck]:checked").prop("checked", false);
	}

	function goDispSearch() {
		var dispNo = $("#disp_no").val();
		if (dispNo == "" || typeof (dispNo) == 'undefined') {
			alert("전시명을 선택하세요.");
			$("#disp_name").focus();
			return;
		}

		var param = "disp_no=" + encParam($.trim(dispNo));
		param += "&goods_disp_type=DISP";

		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/goods/dispGoodsListAjax.do',
			data : param,
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
				return;
			},
			success : function(data, textStatus) {
				$("#dispList").html(data);
				goGoodsSearch();
			}
		});

	}

	function goGoodsSearch() {

		var dispNo = $("#disp_no").val();
		if (dispNo == "" || typeof (dispNo) == 'undefined') {
			alert("전시명을 선택하세요.");
			$("#disp_name").focus();
			return;
		}

		var goodsStatus = $("select[name=goods_status]").val();
		var pinType = $("select[name=pin_type]").val();
		var goodsComId = $("#goods_com_id").val();
		var searchType = $("select[name=search_type]").val();
		var searchKeyword = $("#search_keyword").val();

		var param = "goods_status=" + encParam($.trim(goodsStatus));
		param += "&pin_type=" + encParam($.trim(pinType));
		param += "&goods_com_id=" + encParam($.trim(goodsComId));
		param += "&search_type=" + encParam($.trim(searchType));
		param += "&search_keyword=" + encParam($.trim(searchKeyword));
		param += "&disp_no=" + encParam($.trim(dispNo));

		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/goods/goodsListAjax.do',
			data : param,
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				//console.log($(this));
				alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
				return;
			},
			success : function(data, textStatus) {
				$("#goodsList").html(data);
			}
		});
	
	}
	
	function deleteDispGoods(checkGoodsDispSeq) {
		console.log('checkGoodsDispSeq : ' + checkGoodsDispSeq);
		var param = "check_goods_disp_seq="
				+ encParam($.trim(checkGoodsDispSeq));
		param += "&goods_disp_type=DISP";
		
		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/goods/deleteDispGoods.do',
			data : param,
			dataType : 'jsonp', // type : json, script , xml ...
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				return false;
			},
			success : function(data, textStatus) {
				//console.log(data);
				if (data.errorCode == '0000') {
					goDispSearch();
				} else {
					alert(data.errorMsg);
					return;
				}
			}
		});
		
	}
	
	function insertDispGoods(checkDispGoodsInfo) {
		
		var dispNo = $("#disp_no").val();
		if (dispNo == "" || typeof (dispNo) == 'undefined') {
			alert("전시명을 선택하세요.");
			$("#disp_name").focus();
			return;
		}
		console.log('dispNo : ' + dispNo + ', goods_info : '
				+ checkDispGoodsInfo);
		
		var param = "disp_no=" + encParam($.trim(dispNo));
		param += "&goods_info=" + encParam($.trim(checkDispGoodsInfo));
		param += "&goods_disp_type=DISP";
		
		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/goods/insertDispGoods.do',
			data : param,
			dataType : 'jsonp', // type : json, script , xml ...
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				return false;
			},
			success : function(data, textStatus) {
				//console.log(data);
				if (data.errorCode == '0000') {
					goDispSearch();
				} else {
					alert(data.errorMsg);
					return;
				}
			}
		});
		
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
			var gnbType = 'goodsMng';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("goodsMng" == $(this).attr('class')) {
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
						<li><a href="/goods/goodsList.do" class="goodsMng on">상품관리</a></li>
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
					<li><a href="/goods/goodsList.do" class="goodsList">상품관리</a></li>
					<li><a href="/goods/dispGoodsList.do" class="dispGoodsList on">상품전시관리</a></li>
					<li><a href="/brand/brandList.do" class="brandList">브랜드관리</a></li>
					<!--<li><a href="/disp/dispList.do" class="dispList">전시관리</a></li>-->
					<!--<li><a href="/pin/pinGrpList.do" class="pinList">PIN관리</a></li>-->
				</ul>
			</nav>
			<!-- LNB end -->
			
			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/goods/goodsList.do">상품관리</a> &gt; <a href="/goods/dispGoodsList.do" class="on">상품전시관리</a>
				</div>
				<!-- gnb end -->
				
				<!-- tab start -->
				
				
				
				<div class="tabType01">
					<ul class="clearfix">
						<li id="dispGoods" class="on"><a onclick="javascript:location.href='/goods/dispGoodsList.do', 'goods_disp_type=DISP'">전시기준</a></li>
						<li id="goodsDisp"><a onclick="javascript:location.href='/goods/dispGoodsList2.do', 'goods_disp_type=GOODS'">상품기준</a></li>
					</ul>
				</div>
				<!-- tab end -->
				
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="disp_no" 	 		name="disp_no" 			value="" />
					<input type="hidden" id="goods_disp_type" 	name="goods_disp_type" 	value="GOODS" />
					<input type="hidden" id="goods_com_id" 		name="goods_com_id" 	value="" />
					<input type="hidden" id="goods_seq" 		name="goods_seq" 		value="" />
					<input type="hidden" id="real_amt" 			name="real_amt" 		value="" />
					<input type="hidden" id="real_vat" 			name="real_vat" 		value="" />
				
					<div class="search">
						<div class="row">
							<strong>전시명</strong>
							<input type="text" id="disp_name" name="disp_name" value="" readonly="readonly" /> 
							<a class="btnBase" onclick="javascript:findName('/disp/searchDispPop.do', 'disp');">전시명 찾기</a> 
							<a class="btnType02" onclick="javascipt:goDispSearch();">조회</a>
						</div>
					</div>
				
					<div id="content">
						<h2>전시중인 상품목록</h2>
						<div class="comp scrollTb">
							<table class="tbType01">
							<!-- 	<caption>전시중인 상품목록</caption> -->
								<thead>
									<tr>
										<th><input type="checkbox" name="upperCheckAll" id="upperCheckAll" /></th>
										<th>상품공급사</th>
										<th>상품번호</th>
										<th>상품명</th>
										<th>모델명</th>
										<th>우선순위</th>
										<th>전시상태</th>
										<th>판매가격</th>
										<th>실판매가격</th>
										<th>상품전시가격</th>
										<th>마일리지사용여부</th>
										<th>적립마일리지</th>
									</tr>
								</thead>
								<tbody id="dispList">

								</tbody>
							</table>
						</div>

						<div class="comp btnArea alignC">
							<a class="btnType06" id="moveUp">&and;</a><a class="btnType06" id="moveDown">&or;</a>
						</div>

						<div class="search">
							<div class="row">
								<strong>검색조건</strong>
								<select name="goods_status">
									<option value="">상태</option>
									<option value="1">판매중</option>
									<option value="2">판매중지</option>
									<option value="3">단종</option>
									<option value="4">신규상품</option>
								</select>
								<select name="pin_type">
									<option value="">핀생성방법</option>
									<option value="1">자체핀</option>
									<option value="2">외부핀</option>
									<option value="3">선생성핀</option>
								</select>
								<strong>상품공급사명</strong>
								<input type="text" id="goods_com_name" name="goods_com_name" value="" readonly="readonly" /> 
								<span class="flowType"><a class="btnBase" onclick="javascript:findName('/company/searchGoodsComList.do', 'goodscom');">찾기</a></span>
							</div>
							<div class="row">
								<strong>검색어</strong> <select name="search_type" id="search_type">
									<option value="">선택</option>
									<option value="goods_name">상품명</option>
									<option value="goods_seq">상품번호</option>
									<option value="model_id">모델명</option>
								</select> <input type="text" name="search_keyword" id="search_keyword" value="" /> <a class="btnType02" onclick="javascipt:goGoodsSearch();">조회</a>
							</div>
						</div>

						<h2>상품목록</h2>
						<div class="comp scrollTb">
							<table class="tbType01">
							<!-- 	<caption>상품목록</caption> -->
								<thead>
									<tr>
										<th rowspan="2"><input type="checkbox" name="downCheckAll" id="downCheckAll" /></th>
										<th rowspan="2">상품번호</th>
										<th rowspan="2">상품공급사명</th>
										<th rowspan="2">상품명</th>
										<th rowspan="2">모델명</th>
										<th colspan="3">실판매가격</th>
										<th rowspan="2">상태</th>
									</tr>
									<tr>
										<th>공급가액</th>
										<th>부가세</th>
										<th>합계금액</th>
									</tr>
								</thead>
								<tbody id="goodsList">

								</tbody>

							</table>
						</div>
					</div>

				</form>
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
