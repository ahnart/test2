<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<style type="text/css">
a.thum_img img {
	max-width: 50px;
	max-height: 50px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/b_board_style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/main_style.css">

</head>
<body>

	<div class="ui middle aligned center aligned grid">
	
		<div class="column">
		
			<div class="column">
				<div class="ui large form">
				
					<h1 class="ui teal image header btitle">관리자 페이지</h1>
					<br>
					<h2 class="ui teal image header btitle">
						SysCuss<span>회원 리스트</span>
					</h2>


					<div class="ui large form">
						<div class="ui stacked segment">
							<form role="form" method="post" autocomplete="off">
								<table class="ui celled table">
									<thead>
										<tr>
											<th>NO</th>
											<th>이름</th>
											<th>비밀번호</th>
											<th>회원등급</th>
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
												<td>${member.level}</td>
												<%-- <td>${member.u_date}</td> --%>

												<td><fmt:formatDate value="${member.u_date}"
														pattern="yyyy-MM-dd" /></td>


												<td class="del_btn"><a
													href="mDelete?u_no=${member.u_no}">삭제 </a></td>

											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="cartlist_btn admin_btn">
								<a href="/user/admin/orderList" class="ui fluid large teal submit button  ">주문 현황 관리 </a>
								</div>
								<div class="cartlist_btn admin_btn">
								<a href="/user/admin/allReply" class="ui fluid large teal submit button  ">전체 상품 소감 </a>
								</div>
								<div class="cartlist_btn admin_btn">
								<a href="/" class="ui fluid large teal submit button  ">홈으로</a>
								</div>
							</form>
							
						</div>
						<div class="ui error message"></div>
					</div>
					<%-- <form role="form" method="post" autocomplete="off">

						<div class="ui stacked segment">
							<table class="ui celled table">
								<thead>
									<tr>
										<th>NO</th>
										<th>상품명</th>
										<th>상품소개</th>
										<th>상품가격</th>
										<th>수량</th>
										<th>등록일짜</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								<thead id="list">
									<c:forEach items="${list}" var="list">
										<tr>
											<td>${list.g_no}</td>
											<td>${list.g_name}</td>

											<td class="del_btn">
											<a class="thum_img" href="/user/goods/view?g_no=${list.g_no}">${list.g_content}</a>
											</td>

											<td class="g_price_list"><fmt:formatNumber value="${list.g_price}" pattern="###,###,###" /></td>
											<td><fmt:formatDate value="${list.g_date}" pattern="yyyy-MM-dd" /></td>
											<td>${list.g_amount}</td>

											<td class="del_btn delete_btn"><a href="/user/goods/modify?g_no=${list.g_no}">수정</a></td>
											<td class="del_btn delete_btn"><a href="/user/goods_list/gDelete?g_no=${list.g_no}">삭제 </a></td>

										</tr>
									</c:forEach>
								</thead>
							</table>


							<c:forEach begin="1" end="${pageNum}" var="num">
								<span> <a class="del_btn" href="/user/goods_list?num=${num}">${num}</a>
								</span>
							</c:forEach>


						</div>
					</form> --%>



				</div>
			</div>

			<!-- 게시물 작성 -->
			<a href="/user/register"><button
					class="ui fluid large teal submit button message s_button ">상품등록
					하기</button></a>
			<!-- 	<div class="ui message">
		회원 목록 보기 <a href="/list">여기</a>를 눌러주세요.
	</div> -->
		</div>
	</div>

</body>
</html>