<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/b_board_style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/main_style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/reset.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>

<title>주문 상세목록 페이지</title>
</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">

			<div class="column content">
				<div class="ui large form">
					<h2 class="ui teal image header btitle">
						주문 상세<span>목록</span>
					</h2>
					<table class="ui celled table" id="content">
						<thead>
							<tr>
								<th>주문자</th>
								<th>수령인</th>
								<th>주소</th>
							<!-- 	<th>가격</th> -->
								<th>배송현황</th>
							</tr>
						</thead>
						<thead id="orderInfo">
							<c:forEach items="${orderView}" var="orderView" varStatus="status">

								<c:if test="${status.first}">
									<tr>
										<td>${orderView.u_Id}</td>
										<td>${orderView.orderRec}</td>
										<td>${orderView.u_Addr1})${orderView.u_Addr2}${orderView.u_Addr3}</td>
										<%-- <c:set var="sum" value="${sum + (orderView.g_price * orderView.cartStock)}" />
										<td><fmt:formatNumber value="${sum}" pattern="###,###,###" /> 원</td> --%>
										<td>${orderView.delivery}</td>
									</tr>
									

								</c:if>
							</c:forEach>
						</thead>
						
					</table>


					<table class="ui celled table" id="content">
						<thead>
							<tr>
								<th>상품</th>
								<th>상품명</th>
								<th>개당 가격</th>
								<th>구입 수량</th>
								<th>최종 가격</th>
							</tr>
						</thead>
						<thead id="orderView">
							<c:forEach items="${orderView}" var="orderView">
								<tr>
									<td><img src="${orderView.g_thum}" class="g_thum" /></td>
									<td>${orderView.g_name}</td>
									<td><fmt:formatNumber pattern="###,###,###" value="${orderView.g_price}" /> 원</td>
									<td class="cartStock">${orderView.cartStock}</td>
									<td class="cartStock"><fmt:formatNumber pattern="###,###,###" value="${orderView.g_price * orderView.cartStock}" /> 원</td>
								</tr>
								<c:set var="sum" value="${sum + (orderView.g_price * orderView.cartStock)}" />
							</c:forEach>
						</thead>
					</table>
					<div class="listResult_admin">
						<div class="sum">
							총합계 : <b><fmt:formatNumber pattern="###,###,###" value="${sum}" />원</b>
						</div>
					</div>

					<div class="home_btn">
						<c:if test="${member != null}">
							<a href="/user/goods_list?num=1">
								<button class="cartlist_btn">쇼핑 계속하기</button>
							</a>
							<a href="/user/goods/orderList">
								<button class="cartlist_btn">주문목록</button>
							</a>
						</c:if>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>













