<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<title>기업관리상세 | EPOPKON</title>
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
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript" src="/resources/js/custom.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
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
			if ('companyBasic' == $(this).attr('id')) {
				$(this).addClass('on');
			}
		});
		// tab menu setting end

		// ip setting start
		checkedIpGubun($("#ip_gubun").val());
		$("input[name='ip_gubun']").bind('change', function() {
			checkedIpGubun($(this).val());
		});
		// ip setting end

		// tot limit check start
		$("#tot_limit_check").bind('click', function() {
			if (!$("#tot_limit_amt").prop("readonly")) {
				$("#tot_limit_amt").prop("readonly", true);
			} else {
				$("#tot_limit_amt").prop("readonly", false);
			}
		});
		// tot limit check end

		// only number check start
		$("#tot_limit_amt").keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		// only number check end

		if ($("input:checkbox[id='tot_limit_check']").is(":checked")) {
			$("#tot_limit_amt").prop("readonly", false);
		}

	});

	function checkedIpGubun(gubun) {
		if (gubun == '1' || gubun == '2') {
			$("#ip").show();
			$("#ip_range").hide();
		} else {
			$("#ip").hide();
			$("#ip_range").show();
		}
	}

	function updateCompany() {

		$("#tot_limit_amt").val(
				$("#tot_limit_amt").val().replace(/[^0-9]/gi, ""));

		if ($("input:checkbox[id='tot_limit_check']").is(":checked")) {
			$("#limit_flag").val("Y");
		}

		$("#user_gubun").val($("#user_gubun_select option:selected").val());

		var mmsTextImg450 = $("#mms_text_img_450").val();

		/* 	
		if(mmsTextImg450 == "" || typeof(mmsTextImg450) == 'undefined'  ){
			alert("MMS TEXT ì´ë¯¸ì§ê° ì¡´ì¬íì§ ììµëë¤.");
			$("#mms_text_img450").focus();
			return;
		}
		 */
		// upload file ext check start
		var uploadFileType = "";
		if (mmsTextImg450 != '' && typeof (mmsTextImg450) != 'undefined')
			uploadFileType += mmsTextImg450 + ",";
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
				$("#frm").attr('action', '/company/updateCompany.do');
				$("#frm").submit();
			}
		} else {
			alert("이미지는 jpg, jpeg, png, gif, bmp 파일만 등록이 가능합니다.");
			return;
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
					<li><a href="/user/user_main" class="companyList">기업관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->
			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/company/companyList.do">기업관리</a> &gt; <a onclick="javascript:commonGetUrl('/company/companyListDetail.do', 'user_id=comang');" class="on">기업관리상세</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" enctype="multipart/form-data" method="post">
					<input type="hidden" id="user_id" name="user_id" value="comang" /> <input type="hidden" id="user_gubun" name="user_gubun" value="M002" /> <input type="hidden" id="ip_gubun" name="ip_gubun"
						value="1" /> <input type="hidden" id="limit_flag" name="limit_flag" value="Y" />

					<!-- tab start -->

					<div class="tabType01">
						<ul class="clearfix">
							<li id="companyBasic" class="on"><a href="/company/companyDetail">기본정보</a></li>
							<li id="companyPoint" class=" "><a href="/company/companyPointList">금액정보</a></li>
							<li id="companyCommission" class=" "><a href="/company/companyCommisionList">수수료정보</a></li>
							<!--<li id="companyDeco"><a onclick="javascript:commonGetUrl('/company/companyDecoList.do', 'user_id=comang');" >꾸미기정보</a></li>-->
						</ul>
					</div>
					<!-- tab end -->

					<div id="content">

						<h2>기본정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- 	<caption>기본정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%">
									<col style="width: 15%;">
									<col style="width: 35%">
								</colgroup>
								<tbody>
									<tr>
										<th>ID</th>
										<td>comang</td>
										<th>비밀번호</th>
										<td><input type="password" id="pwd" name="pwd" placeholder="비밀번호" value="123123" /></td>
									</tr>
									<tr>
										<th>기업명</th>
										<td><input type="text" id="user_name" name="user_name" placeholder="기업명" value="꼬망세" /></td>
										<th>법인명</th>
										<td>
											<div class="col-two">
												<input type="text" id="biz_name" name="biz_name" placeholder="법인명" value="(주)꼬망세미디어" />
												<!-- span class="flowType"><a class="btnBase" onclick="javascript:findName('/company/searchBizList.do', 'biz');">찾기</a></span-->
											</div>
										</td>
									</tr>
									<tr>
										<th>대표자</th>
										<td colspan="3"><input type="text" id="biz_ceo" name="biz_ceo" placeholder="대표자" value="최남호" /></td>
									</tr>
									<tr>
										<th>사업장소재지</th>
										<td colspan="3"><input type="text" id="biz_addr" name="biz_addr" placeholder="사업장소재지" value="서울시 강남구 도곡동 946-6 동문빌딩" /></td>
									</tr>
									<tr>
										<th>본점소재지</th>
										<td colspan="3"><input type="text" id="biz_bon_addr" name="biz_bon_addr" placeholder="본점소재지" value="서울시 강남구 도곡동 946-6 동문빌딩" /></td>
									</tr>
									<tr>
										<th>종목</th>
										<td><input type="text" id="biz_kind" name="biz_kind" placeholder="종목" value="월간교육잡지,도서출판,전자출판업외" /></td>
										<th>업태</th>
										<td><input type="text" id="biz_type" name="biz_type" placeholder="업태" value="제조,도매,소매업외" /></td>
									</tr>
									<tr>
										<th>기업상태</th>
										<td colspan="3"><select name="user_status" id="user_status">
												<option value="">선택</option>
												<option value="1" selected="selected">거래중</option>
												<option value="2">거래중지</option>
												<option value="3">승인대기</option>
												<option value="4">해지</option>
										</select></td>
									</tr>
									<!-- tr>
								<th>ìí/ìê¸ì£¼/ê³ì¢ë²í¸</th>
								<td colspan="3">
									<div class="col-three">
										<select name="bank_code" disabled="disabled">
											<option value="">선택</option>
											<option value="">사용</option>
											<option value="">사용안함</option>
										</select>
										<input type="text" id="bank_user" name="bank_user" placeholder="tepm1" readonly="readonly" />
										<input type="text" id="bank_no" name="bank_no" placeholder="tepm2" readonly="readonly" />
									</div>
								</td>
							</tr-->
									<tr>
										<th>총한도금액</th>
										<td>
											<div class="col-two">
												<input type="text" placeholder="총한도금액" id="tot_limit_amt" name="tot_limit_amt" value="10,000,000" readonly="readonly" /> <span class="flowType"><input type="checkbox"
													id="tot_limit_check" checked="checked"><label for="tot_limit_check">한도설정</label></span>
											</div>
										</td>
										<th>사용가능금액</th>
										<td>9,539,400</td>
									</tr>
									<!-- tr>
								<th>일별 발송한도</th>
								<td><input type="text" placeholder="일별 발송한도" id="send_day_amt" name="send_day_amt" value="0" /></td>
								<th>월별 발송한도</th>
								<td><input type="text" placeholder="월별 발송한도" id="send_month_amt" name="send_month_amt" value="0" /></td>
							</tr-->
									<tr>
									<tr>
										<th>기업서비스구분</th>
										<td><select name="user_gubun_select" id="user_gubun_select">
												<option value="">선택</option>
												<option value="M002" selected="selected">매체사</option>
												<option value="G002">상품공급사</option>
												<option value="Y002">영업대행사</option>
												<option value="Y003">광고주</option>
										</select></td>
										<th>IP형태</th>
										<td><span class="flowType"><input type="radio" name="ip_gubun" value="1" checked><label for="radio6">단일</label></span> <span class="flowType"><input type="radio"
												name="ip_gubun" value="2"><label for="radio7">복수</label></span> <span class="flowType"><input type="radio" name="ip_gubun" value="3"><label for="radio7">대역대</label></span></td>
									</tr>
									<tr>
										<th>IP(:구분)</th>
										<td colspan="3">
											<div class="col-three">
												<input type="text" id="ip" name="ip" value="127.0.0.1:123.108.163.163" /> <span id="ip_range"> <input type="text" id="ip_start" name="ip_start" value="" /> <span class="txt">-</span>
													<input type="text" id="ip_end" name="ip_end" value="" />
												</span>
											</div>
										</td>
									</tr>
									<!-- 
							<tr>
								<th>MMS TEXT이미지(450)</th>
								<td colspan="3">
									<span class="imgWrap">
										
										
										<img src="/images/common/bg_buy.png" />
									</span>
									<input type="file" id="mms_text_img_450" name="mms_text_img_450" value="" />	
									<a class="btnBase" onclick="javascript:imgPreview('http://cms.unlock.gift/Resource/images/company/comang', '')">미리보기</a>
								</td>
							</tr>
							<tr>
								<th>MMS TEXT</th>
								<td colspan="3">
									<input type="text" id="mms_text" name="mms_text" value="" />
								</td>
							</tr>
							-->
								</tbody>
							</table>
						</div>

						<h2>담당자정보</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- 	<caption>
									담당자정보
									</h2>
								</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%;">
									<col style="width: 15%;">
									<col style="width: 35%;">
								</colgroup>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input type="text" name="cust_user_name" id="cust_user_name" placeholder="이름" value="고미정" /></td>
										<th>부서명</th>
										<td><input type="text" name="cust_user_dept" id="cust_user_dept" placeholder="부서명" value="온라인사업부" /></td>
									</tr>
									<tr>
										<th>연락처(회사)</th>
										<td><input type="text" name="cust_user_tel_no" id="cust_user_tel_no" placeholder="연락처(회사)" value="0234974000" /></td>
										<th>연락처(휴대폰)</th>
										<td><input type="text" name="cust_user_phone_no" id="cust_user_phone_no" placeholder="연락처(휴대폰)" value="01040514012" /></td>
									</tr>
									<tr>
										<th>이메일</th>
										<td colspan="3"><input type="text" name="cust_user_email" id="cust_user_email" placeholder="이메일" value="3246319@daum.net" /></td>
										<!-- th>ë§¤ì¶ë´ë¹</th>
								<td>
									<select name="sales_id" id="sales_id">
										<option value="couponadmin"  >관리자</option>
										<option value="test"  >테스트</option>
										<option value="baemin"  >배달의민족</option>
									</select>
								</td-->
									</tr>
									<tr>
										<th>MEMO</th>
										<td colspan="3"><input type="text" name="memo" id="memo" placeholder="MEMO" value="포인트몰" /></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
				</form>
				<div class="btnArea alignR">

					<a class="btnType05" onclick="javascript:updateCompany();">수정</a> <a class="btnType04" href="/user/user_main">목록보기</a>
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
