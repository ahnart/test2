<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록 리스트</title>
<style type="text/css">
a.thum_img img {
	max-width: 50px;
	max-height: 50px;
}
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/b_board_style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/main_style.css">
</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<div class="column">
				<div class="ui large form">

					<h2 class="ui teal image header btitle">
						상품<span>목록</span>
					</h2>


					<form role="form" method="post" autocomplete="off">

						<div class="ui stacked segment">
							<table class="ui celled table">
								<thead>
									<tr>
										<th>썸네일</th>
										<th>상품명</th>
										<th>상품소개</th>
										<th>상품가격</th>
										<th>수량</th>
										<th>등록일짜</th>
										<c:if test="${member.level == 9}">
											<th>수정</th>
											<th>삭제</th>
										</c:if>
									</tr>
								</thead>
								<thead id="list">
									<c:forEach items="${list}" var="list">
										<tr>
											<%-- <td>${list.g_no}</td> --%>
											<td><img src="${list.g_thum}" class="g_thum" /></td>
											<td>${list.g_name}</td>
											<td class="del_btn"><a class="thum_img" href="/user/goods/view?g_no=${list.g_no}">${list.g_content}</a></td>

											<td class="g_price_list"><fmt:formatNumber value="${list.g_price}" pattern="###,###,###" /></td>

											<!-- 재고유무 -->
											<c:if test="${list.g_amount !=0}">
												<td class="g_amount">${list.g_amount}</td>
											</c:if>
											<c:if test="${list.g_amount ==0}">
												<td class=" sold_out_thum">SOLD OUT</td>
											</c:if>

											<td><fmt:formatDate value="${list.g_date}" pattern="yyyy-MM-dd" /></td>

											<c:if test="${member.level == 9}">
												<td class="del_btn delete_btn"><a href="/user/goods/modify?g_no=${list.g_no}">수정</a></td>
												<td class="del_btn delete_btn"><a href="/user/goods_list/gDelete?g_no=${list.g_no}">삭제 </a></td>
											</c:if>
										</tr>
									</c:forEach>
								</thead>
							</table>


							<c:forEach begin="1" end="${pageNum}" var="num">
								<span> <a class="del_btn" href="/user/goods_list?num=${num}">${num}</a>
								</span>
							</c:forEach>


						</div>
					</form>

					<div class="ui error message"></div>


				</div>
			</div>

			<c:if test="${member != null}">
				<a href="/user/goods/cart_list?num=1">
					<button class="cartlist_btn">장바구니</button>
				</a>
				<a href="/user/goods/orderList">
					<button class="cartlist_btn admin_btn">주문 현황</button>
				</a>
			</c:if>


			<c:if test="${member.level == 9}">
				<!-- 게시물 작성 -->
				<a href="/user/register"><button class="cartlist_btn admin_btn">상품 등록하기</button></a>
			</c:if>

			<a href="/"><button class="cartlist_btn ">홈으로</button></a>
			<!-- 게시물 작성 -->

		</div>
	</div>


</body>
</html>