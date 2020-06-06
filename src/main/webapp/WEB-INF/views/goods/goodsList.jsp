<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<title>상품관리 | SISCUS</title>
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
	var iCurrPage = "";
	var iTotalCount = "";
	var iPageRow = "";
	var iPageBlock = "";

	$(document).ready(
			function() {
				// left menu setting start
				$("#nav > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ('goodsList' == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// left menu setting end

				// paging start
				if ($("#page").val() == "") {
					$("#page").val("1");
				}

				if ($("#pagecount").val() == "") {
					$("#pagecount").val("20");
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
		$("#frm").attr("action", "/goods/goodsList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function goDetail(goodsSeq) {
		commonGetUrl('/goods/goodsDetail.do', 'goods_seq=' + goodsSeq
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
					<li><a href="/goods/goodsList.do" class="goodsList on">상품관리</a></li>
					<li><a href="/goods/dispGoodsList.do" class="dispGoodsList">상품전시관리</a></li>
					<li><a href="/brand/brandList.do" class="brandList">브랜드관리</a></li>
					<!--<li><a href="/disp/dispList.do" class="dispList">전시관리</a></li>-->
					<!--<li><a href="/pin/pinGrpList.do" class="pinList">PIN관리</a></li>-->
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/goods/goodsList.do">상품관리</a> &gt; <a href="/goods/goodsList.do" class="on">상품목록</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="4676" /> <input
						type="hidden" id="goods_com_id" name="goods_com_id" value="" />

					<div class="search">
						<div class="row">
							<strong>검색조건</strong> <select name="goods_status">
								<option value="">상태</option>
								<option value="1">판매중</option>
								<option value="2">판매중지</option>
								<option value="3">단종</option>
								<option value="4">신규상품</option>
							</select> <select name="pin_type">
								<option value="">핀생성방법</option>
								<option value="1">자체핀</option>
								<option value="2">외부핀</option>
								<option value="3">선생성핀</option>
							</select> <strong>상품공급사</strong> <input type="text" id="goods_com_name" name="goods_com_name" value="" readonly="readonly" /> <span class="flowType"><a class="btnBase"
								onclick="javascript:findName('/company/searchGoodsComList.do', 'goodscom');">찾기</a></span>
						</div>
						<div class="row">
							<strong>검색어</strong> <select name="search_type" id="search_type">
								<option value="">선택</option>
								<option value="goods_name">상품명</option>
								<option value="goods_seq">상품번호</option>
								<option value="model_id">모델명</option>
							</select> <input type="text" name="search_keyword" id="search_keyword" value="" /> <a class="btnType02" onclick="javascipt:goSearch();">조회</a>
						</div>
					</div>

					<div id="content">
						<h2>상품목록</h2>
						<span class="topAdd right">전체 : <strong>4,676</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>상품목록</caption> -->
								<thead>
									<tr>
										<th rowspan="2">No</th>
										<th rowspan="2">상품번호</th>
										<th rowspan="2">상품공급사</th>
										<th rowspan="2">상품명</th>
										<th rowspan="2">모델명</th>
										<th colspan="3">실판매가격</th>
										<th rowspan="2">핀생성방법</th>
										<th rowspan="2">상태</th>
									</tr>
									<tr>
										<th>공급가액</th>
										<th>부가세</th>
										<th>합계금액</th>
									</tr>
								</thead>
								<tbody>





									<tr style="cursor: pointer;" onclick="location.href='/goods/goodsDetail'">
										<td class="alignC">1</td>
										<td class="alignC">G00000004740</td>
										<td class="alignC">(테)엠하우스</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">[To-go] 카페 아메리카노 Tall 4잔 카페 라떼 Tall 4잔 세트</td>
										<td class="alignC">31,636</td>
										<td class="alignC">3,164</td>
										<td class="alignC">34,800</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004739');">
										<td class="alignC">2</td>
										<td class="alignC">G00000004739</td>
										<td class="alignC">(주)와이지리테일</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">[굽네치킨] 굽네 오리지널 순살 콜라1.25L</td>
										<td class="alignC">17,727</td>
										<td class="alignC">1,773</td>
										<td class="alignC">19,500</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004738');">
										<td class="alignC">3</td>
										<td class="alignC">G00000004738</td>
										<td class="alignC">(주)비지에프캐시넷</td>
										<td class="alignC">삼립)주종단팥크림빵</td>
										<td class="alignC">삼립)주종단팥크림빵</td>
										<td class="alignC">909</td>
										<td class="alignC">91</td>
										<td class="alignC">1,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004737');">
										<td class="alignC">4</td>
										<td class="alignC">G00000004737</td>
										<td class="alignC">(주)비지에프캐시넷</td>
										<td class="alignC">삼립)주종단팥크림빵</td>
										<td class="alignC">삼립)주종단팥크림빵</td>
										<td class="alignC">909</td>
										<td class="alignC">91</td>
										<td class="alignC">1,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중지</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004736');">
										<td class="alignC">5</td>
										<td class="alignC">G00000004736</td>
										<td class="alignC">(주)와이지리테일</td>
										<td class="alignC">[스무디킹] 엔젤푸드R</td>
										<td class="alignC">[스무디킹] 엔젤푸드R</td>
										<td class="alignC">5,182</td>
										<td class="alignC">518</td>
										<td class="alignC">5,700</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004735');">
										<td class="alignC">6</td>
										<td class="alignC">G00000004735</td>
										<td class="alignC">(주)와이지리테일</td>
										<td class="alignC">[스무디킹] 엔젤푸드S</td>
										<td class="alignC">[스무디킹] 엔젤푸드S</td>
										<td class="alignC">4,273</td>
										<td class="alignC">427</td>
										<td class="alignC">4,700</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004734');">
										<td class="alignC">7</td>
										<td class="alignC">G00000004734</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[킹콩떡볶이] 쿵쿵튀김</td>
										<td class="alignC">[킹콩떡볶이] 쿵쿵튀김</td>
										<td class="alignC">2,727</td>
										<td class="alignC">273</td>
										<td class="alignC">3,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004733');">
										<td class="alignC">8</td>
										<td class="alignC">G00000004733</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[킹콩떡볶이] 마약오튀밥</td>
										<td class="alignC">[킹콩떡볶이] 마약오튀밥</td>
										<td class="alignC">2,727</td>
										<td class="alignC">273</td>
										<td class="alignC">3,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004732');">
										<td class="alignC">9</td>
										<td class="alignC">G00000004732</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[킹콩떡볶이] 마약오튀밥</td>
										<td class="alignC">[킹콩떡볶이] 마약오튀밥</td>
										<td class="alignC">2,727</td>
										<td class="alignC">273</td>
										<td class="alignC">3,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004731');">
										<td class="alignC">10</td>
										<td class="alignC">G00000004731</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[킹콩떡볶이] 쿵쿵튀김</td>
										<td class="alignC">[킹콩떡볶이] 쿵쿵튀김</td>
										<td class="alignC">2,727</td>
										<td class="alignC">273</td>
										<td class="alignC">3,000</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004730');">
										<td class="alignC">11</td>
										<td class="alignC">G00000004730</td>
										<td class="alignC">(주)우아한형제들</td>
										<td class="alignC">배달의민족 5천원권(테스트)</td>
										<td class="alignC">배달의민족 5천원권(테스트)</td>
										<td class="alignC">100</td>
										<td class="alignC">0</td>
										<td class="alignC">100</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004729');">
										<td class="alignC">12</td>
										<td class="alignC">G00000004729</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+크리스피치킨텐더+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+크리스피치킨텐더+콜라1.25L</td>
										<td class="alignC">34,773</td>
										<td class="alignC">3,477</td>
										<td class="alignC">38,250</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004728');">
										<td class="alignC">13</td>
										<td class="alignC">G00000004728</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+치즈볼로네즈스파게티+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+치즈볼로네즈스파게티+콜라1.25L</td>
										<td class="alignC">35,591</td>
										<td class="alignC">3,559</td>
										<td class="alignC">39,150</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004727');">
										<td class="alignC">14</td>
										<td class="alignC">G00000004727</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅M+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅M+콜라1.25L</td>
										<td class="alignC">26,370</td>
										<td class="alignC">2,397</td>
										<td class="alignC">28,767</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004726');">
										<td class="alignC">15</td>
										<td class="alignC">G00000004726</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+콜라1.25L</td>
										<td class="alignC">28,391</td>
										<td class="alignC">2,839</td>
										<td class="alignC">31,230</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004725');">
										<td class="alignC">16</td>
										<td class="alignC">G00000004725</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+크리스피치킨텐더+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+크리스피치킨텐더+콜라1.25L</td>
										<td class="alignC">38,250</td>
										<td class="alignC">3,477</td>
										<td class="alignC">41,727</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004724');">
										<td class="alignC">17</td>
										<td class="alignC">G00000004724</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+치즈볼로네즈스파게티+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+치즈볼로네즈스파게티+콜라1.25L</td>
										<td class="alignC">35,591</td>
										<td class="alignC">3,559</td>
										<td class="alignC">39,150</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004723');">
										<td class="alignC">18</td>
										<td class="alignC">G00000004723</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅M+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅M+콜라1.25L</td>
										<td class="alignC">23,973</td>
										<td class="alignC">2,397</td>
										<td class="alignC">26,370</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004722');">
										<td class="alignC">19</td>
										<td class="alignC">G00000004722</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+콜라1.25L</td>
										<td class="alignC">[도미노피자] 더블크러스트 치즈멜팅L+콜라1.25L</td>
										<td class="alignC">28,391</td>
										<td class="alignC">2,839</td>
										<td class="alignC">31,230</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>


									<tr style="cursor: pointer;" onclick="javascript:goDetail('G00000004721');">
										<td class="alignC">20</td>
										<td class="alignC">G00000004721</td>
										<td class="alignC">(주)엠트웰브</td>
										<td class="alignC">[파파존스] 치즈롤 수퍼파파스(L) + 치킨스트립 + 콜라 500ml</td>
										<td class="alignC">[파파존스] 치즈롤 수퍼파파스(L) + 치킨스트립 + 콜라 500ml</td>
										<td class="alignC">33,218</td>
										<td class="alignC">3,322</td>
										<td class="alignC">36,540</td>
										<td class="alignC"></td>
										<td class="alignC">판매중</td>
									</tr>




								</tbody>

							</table>
						</div>
					</div>
				</form>

				<div class="sortArea">
					<div class="paging mt20" id="paging"><span class="paginator"><a class="on" href="javascript:goPageNo(1)" title="1" alt="1">1</a></span><span class="paginator"><a class="" href="javascript:goPageNo(2)" title="2" alt="2">2</a></span><span class="paginator"><a class="" href="javascript:goPageNo(3)" title="3" alt="3">3</a></span><span class="paginator"><a class="" href="javascript:goPageNo(4)" title="4" alt="4">4</a></span><span class="paginator"><a class="" href="javascript:goPageNo(5)" title="5" alt="5">5</a></span><span class="paginator"><a class="" href="javascript:goPageNo(6)" title="6" alt="6">6</a></span><span class="paginator"><a class="" href="javascript:goPageNo(7)" title="7" alt="7">7</a></span><span class="paginator"><a class="" href="javascript:goPageNo(8)" title="8" alt="8">8</a></span><span class="paginator"><a class="" href="javascript:goPageNo(9)" title="9" alt="9">9</a></span><span class="paginator"><a class="" href="javascript:goPageNo(10)" title="10" alt="10">10</a></span><a class="next" href="javascript:goPageNo(11)" alt="11">다음</a></div>
				</div>
				
				<div class="btnArea alignR">
					<a class="btnType05" href="/goods/insertGoodsForm.do">등록</a>
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
