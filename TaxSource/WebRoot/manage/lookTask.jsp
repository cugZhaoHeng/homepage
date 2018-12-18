<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>查看税务人员</title>
<link rel="stylesheet" type="text/css" href="static/css/base.css" >
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
<link rel="stylesheet" type="text/css" href="static/css/edit.css">

<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/js/calendar.js"></script>
</head>

<body>
<%
	String id = request.getParameter("id");
%>
 <div class="container">
        <div class="content">
            <div title="纳税人信息" data-options="closable:false" class="basic-info">
                <div class="column"><span class="current">税务人员详细信息</span></div>
                <table class="kv-table">
                    <tbody>
                    <tr>
                        <td class="kv-label">纳税人识别号</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="payerCode" >
                        </td>
                        <td class="kv-label">纳税人名称</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="payerName" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">任务名称</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="taskName" >
                        </td>
                         <td class="kv-label">下达部门</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="subOrganId" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">批准人员</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="approverId" >
                        </td>
                        <td class="kv-label">执行人员</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="executeId" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">行业</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="industryName" >
                        </td>
                        <td class="kv-label">经营范围</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name=bizScope >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">执行时间</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="executeTime" >
                        </td>
                        <td class="kv-label">录入时间</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="recordTaskDate" >
                        </td>
                    </tr>
                   	<tr>
                   		<td class="kv-label">任务来源</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="taskFrom" >
                        </td>
                        <td class="kv-label">风险等级</td>
                       	<td class="kv-content">
                        	<input type="text" readonly="readonly" name="riskLevel" >
                        </td>
                   	</tr>
                   	<tr>
	                   	<td class="kv-label">任务执行情况</td>
	                    <td class="kv-content">
	                        <textarea name="taskState" id="taskState" readonly="readonly" rows="3" style="width: 67%;"></textarea>
	                    </td>
	                    <td class="kv-label">调查结论和意见</td>
	                    <td class="kv-content" colspan="3">
	                        <textarea name="idea" id="idea" readonly="readonly" rows="3" style="width: 67%;"></textarea>
	                    </td>
                   	</tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="lookWindow"></div>
</body>
<script type="text/javascript">
$(function(){
	/* 将文本框中的值根据id自动填入 */
	$.post("getTask.do", {}, function(data) {
		$.each(data, function(index, val) {
			if(val.id == "<%=id%>") {
				/* 填写纳税人识别号，纳税人名称，行业，经营范围 */
				var payerId = val.payerId;
				$.post("getPayer.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(val.id == payerId) {
							$("input[name=payerCode]").val(val.payerCode);
							$("input[name=payerName]").val(val.payerName);
							var industryId = val.industryId
							$.post("getIndustry.do", {}, function(data) {
								$.each(data, function(index, val) {
									if(val.id == industryId) {
										$("input[name=industryName]").val(val.industryName);
									}
								})
							})
							$("input[name=bizScope]").val(val.bizScope);
						}
					})
				})
				
				$("input[name=taskName]").val(val.taskName);
				$("input[name=executeTime]").val(val.executeTime);
				$("input[name=recordTaskDate]").val(val.recordTaskDate);
				$("input[name=taskFrom]").val(val.taskFrom);
				$("#taskState").val(val.taskState);
				$("#idea").val(val.idea);
				//$("input[name=riskLevel]").val(val.riskLevel);
				
				

				/* 下达部门，将organId的值替换为对应的organName */
				var subOrganId = val.subOrganId;
				$.post("getOrgan.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(val.id == subOrganId) {
							$("input[name=subOrganId]").val(val.organName);
						}
					})
				})

				/* 批准人和执行人员 */
				var approverId = val.approverId;
				var executeId = val.executeId;
				$.post("getTaxer.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(val.id == approverId) {
							$("input[name=approverId]").val(val.taxerName);
						}
						if(val.id == executeId) {
							$("input[name=executeId]").val(val.taxerName);
						}
					})
				})

				/* 风险等级  */
				var riskLevel = val.riskLevel;
				$.post("getRiskLevel.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(val.level == riskLevel) {
							$("input[name=riskLevel]").val(val.value);
						}
					})
				})

				
				
			}
		})
	}, "json")
	
});
</script>
</html>