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
	    <i class="layui-icon">&#xe654;</i>添加
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="editDevice">
	    <i class="layui-icon">&#xe642;</i>编辑
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="deleteDevice">
	    <i class="layui-icon">&#xe640;</i>删除
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="">
	    <i class="layui-icon">&#xe602;</i>
	  </button>
	</div>
    <button class="layui-btn"  data-type="reload" style="float: right;margin-right:100px;">搜索</button>
	<div class="layui-input-block" style="float: right;">
      <label class="layui-form-label">设备名搜索</label>
      <input style="width: auto;" type="text" id="select_device" placeholder="请输入设备名" autocomplete="off" class="layui-input">
    </div>
	<!-- <div class="layui-btn-group test-table-operate-btn" style="margin-bottom: 10px;">
      <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
      <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
      <button class="layui-btn" data-type="isAll">验证是否全选</button>
    </div>  -->
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
    ,url: '<%=basePath %>device/deviceList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'numbers'}
      ,{type:'checkbox'}
      ,{field: 'id', title: 'ID', sort: true,align:'left'}
      ,{field: 'dvid', title: '设备ID',align:'left',width:150}
      ,{field: 'dvname', title: '设备名称',align:'left',width:150}
      ,{field: 'dvtypecode', title: '设备型号', align:'left',width:120}
      ,{field: 'dvbelong_name', title: '设备所属医院',align:'left',width:180}
      ,{field: 'dvbelong', title: '设备所属医院ID',align:'left',width:180}
      ,{field: 'sim_code', title: 'SIM卡号' ,align:'left',width:120}
      ,{field: 'dvtotaltime', title: '设备使用总时长',align:'left',width:120} 
      ,{field: 'dvnum', title: '设备使用次数',align:'left',width:120} 
      ,{field: 'MAC_address', title: 'MAC地址',align:'left',width:140 }
      ,{field: 'ip_address', title: 'IP地址',align:'left',width:130}
      ,{field: 'android_version', title: '安卓系统',align:'left',width:80}
      ,{field: 'app_version', title: 'app版本',align:'left',width:80}
      ,{field: 'brand_pad', title: '平板品牌',align:'left',width:80}
      ,{field: 'imei_code', title: 'IMEI号' ,align:'left',width:140,fixed: 'right'}
      ,{toolbar: '#barDemo',title: '操作', align:'center', width:80,fixed: 'right',height: 50}
    ]]
    ,done: function(res, curr, count){
  	  	  $("[data-field='id']").css('display','none');
  	  	  $("[data-field='dvbelong']").css('display','none');
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
    	if(layerView == null){
	    	  layerView = layer.open({
	    		  type: 2, 
	    		  title:'设备使用记录',
	    		  offset:'auto',
	    		  area: ['1000px', '500px'],
	    		  content: ['<%=basePath %>projectPages/device/device-info.jsp','yes'], //这里content是一个普通的String
		    	  shadeClose: true,
		          shade: false,
		          maxmin: true,
		          mask:true,
		          end: function(){ //此处为窗口关闭事件
		        	  layerView =null;
		          }
	    	  });
  	    }
    } 
  });
var $ = layui.$, active = {
		 reload: function(){
		      var userReload = $('#select_device');
		      //执行重载
		      table.reload('deviceReload', {
		    	 page:{ curr:1 }
		        ,where: {
		        	  name: userReload.val()
		        }
		      });
		    },
	      getCheckData: function(){ //获取选中数据
	        var checkStatus = table.checkStatus('deviceReload')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('deviceReload')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('deviceReload');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },addDevice: function(){//添加
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'添加设备',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>projectPages/device/device-add.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }});
	    	  }
	      },editDevice: function(){//编辑
	    	  var checkStatus = table.checkStatus('deviceReload')
		      ,data = checkStatus.data;
	      	  if(data.length != 1){
	      		layer.msg('请选择一个用户！', {
	    		    time: 2000//20s后自动关闭
	    		  });
	      		return;
	      	  }
	      	 var id = data[0].id;
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'信息编辑',
		    		  offset:'auto',
		    		  area: ['600px', '500px'],
		    		  content: ['<%=basePath %>projectPages/device/device-edit.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#id").val(id);  //id
			              body.find("input[name='dvid']").val(data[0].dvid);  //id
			              body.find("input[name='dvname']").val(data[0].dvname);  //id
			              body.find("input[name='dvtypecode']").val(data[0].dvtypecode);  //id
			              body.find("input[name='dvbelongcode']").val(data[0].dvbelong);  //id
			              body.find("input[name='sim_code']").val(data[0].sim_code);  //id
			              body.find("input[name='MAC_address']").val(data[0].MAC_address);  //id
			              body.find("input[name='ip_address']").val(data[0].ip_address);  //id
			              body.find("input[name='imei_code']").val(data[0].imei_code);  //id
			              body.find("input[name='app_version']").val(data[0].app_version);  //id
			              body.find("input[name='android_version']").val(data[0].android_version);  //id
			              body.find("input[name='brand_pad']").val(data[0].brand_pad);  //id
			              /* body.find("select option[value='"+data[0].identnum+"']").prop("selected","selected");  //id */
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },deleteDevice: function(){
	    	  var ids = "";
	    	  var checkStatus = table.checkStatus('deviceReload')
		      ,data = checkStatus.data;
	    	  $.each(data,function(i){
	    		  if(i!=data.length-1){
						ids+=data[i].id+",";	
					}else{
						ids+=data[i].id;
					}
	    	  });
	    	  layer.confirm('您确认要删除选中项吗？', {
	    		  btn: ['确认','取消'] //按钮
	    		}, function(){
	    			$.ajax({
	    		          url: '<%=basePath %>device/deleteDevice.do',
	    		          data: 'ids='+ids,
	    		          success: function (info) {
	    		              layer.msg(info.msg,{time:1500},function(){
	    		            	  window.location.replace(location.href)//刷新父级页面
	    		              });
	    		  			 
	    		          }
	    		      });
	    		}, function(){
	    		  layer.msg('已取消', {
	    		    time: 2000//20s后自动关闭
	    		   
	    		  });
	    		});
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