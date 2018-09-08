<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<div class="layui-container">
	<input name="dvbelongcode" type="hidden">
	<div class="layui-col-sm9">
		    <form class="layui-form" action="">
				<input id="id" name="id" type="hidden">
			  <div class="layui-form-item">
			    <label class="layui-form-label">设备名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="dvname" lay-verify="title" autocomplete="off" placeholder="请输入设备名称" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">设备ID</label>
			    <div class="layui-input-block">
			      <input type="text" name="dvid" lay-verify="required" placeholder="请输入设备ID" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">设备型号</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="dvtypecode" lay-verify="required" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			  <div class="userOptions layui-form-item">
			    <label class="layui-form-label">所属医院</label>
			    <div class="layui-input-block">
			      <select id="hpcodeData" name="dvbelong" lay-filter="required">
			        <option value="">请选择</option>
			      </select>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">MAC地址</label>
			      <div class="layui-input-inline">
			        <input type="text" name="MAC_address"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">app版本</label>
			      <div class="layui-input-inline">
			        <input type="text" name="app_version"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  <div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">安卓系统</label>
			      <div class="layui-input-inline">
			        <input type="text" name="android_version"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label">IP地址</label>
			      <div class="layui-input-inline">
			        <input type="text" name="ip_address"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <!-- <div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="createtime" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div> -->
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">SIM卡号</label>
			    <div class="layui-input-block">
			      <input type="text" name="sim_code"  placeholder="" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">IMEI号</label>
			    <div class="layui-input-block">
			      <input type="text" name="imei_code"  placeholder="" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">平板品牌</label>
			    <div class="layui-input-block">
			      <input type="text" name="brand_pad"  placeholder="" autocomplete="off" class="layui-input">
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
			      <button class="layui-btn" lay-submit="" lay-filter="sub_editDevice">立即提交</button>
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
  //医院option添加
  setTimeout(function(){
		var dvbelong_id = $("input[name='dvbelongcode']").val();
		$.ajax({
		      url: '<%=basePath %>hospital/getHospitals.do',
		      type: 'POST',
		      success: function (info_data) {
		    	  var obj_data = info_data.data;
		    	  $.each(obj_data,function(i){
		    		  var option_Data
		    		  if(dvbelong_id == obj_data[i].id){
		    			  option_Data ="<option value='"+obj_data[i].id+"' selected='selected'>"+obj_data[i].hpname+"</option>";
		    		  }else{
			    		  option_Data="<option value='"+obj_data[i].id+"'>"+obj_data[i].hpname+"</option>";
		    		  }
		    		  console.info(option_Data);
		    		  $("#hpcodeData").append(option_Data);
		    		  form.render('select');
		    	  });
		      }
		  });
	},500);
 
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
  
  //监听提交
   form.on('submit(sub_editDevice)', function(data){
	  $.ajax({
          url: '<%=basePath %>device/show/editDevice.do',
          type: 'POST',
          data: data.field,
          success: function (info_data) {
        	  var index = parent.layer.getFrameIndex(window.name);
  			  //parent.layer.close(index);//关闭当前页
  			 // window.parent.location.replace(location.href)//刷新父级页面
  			 console.info(info_data);
  			  var layData = JSON.parse(info_data);
  			 console.info(layData);
 			 layer.msg(layData.msg,{offset:'lt',icon: 5},{time:1500},function(){
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
