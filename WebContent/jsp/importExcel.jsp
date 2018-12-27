<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<%@include file="../script.html"%>
<script src="static/js/xlsx.full.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="container" style="width: 550px; height: 400px; margin: 0 auto"></div>
	<div id="import">
		<p>请选择要选择导入的模版文件</p>
		<input type="file" onchange="importFile(this)" id="file1">
		<button id="cc">click</button>
		<button id="export">导出为Excel</button>
	</div>
	<script language="JavaScript">
		var jsonArr;
		$(document).ready(function() {
			$("#cc").on('click', function() {
				$.each(jsonArr, function(index, val) {
					alert(val.name);
				});
			});
			$("#export").on('click', function(){
				exportData();
			});
		});

		function importFile(obj) {//导入
			if (!obj.files) {
				return;
			}
			// 获取Excel文件对象
			var f = obj.files[0];
			// 这里的FileReader有何作用？JS中专门用来读取文件的类吗？
			var reader = new FileReader();
			reader.onload = function(e) {
				var data = e.target.result; // 这里的e是指什么？data又是什么？
				// 获取WorkBook对象
				var wb = XLSX.read(data, {
					type : 'binary' //以二进制的方式读取
				});
				// 获取WorkSheet对象
				var sheet0 = wb.Sheets[wb.SheetNames[0]];//sheet0代表excel表格中的第一页
				// 将WorkSheet的内容提取出来，利用下面的接口，转化成了JSON数组
				jsonArr = XLSX.utils.sheet_to_json(sheet0);
			}
			reader.readAsBinaryString(f);
			return jsonArr;
		}
		/* 将JSONArray导出为Excel */
		function exportData() {
			var fileName = "abc";

			var sheet0 = XLSX.utils.json_to_sheet(jsonArr);
			var wopts = {
				bookType : 'xlsx',
				bookSST : false,
				type : 'binary'
			};
			var wb = {
				SheetNames : [ 'Sheet0' ],
				Sheets : {},
				Props : {}
			};
			wb.Sheets['Sheet0'] = sheet0;//转化成workbooks形式。
			var wbout = XLSX.write(wb, wopts);
			//转换流形式
			function s2ab(s) {
				var buf = new ArrayBuffer(s.length);
				var view = new Uint8Array(buf);
				for (var i = 0; i != s.length; ++i)
					view[i] = s.charCodeAt(i) & 0xFF;
				return buf;
			}
			/* the saveAs call downloads a file on the local machine */
			//自定义保存文件方式,原项目采用的是cordova的文件写入方式，此演示只用模拟浏览器下载的形式
			saveAs(new Blob([ s2ab(wbout) ], {
				type : ""
			}), fileName + ".xlsx");

		}
		function saveAs(obj, fileName) {
			var tmpa = document.createElement("a");
			tmpa.download = fileName || "下载";
			tmpa.href = URL.createObjectURL(obj);
			tmpa.click();
			setTimeout(function() {
				URL.revokeObjectURL(obj);
			}, 100);
		}
	</script>
</body>
</html>