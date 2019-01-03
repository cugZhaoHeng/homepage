<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<%@include file="../script.html"%>
<link type="text/css"
	href="static/plugin/ueditor/themes/default/css/ueditor.min.css">
<script type="text/javascript"
	src="static/plugin/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="static/plugin/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript"
	src="static/plugin/ueditor/ueditor.parse.min.js"></script>
<script type="text/javascript"
	src="static/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
<title>日志记录</title>
</head>
<body>
	<div>
		<script type="text/plain" id="myEditor"
			style="width:100%;height:240px;"> 
    </script>
	</div>
	<div>
		<a class="easyui-linkbutton" id="save">确认</a>
	</div>
	<div id="textbody">
		
	</div>
</body>
<script>
	//实例化编辑器
	var ue = UE.getEditor('myEditor');
	$(document).ready(function(){
		$("#save").on('click', function(){
			alert(ue.getContent());
			$("#textbody").html(ue.getContent());
		});
	})
</script>
</html>