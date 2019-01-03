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
<link type="text/css" href="static/plugin/umeditor1_2_3-utf8-jsp/utf8-jsp/themes/default/css/umeditor.min.css" >
<script type="text/javascript" src="static/plugin/umeditor1_2_3-utf8-jsp/utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" src="static/plugin/umeditor1_2_3-utf8-jsp/utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="static/plugin/umeditor1_2_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<title>日志记录</title>
</head>
<body>
<div>
    <script type="text/plain" id="myEditor" style="width:600px;height:240px;"> 
    </script>
</div>
</body>
<script>
     //实例化编辑器
    var um = UM.getEditor('myEditor');
    um.addListener('blur', function () {
        $('#focush2').html('编辑器失去焦点了')
    });
    um.addListener('focus', function () {
        $('#focush2').html('')
    });
</script>
</html>