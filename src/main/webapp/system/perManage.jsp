<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<div id="studentList" fit="true">
	<div id="perDiv" style="height:100%;width:100%">
		<div id="tbs" style="height:10%;width:100%">
			<br>
			&nbsp;权限名称：<input type="text" name="pname"/>
			&nbsp;优先级：<input type="text" name="plevel"/>
			<button id="buts" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="search()">查询</button>
			<button id="butr" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset()">清空</button>
		</div>
		<table id="dgs" class="easyui-datagrid" style="height:90%;width:100%"></table>  
	</div>
</div>
<div id = "studia"></div>
<script type="text/javascript" charset="utf-8">
	function search(){
		var names = $("#tbs input:eq(0)").val();
		var level = $("#tbs input:eq(1)").val();
		$('#dgs').datagrid('load',{
              name: names,
              plevel: level
          });
	}
	function reset(){
		$("#tbs input:eq(0)").val("");
		$("#tbs input:eq(1)").val("");
	}
	$(function(){
		$('#dgs').datagrid({    
		    url:'<%=basePath %>system/perList.do', 
		    border:false, 
		    pagination:true,
		    singleSelect:false,
		    rownumbers:true,
		    pageSize:10,
		    pageList:[10,20,30],
		    fitColums:true,
		    nowrap:true,
		    columns:[[ 
		    	{field:"ids",title:'序号',width:50,align:'center',checkbox:true},  
		        {field:"id",title:'编号',width:100,align:'center'},    
		        {field:"pname",title:'权限名',width:150,align:'center', 
		        formatter:function(value){
		        	if( value == ""){
		        		return '空';
		        	}else{
		        		return value;
		        	}
		        }},    
		        {field:"pcode",title:'代号',width:200,align:'center'},
		        {field:"plevel",title:'优先级',width:100,align:'center'}
		    ]], 
			 toolbar: [{
					text:'查看详情',
					iconCls: 'icon-large-smartart',
					handler: function(){
						
					}
				},'-',{
				    text:'帮助',
					iconCls: 'icon-help',
					handler: function(){

					}
				}], 
		});  
	});
</script>