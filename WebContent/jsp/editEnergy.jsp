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
<title>Insert title here</title>
<%@include file="../script.html"%>
</head>
<body>
	<%String date = request.getParameter("date"); %>
	<%String energy = request.getParameter("energy"); %>
	<div class="container">
		<form id="ff" method="post">
			<div class="input-date">
				<label>日期：</label>
				<input type="text" class="easyui-datebox" id="date" name="date" data-options="disabled:true" required="true" />
			</div>
			<div class="input-number">
				<label>能量：</label>
				<input type="text" class="easyui-numberbox" id="energyNum" name="energyNum" requierd="true"/>
			</div>
			<div class="btn-selection">
				<a href="javascript:save()" class="easyui-linkbutton save-btn" data-options="selected:true">确认</a>
				<a href="javascript:reset()" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var date = "<%=date%>";
		var energy = "<%=energy%>";
		$("#date").datebox('setValue', date);
		$("#energyNum").numberbox('setValue', energy);
	});
	
	/* 点击确认提交表单 */
	function save() {
		var userId = "${sessionScope.userId }";
		var date = "<%=date%>";
		var energyNum = $("input[name='energyNum']").val();
		if(energyNum == null || energyNum == '') {
			$.messager.alert('提示信息', '请输入能量数', 'warning');
			return;
		}
		$("#ff").form('submit', {
			url: 'editEnergy.do?userId='+userId+"&date="+date,
			success: function(data) {
				/* 将JSON格式的数据转化为JavaScript格式的对象 */
				var data = eval('(' + data + ')'); 
				if(data.success) {
					$.messager.alert('提示信息', data.msg, 'info', function(){parent.location.reload();});
				} else {
					$.messager.alert('提示信息', data.msg, 'info', function(){return;});
				}
			}
		});
	}
	
	/* 点击重置按钮 */
	function reset(){
		window.location.reload();
	}
</script>
</html>