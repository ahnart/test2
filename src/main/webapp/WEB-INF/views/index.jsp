<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="ja">

<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico">
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon" />
<title>로그인 EPOPKON</title>
<meta name="Description" content="COUPON">
<link rel="stylesheet" type="text/css" href="resources/css/common.css">
<link rel="stylesheet" type="text/css" href="resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="resources/css/b_board_style.css"> 
<!-- 
<link rel="stylesheet" type="text/css" href="resources/css/main_style.css"> -->

<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->

<script type="text/javascript" src="/js/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.i18n.properties-1.0.9-min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/common/ui.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/custom.js"></script>
<script type="text/javascript" src="/js/index.js"></script>

</head>
<body>
	<div id="wrap">
		<!-- header start -->
			<script type="text/javascript">
			// menu setting
			var gnbType = '';

			$(document).ready(function() {
				// gnb setting start
				$("#gnb > ul > li > a").each(function() {
					$(this).removeClass('on');
					if ("" == $(this).attr('class')) {
						$(this).addClass('on');
					}
				});
				// gnb setting end
			});
		</script>
		<header id="header" class="clearfix">
			<%@ include file="./include/header.jsp"%>
			<!-- 
			<div class="container">
				<a href="/"><h1>EPOPKON</h1></a>
				<div class="util">
					<ul class="clearfix">
						<li><a href="/login/loginForm.do">로그인</a></li>
					</ul>
				</div>
			</div>
			 -->
		</header>
		
		<!-- header end -->
		<div class="content_bg">
			<div class="epop_logo">EPOP</div>
			<div class="main_chr01 active">보라</div>
			<div class="main_chr02 active">깨동이</div>
		</div><!-- content_bg -->
		<section class="login">
			
			<c:if test="${member == null}">
				<form id="loginForm" name="loginForm" role="form" autocomplete="off" method="post" action="signin">
					<div>
						<div class="form">
							<strong>&middot; ID</strong><input type="text" id="u_id" name="u_id" placeholder="ID를 입력하세요." autocomplete="off" title="email" /> <strong>&middot; 비밀번호</strong><input type="password" id="u_pw"
								name="u_pw" placeholder="비밀번호를 입력해주세요." autocomplete="off" title="password" onkeyup="javascript:if( event.keyCode == 13) fnLogin(event);" />

							<!-- <button class="btnType02 double" onclick="fnLogin(event); return false;">로그인</button> -->
							<a href="/main/main">
								<button class="btnType02 double">로그인</button>
							</a>
							<!-- <div><input type="checkbox" id="save"><label for="save">ID 저장</label></div> -->
						</div>
						<p class="noti" style="display: none;"></p>
						<ul class="listType01">
							<li>&middot; 계정 작성/비밀 번호 초기화는 관리자에게 요청해 주세요.</li>
						</ul>
						<!-- <div class="findInfo">
						<a href="#">아이디 찾기</a><a href="#">비밀번호 찾기</a><a href="#">회원가입</a>
					</div> -->
					</div>
				</form>
			</c:if>

			<c:if test="${member != null}">
				<div class="log_in">
				<a href="/signup" class="index_btn"><button class="">회원가입</button></a>
				<a href="/user/user_main" class="index_btn"><button class=" "><em>e</em> POPKON</button></a>
				<c:if test="${member.level == 9}">
					<a href="/user/admin" class="index_btn"><button class=" ">관리자 페이지</button></a>
					<!-- <a href="/user/register" class="index_btn"><button class=" ">상품등록</button></a> -->
				</c:if>
					<a href="/user/goods_list?num=1" class="index_btn"><button class="">메인화면</button></a>
					<a href="/signout" class="index_btn"><button class=" ">로그아웃</button></a>
				</div>
			</c:if>

		</section>
		
		<!-- footer start -->

		

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
			<%@ include file="./include/footer.jsp"%>
		</footer>


		<!-- footer end -->

	</div>


</body>
</html>
