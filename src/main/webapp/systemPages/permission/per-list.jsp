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
<title>权限列表</title>
</head>
<body>
<div id = "content">
  <div class="layui-btn-group test-table-operate-btn">
	  <button class="layui-btn layui-btn-sm" data-type="addPers">
	    <i class="layui-icon">&#xe654;</i>添加
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="editPers">
	    <i class="layui-icon">&#xe642;</i>编辑
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="deleteUser">
	    <i class="layui-icon">&#xe642;</i>查看详情
	  </button>
	  <!-- <button class="layui-btn layui-btn-sm" data-type="deletePer">
	    <i class="layui-icon">&#xe640;</i>删除
	  </button> -->
	  <button class="layui-btn layui-btn-sm" data-type="">
	    <i class="layui-icon">&#xe602;</i>
	  </button>
	</div>
	<!-- <div class="layui-btn-group test-table-operate-btn" style="margin-bottom: 10px;">
      <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
      <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
      <button class="layui-btn" data-type="isAll">验证是否全选</button>
    </div>  -->
	<table id="perTable" lay-filter="test"></table>
</div>
</body>
<script>
layui.use('table', function(){
  var table = layui.table;
  var layer = layui.layer;
  //第一个实例
  table.render({
	 skin: 'row' //行边框风格
	,even: true //开启隔行背景
    ,elem: '#perTable'
    ,height: 'full-100'
    ,cellMinWidth: 80
    ,url: '<%=basePath %>permission/perList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'checkbox'}
      ,{field: 'id', title: 'ID', sort: true}
      ,{field: 'pname', title: '权限名称'}
      ,{field: 'pcode', title: '权限代号'}
      ,{field: 'plevel', title: '权限等级'}
      ,{field: 'purl', title: '权限URL'}
      ,{field: 'pid', title: '权限URL'}
      ,{field: 'createtime', title: '日期'}
    ]],done: function(res, curr, count){
	      	  $("[data-field='id']").css('display','none');
	      	  $("[data-field='pid']").css('display','none');
	      	  $("[data-field='pcode']").css('width','250px');
	      	  $("[data-field='purl']").css('width','250px');
    	}
  });
//监听表格复选框选择
  table.on('checkbox(perTable)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(perTable)', function(obj){
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
	      getCheckData: function(){ //获取选中数据
	        var checkStatus = table.checkStatus('perTable')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('perTable')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('perTable');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },addPers: function(){//添加
	    	  var pid,pname,pcode;
	    	  var checkStatus = table.checkStatus('perTable')
		      ,data = checkStatus.data;
      		  if(data.length > 1){
      			layer.msg('请选择一个权限作为新权限的父级权限！');
      			return ;
      		  }else if(data.length < 1){
      			  pid = 1;
      			  pname="系统所有权";
      			  pcode="P001";
      		  }else{
      			 pid = data[0].id;
     			 pname=data[0].pname;
     			 pcode=data[0].pcode;
      		  }
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'添加新权限',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>systemPages/permission/per-add.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#pid").val(pid);  //id
			              body.find("input[name='pa_pname']").val(pname);  //id
			              body.find("input[name='pa_pcode']").val(pcode);  //id
			          },
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }});
	    	  }
	      },editPers: function(){
	    	  var checkStatus = table.checkStatus('perTable')
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
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>systemPages/permission/per-edit.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#id").val(id);  //id
			              body.find("#pid").val(data[0].pid);  //id
			              body.find("input[name='pName']").val(data[0].pname);  
			              body.find("input[name='pCode']").val(data[0].pcode);  
			              body.find("input[name='plevel']").val(data[0].plevel);  
			              body.find("input[name='url']").val(data[0].purl);  
			             /*  body.find("input[name='status']").val(data[0].status);  //id */
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },deleteUser: function(){
	    	  var ids = "";
	    	  var checkStatus = table.checkStatus('perTable')
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
	    		          url: '<%=basePath %>user/deleteUser.do',
	    		          data: 'ids='+ids,
	    		          success: function (info) {
	    		              layer.msg('删除成功！',{time:1500},function(){
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
$('.test-table-operate-btn .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

});
</script>
</html>