$(document).ready(function() {
		$(".noti").hide();
		//loginSubMenu class on start
		$("#nav > ul > li > a").each(function() {
			$(this).removeClass('on');
			if ('loginMenu01' == $(this).attr('id')) {
				$(this).addClass('on');
			}
		});
	});

	function fnLogin(event) {
		if (typeof ($("#user_id").val()) == 'undefined'
				|| $.trim($("#user_id").val()) == '') {
			$(".noti").show();
			$(".noti").html("ID와 비밀번호를 입력해주세요.");
			return false;
		}

		if (typeof ($("#user_password").val()) == 'undefined'
				|| $.trim($("#user_password").val()) == '') {
			$(".noti").show();
			$(".noti").html("ID와 비밀번호를 입력해주세요.");
			return false;
		}

		//var param = $("#loginForm").serialize();
		var param = "user_id=" + encParam($.trim($("#user_id").val()));
		param += "&user_password="
				+ encParam($.trim($("#user_password").val()));

		// login
		$.ajax({
			type : "POST",
			async : false, // default : false
			dataType : 'jsonp', // type : json, script , xml ...
			data : param,
			url : "/login/loginCheck.do",
			jsonp : "callback",
			timeout : 10000,
			success : function(data) {
				if (data.errorCode == "0000") {
					$("#loginForm").attr("action", "/login/login.do");
					$("#loginForm").attr("method", "post");
					$("#loginForm").submit();
				} else {
					$(".noti").show();
					$(".noti").html("로그인에 실패했습니다. ID 또는 비밀번호를 확인하시기 바랍니다.");
					return false;
					history.go(0);
				}
			},
			error : function(xhr, ajaxOptions, thrownError) {
				$(".noti").show();
				$(".noti").html("시스템 오류가 발생하였습니다.");
				return false;
			}
		});
	}