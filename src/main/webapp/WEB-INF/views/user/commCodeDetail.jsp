<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/jquery-ui.css" />
<title>공통코드 상세 | SISCUS</title>
<meta name="Description" content="Qool Solutions">
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/ui.js"></script>
<script type="text/javascript" src="/js/paging.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

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
					if ('commCodeList' == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// left menu setting end
				$("#saveBtn").hide();
				$("#uptBtn").hide();
				$("#regBtn1").hide();

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

			});

	function goPageNo(pageNo) {
		$("#page").val(pageNo);
		$("#frm").attr("action", "/system/commCodeDetail.do");
		$("#frm").submit();
	}

	function goDetailForm(codeName, codeGrpId, code, codeDepth, status, codeSeq) {

		//form initialize
		$("#insert_div").hide();
		$("#detail_frm")[0].reset();
		$("#insert_frm")[0].reset();
		$("#detail_div").show();
		$("#regBtn").hide();
		$("#saveBtn").hide();
		$("#regBtn1").show();
		$("#uptBtn").show();
		// value setting
		$("#detail_frm").find("#detail_type").val("detail");
		$("#detail_frm").find("#code_seq").val(codeSeq);
		$("#detail_frm").find("#code_name").val(codeName);
		$("#detail_frm").find("#code_depth").val(codeDepth);
		$("#detail_frm").find("#code_grp_id").val(codeGrpId);
		$("#detail_frm").find("#code").val(code);
		// not used
		if ("0" == status) {
			$("#detail_frm").find("#status1").prop('checked', false);
			$("#detail_frm").find("#status2").prop('checked', true);
		} else {
			$("#detail_frm").find("#status1").prop('checked', true);
			$("#detail_frm").find("#status2").prop('checked', false);
		}

	}

	function goInsertForm() {
		$("#detail_div").hide();
		$("#regBtn").hide();
		$("#uptBtn").hide();
		$("#regBtn1").hide();
		$("#saveBtn").show();
		$("#detail_frm")[0].reset();
		$("#insert_frm")[0].reset();
		$("#insert_div").show();
		$("#insert_frm").find("#insert_type").val("insert");

		$("#insert_frm").find("#code_grp_id").val("B2B_USER_TYPE");
		$("#insert_frm").find("#code_grp_id").val("B2B_USER_TYPE");

		$("#insert_frm").find("#code_grp_id").attr("disabled", "disabled");
		$("#insert_frm").find("#code_grp_id").attr("disabled", "disabled");
	}

	function insertCommCode() {

		var codeName = $("#insert_frm").find("#code_name").val();
		var codeDepth = $("#insert_frm").find("#code_depth").val();
		var codeGrpId = $("#insert_frm").find("#code_grp_id").val();
		var code = $("#insert_frm").find("#code").val();
		var status = $("#insert_frm").find("input[name='status']:checked")
				.val();

		console.log('codeName : ' + codeName + ', codeDepth : ' + codeDepth
				+ ', codeGrpId : ' + codeGrpId + ', code : ' + code
				+ ', status : ' + status);

		if (codeName == "" || typeof (codeName) == 'undefined') {
			alert("코드명을 입력하세요.");
			$("#insert_frm").find("#code_name").focus();
			return;
		}
		if (codeDepth == "" || typeof (codeDepth) == 'undefined') {
			alert("서브 코드가 존재하지 않습니다.");
			$("#insert_frm").find("#code_depth").focus();
			return;
		}
		if (codeDepth == "0") {
			alert("서브 코드는 0이 될 수 없습니다.");
			$("#insert_frm").find("#code_depth").focus();
			return;
		}
		if (codeGrpId == "" || typeof (codeGrpId) == 'undefined') {
			alert("공통코드 구분 ID");
			$("#insert_frm").find("#code_grp_id").focus();
			return;
		}
		if (code == "" || typeof (code) == 'undefined') {
			alert("코드값이 존재하지 않습니다.");
			$("#insert_frm").find("#code").focus();
			return;
		}
		if (status == "" || typeof (status) == 'undefined') {
			alert("사용유무 체크를 하지 않았습니다.");
			$("#insert_frm").find("#status").focus();
			return;
		}

		if (confirm("등록 하시겠습니까?")) {

			var param = "code_name=" + encParam($.trim(codeName));
			param += "&code_depth=" + encParam($.trim(codeDepth));
			param += "&code_grp_id=" + encParam($.trim(codeGrpId));
			param += "&code=" + encParam($.trim(code));
			param += "&status=" + encParam($.trim(status));

			$
					.ajax({
						type : 'post', // type : post or get
						async : false, // default : false
						url : '/system/insertCommCode.do',
						data : param,
						dataType : 'jsonp', // type : json, script , xml ...
						timeout : 10000,
						error : function(xhr, ajaxOptions, thrownError) {
							alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
							return;
						},
						success : function(data, textStatus) {
							alert(data.errorMsg);
							if ("0000" == data.errorCode) {
								location.href = "/system/commCodeDetail.do?code_grp_id="
										+ encParam($.trim(codeGrpId));
							}
						}
					});

		}

	}

	function updateCommCode() {

		var codeSeq = $("#detail_frm").find("#code_seq").val();
		var codeName = $("#detail_frm").find("#code_name").val();
		var codeDepth = $("#detail_frm").find("#code_depth").val();
		var codeGrpId = $("#detail_frm").find("#code_grp_id").val();
		var code = $("#detail_frm").find("#code").val();
		var status = $("#detail_frm").find("input[name='status']:checked")
				.val();

		console.log('codeName : ' + codeName + ', codeDepth : ' + codeDepth
				+ ', codeGrpId : ' + codeGrpId + ', code : ' + code
				+ ', status : ' + status);

		if (codeName == "" || typeof (codeName) == 'undefined') {
			alert("ì½ëëªì´ ì¡´ì¬íì§ ììµëë¤.");
			$("#detail_frm").find("#code_name").focus();
			return;
		}
		if (codeDepth == "" || typeof (codeDepth) == 'undefined') {
			alert("ìë¸ ì½ëê° ì¡´ì¬íì§ ììµëë¤.");
			$("#detail_frm").find("#code_depth").focus();
			return;
		}
		if (codeDepth == "0") {
			alert("ìë¸ ì½ëë 0ì´ ë  ì ììµëë¤.");
			$("#detail_frm").find("#code_depth").focus();
			return;
		}
		if (codeGrpId == "" || typeof (codeGrpId) == 'undefined') {
			alert("ê³µíµ ì½ë êµ¬ë¶ IDê° ì¡´ì¬íì§ ììµëë¤.");
			$("#detail_frm").find("#code_grp_id").focus();
			return;
		}
		if (code == "" || typeof (code) == 'undefined') {
			alert("ì½ëê°ì´ ì¡´ì¬íì§ ììµëë¤.");
			$("#detail_frm").find("#code").focus();
			return;
		}
		if (status == "" || typeof (status) == 'undefined') {
			alert("ì¬ì©ì ë¬´ ì²´í¬ë¥¼ íì§ ìììµëë¤.");
			$("#detail_frm").find("#status").focus();
			return;
		}

		if (confirm("수정 하시겠습니까?")) {

			var param = "code_seq=" + encParam($.trim(codeSeq));
			param += "&code_name=" + encParam($.trim(codeName));
			param += "&code_depth=" + encParam($.trim(codeDepth));
			param += "&code_grp_id=" + encParam($.trim(codeGrpId));
			param += "&code=" + encParam($.trim(code));
			param += "&status=" + encParam($.trim(status));

			$
					.ajax({
						type : 'post', // type : post or get
						async : false, // default : false
						url : '/system/updateCommCode.do',
						data : param,
						dataType : 'jsonp', // type : json, script , xml ...
						timeout : 10000,
						error : function(xhr, ajaxOptions, thrownError) {
							alert("접속이 원활하지 않습니다. 다시 시도해 주십시오.");
							return;
						},
						success : function(data, textStatus) {
							alert(data.errorMsg);
							if ("0000" == data.errorCode) {
								location.href = "/system/commCodeDetail.do?code_grp_id="
										+ encParam($.trim(codeGrpId));
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

		<!-- Header end -->
		
		<c:if test="${member != null}">
			<section id="gnb">
				<div class="container">
					<ul class="clearfix">
						<li><a href="/user/user_main" class="companyMng ">기업관리</a></li>
						<li><a href="/send/campaignList" class="sendMng ">발송관리</a></li>
						<li><a href="/user/buy_list" class="buyMng">구매관리</a></li>
						<li><a href="/goods/goodsList.do" class="goodsMng">상품관리</a></li>
						<li><a href="/account/accountListDay.do" class="accountMng">정산관리</a></li>
						<li><a href="/user/user_list" class="systemMng on">시스템관리</a></li>
					</ul>
				</div>
			</section>
		</c:if>
		
		<section id="container" class="clearfix">
			<!-- LNB start -->



			<nav id="nav">
				<ul>
					<li><a href="/user/user_list" class="userList">계정관리</a></li>
					<li><a href="/user/commCodeList.do" class="commCodeList on">공통코드관리</a></li>
				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/system/commCodeList.do">시스템관리</a> &gt; <a href="/system/commCodeList.do">공통코드 목록</a> &gt; <a
						onclick="javascript:commonGetUrl('/system/commCodeDetail.do', 'code_grp_id=B2B_USER_TYPE');" class="on">공통코드 상세</a>
				</div>
				<!-- gnb end -->

				<div id="content">
					<form name="frm" id="frm" enctype="multipart/form-data" method="post">
						<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="4" /> <input
							type="hidden" id="code_grp_id" name="code_grp_id" value="B2B_USER_TYPE" />

						<h2>상세 코드 리스트</h2>
						(더블클릭시 코드정보 수정이 가능합니다)<span class="topAdd right">전체 : <strong>4</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
								<!-- <caption>상세 코드 리스트</caption> -->
								<thead>
									<tr>
										<th>No</th>
										<th>코드명</th>
										<th>코드 구분</th>
										<th>코드</th>
										<th>서브코드</th>
										<th>등록일짜</th>
									</tr>
								</thead>
								<tbody>

									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( '영업대행사',
																	 'B2B_USER_TYPE',
																	 'Y002',
																	 '1',
																	 '1',
																	 '2'
							);">
										<td class="alignC">1</td>
										<td class="alignC">영업대행사</td>
										<td class="alignC">B2B_USER_TYPE</td>
										<td class="alignC">Y002</td>
										<td class="alignC">1</td>
										<td class="alignC">2015-08-13</td>
									</tr>


									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( '광고주',
																	 'B2B_USER_TYPE',
																	 'Y003',
																	 '1',
																	 '1',
																	 '3'
							);">
										<td class="alignC">2</td>
										<td class="alignC">광고주</td>
										<td class="alignC">B2B_USER_TYPE</td>
										<td class="alignC">Y003</td>
										<td class="alignC">1</td>
										<td class="alignC">2015-08-13</td>
									</tr>


									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( '매체사',
																	 'B2B_USER_TYPE',
																	 'M002',
																	 '1',
																	 '1',
																	 '4'
							);">
										<td class="alignC">3</td>
										<td class="alignC">매체사</td>
										<td class="alignC">B2B_USER_TYPE</td>
										<td class="alignC">M002</td>
										<td class="alignC">1</td>
										<td class="alignC">2015-08-13</td>
									</tr>


									<tr style="cursor: pointer;"
										ondblclick="javascript:goDetailForm( '상품공급사',
																	 'B2B_USER_TYPE',
																	 'G002',
																	 '1',
																	 '1',
																	 '5'
							);">
										<td class="alignC">4</td>
										<td class="alignC">상품공급사</td>
										<td class="alignC">B2B_USER_TYPE</td>
										<td class="alignC">G002</td>
										<td class="alignC">1</td>
										<td class="alignC">2015-08-13</td>
									</tr>

								</tbody>

							</table>
						</div>
						<div class="comp sortArea">
							<div class="paging mt20" id="paging"></div>
						</div>
					</form>

					<form name="detail_frm" id="detail_frm" method="post">
						<input type="hidden" name="detail_type" id="detail_type" value="" /> <input type="hidden" name="code_seq" id="code_seq" value="" />

						<div class="comp" id="detail_div" style="display: none;">
							<h2>코드 정보</h2>
							<span class="topAdd right"> <a class="btnType01" id="regBtn1" onclick="javascript:goInsertForm();">등록</a>
							</span>

							<table class="tbType02">
								<!-- <caption>코드 정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *%">
								</colgroup>
								<tbody>
									<tr>
										<th>코드 명</th>
										<td><input type="text" id="code_name" name="code_name" placeholder="코드 명" value="" /></td>
									</tr>
									<tr>
										<th>서브코드</th>
										<td><input type="text" id="code_depth" name="code_depth" placeholder="서브코드" value="" /></td>
									</tr>
									<tr>
										<th>공통코드 구분 ID</th>
										<td><input type="text" id="code_grp_id" name="code_grp_id" placeholder="공통코드 구분 ID" value="" /></td>
									</tr>
									<tr>
										<th>코드값</th>
										<td><input type="text" id="code" name="code" placeholder="코드값" value="" /></td>
									</tr>
									<tr>
										<th>사용유무</th>
										<td><span class="flowType"><input type="radio" name="status" id="status1" value="1"><label for="status1">사용</label></span> <span class="flowType"><input type="radio"
												name="status" id="status2" value="0"><label for="status2">사용안함</label></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>

					<form name="insert_frm" id="insert_frm" method="post">
						<input type="hidden" name="detail_type" id="detail_type" value="" />
						<div class="comp" id="insert_div" style="display: none;">
							<h2>코드 정보</h2>

							<table class="tbType02">
							<!-- 	<caption>코드 정보</caption> -->
								<colgroup>
									<col style="width: 15%;">
									<col style="width: *%">
								</colgroup>
								<tbody>
									<tr>
										<th>코드 명</th>
										<td><input type="text" id="code_name" name="code_name" placeholder="코드 명" value="" /></td>
									</tr>
									<tr>
										<th>서브코드</th>
										<td><input type="text" id="code_depth" name="code_depth" placeholder="서브코드" value="" /></td>
									</tr>
									<tr>
										<th>공통코드 구분 ID</th>
										<td><input type="text" id="code_grp_id" name="code_grp_id" placeholder="공통코드 구분 ID" value="" /></td>
									</tr>
									<tr>
										<th>코드값</th>
										<td><input type="text" id="code" name="code" placeholder="코드값" value="" /></td>
									</tr>
									<tr>
										<th>사용유무</th>
										<td><span class="flowType"><input type="radio" name="status" value="1" checked="checked"><label for="radio6">사용</label></span> <span class="flowType"><input type="radio"
												name="status" value="0"><label for="radio7">사용안함</label></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>


				</div>

				<div class="btnArea alignR">
					<a class="btnType05" id="regBtn" onclick="javascript:goInsertForm();">등록</a> <a class="btnType05" id="saveBtn" onclick="javascript:insertCommCode();">저장</a> <a class="btnType05" id="uptBtn"
						onclick="javascript:updateCommCode();">수정</a> <a class="btnType04" href="/user/commCodeList.do">목록보기</a>
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
