<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/reset.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>

</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<div class="column content">
				<div class="ui large form">
					<h2 class="ui teal image header btitle">
						장바구니<span>목록</span>
					</h2>
					
					<ul class="delCeck">
							<li>
								<div class="allCheck">
									<input type="checkbox" name="allCheck" id="allCheck">
									<label for="allCheck">모두선택</label>
									
									<script type="text/javascript">
										$("#allCheck").click(function() {
											var chk = $("#allCheck").prop("checked");
											if (chk) {
												$(".chBox").prop("checked", true);
											}else {
												$(".chBox").prop("checked", false);
											}
										});
									</script>
									
								</div>	<!-- 모두선택 -->
								
								
								
								<div class="delBtn">
									<button type="button" class="selectDelete_btn">선택 삭제</button>
									
									<script>
									$(".selectDelete_btn").click(function(){
										var confirm_val = confirm("정말 삭제하시겠습니까?");
											
										if(confirm_val) {
											var chArr = new Array();
												
												$("input[class='chBox']:checked").each(function(){
													chArr.push($(this).attr("data-cartNum"));
												});
												
												$.ajax({
													 url : "/user/goods/cart_list/deleteCart",
													 type : "post",
													 data : { chbox : checkArr },
													 success : function(result){
													  if(result == 1) {          
													   location.href = "/user/goods/cart_list";
													  } else {
													   alert("삭제 실패");
													  }
													}
												});
											}
										});
									</script>
								</div>	<!-- 선택 삭제 -->
								
							</li>
							<c:set var="sum" value="0" />
						</ul>
						
						
						
					<form role="form" method="post" autocomplete="off">
						
						<div class="ui stacked segment">
							<table class="ui celled table">
								<thead>
									<tr>
										<th>선책</th>
										<th>상품이미지</th>
										<th>상품명</th>
										<th>상품가격</th>
										<th>구입수량</th>
										<th>최종가격</th>
										<th>삭제</th>
									</tr>
								</thead>
								<thead id="cartList">
									<c:forEach items="${cartList}" var="cartList">
										<tr>
											<td class="checkBox"><input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum }" />
												<script type="text/javascript">
													$(".chBox").click(function() {
														$("#allCheck").prop("checked", false);
													});
												</script>
											</td>
											<td class="thum">
												<img src="${cartList.g_thum}" class="g_thum" />
											</td>
											<td>${cartList.g_name}</td>
											<td class="g_price"><fmt:formatNumber value="${cartList.g_price}"
													pattern="###,###,###" /></td>
											<td class="cartStock">${cartList.cartStock}</td>		
											<td class="cartStock"><fmt:formatNumber value="${cartList.g_price * cartList.cartStock}"
													pattern="###,###,###" /></td>
												
											
											<td class="del_btn delete">
											
											<button type="button" class="delete_${cartList.cartNum}_btn" data-cartNum ="${cartList.cartNum}" >삭제</button>
											<script type="text/javascript">
												$(".delete_${cartList.cartNum}_btn").click(function() {
													var confirm_val = confirm("정말 삭제하시겠습니까?");
													
													if (confirm_val) {
														var chArr = new Array();
														
														chArr.push($(this).attr("data-cartNum"));
														
														$.ajax({
															url : "/user/goods/cart_list/deleteCart",
															type : "post",
															data : { chbax : chArr },
															success : function (result) {
																if (result == 1) {
																	location.href = "/user/goods/cart_list";
																}else {
																	alert("삭제 실패");
																}
															}
														});
													}
												});
											</script>
											
											</td>
										</tr>
										<c:set var = "sum" value="${sum + (cartList.g_price * cartList.cartStock)}" />
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
						
				
			
			<!-- 총합계  주문정보 버튼 -->
			<div class="listResult">
				<div class="sum">
					총합계 : <b><fmt:formatNumber pattern="###,###,###" value="${sum}" />원</b>
				</div>
				<div class="orderOpen">
					<button type="button" class="orderOpen_btn">주문 정보 입력</button>
					
					<script type="text/javascript">
						$(".orderOpen_btn").click(function(e) {
							e.preventDefault();
							$(".orderInfo").slideDown();
							$(".orderOpen_btn").slideUp();
						});
					</script>
				</div>
			</div>
			
			
			<div class="orderInfo">
				<h2 class="ui teal image header btitle orderTitle">
						상품 <span>구매정보</span></h2>
						
				<form role="form" method="post" autocomplete="off">
					<input type="hidden" name="amount" value="${sum}" />
					
					<div class="inputArea">
						<label for="">수령인</label>
						<input class="order_input"  type="text" name="orderRec" id="orderRec" required="required" />
					</div>
					<div class="inputArea">
						<label for="">수령인 연락처</label>
						<input class="order_input" type="text" name="orderPhon" id="orderPhon" required="required" />
					</div>
					<div class="inputArea">
					<div class="addr_area1">
						<input type="text" id="sample2_postcode" placeholder="우편번호">
						<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
					</div>
					<div class="addr_area2">
						<input type="text" name="u_Addr1" id="sample2_address" placeholder="주소">
						<input type="text" name="u_Addr2" id="sample2_detailAddress" placeholder="상세주소">
						<input type="text" name="u_Addr3" id="sample2_extraAddress" ><br>
					</div>
					<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
					<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
					
					<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    // 우편번호 찾기 화면을 넣을 element
					    var element_layer = document.getElementById('layer');
					
					    function closeDaumPostcode() {
					        // iframe을 넣은 element를 안보이게 한다.
					        element_layer.style.display = 'none';
					    }
					
					    function sample2_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var addr = ''; // 주소 변수
					                var extraAddr = ''; // 참고항목 변수
					
					                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					                    addr = data.roadAddress;
					                } else { // 사용자가 지번 주소를 선택했을 경우(J)
					                    addr = data.jibunAddress;
					                }
					
					                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					                if(data.userSelectedType === 'R'){
					                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                        extraAddr += data.bname;
					                    }
					                    // 건물명이 있고, 공동주택일 경우 추가한다.
					                    if(data.buildingName !== '' && data.apartment === 'Y'){
					                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                    }
					                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                    if(extraAddr !== ''){
					                        extraAddr = ' (' + extraAddr + ')';
					                    }
					                    // 조합된 참고항목을 해당 필드에 넣는다.
					                    document.getElementById("sample2_extraAddress").value = extraAddr;
					                
					                } else {
					                    document.getElementById("sample2_extraAddress").value = '';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('sample2_postcode').value = data.zonecode;
					                document.getElementById("sample2_address").value = addr;
					                // 커서를 상세주소 필드로 이동한다.
					                document.getElementById("sample2_detailAddress").focus();
					
					                // iframe을 넣은 element를 안보이게 한다.
					                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
					                element_layer.style.display = 'none';
					            },
					            width : '100%',
					            height : '100%',
					            maxSuggestItems : 5
					        }).embed(element_layer);
					
					        // iframe을 넣은 element를 보이게 한다.
					        element_layer.style.display = 'block';
					
					        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
					        initLayerPosition();
					    }
					
					    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
					    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
					    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
					    function initLayerPosition(){
					        var width = 300; //우편번호서비스가 들어갈 element의 width
					        var height = 400; //우편번호서비스가 들어갈 element의 height
					        var borderWidth = 5; //샘플에서 사용하는 border의 두께
					
					        // 위에서 선언한 값들을 실제 element에 넣는다.
					        element_layer.style.width = width + 'px';
					        element_layer.style.height = height + 'px';
					        element_layer.style.border = borderWidth + 'px solid';
					        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
					        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
					        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
					    }
					</script>
					</div>
					
					<!-- 
					<div class="inputArea">
						<label for="">우편번호</label>
						<input class="order_input" type="text" name="u_Addr1" id="u_Addr1" required="required" />
					</div>
					<div class="inputArea">
						<label for="">1차 주소</label>
						<input class="order_input" type="text" name="u_Addr2" id="u_Addr2" required="required" />
					</div>
					<div class="inputArea">
						<label for="">2차 주소</label>
						<input class="order_input" type="text" name="u_Addr3" id="u_Addr3" required="required" />
					</div>
					 -->
					<div class="orderBTN">
						<button type="submit" class="order_btn">주문</button>
						<button type="button" class="cancel_btn">취소</button>
						
						<script type="text/javascript">
							$(".cancel_btn").click(function() {
								$(".orderInfo").slideUp();
								$(".orderOpen_btn").slideDown();
							});
							
						</script>
					</div>
				</form>
			</div><!-- orderInfo -->
		</div>
	</div><!-- content -->
			<c:if test="${member.level == 9}">
			<!-- 게시물 작성 -->
			
			</c:if>
			<a href="/user/goods_list?num=1">
				<button class="cartlist_btn">쇼핑 계속하기</button>
			</a>
			<a href="/"><button class="cartlist_btn">홈으로</button></a>
			
		</div>
	</div>


</body>
</html>