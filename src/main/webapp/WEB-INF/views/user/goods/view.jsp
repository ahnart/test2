<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/main_style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/b_board_style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/reset.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<meta charset="UTF-8">

<style type="text/css">
.ui.form .field .ui.input input.g_amount {
	width: 100px;
}

</style>
<!-- 댓글 리스트 스크립트 -->
<script> 

function replyList() {
	
	 var g_no = ${view.g_no};
	 $.getJSON("/user/goods/view/replyList" + "?n=" + g_no, function(data){
	  var str = "";
	  
	  $(data).each(function(){
	   
	   console.log(data);
	   
	   var reDate = new Date(this.reDate);
	   reDate = reDate.toLocaleDateString("ko-US")
	   
	   str += "<li data-g_no='" + this.g_no + "'>"
	     + "<div class='userInfo'>"
	     + "<span class='u_id'>" + this.u_Id + "  </span>"
	     + "<span class='date'>" + reDate + "</span>"
	     + "</div>"
	     + "<div class='replyContent'>" + this.reCon + "</div>"
	     + "<c:if test='${member !=null }'>"
	     + "<div class='replyFooter'>"
	     + "<button type='button' class='modify' data-reNum ='" + this.reNum + "'>수정</button>"
	     + "<button type='button' class='delete' data-reNum ='" + this.reNum + "'>삭제</button>"
	     + "</div>"
	     + "</c:if>"
	     + "</li>";
	  });
	  
	  $("section.replyList").html(str);
	 });
	}
</script>
						 						 	
