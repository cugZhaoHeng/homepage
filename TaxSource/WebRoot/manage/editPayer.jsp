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
<title>修改纳税人</title>
<link rel="stylesheet" type="text/css" href="static/css/base.css" >
    <link rel="stylesheet" type="text/css" href="static/easyui/uimaker/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
    <link rel="stylesheet" type="text/css" href="static/css/edit.css">

  	<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
  	<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
  	<script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
  	<script type="text/javascript" src="static/js/calendar.js"></script>
  
  	<script src="https://cdn.bootcss.com/webuploader/0.1.1/webuploader.min.js"></script>
  	<link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/webuploader/0.1.1/webuploader.css">
</head>
<%
	String payerId = request.getParameter("payerId");
%>
<body>
    <div class="container">
        <div class="content">
            <div title="纳税人信息" data-options="closable:false" class="basic-info">
                <div class="column"><span class="current">修改纳税人信息</span></div>
                <table class="kv-table">
                    <tbody>
                    <tr>
                        <td class="kv-label">纳税人识别号</td>
                        <td class="kv-content"><input type="text" name="payerCode" id="payerCode" class="easyui-validatebox" data-options="validType:'payerCode'"></td>
                        <td class="kv-label">纳税人名称</td>
                        <td class="kv-content"><input type="text" name="payerName" id="payerName" class="easyui-validatebox" data-options="validType:'chineseName'"></td>
                    </tr>
                    <tr>
                        <td class="kv-label">生产经营地址</td>
                        <td class="kv-content">
                        	<select name="bizAddress" id="bizAddress" checked="${payerBean.bizAddress }">
                        		<option value=-1>请选择经营地址</option>
                        	</select>
                        </td>
                        <td class="kv-label">经营地电话</td>
                        <td class="kv-content"><input type="text" name="bizAddressPhone" id="bizAddressPhone" class="easyui-validatebox" data-options="validType:'mobilePhone'"></td>
                    </tr>
                    <tr>
                        <td class="kv-label">所属税务机关</td>
                        <td class="kv-content">
                            <select name="taxOrganId" id="taxOrganId">
                                <option value="-1">请选择所属税务机关</option>                         
                            </select>
                        </td>
                        <td class="kv-label">行业</td>
                        <td class="kv-content">
                            <select name="industryId" id="industryId">
                                <option value="-1" >请选择纳税人行业</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">生产经营范围</td>
                        <td class="kv-content">
                            <input type="text" name="bizScope" id="bizScope" class="easyui-validatebox" data-options="validType:'bizScope'">
                        </td>
                        <td class="kv-label">票种核定</td>
                        <td class="kv-content">
                            <select name="invoiceType" id="invoiceType">
                                <option value="-1">请选择发票种类</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">法人代表</td>
                        <td class="kv-content">
                            <input type="text" name="legalPerson" id="legalPerson" class="easyui-validatebox" data-options="validType:'chineseName'">
                        </td>
                        <td class="kv-label">法人身份证号</td>
                        <td class="kv-content">
                            <input type="text" name="legalIdCard" id="legalIdCard" class="easyui-validatebox" data-options="validType:'idCard'">
                        </td>
                    </tr>
                    <tr>
                   		<td class="kv-label">法人手机号</td>
                        <td class="kv-content">
                            <input type="text" name="legalMobile" id="legalMobile" class="easyui-validatebox" data-options="validType:'mobilePhone'">
                        </td>
                        <td class="kv-label">法人身份证扫描图</td>
                        <td class="kv-content">
                        	<img id="chooseLegalIdCardPreview" alt="" src=""/>
                        	<div id="chooseLegalIdCard">选择文件</div>
                        	<input type="hidden" name="legalIdCardImageURL" id="legalIdCardImageURL"/>
                        </td>
                   	</tr>
                    <tr>
                        <td class="kv-label">财务人员</td>
                        <td class="kv-content">
                            <input type="text" name="finaceName" id="finaceName" class="easyui-validatebox" data-options="validType:'chineseName'">
                        </td>
                        <td class="kv-label">财务身份证号</td>
                        <td class="kv-content">
                            <input type="text" name="finaceIdCard" id="finaceIdCard" class="easyui-validatebox" data-options="validType:'idCard'">
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">财务手机号</td>
                        <td class="kv-content">
                            <input type="text" name="finaceMobile" id="finaceMobile" class="easyui-validatebox" data-options="validType:'mobilePhone'">
                        </td>
                        
                        <td class="kv-label">财务身份证照片</td>
                        <td class="kv-content">
                        	<img id="chooseFinaceIdCardPreview" alt="" src=""/>
                            <div id="chooseFinaceIdCard">选择文件</div>
                            <input type="hidden" name="finaceIdCardImageURL" id="finaceIdCardImageURL"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">办税专员</td>
                        <td class="kv-content">
                            <select name="taxerName" id="taxerName">
                                <option value="-1">请选择办税专员</option>
                            </select>
                        </td>
                        <td class="kv-label">办税人员身份证号</td>
                        <td class="kv-content">
                            <input type="text" name="taxerIdCard" id="taxerIdCard" class="easyui-validatebox" data-options="validType:'idCard'">
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">办税人员手机号</td>
                        <td class="kv-content">
                            <input type="text" name="taxerMobile" id="taxerMobile" class="easyui-validatebox" data-options="validType:'mobilePhone'">
                        </td>
                        <td class="kv-label">办税人员身份证扫描图</td>
                        <td class="kv-content">
                        	<img alt="" src="" id="chooseTaxerIdCardPreview" />
                        	<div id="chooseTaxerIdCard">选择文件</div>
                            <input type="hidden" name="taxerIdCardImageURL" id="taxerIdCardImageURL">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="btn-selection">
                <a href="javascript:void(0);" class="easyui-linkbutton save-btn" data-options="selected:true">保存</a>
                <a href="javascript:void(0);" class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	//$.messager.defaults = {Ok:'确定', Cancel:'取消'};
	$(function(){
		
		
		
		/* 生产经营地和所属税务机关的下拉列表，通过在Organ表的address和organName中得到*/
		$.post("getOrgan.do",{},function(data){
			$.each(data, function(index, val){
				$("#bizAddress").append("<option value='"+val.address+"'>"+val.address+"</option>");
			})
			$.each(data,function(index, val){
				$("#taxOrganId").append("<option value='"+val.id+"'>"+val.organName+"</option>");
			})
		},"json")
		
		/* 当地址改变时，相应的税务机关也改变 */
		$("#bizAddress").on("change", function() {
			/* 获取选中的地址 */
			var bizAddress = $("#bizAddress").val();
			/* 清空税务机关下拉列表 */
			$("#taxOrganId").find("option").remove();
			/* 将税务机关下拉列表自动的选中为相应的地址 */
			$.post("getOrgan.do",{},function(data){
			var organ = $("#taxOrganId");
				$.each(data,function(index, val){
					if(val.address == bizAddress) {
						organ.append("<option value='"+val.id+"'>"+val.organName+"</option>");
					}
				})
			},"json")
		})
		
		/* 行业下拉列表 */
		$.post("getIndustry.do",{},function(data){
			var industry = $("#industryId");
			$.each(data,function(index, val){
				industry.append("<option value='"+val.id+"'>"+val.industryName+"</option>");
			})
		},"json")
		
		/* 票种核定列表 */
		$.post("getInvoice.do",{},function(data){
			var invoiceType = $("#invoiceType");
			$.each(data,function(index, val){
				invoiceType.append("<option value='"+val.invoiceType+"'>"+val.invoiceType+"</option>");
			})
		},"json")
		
		/* 办税人员下拉列表 */
		$.post("getTaxer.do",{},function(data){
			var taxerName = $("#taxerName");
			$.each(data,function(index, val){
				taxerName.append("<option value='"+val.taxerName+"'>"+val.taxerName+"</option>");
			})
		},"json")
		
		/* 通过id将文本框和下拉列表的数据自动生成 */
		$.post("getPayer.do", {}, function(data) {
			$.each(data, function(index, val) {
				if(val.id == "<%=payerId%>") {
					$("#payerCode").val(val.payerCode);
					$("#payerName").val(val.payerName);
					$("#bizAddressPhone").val(val.bizAddressPhone);
					$("#invoiceType").val(val.invoiceType);
					$("#industryId").val(val.industryId);
					
					$("#taxerName").val(val.taxerName);
					$("#bizAddress").val(val.bizAddress);
					$("#taxOrganId").val(val.taxOrganId);
					$("#bizScope").val(val.bizScope);
					
					$("#legalPerson").val(val.legalPerson);
					$("#legalIdCard").val(val.legalIdCard);
					$("#legalMobile").val(val.legalMobile);
					
					$("#finaceName").val(val.finaceName);
					$("#finaceIdCard").val(val.finaceIdCard);
					$("#finaceMobile").val(val.finaceMobile);
					
					$("#taxerIdCard").val(val.taxerIdCard);
					$("#taxerMobile").val(val.taxerMobile);
				}
			})
		})
		
		/* 点击保存 */
		$(".save-btn").on("click", function(){
			edit();
		})
		
		/* 点击重置 */
		$(".reset-btn").on("click", function(){
			location.href="manage/editPayer.jsp?payerId=<%=payerId%>";
		})

		/* esauUI验证表单元素的输入，参数value为当前文本框中的内容，不能省略 */
		$.extend($.fn.validatebox.defaults.rules, {
			/* 验证payerCode */
			payerCode: {
				validator: function(value){
					var reg = /^[0-9|a-z|A-Z]{5}$/;
					return reg.test(value);
				},
				message: '请输入5位字符'
		    },
		    
		    /* 验证输入的纳税人名称是否为汉字， 且在2-32位之间 */
		    chineseName: {
				validator: function(value){
					var reg = /^[\u4E00-\u9FA5]{2,32}$/;
					return reg.test(value);
				},
				message: '请输入2-32位汉字'
		    },

		    /* 验证手机号是否输入正确 */
		    mobilePhone: {
				validator: function(value){
					var reg = /^1[34578][0-9]{9}$/;
					return reg.test(value);
				},
				message: '请输入正确的手机号'
		    },
		    
		    /* 验证身份证号是否输入正确 */
		    idCard: {
				validator: function(value){
					var reg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
					return reg.test(value);
				},
				message: '请输入正确的身份证号'
		    }
		});
	})
	
	/* 执行修改函数 */
	function edit() {
		var payerCode = $("#payerCode").val();
		var payerName = $("#payerName").val();
		var bizAddress = $("#bizAddress").val();
		
		var taxOrganId = $("#taxOrganId").val();
		var industryId = $("#industryId").val();
		var bizScope = $("#bizScope").val();
		var invoiceType = $("#invoiceType").val();

		var legalPerson = $("#legalPerson").val();
		var legalIdCard = $("#legalIdCard").val();
		var legalMobile = $("#legalMobile").val();
		var legalIdCardImageURL = $("#legalIdCardImageURL").val();

		var finaceName = $("#finaceName").val();
		var finaceIdCard = $("#finaceIdCard").val();
		var finaceMobile = $("#finaceMobile").val();
		var finaceIdCardImageURL = $("#finaceIdCardImageURL").val();

		var taxerName = $("#taxerName").val();
		var taxerIdCard = $("#taxerIdCard").val();
		var taxerMobile = $("#taxerMobile").val();
		var taxerIdCardImageURL = $("#taxerIdCardImageURL").val();

		
		var bizAddressPhone = $("#bizAddressPhone").val();
		var userName = "<%=session.getAttribute("username")%>";
		
		/* 对这些参数用正则表达式进行判断是否符合条件 */
		
		//纳税识别号
		if(!/^[0-9|a-z|A-Z]{5}$/.test(payerCode)){
			$.messager.alert("提示","纳税识别号由5位字母或数字组成", "info");
			return false;
		}
		
		//纳税人名称
		if(payerName==""){
			$.messager.alert("提示","请输入纳税人名称", "info");
			return false;
		}
		if(!/^[a-z|A-Z|\u4e00-\u9fa5]{0,32}$/.test(payerName)){
			$.messager.alert("提示","纳税人名称格式不正确，最大32位", "info");
			return false;
		}
		
		//生产经营地址
		if(bizAddress==-1){
			$.messager.alert("提示","请输入生产地址", "info");
			return false;
		}
		
		
		//生产经营地电话
		if(bizAddressPhone==""){
			$.messager.alert("提示","请输入生产地电话", "info");
			return false;
		}
		if(!/^1[34578][0-9]{9}$/.test(bizAddressPhone)){
			$.messager.alert("提示","生产经营地电话格式不正确", "info");
			return false;
		}
		
		//所属税务机关选填
		if(taxOrganId==-1){
			$.messager.alert("提示","请选择税务机关", "info");
			return false;
		}
		
		//行业选填
		if(industryId == -1) {
			$.messager.alert("提示","请选择行业", "info");
			return false;
		}
		
		//生产经营范围选填
		if(!/^[a-z|A-Z|\u4e00-\u9fa5]{0,64}$/.test(bizScope)){
			$.messager.alert("提示","生产经营范围最多只能填64个字符", "info");
			return false;
		}
		
		//票种核定，选填
		if(invoiceType == -1) {
			$.messager.alert("提示","请选择发票种类", "info");
			return false;
		}
		
		//法人代表
		if(legalPerson==""){
			$.messager.alert("提示","请输入法人代表姓名", "info");
			return false;
		}
		if(!/^[\u4e00-\u9fa5]{1,4}$/.test(legalPerson)){
			$.messager.alert("提示","法人代表姓名最大为4个中文字符", "info");
			return false;
		}
		
		//法人身份证号验证
		if(legalIdCard==""){
			$.messager.alert("提示","请输入法人代表身份证号", "info");
			return false;
		}
		if(!/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(legalIdCard)){
			$.messager.alert("提示","法人代表身份证号格式不正确", "info");
			return false;
		}
		
		//法人代表手机号验证，选填
		if(legalMobile == "") {
			$.messager.alert("提示","请输入法人代表手机号", "info");
		    return false;
		}
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(legalMobile))){ 
			$.messager.alert("提示","法人代表手机号格式错误", "info");
		    return false; 
		}
		
		//财务人员验证
		if(finaceName == "") {
			$.messager.alert("提示","请输入财务人员", "info");
		    return false;
		}
		if(!/^[\u4e00-\u9fa5]{0,4}$/.test(finaceName)){
			$.messager.alert("提示","财务主管最大为4个中文字符", "info");
			return false;
		}
		
		//财务人员身份证号验证，选填
		if(finaceIdCard == "") {
			$.messager.alert("提示","请输入财务人员身份证号", "info");
			return false;
		}
		if(!/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(finaceIdCard)){
			$.messager.alert("提示","财务人员身份证号格式不正确", "info");
			return false;
		}
		
		//财务人员手机号验证，选填
		if(finaceMobile == "") {
			$.messager.alert("提示","请输入财务人员手机号", "info");
			return false;
		}
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(finaceMobile))){ 
			$.messager.alert("提示","财务人员手机号格式错误", "info");
		    return false; 
		} 
		
		//办税人员验证
		if(taxerName==-1){
			$.messager.alert("提示","请选择办税人员", "info");
			return false;
		}
		//办税人员身份证号验证
		if(taxerIdCard == "") {
			$.messager.alert("提示","请输入办税人员身份证号", "info");
			return false;
		}
		if(!/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(taxerIdCard)){
			$.messager.alert("提示","办税人员身份证号格式不正确", "info");
			return false;
		}
		//办税人员手机号验证
		if(taxerMobile == "") {
			$.messager.alert("提示","请输入办税人员手机号", "info");
			return false;
		}
		if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(taxerMobile))){ 
			$.messager.alert("提示","办税人员手机号格式错误", "info");
		    return false; 
		}

		var formData = new FormData();
		formData.append("payerCode",payerCode);
		formData.append("payerName",payerName);
		formData.append("bizAddress",bizAddress);
		
		formData.append("taxOrganId",taxOrganId);
		formData.append("industryId",industryId);
		formData.append("bizScope",bizScope);
		formData.append("invoiceType",invoiceType);
		
		formData.append("legalPerson",legalPerson);
		formData.append("legalIdCard",legalIdCard);
		formData.append("legalMobile",legalMobile);
		formData.append("legalIdCardImageURL",legalIdCardImageURL);
		
		formData.append("finaceName",finaceName);
		formData.append("finaceIdCard",finaceIdCard);
		formData.append("finaceMobile",finaceMobile);
		formData.append("finaceIdCardImageURL",finaceIdCardImageURL);
		
		formData.append("taxerName",taxerName);
		formData.append("taxerIdCard",taxerIdCard);
		formData.append("taxerMobile",taxerMobile);
		formData.append("taxerIdCardImageURL",taxerIdCardImageURL);
		
		formData.append("bizAddressPhone",bizAddressPhone);
		formData.append("userName",userName);

		/* 使用messager，将英文按钮替换为中文按钮 */		
		$.ajax({
			url:"editPayer.do?id="+"<%=payerId%>",
			type:"POST",
			data:formData,
			contentType:false,
			processData:false,
			success: function (data) {
				/* 因为在父类窗口弹出提示窗口，此处需要加上parent */
				parent.$.messager.alert("提示",data.msg,"info", function() {
					if(data.success) {
						parent.$("#topWindow").window('close');
					}
				});
            },
			error:function() {
				parent.$.messager.alert("提示","服务器异常","info");
			}
		})
	}
	
