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
<title>修改税务人员</title>
<link rel="stylesheet" type="text/css" href="static/css/base.css" >
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/easyui.css">
<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
<link rel="stylesheet" type="text/css" href="static/css/edit.css">

<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/js/calendar.js"></script>

</head>
<%
	String id = request.getParameter("id");
%>
<body>
<div class="container">
        <div class="content">
            <div title="纳税人信息" data-options="closable:false" class="basic-info">
                <div class="column"><span class="current">税务人员详细信息</span></div>
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
                        <td class="kv-label">系统管理员标志</td>
                        <td class="kv-content">
                            <input type="text" name="admin" >
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
            </div>
            <div class="btn-selection">
                <a href="javascript:save();" class="easyui-linkbutton save-btn" data-options="selected:true">保存</a>
                <a href="javascript:reset();" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	$(function() {
		/* 获取信息来源，并显示在页面上 */
		$.post("getTaxer.do", {}, function(data) {
			$.each(data, function(index, val) {
				if(val.id == "<%=id%>") {
					$("input[name=taxerCode]").val(val.taxerCode);
					$("input[name=taxerName]").val(val.taxerName);
					$("input[name=mobile]").val(val.mobile);
					$("input[name=admin]").val(val.admin);
					$("input[name=birthday]").val(val.birthday);
					$("input[name=email]").val(val.email);

					/* 将所属税务机关的编号转换为名称 */
					var organId = val.organId;
					$.post("getOrgan.do", {}, function(data) {
						$.each(data, function(index, val) {
							if(val.id == organId) {
								$("#organId").val(val.id);
							}
						})
					})

					/* 通过地址中存放的@， 将省市县分别自动选中 */
					//将地址拆分为数组
					var addressArr = val.address.split("@");
					var provinceName = addressArr[0];
					var cityName = addressArr[1];
					var townName = addressArr[2];
					var locate = addressArr[3];

					/* 将获得的详细地址（不包含省市县，只包含街道与乡镇），添加到textArea文本域中 */
					$("#locate").val(locate);

					/* 实现了对第一级select的文本选中，但是无法实现对第二级select的文本选中 */
					/* 尽管这里对province级别的select设置值，但是并没有真正意义上 的调用onChange()方法，所以city级别的select没有被赋上该省的城市名称 */
					/* 那么这里我能不能在不调用onChange()的情况下，对city级别的select的下拉列表进行赋值呢？假如在这里实现onChange()的函数体呢？ */
					$('#province option:contains(' + provinceName + ')').attr('selected','selected');
					/* 实现一下试试 */
					//1.先获取当前省在provinceList数组中的下标
					var indexProvince;
					$.each(provinceList, function(i, item){
						if(item.name == provinceName) {
							indexProvince = i;
						}
					})
					//2.获得了下标indexProvince之后，获得这个省底下的所有市
					$.each(provinceList[indexProvince].cityList, function(i, item) {
						addEle($("#city"),item.name);
					})
					//3.将city下拉列表的值设置为cityName被选中
					$('#city option:contains(' + cityName + ')').attr('selected','selected');
					//4.模仿第1步，再次实现onChange()，将县级select对应的值添加进去
					var indexCity;
					$.each(provinceList[indexProvince].cityList, function(i, item){
						if(item.name == cityName) {
							indexCity = i;
						}
					})
					//5.获取了indexCity，即城市的下标之后，获取该城市下面的所有县（区）
					$.each(provinceList[indexProvince].cityList, function(i, item) {
						if(cityName == item.name){
				            for(var n=0;n<item.areaList.length;n++){
				                addEle($("#town"),item.areaList[n])
				            }
				        }
					})
					//6.将当前的townName选中
					$('#town option:contains(' + townName + ')').attr('selected','selected');
				}
			})
		})

		/* 生成所属税务机关下拉条 */
		$.post("getOrgan.do", {}, function(data) {
			var organ = $("#organId");
			$.each(data, function(index, val) {
				organ.append("<option value='"+val.id+"'>"+val.organName+"</option>");
			})
		})
	})
	
	/* 点击重置 */
	function reset() {
		location.href = "manage/editTaxer.jsp?id=<%=id%>";
	}
	
	/* 点击保存 */
	function save() {
		/* 读取文本框和下拉条的的数据 */
		var taxerCode = $("input[name=taxerCode]").val();
		var taxerName = $("input[name=taxerName]").val();
		var mobile = $("input[name=mobile]").val();
		/* 获取省，市，县的文本内容 */
		var province = $("#province").find("option:selected").text();
		var city = $("#city").find("option:selected").text();
		var town = $("#town").find("option:selected").text();
		var locate = $("#locate").val();
		var address = province + "@" + city + "@" + town + "@" + locate;
		
		var sex = $('input:radio[name="sex"]:checked').val();
		var birthday = $("input[name=birthday]").val();
		var email = $("input[name=email]").val();
		var organId = $("#organId").val();
		var admin = $("input[name=admin]").val();

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
		
		if(email == "") {
			$.messager.alert("提示","请输入邮箱", "info");
			return false;
		}
		if(!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(email)) {
			$.messager.alert("提示","邮箱格式错误", "info");
			return false;
		}
		if(organId == -1) {
			$.messager.alert("提示","请选择税务机关", "info");
			return false;
		}
		
		var formData = new FormData();
		formData.append("taxerCode", taxerCode);
		formData.append("taxerName", taxerName);
		formData.append("mobile", mobile);
		formData.append("address", address);
		formData.append("sex", sex);
		formData.append("birthday", birthday);
		formData.append("email", email);
		formData.append("organId", organId);
		formData.append("admin", admin);
		$.ajax({
			url: "editTaxer.do?id="+"<%=id%>",
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
			error: function() {
				parent.$.messager.alert("提示","服务器异常","info");
			}
		})
	}
</script>
<script src="static/js/area.js"></script>
<script src="static/js/select.js"></script>
</html>