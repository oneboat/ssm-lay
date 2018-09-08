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
	  <button class="layui-btn layui-btn-sm" data-type="add">
	    <i class="layui-icon">&#xe654;</i>添加
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="edit">
	    <i class="layui-icon">&#xe642;</i>编辑
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="bind_role">
	    <i class="layui-icon">&#xe642;</i>绑定角色
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="unbind_role">
	    <i class="layui-icon">&#xe642;</i>解除绑定
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="reset_password">
	    <i class="layui-icon">&#xe642;</i>密码重置
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="deleteUser">
	    <i class="layui-icon">&#xe640;</i>删除
	  </button>
	  <button class="layui-btn layui-btn-sm" data-type="">
	    <i class="layui-icon">&#xe602;</i>
	  </button>
	</div>
    <button class="layui-btn"  data-type="reload" style="float: right;margin-right:100px;">搜索</button>
	<div class="layui-input-block" style="float: right;">
      <label class="layui-form-label">用户名搜索</label>
      <input style="width: auto;" type="text" id="select_username" placeholder="请输入用户名" autocomplete="off" class="layui-input">
    </div>
	<!-- <div class="layui-btn-group test-table-operate-btn" style="margin-bottom: 10px;">
      <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
      <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
      <button class="layui-btn" data-type="isAll">验证是否全选</button>
    </div>  -->
	<table id="userList" lay-filter="test"></table>
</div>
</body>
<script>
layui.use('table', function(){
  var table = layui.table;
  var layer = layui.layer;
  //第一个实例
  table.render({
	  id:'usernameReload'
	,skin: 'row' //行边框风格
	,even: true //开启隔行背景
    ,elem: '#userList'
    ,height: 'full-50'
    ,cellMinWidth: 80
    ,url: '<%=basePath %>user/userManage.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'numbers'}
      ,{type:'checkbox'}
      ,{field: 'id', title: 'ID', sort: true,align:'left'}
      ,{field: 'username', title: '用户名',align:'left'}
      ,{field: 'name', title: '名称',align:'left'}
      ,{field: 'phone', title: '电话',align:'left'}
      ,{field: 'address', title: '城市',align:'left'} 
      ,{field: 'age', title: '年龄',align:'left'}
      ,{field: 'ident', title: '角色',align:'left' }
      ,{field: 'email', title: '邮箱',align:'left'}
      ,{field: 'cardid', title: '证件号' ,align:'left'}
      ,{field: 'createtime', title: '日期' ,align:'left'}
      ,{field: 'identnum'}
    ]]
    ,done: function(res, curr, count){
	  	  $("[data-field='identnum']").css('display','none');
	  	  $("[data-field='cardid']").css('display','none');
	  	  $("[data-field='id']").css('display','none');
	  	  $("[data-field='age']").css('display','none');
	  	  $("[data-field='name']").css('width','200px');
	  	  $("[data-field='phone']").css('width','110px');
	  	  $("[data-field='email']").css('width','180px');
	  	  $("[data-field='createtime']").css('width','170px');
	  }
  });
//监听表格复选框选择
  table.on('checkbox(userList)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(userList)', function(obj){
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
		      var userReload = $('#select_username');
		      //执行重载
		      table.reload('usernameReload', {
		    	 page:{ curr:1 }
		        ,where: {
		        	  usernames: userReload.val()
		        }
		      });
		    },
	      getCheckData: function(){ //获取选中数据
	        var checkStatus = table.checkStatus('usernameReload')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('usernameReload')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('usernameReload');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },add: function(){//添加
	    	  if(layerView == null){
		    	  layerView = layer.open({
		    		  type: 2, 
		    		  title:'添加用户',
		    		  offset:'auto',
		    		  area: ['500px', '400px'],
		    		  content: ['<%=basePath %>systemPages/user/user-add.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          end: function(){ //此处用于演示
			        	  layerView =null;
			          }});
	    	  }
	      },bind_role: function(){//绑定角色
	    	  var checkStatus = table.checkStatus('usernameReload')
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
		    		  title:'绑定角色',
		    		  offset:'auto',
		    		  area: ['800px', '400px'],
		    		  content: ['<%=basePath %>systemPages/user/user-roles.jsp','yes'], //这里content是一个普通的String
			    	  shadeClose: true,
			          shade: false,
			          maxmin: true,
			          mask:true,
			          success : function(layero, index){
			              var body = layui.layer.getChildFrame('body', index);
			                  // 取到弹出层里的元素，并把编辑的内容放进去
			                 body.find("#uid").val(id);  //id
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },unbind_role: function(){//解除绑定
	    	  var ids='';
	    	  var checkStatus = table.checkStatus('usernameReload')
		      ,data = checkStatus.data;
	      	  if(data.length < 1){
	      		layer.msg('请选择至少一个用户！', {
	    		    time: 2000//20s后自动关闭
	    		  });
	      		return;
	      	  }
	      	$.each(data,function(i){
	    		  if(i!=data.length-1){
						ids+=data[i].username+",";	
					}else{
						ids+=data[i].username;
					}
	    	  });
	      	layer.confirm('您确认要解绑选中项吗？', {
	    		  btn: ['确认','取消'] //按钮
	    		}, function(){
	    			$.ajax({
	    		          url: '<%=basePath %>user/deleteUserRoles.do',
	    		          data: 'ids='+ids,
	    		          success: function (info) {
	    		              layer.msg(info.msg,{time:1500},function(){
	    		            	  window.location.replace(location.href)//刷新父级页面
	    		              });
	    		          }
	    		      });
	    		}, function(){
	    		  layer.msg('已取消', {
	    		    time: 2000//2s后自动关闭
	    		  });
	    		});
	      },edit: function(){//编辑
	    	  var checkStatus = table.checkStatus('usernameReload')
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
		    		  content: ['<%=basePath %>systemPages/user/user-edit.jsp','yes'], //这里content是一个普通的String
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
			              body.find("input[name='address']").val(data[0].address);  //id
			              body.find("input[name='email']").val(data[0].email);  //id
			              body.find("input[name='cardid']").val(data[0].cardid);  //id
			              /* body.find("select option[value='"+data[0].identnum+"']").prop("selected","selected");  //id */
			          },
			          end: function(){ //关闭弹出层
			        	  layerView =null;
			          }});
	    	  }
	      },reset_password: function(){//重置密码
	    	  var checkStatus = table.checkStatus('usernameReload')
		      ,data = checkStatus.data;
	    	  if(data.length != 1){
		      		layer.msg('请选择一个用户！', {
		    		    time: 2000//20s后自动关闭
		    		  });
		      		return;
		      	  }
		      var id = data[0].id;
	    	  $.ajax({
		          url: '<%=basePath %>user/show/resetPassword.do',
		          data: 'uid='+id,
		          success: function (info) {
		        	  var data_re = JSON.parse(info);
		              layer.msg(data_re.msg,{time:1500},function(){
		            	  window.location.replace(location.href)//刷新父级页面
		              });
		  			 
		          }
		      });
	      },deleteUser: function(){
	    	  var ids = "";
	    	  var checkStatus = table.checkStatus('usernameReload')
		      ,data = checkStatus.data;
	    	  $.each(data,function(i){
	    		  if(i!=data.length-1){
						ids+=data[i].username+",";	
					}else{
						ids+=data[i].username;
					}
	    	  });
	    	  layer.confirm('您确认要删除选中项吗？', {
	    		  btn: ['确认','取消'] //按钮
	    		}, function(){
	    			$.ajax({
	    		          url: '<%=basePath %>user/deleteUser.do',
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