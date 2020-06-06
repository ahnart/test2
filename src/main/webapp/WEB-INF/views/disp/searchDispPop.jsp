<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>전시명 찾기 | SISCUS</title>
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
		$("#frm").attr("action", "/disp/searchDispList.do");
		$("#frm").submit();
	}

	function goSearch() {
		goPageNo(1);
	}

	function popClose() {
		window.close();
	}

	function gotoForm(dispNo, dispName) {
		if (dispNo == '' || typeof (dispName) == 'undefined') {
			alert("전시명을 선택하세요.");
			return;
		}
		$("#disp_no", opener.frm).val(dispNo);
		$("#disp_name", opener.frm).val(dispName);
		self.close();
	}
</script>
</head>

<body>
	<div id="popup">
		<form name="frm" id="frm" method="post">
			<input type="hidden" id="page" name="page" value="" /> <input type="hidden" id="pagecount" name="pagecount" value="" /> <input type="hidden" id="pagetotal" name="pagetotal" value="8" />

			<div id="wrap">
				<header id="header" class="clearfix">
					<h1>전시명 찾기</h1>
				</header>
				<section id="section">
					<div class="search">
						<div class="searchRow">
							<p class="searchTt">전시명</p>
							<input type="text" name="disp_name" id="disp_name" value="" /> <a class="btnType02" onclick="javascipt:goSearch();">조회</a>
						</div>
					</div>

					<div id="content">

						<h2>전시 선택</h2>
						<span class="topAdd">전체 : <strong>8</strong>개
						</span>
						<div class="comp">
							<table class="tbType01">
							<!-- 	<caption>전시목록</caption> -->
								<thead>
									<tr>
										<th>전시번호</th>
										<th>전시명</th>
										<th>할인 적용 여부</th>
										<th>할인율/할인금액</th>
									</tr>
								</thead>
								<tbody>




									<tr style="cursor: pointer;" onclick="javascript:gotoForm('8', '아이템로드');">
										<td class="alignC">8</td>
										<td class="alignC">아이템로드</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('7', '디지엠정보기술 (주)');">
										<td class="alignC">7</td>
										<td class="alignC">디지엠정보기술 (주)</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('6', '씨엠마케팅');">
										<td class="alignC">6</td>
										<td class="alignC">씨엠마케팅</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('5', '아람커뮤니케이션');">
										<td class="alignC">5</td>
										<td class="alignC">아람커뮤니케이션</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('4', '아이쿱');">
										<td class="alignC">4</td>
										<td class="alignC">아이쿱</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('3', '미밍_B2B');">
										<td class="alignC">3</td>
										<td class="alignC">미밍_B2B</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('2', '꼬망세');">
										<td class="alignC">2</td>
										<td class="alignC">꼬망세</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>

									<tr style="cursor: pointer;" onclick="javascript:gotoForm('1', '미밍');">
										<td class="alignC">1</td>
										<td class="alignC">미밍</td>
										<td class="alignC">사용(%)</td>
										<td class="alignC">0</td>
									</tr>



								</tbody>
							</table>
						</div>

					</div>

					<div class="sortArea">
						<div class="paging mt20" id="paging">
							<span class="paginator"><a class="on" href="javascript:goPageNo(1)" title="1" alt="1">1</a></span>
						</div>
					</div>

				</section>
			</div>
		</form>
	</div>
</body>
</html>
