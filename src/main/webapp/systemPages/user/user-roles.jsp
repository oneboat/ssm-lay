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
<input id="uid" type="hidden"/>
<div id = "content">
	<table id="roleList" lay-filter="test"></table>
</div>
<div class="layui-form-item layui-layout-admin test-table-operate-btn">
       <div class="layui-input-block">
         <div class="layui-footer" style="left:0">
           <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="component-form-demo1" data-type="addPers" >立即提交</button>
           <button type="reset" class="layui-btn layui-btn-sm" data-type="closeDialog">取消</button>
         </div>
       </div>
	</div> 
</body>
<script>
var uid;
layui.use('table', function(){
	layer = layui.layer;
	var $ = layui.$;
	var table = layui.table;
	var index = layer.load(1, {
	shade: [0.1,'#fff'] //0.1透明度的白色背景
	});
	setTimeout(function(){
		layer.close(index);
		uid = $("#uid").val()
		console.info("延迟0.5秒。。。"+uid);
		 table.render({
			 skin: 'row' //行边框风格
			,even: true //开启隔行背景
		    ,elem: '#roleList'
		    ,height: 'full-100'
		    ,cellMinWidth: 80
		    ,url: '<%=basePath %>user/userroleList.do' //数据接口
		    ,cols: [[ //表头
		      {type:'checkbox'}
		      ,{field: 'id', title: 'ID', sort: true}
		      ,{field: 'rname', title: '角色名称'}
		      ,{field: 'rcode', title: '角色编号'}
		      ,{field: 'rlevel', title: '角色等级'}
		    ]]
		    , done: function(res){
		    	var dataRes = res.data;
		    	$.ajax({
		            url: '<%=basePath %>user/userroles.do',
		            type: 'POST',
		            data: "uid="+uid,
		            success: function (info_data) {
		            	console.info("info_data----"+info_data);
		            	var dataInfo = JSON.parse(info_data).data;
		            	var allCheckBox = $(".layui-table-body").find(".layui-form-checkbox");
		            	$.each(dataInfo,function(i){
							var key = dataInfo[i].id;
		          	 		$.each(dataRes,function(j){
		          	 			if(dataRes[j].id == key){
		          	 				$(allCheckBox[j]).attr("class","layui-unselect layui-form-checkbox layui-form-checked");
		          	 			}
		          	 		});
						});
		          	 	console.info(res);
		          	 	console.info(allCheckBox);
		            }
		        });
		      }
		  });
	},500);
 
  
  //第一个实例
 
//监听表格复选框选择
  table.on('checkbox(roleList)', function(obj){
	  console.log(obj.checked); //当前是否选中状态
	  console.log(obj.data); //选中行的相关数据
	  console.log(obj.type); //如果触发的是全选，则为：all，如果触发的是单选，则为：one
  });
  //监听工具条
 /* table.on('tool(demo)', function(obj){
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
  }); */
var layerView =null;
var active = {
	      getCheckData: function(){ //获取选中数据
	        var checkStatus = table.checkStatus('roleList')
	        ,data = checkStatus.data;
	        layer.alert(JSON.stringify(data));
	      }
	      ,getCheckLength: function(){ //获取选中数目
	        var checkStatus = table.checkStatus('roleList')
	        ,data = checkStatus.data;
	        layer.msg('选中了：'+ data.length + ' 个');
	      }
	      ,isAll: function(){ //验证是否全选
	        var checkStatus = table.checkStatus('roleList');
	        layer.msg(checkStatus.isAll ? '全选': '未全选')
	      },addPers:function(){
	    	  var checkStatus = table.checkStatus('roleList')
		       ,data = checkStatus.data;
	    	  if(data.length != 1){
	    		  layer.msg('请选择至少一个用户！', {
		    		    time: 1500//20s后自动关闭
		    		  });
		      		return;
	    	  }else{
	    		  var uid = $("#uid").val();
	    		  var rid = data[0].id;
	    		  $.ajax({
	    			  url: '<%=basePath %>user/bindRoleForUser.do',
    		          data: 'uid='+uid+'&rid='+rid,
    		          success: function (info) {
    		        	  var index = parent.layer.getFrameIndex(window.name);
    		        	  var data_re = JSON.parse(info);
    		              layer.msg(data_re.msg,{time:1500},function(){
    		            	  window.parent.location.reload();//刷新父级页面
    			  			  parent.layer.close(index);//关闭当前页
    		              });
    		          }
	    		  });
	    	  }
	      },closeDialog:function(){
	    	  var index = parent.layer.getFrameIndex(window.name);
	    	  layer.msg("已取消！",{time:500},function(){
	  			  parent.layer.close(index);//关闭当前页
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