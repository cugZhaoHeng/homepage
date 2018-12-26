<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<form id="ff" method="post">
			<div class="input-date">
				<label>日期：</label>
				<input type="text" class="easyui-datebox" name="date" required="true" />
			</div>
			<div class="input-number">
				<label>能量：</label>
				<input type="text" class="easyui-numberbox" name="energyNum" requierd="true"/>
			</div>
			<div class="btn-selection">
				<a href="javascript:save()" class="easyui-linkbutton save-btn" data-options="selected:true">确认</a>
				<a href="javascript:void(0)" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	/* 点击确认提交表单 */
	function save() {
		var userId = "${sessionScope.userId }";
		var energyNum = $("input[name='energyNum']").val();
		if(energyNum == null || energyNum == '') {
			$.messager.alert('提示信息', '请输入能量数', 'warning');
			return;
		}
		$("#ff").form('submit', {
			url: 'addEnergy.do?userId='+userId,
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
</script>
</html>