<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div fit="true">
	<div id="treeContent" style="padding:15px">
		<ul id='tree' class='easyui-tree' >
		</ul>
	</div>
</div>
<script type="text/javascript"  charset="utf-8">
	$(function(){
		$('#tree').tree({data:[{'id':'1','text':'SSM系统功能展示','state':'closed','lines':true,'children':[{'text':'1234'}]}]});
	});
	$('#tree').tree({
		onExpand: function(node){
			open(node);
		}
	}); 
	$('#tree').tree({
		onClick: function(node){
			if(node.state=='closed'){
				node.state='open';
				$('#tree').tree('expand', node.target);
			}else{
				node.state='closed';
				$('#tree').tree('collapse', node.target);
			}
		}
	}); 
	function open(node){
		 var children = $('#tree').tree('getChildren',node.target);
		var clen = children.length;
		if(clen == 1){
			console.info("son node:"+children[0].text);
			if(children[0].text == '1234'){
				$('#tree').tree('remove',children[0].target);
			}
		}
		children = $('#tree').tree('getChildren',node.target);
		clen = children.length;
		if(clen<=0){
			console.info(node.id);
			$.ajax({
				url:"<%=basePath%>system/getFunctions.do?id="+node.id,
				dataType:"JSON",
				type:"POST",
				contentType:'application/x-www-form-urlencoded; charset=UTF-8',
				success:function(data){
					var obj = data.value;
					$.each(obj,function(i){
						if(obj[i].func_flag == 'open'){
							$("#tree").tree('append',{
								parent: node.target,
								data: [{
									id: obj[i].id,
									text: obj[i].func_name,
									state:obj[i].func_flag,
									lines:true
								}]
							});
						}else{
							$("#tree").tree('append',{
								parent: node.target,
								data: [{
									id: obj[i].id,
									text: obj[i].func_name,
									state:obj[i].func_flag,
									lines:true,
									children:[{text:'1234'}]
								}]
							});
						}
					});
				}
			});
		}
	}
	
</script>