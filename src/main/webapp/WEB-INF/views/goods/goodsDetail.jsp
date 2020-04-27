<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>상품상세정보 | SISCUS</title>
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
<script type="text/javascript" src="/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/resources/js/jquery/numberformatter.min.js"></script>
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->

<script type="text/javascript">
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

				// chagne goods_gun start
				changeGoodsZone('REA');
				$("select[name='goods_gubun']").bind('change', function() {
					changeGoodsZone($(this).val());
				});
				// chagne goods_gun end

				// only number check start
				$(".onlyNumber").keyup(function() {
					$(this).val($(this).val().replace(/[^0-9]/gi, ""));
				});
				// only number check end

				// sum amt/vat start
				$(".onlyNumber").bind(
						'change',
						function() {
							var result = $.trim($(this).attr('class').replace(
									'onlyNumber', ''));
							setTotalPrice(result);
						});
				// sum amt/vat end

			});

	function changeGoodsZone(value) {
		var param = "code_grp_id=" + value;

		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/system/selectCommCodeListAjax.do',
			data : param,
			dataType : 'jsonp', // type : json, script , xml ...
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
				return;
			},
			success : function(data, textStatus) {
				//console.log(data.codeList);
				//var listLen = list.length;
				var list = data.codeList;
				var contenStr = "";
				$.each(list, function(i) {
					contenStr += "<option value='"+list[i].code+"' >"
							+ list[i].codeName + "</option>";
				});
				$("#goods_zone").html(contenStr);
			}
		});

	}

	function setTotalPrice(name) {
		//console.log(name);
		if (name != "" || typeof (brandName) != 'undefined') {
			var sum = 0;
			$("." + name).each(function() {
				sum += Number($(this).val());
			});
			$("#" + name + "_sum").val(sum);
		}
	}

	function imgPreview(url, fileName) {
		console.log('url : ' + url + ', fileName : ' + fileName);
		if (url == "" || typeof (url) == 'undefined') {
			alert("URL이 없습니다.");
			return false;
		}
		if (fileName == "" || typeof (fileName) == 'undefined') {
			alert("파일이 없습니다.");
			return false;
		}
		window.open(url + fileName, "imgPop");
	}

	function updateGoods() {

		var goodComId = $("#goods_com_id").val();
		var brandCode = $("#brand_code").val();
		var usecomCode = $("#usecom_code").val();
		var goodsGubun = $("#goods_gubun").val();
		var goodsZone = $("#goods_zone").val();
		var goodsName = $("#goods_name").val();
		var modelName = $("#model_name").val();
		var goodsStatus = $("input[name='goods_status']:checked").val();
		var pinMethod = $("input[name='pin_method']:checked").val();
		var pinSeptGubun = $("input[name='pin_sept_gubun']:checked").val();
		var goodsType = $("input[name='goods_type']:checked").val();
		var defaultFlag = $("input[name='default_flag']:checked").val();
		var expirationFlag = $("input[name='expiration_flag']:checked").val();
		var exchangeFlag = $("input[name='exchange_flag']:checked").val();
		var cancelFlag = $("input[name='cancel_flag']:checked").val();
		var refundFlag = $("input[name='refund_flag']:checked").val();
		var saleStartDate = $("#sale_start_date").val();
		var saleEndDate = $("#sale_end_date").val();
		var limitDate = $("#limit_date").val();
		var pinDiscardYn = $("input[name='pin_discard_yn']:checked").val();
		var autoRefundYn = $("input[name='auto_refund_yn']:checked").val();
		var extendYn = $("input[name='extend_yn']:checked").val();
		var b2bGoodsYn = $("input[name='b2b_goods_yn']:checked").val();
		var barcodeYn = $("input[name='barcode_yn']:checked").val();
		var sellMethod = $("input[name='sell_method']:checked").val();
		var goodsComFee = $("#goods_com_fee").val();
		var purchaseAmt = $("#purchase_amt").val();
		var purchaseVat = $("#purchase_vat").val();
		var purchaseSum = $("#purchase_sum").val();
		var saleAmt = $("#sale_amt").val();
		var saleVat = $("#sale_vat").val();
		var saleSum = $("#sale_sum").val();
		var saleDiscountAmt = $("#sale_discount_amt").val();
		var saleDiscountVat = $("#sale_discount_vat").val();
		var saleDiscountSum = $("#sale_discount_sum").val();
		var goodsImg5 = $("#goods_img5").val();
		var goodsImg2 = $("#goods_img2").val();
		var goodsImg3 = $("#goods_img3").val();
		var goodsImg4 = $("#goods_img4").val();

		if (goodComId == "" || typeof (goodComId) == 'undefined') {
			alert("상품공급사를 선택하세요.");
			$("#goods_com_name").focus();
			return;
		}
		if (brandCode == "" || typeof (brandCode) == 'undefined') {
			alert("브랜드를 선택하세요.");
			$("#brand_name").focus();
			return;
		}
		if (usecomCode == "" || typeof (usecomCode) == 'undefined') {
			alert("교환처를 선택하세요.");
			$("#usecom_code_name").focus();
			return;
		}
		if (goodsGubun == "" || typeof (goodsGubun) == 'undefined') {
			alert("상품구분을 선택하세요.");
			$("#usecom_code_name").focus();
			return;
		}
		if (goodsZone == "" || typeof (goodsZone) == 'undefined') {
			alert("상품군을 선택하세요.");
			$("#goods_zone").focus();
			return;
		}
		if (goodsName == "" || typeof (goodsName) == 'undefined') {
			alert("상품명을 입력하세요.");
			$("#goods_name").focus();
			return;
		}
		if (modelName == "" || typeof (modelName) == 'undefined') {
			alert("모델명을 입력하세요.");
			$("#model_name").focus();
			return;
		}
		if (goodsStatus == "" || typeof (goodsStatus) == 'undefined') {
			alert("상품상태를 선택하세요.");
			return;
		}
		if (pinMethod == "" || typeof (pinMethod) == 'undefined') {
			alert("핀 생성 방법을 선택하세요.");
			return;
		}
		if (pinSeptGubun == "" || typeof (pinSeptGubun) == 'undefined') {
			alert("핀 통합 설정을 선택하세요.");
			return;
		}
		if (goodsType == "" || typeof (goodsType) == 'undefined') {
			alert("상품 형태를 선택하세요.");
			return;
		}
		if (expirationFlag == "" || typeof (expirationFlag) == 'undefined') {
			alert("기간만료 확인 여부를 선택하세요.");
			return;
		}
		if (defaultFlag == "" || typeof (defaultFlag) == 'undefined') {
			alert("기본 상품 설정을 선택하세요.");
			return;
		}
		if (exchangeFlag == "" || typeof (exchangeFlag) == 'undefined') {
			alert("교환 상품 설정을 선택하세요.");
			return;
		}
		if (cancelFlag == "" || typeof (cancelFlag) == 'undefined') {
			alert("취소 가능 설정을 선택하세요.");
			return;
		}
		if (refundFlag == "" || typeof (refundFlag) == 'undefined') {
			alert("환불 가능 설정을 선택하세요.");
			return;
		}
		if (saleStartDate == "" || typeof (saleStartDate) == 'undefined') {
			alert("판매 시작 기간을 선택하세요.");
			$("#sale_start_date").focus();
			return;
		}
		if (saleEndDate == "" || typeof (saleEndDate) == 'undefined') {
			alert("판매 종료 기간을 선택하세요.");
			return;
		}
		if (limitDate == "" || typeof (limitDate) == 'undefined') {
			alert("유효일수를 입력하세요.");
			$("#limit_date").focus();
			return;
		}
		if (pinDiscardYn == "" || typeof (pinDiscardYn) == 'undefined') {
			alert("PIN 폐기 연동 여부를 선택하세요.");
			return;
		}
		if (autoRefundYn == "" || typeof (autoRefundYn) == 'undefined') {
			alert("자동환불 여부를 선택하세요.");
			return;
		}
		if (extendYn == "" || typeof (extendYn) == 'undefined') {
			alert("연장 가능 여부를 선택하세요.");
			return;
		}
		if (b2bGoodsYn == "" || typeof (b2bGoodsYn) == 'undefined') {
			alert("B2B 상품 여부를 선택하세요.");
			return;
		}
		if (barcodeYn == "" || typeof (barcodeYn) == 'undefined') {
			alert("바코드 출력 유무를 선택하세요.");
			return;
		}
		if (sellMethod == "" || typeof (sellMethod) == 'undefined') {
			alert("매출 정산 방법을 선택하세요.");
			return;
		}
		if (goodsComFee == "" || typeof (goodsComFee) == 'undefined') {
			alert("공급 수수료를 입력하지 않습니다.");
			$("#goods_com_fee").focus();
			return;
		}
		if (purchaseAmt == "" || typeof (purchaseAmt) == 'undefined') {
			alert("매입단가의 공급가액을 입력하세요.");
			$("#purchase_amt").focus();
			return;
		}
		if (purchaseVat == "" || typeof (purchaseVat) == 'undefined') {
			alert("매입단가의 부가세를 입력하세요.");
			$("#purchase_vat").focus();
			return;
		}
		if (purchaseSum == "" || typeof (purchaseSum) == 'undefined') {
			alert("매입단가의 합계를 입력하세요.");
			$("#purchase_sum").focus();
			return;
		}
		if (saleAmt == "" || typeof (saleAmt) == 'undefined') {
			alert("판매단가의 공급가액을 입력하지 않습니다.");
			$("#sale_amt").focus();
			return;
		}
		if (saleVat == "" || typeof (saleVat) == 'undefined') {
			alert("판매단가의 부가세를 입력하지 않습니다.");
			$("#sale_vat").focus();
			return;
		}
		if (saleSum == "" || typeof (saleSum) == 'undefined') {
			alert("판매단가의 합계를 입력하지 않습니다.");
			$("#sale_sum").focus();
			return;
		}
		if (saleDiscountAmt == "" || typeof (saleDiscountAmt) == 'undefined') {
			alert("실판매단가의 공급가액을 입력하지 않습니다.");
			$("#sale_discount_amt").focus();
			return;
		}
		if (saleDiscountVat == "" || typeof (saleDiscountVat) == 'undefined') {
			alert("실판매단가의 부가세를 입력하지 않습니다.");
			$("#sale_discount_vat").focus();
			return;
		}
		if (saleDiscountSum == "" || typeof (saleDiscountSum) == 'undefined') {
			alert("실판매단가의 합계를 입력하지 않습니다.");
			$("#sale_discount_sum").focus();
			return;
		}

		// upload file ext check start
		var uploadFileType = "";
		if (goodsImg5 != '' && typeof (goodsImg5) != 'undefined')
			uploadFileType += goodsImg5 + ",";
		if (goodsImg2 != '' && typeof (goodsImg2) != 'undefined')
			uploadFileType += goodsImg2 + ",";
		if (goodsImg3 != '' && typeof (goodsImg3) != 'undefined')
			uploadFileType += goodsImg3 + ",";
		if (goodsImg4 != '' && typeof (goodsImg4) != 'undefined')
			uploadFileType += goodsImg4 + ",";

		if (uploadFileType != '')
			uploadFileType = uploadFileType.substring(0, uploadFileType
					.lastIndexOf(","));
		console.log("uploadFileType : " + uploadFileType + ', length : '
				+ uploadFileType.split(',').length);

		var result = true;
		if (uploadFileType != '') {
			for (var i = 0; i < uploadFileType.split(',').length; i++) {
				result = checkImg(uploadFileType.split(',')[i]);
			}
		}
		// upload file ext check end

		if (result) {
			if (confirm("수정 하시겠습니까?")) {
				$('form[name=frm]').ajaxForm(
						{
							dataType : "jsonp",
							url : "/goods/updateGoods.do",
							/* beforeSend: function () {
							  alert("시작전");
							},
							uploadProgress: function (event, position, total, percentComplete) {
							  alert("업로드중");
							}, */
							success : function(data) {
								//console.log(data);
								if (data.errorCode == '0000') {
									alert("수정 되었습니다.");
									commonGetUrl('/goods/goodsDetail.do',
											'goods_seq=' + 'G00000004740');
								} else {
									alert(data.errorMsg);
								}
							}
						});
				$('form[name=frm]').submit();
			}
		} else {
			alert("이미지는 jpg, jpeg, png, gif, bmp 파일만 등록이 가능합니다.");
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
						<li><a href="/user/user_main" class="companyMng">기업관리</a></li>
						<li><a href="/send/campaignList" class="sendMng">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng on">상품관리</a></li>
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
					<a href="/">SISCUS</a> &gt; <a href="/goods/goodsList.do">상품관리</a> &gt; <a href="/goods/goodsList.do">상품목록</a> &gt; <a
						onclick="javascript:commonGetUrl('/goods/goodsDetail.do', 'goods_seq=G00000004740');" class="on">상품상세정보</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" enctype="multipart/form-data" method="post">
					<input type="hidden" id="goods_seq" name="goods_seq" value="G00000004740" /> <input type="hidden" id="goods_com_id" name="goods_com_id" value="testmhouse" /> <input type="hidden"
						id="brand_code" name="brand_code" value="BR00013" /> <input type="hidden" id="usecom_code" name="usecom_code" value="starbs" /> <input type="hidden" id="goods_com_fee_old"
						name="goods_com_fee_old" value="1.0" />

					<div id="content">

						<h2>기본정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>기본정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%">
									<col style="width: 15%;">
									<col style="width: 35%">
								</colgroup>
								<tbody>
									<tr>
										<th>상품번호</th>
										<td colspan="3">G00000004740</td>
									</tr>
									<tr>
										<th>상품공급사명</th>
										<td>
											<div class="col-two">
												<input type="text" id="goods_com_name" name="goods_com_name" placeholder="상품공급사명" value="(테)엠하우스" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/company/searchGoodsComList.do', '');">상품공급사찾기</a></span>
											</div>
										</td>
										<th>브랜드</th>
										<td>
											<div class="col-two">
												<input type="text" id="brand_name" name="brand_name" placeholder="브랜드" value="스타벅스" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/brand/searchBrandList.do', '');">브랜드찾기</a></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>교환처</th>
										<td>
											<div class="col-two">
												<input type="text" id="usecom_code_name" name="usecom_code_name" value="스타벅스" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/system/searchUsecomCodeList.do', '');">교환처찾기</a></span>
											</div>
										</td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th>상품구분</th>
										<td><select name="goods_gubun" id="goods_gubun">
												<option value="">선택</option>

												<option value="REA" selected="selected">실물</option>

												<option value="GIFTCARD">상품권</option>

										</select></td>
										<th>상품군</th>
										<td><select name="goods_zone" id="goods_zone">
												<option value="">선택</option>
										</select></td>
									</tr>
									<tr>
										<th>상품명</th>
										<td><input type="text" id="goods_name" name="goods_name" placeholder="상품명" value="[To-go] 카페 아메리카노 Tall 4잔   카페 라떼 Tall 4잔 세트" /></td>
										<th>모델명</th>
										<td><input type="text" id="model_name" name="model_name" placeholder="모델명" value="[To-go] 카페 아메리카노 Tall 4잔   카페 라떼 Tall 4잔 세트" /></td>
									</tr>
									<tr>
										<th>상태</th>
										<td><span class="flowType"><input type="radio" name="goods_status" value="1" checked><label for="radio6">판매중</label></span> <span class="flowType"><input type="radio"
												name="goods_status" value="2"><label for="radio7">판매중지</label></span> <span class="flowType"><input type="radio" name="goods_status" value="3"><label for="radio7">단종</label></span>
										</td>
										<th>일회 최대 구매 개수</th>
										<td><input class="onlyNumber" type="text" placeholder="일회 최대 구매 개수" id="max_sale_cnt" name="max_sale_cnt" value="1" /></td>
									</tr>
									<tr>
										<th>핀생성방법</th>
										<td><span class="flowType"><input type="radio" name="pin_method" value="1"><label for="radio6">자체핀</label></span> <span class="flowType"><input type="radio"
												name="pin_method" value="2" checked><label for="radio7">외부핀</label></span> <span class="flowType"><input type="radio" name="pin_method" value="3"><label for="radio7">선생성핀</label></span>
										</td>
										<th>핀 통합 설정</th>
										<td><span class="flowType"><input type="radio" name="pin_sept_gubun" value="1"><label for="radio6">통합 가능</label></span> <span class="flowType"><input type="radio"
												name="pin_sept_gubun" value="2" checked><label for="radio7">통합 불가능</label></span></td>
									</tr>
									<tr>
										<th>상품형태</th>
										<td><span class="flowType"><input type="radio" name="goods_type" value="1" checked><label for="radio6">단일상품</label></span> <span class="flowType"><input type="radio"
												name="goods_type" value="6"><label for="radio7">상품권</label></span> <!-- span class="flowType"><input type="radio" name="goods_type" value="8"  ><label for="radio7">이용권</label></span--></td>
										<th>기간만료 확인 여부</th>
										<td><span class="flowType"><input type="radio" name="expiration_flag" value="Y" checked><label for="radio6">확인</label></span> <span class="flowType"><input type="radio"
												name="expiration_flag" value="N"><label for="radio7">미확인</label></span></td>
									</tr>
									<tr>
										<th>기본상품 설정</th>
										<td><span class="flowType"><input type="radio" name="default_flag" value="1" checked><label for="radio6">설정</label></span> <span class="flowType"><input type="radio"
												name="default_flag" value="2"><label for="radio7">미설정</label></span></td>
										<th>교환 가능 여부</th>
										<td><span class="flowType"><input type="radio" name="exchange_flag" value="1" checked><label for="radio6">교환 가능</label></span> <span class="flowType"><input type="radio"
												name="exchange_flag" value="2"><label for="radio7">교환 불가능</label></span></td>
									</tr>
									<tr>
										<th>취소 가능 설정</th>
										<td><span class="flowType"><input type="radio" name="cancel_flag" value="1" checked><label for="radio6">취소 가능</label></span> <span class="flowType"><input type="radio"
												name="cancel_flag" value="2"><label for="radio7">취소 불가능</label></span></td>
										<th>환불 가능 여부</th>
										<td><span class="flowType"><input type="radio" name="refund_flag" value="1" checked><label for="radio6">환불 가능</label></span> <span class="flowType"><input type="radio"
												name="refund_flag" value="2"><label for="radio7">환불 불가능</label></span></td>
									</tr>
									<tr>
										<th>판매기간</th>
										<td>
											<div class="calendar">
												<input type="text" name="sale_start_date" id="sale_start_date" readonly value="20200412" class="datepicker01">
											</div> <span> ~ </span>
											<div class="calendar">
												<input type="text" name="sale_end_date" id="sale_end_date" readonly value="20200711" class="datepicker02">
											</div>
										</td>
										<th>유효일수</th>
										<td>
											<div class="col-three">
												<input class="onlyNumber" type="text" id="limit_date" name="limit_date" placeholder="유효일수" value="60" /><span style="color: red;">ex:유효일자:60/종료일자:20010101</span>
											</div>
										</td>
									</tr>
									<tr>
										<th>PIN 폐기 연동 여부</th>
										<td><span class="flowType"><input type="radio" name="pin_discard_yn" value="Y" checked><label for="radio6">가능</label></span> <span class="flowType"><input type="radio"
												name="pin_discard_yn" value="N"><label for="radio7">불가능</label></span></td>
										<th>자동 환불 여부</th>
										<td><span class="flowType"><input type="radio" name="auto_refund_yn" value="Y" checked><label for="radio6">가능</label></span> <span class="flowType"><input type="radio"
												name="auto_refund_yn" value="N"><label for="radio7">불가능</label></span></td>
									</tr>
									<tr>
										<th>연장 가능 여부</th>
										<td><span class="flowType"><input type="radio" name="extend_yn" value="Y" checked><label for="radio6">가능</label></span> <span class="flowType"><input type="radio"
												name="extend_yn" value="N"><label for="radio7">불가능</label></span></td>
										<th>B2B 상품 여부</th>
										<td><span class="flowType"><input type="radio" name="b2b_goods_yn" value="Y"><label for="radio6">가능</label></span> <span class="flowType"><input type="radio"
												name="b2b_goods_yn" value="N" checked><label for="radio7">불가능</label></span></td>
									</tr>
									<tr>
										<th>바코드 출력 유무</th>
										<td><span class="flowType"><input type="radio" name="barcode_yn" value="Y" checked><label for="radio6">출력</label></span> <span class="flowType"><input type="radio"
												name="barcode_yn" value="N"><label for="radio7">미출력</label></span></td>
										<th></th>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2>상품 정산 정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>상품 정산 정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%">
									<col style="width: 15%;">
									<col style="width: 35%">
								</colgroup>
								<tbody>
									<tr>
										<th>매출 정산 방법</th>
										<td><span class="flowType"><input type="radio" name="sell_method" value="1" checked><label for="radio6">사용</label></span> <span class="flowType"><input type="radio"
												name="sell_method" value="2"><label for="radio7">발행</label></span> <span class="flowType"><input type="radio" name="sell_method" value="3"><label for="radio8">선매입</label></span></td>
										<th>공급 수수료</th>
										<td>
											<div class="col-three">
												<input type="text" id="goods_com_fee" name="goods_com_fee" placeholder="공급 수수료" value="1.0" /> %
											</div>
										</td>
									</tr>
									<tr>
										<th>매입단가<br /> <span style="font-size: 12px;">(공급가액/부가세/합계)</span></th>
										<td colspan="3">
											<div class="col-three">
												<input class="onlyNumber purchase" type="text" id="purchase_amt" name="purchase_amt" placeholder="공급가액" value="31636" />/ <input class="onlyNumber purchase" type="text" id="purchase_vat"
													name="purchase_vat" placeholder="부가세" value="3164" />/ <input type="text" id="purchase_sum" name="purchase_sum" placeholder="합계" value="34800" readonly="readonly" />
											</div>
										</td>
									</tr>
									<tr>
										<th>판매단가<br /> <span style="font-size: 12px;">(공급가액/부가세/합계)</span></th>
										<td colspan="3">
											<div class="col-three">
												<input class="onlyNumber sale" type="text" id="sale_amt" name="sale_amt" placeholder="공급가액" value="31636" />/ <input class="onlyNumber sale" type="text" id="sale_vat" name="sale_vat"
													placeholder="부가세" value="3164" />/ <input type="text" id="sale_sum" name="sale_sum" placeholder="합계" value="34800" readonly="readonly" />
											</div>
										</td>
									</tr>
									<tr>
										<th>실판매단가<br /> <span style="font-size: 12px;">(공급가액/부가세/합계)</span></th>
										<td colspan="3">
											<div class="col-three">
												<input class="onlyNumber sale_discount" type="text" id="sale_discount_amt" name="sale_discount_amt" placeholder="공급가액" value="31636" />/ <input class="onlyNumber sale_discount"
													type="text" id="sale_discount_vat" name="sale_discount_vat" placeholder="부가세" value="3164" />/ <input type="text" id="sale_discount_sum" name="sale_discount_sum" placeholder="합계"
													value="34800" readonly="readonly" />
											</div>
										</td>
									</tr>
									<tr>
										<th>매입 전환 비용</th>
										<td colspan="3">
											<div class="col-three">
												<input class="onlyNumber" type="text" id="buy_conv_amt" name="buy_conv_amt" placeholder="매입 전환 비용" value="0" />
											</div>
										</td>
									</tr>
									<tr>
										<th>공급사 고유 ID</th>
										<td><input type="text" id="oth_pro_org_id" name="oth_pro_org_id" placeholder="공급사 고유 ID" value="9999999" /></td>
										<th>제휴사 부담금</th>
										<td><input class="onlyNumber" type="text" id="oth_joincom_amt" name="oth_joincom_amt" placeholder="제휴사 부담금" value="0" /></td>
									</tr>
									<tr>
										<th>공급사 바코드</th>
										<td><input type="text" id="oth_pro_barcode" name="oth_pro_barcode" placeholder="공급사 바코드" value="" /></td>
										<th>공급사 부담금</th>
										<td><input class="onlyNumber" type="text" id="oth_procom_amt" name="oth_procom_amt" placeholder="공급사 부담금" value="0" /></td>
									</tr>
									<tr>
										<th>공급업체 코드</th>
										<td><input type="text" id="oth_pro_code" name="oth_pro_code" placeholder="공급업체 코드" value="" /></td>
										<th>상품원가</th>
										<td><input class="onlyNumber" type="text" id="oth_pro_org_amt" name="oth_pro_org_amt" placeholder="상품원가" value="34800" /></td>
									</tr>
									<tr>
										<th>NOTE</th>
										<td colspan="3"><input type="text" id="amt_note" name="amt_note" placeholder="NOTE" value="" /></td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2>상품 이미지 정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>상품 이미지 정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%">
									<col style="width: 15%;">
									<col style="width: 35%">
								</colgroup>
								<tbody>
									<tr>
										<th>상품 이미지</th>
										<td colspan="3"><span class="imgWrap"> <img src="http://cms.unlock.gift/Resource/images/goods/G00000004740/goods_img5.jpg" />
										</span> <input type="file" id="goods_img5" name="goods_img5" value="goods_img5.jpg" /> <a class="btnBase"
											onclick="javascript:imgPreview('http://cms.unlock.gift/Resource/images/goods/', '/G00000004740/goods_img5.jpg')">미리보기</a> <span style="font-size: 12px; color: red;">(★ JPG만 가능, 크기는
												가로500 * 세로500)</span></td>
									</tr>
									<tr>
										<th>발송MMS템플릿</th>
										<td colspan="3"><span class="imgWrap"> <img src="http://cms.unlock.gift/Resource/images/goods/G00000004740/goods_img4.jpg" />
										</span> <input type="file" id="goods_img4" name="goods_img4" value="goods_img4.jpg" /> <a class="btnBase"
											onclick="javascript:imgPreview('http://cms.unlock.gift/Resource/images/goods/', '/G00000004740/goods_img4.jpg')">미리보기</a> <span style="font-size: 12px; color: red;">(★ JPG만 가능, 크기는
												가로280 * 세로280)</span></td>
									</tr>
									<tr>
										<th>상품설명 이미지(유선)</th>
										<td colspan="3"><span class="imgWrap"> <img src="/images/common/bg_buy.png" />
										</span> <input type="file" id="goods_img2" name="goods_img2" value="" /> <a class="btnBase" onclick="javascript:imgPreview('http://cms.unlock.gift/Resource/images/goods/', '/G00000004740/')">미리보기</a>
											<span style="font-size: 12px; color: red;">(★ JPG만 가능, 크기는 가로450 * 세로 450)</span></td>
									</tr>
									<tr>
										<th>상품설명 이미지(모바일웹)</th>
										<td colspan="3"><span class="imgWrap"> <img src="/images/common/bg_buy.png" />
										</span> <input type="file" id="goods_img3" name="goods_img3" value="" /> <a class="btnBase" onclick="javascript:imgPreview('http://cms.unlock.gift/Resource/images/goods/', '/G00000004740/')">미리보기</a>
											<span style="font-size: 12px; color: red;">(★ JPG만 가능, 크기는 가로280 * 세로 280)</span></td>
									</tr>
								</tbody>
							</table>
						</div>

						<h2>상품설명</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>상품설명</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *">
								</colgroup>
								<tbody>
									<tr>
										<th>상품설명</th>
										<td colspan="3"><textarea class="txtLong" id="goods_expl" name="goods_expl" placeholder="상품설명">[이용안내]
- 모바일쿠폰은 온라인 주문으로 사용 가능합니다.
- 교환은 온라인 주문으로만 사용 가능합니다.
- 온라인 주문방법 : http://www.goobne.co.kr
굽네치킨 홈페이지 접속 → 온라인주문 클릭 → 로그인 및 비회원 주문 클릭 → 배달지 등록 및 배달지 선택
→ E쿠폰 주문(스마트콘) 클릭 → 쿠폰번호 입력 후 장바구니 담기 → 결제하기 → 완료(유효기간 이내 사용)
</textarea></td>
									</tr>
									<tr>
										<th>MMS 추가 문구</th>
										<td colspan="3"><textarea class="txtLong" id="mms_content" name="mms_content" placeholder="MMS 추가 문구">[이용안내]
- 모바일쿠폰은 온라인 주문으로 사용 가능합니다.
- 교환은 온라인 주문으로만 사용 가능합니다.
- 온라인 주문방법 : http://www.goobne.co.kr
굽네치킨 홈페이지 접속 → 온라인주문 클릭 → 로그인 및 비회원 주문 클릭 → 배달지 등록 및 배달지 선택
→ E쿠폰 주문(스마트콘) 클릭 → 쿠폰번호 입력 후 장바구니 담기 → 결제하기 → 완료(유효기간 이내 사용)
</textarea></td>
									</tr>
									<tr>
										<th>WEB 추가 문구</th>
										<td colspan="3"><textarea class="txtLong" id="web_content" name="web_content" placeholder="WEB 추가 문구">[이용안내]
- 모바일쿠폰은 온라인 주문으로 사용 가능합니다.
- 교환은 온라인 주문으로만 사용 가능합니다.
- 온라인 주문방법 : http://www.goobne.co.kr
굽네치킨 홈페이지 접속 → 온라인주문 클릭 → 로그인 및 비회원 주문 클릭 → 배달지 등록 및 배달지 선택
→ E쿠폰 주문(스마트콘) 클릭 → 쿠폰번호 입력 후 장바구니 담기 → 결제하기 → 완료(유효기간 이내 사용)
</textarea></td>
									</tr>
									<tr>
										<th>검색어</th>
										<td colspan="3"><textarea class="txtLong" id="search_text" name="search_text" placeholder="검색어">스타벅스</textarea></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
				</form>
				<div class="btnArea alignR">
					<a class="btnType05" onclick="javascript:updateGoods();">수정</a> <a class="btnType04" href="/goods/goodsList.do">목록보기</a>
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
