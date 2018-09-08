<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<div class="layui-container">
	<div class="layui-col-sm9">
		    <form class="layui-form" action="">
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
			    <!-- <div class="layui-inline">
			      <label class="layui-form-label">年龄</label>
			      <div class="layui-input-inline">
			        <input type="text" name="age" lay-verify="number" autocomplete="off" class="layui-input">
			      </div>
			    </div> -->
			  </div>
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">证件号</label>
			    <div class="layui-input-block">
			      <input type="text" name="cardid"  placeholder="" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">密码</label>
			    <div class="layui-input-inline">
			      <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
			    </div>
			    <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
			  </div>
			  
			  <!-- <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">范围</label>
			      <div class="layui-input-inline" style="width: 100px;">
			        <input type="text" name="price_min" placeholder="￥" autocomplete="off" class="layui-input">
			      </div>
			      <div class="layui-form-mid">-</div>
			      <div class="layui-input-inline" style="width: 100px;">
			        <input type="text" name="price_max" placeholder="￥" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div> -->
			  
			  <div class="layui-form-item">
			    <label class="layui-form-label">角色</label>
			    <div class="layui-input-block">
			      <select name="identnum" lay-filter="aihao">
			        <option value="">请选择</option>
			        <option value="2" >医院管理员</option>
			      </select>
			    </div>
			  </div>
			  <!-- <div class="layui-form-item">
			    <label class="layui-form-label">多选</label>
			    <div class="layui-input-block">
			      <input type="checkbox" name="like[write]" title="写作">
			      <input type="checkbox" name="like[read]" title="阅读" checked="">
			      <input type="checkbox" name="like[game]" title="游戏">
			    </div>
			  </div> -->
			  <!-- <div class="layui-form-item">
			    <label class="layui-form-label">性别</label>
			    <div class="layui-input-block">
			      <input type="radio" name="sex" value="男" title="男" checked="">
			      <input type="radio" name="sex" value="女" title="女">
			      <input type="radio" name="sex" value="禁" title="禁用" disabled="">
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
			      <button class="layui-btn" lay-submit="" lay-filter="sub_addUser">立即提交</button>
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
    title: function(value){
      if(value.length < 3){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
    ,content: function(value){
      layedit.sync(editIndex);
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
   form.on('submit(sub_addUser)', function(data){
	  $.ajax({
          url: '<%=basePath %>user/show/addUser.do',
          type: 'POST',
          data: data.field,
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
