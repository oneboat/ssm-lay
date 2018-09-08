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
<title>角色列表</title>
</head>
<body>
<div id = "content">
  <div class="layui-btn-group test-table-operate-btn">
	  <button class="layui-btn layui-btn-sm" data-type="addRoles">
	    <i class="layui-icon">&#xe654;</i>添加
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="editRoles">
	    <i class="layui-icon">&#xe642;</i>编辑
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="bind_pers">
	    <i class="layui-icon">&#xe642;</i>绑定权限
	  </button>
	  <!-- <button class="layui-btn layui-btn-sm" data-type="deleteRole">
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
	<table id="rolaeTables" lay-filter="test"></table>
</div>
</body>
<!-- 	转义 -->
<script type="text/html" id="titleTpl">
    {{#  if(d.status==1){ }}
   		 有效
	{{#  } else if(d.status==0) { }}
    	 无效
	{{#  } else{}}
		 其他
	{{#  } }}
</script> 
<script>
layui.use('table', function(){
  var table = layui.table;
  var layer = layui.layer;
  //第一个实例
  table.render({
	 skin: 'row' //行边框风格
	,even: true //开启隔行背景
    ,elem: '#rolaeTables'
    ,height: 'full-100'
    ,cellMinWidth: 80
    ,url: '<%=basePath %>role/roleList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'numbers'}
      ,{type:'checkbox'}
      ,{field: 'id', title: 'ID', sort: true}
      ,{field: 'rname', title: '角色名称'}
      ,{field: 'rcode', title: '角色编号'}
      ,{field: 'rlevel', title: '角色等级'}
      ,{field: 'status', title: '角色状态', templet: '#titleTpl'}
      ,{field: 'createtime', title: '日期'}
    ]]
    ,done:function(){
    	$("[data-field='id']").css('display','none');
    }
  });
//监听表格复选框选择
  table.on('checkbox(rolaeTables)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(rolaeTables)', function(obj){
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
	        var checkStatus = table.checkStatus('rolaeTables')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('rolaeTables')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('rolaeTables');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },addRoles: function(){//添加
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'添加角色',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>systemPages/role/role-add.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }});
	    	  }
	      },bind_pers: function(){//绑定权限
	    	  var checkStatus = table.checkStatus('rolaeTables')
		      ,data = checkStatus.data;
	      	  if(data.length != 1){
	      		layer.msg('请选择一个角色！', {
	    		    time: 2000//20s后自动关闭
	    		  });
	      		return;
	      	  }
	      	 var id = data[0].id;
	      	  console.info("-----"+id);
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'绑定权限',
		    		  offset:'auto',
		    		  area: ['800px', '400px'],
		    		  content: ['<%=basePath %>systemPages/role/role-pers.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find(".mid").val(id);  //id
			          },
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }});
	    	  }
	      },editRoles: function(){
	    	  var checkStatus = table.checkStatus('rolaeTables')
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
		    		  area: ['800px', '400px'],
		    		  content: ['<%=basePath %>systemPages/role/role-edit.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			              body.find("#id").val(id);  //id
			              body.find("input[name='rname']").val(data[0].rname);  //id
			              body.find("input[name='rcode']").val(data[0].rcode);  //id
			              body.find("input[name='rlevel']").val(data[0].rlevel);  //id
			             /*  body.find("input[name='status']").val(data[0].status);  //id */
			              body.find("input[type='radio'] input[value='"+data[0].status+"']").prop("selected","selected");
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },deleteRole: function(){
	    	  var ids = "";
	    	  var checkStatus = table.checkStatus('rolaeTables')
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
<script type="text/html" id="titleTpl">
      if({{d.type}}=='2'){机构}else if({{d.type}}=='3'){财务}
    	</script> 
</html>