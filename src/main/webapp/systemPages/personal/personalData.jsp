<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人资料</title>
</head>
<style>
	.grid-demo-bg1{
		background:green;
	}
	img{
		width:200px;
		height:260px;
	}
	.label_info{
		margin:40px 10px 0 20px;
	}
	label{
		font-size:16px;
	}
</style>

<body>
<div  class="layui-layout-body">
<div id = "content" class="layui-col-md10  layui-col-md-offset1">
	<div class="layui-row layui-col-space1">
	  <div class="layui-col-md4">
	    	<div class="layui-col-md8  layui-col-md-offset2">
	    		<a href="javascript:;">
		          <img src="<%=basePath %>js/respic/initpic.jpg">
		        </a>
		        <button class="layui-btn" lay-submit="" data-type="editInfo" >编辑资料</button>
	  		</div>
	  </div>
	  <div class="layui-col-md8">
	    <div class="layui-row grid-demo">
	      <div class="layui-col-md5">
		      <div class="label_info">名称：<label id="name"></label></div><br>
		      <div class="label_info">用户名：<label id="username"></label></div><br>
		      <div class="label_info">电话：<label id="phone"></label></div>
		      <div class="label_info">邮箱：<label id="email"></label></div>
	      </div>
	       <div class="layui-col-md7">
		      <div class="label_info">角色：<label id="ident"></label></div><br>
		      <div class="label_info">证件号：<label id="cardid"></label></div><br>
		      <div class="label_info">地址：<label id="address"></label></div>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="layui-row grid-demo">
		<div class="layui-col-md10  layui-col-md-offset1">
	        	简介：
	      </div>
	</div>
</div>
</div>
</body>
<script>
layui.use(['layer', 'form'], function(){
  var layer = layui.layer
  ,form = layui.form;
  
  var $ = layui.$, active = {
		  editInfo: function(){ //获取选中数据
		        var checkStatus = table.checkStatus('perTable')
		        ,data = checkStatus.data;
		        layer.alert(JSON.stringify(data));
		      }
	    };
  $.ajax({
      url: '<%=basePath %>user/getPersonalInfo.do',
      type:'post',
      success: function (info) {
          var data_info = JSON.parse(info);
    	  console.info(data_info);
    	  $("label[id='name']").html(data_info.name);
    	  $("label[id='username']").html(data_info.username);
    	  $("label[id='phone']").html(data_info.phone);
    	  $("label[id='ident']").html(data_info.ident);
    	  $("label[id='cardid']").html(data_info.cardid);
    	  $("label[id='address']").html(data_info.address);
    	  $("label[id='email']").html(data_info.email);
      }
  });
$('.layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

});
</script> 
</html>