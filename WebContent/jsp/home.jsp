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
<script type="text/javascript" src="static/highcharts/highcharts.js"></script>
<title>Insert title here</title>
</head>
<body>
<div id="container" style="width: 500px; height: 400px;">abc</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var title = {text: '月平均气温'};
		var subtitle = {text:'数据来源：中国天气网'};
		var xAxis = {
				title:'月份', 
				categories:['一月', '二月', '三月', '四月', '五月', '六月' ,'七月', '八月', '九月', '十月', '十一月', '十二月'],
				lineWidth:0,
				gridLineColor:'#C0C0C0',
				gridLineWidth:1,
		};
		
		var yAxis = {title:'温度', plotLined:[{value: 0, width: 1, color: '#808080'}]};
		var tooltip = {valueSuffix:'xB0C'};
		var legend = {layout:'vertical', align:'right', verticalAlign:'middle', borderWidth:0};
		var series = [
			{name:'东京', data:[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]},
			{name:'纽约', data:[-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]},
			{name:'柏林', data:[-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]}, 
			{name:'伦敦', data:[3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]}
		];
		
		var json = {};
		
		json.title = title;
		json.subtitle = subtitle;
		json.xAxis = xAxis;
		json.yAxis = yAxis;
		json.tooltip = tooltip;
		json.legend = legend;
		json.series = series;
		$("#container").highcharts(json);
	})
	
</script>
</html>