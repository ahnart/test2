<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>발송실패관리 | SISCUS</title>
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

	var allCheckFlag = false;

	$(document).ready(
			function() {
				// left menu setting start
				$("#nav > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ('sendFailMng' == $(this).attr('class')) {
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

				// all check start
				$("#checkAll").click(function() {
					if (!allCheckFlag) {
						checkAll();
						allCheckFlag = true;
					} else {
						uncheckAll();
						allCheckFlag = false;
					}
				});

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

	function checkAll() {
		$("input[name=check]").not(":checked").prop("checked", true);
	}
	function uncheckAll() {
		$("input[name=check]:checked").prop("checked", false);
	}
	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/send/sendFailList.do");
		$("#frm").submit();
	}
	function goSearch() {
		/*
		var sendMassId = $("#send_mass_id").val();
		if( sendMassId == "" || typeof(sendMassId) == "undefinde" ){
			alert("매체사를 선택하세요.");
			$("#send_mass_name").focus();
			return;
		}
		 */
		goPageNo(1);
	}
	function goResend() {

		var checkInfo = "";
		$("input[name=check]:checked").each(function() {
			checkInfo += $(this).val() + ",";
		});
		checkInfo = checkInfo.substr(0, checkInfo.lastIndexOf(','));
		if (checkInfo != "" && typeof (checkInfo) != 'undefined') {
			//console.log('checkInfo : ' + checkInfo);
			var param = "check_info=" + encParam($.trim(checkInfo));
			$.ajax({
				type : 'post', // type : post or get
				async : false, // default : false
				dataType : 'jsonp',
				url : '/send/updateSendFailStatus.do',
				data : param,
				timeout : 10000,
				error : function(xhr, ajaxOptions, thrownError) {
					alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
					return;
				},
				success : function(data, textStatus) {
					//console.log(data);
					alert(data.errorMsg);
				}
			});

		} else {
			alert("발송할 항목을 선택하세요.");
			return;
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
						<li><a href="/send/campaignList" class="sendMng ">발송관리</a></li>
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
					<li><a href="/user/buy_list.do" class="buyList ">구매조회</a></li>
					<li><a href="/send/sendFailList.do" class="sendFailMng on">발송실패관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/buy/buyList.do">구매관리</a> &gt; <a href="/send/sendFailList.do" class="on">발송실패관리</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="0" /> <input
						type="hidden" id="b2b_gubun" name="b2b_gubun" value="B2B" /> <input type="hidden" id="send_mass_id" name="send_mass_id" value="" />

					<div class="search">
						<div class="row">
							<strong>조회구분</strong>
							<div class="calendar">
								<input type="text" name="search_date" id="search_date" value="2020-04-21" class="datepicker01">
							</div>
							<select name="send_gubun" id="send_gubun">
								<option value="regDate">등록일짜</option>
								<option value="sendDate">발송일짜</option>
							</select>
						</div>
						<div class="row">
							<strong>매체사</strong> <input type="text" id="send_mass_name" name="send_mass_name" value="" readonly="readonly" /> <span class="flowType"><a class="btnBase"
								onclick="javascript:findName('/company/searchMediaList.do', 'media');">찾기</a></span>
						</div>
						<a class="btnType02 right" onclick="javascipt:goSearch();">조회</a>
					</div>

					<div id="content">
						<h2>발송실패내역</h2>
						<span class="topAdd right">전체 : <strong>0</strong>개
						</span>
						<div class="comp scrollTb xScroll">
							<table class="tbType01">
								<!-- <caption>발송실패내역</caption> -->
								<thead>
									<tr>
										<th><input type="checkbox" name="checkAll" id="checkAll" /></th>
										<th>No</th>
										<th>기업구분</th>
										<th>기업명</th>
										<th>구매번호</th>
										<th>핀번호</th>
										<th>TR_ID</th>
										<th>발행날짜</th>
										<th>수신자<br />(번호/이메일)
										</th>
										<th>상품명</th>
										<th>실판매가격</th>
										<th>유효기간</th>
										<th>발송구분</th>
										<th>실패사유</th>
									</tr>
								</thead>
								<tbody>


									<tr>
										<td colspan="14" class="alignC">검색 결과가 없습니다.</td>
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
					<a class="btnType05" onclick="javascript:goResend();">발송</a>
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
