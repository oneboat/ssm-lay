<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<style>
	.layui-form-item{
		margin:40px auto;
	}
</style>
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<div class="layui-container">
	<div class="layui-col-sm9">
		    <form class="layui-form" action="">
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">新密码</label>
			    <div class="layui-input-inline">
			      <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
			    </div>
			    <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">确认密码</label>
			    <div class="layui-input-inline">
			      <input type="password" name="password2" lay-verify="pass2" placeholder="请确认密码" autocomplete="off" class="layui-input">
			    </div>
			    <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
			  </div>
			  
			 
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="sub_pwdChange">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
			  </div>
			</form>
		</div>  
</div>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  $ = layui.$;
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
 form.verify({
   pass: [/(.+){6,12}$/, '密码必须6到12位']
   ,pass2:[/(.+){6,12}$/, '密码必须6到12位']
   ,pass2:function(value){
		 if(value != $("input[name='password']").val()){
		    $("input[name='password']").val("");
		    $("input[name='password2']").val("")
			return "两次密码输入不一致，请重新输入！";
 		}
  	}
 }); 
  
  //监听指定开关
  form.on('switch(switchTest)', function(data){
    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
      offset: '6px'
    });
    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
  });
  
  //监听提交
   form.on('submit(sub_pwdChange)', function(data){
	       var npsw = $("input[name='password']").val();
		   $.ajax({
		          url: '<%=basePath %>user/show/pwdChange.do',
		          type: 'POST',
		          data: 'npsw='+npsw,
		          success: function (info_data) {
		        	  var index = parent.layer.getFrameIndex(window.name);
		  			  //parent.layer.close(index);//关闭当前页
		  			 // window.parent.location.replace(location.href)//刷新父级页面
		  			 console.info(info_data);
		  			  var layData = JSON.parse(info_data);
		  			 console.info(layData);
		 			layer.msg(layData.msg,{time:1500},function(){
		            	  window.parent.location.reload();//刷新父级页面
			  			  parent.layer.close(index);//关闭当前页
		              });
		          }
		      });
		  return false;
  }); 
 
  //表单初始赋值
  /* form.val('example', {
    "username": "贤心" // "name": "value"
    ,"password": "123456"
    ,"interest": 1
    ,"like[write]": true //复选框选中状态
    ,"close": true //开关状态
    ,"sex": "女"
    ,"desc": "我爱 layui"
  }) */
  
  
});

</script>
