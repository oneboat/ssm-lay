<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<base href="<%=basePath%>">
<title>管理中心</title>
<%@include file="/jsp_use.jsp"%>
<style>
	a{
		text-decoration:none;
	}
</style>
</head>
<script type="text/javascript" charset="utf-8">
  	function open1(plugin){
  		$.ajax({
  			url:"<%=basePath %>getSessionInfor.do",
  			async:false,
  			success:function(data){
  				obj = JSON.parse(data);
  				console.info("session是否过期："+obj.ifTimeout);
  				if(obj.ifTimeout == "0"){
  					$.messager.alert("过期提示","session已经过期，请重新登录！","info",function(){
  						$(location).attr("href", "login.jsp");
  					});
  				}else{
  					var obj=null;
					$.ajax({
						url:"<%=basePath %>"+plugin+".do",
						type:"POST",
						dateType:"JSON",
						async:false,
						success:function(data){
							obj = JSON.parse(data);
						}
					}); 
			  		if ($('#tt').tabs('exists',obj.title)){
						$('#tt').tabs('select',obj.title);
						var tab = $('#tt').tabs('getSelected');  // 获取选择的面板
						tab.panel('refresh');          //刷新数据
			  		}else{
				  		$('#tt').tabs('add',{
									id:plugin,
									href:obj.address+".jsp",
									title:obj.title,
									closable:true
						});
					}
  				}
  			}
  		});
  		
	}
  </script>
<body id="cc" class="easyui-layout">
	<div data-options="region:'north',split:false" style="height: 16%;">
		<div style="font-size: 30px;top: auto;bottom: 2px;left: 2px;position:absolute;">
			欢迎使用综合管理系统
		</div>
		<div style="width: 180px; height: 20px; float: right">
			<div><span>欢迎您：${user.name }&nbsp;&nbsp;${user.ident }</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=basePath %>logout.do">退出</a></div>
			<div style="width: 200px; height: 20px; float: right;top: auto;bottom: 2px;right: 2px;position:absolute;">
				<a href="<%=basePath%>admin/admin_layui.jsp">layui风格界面</a>&nbsp;&nbsp;
				<a href="<%=basePath%>admin/admin_dwz.jsp">dwz风格界面</a>
			</div>
			
		</div>
	</div>

	<div data-options="region:'south',split:false" style="height: 10%;">
		<div
			style="height: 20px; width: 200px; margin-top: 1%; margin-left: 50%">
			友情链接：<a href="http:\\www.baidu.com" target="_blank">百度一下</a>
		</div>
	</div>
	<div data-options="region:'west',title:'导航菜单',split:false"
		style="width: 200px;">
		<div id="menu" class="easyui-accordion" fit="true" border="false">
			<shiro:hasRole name="R001">
			<div title="系统管理" data-options="iconCls:'icon-folder',selected:true" style="overflow: auto;">
				<ul class="easyui-tree">
					<li><span><a target="mainFrame" onClick="open1('system/systemInfo')">系统信息</a></span></li>
					<li><span><a onClick="open1('system/userManage')">用户管理</a></span></li>
					<li><span><a onClick="open1('system/roleManage')">角色管理</a></span></li>
					<li><span><a onClick="open1('system/perManage')">权限管理</a></span></li>
					<li><span><a onClick="open1('system/functionList')">查看系统功能</a></span></li>
				</ul>
			</div>
			</shiro:hasRole>
			<div title="业务管理" data-options="iconCls:'icon-folder'">
				<ul class="easyui-tree">
					<shiro:hasAnyRoles name="R001,R002,R002_001"><li><span><a target="mainFrame" onClick="open1('show/studentListPage')">学生管理</a></span></li></shiro:hasAnyRoles>
					<li><span><a onClick="open1('show/personalPage')">个人信息</a></span></li>
					<li><span><a onClick="open1('friends/friendsPage')">好友列表</a></span></li>
					<li><span><a onClick="open1('vedio/vedioPage')">视频音乐</a></span></li>
				</ul>
			</div>
			<div title="游戏娱乐" data-options="iconCls:'icon-folder'">
				<ul class="easyui-tree">
					<li><span><a onClick="open1('show/gamePage')">俄罗斯方块</a></span></li>
					<li><span><a onClick="">贪吃蛇</a></span></li>
					<li><span><a onClick="">连连看</a></span></li>
				</ul>
			</div>
		</div>
	</div>

	<div id="center" data-options="region:'center'"
		style="background: #eee;">
		<div id="tt" class="easyui-tabs tabs-container easyui-fluid"
			fit="true" border="false" plain="true">
			<div title="主页" fit="true">
				<div id="sop">
					<span>欢迎使用SSM3+EASYUI系统</span>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$(".easyui-tree").tree({lines:true});
	});
</script>