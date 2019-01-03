<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<%@include file="../script.html"%>
<title>修改个人信息</title>
</head>
<body>
<div class="container" align="center">
	<table class="kv-table">
		<tr>
			<td class="kv-label">用户名：</td>
			<td class="kv-content" id="userName">${sessionScope.userName }</td>
		</tr>
		<tr>
			<td class="kv-label">出生日期：</td>
			<td class="kv-content">
				<input class="easyui-datebox" id="birthday" />
			</td>
		</tr>
		<tr>
			<td class="kv-label">手机号：</td>
			<td class="kv-content" >
				<input type="text" class="easyui-numberbox" id="tel" />
			</td>
		</tr>
		<tr>
			<td class="kv-label">邮箱：</td>
			<td class="kv-content" >
				<input type="text" class="easyui-validatebox" id="email" validateType="email"/>
			</td>
		</tr>
	</table>
	
	<div class="btn-selection">
		<a href="javascript:submit()" class="easyui-linkbutton save-btn" data-options="selected:true, iconCls:'icon-add'" style="width:70px;height:35px;">提交</a>
		<a href="javascript:reset()" class="easyui-linkbutton reset-btn" data-options="selected:true, iconCls:'icon-reload'" style="width:70px;height:35px;">重置</a>
	</div>
</div>
</body>
<script type="text/javascript">
	var userId = "${sessionScope.userId }";
	$(document).ready(function(){
		reset();
	});
	
	function submit() {
		
	}
	
	function reset() {
		$.post("getAllUser.do",{}, function(data){
			$.each(data, function(index, val){
				if(val.id == userId) {
					$("#birthday").datebox('setValue', val.birthday);
					$("#tel").numberbox('setValue', val.tel);
					$("#email").val(val.email);
				}
			});
		}, "json");
	}
</script>
</html>