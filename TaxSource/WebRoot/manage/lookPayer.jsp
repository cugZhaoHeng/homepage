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
<title>查看纳税人信息</title>
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
                <div class="column"><span class="current">纳税人详细信息</span></div>
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
                        <td class="kv-label">生产经营地址</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="bizAddress" >
                        </td>
                        <td class="kv-label">经营地电话</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="bizAddressPhone" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">所属税务机关</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="taxOrganId" >
                        </td>
                        <td class="kv-label">行业</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="industryId" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">生产经营范围</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="bizScope" >
                        </td>
                        <td class="kv-label">票种核定</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="invoiceType" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">法人代表</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="legalPerson" >
                        </td>
                        <td class="kv-label">法人身份证号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="legalIdCard" >
                        </td>
                    </tr>
                   	<tr>
                   		<td class="kv-label">法人手机号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="legalMobile">
                        </td>
                        <td class="kv-label">法人身份证扫描图</td>
                        <td class="kv-content">
                        	<a href="javascript:lookLegalImage()">点击查看</a>
                        </td>
                   	</tr>
                    <tr>
                        <td class="kv-label">财务人员</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="finaceName" >
                        </td>
                        <td class="kv-label">财务身份证号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="finaceIdCard" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">财务手机号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="finaceMobile" >
                        </td>
                        <td class="kv-label">财务身份证扫描图</td>
                        <td class="kv-content">
                        	<a href="javascript:lookFinaceImage()">点击查看</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">办税人员</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="taxerName" >
                        </td>
                        <td class="kv-label">办税人员身份证号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="taxerIdCard" >
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">办税人员手机号</td>
                        <td class="kv-content">
                            <input type="text" readonly="readonly" name="taxerMobile" >
                        </td>
                         <td class="kv-label">办税人员身份证扫描图</td>
                        <td class="kv-content">
                        	<a href="javascript:lookTexerImage()">点击查看</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">录入人员</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="userId" >
                        </td>
                        <td class="kv-label">录入日期</td>
                        <td class="kv-content">
                        	<input type="text" readonly="readonly" name="recordDate" >
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
	/* 三个变量分别对应三张身份证图片 */
	var legalIdCardImageURL;
	var finaceIdCardImageURL;
	var taxerIdCardImageURL;
	$(function(){
		/* 获得文本框中的信息来源， 并自动填入 */
		$.post("getPayer.do", {}, function(data) {
			$.each(data, function(index, val) {
				if(val.id == "<%=id%>") {
					$("input[name=payerCode]").val(val.payerCode);
					$("input[name=payerName]").val(val.payerName);
					$("input[name=bizAddressPhone]").val(val.bizAddressPhone);
					$("input[name=bizScope]").val(val.bizScope);
					$("input[name=invoiceType]").val(val.invoiceType);
					/* 获取三个图片的名称 */
					legalIdCardImageURL = val.legalIdCardImageURL;
					finaceIdCardImageURL = val.finaceIdCardImageURL;
					taxerIdCardImageURL = val.taxerIdCardImageURL;
					var bizAddress = val.bizAddress;
					var taxOrganId = val.taxOrganId;
					$.post("getOrgan.do", {}, function(data) {
						$.each(data, function(data, val) {
							if(val.id == taxOrganId) {
								$("input[name=taxOrganId]").val(val.organName);
								$("input[name=bizAddress]").val(val.address);
							}
						})
					})
					
					var industryId = val.industryId;
					$.post("getIndustry.do", {}, function(data) {
						$.each(data, function(index, val) {
							if(val.id == industryId) {
								$("input[name=industryId]").val(val.industryName);
							}
						})
					})
					
					var userId = val.userId;
					$.post("getUser.do", {}, function(data) {
						$.each(data, function(index, val){
							if(val.id == userId) {
								var taxerId = val.taxerId;
								$.post("getTaxer.do", {}, function(data) {
									$.each(data, function(index, val) {
										if(val.id == taxerId) {
											$("input[name=userId]").val(val.taxerName);
										}
									})
								})
							}
						})
					})
					
					$("input[name=legalPerson]").val(val.legalPerson);
					$("input[name=legalIdCard]").val(val.legalIdCard);
					$("input[name=legalMobile]").val(val.legalMobile);
					
					$("input[name=finaceName]").val(val.finaceName);
					$("input[name=finaceIdCard]").val(val.finaceIdCard);
					$("input[name=finaceMobile]").val(val.finaceMobile);

					$("input[name=taxerName]").val(val.taxerName);
					$("input[name=taxerIdCard]").val(val.taxerIdCard);
					$("input[name=taxerMobile]").val(val.taxerMobile);

					$("input[name=recordDate]").val(val.recordDate);
					
				}
			})
		})
	});
	/* 查看法人代表的身份证扫描件 */
	function lookLegalImage() {
		openTopWindow({
			width : 550,
            height : 400,
            title : "法人代表身份证扫描件",
            url : "manage/showIdCardImage.jsp?idCardImageURL="+legalIdCardImageURL
		})
	}

	/* 查看财务人员的身份证扫描件 */
	function lookFinaceImage() {
		openTopWindow({
			width : 550,
            height : 400,
            title : "查看身份证",
            url : "manage/showIdCardImage.jsp?idCardImageURL=" + finaceIdCardImageURL
		})
	}
	/* 查看税务人员的身份证扫描件 */
	function lookTexerImage() {
		openTopWindow({
			width : 550,
            height : 400,
            title : "查看身份证",
            url : "manage/showIdCardImage.jsp?idCardImageURL=" + taxerIdCardImageURL
		})
	}
	//打开弹窗
	function openTopWindow(options){
        options = !options ? {} :options;
        options.width = !options.width ? 500 : options.width;
        options.height = !options.height ? 400 : options.height;
        options.url = !options.url ? "404.html" : options.url;
        options.title = !options.title ? "" : options.title;

        $("#lookWindow").window({
            title : options.title,
            width: options.width,
            height: options.height,
            content : "<iframe scrolling='yes' frameborder='0' border='0' height='100%' width='100%' src='"+options.url+"'></iframe>",
            modal:true,
            resizable:false,
            collapsible:false
        });
    }
</script>
</html>