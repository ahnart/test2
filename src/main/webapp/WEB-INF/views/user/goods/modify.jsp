<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/main_style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/b_board_style.css">
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<title>상품리스트 수정</title>
</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">

			<h2 class="ui teal image header btitle">
				상품<span>리스트 수정</span>
			</h2>

			<form role="form" class="ui large form" method="post" autocomplete="off"
				enctype="multipart/form-data">

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
							<label for="g_name">상품명</label> <input type="text" id="g_name" name="g_name"
								value="${view.g_name}" required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_price">상품가격</label> <input type="text" id="g_price" name="g_price"
								value="${view.g_price}" required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_amount">수량</label> <input type="text" id=g_amount name="g_amount"
								value="${view.g_amount}" required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_content">상품소개</label> <textarea class="b_con"  id="g_content"
								name="g_content" required="required">${view.g_content}</textarea>
								<script type="text/javascript">
								var ckeditor_config = {
									resize_enaleb : false,
									enterMode : CKEDITOR.ENTER_BR,
									shiftEnterMode : CKEDITOR.ENTER_P,
									filebrowserUploadUrl : "/user/goods/ckUpload"
								};
								CKEDITOR.replace("g_content", ckeditor_config);
							</script>
						</div>
						
					</div>
					<div class="field">
						<div class="ui left icon input">
							
							<label for="g_img">이미지</label>
							<input type="file" id="g_img" name="file" />
							<div class="select_img">
								 <img class="g_img" src="${view.g_img}" />
								
							<input class="g_img" type="hidden" id="g_img" name="g_img" value="${view.g_img}" /> 
							<input class="b_con" type="hidden" id="g_thum" name="g_thum" value="${view.g_thum}" />
							
							</div>
						</div>

						<script type="text/javascript">
							$("#g_img").change(function() {
												if (this.files && this.files[0]) {
													var reader = new FileReader;
													reader.onload = function(data) {
														$(".select_img img").attr(
																		"src", data.target.result).width(500);
													}reader.readAsDataURL(this.files[0]);
												}
											});
						</script>
					<%-- 	<%=request.getRealPath("/")%> --%>
					</div>
					<button class="ui fluid large teal submit button" id="update_Btn" type="submit">완료</button>
					<button class="ui fluid large teal submit button" id="register_Btn back_btn" type="submit">취소</button>



				</div>
			</form>

			<a href="/user/goods_list?num=1"><button class="ui message ui fluid large teal submit button">상품
					리스트 보기</button></a>
		</div>
	</div>
</body>
</html>