<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
	<title>未调查企业统计</title>
	<link href="static/css/base.css" rel="stylesheet">
	<link rel="stylesheet" href="static/easyui/uimaker/easyui.css">
	<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
	<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
    
</head>  
<body>
    <div class="container">
     <div id="tb" style="padding:0 30px;">
        	纳税人识别号: <input type="text" id="payerCode" name="payerCode" style="width:166px;height:35px;line-height:35px;"/>
        	纳税人名称: <input type="text" id="payerName" name="payerName" style="width:166px;height:35px;line-height:35px;"/>
        	<a href="javascript:search()" id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        	<a href="javascript:reset();" id="setBtn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
      </div> 
      <table id="dg"></table>
    </div>
    <div id="d1"></div>
    <script type="text/javascript">
		$(function(){
			$("#dg").datagrid({
				title:"纳税人列表",
				striped:true,
				pagination:true,
				pageNumber:1,
				pageList:[2,5,10,20,30],
				rownumbers:true,
				pagePosition:"top",
				url:"statistical.do",
				columns:[[
					{field:"payerCode", title: '纳税人识别号'},
					{field:"payerName", title: '纳税人名称'},
					{field:"organName", title: '所属税务机关'},
					{field:"industryName", title: '所属行业'},
					{field:"legalPerson", title: '法人代表'},
					{field:"legalIdCard", title: '法人身份证号码'},
					{field:"finaceName", title: '主管财务'},
					{field:"finaceIdCard", title: '财务身份证号码'},
					{field:"taxerName", title: '办税人员'},
					{field:"recordDate", title: '录入日期'},
				]]
			});

		});
		
		/* doSerch函数，在每次执行完对数据库的操作之后刷新数据表 */
	 	function doSearch() {
	 		$('#dg').datagrid('load', {
	 		    payerCode: $("#payerCode").val(),
	 		    payerName: $("#payerName").val()
	 		});
		}

		/* 点击查询按钮 */
		function search() {
			doSearch();
		}

	 	/* 点击重置按钮，重置按钮如果要生效，则input标签不能使用easyUI的样式，必须为原生的HTML标签 */
	 	function reset() {
	 		$("#payerCode").val("");
			$("#payerName").val("");
		}
    </script>
</body> 
</html>
