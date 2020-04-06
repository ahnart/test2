<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script type="text/javascript" src="resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="resources/js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="resources/js/validate/additional-methods.js"></script>
<script type="text/javascript" src="resources/js/validate/messages_ko.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>

<script type="text/javascript">
	$(function() {
		$("#memberup").validate();
	});
	
	function signup() {
		if($("#memberup").valid()){
			alert(11);
		}
	}
</script>

<link rel="stylesheet" type="text/css" href="resources/main_style.css">

<style type="text/css">
body {
	background-color: #0086b3;
}

body>.grid {
	height: 100%;
}

.image {
	margin-top: -100px;
}

.column {
	max-width: 450px;
}

.column span {
	font-weight: 300;
	color: #e6f9ff;
}

.ui .column p {
	background-image: url(resources/syscuss_logo.png);
	width: 240px;
	height: 90px;
	background-size: cover;
	z-index: 1000;
	margin-left: 80px;
	display: block;
}

label.error{
	color: red;
	font-style: italic;
	font-size: 7px;
}
input.error{
	border: 1px dotted red !important;
	}
</style>
</head>

<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<p></p>

			<h2 class="ui teal image header">
				회원가입<span>페이지</span>
			</h2>
			
			<div class="ui large form">
				<form id="memberup" role="form" class="ui stacked segment" method="post" autocomplete="off">
					<div class="field">
						<div class="ui left icon input">
							<input type="text" id="u_id" name="u_id" placeholder="아이디" autofocus autocomplete="off" required>
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<input type="password" id="u_pw" name="u_pw" placeholder="비밀번호" required>
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<input equalTo="#u_pw" data-msg-equalTo="비밀번호가 일치하지않습니다." title="비밀번호를 입력하세요" type="password" id="u_pw2" name="u_pw2" placeholder="비밀번호 확인" required>
						</div>
					</div>
					
					<button class="ui fluid large teal submit button" id="submit" type="submit">회원가입</button>
				</form>
				
				<div class="ui error message"></div>

			</div>

			<div class="ui message">
				로그인 할 계정이 있다면 <a href="/">여기</a>를 눌러주세요.
			</div>
		</div>
	</div>
</body>
</html>