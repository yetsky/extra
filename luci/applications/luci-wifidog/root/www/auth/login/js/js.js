/*
 * 全站公共脚本,基于jquery-1.9.1脚本库
 */
$(function() {
	// flash
	if ($(".flash").length) {
		$(".flash").addClass("swiper-container");
		$(".flash ul:first").addClass("swiper-wrapper").find("li").addClass(
				"swiper-slide");
		var auto_width = $(".flash").width();
		var auto_height = 360;
		var auto_num = $(".flash ul:first img").length;
		$(".flash").append("<div class='num'></div>")
		function flash() {
			// 获取图片高度
			if ($(".flash").parent().width() >= 640) {
				auto_width = 640;
				auto_height = 360;
			} else {
				auto_width = $(".flash").parent().width();
				auto_height = 360 * auto_width / 640;
			}
			$(".flash").width(auto_width).height(auto_height);
			$(".flash ul:first li").width(auto_width);
			$(".flash ul:first").width(auto_width * auto_num).height(
					auto_height);
		}
		flash();
		$(window).resize(function() {
			flash()
		});
		$('.flash').swiper({
			pagination : '.num',
			mode : 'horizontal',
			loop : true,
			autoplay : 5000
		})
	}
	// 表单验证
	$("#login").validate({
		onChange : true,
		eachValidField : function() {
			if ($(this).val().length == 11) {
				$(this).parent().removeClass("false").addClass("true");
				$(".password").html("获取密码");
				$(".password").addClass("ok");
			}
		},
		eachInvalidField : function() {
			if ($(this).val().length == 11) {
				$(this).parent().removeClass("true").addClass("false");
				$(".password").removeClass("ok");
				if (!$(".password").hasClass("going")) {
					$(".password").html("获取密码");
				}
			}
		}
	});
	$
			.validateExtend({
				tel : {
					required : true,
					pattern : /(((13[0-9]{1})|(18[0-9]{1})|(15[0-9]{1}))+\d{8})$|(^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)/
				}
			});
	$("#tel").keyup(function() {
		$(this).parent().removeClass("false").removeClass("true");
		$(".password").removeClass("ok");
		if($("#tel").val().length==11){
			checkTelIsExist();
		}
	});
	var time = 99;
	$(".password").click(
			function() {
				if (!$(this).hasClass("going") && $(this).hasClass("ok")
						&& $("#tel").val() != "") {
					sendRandCode();
					$(this).addClass("going").html(time + "秒后重新获取");
					var autotime = setInterval(function() {
						time--;
						if (time == -1) {
							$(".password").removeClass("going").html("获取密码");
							time = 99;
							clearInterval(autotime);
						} else {
							$(".password").html(time + "秒后重新获取");
						}
					}, 1000)
				}
			})
	var submittime = 3;

	var truntime = parseInt($(".time").html());
	var truntimes = setInterval(function() {
		truntime--;
		if (truntime == -1) {
			clearInterval(truntimes);
			toShopHome();
			// alert("跳转");
		} else {
			$(".time").html(truntime);
		}
	}, 1000);

})