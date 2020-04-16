<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<title>기업 등록 화면 | EPOPKON</title>
<meta name="Description" content="Qool Solutions">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />

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
		$("input[name='ip_gubun']").bind('change', function() {
			checkedIpGubun($(this).val());
		});
		// ip setting end

		// only number check start
		$("#tot_limit_amt").keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		$("#cust_user_tel_no").keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		$("#cust_user_phone_no").keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		// only number check end

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

	function goMailSelect() {
		if ($("#cust_user_email_list").val() == "self") {
			$("#cust_user_email2").attr("readOnly", false);
			$("#cust_user_email2").val("");
		} else {
			$("#cust_user_email2").attr("readOnly", true);
			$("#cust_user_email2").val($("#cust_user_email_list").val());
		}
	}

	function checkUserId() {
		var userId = $("#user_id").val();
		if (userId == "" || typeof (userId) == 'undefined') {
			alert("기업아이디가 존재하지 않습니다.");
			return false;
		}

		var param = "user_id=" + encParam($.trim(userId));
		$.ajax({
			type : 'post', // type : post or get
			async : false, // default : false
			url : '/company/checkCompanyId.do',
			data : param,
			dataType : 'jsonp', // type : json, script , xml ...
			timeout : 10000,
			error : function(xhr, ajaxOptions, thrownError) {
				alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
				return false;
			},
			success : function(data, textStatus) {
				if (data.errorCode == '0000') {
					alert("가입 가능한 기업아이디 입니다.");
					$("#user_id_check_flag").val("Y");
					return true;
				} else {
					alert(data.errorMsg);
					$("#user_id_check_flag").val("N");
					return false;
				}
			}
		});
	}

	function insertCompany() {

		//checkUserId();

		var userId = $("#user_id").val();
		var userIdCheckFlag = $("#user_id_check_flag").val();
		var pwd = $("#pwd").val();
		var userName = $("#user_name").val();
		var bizName = $("#biz_name").val();
		var bizCeo = $("#biz_ceo").val();
		var bizAddr = $("#biz_addr").val();
		//var bizBonAddr = $("#biz_bon_addr").val();
		var bizKind = $("#biz_kind").val();
		var bizType = $("#biz_type").val();
		//var bankCode = $("#bank_code").val();
		//var bankUser = $("#bank_user").val();
		//var bankNo = $("#bank_no").val();
		var userGubun = $("#user_gubun").val();
		//var totLimitAmt = $("#tot_limit_amt").val();
		//var ipGubun = $("#ip_gubun").val();
		//var ip = $("#ip").val();
		//var ipStart = $("#ip_start").val();
		//var ipEnd = $("#ip_end").val();
		//var ipStart = $("#ip_start").val();
		//var mmsText = $("#mms_text").val();
		var custUserName = $("#cust_user_name").val();
		var custUserDept = $("#cust_user_dept").val();
		var custUserTelNo = $("#cust_user_tel_no").val();
		var custUserPhoneNo = $("#cust_user_phone_no").val();
		var custUserEmail1 = $("#cust_user_email1").val();
		var custUserEmail2 = $("#cust_user_email2").val();
		//var mmsTextImg450 = $("#mms_text_img_450").val();

		if (userId == "" || typeof (userId) == 'undefined') {
			alert("기업아이디가 존재하지 않습니다.");
			$("#user_id").focus();
			return;
		}
		if (userIdCheckFlag == "" || typeof (userIdCheckFlag) == 'undefined'
				|| userIdCheckFlag != 'Y') {
			alert("아이디 중복체크를 하지 않았습니다.");
			$("#user_id").focus();
			return;
		}
		if (pwd == "" || typeof (pwd) == 'undefined') {
			alert("패스워드가 존재하지 않습니다.");
			$("#pwd").focus();
			return;
		}
		if (userName == "" || typeof (userName) == 'undefined') {
			alert("기업명이 존재하지 않습니다.");
			$("#user_name").focus();
			return;
		}
		if (bizName == "" || typeof (bizName) == 'undefined') {
			alert("법인명이 존재하지 않습니다.");
			$("#biz_name").focus();
			return;
		}
		if (bizCeo == "" || typeof (bizCeo) == 'undefined') {
			alert("대표자명이 존재하지 않습니다.");
			$("#biz_ceo").focus();
			return;
		}
		if (bizAddr == "" || typeof (bizAddr) == 'undefined') {
			alert("주소가 존재하지 않습니다.");
			$("#biz_addr").focus();
			return;
		}
		if (bizKind == "" || typeof (bizKind) == 'undefined') {
			alert("종목이 존재하지 않습니다.");
			$("#biz_kind").focus();
			return;
		}
		if (bizType == "" || typeof (bizType) == 'undefined') {
			alert("업태가 존재하지 않습니다.");
			$("#biz_type").focus();
			return;
		}
		if (userGubun == "" || typeof (userGubun) == 'undefined') {
			alert("기업서비스 구분을 선택하세요.");
			$("#user_gubun").focus();
			return;
		}
		if (custUserName == "" || typeof (custUserName) == 'undefined') {
			alert("담당자명을 입력하세요.");
			$("#cust_user_name").focus();
			return;
		}
		if (custUserDept == "" || typeof (custUserDept) == 'undefined') {
			alert("담당자 부서명을 입력하세요.");
			$("#cust_user_dept").focus();
			return;
		}
		if (custUserTelNo == "" || typeof (custUserTelNo) == 'undefined') {
			alert("담당자 연락처(회사)를 입력하세요.");
			$("#cust_user_tel_no").focus();
			return;
		}
		if (custUserPhoneNo == "" || typeof (custUserPhoneNo) == 'undefined') {
			alert("담당자 연락처(휴대폰)를 입력하세요.");
			$("#cust_user_phone_no").focus();
			return;
		}
		if (custUserEmail1 == "" || typeof (custUserEmail1) == 'undefined') {
			alert("담당자 이메일을 입력하세요.");
			$("#cust_user_email1").focus();
			return;
		}
		if (custUserEmail2 == "" || typeof (custUserEmail2) == 'undefined') {
			alert("담당자 이메일을 입력하세요.");
			$("#cust_user_email2").focus();
			return;
		}
		// upload file ext check start
		/*
		var uploadFileType = "";
		if(mmsTextImg450 != '' && typeof(mmsTextImg450) != 'undefined') 	uploadFileType += mmsTextImg450+",";
		if(uploadFileType != '') 											uploadFileType = uploadFileType.substring(0, uploadFileType.lastIndexOf(","));	
		console.log("uploadFileType : " + uploadFileType + ', length : ' + uploadFileType.split(',').length );
		
		var result = true;
		if(uploadFileType != ''){
			for(var i=0; i<uploadFileType.split(',').length; i++){
				result = checkImg(uploadFileType.split(',')[i]);
			}
		}
		 */
		// upload file ext check end
		if (confirm("등록 하시겠습니까?")) {
			$("#frm").attr('action', '/company/insertCompany.do');
			$("#frm").submit();
		}
		/*	
		if(result){
			if(confirm("등록 하시겠습니까?")){
				$("#frm").attr('action', '/company/insertCompany.do');
				$("#frm").submit();	
			}
		}else{
			alert("이미지는 jpg, jpeg, png, gif, bmp 파일만 등록이 가능합니다.");
			return;
		}
		 */

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

		<section id="gnb">
			<div class="container">
				<ul class="clearfix">
					<li><a href="/user/user_main" class="companyMng">기업관리</a></li>

					<li><a href="/user/buy_list" class="buyMng">구매관리</a></li>

					<li><a href="/user/user_list" class="systemMng">시스템관리</a></li>
				</ul>
			</div>
		</section>

		<!-- Header end -->

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
					<a href="/">SISCUS</a> &gt; <a href="/company/companyList.do">기업관리</a> &gt; <a href="/company/insertCompanyForm.do" class="on">기업 등록 화면</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" enctype="multipart/form-data" method="post">
					<input type="hidden" name="user_id_check_flag" id="user_id_check_flag" value="N" />

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
										<th>ID</th>
										<td>
											<div class="col-two">
												<input type="text" id="user_id" name="user_id" placeholder="ID" value="" /><span class="flowType"><a class="btnBase" onclick="javascript:checkUserId();">중복확인</a></span>
											</div>
										</td>
										<th>비밀번호</th>
										<td><input type="password" id="pwd" name="pwd" placeholder="비밀번호" value="" /></td>
									</tr>
									<tr>
										<th>기업명</th>
										<td><input type="text" id="user_name" name="user_name" placeholder="기업명" value="" /></td>
										<th>법인명</th>
										<td>
											<div class="col-two">
												<input type="text" id="biz_name" name="biz_name" placeholder="법인명" value="" />
												<!-- span class="flowType"><a class="btnBase" onclick="javascript:findName('/company/searchBizList.do', 'biz');">찾기</a></span-->
											</div>
										</td>
									</tr>
									<tr>
										<th>대표자</th>
										<td colspan="3"><input type="text" id="biz_ceo" name="biz_ceo" placeholder="대표자" value="" /></td>
									</tr>
									<tr>
										<th>사업장소재지</th>
										<td colspan="3"><input type="text" id="biz_addr" name="biz_addr" placeholder="사업장소재지" value="" /></td>
									</tr>
									<tr>
										<th>본점소재지</th>
										<td colspan="3"><input type="text" id="biz_bon_addr" name="biz_bon_addr" placeholder="본점소재지" value="" /></td>
									</tr>
									<tr>
										<th>종목</th>
										<td><input type="text" id="biz_kind" name="biz_kind" placeholder="종목" value="" /></td>
										<th>업태</th>
										<td><input type="text" id="biz_type" name="biz_type" placeholder="업태" value="" /></td>
									</tr>
									<!-- tr>
								<th>ìí/ìê¸ì£¼/ê³ì¢ë²í¸</th>
								<td colspan="3">
									<div class="col-three">
										<select name="bank_code" id="bank_code">
											<option value="">선택</option>
											<option value="">사용</option>
											<option value="">사용안함</option>
										</select>
										<input type="text" id="bank_user" name="bank_user" placeholder="ìê¸ì£¼" />
										<input type="text" id="bank_no" name="bank_no" placeholder="ê³ì¢ë²í¸" />
									</div>
								</td>
							</tr-->
									<tr>
										<th>총한도금액</th>
										<td><input type="text" placeholder="총한도금액" id="tot_limit_amt" name="tot_limit_amt" value="0 (기업 등록 후  변경 가능합니다.)" readonly="readonly" /></td>
										<th>사용가능금액</th>
										<td>0 (기업 등록 후 변경 가능합니다.)</td>
									</tr>
									<tr>
										<th>기업서비스구분</th>
										<td><select name="user_gubun" id="user_gubun">
												<option value="">선택</option>
												<option value="M002">매체사</option>
												<option value="G002">상품공급사</option>
												<option value="Y002">영업대행사</option>
												<option value="Y003">광고주</option>
										</select></td>
										<th>IP형태</th>
										<td><span class="flowType"><input type="radio" name="ip_gubun" value="1" checked="checked"><label for="radio6">단일</label></span> <span class="flowType"><input
												type="radio" name="ip_gubun" value="2"><label for="radio7">복수</label></span> <span class="flowType"><input type="radio" name="ip_gubun" value="3"><label for="radio7">대역대</label></span>
										</td>
									</tr>
									<tr>
										<th>IP(:구분)</th>
										<td colspan="3">
											<div class="col-three">
												<input type="text" id="ip" name="ip" value="" /> <span id="ip_range" style="display: none;"> <input type="text" id="ip_start" name="ip_start" value="" /> <span class="txt">-</span>
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
								<caption>담당자정보</caption>
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 35%;">
									<col style="width: 15%;">
									<col style="width: 35%;">
								</colgroup>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input type="text" name="cust_user_name" id="cust_user_name" placeholder="이름" value="" /></td>
										<th>부서명</th>
										<td><input type="text" name="cust_user_dept" id="cust_user_dept" placeholder="부서명" value="" /></td>
									</tr>
									<tr>
										<th>연락처(회사)</th>
										<td><input type="text" name="cust_user_tel_no" id="cust_user_tel_no" placeholder="연락처(회사)" value="" /></td>
										<th>연락처(휴대폰)</th>
										<td><input type="text" name="cust_user_phone_no" id="cust_user_phone_no" placeholder="연락처(휴대폰)" value="" /></td>
									</tr>
									<tr>
										<th>이메일</th>
										<td colspan="3">
											<div class="col-three">
												<input type="text" name="cust_user_email1" id="cust_user_email1" placeholder="이메일1"> <span class="txt">@</span> <input type="text" name="cust_user_email2" id="cust_user_email2"
													placeholder="이메일2"> <select id="cust_user_email_list" name="cust_user_email_list" onChange="javascript:goMailSelect();">
													<option value="" selected="selected">선택</option>
													<option value="self">직접입력</option>
													<option value="gmail.com">gmail.com</option>
													<option value="kt.com">yahoo.co.jp</option>
													<option value="naver.com">naver.com</option>
												</select>
											</div>
										</td>

									</tr>
									<!-- tr>
								<th>ë§¤ì¶ë´ë¹</th>
								<td colspan="3"> 
									
									
									
									<select name="sales_id" id="sales_id">
										
										<option value="couponadmin" >관리자</option>
										
										<option value="test" >테스트</option>
										
										<option value="baemin" >배달의민족</option>
										
									</select>
									
									
								</td>
							</tr-->
									<tr>
										<th>MEMO</th>
										<td colspan="3"><input type="text" name="memo" id="memo" placeholder="MEMO" value="" /></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
				</form>
				<div class="btnArea alignR">
					<a class="btnType05" onclick="javascript:insertCompany();">등록</a> <a class="btnType04" href="/user/user_main">목록보기</a>
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
