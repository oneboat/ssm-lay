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
<title>用户列表</title>
</head>
<body>
<div id = "content">
  <div class="layui-btn-group test-table-operate-btn">
	  <button class="layui-btn layui-btn-sm" data-type="addDevice">
	    <i class="layui-icon">&#xe642;</i>查看详细信息
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="">
	    <i class="layui-icon">&#xe602;</i>
	  </button>
	</div>
    <!-- <button class="layui-btn"  data-type="reload" style="float: right;margin-right:100px;">搜索</button>
	<div class="layui-input-block" style="float: right;">
      <label class="layui-form-label">设备名搜索</label>
      <input style="width: auto;" type="text" id="select_device" placeholder="请输入设备名" autocomplete="off" class="layui-input">
    </div> -->
	<table id="deviceList" lay-filter="deviceDemo"></table>
</div>
</body>
<script>
layui.use('table', function(){
  var table = layui.table;
  var layer = layui.layer;
  var layerView =null;
  //第一个实例
  table.render({
	  id:'deviceReload'
	,skin: 'row' //行边框风格
	,even: true //开启隔行背景
    ,elem: '#deviceList'
    ,height: 'full-50'
    ,cellMinWidth: 70
    ,url: '<%=basePath %>device/deviceInfoList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'numbers'}
      ,{type:'checkbox'}
      ,{field: 'id', title: 'ID',align:'left'}
      ,{field: 'dvid', title: '设备ID',align:'left',width:150}
      ,{field: 'dvname', title: '设备名称',align:'left',width:150}
      ,{field: 'starttime', title: '开启时间',align:'left',width:150}
      ,{field: 'endtime', title: '关闭时间',align:'left',width:150}
      ,{field: 'status', title: '使用状态',align:'left',width:120}
      ,{toolbar: '#barDemo',title: '操作', align:'center', width:80}
    ]]
    ,done: function(res, curr, count){
  	  	  $("[data-field='id']").css('display','none');
	  }
  });
  
//监听表格复选框选择
  table.on('checkbox(deviceDemo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(deviceDemo)', function(obj){
    var data = obj.data;
    if(obj.event === 'useRecode'){
    	console.log(obj);
    } 
  });
var $ = layui.$, active = {
		 reload: function(){
		      var userReload = $('#select_device');
		      //执行重载
		      table.reload('deviceReload', {
		    	 page:{ curr:1 }
		        ,where: {
		        	  usernames: userReload.val()
		        }
		      });
		    },editDevice: function(){//编辑
	    	  var checkStatus = table.checkStatus('deviceReload')
		      ,data = checkStatus.data;
	      	  if(data.length != 1){
	      		layer.msg('请选择一条记录！', {
	    		    time: 2000//20s后自动关闭
	    		  });
	      		return;
	      	  }
	      	 var id = data[0].id;
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'治疗记录',
		    		  offset:'auto',
		    		  area: ['800px', '500px'],
		    		  content: ['<%=basePath %>layPages/record/cure-record.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#id").val(id);  //id
			              body.find("input[name='name']").val(data[0].name);  //id
			              body.find("input[name='username']").val(data[0].username);  //id
			              body.find("input[name='phone']").val(data[0].phone);  //id
			              body.find("input[name='age']").val(data[0].age);  //id
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }
			      });
	    	  }
	      }
	    };
	  
$('.layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

});
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="useRecode">使用记录</a>
</script>