</script>

	
<script type="text/javascript">
	$(function() {
		//上传法人代表身份证===============================================================================
		var chooseLegalIdCardUploader = WebUploader.create({
			// 选完文件后，是否自动上传。
		    auto: true,
		    // swf文件路径
		    swf: 'https://cdn.bootcss.com/webuploader/0.1.1/Uploader.swf',		
		    // 文件接收服务端。
		    server: '/TaxSource/uploadImg.do',		
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#chooseLegalIdCard',		
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
		    // 只允许选择图片文件。
		    accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }
		});
		
		chooseLegalIdCardUploader.on('fileQueued', function( file ) {
			chooseLegalIdCardUploader.makeThumb( file, function( error, src ) {
		        if (error) {
		            $("#chooseLegalIdCardPreview").replaceWith('<span>不能预览</span>');
		            return;
		        }
		        $("#chooseLegalIdCardPreview").attr( 'src', src );
		    }, 200, 100 );
		});
		//文件上传成功接受回调信息
		chooseLegalIdCardUploader.on('uploadSuccess', function (file,response) {
			 $("#legalIdCardImageURL").val(response.url);
	    });

		//上传财务人员===============================================================================
		var chooseTaxerIdCardUploader = WebUploader.create({	
			// 选完文件后，是否自动上传。
		    auto: true,
		    // swf文件路径
		    swf: 'https://cdn.bootcss.com/webuploader/0.1.1/Uploader.swf',		
		    // 文件接收服务端。
		    server: '/TaxSource/uploadImg.do',		
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#chooseFinaceIdCard',		
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
		    // 只允许选择图片文件。
		    accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }
		});
		
		chooseTaxerIdCardUploader.on('fileQueued', function( file ) {
			chooseTaxerIdCardUploader.makeThumb( file, function( error, src ) {
		        if (error) {
		            $("#chooseFinaceIdCardPreview").replaceWith('<span>不能预览</span>');
		            return;
		        }
		        $("#chooseFinaceIdCardPreview").attr( 'src', src );
		    }, 200, 100 );
		});
		//文件上传成功接受回调信息
		chooseTaxerIdCardUploader.on('uploadSuccess', function (file,response) {
			 $("#finaceIdCardImageURL").val(response.url);
	    });

		//上传财务人员===============================================================================
		var chooseTaxerIdCardUploader = WebUploader.create({	
			// 选完文件后，是否自动上传。
		    auto: true,
		    // swf文件路径
		    swf: 'https://cdn.bootcss.com/webuploader/0.1.1/Uploader.swf',		
		    // 文件接收服务端。
		    server: '/TaxSource/uploadImg.do',		
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#chooseTaxerIdCard',		
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
		    // 只允许选择图片文件。
		    accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }
		});
		
		chooseTaxerIdCardUploader.on('fileQueued', function( file ) {
			chooseTaxerIdCardUploader.makeThumb( file, function( error, src ) {
		        if (error) {
		            $("#chooseTaxerIdCardPreview").replaceWith('<span>不能预览</span>');
		            return;
		        }
		        $("#chooseTaxerIdCardPreview").attr( 'src', src );
		    }, 200, 100 );
		});
		//文件上传成功接受回调信息
		chooseTaxerIdCardUploader.on('uploadSuccess', function (file,response) {
			 $("#taxerIdCardImageURL").val(response.url);
	    });
	})
</script>
</html>