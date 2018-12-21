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
			<td class="kv-content"><input type="text" class="kv-text" id="prePassword" style="width: 50%; height: 100%;"/></td>
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
		<a href="" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
	</div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		/* 确认密码框离焦事件  */
		$("#checkPassword").blur(function(){
			var setPassword = $("#setPassword").val();
			var checkPassword = $("#checkPassword").val();
			if(setPassword != checkPassword) {
				$.messager.alert('提示信息', '两次密码不匹配', 'info');
			}
		})
	})
	function save() {
		validate();
	}
	function validate() {
		var userId = "${sessionScope.userId }";
		var prePwd = $("#prePassword").val();
		
		$.post('validatePassword.do', {'userId':userId, 'prePassword': prePwd}, function(data){
			if(data.success) {
				$.messager.alert('提示信息', '修改成功', 'info', function(){})
			} else {
				$.messager.alert('提示信息', '修改失败', 'info', function(){})
			}
		}, 'json')
		
		
	}
</script>
</html>