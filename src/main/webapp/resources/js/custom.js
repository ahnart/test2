$(document).ready(function () {
	
//	//패밀리사이트
//	 var ht = $(window).height();
//	    $("section, ul.slide").height(ht);
//	    $(window).resize(function () {
//	        var ht = $(window).height();
//	        $("section, ul.slide").height(ht);
//	    });
//	    //배경화면 사이즈 조정 끝
//	    
//	    
	    
	    // 패밀리사이트 스크롤
	    $("ul.buy_info").click(function () {
//	        e.preventDefault();
	        $(this).toggleClass("on");
	        
	        $("ul.buy_info>li>ul.buy_sub").slideToggle();
	        $("ul.buy_info>li>a>i").toggleClass("fa fa-caret-down").toggleClass("fa fa-caret-up")
	    });
	    
	    
	    //hover 시 사라짐
	    $("ul.buy_info").hover(function(){
//	        $(this).addClass("on");
	    },function(){
	        
	        $(this).removeClass("on");
	        $("ul.buy_sub").hide();
	        $("ul.buy_info>li>a>i").toggleClass("fa fa-caret-down").toggleClass("fa fa-caret-up")
	    });
	    ////패밀리사이트 끝
	
	
	    
	    
	
	
    var timer = setInterval(function () {
        //변수에 시간 데이터 저장
        var now = new Date();
        var hr = now.getHours();
        var min = now.getMinutes();
        var sec = now.getSeconds();
        var hNum, mNum, sNum;

        //시간이 한자리 숫자일때 앞에 0붙이기
        if (hr >= 10) {
            hNum = hr;
        } else {
            hNum = "0" + hr;
        }
        //분이 한자리 숫자일때 앞에 0붙이기
        if (min >= 10) {
            mNum = min;
        } else {
            mNum = "0" + min;
        }
        //초가 한자리 숫자일때 앞에 0붙이기
        if (sec >= 10) {
            sNum = sec;custom.js
        } else {
            sNum = "0" + sec;
        }

        /*시간 출력*/
        $("figure p span").eq(0).text(hNum);
        $("figure p span").eq(1).text(mNum);
        $("figure p span").eq(2).text(sNum);
        
    }, 1000);
    

}); //ready end