<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/b_board_style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/main_style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/reset.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>

<title>주문 목록 페이지</title>
</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">

			<div class="column content">
				<div class="ui large form">
					<h2 class="ui teal image header btitle">
						 전체 주문 <span> 목록 관리</span>
					</h2>
					<table class="ui celled table" id="content">
						<thead>
							<tr>
								<th>주문번호</th>
								<th>주문자</th>
								<th>수령인</th>
								<th>주소</th>
								<th>가격</th>
								<th>상태</th>
							</tr>
						</thead>
						<thead id="orderList">
							<c:forEach items="${aorderList}" var="orderList">
								<tr>
									<td class="goods_code"><a href="/user/admin/orderView?n=${orderList.orderId}">${orderList.orderId}</a></td>
									<td>${orderList.u_Id}</td>
									<td>${orderList.orderRec}</td>
									<td>${orderList.u_Addr1}) ${orderList.u_Addr2} ${orderList.u_Addr3}</td>
									<td class="goods_price"><fmt:formatNumber value="${orderList.amount}" pattern="###,###,###" /> 원</td>
									<td class="pro_state">${orderList.delivery}</td>
								</tr>
							</c:forEach>
						</thead>
					</table>


					<c:if test="${member != null}">
						<a href="/user/admin">
							<button class="cartlist_btn">관리자 페이지</button>
						</a>
						
					</c:if>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>