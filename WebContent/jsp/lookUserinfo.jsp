<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="static/css/edit.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<div class="container" align="center">
	<table class="kv-table">
		<tr>
			<td class="kv-label">用户名</td>
			<td class="kv-content" id="userName">${sessionScope.userName }</td>
		</tr>
		<tr>
			<td class="kv-label">出生日期：</td>
			<td class="kv-content" id="birthday"></td>
		</tr>
		<tr>
			<td class="kv-label">手机号：</td>
			<td class="kv-content" id="tel"></td>
		</tr>
	</table>
	<div class="btn-selection">
		<a href="" class="easyui-linkbutton edit-btn" data-options="selected:true">修改</a>
		<a href="" class="easyui-linkbutton exit-btn" data-options="selected:true">关闭</a>
	</div>
</div>
</body>

<script type="text/javascript">
	
	$(document).ready(function(){
		var userId = "${sessionScope.userId }";
		$.post("getAllUser.do",{}, function(data){
			$.each(data, function(index, val){
				if(val.id == userId) {
					$("#birthday").text(val.birthday);
					$("#tel").text(val.tel);
				}
			})
		}, "json")
	})
</script>
</html>