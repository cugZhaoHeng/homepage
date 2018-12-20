<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="static/css/edit.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<div class="container" align="center">
	<table class="kv-table">
		<tr>
			<td class="kv-label">原密码：</td>
			<td class="kv-content"><input class="easyui-textbox" id="prePassword" style="width:100%; height:100%;" /></td>
		</tr>
		<tr>
			<td class="kv-label">设置密码：</td>
			<td class="kv-content"><input class="easyui-textbox" id="setPassword" style="width:100%; height:100%;" /></td>
		</tr>
		<tr>
			<td class="kv-label">确认密码：</td>
			<td class="kv-content"><input class="easyui-textbox" id="checkPassword" style="width:100%; height:100%;" /></td>
		</tr>
	</table>
	<div class="btn-selection">
		<a href="" class="easyui-linkbutton save-btn" data-options="selected:true">确认</a>
		<a href="" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
	</div>
</div>
</body>
</html>