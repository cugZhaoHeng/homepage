<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="shortcut icon" href="static/images/dollar.ico"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="/TaxSource/">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>河南省金税三期税源信息管理系统</title>
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/platform.css">
    <link rel="stylesheet" href="static/easyui/uimaker/easyui.css">
    <link href="static/easyui/uimaker/icon.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="static/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/js/main.js"></script>
</head>
<body>
    <div class="container">
    	<!--页面的头部信息  -->
        <div id="pf-hd">
            <div class="pf-logo">
               <div class="system-name">税源信息管理系统</div>
            </div>
            <!--顶部用户信息-->
            <div class="pf-user">
                <!--用户头像-->
                <div class="pf-user-photo">
                    <img src="static/images/main/user.png" alt="">
                </div>
                <!--用户名-->
                <h4 class="pf-user-name ellipsis"><label id="taxerName">${sessionScope.username }</label></h4>
                <i class="iconfont xiala">&#xe607;</i>
                <!-- 头部用户信息 下拉菜单 -->
                <div class="pf-user-panel">
                    <ul class="pf-user-opt">
                        <li>
                            <a href="javascript:void(0);">
                                <i class="iconfont">&#xe60d;</i>
                                <span class="pf-opt-name personInfo">用户信息</span>
                            </a>
                        </li>
                        <li class="pf-modify-pwd">
                            <a href="javascript:void(0)">
                                <i class="iconfont">&#xe634;</i>
                                <span class="pf-opt-name updatePassword">修改密码</span>
                            </a>
                        </li>
                        <li class="pf-logout">
                            <a href="javascript:void(0);">
                                <i class="iconfont">&#xe60e;</i>
                                <span class="pf-opt-name exit">退出</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div><!-- 头部用户信息结束 -->

        <!-- 中间部分，也是主体部分 -->
        <div id="pf-bd">
        	<!-- 左侧边侧滑菜单 -->
            <div id="pf-sider">
                <!-- 系统菜单 标题-->
                <h2 class="pf-model-name">
                    <span class="iconfont">&#xe64a;</span>
                    <span class="pf-name">系统菜单</span>
                    <span class="toggle-icon"></span>
                </h2>
                <!-- 侧滑菜单开始 -->
                <ul class="sider-nav">
                     <!--<li class="current">-->
                    <li>
                        <a href="javascript:addTab('纳税人管理','manage/listPayer.jsp');">
                            <span class="iconfont sider-nav-icon">&#xe620;</span>
                            <span class="sider-nav-title">纳税人管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe625;</span>
                            <span class="sider-nav-title">调查任务管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                            <li class="active"><a href="javascript:addTab('任务查询','manage/listTask.jsp')">调查任务查询</a></li>
                            <li><a href="javascript:addTab('调查任务录入','manage/addTask.jsp')">调查任务录入</a></li>
                            <li><a href="javascript:addTab('未调查企业统计','manage/statistical.jsp')">未被调查企业统计</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe62f;</span>
                            <span class="sider-nav-title">系统管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li class="active"><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">用户管理</a></li>
                           <li><a href="javascript:mention();">角色管理</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">模块管理</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">字典管理</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">登录日志</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe647;</span>
                            <span class="sider-nav-title">组织管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li class="active"><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">组织结构</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">区域管理</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/mention.jsp')">岗位管理</a></li>
                           <li><a href="javascript:addTab('税务人员管理', 'manage/listTaxer.jsp')">员工管理</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe611;</span>
                            <span class="sider-nav-title">个人信息</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                         <ul class="sider-nav-s">
                             <li class="active"><a class="personInfo">个人基本信息</a></li>
                             <li><a  class="updatePassword">密码修改</a></li>
                             <li ><a href="javascript:void(0);" class="exit">退出系统</a></li>
                         </ul>
                     </li>
                 </ul>
            </div>

			<!-- 右侧显示部分 -->
            <div id="pf-page">
                <div class="easyui-tabs1" style="width:100%;height:100%;">
                  <div title="首页" style="padding:10px 5px 5px 10px;">
                    <iframe class="page-iframe" src="manage/home.html" frameborder="no"   border="no" height="100%" width="100%" scrolling="auto"></iframe>
                  </div>
                </div>
            </div>
        </div>
		
		<!-- 页面底部信息 -->
        <div id="pf-ft">
            <div class="system-name">
              <i class="iconfont">&#xe6fe;</i>
              <span>税源信息管理系统&nbsp;v1.0</span>
            </div>
            <div class="copyright-name">
              <span>CopyRight&nbsp;2017&nbsp;&nbsp;zhidisoft.com&nbsp;版权所有</span>
              <i class="iconfont" >&#xe6ff;</i>
            </div>
        </div>
    </div>
   <div id="topWindow"></div>
 
<script type="text/javascript">
    
    $(function(){
        /* 通过session中的taxerId，显示登录用户的姓名 */
        $.post("getTaxer.do",{},function(data){
            $.each(data, function(index, val) {
                if(val.id == "${sessionScope.taxerId}") {
                    $("#taxerName").html(val.taxerName);
                }
            })
        })
        
	    /* 点击查看个人信息 */
	    $(".personInfo").on("click", function(e){
	    	 openTopWindow({
	             width : 1000,
	             height : 500,
	             title : "查看个人信息",
	             url : "manage/lookPersonInfo.jsp"
	         })
	    });
	    
	    /* 点击修改密码 */
	    $(".updatePassword").on("click", function(){
	    	openTopWindow({
	            width : 700,
	            height : 500,
	            title : "修改密码",
	            url : "manage/updatePassword.jsp"
	        })
	    });
	   
	  	//点击退出
    	$(".exit").on("click",function(e){
        	$.messager.confirm({
            	title: "提示",
            	msg: "确认退出？",
            	width: 300,
            	height: 160,
            	fn: function(data) {
                	if(data) {
                    	window.location.href="login.jsp";
                    }
                }
            })
           
        });
	
	    $('.easyui-tabs1').tabs({
	      tabHeight: 44,
	      onSelect:function(title,index){
	        var currentTab = $('.easyui-tabs1').tabs("getSelected");
	        if(currentTab.find("iframe") && currentTab.find("iframe").size()){
	            currentTab.find("iframe").attr("src",currentTab.find("iframe").attr("src"));
	        }
	      }
	    });
    });
    
    function addTab(title, url){
	   /* 功能是第一次点击打开tab页就打开一个tab页，当没关闭这个tab页，又去另外一个tab页操作，再回来刚才的tab页后就不用打开另外一个和刚才一样的tab页，而是同一个tab页。 */
        if ($('.easyui-tabs1').tabs('exists', title)){
            $('.easyui-tabs1').tabs('select', title);
        } else {
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
            $('.easyui-tabs1').tabs('add',{
                title:title,
                content:content,
                closable:true
            });
        }
    }
   
    /* 打开在父窗口中打开window */
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
           content : "<iframe scrolling='no' frameborder='0' border='0' height='100%' width='100%' src='"+options.url+"'></iframe>",
           modal:true,
           resizable:false,
           collapsible:false
       });
   }
   function mention() {
	   
	}
    </script>
</body> 
</html>