<title>상품 상세페이지</title>
</head>
<body>
	
	<!-- 댓글 수정 모달 -->
	<div class="replyModal">
		<div class="modalContent">
			<textarea class="modal_reCon" name="modal_reCon" rows="" cols=""></textarea>
			<div class="button">
				<button type="button" class="modal_modify_btn">수정</button>
				<button type="button" class="modal_cancel">취소</button>
			</div>
		</div>
		<div class="modalBackground"></div>
	</div>
	<script type="text/javascript">
		$(".modal_cancel").click(function () {
		$(".replyModal").fadeOut(200);
		});
	</script>
	
	
	<div class="ui middle aligned center aligned grid">
	
		<div class="column">
				
			<h2 class="ui teal image header btitle">
				상품<span>상세보기</span>
			</h2>

			<form class="ui large form" method="post">
				<div class="ui stacked segment">
					<div class="field">
						<div class="ui left icon input">
							<label for="u_id">아이디</label>
							<p class="u_id">${member.u_id}</p>
						</div>
					</div>


					<div class="field">
						<div class="ui left icon input">
							<label for="b_cart">상품분류</label> <select>
								<option value="">전체</option>
								<option value="">상의</option>
								<option value="">하의</option>
								<option value="">신발</option>
							</select>
						</div>
					</div>



					<div class="field">
						<div class="ui left icon input">
							<label>상품명</label>
							<p class="u_id">${view.g_name}</p>
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label>상품가격</label>
							<p class="u_id">${view.g_price}</p>
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label>재고</label>
							<p class="u_id">${view.g_amount} 개</p>
						</div>
					</div>
					
					<c:if test="${view.g_amount !=0 }">
					<div class="field cartStock">
						<div class="ui left icon input">
							<label>수량</label> <input class="numBox" type="number" min="1" max="${view.g_amount}" value="1" />
						</div>
					</div>
					
					<div class="field">
						<div class="ui left icon input addCart">
							<button class="ui message teal submit button addCart_btn" type="button">카트에 담기</button>
							<!-- 카트담기 -->
							 <script>
							  $(".addCart_btn").click(function(){
							   var g_no = $("#g_no").val();
							   var cartStock = $(".numBox").val();
							      
							   var data = {
							     g_no : g_no,
							     cartStock : cartStock
							     };
							   
							   $.ajax({
							    url : "/user/goods/view/addCart",
							    type : "post",
							    data : data,
							    success : function(result){
							    	
										    if(result == 1){
										    	alert("카트 담기 성공");
											    $(".numBox").val("1");
										    }else{
										    	alert("회원만 사용할 수 있습니다.")
										    	$(".numBox").val("1");
										  		 }
											},
							    error : function(){
							     alert("카트 담기 실패");
							    }
							   });
							  });
							 </script>
							 
						</div>
					</div>
					</c:if>
					<c:if test="${view.g_amount ==0}">
						<p class=" sold_out">SOLD OUT !!</p>
					</c:if>
					
					<div class="field">
						<div class="ui left icon input">
							<label>상품소개</label>
							<p class="u_id text_content g_img">${view.g_content}</p>
						</div>
					</div>
					
					
					
					<div class="field">
						<div class="ui left icon input">
							<label></label>
							<p class="u_id ">
								<img src="${view.g_img}" class="g_img" />
							</p>
							<p class="u_id ">
								<img src="${view.g_thum}" class="g_thum" />
							</p>
						</div>
					</div>

					

				</div>
			</form>

			<div class="ui stacked segment">
				<div id="reply">

					<c:if test="${member == null}">
						<div class="ui message">
							소감을 남기려면 <a href="/">로그인</a>해주세요
						</div>
					</c:if>
					
					<c:if test="${member != null}">
						<section class="replyForm">
							<form class="form f_reply" role="form" method="post" autocomplete="off">
								<input type="hidden" name="g_no" id="g_no" value="${view.g_no}">
								
								<div class="input_area">
									<h2 class="ui teal image header btitle">
										상품<span>사용후기</span>
									</h2>
									
									<textarea rows="3" cols="" name="reCon" id="reCon" placeholder="소감을 남겨주세요."></textarea>
								</div>
								<div class="input_area">
									<button class="ui message teal submit button" type="button" id="reply_btn">소감 남기기</button>
									
									<script>
									$("#reply_btn").click(function(){
										
										var formObj = $(".replyForm form[role='form']");
										var g_no = $("#g_no").val();
										var reCon = $("#reCon").val();
										
										// ReplyVO 형태로 데이터 생성
										var data = {
												g_no : g_no,
												reCon : reCon
												};
										
										$.ajax({
											url : "/user/goods/view/registReply",
											type : "post",
											data : data,
											success : function(){
												replyList();  // 리스트 새로고침
												$("#reCon").val("");  // 텍스트에어리어를 초기화
											}
										});
									});
								</script>
								</div>
							</form>

						</section>
						
						
						<section class="replyList">
						
							
								<c:forEach items="${reply}" var="reply">
									<%-- <li>
										<div class="userInfo">
											    <span class="u_id">${reply.u_id}</span>
											<span class="date"> <fmt:formatDate value="${reply.reDate}" pattern="yyyy-MM-dd" /></span>    
										</div>
										<div class="replyContent">${reply.reCon}</div>
									</li> --%>
       					     </c:forEach>
							
							<script type="text/javascript">
								replyList();
							</script>
							
							
							
							<!-- 모달  댓글 수정  -->
							<script type="text/javascript">
									$(document).on("click", ".modify", function () {
										$(".replyModal").fadeIn(200);
										
									var reNum = $(this).attr("data-reNum");
									var reCon = $(this).parent().parent().children(".replyContent").text();
									
									$(".modal_reCon").val(reCon);
									$(".modal_modify_btn").attr("data-reNum", reNum);
									});
							</script>
							
							<!-- 댓글 수정  -->
							<script type="text/javascript">
								$(".modal_modify_btn").click(function() {
									var modifyConfirm = confirm("정말로 수정하시겠습니까?");
									
									if (modifyConfirm) {
										var data = {
												reNum : $(this).attr("data-reNum"),
												reCon : $(".modal_reCon").val()
										}; //replyDTO 형태로 data 생성
										
									$.ajax({
										url : "/user/goods/view/modifyReply",
										type : "post",
										data : data,
										success : function(result) {
											
											//result 값에 따라 동작
											if (result ==1) {
												replyList();  //list 새로 고침
												$(".replyModal").fadeOut(200);
											}else {
												alert("작성자 본인만 열 수 있습니다.") 
											}
										},
										error : function() {
											alert("로그인 하셔야 합니다.")
										}
									});
									}
								});
							</script>
							
							
							<!-- 댓글 삭제  -->
							<script type="text/javascript">
								$(document).on("click", ".delete", function () {
									var deleteConfirm = confirm("정말로 삭제 하시겠습니까?");
										if(deleteConfirm){
											
											var data = {reNum : $(this).attr("data-reNum")};
											$.ajax({
												url : "/user/goods/view/deleteReply",
												type : "post",
												data : data,
												success : function(result) {
													if (result == 1) {
														replyList();
													}else {
														alert("작성자만 삭제 할 수 있습니다.")
													}
												},
												error : function(){
													// 로그인하지 않아서 에러가 발생한 경우
													alert("로그인하셔야합니다.")
												}
											});
										}
								});
							
							</script>
							
						</section>
					</c:if>
				</div>
			</div>
			
			<a href="/user/goods_list?num=1">
				<button class="cartlist_btn ">상품  보기</button>
			</a>
			<c:if test="${member.level == 9}">
				<a href="/user/goods/modify?g_no=${view.g_no}">
					<button class="cartlist_btn admin_btn">게시물 수정</button>
				</a>
			</c:if>
			
		</div>
	</div>
</body>
</html>