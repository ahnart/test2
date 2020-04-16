<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">

<link rel="stylesheet" href="/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />

<title>계정관리상세 | EPOPKON</title>
<meta name="Description" content="Qool Solutions">
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/js/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/js/common/ui.js"></script>
<script type="text/javascript" src="/js/common/paging.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript">
	var iCurrPage = "";
	var iTotalCount = "";
	var iPageRow = "";
	var iPageBlock = "";

	$(document).ready(function() {
		// left menu setting start
		$("#nav > ul > li > a").each(function() {
			$(this).removeClass('on');
			if ('userList' == $(this).attr('class')) {
				$(this).addClass('on');
			}
		});
		// left menu setting end

		$("#selectM002").hide();
		$("#selectG002").hide();
		$("#selectY002").hide();
		$("#selectY003").hide();
		changeUserGubun('M002');
		$("select[name='user_gubun_select']").bind('change', function() {
			changeUserGubun($(this).val());
		});

	});

	function changeUserGubun(value) {
		if (value == "A000") {
			$("#chkB2bUserId").hide();
		} else {
			if (value == "M002") {
				$("#selectM002").show();
				$("#selectG002").hide();
				$("#selectY002").hide();
				$("#selectY003").hide();
			} else if (value == "G002") {
				$("#selectM002").hide();
				$("#selectG002").show();
				$("#selectY002").hide();
				$("#selectY003").hide();
			} else if (value == "Y002") {
				$("#selectM002").hide();
				$("#selectG002").hide();
				$("#selectY002").show();
				$("#selectY003").hide();
			} else if (value == "Y003") {
				$("#selectM002").hide();
				$("#selectG002").hide();
				$("#selectY002").hide();
				$("#selectY003").show();
			}
			$("#chkB2bUserId").show();
		}
	}

	function updateUser() {

		var userNo = $("#user_no").val();
		var userName = $("#user_name").val();
		var userPasswd = $("#user_passwd").val();
		var userDept = $("#user_dept").val();
		var userPhoneNo = $("#user_phone_no").val();
		var userTelNo = $("#user_tel_no").val();
		var userEmail = $("#user_email").val();
		var useYn = $("input[name='use_yn']:checked").val();
		var salesFlag = $("input[name='sales_flag']:checked").val();
		var userGubun = $("#user_gubun_select").val();
		var b2bUserId = $("#b2b_user_id").val();
		var aFlag = 'Y';

		if (userPasswd == "" || typeof (userPasswd) == 'undefined') {
			alert("비밀번호를 입력하세요.");
			$("#user_passwd").focus();
			return false;
		}

		if (aFlag == "Y") {
			if (userName == "" || typeof (userName) == 'undefined') {
				alert("회원명을 입력하세요.");
				$("#user_name").focus();
				return false;
			}
			if (userDept == "" || typeof (userDept) == 'undefined') {
				alert("부서(팀)명을 입력하세요.");
				$("#user_dept").focus();
				return false;
			}
			if (userPhoneNo == "" || typeof (userPhoneNo) == 'undefined') {
				alert("연락처(HP)가 없습니다.");
				$("#user_phone_no").focus();
				return false;
			}
			if (userTelNo == "" || typeof (userTelNo) == 'undefined') {
				alert("연락처(TEL)를 입력하세요");
				$("#user_tel_no").focus();
				return false;
			}
			if (userEmail == "" || typeof (userEmail) == 'undefined') {
				alert("이메일을 입력하세요.");
				$("#user_email").focus();
				return false;
			}
			if (useYn == "" || typeof (useYn) == 'undefined') {
				alert("사용유무를 선택하세요.");
				$("#use_yn").focus();
				return false;
			}
			if (salesFlag == "" || typeof (salesFlag) == 'undefined') {
				alert("매출담당여부를 선택하세요.");
				$("#sales_flag").focus();
				return false;
			}
			if (userGubun == "" || typeof (userGubun) == 'undefined') {
				alert("회원구분을 선택하세요.");
				$("#user_gubun").focus();
				return false;
			}

			if (userGubun == "M002") {
				b2bUserId = $("#send_mass_id").val();
			} else if (userGubun == "G002") {
				b2bUserId = $("#goods_com_id").val();
			} else if (userGubun == "Y002") {
				b2bUserId = $("#agency_id").val();
			} else if (userGubun == "Y003") {
				b2bUserId = $("#adv_id").val();
			}

			if (b2bUserId == "" || typeof (b2bUserId) == 'undefined') {
				if (userGubun != "A000") {
					alert("관리기업을 선택하세요.");
					$("#user_gubun").focus();
					return false;
				}
			}
		}

		if (confirm("수정 하시겠습니까?")) {
			var aFlag = 'Y';
			var param = "&user_no=" + encParam($.trim(userNo));
			param += "&user_passwd=" + encParam($.trim(userPasswd));
			if (aFlag == "Y") {
				param += "&user_name=" + encParam($.trim(userName));
				param += "&user_dept=" + encParam($.trim(userDept));
				param += "&user_phone_no=" + encParam($.trim(userPhoneNo));
				param += "&user_tel_no=" + encParam($.trim(userTelNo));
				param += "&user_email=" + encParam($.trim(userEmail));
				param += "&use_yn=" + encParam($.trim(useYn));
				param += "&sales_flag=" + encParam($.trim(salesFlag));
				param += "&user_gubun=" + encParam($.trim(userGubun));
				param += "&b2b_user_id=" + encParam($.trim(b2bUserId));
			}

			$.ajax({
				type : 'post', // type : post or get
				async : false, // default : false
				url : '/system/updateUser.do',
				data : param,
				dataType : 'jsonp', // type : json, script , xml ...
				timeout : 10000,
				error : function(xhr, ajaxOptions, thrownError) {
					alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
					return;
				},
				success : function(data, textStatus) {
					if ("0000" == data.errorCode) {
						alert("수정 되었습니다.");
						return;
					} else {
						alert(data.errorMsg);
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
			var gnbType = 'systemMng';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("systemMng" == $(this).attr('class')) {
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
					<li><a href="/system/userList.do" class="userList">계정관리</a></li>

				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/system/commCodeList.do">시스템관리</a> &gt; <a href="/system/userList.do">계정관리</a> &gt; <a
						onclick="javascript:commonGetUrl('/system/userDetail.do', 'user_no=2');" class="on">계정관리상세</a>
				</div>
				<!-- gnb end -->

				<div id="content">
					<form name="frm" id="frm" enctype="multipart/form-data" method="post">
						<input type="hidden" id="user_no" name="user_no" value="2" /> <input type="hidden" id="b2b_user_id" name="b2b_user_id" value="comang" /> <input type="hidden" id="send_mass_id"
							name="send_mass_id" value="" /> <input type="hidden" id="goods_com_id" name="goods_com_id" value="" /> <input type="hidden" id="agency_id" name="agency_id" value="" /> <input type="hidden"
							id="adv_id" name="adv_id" value="" />

						<h2>상세 코드 리스트</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>공통코드 등록</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *%">
								</colgroup>

								<tbody>
									<tr>
										<th>계정</th>
										<td><div class="col-two">test</div></td>
									</tr>
									<tr>
										<th>회원명</th>
										<td><input type="text" id="user_name" name="user_name" placeholder="회원명" value="테스트" /></td>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td><input type="password" id="user_passwd" name="user_passwd" placeholder="비밀번호" value="123123" /></td>
									</tr>
									<tr>
										<th>소속(팀)</th>
										<td><input type="text" id="user_dept" name="user_dept" placeholder="소속(팀)" value="테스트" /></td>
									</tr>
									<tr>
										<th>연락처(HP)</th>
										<td><input class="onlyNumber" type="text" id="user_phone_no" name="user_phone_no" placeholder="연락처(HP)" value="01012341234" /></td>
									</tr>
									<tr>
										<th>연락처(TEL)</th>
										<td><input class="onlyNumber" type="text" id="user_tel_no" name="user_tel_no" placeholder="연락처(TEL)" value="02123456" /></td>
									</tr>
									<tr>
										<th>이메일</th>
										<td><input type="text" id="user_email" name="user_email" placeholder="이메일" value="test@test.co.kr" /></td>
									</tr>
									<tr>
										<th>사용유무</th>
										<td><span class="flowType"><input type="radio" name="use_yn" value="Y" checked="checked"><label for="radio6">사용</label></span> <span class="flowType"><input
												type="radio" name="use_yn" value="N"><label for="radio7">사용안함</label></span></td>
									</tr>
									<tr>
										<th>매출담당여부</th>
										<td><span class="flowType"><input type="radio" name="sales_flag" value="Y" checked="checked"><label for="radio6">사용</label></span> <span class="flowType"><input
												type="radio" name="sales_flag" value="N"><label for="radio7">사용안함</label></span></td>
									</tr>
									<tr>
										<th>회원구분</th>
										<td><select name="user_gubun_select" id="user_gubun_select">
												<option value="">선택</option>
												<option value="A000">관리자</option>
												<option value="M002" selected="selected">매체사</option>
												<option value="G002">상품공급사</option>
												<option value="Y002">영업대행사</option>
												<option value="Y003">광고주</option>
										</select></td>
									</tr>
									<tr id='chkB2bUserId'>
										<th>관리기업</th>
										<td>
											<div class="col-two" id="selectG002">
												<input type="text" id="goods_com_name" name="goods_com_name" placeholder="" value="꼬망세" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/company/searchGoodsComList.do', '');">찾기</a></span>
											</div>
											<!-- <div class="col-two" id="selectM002">
												<input type="text" id="send_mass_name" name="send_mass_name" placeholder="" value="꼬망세" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/company/searchMediaList.do', '');">찾기</a></span>
											</div>
											<div class="col-two" id="selectY002">
												<input type="text" id="agency_name" name="agency_name" placeholder="" value="꼬망세" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/company/searchAgencyList.do', '');">찾기</a></span>
											</div>
											<div class="col-two" id="selectY003">
												<input type="text" id="adv_name" name="adv_name" placeholder="" value="꼬망세" readonly="readonly" /><span class="flowType"><a class="btnBase"
													onclick="javascript:findName('/company/searchAdvList.do', '');">찾기</a></span>
											</div> -->
										</td>
									</tr>
								</tbody>


							</table>
						</div>
					</form>
				</div>

				<div class="btnArea alignR">
					<a class="btnType05" onclick="javascript:updateUser();">수정</a> <a class="btnType04" href="/user/user_list">목록보기</a>
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
