<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
	<title>任务录入</title>
	<link href="static/css/base.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="static/css/edit.css">
	<link rel="stylesheet" href="static/easyui/uimaker/easyui.css">
	<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
	<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
</head>
<body>
<%
	String id = request.getParameter("id");
%>
<div class="container">
    <div class="content">
        <div title="纳税人信息" data-options="closable:false" class="basic-info">
            <div class="column"><span class="current">纳税人基本信息</span></div>
            <form id="ff">
            <table class="kv-table">
                <tbody>
                <tr>
                    <td class="kv-label">纳税人识别号</td>
                    <td class="kv-content">
                    	<input type="text" id="payerCode" name="payerCode" list="payerCodeList" placeholder="请输入纳税人识别号" />
                    	<datalist id="payerCodeList">
                    		
                    	</datalist>
                    </td>
                    <td class="kv-label">纳税人名称</td>
                    <td class="kv-content"><label id="payerName"></label></td>
                    <td class="kv-label">生产经营地址</td>
                    <td class="kv-content"><label id="bizAddress"></label></td>
                </tr>
                <tr>
                    <td class="kv-label">所属税务机关</td>
                    <td class="kv-content"><label id="taxOrganId"></label></td>
                    <td class="kv-label">行业</td>
                    <td class="kv-content"><label id="industryId"></label></td>
                    <td class="kv-label">经营范围</td>
                    <td class="kv-content"><label id="bizScope"></label></td>
                </tr>
                <tr>
                    <td class="kv-label">票种核定</td>
                    <td class="kv-content"><label id="invoiceType"></label></td>
                    <td class="kv-label">法人代表人</td>
                    <td class="kv-content"><label id="legalPerson"></label></td>
                    <td class="kv-label">法人身份证号</td>
                    <td class="kv-content"><label id="legalIdCard"></label></td>
                </tr>
                <tr>
                    <td class="kv-label">主管财务</td>
                    <td class="kv-content"><label id="finaceName"></label></td>
                    <td class="kv-label">财务身份证号</td>
                    <td class="kv-content"><label id="finaceIdCard"></label></td>
                     <td class="kv-label">办税人员</td>
                    <td class="kv-content"><label id="taxerName"></label></td>
                </tr>
                <tr>
                    <td class="kv-label">办税人身份证号</td>
                    <td class="kv-content"><label id="taxerIdCard"></label></td>
                    <td class="kv-label">录入日期</td>
                    <td class="kv-content"><label id="recordDate"></label></td>
                    <td class="kv-label">录入人员</td>
                    <td class="kv-content"><label id="userId"></label></td>
                </tr>
                </tbody>
            </table>
            <div class="column"><span class="current">任务信息</span></div>
            
            <table class="kv-table">
                <tbody>
                <tr>
                    <td class="kv-label">任务名称</td>
                    <td class="kv-content">
                    	<input type="text" id="taskName" name="taskName" placeholder="请输入任务名称" />
                    </td>
                    <td class="kv-label">下达部门</td>
                    <td class="kv-content">
                    	 <select name="subOrganId" id="subOrganId">
                             <option value="-1">请选择下达部门</option>                         
                         </select>
                    	
                    </td>
                    <td class="kv-label">批准人员</td>
                    <td class="kv-content">
                    	<select name="approverId" id="approverId">
                            <option value="-1">请选择批准人员</option>                         
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="kv-label">执行人员</td>
                    <td class="kv-content">
                    	<select name="executeId" id="executeId">
                            <option value="-1">请选择执行人员</option>                         
                        </select>
                    </td>
                    <td class="kv-label">执行时间</td>
                    <td class="kv-content"><input class="easyui-datebox" type="text" name="executeTime" id="executeTime"></td>
                    <td class="kv-label">风险等级</td>
                    <td class="kv-content">
                        <select name="riskLevel" id="riskLevel">
                            <option value=-1>请选择风险等级</option>
                            <option value=0>无</option>
                            <option value=1>低</option>
                            <option value=2>中</option>
                            <option value=3>高</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="kv-label">任务执行情况</td>
                    <td class="kv-content">
                        <textarea name="taskState" id="taskState" rows="3" style="width: 90%;"></textarea>
                    </td>
                    <td class="kv-label">调查结论和意见</td>
                    <td class="kv-content" colspan="3">
                        <textarea name="idea" id="idea" rows="3" style="width: 90%;"></textarea>
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
<script type="text/javascript">
	$(function() {
		/* 生成任务信息的各个下拉条 */
		
		/* 纳税人识别号 */
		$.post("getPayer.do", {}, function(data) {
			$.each(data ,function(index, val) {
				$("#payerCodeList").append("<option value=" + val.payerCode + ">" + val.payerCode);
			})
		})
		
		/* 下达部门 */
		$.post("getOrgan.do", {}, function(data) {
			$.each(data ,function(index, val) {
				$("#subOrganId").append("<option value='" + val.id + "'>" + val.organName + "</option>");
			})
		})

		/* 批准人员 */
		$.post("getTaxer.do", {}, function(data) {
			$.each(data, function(index, val) {
				$("#approverId").append("<option value='" + val.id + "'>" + val.taxerName + "</option>");
			})
		})

		/* 执行人员 */
		$.post("getTaxer.do", {}, function(data) {
			$.each(data, function(index, val) {
				$("#executeId").append("<option value='" + val.id + "'>" + val.taxerName + "</option>");
			})
		})
		
		/* 根据id自动完成文本框和下拉条的值 */
		$.post("getTask.do", {}, function(data) {
			$.each(data, function(index, val) {
				if(val.id == "<%=id%>") {
					/* 填充纳税人信息 */
					var payerId = val.payerId;
					$.post("getPayer.do", {}, function(data) {
						$.each(data, function(index, val) {
							if(val.id == payerId) {
								$("#payerCode").val(val.payerCode);
								$("#payerName").html(val.payerName);
								$("#bizAddress").html(val.bizAddress);
								$("#bizScope").html(val.bizScope);
								$("#invoiceType").html(val.invoiceType);
								$("#legalPerson").html(val.legalPerson);
								$("#legalIdCard").html(val.legalIdCard);
								$("#finaceName").html(val.finaceName);
								$("#finaceIdCard").html(val.finaceIdCard);
								$("#taxerName").html(val.taxerName);
								$("#taxerIdCard").html(val.taxerIdCard);
								$("#recordDate").html(val.recordDate);
		
		
								/* 转换所属税务机关 */
								var taxOrganId = val.taxOrganId;
								$.post("getOrgan.do", {}, function(data) {
									$.each(data, function(index, val) {
										if(val.id == taxOrganId) {
											$("#taxOrganId").html(val.organName);
										}
									})
								})
								
								/* 转换行业名称 */
								var industryId = val.industryId;
								$.post("getIndustry.do", {}, function(data) {
									$.each(data, function(index, val) {
										if(val.id == industryId) {
											$("#industryId").html(val.industryName);
										}
									})
								})
								/* 转换税务人员 */
								var userId = val.userId;
								$.post("getUser.do", {}, function(data) {
									$.each(data, function(index, val) {
										if(val.id == userId) {
											var taxerId = val.taxerId;
											$.post("getTaxer.do", {}, function(data) {
												$.each(data, function(index, val) {
													if(val.id == taxerId) {
														$("#userId").html(val.taxerName);
													}
												})
											})
										}
									})
								})
							}
						})
					})
					/* 自动填充任务信息 */
					$("#taskName").val(val.taskName);
					$("#subOrganId").val(val.subOrganId);
					$("#approverId").val(val.approverId);
					$("#executeId").val(val.executeId);
					$('#executeTime').datebox('setValue', val.executeTime);
					$("#riskLevel").val(val.riskLevel);
					$("#taskState").val(val.taskState);
					$("#idea").val(val.idea);
				}
			})
		})
		
		/* 输入完纳税人识别号时，失去焦点事件 */
		$("#payerCode").on("blur", function() {
			$.post("getPayer.do", {}, function(data) {
				$.each(data, function(index, val) {
					if(val.payerCode == $("#payerCode").val()) {
						$("#payerName").html(val.payerName);
						$("#bizAddress").html(val.bizAddress);
						$("#bizScope").html(val.bizScope);
						$("#invoiceType").html(val.invoiceType);
						$("#legalPerson").html(val.legalPerson);
						$("#legalIdCard").html(val.legalIdCard);
						$("#finaceName").html(val.finaceName);
						$("#finaceIdCard").html(val.finaceIdCard);
						$("#taxerName").html(val.taxerName);
						$("#taxerIdCard").html(val.taxerIdCard);
						$("#recordDate").html(val.recordDate);


						/* 转换所属税务机关 */
						var taxOrganId = val.taxOrganId;
						$.post("getOrgan.do", {}, function(data) {
							$.each(data, function(index, val) {
								if(val.id == taxOrganId) {
									$("#taxOrganId").html(val.organName);
								}
							})
						})
						
						/* 转换行业名称 */
						var industryId = val.industryId;
						$.post("getIndustry.do", {}, function(data) {
							$.each(data, function(index, val) {
								if(val.id == industryId) {
									$("#industryId").html(val.industryName);
								}
							})
						})
						/* 转换税务人员 */
						var userId = val.userId;
						$.post("getUser.do", {}, function(data) {
							$.each(data, function(index, val) {
								if(val.id == userId) {
									var taxerId = val.taxerId;
									$.post("getTaxer.do", {}, function(data) {
										$.each(data, function(index, val) {
											if(val.id == taxerId) {
												$("#userId").html(val.taxerName);
											}
										})
									})
								}
							})
						})
					}
				})
			})
		})
		
		
	})
	
	/* 点击保存 */
	function save() {
		/* 获取文本框和下拉条的信息 */
		var payerCode = $("#payerCode").val();
		var taskName = $("#taskName").val();
		var subOrganId = $("#subOrganId").val();
		var approverId = $("#approverId").val();
		var executeId = $("#executeId").val();
		var executeTime = $("input[name=executeTime]").val();
		var riskLevel = $("#riskLevel").val();
		var taskState = $("#taskState").val();
		var idea = $("#idea").val();

		/* 对文本框和下拉列表的信息进行正则表达式判断 */
		if(payerCode == "") {
			$.messager.alert("提示","请输入纳税人识别号！", "info");
			return false;
		}
		if(taskName == "") {
			$.messager.alert("提示","请输入任务名称！", "info");
			return false;
		}
		if(subOrganId == -1) {
			$.messager.alert("提示","请选择下达部门！", "info");
			return false;
		}
		if(approverId == -1) {
			$.messager.alert("提示","请选择批准人员！", "info");
			return false;
		}
		if(executeId == -1) {
			$.messager.alert("提示","请选择执行人员！", "info");
			return false;
		}
		if(executeTime == "") {
			$.messager.alert("提示","请选择执行时间！", "info");
			return false;
		}
		if(riskLevel == -1) {
			$.messager.alert("提示","请选择风险等级！", "info");
			return false;
		}

		/* 提交form表单 */
		$("#ff").form('submit',{
			url: "editTask.do",
			onSubmit: function(param){
				param.id = "<%=id%>";
		    },
			success: function(data) {
				var data = eval('(' + data + ')');
				/* easyUI的alert是非阻塞式的，与js的alert不同，程序会跳过alert继续执行，方法是将要执行的代码写在alert的function中 */
				$.messager.alert("提示", data.msg, "info", function(){
					location.href="manage/listTask.jsp";
				});
			}
		})
	}

	/* 点击重置 */
	function reset() {
		location.href="manage/editTask.jsp?id=<%=id%>";
	}
</script>
</body>
</html>