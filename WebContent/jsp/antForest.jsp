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
<script type="text/javascript" src="static/plugin/highcharts/highcharts.js"></script>
<script type="text/javascript" src="static/plugin/js-xlsx/xlsx.full.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<table id="tb-energy"></table>
	<div id="chart" style="width: 500px; height: 400px;"></div>
	<div id="win"></div>
</div>
</body>
<script type="text/javascript">
	/* 定义全局变量 */
	var allEnergy;
	var jsonArr;
	$(document).ready(function(){
		var userId = "${sessionScope.userId }";
		tableEnergy(userId);
		loadEnergy(userId);
		
	});
	
	/* 显示蚂蚁森林能量表格  */
	function tableEnergy(userId) {
		$("#tb-energy").datagrid({
			toolbar: [
				{iconCls: 'icon-edit', text: '编辑', handler: function(){editEnergy();}},
				{iconCls: 'icon-remove', text: '删除', handler: function(){removeEnergy();}},
				{iconCls: 'icon-add', text:'添加', handler:function(){addEnergy();}},
				{iconCls: 'icon-reload', text:'刷新', handler:function(){window.location.reload();}},
				{iconCls: 'icon-excel', text:'导出 ', handler:function(){exportEnergy();}},
				{iconCls: 'icon-word', text:'导入 ', handler:function(){importEnergy();}}
			] ,
			url: 'getEnergyById.do?userId='+userId,
			pagination: true,
			rownumbers: true,
			pageNumber: 1,
			pageSize: 5,
			pageList: [1, 2, 5, 10],
			striped: true,
			checkOnSelect: true,
			singleSelect: true,
			columns: [
				[
				 	{field:'check', checkbox:"true"},
					{field: 'date', title: '日期', width: 200, align: 'center'},
					{field: 'energy', title: '能量', width: 200, align: 'center'}
				]
			],
		});
	}
	
	/* 加载蚂蚁森林能量曲线图  */
	function loadEnergy(userId) {
		/* 防止Ajax异步提交，这里需要等待数据先获取到   */
		$.ajaxSetup({async : false});
		var energyDate = [];
		var energyData = [];
		$.post('getEnergyById.do', {'userId': userId}, function(data){
			allEnergy = data.all;
			$.each(data.all, function(index, val){
				energyDate.push(val.date);
				energyData.push(val.energy*1);	/* 将字符串转化为数字  */
			});
		}, 'json');
		
		var chart = {backgroundColor: '#ffffff', inverted: false};
		var credits = {enabled: false};
		var title = {text: '蚂蚁森林'};
		var subtitle = {text:'数据来源：支付宝'};
		var xAxis = {
				title:'月份', 
				categories:energyDate,
				lineWidth:0,
				gridLineColor:'#C0C0C0',
				gridLineWidth:1,
		};
		
		var yAxis = {title:'温度', plotLined:[{value: 0, width: 1, color: '#808080'}]};
		var tooltip = {valueSuffix:'xB0C'};
		var legend = {layout:'vertical', align:'right', verticalAlign:'middle', borderWidth:0};
		var series = [
			{name:'能量', data:energyData}
		];
		
		var json = {};
		json.chart = chart;
		json.credits = credits;
		json.title = title;
		json.subtitle = subtitle;
		json.xAxis = xAxis;
		json.yAxis = yAxis;
		json.tooltip = tooltip;
		json.legend = legend;
		json.series = series;
		$("#chart").highcharts(json);
	}
	
	/* 点击添加按钮  */
	function addEnergy(){
		options = {
				title: '添加能量数据',
				height: 400,
				width: 800,
				content: "<iframe height='100%' width='100%' src='jsp/addEnergy.jsp' ></iframe>"
		};
		openWindow(options);
	}
	
	/* 点击删除按钮 */
	function removeEnergy() {
		var selection = $("#tb-energy").datagrid('getSelected');
		if(selection == null) {
			$.messager.alert('提示信息', '请勾选删除项', 'info', function(){return;});
		} else {
			var userId = "${sessionScope.userId }";
			$.messager.confirm('提示信息', '确认删除？', function(sure){
				if(sure) {
					$.post('removeEnergy.do', {'userId': userId, 'date': selection.date}, function(data){
						if(data.success) {
							$.messager.alert('提示信息', data.msg, 'info', function(){
								window.location.reload();
							});
						} else {
							$.messager.alert('提示信息', data.msg, 'info');
						}
					}, 'json');
				} else {
					return;
				}
			});
		}
	}
	
	/* 点击编辑按钮 */
	function editEnergy() {
		var selection = $("#tb-energy").datagrid('getSelected');
		if(selection == null) {
			$.messager.alert('提示信息', '请选择修改项', 'warning');
			return;
		}
		var date = selection.date;
		var energy = selection.energy;
		var options = {
				title: '修改能量',
				content: "<iframe height='100%' width='100%' src='jsp/editEnergy.jsp?date="+
						date+"&energy="+energy+"'></iframe>"
				
		};
		openWindow(options);
	}
	
	/* 点击查询按钮 */
	function searchEnergy() {
		$("#tb-energy").datagrid('load', {});
	}
	
	/* 点击导出按钮 */
	function exportEnergy() {
		var fileName = "蚂蚁森林";
		exportData(fileName, allEnergy);
	}
	
	/* 点击导入按钮 */
	function importEnergy() {
		var options = {
				title:'导入Excel数据', 
				content:"<iframe height='100%' width='100%' src='jsp/importEnergy.jsp'></iframe>"
		};
		openWindow(options);
	}
	
	/* 打开弹窗 */
	function openWindow(options) {
		$("#win").window({
			title: options.title,
			height: options.height ? options.height : 400,
			width: options.width ? options.width : 800,
			content: options.content
		});
	}
	
	
	/* 将JSONArray导出为Excel */
	function exportData(fileName, jsonArr) {
		var sheet0 = XLSX.utils.json_to_sheet(jsonArr);
		var wopts = {
			bookType : 'xlsx',
			bookSST : false,
			type : 'binary'
		};
		var wb = {
			SheetNames : [ 'Sheet0' ],
			Sheets : {},
			Props : {}
		};
		wb.Sheets['Sheet0'] = sheet0;//转化成workbooks形式。
		var wbout = XLSX.write(wb, wopts);
		//转换流形式
		function s2ab(s) {
			var buf = new ArrayBuffer(s.length);
			var view = new Uint8Array(buf);
			for (var i = 0; i != s.length; ++i)
				view[i] = s.charCodeAt(i) & 0xFF;
			return buf;
		}
		/* the saveAs call downloads a file on the local machine */
		//自定义保存文件方式,原项目采用的是cordova的文件写入方式，此演示只用模拟浏览器下载的形式
		saveAs(new Blob([ s2ab(wbout) ], {
			type : ""
		}), fileName + ".xlsx");

	}
	function saveAs(obj, fileName) {
		var tmpa = document.createElement("a");
		tmpa.download = fileName || "下载";
		tmpa.href = URL.createObjectURL(obj);
		tmpa.click();
		setTimeout(function() {
			URL.revokeObjectURL(obj);
		}, 100);
	}
</script>
</html>