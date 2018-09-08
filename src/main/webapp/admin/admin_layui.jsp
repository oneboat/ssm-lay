<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>   
<html>
<head>
  <title>管理平台</title>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
</head>
<style>
.layui-tab-content {
    padding: 3px;
}
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">后台管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <!-- <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <li class="layui-nav-item"><a href="">设备</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child layui-anim layui-anim-upbit">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li>
    </ul> -->
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="<%=basePath %>js/respic/initpic.jpg" class="layui-nav-img">
          	
        </a>
        <dl class="layui-nav-child">
          <dd><a href="#" id="001" data-url="<%=basePath %>systemPages/personal/personalData.jsp" data-id="001" class="site-demo-active">基本资料</a></dd>
          <dd><a href="#" id="002"  data-id="002" class="site-demo-active">修改密码</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="<%=basePath %>user/logout.do">退出</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
        <shiro:hasRole name="R001">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">系统管理</a>
          <dl class="layui-nav-child">
            <shiro:hasPermission name="P001_0A_USER">
            	<dd><a href="#" id="101" data-url="<%=basePath %>systemPages/user/user-list.jsp" data-id="101" class="site-demo-active">用户管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0A_ROLE">
            	<dd><a href="#" id="102" data-url="<%=basePath %>systemPages/role/role-list.jsp" data-id="102" class="site-demo-active">角色管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0A_PERMS">
            	<dd><a href="#" id="103" data-url="<%=basePath %>systemPages/permission/per-list.jsp" data-id="103" class="site-demo-active">权限管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0A_LOG">
            <dd><a href="#" id="104" data-url="<%=basePath %>systemPages/logs/logs-list.jsp" data-id="104" class="site-demo-active">日志管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0A_FUNCS">
            <dd><a href="#" id="105" data-url="<%=basePath %>folder.jsp" data-id="105" class="site-demo-active">查看系统功能</a></dd>
          	</shiro:hasPermission>
          </dl>
        </li>
        </shiro:hasRole>
        <li class="layui-nav-item">
          <a >业务管理</a>
          <dl class="layui-nav-child">
            <shiro:hasPermission name="P001_0B_DEVICE">
            	<dd><a href="#" id="201" data-url="<%=basePath %>projectPages/device/device-list.jsp" data-id="201" class="site-demo-active">设备管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0B_HOSPITAL">
            	<dd><a href="#" id="202" data-url="<%=basePath %>projectPages/hospital/hospital-list.jsp" data-id="202" class="site-demo-active">医院管理</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0B_CREC">
            	<dd><a href="javascript:;">医疗记录</a></dd>
            </shiro:hasPermission>
            <shiro:hasPermission name="P001_0B_SUFFERER">
            	<dd><a href="javascript:;">患者信息</a></dd>
            </shiro:hasPermission>
          </dl>
        </li>
        <li class="layui-nav-item">
        <a href="javascript:;">统计报表</a>
         <dl class="layui-nav-child">
            <dd><a href="javascript:;">设备数据报表</a></dd>
            <dd><a href="javascript:;">患者诊疗报表</a></dd>
            <dd><a href="javascript:;">数据应用报表</a></dd>
          </dl>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div class="layadmin-tabsbody-item layui-show">
	    <div class="layui-tab layui-tab-card" lay-filter="demo" lay-allowClose="true">
		    <ul class="layui-tab-title"></ul>
	    	<div class="layui-tab-content"></div>
		</div>				
    </div>
      
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
  </div>
</div>
 <script src="<%=basePath %>js/layui/layui.all.js" charset="utf-8"></script>
<script>
//JavaScript代码区域
layui.use('element', function() {
            var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
            var layer = layui.layer;
            var $ = layui.jquery;
          //触发事件
            var active = {
                  tabAdd: function (url,id) {
                	  var iftimeout = getTimoeOutInfo();
                	  if(iftimeout == "0"){
                		  layer.msg("登录过期，请重新登录!",{time:1000},function(){
                			  window.location.href="<%=basePath%>login3.jsp";
                		  });
                	  }else{
                        //新增一个Tab项
                        var name=document.getElementById(id).innerHTML;
                        element.tabAdd('demo', {
                            title: name //用于演示
                          , content: '<iframe data-frameid="'+id+'" frameborder="0" class="layadmin-iframe" name="content"  width="100%" src="' + url + '"></iframe>'
                          , id: id //实际使用一般是规定好的id，这里以时间戳模拟下
                        })
                        active.tabChange(id);
                        FrameWH();//计算框架高度
                	  }
                  },tabChange: function (id) {
                	  var iftimeout = getTimoeOutInfo();
                	  if(iftimeout == "0"){
                		  layer.msg("登录过期，请重新登录!",{time:1000},function(){
                			  window.location.href="<%=basePath%>login3.jsp";
                		  });
                	  }else{
	                      //切换到指定Tab项
	                      element.tabChange('demo', id); //切换到id
	                      $("iframe[data-frameid='"+id+"']").attr("src",$("iframe[data-frameid='"+id+"']").attr("src"))//切换后刷新框架
                	  }
                  },tabDelete: function (id) {
                        element.tabDelete("demo", id);//删除
                  },tabDeleteAll: function (ids) {//删除所有
                        $.each(ids, function (i,item) {
                            element.tabDelete("demo", item);
                        })
                    }
                };
            $(".layui-nav-child a").click(function () {
                var dataid = $(this);
                if(dataid.attr("data-id") == "002"){
                	layer.open({
		    		  type: 2, 
		    		  title:'修改密码',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>systemPages/user/user-pwdchange.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: false,
			          mask:true,
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }
			          });
                }else{
                	if ($(".layui-tab-title li[lay-id]").length <= 0) {
                        active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"));
                    } else {
                        var isData = false;
                        $.each($(".layui-tab-title li[lay-id]"), function () {
                            if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                                isData = true;
                            }
                        })
                        if (isData == false) {
                            active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"));
                        }
                    }
                    active.tabChange(dataid.attr("data-id"));
                }
            });
            $(".rightmenu li").click(function () {
                if ($(this).attr("data-type") == "closethis") {
                    active.tabDelete($(this).attr("data-id"))
                } else if ($(this).attr("data-type") == "closeall") {
                    var tabtitle = $(".layui-tab-title li");
                    var ids = new Array();
                    $.each(tabtitle, function (i) {
                        ids[i] = $(this).attr("lay-id");
                    })

                    active.tabDeleteAll(ids);
                }

                $('.rightmenu').hide();
            });
            function FrameWH() {
                var h = $(window).height() -41- 10 - 60 -10-44 -10;
                $("iframe").css("height",h+"px");
            }
     
            $(window).resize(function () {
                FrameWH();
            })
            function getTimoeOutInfo(){
            	var timeOut;
            	$.ajax({
          			url:"<%=basePath %>user/getSessionInfor.do",
          			async:false,
          			success:function(data){
          				obj = JSON.parse(data);
          				console.info("session是否过期："+obj.ifTimeout);
          				 timeOut = obj.ifTimeout;
          				}
          			});
            	return timeOut;
            }
});


</script>
</body>
</html>