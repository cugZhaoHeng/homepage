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
<title>新增税务人员</title>
<link rel="stylesheet" type="text/css" href="static/css/base.css" >
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
<link rel="stylesheet" type="text/css" href="static/css/edit.css">

<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/js/calendar.js"></script>

<script src="static/js/area.js"></script>
<script src="static/js/select.js"></script>
</head>
<body>
	<div class="container">
        <div class="content">
            <div title="纳税人信息" data-options="closable:false" class="basic-info">
                <div class="column"><span class="current">税务人员基本信息</span></div>
                <form id="ff">
                <table class="kv-table">
                    <tbody>
                    <tr>
                        <td class="kv-label">税务人员工号</td>
                        <td class="kv-content">
                        	<input type="text" name="taxerCode" >
                        </td>
                        <td class="kv-label">税务人员名称</td>
                        <td class="kv-content">
                        	<input type="text" name="taxerName" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">税务人员电话</td>
                        <td class="kv-content">
                        	<input type="text" name="mobile" >
                        </td>
                        <td class="kv-label">所属税务机关</td>
                        <td class="kv-content">
                        	 <select name="organId" id="organId">
                                <option value="-1">请选择所属税务机关</option>                         
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">税务人员性别</td>
                        <td class="kv-content">
                        	<input type="radio" name="sex" checked="checked" value="男" >男
                        	<input type="radio" name="sex" value="女" >女
                        	
                        </td>
                        <td class="kv-label">出生日期</td>
                        <td class="kv-content">
                        	<input type="date" name="birthday" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">电子邮箱</td>
                        <td class="kv-content">
                            <input type="text" name="email" >
                        </td>
                        <td class="kv-label">上级领导</td>
                        <td class="kv-content">
                        	<select name="mgr" id="mgr">
                        		<option value="-1">请选择上级领导</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                    	<td class="kv-label">税务人员地址</td>
                        <td class="kv-content">
                        <label id="address">
                        	<select name="province" id="province">
								<option value="-1">省级</option>
							</select>
							<select name="city" id="city">
								<option value="-1">地级</option>
							</select>
							<select name="town" id="town">
								<option value="-1">县级</option>
							</select>
							</label>
                        </td>
                        <td class="kv-label">详细地址</td>
                        <td class="kv-content">
                        	<textarea rows="5" cols="27" id="locate"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </form>
            </div>
            <div class="btn-selection">
                <a href="javascript:save();" class="easyui-linkbutton save-btn" data-options="selected:true">保存</a>
                <a href="javascript:reset();" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	$(function(){
		/* 生成所属税务机关的select */
		$.post("getOrgan.do", {}, function(data) {
			var organ = $("#organId");
			$.each(data ,function(index, val) {
				organ.append("<option value='" + val.id + "'>" + val.organName + "</option>");
			})
		})

		/* 生成上级领导的select */
		$.post("getTaxer.do", {}, function(data) {
			var mgr = $("#mgr");
			$.each(data, function(index, val) {
				mgr.append("<option value='" + val.id + "'>" + val.taxerName + "</option>");
			})
		})
	})
	
	/* 点击保存 */
	function save() {
		/* 读取文本框和下拉条的的数据 */
		var taxerCode = $("input[name=taxerCode]").val();
		var taxerName = $("input[name=taxerName]").val();
		var mobile = $("input[name=mobile]").val();
		var organId = $("#organId").val();

		var sex = $('input:radio[name="sex"]:checked').val();
		var birthday = $("input[name=birthday]").val();
		var email = $("input[name=email]").val();
		var mgr = $("#mgr").val();
		
		/* 获取省，市，县的文本内容 */
		var province = $("#province").find("option:selected").text();
		var city = $("#city").find("option:selected").text();
		var town = $("#town").find("option:selected").text();
		var locate = $("#locate").val();
		var address = province + "@" + city + "@" + town + "@" + locate;

		/* 对表单元素进行正则表达式判断 */
		if(taxerCode == "") {
			$.messager.alert("提示","请输入税务人员工号", "info");
			return false;
		}
		if(!/^[0-9|a-z|A-Z]{6}$/.test(taxerCode)) {
			$.messager.alert("提示","税务人员工号由6位字母或数字组成", "info");
			return false;
		}
		if(taxerName == "") {
			$.messager.alert("提示","请输入税务人员姓名", "info");
			return false;
		}
		if(!/^[a-z|A-Z|\u4e00-\u9fa5]{0,32}$/.test(taxerName)) {
			$.messager.alert("提示","税务人员姓名格式不正确", "info");
			return false;
		}
		if(mobile == "") {
			$.messager.alert("提示","请输入税务人员手机号", "info");
			return false;
		}
		if(!/^1[34578][0-9]{9}$/.test(mobile)) {
			$.messager.alert("提示","请输入正确的手机号","info");
			return false;
		}
		if(organId == -1) {
			$.messager.alert("提示","请选择税务机关", "info");
			return false;
		}
		if(email == "") {
			$.messager.alert("提示","请输入邮箱", "info");
			return false;
		}
		if(mgr == -1) {
			$.messager.alert("提示","请选择上级领导", "info");
			return false;
		}
		if(!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(email)) {
			$.messager.alert("提示","邮箱格式错误", "info");
			return false;
		}
		if(province == "省级" || province == "请选择") {
			$.messager.alert("提示","请选择省", "info");
			return false;
		}
		if(city == "地级" || city == "请选择") {
			$.messager.alert("提示","请选择市", "info");
			return false;
		}
		if(town == "县级" || town == "请选择") {
			$.messager.alert("提示","请选择县", "info");
			return false;
		}

		var formData = new FormData();
		formData.append("taxerCode", taxerCode);
		formData.append("taxerName", taxerName);
		formData.append("mobile", mobile);
		formData.append("organId", organId);
		
		formData.append("sex", sex);
		formData.append("birthday", birthday);
		formData.append("email", email);
		formData.append("mgr", mgr);
		
		formData.append("address", address);
		
		$.ajax({
			url: "addTaxer.do",
			type: "POST",
			data: formData,
			contentType: false,
			processData: false,
			success: function(data) {
				parent.$.messager.alert("提示",data.msg,"info");
				if(data.success) {
					parent.$("#topWindow").window('close');
				}
			},
			error:function() {
				parent.$.messager.alert("提示","服务器异常","info");
			}
		})
	}

	/* 点击重置 */
	function reset() {
		$("#ff").form('clear');
	}
</script>
<script src="static/js/area.js"></script>
<script src="static/js/select.js"></script>
</html>