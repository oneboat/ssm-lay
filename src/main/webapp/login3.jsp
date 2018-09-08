<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>"> 
	<title>综合管理系统</title>
	<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
	<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="js/jquery-easyui-1.5.1/themes/default/easyui.css" type="text/css"></link>
	<link rel="stylesheet" href="js/jquery-easyui-1.5.1/themes/icon.css" type="text/css"></link>
	<script type="text/javascript" src="js/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>
	<style>
		.layui-col-sm5{
			top:200PX;
		}
		body{
			background-image:url(js/respic/star1.jpg);
		}
	</style>
</head>
<script type="text/javascript">
		function reloadValidateCode(){
	        $("#validateCodeImg").attr("src","<%=basePath%>user/validateCode.do?data="+ encodeURIComponent(new Date()) + Math.floor(Math.random()*24));
	    }
</script>
<body>
<div class="layui-container">
	<div class="layui-col-sm5 layui-col-md-offset3">
		    <form class="layui-form" action="<%=basePath %>user/show/loginToAdmin.do" method="post">
			  <div class="layui-form-item">
			    <label class="layui-form-label">用户名</label>
			    <div class="layui-input-block">
			      <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">验证码</label>
			    <div class="layui-input-block">
			    	<div class="layui-col-sm4">
				      <input type="text" name="validateCode" lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
			    	</div>
			    	<div class="layui-col-sm2  layui-col-md-offset2">
				      <img  onclick="reloadValidateCode()"  href="javascript:void(0);"  id="validateCodeImg" src="<%=basePath%>user/validateCode.do" />
				    </div>
			    </div>
			    
			  </div>
			  
			 
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="sub_userLogin">登录</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
			  </div>
			</form>
		</div>  
</div>
</body> 
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer ;
	  $ = layui.$;
	  
	  form.on('submit(sub_userLogin)', function(data){
		var code = $("input[name='validateCode']").val();
		$.ajax({
			type:"post",
			url: "<%=basePath %>user/loginTestCode.do", 
		 	data: "code="+code,
			async:false,
			success:function(data){
			var datas = JSON.parse(data);
				var datas = JSON.parse(data);
				console.info(datas.message);
				if(datas.message=="correct"){
					var username = $("input[name='username']").val();
					var password = $("input[name='password']").val();
					$.ajax({
						type:"post",
						url: "<%=basePath %>user/show/login.do?username="+username+"&password="+password, 
						async:false,
						success:function(data){
						var datas = JSON.parse(data);
							var datas = JSON.parse(data);
							console.info(datas.message);
							if(datas.ifsuc=="true"){
								$("form").submit();
							}else{
								layer.confirm('用户名或密码有误，请重新输入！', {
									  btn: ['确定'] //按钮
									}, function(){
										refresh(); 
									});
							}
							
						}
					});
				}else{
					layer.confirm('验证码有误，请重新输入！', {
						  btn: ['确定'] //按钮
						}, function(){
							refresh(); 
						}
					);
					
				}
			}
		});
		return false;
	});
	function refresh(){
	 	location=location; 
	}
	$(function(){
		document.onkeydown=function(event){
			  var e = event || window.event || arguments.callee.caller.arguments[0];
			  if(e && e.keyCode==27){ // 按 Esc 
			    //要做的事情
			   }
			   if(e && e.keyCode==13){ // enter 键
				   login();
			   }
			  }
	});
});
</script>
</html>