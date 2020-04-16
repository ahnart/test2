<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/resources/images/favicon.ico">
<link rel="stylesheet" href="/css/jquery-ui.css">
<title>매체사 찾기 | SISCUS</title>
<meta name="Description" content="Qool Solutions">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<!--[if lte IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lte IE 8]>
	<link rel="stylesheet" href="/css/ie.css" type="text/css" media="screen">
<![endif]-->
<script type="text/javascript" src="/js/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="/js/common/ui.js"></script>
<script type="text/javascript" src="/js/common/paging.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript"> 

var iCurrPage = "";
var iTotalCount = "";
var iPageRow = "";
var iPageBlock = "";

$(document).ready(function() {

	// paging start
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	if($("#pagecount").val() == ""){
		$("#pagecount").val("10");
	}
	iCurrPage = $("#page").val();
	iTotalCount = $("#pagetotal").val();
	iPageRow = $("#pagecount").val();
	iPageBlock = "10";
	
	$(".paging").html(pageNavigator(iCurrPage, iTotalCount, iPageRow, iPageBlock, "goPageNo", "on"));
	// paging end

});

function goPageNo(pageNo){
	$("#page").val(pageNo);
	$("#frm").attr("action", "/company/searchMediaList.do");
	$("#frm").submit();
}

function goSearch(){
	goPageNo(1);
}


function popClose() {
	window.close();
}

function gotoForm(sendMassId, sendMassName) {
	if(	sendMassId == '' || typeof(sendMassId) == 'undefined' ||
		sendMassName == '' || typeof(sendMassName) == 'undefined' 
	){
		alert("매체사를 선택하세요.");
		return;
	} 
	$("#send_mass_id"	, opener.frm).val(sendMassId);
	$("#send_mass_name"	, opener.frm).val(sendMassName);
	self.close();
}

</script>
</head>

<body>
<div id="popup">
<form name="frm" id="frm" method="post" >
<input type="hidden" id="page" 				name="page" 			value="" />
<input type="hidden" id="pagecount"  		name="pagecount"  		value="" />
<input type="hidden" id="pagetotal" 	 	name="pagetotal" 		value="1" />

	<div id="wrap">
		<header id="header" class="clearfix">
			<h1>매체사 찾기</h1>
		</header>
		<section id="section">
			<div class="search">
				<div class="searchRow">
					<p class="searchTt">기업명 : </p>
					<input type="text" name="search_keyword" id="search_keyword" value="" />
					<a class="btnType02" onclick="javascipt:goSearch();">조회</a>
				</div>
			</div>
			
			<div id="content">
				
				<h2>매체사 선택</h2> <span class="topAdd">전체 : <strong>1</strong>개</span>
				<div class="comp">
					<table class="tbType01">
					<!-- 	<caption>기업목록</caption>	 -->
						<thead>
							<tr>
								<th>No</th>
								<th>매체사 ID</th>
								<th>기업명</th>
								<th>담당자</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
									
							<tr style="cursor: pointer;" onclick="javascript:gotoForm('comang', '꼬망세');" >
								<td class="alignC">1</td>
								<td class="alignC">comang</td>
								<td class="alignC">꼬망세</td>
								<td class="alignC">고미정</td>
								<td class="alignC"></td>
							</tr>
						
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="sortArea">
				<div class="paging mt20" id="paging"></div>
			</div>
			
		</section>
	</div>
</form>	
</div><!-- popup -->
</body>
</html>
