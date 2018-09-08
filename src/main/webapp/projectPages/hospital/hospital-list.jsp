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
	  <button class="layui-btn layui-btn-sm" data-type="addHospital">
	    <i class="layui-icon">&#xe654;</i>添加
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="editHospital">
	    <i class="layui-icon">&#xe642;</i>编辑
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="deleteHospital">
	    <i class="layui-icon">&#xe640;</i>删除
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="">
	    <i class="layui-icon">&#xe602;</i>
	  </button>
	</div>
    <button class="layui-btn"  data-type="reload" style="float: right;margin-right:100px;">搜索</button>
	<div class="layui-input-block" style="float: right;">
      <label class="layui-form-label">医院搜索</label>
      <input style="width: auto;" type="text" id="select_hpname" placeholder="请输入医院名" autocomplete="off" class="layui-input">
    </div>
	<table id="hospitalList" lay-filter="test"></table>
</div>
</body>
<script>
layui.use('table', function(){
  var table = layui.table;
  var layer = layui.layer;
  //第一个实例
  table.render({
	  id:'hospitalReload'
	,skin: 'row' //行边框风格
	,even: true //开启隔行背景
    ,elem: '#hospitalList'
    ,height: 'full-50'
    ,cellMinWidth: 80
    ,url: '<%=basePath %>hospital/hospitalList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'numbers'}
      ,{type:'checkbox'}
      ,{field: 'id', title: 'ID',align:'left'}
      ,{field: 'hpname', title: '医院名称',align:'left'}
      ,{field: 'hpcode', title: '登陆用户名',align:'left'}
      ,{field: 'hptel', title: '电话',align:'left'}
      ,{field: 'addressDetail', title: '城市',align:'left'} 
      ,{field: 'hpemail', title: '邮箱',align:'left'}
      ,{field: 'cardid', title: '证件号' ,align:'left'}
      ,{field: 'createtime', title: '日期' ,align:'left',sort: true}
    ]]
    ,done: function(res, curr, count){
  	  $("[data-field='id']").css('display','none');
  	  $("[data-field='hpname']").css('width','180px');
  	  $("[data-field='hpemail']").css('width','170px');
  	  $("[data-field='cardid']").css('width','170px');
	  }
  });
//监听表格复选框选择
  table.on('checkbox(hospitalList)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(hospitalList)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
      layer.msg('ID：'+ data.id + ' 的查看操作');
    } else if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
      layer.alert('编辑行：<br>'+ JSON.stringify(data))
    }
  });
var layerView =null;
var $ = layui.$, active = {
		 reload: function(){
		      var userReload = $('#select_hpname');
		      //执行重载
		      table.reload('hospitalReload', {
		    	 page:{ curr:1 }
		        ,where: {
		        	  name: userReload.val()
		        }
		      });
		    },
	      getCheckData: function(){ //获取选中数据
	        var checkStatus = table.checkStatus('hospitalReload')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('hospitalReload')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('hospitalReload');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },addHospital: function(){//添加
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'添加医院信息',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>projectPages/hospital/hospital-add.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          end: function(){ //
			        	  layerView =null;
			          }});
	    	  }
	      },editHospital: function(){//编辑
	    	  var checkStatus = table.checkStatus('hospitalReload')
		      ,data = checkStatus.data;
	      	  if(data.length != 1){
	      		layer.msg('请选择一个用户！', {
	    		    time: 2000//20s后自动关闭
	    		  });
	      		return;
	      	  }
	      	 var id = data[0].id;
	      	 var hasUser;
	      	 if(data[0].hpcode != null && data[0].hpcode != ""){
	      		hasUser = 1;
	      	 }else{
	      		hasUser = 0;
	      	 }
	      	 
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'信息编辑',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>projectPages/hospital/hospital-edit.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#id").val(id);  //id
			              body.find("input[name='hpname']").val(data[0].hpname);  //id
			             body.find("input[name='hpcode']").val(data[0].hpcode); //username
			              body.find("input[name='hptel']").val(data[0].hptel);  //hptel
			              body.find("input[name='addressDetail']").val(data[0].addressDetail);  //addressDetail
			              body.find("input[name='hpemail']").val(data[0].hpemail);  //hpemail
			              body.find("input[name='cardid']").val(data[0].cardid);  //cardid
			              body.find("input[name='createtime']").val(data[0].createtime);  //createtime
			              body.find("input[type='radio'][value='"+hasUser+"']").prop("checked","checked");
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },deleteHospital: function(){
	    	  var ids = "";
	    	  var checkStatus = table.checkStatus('hospitalReload')
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
	    		          url: '<%=basePath %>hospital/deleteHospital.do',
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
</html>