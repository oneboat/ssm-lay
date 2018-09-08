<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<body>
<div class="layui-container">
	<div class="layui-col-sm9">
		    <form class="layui-form" action="">
		    	<input id="id" name="id" type="hidden">
			  <div class="layui-form-item">
			    <label class="layui-form-label">用户名</label>
			    <div class="layui-input-block">
			      <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">手机</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label">邮箱</label>
			      <div class="layui-input-inline">
			        <input type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">地址</label>
			      <div class="layui-input-inline">
			        <input type="text" name="address"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <!-- <div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div> -->
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">证件号</label>
			    <div class="layui-input-block">
			      <input type="text" name="cardid" placeholder="" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <!-- <div class="layui-form-item">
			    <label class="layui-form-label">角色</label>
			    <div class="layui-input-block">
			      <select name="ident" lay-filter="aihao">
			        <option value=""></option>
			        <option value="1">管理员</option>
			        <option value="2" selected="">校长</option>
			        <option value="3">教师</option>
			        <option value="4">学生</option>
			        <option value="5">游客</option>
			      </select>
			    </div>
			  </div> -->
			  <div class="layui-form-item layui-form-text">
			    <label class="layui-form-label">备注</label>
			    <div class="layui-input-block">
			      <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="sub_editUser">立即提交</button>
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
 /*  form.verify({
    title: function(value){
      if(value.length < 3){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
    ,content: function(value){
      layedit.sync(editIndex);
    }
  }); */
  
  //监听指定开关
  form.on('switch(switchTest)', function(data){
    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
      offset: '6px'
    });
    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
  });
  
  //监听提交
   form.on('submit(sub_editUser)', function(data){
	  $.ajax({
          url: '<%=basePath %>user/show/editUser.do',
          type: 'POST',
          data: data.field,
          success: function (info_data) {
        	  var index = parent.layer.getFrameIndex(window.name);
  			  //parent.layer.close(index);//关闭当前页
  			 // window.parent.location.replace(location.href)//刷新父级页面
  			 var data_re = JSON.parse(info_data);
 			layer.msg(data_re.msg,{time:1500},function(){
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
