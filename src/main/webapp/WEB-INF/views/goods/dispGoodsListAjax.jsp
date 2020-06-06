<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<c:choose>
	<c:when test="${empty dispGoodsList}">
		<tr>
			<td colspan="12" class="alignC"><spring:message code='common.no.search.result' /></td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${dispGoodsList}" var="list" varStatus="status">
			<tr>
				<td class="alignC"><input type="checkbox" name="upperCheck" id="check_upper_${status.count}" value="${list.goodsDispSeq}" /></td>
				<td class="alignC">${list.goodsBizName}</td>
				<td class="alignC">${list.goodsSeq}</td>
				<td class="alignC">${list.goodsName}</td>
				<td class="alignC">${list.modelName}</td>
				<td class="alignC">${list.orderNo}</td>
				<td class="alignC">${list.dispGoodsStatusName}</td>
				<td class="alignC"><fmt:formatNumber value="${list.saleAmt+list.saleVat}" pattern="#,###" /></td>
				<td class="alignC"><fmt:formatNumber value="${list.realAmt+list.realVat}" pattern="#,###" /></td>
				<td class="alignC"><fmt:formatNumber value="${list.goodsDispAmt+list.goodsDispVat}" pattern="#,###" /></td>
				<td class="alignC">${list.mileageUseYn}</td>
				<td class="alignC">${list.layMileage}</td>
			</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>