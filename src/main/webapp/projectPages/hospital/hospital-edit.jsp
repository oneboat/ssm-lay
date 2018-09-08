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
			<input type="hidden" name="hpcode">
		    <form class="layui-form" action="">
			  <div class="layui-form-item">
			    <label class="layui-form-label">医院名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="hpname" lay-verify="title" autocomplete="off" placeholder="请输入名称" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">联系电话</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="hptel" lay-verify="required|tel" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label">邮箱</label>
			      <div class="layui-input-inline">
			        <input type="text" name="hpemail" lay-verify="email" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">地址</label>
			      <div class="layui-input-inline">
			        <input type="text" name="addressDetail"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			   <!--  <div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="createtime" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
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
			    <label class="layui-form-label">已有账号</label>
			    <div class="layui-input-block">
			      <input type="radio" name="hasUser" lay-filter="overRadio"  value="1" title="是">
			      <input type="radio" name="hasUser" lay-filter="overRadio"  value="0" title="否"  checked="">
			      <input type="radio" name="hasUser" value="禁" title="禁用" disabled="">
			    </div>
			  </div>
			  <div class="userOptions layui-form-item" style="display:none;">
			    <label class="layui-form-label">账号绑定</label>
			    <div class="layui-input-block">
			      <select id="hpcodeData" name="hpcode" lay-filter="required">
			        <option value="">请选择</option>
			      </select>
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
  var hpcode = $("input[name='hpcode']").val();
  setTimeout(function(){
		getUserSelect();
		if($("input[name='hasUser']").val() == "1"){
			$(".userOptions").css("display","block");
		}else{
			$(".userOptions").css("display","none");
		}
	},500);

  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  /* 
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
  }); */
  
  //监听指定开关
  form.on('switch(switchTest)', function(data){
    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
      offset: '6px'
    });
    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
  });
  //监听单选按钮
  form.on('radio(overRadio)', function (data) {
      var hasUser = data.value;//判断单选框的选中值
      if(hasUser == "1"){
    	  $(".userOptions").css("display","block");
    	  getUserSelect();
      }else{
    	  $(".userOptions").css("display","none");
    	  $("#hpcodeData").empty();
    	  $("#hpcodeData").append("<option value=''>请选择</option>");
      }
  });

  //监听提交
   form.on('submit(sub_addUser)', function(data){
	  $.ajax({
          url: '<%=basePath %>hospital/show/editHospital.do',
          type: 'POST',
          data: data.field,
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
  //获取选项下拉列表
   function getUserSelect(){
		 $.ajax({
	         url: '<%=basePath %>user/getUsers.do',
	         type: 'POST',
	         success: function (info_data) {
	       	  var obj_data = JSON.parse(info_data).data;
	       	  $.each(obj_data,function(i){
	       		  var option_Data;
	         		  if(obj_data[i].username == hpcode){
		          		  option_Data="<option value='"+obj_data[i].username+"' selected='selected'>"+obj_data[i].name+"</option>";
	         		  }else{
	         			  option_Data="<option value='"+obj_data[i].username+"'>"+obj_data[i].name+"</option>";
	         		  }
	         		  $("#hpcodeData").append(option_Data);
	         		  form.render('select');
	       	  });
	         }
	     });
	}
});

</script>
