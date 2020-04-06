<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록 리스트</title>

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
					<h2 class="ui teal image header btitle">
						상품<span>목록 페이지 </span>
					</h2>
					<form role="form" method="post" autocomplete="off">

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
									<c:forEach items="${g_list}" var="list">
										<tr>
											<td>${list.g_no}</td>
											<td>${list.g_name}</td>
											

											<td class="del_btn"><a href="/user/goods/view?g_no=${list.g_no}">${list.g_content}</a></td>
											<td>${list.g_amount}</td>

											<td class="g_price_list"><fmt:formatNumber value="${list.g_price}"
													pattern="###,###,###" /></td>
											<td><fmt:formatDate value="${list.g_date}" pattern="yyyy-MM-dd" /></td>
											<td class="del_btn delete_btn"><a href="/user/goods/modify?g_no=${list.g_no}">수정</a>
											</td>
											<td class="del_btn delete_btn"><a href="/user/goods_list/gDelete?g_no=${list.g_no}">삭제
											</a></td>

										</tr>
									</c:forEach>
								</thead>
							</table>
						
						</div>
						
					</form>
					
					<div class="ui error message"></div>
					<div class="ui stacked segment">
					<c:forEach begin="1" end="${pageNum}" var="num">
						<span> <a href="/user/goods/listPage?num=${num}">${num}</a>
						</span>
					</c:forEach>
					</div>
				</div>
			</div>
			<a href="/"><button class="ui message fluid large teal submit button s_button">홈으로</button></a>
			<!-- 게시물 작성 -->
			<a href="/user/register"><button class="ui fluid large teal submit button message s_button">상품등록
					하기</button></a>
		</div>
	</div>


</body>
</html>