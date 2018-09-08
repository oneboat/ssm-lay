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
		    <form class="layui-form" action="<%=basePath %>role/show/addRole.do">
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">角色名称</label>
			      <div class="layui-input-inline">
			        <input type="text" name="rname" lay-verify="required" placeholder="请输入角色名"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">角色代号</label>
			      <div class="layui-input-inline">
			        <input type="text" name="rcode" lay-verify="required" placeholder="请输入角色代号" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">角色等级</label>
			      <div class="layui-input-inline">
			        <input type="number" name="rlevel" lay-verify="required|phone" placeholder="1~99" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			   <!--  <div class="layui-inline">
			      <label class="layui-form-label">新增日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div> -->
			    <div class="layui-form-item">
			    <label class="layui-form-label">状态</label>
			    <div class="layui-input-block">
			      <input type="radio" name="status" value="1" title="有效" checked="">
			      <input type="radio" name="status" value="0" title="无效">
			      <input type="radio" name="status" value="禁" title="禁用" disabled="">
			    </div>
			  </div>
			  <div class="layui-form-item layui-form-text">
			    <label class="layui-form-label">备注</label>
			    <div class="layui-input-block">
			      <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit="" lay-filter="submit_addRole">立即提交</button>
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
  /* form.on('submit(submit_addRole)', function(data){
	  $.ajax({
          url: data.form.action,
          type: data.form.method,
          data: $(data.form).serialize(),
          success: function (info) {
        	  var index = parent.layer.getFrameIndex(window.name);
  			  parent.layer.close(index);//关闭当前页
  			  window.parent.location.replace(location.href)//刷新父级页面
              layer.msg(info);
          }
      });
    return false;
  }); */
 
  //表单初始赋值
  form.val('example', {
    "username": "贤心" // "name": "value"
    ,"password": "123456"
    ,"interest": 1
    ,"like[write]": true //复选框选中状态
    ,"close": true //开关状态
    ,"sex": "女"
    ,"desc": "我爱 layui"
  })
  
  
});

</script>
