<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Insert title here</title>
<link href="static/css/index.css" rel="stylesheet">
<%@include file="../script.html"%>
</head>
<body>
	<div class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'north'" id="north">
			<div class="north-user">
				<div class="north-user-photo">
					<img alt="" src="static/images/user.png">
				</div>
				<div class="north-user-username">
					<a class="easyui-menubutton" data-options="plain:true, menu:'#user'">${sessionScope.userName }</a>
					<div id="user">
						<div id="userinfo"><i class="iconfont">&#xe6cb;</i><a href="javascript:addTab('个人信息', 'jsp/lookUserinfo.jsp')">个人信息</a></div>
						<div><i class="iconfont" id="editPassword">&#xe8fd;</i><a href="javascript:addTab('修改密码', 'jsp/editPassword.jsp')">修改密码</a></div>
						<div><i class="iconfont" id="exit">&#xeae2;</i><a href="login.jsp">退出</a></div>
					</div>
				</div>
			</div>
		</div>
		<div data-options="region:'south',split:true" style="height: 50px;"></div>
		<div data-options="region:'east',split:true" title="East"
			style="width: 100px;"></div>
		<div data-options="region:'west',split:true, collapsible:false" id="west" title="小功能" style="width: 100px;">
			<div class="selecion-btn">
				<a href="javascript:addTab('蚂蚁森林', 'jsp/antForest.jsp')" class="easyui-linkbutton" data-options="text:'蚂蚁森林', selected:true"></a>
				
			</div>
			
		</div>
		<div data-options="region:'center'">
			<!-- 中间的面板显示标签页，默认为首页home.jsp -->
			<div class="easyui-tabs" id="tabs" style="width:100%; height:100%;">
				<div title="首页" style="padding:10px 5px 5px 10px;">
                    <iframe src="jsp/editUser.jsp" frameborder="0" height="100%" width="100%" scrolling="auto"></iframe>
                </div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function(){
		
	})
	
	/* 添加选项卡 */
	function addTab(title, url) {
		if($("#tabs").tabs('exists', title)) {
			return;
		} else {
			var content = "<iframe scrolling='auto' frameborder='0' src='"+url+"' style='width:100%; height:100%;'> </iframe>";
			$("#tabs").tabs('add', {title: title, closable:true, content:content});
		}
	}
	
	
</script>
</html>