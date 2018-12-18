<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>修改密码</title>

<link href="static/css/login/login.css" rel="stylesheet">
<link href="static/css/base.css" rel="stylesheet">
<link href="static/easyui/uimaker/easyui.css" rel="stylesheet">
<link href="static/easyui/uimaker/icon.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>

<style type="text/css">
	#d1{
		margin-left: 200px;
		margin-top: 100px;
	}
	.password{
		height: 30px;
		width: 300px;
	}
	#btnSubmit{
		width: 70px;
		height: 40px;
		background-color: green;
		color: white;
	}
	.reset{
		width: 70px;
		height: 40px;
		background-color: red;
		color: white;
	}
</style>
</head>
<body>
<div id="d1">
<form>
		<div class="lg-password input-item clearfix">
			<i class="iconfont">&#xe634;</i> 
			<input type="password" 
				name="oldPassword"  placeholder="请输入旧密码"
				class="password easyui-validatebox" data-options="required:true,validType:'oldPassword'">
		</div>
		<br>
		<div class="lg-password input-item clearfix">
			<i class="iconfont">&#xe634;</i> 
			<input type="password" 
				name="newPassword"  placeholder="请输入新密码" 
				class="password easyui-validatebox" data-options="required:true,validType:'newPassword'">
		</div>
		<br>
		<div class="lg-password input-item clearfix">
			<i class="iconfont">&#xe634;</i> 
			<input type="password" 
				name="newRepassword"  placeholder="请确认新密码" 
				class="password easyui-validatebox" data-options="required:true,validType:'newRepassword'">
		</div>
		<br>
		<div class="enter">
			&emsp;&emsp;&emsp;&emsp;<button id="btnSubmit" type="button">提交</button>&emsp;&emsp;&emsp;&emsp;
			<button class="reset" type="reset">重置</button>
		</div>
		</form>
</div>
<script type="text/javascript">
	$(function(){
		$.extend($.fn.validatebox.defaults.rules, {
			oldPassword: {
				validator: function(value){
					var reg = /^[a-zA-Z0-9_]{1,}$/;
					return reg.test(value);
				},
				message: '密码格式不正确'
		    },
		    newPassword: {
				validator: function(value){
					var reg = /^[a-zA-Z0-9_]{1,}$/;
					return reg.test(value);
				},
				message: '密码格式不正确'
		    },
			newRepassword: {
				validator: function(value){
					return value == $("input[name=newPassword]").val();
				},
				message: '两次密码不一致'
		    }
		});
		
		
		$("#btnSubmit").on("click", function(){
			var oldPassword = $("input[name=oldPassword]").val();
			var newPassword = $("input[name=newPassword]").val();
			var newRepassword = $("input[name=newRepassword]").val();
			
			if(oldPassword == "") {
				$.messager.alert("提示", "请输入当前密码！", "info");
				return false;
			}
			if(newPassword == "") {
				$.messager.alert("提示", "请输入新密码！", "info");
				return false;
			}
			if(newPassword != newRepassword) {
				$.messager.alert("提示", "确认密码不一致", "info")
				return false;
			}
			$.messager.confirm("警告","确定修改密码？", function(data){
				if(data) {
					$.post(
							"updatePersonPassword.do?username="+"${sessionScope.username}",
							{
								"oldPassword": oldPassword, 
								"newPassword": newPassword, 
								"newRepassword": newRepassword
							},
							function(data) {
								$.messager.alert("提示",data.msg,"info");
								if(data.success) {
									parent.$("#topWindow").window('close');
									parent.window.location.href="/TaxSource/login.jsp";
								} else {
									return false;
								}
							},
							"json"
					)
				}
			})
			
		});
	});
</script>
</body>
</html>