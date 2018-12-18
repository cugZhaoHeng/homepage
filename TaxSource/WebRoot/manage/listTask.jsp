<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
	<title>调查任务列表</title>
	<link href="static/css/base.css" rel="stylesheet">
	<link rel="stylesheet" href="static/easyui/uimaker/easyui.css">
	<link rel="stylesheet" type="text/css" href="static/easyui/uimaker/icon.css">
	<script type="text/javascript" src="static/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
</head> 
<body>
    <div class="container">
        <!-- 筛选部分 -->
      <div id="tb" style="padding:0 30px;">
      <form id="ff">
        <div class="conditions">
            <span class="con-span">纳税人识别号: </span><input class="easyui-textbox" type="text" name="payerCode" style="width:166px;height:35px;line-height:35px;">
            <span class="con-span">纳税人名称: </span><input class="easyui-textbox" type="text" name="payerName" style="width:166px;height:35px;line-height:35px;">
            <a href="javascript:search();" class="easyui-linkbutton" iconCls="icon-search" data-options="selected:true">查询</a>
            <a href="javascript:reset();" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
            <a href="javascript:void(0);" class="easyui-linkbutton more" iconCls="icon-more">更多</a>
        </div>
        <div class="conditions hide" style="display: none">
            <span class="con-span">税务机关: </span>
            <select id="organId" style="width:166px;height:35px;line-height:35px;">
            	<option value=-1>请选择税务机关</option>
            </select>
            <span class="con-span">任务开始时间: </span><input class="easyui-datebox" type="text" name="startDate" style="width:166px;height:35px;line-height:35px;">
            <span class="con-span">任务结束时间: </span><input class="easyui-datebox" type="text" name="endDate" style="width:166px;height:35px;line-height:35px;">
            <span class="con-span">行业: </span>
            <select id="industryId" style="width:166px;height:35px;line-height:35px;">
            	<option value=-1>请选择行业</option>
            </select>
        </div>
      </form>
      </div>
      <!-- 调查任务展示表格 -->
       <table id="taskTable" style="width:100%"></table>
    </div>
    <script type="text/javascript">
	    $(function(){
		    $("#taskTable").datagrid({
		    	rownumbers:true,
                singleSelect:false,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                checkOnSelect:false,
                selectOnCheck:false,
                collapsible:true,
                toolbar:'#tb',
                pageSize:10,
                url:"listTask.do",
                columns:[[
                	{ field:"taskName", width:"110", title: '任务名称' },
                    { field:"payerCode", title: '纳税人识别号' },
                    { field:"payerName", width:"180", title: '纳税人名称' },
                    { field:"industryName", width:"160", title: '行业' },
                    { field:"bizScope", width:"130", title: '经营范围' },
                    { field:"executeTime", title: '执行时间' },
                    { field:"recordTaskDate", title: '录入时间' },
                    { field:"overDays", width:"105", align:'center', title: '录入超时(天)' },
                    { field:"operation", width:"105", title: '操作',
                        formatter: function(value, rowData, index) {
                            return "<a href='javascript:remove("+rowData.id+")'>删除</a> " + 
                            "<a href='javascript:edit("+rowData.id+")'>修改</a> "+
                            "<a href='javascript:look("+rowData.id+")'>查看详情</a> "
                       	}
                    }
                ]]
			})
			
		    /* 点击更多，实现隐藏与现实其他的条件查询按钮 */
	        $(".more").click(function(){
	            $(".hide").toggle();
	        });

	        /* 生成税务机关列表 */
	        $.post("getOrgan.do", {},function(data) {
		        $.each(data, function(index, val) {
		        	 $("#organId").append("<option value='"+val.id+"'>"+val.organName+"</option>");
			    })
		    })

		    /* 生成行业下拉列表 */
		    $.post("getIndustry.do", {}, function(data) {
			    $.each(data, function(index, val) {
			    	$("#industryId").append("<option value='"+val.id+"'>"+val.industryName+"</option>");
				})
			})
		    
	    });

	    function doSearch() {
		    $("#taskTable").datagrid('load',{
			    payerCode: $("input[name=payerCode]").val(),
			    payerName: $("input[name=payerName]").val(),
		    	organId: $("#organId").val(),
		    	industryId: $("#industryId").val(),
			    startDate: $("input[name=startDate]").val(),
			    endDate: $("input[name=endDate]").val()
			})
		}
		
		/* 点击查询 */
		function search() {
			doSearch();
		}

		/* 点击重置 */
		function reset() {
			$("#ff").form('clear');
		}

		/* 点击删除 */
		function remove(id) {
			$.messager.confirm("提示", "确认删除？", function(data) {
				if(data) {
					$.post(
						"removeTask.do?id="+id,
						{},
						function(data) {
							parent.$.messager.alert("提示",data.msg, "info", function() {
								if(data.success) {
									doSearch();
								}
							});
						},
						"json"
					)
				}
			})
		}

		/* 点击修改 */
		function edit(id) {
			location.href="manage/editTask.jsp?id="+id;
		}

		/* 点击查看详情 */
		function look(id) {
			openTopWindow({
				width:1000,
				height:600,
				title:"查看税务人员信息",
				url:"manage/lookTask.jsp?id="+id
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
