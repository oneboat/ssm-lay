<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<div class="layui-container">
	<div class="layui-col-sm10">
		    <form class="layui-form" action="" method="post">
		      <input type="hidden" name="pid" id="pid">
			  <div class="layui-form-item">
			    <label class="layui-form-label">父权限名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="pa_pname" disabled="disabled" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">父权限代号</label>
			    <div class="layui-input-block">
			      <input type="text" name="pa_pcode" disabled="disabled" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">权限名称</label>
			      <div class="layui-input-inline">
			        <input type="text" name="pName" lay-verify="required" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">权限代号</label>
			      <div class="layui-input-inline">
			        <input type="text" name="pCode" lay-verify="required" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">权限URL</label>
			      <div class="layui-input-inline">
			        <input type="text" name="url" lay-verify="required" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">权限等级</label>
			      <div class="layui-input-inline">
			        <input type="number" name="plevel" lay-verify="required" placeholder="1~99" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			   <!-- <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">新增日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="createTime" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
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
			      <button class="layui-btn" lay-submit="" lay-filter="submit_addPermission">立即提交</button>
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
  var $ = layui.$;
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
  form.on('submit(submit_addPermission)', function(data){
	  $.ajax({
          url: '<%=basePath %>permission/addNewPermission.do',
          type: data.form.method,
          data: $(data.form).serialize(),
          success: function (info_data) {
        	  var index = parent.layer.getFrameIndex(window.name);
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
 
});

</script>
