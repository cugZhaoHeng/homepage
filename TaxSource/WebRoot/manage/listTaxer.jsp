<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>纳税人管理</title>
	<link href="static/easyui/uimaker/easyui.css" rel="stylesheet">
	<link href="static/easyui/uimaker/icon.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>

	<style type="text/css">
		a:link {color: blue; text-decoration: none}     /* 未访问的链接 */
		a:visited {color: blue}  /* 已访问的链接 */
		a:hover {color: green}    /* 当有鼠标悬停在链接上 */
		a:active {color: green}   /* 被选择的链接 */
		
	</style>
</head>
<body>
	<div id="tb" style="padding:0 30px;">
        	税务人员工号: <input type="text" name="taxerCode" style="width:166px;height:35px;line-height:35px;"/>
        	税务人员名称: <input type="text" name="taxerName" style="width:166px;height:35px;line-height:35px;"/>
        	<a href="javascript:searchTaxer()" id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        	<a href="javascript:reset()" id="setBtn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
        	<a href="javascript:addTaxer()" id="addBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增税务人员</a>
      </div>
	<table id="tableTaxer"></table>
	<script type="text/javascript">
	$(function(){
		$("#tableTaxer").datagrid({
			title:"税务人员列表",
			striped:true,
			pagination:true,
			pageNumber:1,
			pageList:[2,5,10,20,30],
			rownumbers:true,
			pagePosition:"top",
			url:"listTaxer.do",
			columns:[[
				{field:"taxerCode", title: '税务人员工号'},
				{field:"taxerName", title: '姓名'},
				{field:"mobile", title: '电话'},
				{field:"sex", title: '性别'},
				{field:"birthday", title: '出生日期'},
				{field:"email", title: '电子邮箱'},
				{field:"organName", title: '所属税务机关'},
				{field:"state", title: '有效标志'},
				{field:"mgrName", title: '上级领导'},
				{field:"admin", title: '系统管理员标志'},
				{field:"recordDate", title: '录入日期'},
				{field:"recordName", title: '录入人员'},
				{field:"option", title: '操作',
					formatter: function(value,rowData,index){
						 return "<a href='javascript:removeTaxer("+rowData.id+")'>删除   </a>"
		                    +"<a href='javascript:editTaxer("+rowData.id+")' >修改  </a>"
		                    +"<a href='javascript:lookTaxer("+rowData.id+")' >查看详情  </a>"
						
					}
				}
			]]
		});
	});

	/* doSearch函数，在对数据库进行操作之后执行，重新加载表格 */
	function doSearch() {
		$("#tableTaxer").datagrid('load', {
			taxerCode: $("input[name=taxerCode]").val(),
			taxerName: $("input[name=taxerName]").val()
		});
	}

	/* 点击查询 */
	function searchTaxer() {
		doSearch();
	}
	/* 点击重置 */
	function reset() {
		$("input[name=taxerCode]").val("");
		$("input[name=taxerName]").val("");
	}

	/* 点击添加 */
	function addTaxer() {
		openTopWindow({
			width: 1000,
			height: 600,
			title: "修改税务人员信息",
			url: "manage/addTaxer.jsp"
		})
		parent.$("#topWindow").window({
	              onBeforeClose: function() {
		              doSearch();
	              }
            })
	}
	
	/* 删除纳税人的函数 */
	function removeTaxer(id) {
		$.messager.confirm({
			title: "提示",
			msg: "确认删除？",
			fn: function(data) {
				if(data) {
					$.post(
						"removeTaxer.do?id="+id,
						$(this).serialize(),
						function(data) {
							parent.$.messager.alert("提示",data.msg,"info");
							if(data.success) {
								doSearch();
							}
						},
						"json"
					)
				}
			}
		})
	}
	
	/* 修改纳人的函数 */
	function editTaxer(id) {
		openTopWindow({
			width: 1000,
			height: 600,
			title: "修改税务人员信息",
			url: "manage/editTaxer.jsp?id="+id
		})
		parent.$('#topWindow').window({
            onBeforeClose:function(){ 
            	doSearch();
            }
        });
	}
	
	/* 查看纳税人详情的函数 */
	function lookTaxer(id) {
		openTopWindow({
			width:1000,
			height:600,
			title:"查看税务人员信息",
			url:"manage/lookTaxer.jsp?id="+id
		})
	}
	
	/* 打开在父窗口中打开window的函数 */
    function openTopWindow(options){
        options = !options ? {} :options;
        options.width = !options.width ? 500 : options.width;
        options.height = !options.height ? 400 : options.height;
        options.url = !options.url ? "404.html" : options.url;
        options.title = !options.title ? "" : options.title;

        parent.$("#topWindow").window({
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
</body>
</html>