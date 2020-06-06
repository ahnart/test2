<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/b_board_style.css">
<title>Insert title here</title>
</head>
<body>
	<header id="header" class="clearfix">
	<div class="container">
		<a href="/"><h1>이팝콘</h1></a>
		
		<c:if test="${member == null and ADMIN_ID == null}">
			<form id="loginForm" name="loginForm" role="form" autocomplete="off" method="post" action="signin">
				<div>
					<div class="form">
						<div class="findInfo">
							<a href="/">로그인</a>
							<!-- <a href="#">비밀번호 찾기</a> -->
							<a href="/signup">회원가입</a>
							<!-- <input type="checkbox" id="save"><label for="save">ID 저장</label> -->
						</div>
					</div>
				</div>
			</form>
		</c:if>
		
		<c:if test="${member != null or ADMIN_ID != null}">
		<section>
			<p class="loginon">
			
				<span class="user_name">
				${ !empty member ? member.u_id : ADMIN_ID }
				<!-- member 란 객체가 널이아니라면(참) member.u_id   널이라면(false) ADMIN_ID 를 출력 -->
				
				<%-- ${member.u_id or ADMIN_ID} --%>
				</span> 님환영합니다!
				<a href="/signout" class="index_btn"><button class=" ">로그아웃</button></a>
			</p>
		</section>
		</c:if>
		
	</div>
	<!-- container -->
	</header>
	
</body>
</html>

