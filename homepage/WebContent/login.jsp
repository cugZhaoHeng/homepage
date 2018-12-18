<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<link href="static/css/base.css" rel="stylesheet">
<link href="static/css/login/login.css" rel="stylesheet">
<link href="static/easyui/uimaker/easyui.css" rel="stylesheet">
<link href="static/easyui/uimaker/icon.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- 页面顶部布局 -->
	<div class="login-hd"></div>
	<!-- 页面中部布局 -->
	<div class="login-bd">
		<!-- bd-inner 将登录框置于屏幕右边 -->
		<div class="bd-inner">
			<div class="inner-wrap">
				<div class="lg-zone">
					<div class="lg-box">
						<div class="lg-label">用户登录</div>
						<!-- 带有error的为提示语，默认隐藏，在用户输入错误信息时显示 -->
						<div class="alert alert-error" id="error">
							<i class="iconfont">&#xe62e;</i>
							<span id="info"></span>
						</div>
						<!-- 创建登录表单 -->
						<form method="post">
							<!-- 用户名输入框 -->
							<div class="input-item clearfix">
								<i class="iconfont">&#xe60d;</i>
								<input type="text" name="username" id="username" placeholder="用户名"/>
							</div>
							<!-- 密码输入框 -->
							<div class="input-item clearfix">
								<i class="iconfont">&#xe634;</i>
								<input type="password" name="password" id="password" placeholder="密码"/>
							</div>
							<!-- 验证码，包含输入部分和显示部分 -->
							<div class="lg-check clearfix">
								<div class="input-item">
									<i class="iconfont">&#xe633;</i>
									<input type="text" name="captcha" id="captcha" placeholder="验证码" />
								</div>
								<span class="check-code">
									
								</span>
							</div>
							<div class="enter">
								<a class="supplier">登录</a>
								<a class="purchaser">注册</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 页面底部布局 -->
	<div class="login-ft"></div>
</body>
<script type="text/javascript">
	/* 页面加载  */
	$(document).ready(function() {
		// 将带有error的标签设置为隐藏
		$("#error").hide();
		$(".supplier").on('click', function(){
			login();
		})
	})
	
	/* 点击登录按钮触发事件  */
	function login() {
		var username = $("#username").val();
		var password = $("#password").val();
		if(username == "" || username == null) {
			$("#info").text("请输入用户名");
			$("#error").show();
		}
		else if(password == "" || password == null) {
			$("#info").text("请输入密码");
			
		}else {
			// 处理用户登录
		}
	}
	
	
	
	
</script>
</html>