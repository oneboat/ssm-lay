<%@page import="com.sun.research.ws.wadl.Request"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/publicUtil.jsp"%>
<link rel="stylesheet" href="<%=basePath %>js/layui/css/layui.css">
<script src="<%=basePath %>js/layui/layui.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui-1.5.1/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui-1.5.1/demo/demo.css">
<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<body>
<div class="layui-container">
<input class="mid" name="mid" type="hidden"></input>
	<div class="layui-form-item">
			<table id="menuTree"></table>  
	</div>
	<div class="layui-form-item layui-layout-admin">
       <div class="layui-input-block">
         <div class="layui-footer" style="left:0">
           <button class="layui-btn" lay-submit="" lay-filter="component-form-demo1" data-type="addPers" onclick="addPers()">立即提交</button>
           <button class="layui-btn layui-btn-primary" data-type="closeDialog">取消</button>
         </div>
       </div>
	</div> 
</div>
<div id = "rolperdia"></div>
</body>
<script type="text/javascript" charset="utf-8">
	var mid;
	var layer;
	layui.use('layer',function(){
		layer = layui.layer;
		var index = layer.load(1, {
		  shade: [0.1,'#fff'] //0.1透明度的白色背景
		});
		setTimeout(function(){
			mid = $("input[name='mid']").val()
			layer.close(index);
			onLoad();
		},500);
		var active = {
			      closeDialog:function(){
			    	  layer.msg("已取消！",{time:100},function(){
			  			  parent.layer.close(index);//关闭当前页
		              });
			      }
			    };
		$('.layui-btn').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		  });
	}); 
	function onLoad() {  
		mid = $("input[name='mid']").val();
	    $("#menuTree").treegrid({  
           idField : 'id',  
           treeField : 'pname',  
           rownumbers : true,  
           checkbox:true,
          //首次查询参数           
           columns : [ [ {  
               field : "pname",  
               title : "名称",  
               width : 200  
           }, {  
               field : "url",  
               title : "链接",  
               width : 287  
           },{  
               field : "pname",  
               title : "代号描述",  
               width : 200  
           } ] ]
    	}); 
	    loadRootPer();
	} 
	
	function loadRootPer(){
		  $.ajax({
				 url: "<%=basePath %>system/getRootPermission.do", 
				 async:false,
				 type:"POST",
				 dateType:"JSON",	
				 success:function(datas){
					obj = JSON.parse(datas);
				 	 $("#menuTree").treegrid({
				 		 data:[{
				 			 id:obj.id,
				 			 pname:obj.pname,
				 			 url:obj.url,
				 			 state:'open',
				 			 lines:true
				 		 }]
				 	 });
				    loadChildren(obj.id);
				 }					 
			});
	}
	function loadChildren(pid){
		 $.ajax({
			 url: "<%=basePath %>system/getChildrenPers.do?id="+pid, 
			 async:false,
			 type:"POST",
			 dateType:"JSON",	
			 contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			 success:function(datas){
				var obj = JSON.parse(datas).value;
				$.each(obj,function(i){
					if(obj[i].per_flag == "open"){
						 $("#menuTree").treegrid('append',{
							 parent:pid,
					 		 data:[{
					 			 id:obj[i].per_id,
					 			 pname:obj[i].per_name,
					 			 url:obj[i].per_url,
					 			 state:'open',
					 			 lines:true
					 		 }]
					 	 });
					}else{
						 $("#menuTree").treegrid('append',{
							 parent:pid,
					 		 data:[{
					 			 id:obj[i].per_id,
					 			 pname:obj[i].per_name,
					 			 url:obj[i].per_url,
					 			 state:'open',
					 			 lines:true
					 		 }]
					 	 });
						 loadChildren(obj[i].per_id);
					}
				});
			 }					 
		});
		setSelected();
	}
	function setSelected(){
		 $.ajax({
			 url: "<%=basePath %>system/getPersonalPers.do?id="+mid, 
			 async:false,
			 type:"POST",
			 dateType:"JSON",	
			 contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			 success:function(datas){
				var obj = JSON.parse(datas).value;
				$.each(obj,function(i){
					var nodesAll = $("#menuTree").treegrid("getPanel").find(".tree-checkbox"); 
					$.each(nodesAll,function(j){
						var key = $($(nodesAll[j]).closest('tr')[0]).attr("node-id");
						if(obj[i].per_id == key){
							$($(nodesAll[j]).closest('span')).attr("class","tree-checkbox tree-checkbox1");
						}
					});
				});		
			 }
		});
	}
	function addPers(){
		var ids = "";
	    var nodes = $("#menuTree").treegrid("getPanel").find(".tree-checkbox1"); 
	    $.each(nodes,function(j){
			var key = $($(nodes[j]).closest('tr')[0]).attr("node-id");
			ids+=key+",";
		});
	    $.ajax({
		   url: "<%=basePath %>system/addPersonalPers.do?id="+mid+"&ids="+ids, 
		   async:false,
		   type:"POST",
		   dateType:"JSON",	
		   success:function(datas){
			   var per_data=JSON.parse(datas);
			   $.ajax({
				   url: "<%=basePath %>filter/change.do",
				   async:true,
				   type:"POST",
				   success:function(data){
					   	console.info("-------元数据---"+datas);
					   	console.info("------JSON---"+per_data);
					    layer.msg("权限分配完成！" ,{time:1500},function(){
					    	var index = parent.layer.getFrameIndex(window.name);
	  			  			parent.layer.close(index);//关闭当前页
			            	window.parent.location.reload();//刷新父级页面
					    });
					   
					   
				  	}
			   });
			    
		  }
	  });
	}
</script>