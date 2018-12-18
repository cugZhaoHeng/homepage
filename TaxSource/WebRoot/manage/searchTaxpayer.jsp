<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>纳税人查询</title>

<link href="static/easyui/uimaker/easyui.css" rel="stylesheet">
<link href="static/easyui/uimaker/icon.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
</head>
<body>
<%
	String payerCode = request.getParameter("payerCode");
	String payerName = request.getParameter("payerName");
%>

 <table id="dg1"></table>

 <script type="text/javascript">
		$(function(){
			$("#dg1").datagrid({
				title:"纳税人列表",
				pagePosition:"bottom",
				url:"searchTaxPayer.do?payerCode=<%=payerCode %>&payerName=<%=payerName%>",
				columns:[[
					{field:"payerCode", title: '纳税人识别号'},
					{field:"payerName", title: '纳税人名称'},
					{field:"taxOrganId", title: '所属税务机关'},
					{field:"industryId", title: '所属行业'},
					{field:"legalPerson", title: '法人代表'},
					{field:"legalIdCard", title: '法人身份证号码'},
					{field:"finaceName", title: '主管财务'},
					{field:"finaceIdCard", title: '财务身份证号码'},
					{field:"taxerName", title: '办税人员'},
					{field:"recordDate", title: '录入日期'}
				]]
			});
		});
    </script>
</body>
</html>