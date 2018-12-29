<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">

<%@include file="../script.html"%>

<title>Insert title here</title>
</head>
<body>
<div class="container" align="center">
	<table class="kv-table">
		<tr>
			<td class="kv-label">原密码：</td>
			<td class="kv-content"><input type="password" class="easyui-validatebox kv-text" id="prePassword" style="width: 50%; height: 100%;"/></td>
		</tr>
		<tr>
			<td class="kv-label">设置密码：</td>
			<td class="kv-content"><input type="password" class="easyui-validatebox kv-text" id="setPassword" style="width: 50%; height: 100%;"/></td>
		</tr>
		<tr>
			<td class="kv-label">确认密码：</td>
			<td class="kv-content"><input type="password" class="easyui-validatebox kv-text" id="checkPassword" style="width: 50%; height: 100%;"/></td>
		</tr>
	</table>
	<div class="btn-selection">
		<a href="javascript:save()" class="easyui-linkbutton save-btn" data-options="selected:true">确认</a>
		<a href="javascript:reset()" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
	</div>
</div>
</body>
<script type="text/javascript">
	/* 全局变量 */
	var userId = "${sessionScope.userId }";
	
	
	$(document).ready(function(){
		/* 确认密码框离焦事件  */
		$("#checkPassword").blur(function(){
			var setPassword = $("#setPassword").val();
			var checkPassword = $("#checkPassword").val();
			if(setPassword != checkPassword) {
				$.messager.alert('提示信息', '两次密码不匹配', 'info');
			}
		});
	});

	/* 点击确认按钮 */
	function save() {
		if(validateBlank()) {
			var prePwd = $("#prePassword").val();
			/* 先验证原密码是否正确 */
			$.post('validatePassword.do', {'userId':userId, 'prePassword': prePwd}, function(data){
				if(data.success) {
					/* 将数据发送到后台 */
					$.post(
							'editPassword.do', 
							{'userId': userId, 'prePassword': $("#prePassword").val(), 'setPassword': $("#setPassword").val()}, 
							function(data){
								if(data.success) {
									$.messager.alert('提示信息', data.msg, 'info', function(){parent.location.href="login.jsp";});
								} else {
									$.messager.alert("提示信息", data.msg, 'info');
								}
							}, 
							'json'
					);
				} else {
					$.messager.alert('提示信息', '原密码输入错误', 'info', function(){});
				}
			}, 'json');
		} else {
			return false;
		}
	}
	
	/* 验证是否有未输入项 */
	function validateBlank() {
		if($("#prePassword").val() == "" || $("#prePassword").val() == null) {
			$.messager.alert('提示信息', '请输入原密码', 'info');
			return false;
		}
		if($("#setPassword").val() == "" || $("#setPassword").val() == null) {
			$.messager.alert('提示信息', '请输入预设密码', 'info');
			return false;
		}
		if($("#checkPassword").val() == "" || $("#checkPassword").val() == null) {
			$.messager.alert('提示信息', '请输入确认密码', 'info');
			return false;
		}
		return true;
	}
	
	/* 点击重置按钮 */
	function reset() {
		$("#prePassword").val('');
		$("#setPassword").val('');
		$("#checkPassword").val('');
	}
</script>
</html>