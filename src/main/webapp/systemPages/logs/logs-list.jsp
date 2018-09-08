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
<title>日志列表</title>
</head>
<body>
<div id = "content">
  <div class="layui-btn-group test-table-operate-btn">
	</div>
	<table id="demo" lay-filter="test"></table>
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
    ,elem: '#demo'
    ,height: 'full-100'
    ,cellMinWidth: 80
    ,url: '<%=basePath %>log/logList.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
    	{type:'checkbox'}
      ,{field: 'id', title: 'ID', sort: true}
      ,{field: 'pname', title: '操作内容'}
      ,{field: 'pcode', title: '操作用户'}
      ,{field: 'plevel', title: '操作日期', sort: true}
      ,{field: 'plevel', title: '操作结果'}
      ,{field: 'plevel', title: '操作状态'}
    ]]
  });
//监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
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
	        var checkStatus = table.checkStatus('demo')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('demo')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('demo');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      }
	    };
$('.test-table-operate-btn .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

});
</script>
</html>