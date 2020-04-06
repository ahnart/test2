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
						주문 상세<span> 목록 관리</span>
					</h2>

					<table class="ui celled table" id="content">
					<c:forEach items="${aorderView}" var="orderView" varStatus="status">
							<c:if test="${status.first}">
						<thead>
							<tr>
								<th>주문자</th>
								<th>수령인</th>
								<th>주소</th>
								<th>가격</th>
								<th>상태</th>
							</tr>
						</thead>
						
						<thead id="orderInfo">
							<tr>
								<td>${orderView.u_Id}</td>
								<td>${orderView.orderRec}</td>
								<td>${orderView.u_Addr1})${orderView.u_Addr2} ${orderView.u_Addr3}</td>
								<td><fmt:formatNumber value="${orderView.g_price}" pattern="###,###,###" /> 원</td>
								<td class="pro_state">${orderView.delivery}</td>
							</tr>
						</thead>
					
							<div class="deliveryChange">
								<form role="form" method="post" class="deliveryForm">
									<input type="hidden" name="orderId" value="${orderView.orderId}" /> 
									<input type="hidden" name="delivery" class="delivery" value="" />
									<button type="button" class="delivery_btn1 deli_btn">배송중</button>
									<button type="button" class="delivery_btn2 deli_btn">배송완료</button>
									<script type="text/javascript">
										$(".delivery_btn1").click(function() {
											$(".delivery").val("Ready");
											run();
										});
										$(".delivery_btn2").click(function() {
											$(".delivery").val("completed");
											run();
										});
										function run() {
											$(".deliveryForm").submit();
										}
									</script>
								</form>
							</div>
						</c:if>
					</c:forEach>
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
							<c:forEach items="${aorderView}" var="orderView">
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
							<a href="/user/admin">
								<button class="cartlist_btn">관리자 페이지</button>
							</a>
							<a href="/user/admin/orderList">
								<button class="cartlist_btn">뒤로</button>
							</a>
						</c:if>
					</div>


				</div>
			</div>

		</div>
	</div>
</body>
</html>













