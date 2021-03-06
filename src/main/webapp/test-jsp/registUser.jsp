<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<style>
	#main{
		width:500px;
		height:500px;
		margin:60px auto;
	}
</style>
<head>
  <base href="<%=basePath%>">
  
  <title>注册帐号</title>
  	<script type="text/javascript" src="js/jquery-easyui-1.5.1/jquery.min.js"></script>
  	<script type="text/javascript" src="js/css/btn_p1.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="js/jquery-easyui-1.5.1/themes/default/easyui.css" type="text/css"></link>
	<link rel="stylesheet" href="js/jquery-easyui-1.5.1/themes/icon.css" type="text/css"></link>
	<script type="text/javascript" src="js/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<div id ="main">
		<form action="show/regist.do" method="post">
			<input type="hidden" name="identify" value="trav">
			<table>
				<tr>
					<td class="td_left"><label>用户名:</label></td>
				  	<td class="td_right"><input class="register" name="username" type="text"></td>
		  		</tr>
			  	<tr>
				  	<td class="td_left"><label>邮&nbsp;&nbsp;&nbsp;箱:</label></td>
				  	<td class="td_right"><input class="register" name="username" type="text"></td>
			  	</tr>
				<tr>
					<td class="td_left"><label>密&nbsp;&nbsp;&nbsp;码:</label></td>
					<td class="td_right"><input class="register" name="password" type="text"></td>
				</tr>
				<tr>
					<td class="td_left"><label>确认密码:</label></td>
					<td class="td_right"><input class="register" name="password2" type="text"></td>
				</tr>
				<tr id="addContent"></tr>
				<tr>
					<td colspan="2">
						<input type="button" class="btn-regist" name="teac" value="教师注册">
						<input type="button" class="btn-regist" name="stud" value="学生注册">
						<input type="button" class="btn-regist" name="trav" value="游客注册">
					</td>
				</tr>
				<tr></tr>
				<tr>
					<td colspan="2">
						<input class="btn-confirm" type="submit" value="注册">
						<input class="btn-reset" type="reset" value="重置">
					</td>
				</tr>
			</table>
	  	</form>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		reload();
	});
	function reload(){
		$(".register").css({"width":"350px","height":"35px"});
		$("label").css({"font-size":"19px"});
		$(".btn-regist").css({"font-size":"15px","margin":"0 0 0 70px"});
		$("td").css({"border":"0","height":"50px"}); 
		$("table .td_left").css({"width":"100px","text-align":"right"}); 
		$("table .td_right").css({"width":"400px","text-align":"left"});
	}
	$(".btn-regist").click(function(){
		var identify = $(this).attr("name");
		console.info(identify);
		$("#addContent").html("");
		if(identify == "teac"){
			$("#addContent").append("<td class='td_left'><label>教师证号:</label></td><td class='td_right'><input class='register' name='idennum' type='text'></td>");
		}else if(identify == "stud"){
			$("#addContent").append("<td class='td_left'><label>学生学号:</label></td><td class='td_right'><input class='register' name='idennum' type='text'></td>");
		}
		reload();
		$("input[name='identify']").val(identify);
	});
</script>

  