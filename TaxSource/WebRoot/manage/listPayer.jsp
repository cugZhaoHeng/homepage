<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <div class="container">
     <div id="tb" style="padding:0 30px;">
        	纳税人识别号: <input type="text" id="payerCode" name="payerCode" style="width:166px;height:35px;line-height:35px;"/>
        	纳税人名称: <input type="text" id="payerName" name="payerName" style="width:166px;height:35px;line-height:35px;"/>
        	<a href="javascript:search()" id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        	<a href="javascript:reset();" id="setBtn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
        	<a href="javascript:add()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加纳税人</a>
      </div> 
      <table id="dg"></table>
    </div>
    <div id="d1"></div>
    <script type="text/javascript">
		$(function(){
			$("#dg").datagrid({
				title:"纳税人列表",
				striped:true,
				pagination:true,
				pageNumber:1,
				pageList:[2,5,10,20,30],
				rownumbers:true,
				pagePosition:"top",
				url:"listPayer.do",
				columns:[[
					{field:"payerCode", title: '纳税人识别号'},
					{field:"payerName", title: '纳税人名称'},
					{field:"organName", title: '所属税务机关'},
					{field:"industryName", title: '所属行业'},
					{field:"legalPerson", title: '法人代表'},
					{field:"legalIdCard", title: '法人身份证号码'},
					{field:"finaceName", title: '主管财务'},
					{field:"finaceIdCard", title: '财务身份证号码'},
					{field:"taxerName", title: '办税人员'},
					{field:"recordDate", title: '录入日期'},
					{field:"option", title: '操作',
						formatter: function(value,rowData,index){
							 return "<a href='javascript:void(0)' onclick='removeTaxPayer("+rowData.id+")'>删除   </a>"
			                    +"<a href='javascript:void(0)' onclick='editTaxPayer("+rowData.id+")' >修改  </a>"
			                    +"<a href='javascript:void(0)' onclick='lookTaxPayer("+rowData.id+")' >查看详情  </a>"
							
						}
					}
				]]
			});

		});
		
		/* doSerch函数，在每次执行完对数据库的操作之后刷新数据表 */
	 	function doSearch() {
	 		$('#dg').datagrid('load', {
	 		    payerCode: $("#payerCode").val(),
	 		    payerName: $("#payerName").val()
	 		});
		}

		/* 点击查询按钮 */
		function search() {
			doSearch();
		}

	 	/* 点击重置按钮，重置按钮如果要生效，则input标签不能使用easyUI的样式，必须为原生的HTML标签 */
	 	function reset() {
	 		$("#payerCode").val("");
			$("#payerName").val("");
		}
		
	 	/* 点击添加按钮 */
		function add() {
			openTopWindow({
                width : 1000,
                height : 600,
                title : "新增纳税人",
                url : "manage/addPayer.jsp"
            })
            parent.$("#topWindow").window({
	              onBeforeClose: function() {
		              doSearch();
	              }
            })
		}
        /* 点击删除执行的函数 */
		function removeTaxPayer(id) {
			$.messager.confirm("警告", "确认删除？", function(data){
				if(data) {
					$.post(
						"removePayer.do?id="+id,
						$(this).serialize(),
						function(data) {
							parent.$.messager.alert("提示",data.msg, "info", function() {
								if(data.success == true) {
									doSearch();
								}
							});
						},
						"json"
					);
				}
			})
		}
		
		/* 点击修改执行的 函数 */
		function editTaxPayer(id) {
			 openTopWindow({
				width:1000,
				height:600,
				title:"修改纳税人信息",
				url:"manage/editPayer.jsp?payerId="+id
			})
	        parent.$('#topWindow').window({
	            onBeforeClose:function(){ 
	            	doSearch();
	            }
	        });
		}
		
		/* 点击查看详情执行的函数 */
		function lookTaxPayer(id) {
			 openTopWindow({
				width:1000,
				height:600,
				title:"查看纳税人信息",
				url:"manage/lookPayer.jsp?id="+id
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
