<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<%@include file="../script.html"%>
<script src="static/js/xlsx.full.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.container .import {
		padding-top: 20px;
	}
	.container .center {
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
</style>
</head>
<body>
	<div class="container">
		<form id="ff" method="post">
			<div>
				<input class="easyui-filebox" id="file1" data-options="onChange:function(){getFiles();}" sytle="width:200px" />
			</div>
			<div class="center" style="padding-top: 20px;">
				<table class="easyui-datagrid tb-module" style="text-align:'center';"
					data-options="url:'static/json/energy.json',method:'get', toolbar:'#toolbar'">
					<thead>
						<tr>
							<th data-options="field:'date',align:'center'" style="width:50%">date</th>
							<th data-options="field:'energy',align:'center'" style="width:50%">energy</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="btn-selection">
				<a href="javascript:save()" class="easyui-linkbutton save-btn"
					data-options="selected:true">确认</a> <a href="javascript:reset()"
					class="easyui-linkbutton reset-btn" data-options="selected:true">重置</a>
			</div>
		</form>
	</div>
	<div id="toolbar">
		<a class="easyui-linkbutton" plain="true">请严格按照下面格式填充excel表格</a>
		<a href="static/otherFile/energyModal.xlsx" class="easyui-linkbutton" iconCls="icon-download">下载模板</a>
	</div>

	<script language="JavaScript">
		/* 全局变量，file为上传的文件，以JSON数组的形式保存Excel文件转化的数据 */
		var file;
		var files;
		var jsonArr;
		$(document).ready(function() {
			$("#file1").filebox({
				buttonText: '选择文件',
				buttonAlign: 'left',
				
			});
			
		});
		
		/* 读取文件 */
		function getFiles() {
			files = $("#file1").filebox('files');
			// 获取Excel文件对象
			file = files[0];
			var fileName = file.name;
			var fileType = fileName.substring(fileName.length - 4);

			/* 判断是否是excel文件 */
			if ([ 'xlsx', '.xls' ].indexOf(fileType) > -1) {
				// 创建FileReader对象
				var reader = new FileReader();
				/* 读取文件，以二进制方式 */
				reader.readAsBinaryString(file);
				
				/* onloan的执行时间在很后面，会导致延迟的，所以这个函数必须在上传好文件之后立即触发，而不是等待点击确认再触发*/
				reader.onload = function(e) {
					/* 读取文件内容 */
					var data = e.target.result;
					// 获取WorkBook对象，以二进制的方式读取
					var wb = XLSX.read(data, {
						type : 'binary'
					});
					// 获取WorkSheet对象，sheet0代表excel表格中的第一页
					var sheet0 = wb.Sheets[wb.SheetNames[0]];
					// 将WorkSheet的内容提取出来，利用下面的接口，转化成了JSON数组
					jsonArr = XLSX.utils.sheet_to_json(sheet0);
				};
			} else {
				$.messager.alert('提示信息', '请选择Excel文件', 'info', function() {
					reset();
					return;
				});

			}
		}

		/* 点击确认按钮 */
		function save() {
			/* 判断是否有文件上传 */
			if (!files) {
				$.messager.alert('提示信息', '请选择文件', 'warning');
				return;
			} else {
				if(jsonArr) {
					/* 遍历表头，检查表头中的元素是否与数据表一致 */
					for ( var key in jsonArr[0]) {
						if ([ 'date', 'energy' ].indexOf(key) == -1) {
							$.messager.alert('提示信息', '表头格式未按照要求填写', 'warning');
							return;
						}
					}
				} else {
					alert("没有数据");
				}
				
			}
			/* 日期格式为mm/dd/yy的正则表达式 */
			var dateReg1 = /^\d{2}\/\d{2}\/\d{2}/;
			var date = "";
			var failDate = "";
			/* 防止Ajax异步提交，这里需要等待数据先获取到   */
			$.ajaxSetup({
				async : false
			});
			$.each(jsonArr,
					function(index, val) {
						if (dateReg1.test(val.date)) {
							var strArr = val.date.split("/");
							date = "20" + strArr[2] + "-" + strArr[0] + "-"
									+ strArr[1];
						}
						$.post('addEnergy.do', {
							'userId' : "${sessionScope.userId}",
							'date' : date,
							'energyNum' : val.energy
						}, function(data) {
							if (!data.success) {
								failDate += (date + "\n");
							}
						}, 'json');
					});
			if (failDate != "") {
				$.messager.alert('提示信息', failDate + "已存在，如需修改请进入编辑页面", 'info');

			} else {
				$.messager.alert('提示信息', '添加成功', 'info');
			}

		}

		/* 点击重置按钮 */
		function reset() {
			window.location.reload();
		}

	</script>
</body>
</html>