<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록하기</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/main_style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/b_board_style.css">
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
</head>
<body>

	<div class="ui middle aligned center aligned grid">
		<div class="column">

			<h2 class="ui teal image header btitle">
				상품<span>등록페이지</span>
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
							<label for="b_cart">1차 상품분류</label> 
							<select class="category1">
								<option value="">전체</option>
							</select> <label for="b_cart">2차 상품분류</label> 
							<select class="category2" name="cateCode">
								<option value="">전체</option>
							</select>
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_name">상품명</label> <input type="text" id="g_name" name="g_name"
								required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_price">상품가격</label> <input type="text" id="g_price" name="g_price"
								required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_amount">수량</label>
							
							 <input type="text" id="g_amount" name="g_amount"
								required="required" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<label for="g_content">상품소개</label>
							<textarea class="b_con" id="g_content" name="g_content" required="required"></textarea>
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
							<label for="g_img">이미지</label> <input type="file" id="g_img" name="file" />
							<div class="select_img">
								<img src="" />
							</div>
							<script>
								$("#g_img")
										.change(
												function() {
													if (this.files
															&& this.files[0]) {
														var reader = new FileReader;
														reader.onload = function(
																data) {
															$(".select_img img")
																	.attr(
																			"src",
																			data.target.result)
																	.width(500);
														}
														reader
																.readAsDataURL(this.files[0]);
													}
												});
							</script>


							<%-- <%=request.getRealPath("/")%> --%>
						</div>
					</div>
					<button class="ui fluid large teal submit button" id="register_Btn" type="submit">등록하기</button>
					<!-- 
					 <div class="ui fluid large teal submit button" id="register_Btn" >
						<a href="/user/goods_list" type="submit">등록하기</a>
					</div>
					 -->
				</div>
			</form>


			<a href="/user/goods_list?num=1"><button class="ui message ui fluid large teal submit button">상품
					리스트 보기</button></a>

		</div>
	</div>


	<script>
		var regExp = /[^0-9]/gi;

		$("#g_price").keyup(function() {
			numCheck($(this));
		});

		function numCheck(selector) {
			var tempVal = selector.val();
			selector.val(tempVal.replace(regExp, ""));
		}
	</script>
	
	<script>
	
	////////////// category 1 //////////////////
		// 컨트롤러에서 데이터 받기
		var jsonData = JSON.parse('${category}');
		console.log(jsonData);
		
		var cate1Arr = new Array();
		var cate1Obj = new Object();

		// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
		for (var i = 0; i < jsonData.length; i++) {

			if (jsonData[i].level == "1") {
				cate1Obj = new Object(); //초기화
				cate1Obj.cateCode = jsonData[i].cateCode;
				cate1Obj.cateName = jsonData[i].cateName;
				cate1Arr.push(cate1Obj);
			}
		}

		// 1차 분류 셀렉트 박스에 데이터 삽입
		var cate1Select = $("select.category1")

		for (var i = 0; i < cate1Arr.length; i++) {
			cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
					+ cate1Arr[i].cateName + "</option>");
		}
		
		
		////////////// category 2 ///////////////////
		
		// 클래스가 category1인 select변수의 값이 바뀌었을 때 실행
		$(document).on("change", "select.category1", function(){

			
			// 필요한 배열과 오브젝트 변수를 생성
			var cate2Arr = new Array();
			var cate2Obj = new Object();
			
			// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
			for(var i = 0; i < jsonData.length; i++) {
				
				if(jsonData[i].level == "2") {  // 레빌이 2인 데이터가 있다면
					cate2Obj = new Object();  // 초기화
					
					// cate2Obj에 cateCode, cateName, cateCodeRef를 저장
					cate2Obj.cateCode = jsonData[i].cateCode;
					cate2Obj.cateName = jsonData[i].cateName;
					cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
					
					// cate2Obj에 저장된 값을 cate1Arr 배열에 저장
					cate2Arr.push(cate2Obj);
				} 
			}
			
			var cate2Select = $("select.category2");
			
			/* 
			for(var i = 0; i < cate2Arr.length; i++) {
				cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
									+ cate2Arr[i].cateName + "</option>");
		}
			 */
			 
			cate2Select.children().remove();

			 $("option:selected", this).each(function(){
			  
			  var selectVal = $(this).val();  
			  cate2Select.append("<option value=''>전체</option>");
			  
			  for(var i = 0; i < cate2Arr.length; i++) {
			   if(selectVal == cate2Arr[i].cateCodeRef) {
			    cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
			         + cate2Arr[i].cateName + "</option>");
			   }
			  }
			  
			 });
			 
			});
		
	</script>
 













</body>
</html>