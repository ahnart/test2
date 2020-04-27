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
<title>공통코드 등록 화면 | SISCUS</title>
<meta name="Description" content="Qool Solutions">
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/ui.js"></script>
<script type="text/javascript" src="/js/paging.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// left menu setting start
		$("#nav > ul > li > a").each(function() {
			$(this).removeClass('on');
			if ('commCodeList' == $(this).attr('class')) {
				$(this).addClass('on');
			}
		});
		// left menu setting end

	});

	function insertCommCode() {

		var codeName = $("#code_name").val();
		var codeDepth = $("#code_depth").val();
		var codeGrpId = $("#code_grp_id").val();
		var code = $("#code").val();
		var status = $("input[name='status']:checked").val();

		if (codeName == "" || typeof (codeName) == 'undefined') {
			alert("코드명을 입력하세요.");
			$("#code_name").focus();
			return;
		}
		if (codeDepth == "" || typeof (codeDepth) == 'undefined') {
			alert("서브 코드가 존재하지 않습니다.");
			$("#code_depth").focus();
			return;
		}
		if (codeGrpId == "" || typeof (codeGrpId) == 'undefined') {
			alert("공통 코드 구분 ID가 존재하지 않습니다.");
			$("#code_grp_id").focus();
			return;
		}
		if (code == "" || typeof (code) == 'undefined') {
			alert("코드값이 존재하지 않습니다.");
			$("#code").focus();
			return;
		}
		if (status == "" || typeof (status) == 'undefined') {
			alert("사용유무 체크를 하지 않았습니다.");
			$("#status").focus();
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

		<section id="container" class="clearfix">
			<!-- LNB start -->



			<nav id="nav">
				<ul>
					<li><a href="/system/userList.do" class="userList">계정관리</a></li>

					<li><a href="/system/commCodeList.do" class="commCodeList">공통코드관리</a></li>

				</ul>
			</nav>
			<!-- LNB end -->

			<section id="section">
				<!-- gnb start -->
				<div class="bradcrumb">
					<a href="/">SISCUS</a> &gt; <a href="/system/commCodeList.do">시스템관리</a> &gt; <a href="/system/commCodeList.do">공통코드 목록 </a> &gt; <a href="/system/insertCommCodeForm.do" class="on">공통코드 등록 화면</a>
				</div>
				<!-- gnb end -->
				<form name="frm" id="frm" method="post">

					<div id="content">

						<h2>공통코드 등록</h2>
						<div class="comp">
							<table class="tbType02">
								<!-- <caption>공통코드 등록</caption> -->
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
										<td><input type="text" id="code_depth" name="code_depth" placeholder="서브코드" value="0" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>공통코드 구분 ID</th>
										<td><input type="text" id="code_grp_id" name="code_grp_id" placeholder="공통코드 구분 ID" value="" /></td>
									</tr>
									<tr>
										<th>코드값</th>
										<td><input type="text" id="code" name="code" placeholder="코드값" value="0" readonly="readonly" /></td>
									</tr>
									<tr>
										<th>사용유무</th>
										<td><span class="flowType"><input type="radio" name="status" value="1" checked="checked"><label for="radio6">사용</label></span> <span class="flowType"><input type="radio"
												name="status" value="0"><label for="radio7">사용안함</label></span></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
				</form>
				<div class="btnArea alignR">
					<a class="btnType05" onclick="javascript:insertCommCode();">등록</a> <a class="btnType04" href="/user/commCodeList.do">목록보기</a>
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
