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
                        <td class="kv-label">税务人员工号</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="taxerCode" >
                        </td>
                        <td class="kv-label">税务人员名称</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="taxerName" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">税务人员电话</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="mobile" >
                        </td>
                         <td class="kv-label">所属税务机关</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="organId" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">税务人员性别</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="sex" >
                        </td>
                        <td class="kv-label">出生日期</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="birthday" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">电子邮箱</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="email" >
                        </td>
                        <td class="kv-label">有效标志</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name=state >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">上级领导</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="mgr" >
                        </td>
                        <td class="kv-label">系统管理员标志</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="admin" >
                        </td>
                    </tr>
                   	<tr>
                   		<td class="kv-label">录入日期</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="recordDate" >
                        </td>
                        <td class="kv-label">录入人员</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="recordUserId" >
                        </td>
                   	</tr>
                   	<tr>
                   		<td class="kv-label">税务人员地址</td>
                        <td class="kv-content" colspan="3">
                        	
                        	<label id="address"></label>
                        </td>
                   	</tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
$(function(){
	/* 将文本框中的值根据id自动填入 */
	$.post("getTaxer.do", {}, function(data) {
		$.each(data, function(index, val) {
			if(val.id == "<%=id%>") {
				$("input[name=taxerCode]").val(val.taxerCode);
				$("input[name=taxerName]").val(val.taxerName);
				$("input[name=mobile]").val(val.mobile);
				/* 由于地址中含有@分隔，需要将@去掉，并依次添加到地址栏中 */
				var addressArr = val.address.split("@");
				var addressLocate = "";
				for(var i=0; i<addressArr.length; i++) {
					addressLocate += addressArr[i];
				}
				$("#address").html(addressLocate);
				$("input[name=sex]").val(val.sex);
				$("input[name=birthday]").val(val.birthday);
				$("input[name=email]").val(val.email);
				$("input[name=admin]").val(val.admin);
				$("input[name=recordDate]").val(val.recordDate);
				$("input[name=state]").val(val.state);

				/* 将mgr即上级领导替换为相应的taxer */
				var mgr = val.mgr;
				$.post("getTaxer.do",{},function(data){
					$.each(data, function(index, val){
						if(val.id == mgr) {
							$("input[name=mgr]").val(val.taxerName);
						}
					})
				},"json")

				/* 将organId的值替换为对应的organName */
				var organId = val.organId;
				$.post("getOrgan.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(val.id == organId) {
							$("input[name=organId]").val(val.organName);
						}
					})
				})

				/* 通过税务人员的id，将userId即录入人员替换为相应的税务人员 */
				var userId = val.recordUserId;
				$.post("getUser.do", {}, function(data) {
					$.each(data, function(index, val) {
						if(userId == val.id) {
							var taxerId = val.taxerId;
							$.post("getTaxer.do", {}, function(data) {
								$.each(data, function(index, val) {
									if(taxerId == val.id) {
										$("input[name=recordUserId]").val(val.taxerName);
									}
								})
							})
							
						}
					})
				})
			}
		})
	}, "json")
	
});
</script>
</html>