<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<title>회원조회</title>
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
	max-width: 1000px;
}

.view_btn {
	cursor: pointer;
}

.column span {
	font-weight: 300;
	color: #e6f9ff;
}

td.del_btn a:hover {
	color: #80dfff;
}

td.del_btn a {
	color: #007399;
}
</style>

</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<h2 class="ui teal image header">SysCuss 회원 리스트</h2>
			<div class="ui large form">
				<div class="ui stacked segment">
					<table class="ui celled table">
						<thead>
							<tr>
								<th>NO</th>
								<th>이름</th>
								<th>비밀번호</th>
								<th>가입날짜</th>
								<th>회원삭제</th>

							</tr>
						</thead>
						<tbody id="list">
							<c:forEach items="${memberList}" var="member">
								<tr>
									<td>${member.u_no}</td>
									<td>${member.u_id}</td>
									<td>${member.u_pw}</td>
									<%-- <td>${member.u_date}</td> --%>
									
									<td>
									<fmt:formatDate value="${member.u_date}" pattern="yyyy-MM-dd"/>
									</td>
									
									
									<td class="del_btn"><a href="mDelete?u_no=${member.u_no}">삭제 </a></td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
					<a href="/"><button class="ui fluid large teal submit button">홈으로</button></a>
					<!-- 
					<div class="ui message">
						홈으로 <a href="/">여기</a>를 눌러주세요.
					</div>
					 -->
				</div>
				<div class="ui error message"></div>
			</div>
		</div>
	</div>



</body>
</html>
