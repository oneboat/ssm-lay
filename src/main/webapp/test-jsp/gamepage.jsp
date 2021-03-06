<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="gamepage" fit="true" >
	<div style="width:25%;height:100%;float:left;">
		<div id="content_min">
			<div id="scoreContent">
				<h3>当前得分：<input id="inputScore" value = "0" readonly></input></h3>
			</div>
			<table id="gtable_min"></table>
			<div id="scoreRecode">
				<h3>最高得分：<input id="topScore" value = "1234" readonly></input></h3>
			</div>
			<button id="checkScores" onclick="checkScoresRecode()">查看得分榜</button>
		</div>
	</div>
	<div style="width:40%;height:100%;float:left;">
		<div id="content_game" >
			<table id="gtable"></table>
		</div>
	</div>
	<div style="width:20%;height:100%;float:left;">
		<div id="gbtn">
			<button onclick="startgame()">开始游戏</button>
			&nbsp;
			<button onclick="stopgame()">结束游戏</button>
		</div>
	</div>
	<div id="scoreRecodes" ></div>
</div>
<script type="text/javascript">
	var nids;
	var oidS;
	var changeLocation;//定时器
	var shape;//图形
	var score;//分数
	var num;//随机图形
	$(function(){
		$.ajax({
			url:"<%=basePath %>getLargestScore.do",
			success:function(data){
				var obj = JSON.parse(data);
				/* console.info(obj.score); */
				$("#topScore").val(obj.score);
			}
		});
		score = 0;
		$("#content_game").css({"margin":"15px auto","width":"300px","height":"400px"});
		$("#gbtn").css({"margin":"50% 0 0 50px"});
		$("#content_min").css({"margin":"50px 0 0 50px","width":"200px","height":"150px"});
		$("#scoreContent").css({"height":"18px"});
		$("#scoreRecode").css({"height":"18px"});
		$("#checkScores").css({"margin":"15px 0 0 30px"});
		$("#content_min #inputScore").css({"width":"80px","height":"20px"});
		$("#content_min #topScore").css({"width":"80px","height":"20px"});
		$("#gtable").css({"width":"300px","height":"400px","border":"2px solid black","border-collapse":"collapse"});
		for(var i=0;i<18;i++){
			$("#gtable").append("<tr id='gtr"+i+"'></tr>");
			for(var j=0;j<12;j++){
				$("#gtr"+i).append("<td id='"+i+","+j+"'></td>");
			}
		} 
		$("#gtable tr td").css({"width":"25px"});
		$("#gtable_min").css({"margin":"15px 0","width":"150px","height":"150px","border":"2px solid black","border-collapse":"collapse"});
		for(var i=0;i<6;i++){
			$("#gtable_min").append("<tr id='gtr_min"+i+"'></tr>");
			for(var j=0;j<6;j++){
				$("#gtr_min"+i).append("<td id='"+i+","+j+"'></td>");
			}
		} 
		$("td").css({"border":"1px solid white","cellspacing":"0","cellpadding":"0"});
		$("#gtable tr:lt(2)").hide();
		$(document).keydown(function(event){ 
			//alert(event.keyCode);
			if(event.keyCode == 37){
				changeHorizontalPlace(-1);
			}else if(event.keyCode == 39){
				changeHorizontalPlace(1);
			}else if(event.keyCode == 38){
				console.info("旧图形代码："+shape);
				changeShape();
				console.info("新图形代码："+shape);
			}
		}); 
	});
	function tianShape(){//'田'
		shape = 0;
		getNextShape();
		$("#content_game td[id='0,5']").attr("class","blackBox");
		$("#content_game td[id='0,6']").attr("class","blackBox");
		$("#content_game td[id='1,5']").attr("class","blackBox");
		$("#content_game td[id='1,6']").attr("class","blackBox");
		$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		/* console.info("changeLocation="+changeLocation); */
		if(changeLocation == undefined){
			changeLocation = window.setInterval("changePlace()",1000);
		}
		/* console.info("changeLocation="+changeLocation); */
	}
	function tuShape(){
		shape = 1;//1代表‘┻‘,11代表‘┣‘，12代表‘┳‘，13代表‘┫’
		getNextShape();
		$("#content_game td[id='0,5']").attr("class","blackBox");
		$("#content_game td[id='1,4']").attr("class","blackBox");
		$("#content_game td[id='1,5']").attr("class","blackBox");
		$("#content_game td[id='1,6']").attr("class","blackBox");
		$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		/* console.info("changeLocation="+changeLocation); */
		if(changeLocation == undefined){
			changeLocation = window.setInterval("changePlace()",1000);
		}
		/* console.info("changeLocation="+changeLocation); */
	}
	function fuShape(){//'﹂'
		shape = 2;//2代表‘ ﹂ ‘,21代表‘「‘，22代表‘﹁‘，23代表‘」’
		getNextShape();
		$("#content_game td[id='0,4']").attr("class","blackBox");
		$("#content_game td[id='1,4']").attr("class","blackBox");
		$("#content_game td[id='1,5']").attr("class","blackBox");
		$("#content_game td[id='1,6']").attr("class","blackBox");
		$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		/* console.info("changeLocation="+changeLocation); */
		if(changeLocation == undefined){
			changeLocation = window.setInterval("changePlace()",1000);
		}
		/* console.info("changeLocation="+changeLocation); */
	}
	function hsShape(){//'——'
		shape = 3;//3代表‘ —— ‘,31代表‘|‘
		getNextShape();
		$("#content_game td[id='1,4']").attr("class","blackBox");
		$("#content_game td[id='1,5']").attr("class","blackBox");
		$("#content_game td[id='1,6']").attr("class","blackBox");
		$("#content_game td[id='1,7']").attr("class","blackBox");
		$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		/* console.info("changeLocation="+changeLocation); */
		if(changeLocation == undefined){
			changeLocation = window.setInterval("changePlace()",1000);
		}
		/* console.info("changeLocation="+changeLocation); */
	}
	//随机获取下个图案并显示在左侧
	function getNextShape(){
		$("#content_min td").attr("class","whiteBox");
		$("#content_min .whiteBox").css({"background-color":"white","border":"1px solid white"});
		num = Math.round(Math.random() * 3);
		switch(num){
			case 0:
				$("#content_min td[id='2,2']").attr("class","blackBox");
				$("#content_min td[id='2,3']").attr("class","blackBox");
				$("#content_min td[id='3,2']").attr("class","blackBox");
				$("#content_min td[id='3,3']").attr("class","blackBox");
				$("#content_min .blackBox").css({"background-color":"gray","border":"1px solid black"});
			break;
			case 1:
				$("#content_min td[id='2,2']").attr("class","blackBox");
				$("#content_min td[id='3,1']").attr("class","blackBox");
				$("#content_min td[id='3,2']").attr("class","blackBox");
				$("#content_min td[id='3,3']").attr("class","blackBox");
				$("#content_min .blackBox").css({"background-color":"gray","border":"1px solid black"});
			break;
			case 2:
				$("#content_min td[id='2,1']").attr("class","blackBox");
				$("#content_min td[id='3,1']").attr("class","blackBox");
				$("#content_min td[id='3,2']").attr("class","blackBox");
				$("#content_min td[id='3,3']").attr("class","blackBox");
				$("#content_min .blackBox").css({"background-color":"gray","border":"1px solid black"});
			break;
			case 3:
				$("#content_min td[id='3,1']").attr("class","blackBox");
				$("#content_min td[id='3,2']").attr("class","blackBox");
				$("#content_min td[id='3,3']").attr("class","blackBox");
				$("#content_min td[id='3,4']").attr("class","blackBox");
				$("#content_min .blackBox").css({"background-color":"gray","border":"1px solid black"});
			break;
			default:
			break;
		}
	}
	function changePlace(){
		nids="";
		oids="";
		$("#content_game .blackBox").each(function(){
			var tx = $(this).attr("id");
			oids +=tx+";";
			var txs = tx.split(",");
			txs[0] = parseInt(txs[0])+1;
			var nid = txs[0]+","+txs[1];
			nids+=nid+";";
		});
		/* console.info("旧坐标:"+oids);
		console.info("新坐标:"+nids); */
		var obox = oids.split(";");//旧位置坐标
		var nbox = nids.split(";");//新位置坐标
		var ifBottom=false;//检测是否到底
		var ifNextBlack = 0;//检测下方方块黑色块数量
		$.each(obox,function(i){
			var ablack="";//用来查看下方方块坐标是否为黑色区域
			var obs = obox[i].split(",");
			var nx = parseInt(obs[0])+1;
			if(nx>=18){
				ifBottom = true;
			}
			ablack = $("#content_game td[id='"+nx+","+obs[1]+"']").attr("class");
			if("blackBox"==ablack || "blackBox-fix" == ablack){
				ifNextBlack += 1;
			}
		});
		if(ifBottom){
			clearTimeout(changeLocation);
			changeLocation = undefined;
			$.each(obox,function(i){
				var obs = obox[i].split(",");
				$("#content_game td[id='"+obs[0]+","+obs[1]+"']").attr("class","blackBox-fix");
				$("#content_game .blackBox-fix").css({"background-color":"gray","border":"1px solid black"});
			});
			dispearBox();
			startgame();
			return;
		}
		if((shape == 0 && ifNextBlack >= 3) || (shape == 1 && ifNextBlack >= 2)|| (shape == 11 && ifNextBlack >= 3)
			|| (shape == 12 && ifNextBlack >= 2)|| (shape == 13 && ifNextBlack >= 3)|| (shape == 2 && ifNextBlack >= 2)
			|| (shape == 22 && ifNextBlack >= 2)|| (shape == 21 && ifNextBlack >= 3)|| (shape == 23 && ifNextBlack >= 3)
			|| (shape == 3 && ifNextBlack >= 1)|| (shape == 31 && ifNextBlack >= 4)
		){
			clearTimeout(changeLocation);
			var ifStop = false;//是否结束游戏
			var obox_one = obox[1].split(",");
			var nx = parseInt(obox_one[0]);
			if(nx <= 2){
				ifStop = true;
				//记录当前分数
				$.ajax({
					url: "<%=basePath %>recodescore.do",
					type:"POST",
					data: "score="+score,
				});
				$.messager.confirm('game message','游戏结束，是否重新开始!',function(rt){
					if(rt){
						score = 0;
						startAgin();
					}
				});
			}else{
				changeLocation = undefined;
			}
			$.each(obox,function(i){
				var obs = obox[i].split(",");
				$("#content_game td[id='"+obs[0]+","+obs[1]+"']").attr("class","blackBox-fix");
				$("#content_game .blackBox-fix").css({"background-color":"gray","border":"1px solid black"});
			});
			if(!ifStop){
				dispearBox();
				startgame();
			}
			return;
		}
		$.each(obox,function(i){
			var obs = obox[i].split(",");
			$("#content_game td[id='"+obs[0]+","+obs[1]+"']").attr("class","whiteBox");
			$("#content_game .whiteBox").css({"background-color":"white","border":"1px solid white"});
		});
		$.each(nbox,function(i){
			var nbs = nbox[i].split(",");
			$("#content_game td[id='"+nbs[0]+","+nbs[1]+"']").attr("class","blackBox");
			$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		});
	}
	//结束游戏
	function stopgame(){
		console.info(score);
		$.ajax({
			url: "<%=basePath %>recodescore.do",
			type:"POST",
			data: "score="+score,
		});
		clearTimeout(changeLocation);
		startAgin();
	}
	//重新开始游戏
	function startAgin(){
		changeLocation = undefined;
		$("td").removeAttr("class");
		var tab = $('#tt').tabs('getSelected');  
		tab.panel('refresh'); 
	}
	//消除整行
	function dispearBox(){
		var b_level = 0;//一次性有多少行消失
		var i_last;//消失的最后一行行数
		for(var i = 17;i>=2;i--){
			var ifAllBlack = true;//一层块状区域是否全黑
			for(var j = 0;j <= 11;j++){
				var color = $("#content_game td[id='"+i+","+j+"']").attr("class");
				if(color == "whiteBox" || color == undefined){
					ifAllBlack = false;
				}
			}
			if(ifAllBlack){
				b_level += 1;
				i_last= i;
				for(var j = 0;j <= 11;j++){
					var color = $("#content_game td[id='"+i+","+j+"']").attr("class","whiteBox");
					$("#content_game .whiteBox").css({"background-color":"white","border":"1px solid white"});
				}
			}
		}
		score += b_level;
		$("#inputScore").val(score);
		var ob_box ="";
		var nb_box ="";
		 for(var a = i_last-1;a>=2;a--){
			for(var b = 0;b <= 11;b++){
				if($("#content_game td[id='"+a+","+b+"']").attr("class") == "blackBox-fix"){
					var c = a+b_level;
					ob_box += a+","+b+";";
					nb_box += c+","+b+";";
				}
			}
		}
		var ob_boxs = ob_box.split(";");
		var nb_boxs = nb_box.split(";");
		$.each(ob_boxs,function(i){
			var obs = ob_boxs[i].split(",");
			$("#content_game td[id='"+obs[0]+","+obs[1]+"']").attr("class","whiteBox");
			$("#content_game .whiteBox").css({"background-color":"white","border":"1px solid white"});
		});
		$.each(nb_boxs,function(i){
			var nbs = nb_boxs[i].split(",");
			$("#content_game td[id='"+nbs[0]+","+nbs[1]+"']").attr("class","blackBox-fix");
			$("#content_game .blackBox-fix").css({"background-color":"gray","border":"1px solid black"});
		}); 
	}
	//水平位移
	function changeHorizontalPlace(dir){
		nids="";
		oids="";
		var ifSide = false;//是否已经移动到边上
		$("#content_game .blackBox").each(function(){
			var tx = $(this).attr("id");
			oids +=tx+";";
			var txs = tx.split(",");
			txs[1] = parseInt(txs[1])+dir;
			if(txs[1] == -1 || txs[1] == 12){
				ifSide= true;
			}
			var nid = txs[0]+","+txs[1];
			if($("#content_game td[id='"+nid+"']").attr("class") == "blackBox-fix"){
				ifSide= true;
			}
			nids+=nid+";";
		});
		if(ifSide){
			return;
		}
		var obox = oids.split(";");//旧位置坐标
		var nbox = nids.split(";");//新位置坐标
		$.each(obox,function(i){
			var obs = obox[i].split(",");
			$("#content_game td[id='"+obs[0]+","+obs[1]+"']").attr("class","whiteBox");
			$("#content_game .whiteBox").css({"background-color":"white","border":"1px solid white"});
		});
		$.each(nbox,function(i){
			var nbs = nbox[i].split(",");
			$("#content_game td[id='"+nbs[0]+","+nbs[1]+"']").attr("class","blackBox");
			$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		});
		
	}
	function changeShape(){
		if(shape == 0){
			return;
		}
		var ob="";
		var nb="";
		var obs;
		var ifChange = ifChangeShape();//是否可以变形
		switch(shape){
			case 1:
				//'┻'
				ob = $("#content_game .blackBox:eq(1)").attr("id");
				obs = ob.split(",");
				nb = (parseInt(obs[0])+1)+","+(parseInt(obs[1])+1);
				changerShapes(ob,nb);
				shape = 11;
			break;
			case 11:
				//'┣'
				if(ifChange){
					ob = $("#content_game .blackBox:eq(0)").attr("id");
					obs = ob.split(",");
					nb = (parseInt(obs[0])+1)+","+(parseInt(obs[1])-1);
					changerShapes(ob,nb);
					shape = 12;
				}else{
					return;
				}
			break;
			case 12://'┳'
				ob = $("#content_game .blackBox:eq(2)").attr("id");
				obs = ob.split(",");
				nb = (parseInt(obs[0])-1)+","+(parseInt(obs[1])-1);
				changerShapes(ob,nb);
				shape = 13;
			break;
			case 13:
				//'┫'
				if(ifChange){
					ob = $("#content_game .blackBox:eq(3)").attr("id");
					obs = ob.split(",");
					nb = (parseInt(obs[0])-1)+","+(parseInt(obs[1])+1);
					changerShapes(ob,nb);
					shape = 1;
				}else{
					return;
				}
			break;
			case 2:
				//‘ ﹂ ‘
				var ob1 = $("#content_game .blackBox:eq(0)").attr("id");
				var ob2 = $("#content_game .blackBox:eq(1)").attr("id");
				ob = ob1+";"+ob2;
				var ob1s = ob1.split(",");
				var ob2s = ob2.split(",");
				var nb1 = (parseInt(ob1s[0])+2)+","+(parseInt(ob1s[1])+1);
				var nb2 = (parseInt(ob2s[0])+2)+","+(parseInt(ob2s[1])+1);
				nb = nb1+";"+nb2;
				changerShapes(ob,nb);
				shape = 21;
			break;
			case 21:
				//‘「‘
				if(ifChange){
					var ob1 = $("#content_game .blackBox:eq(0)").attr("id");
					var ob2 = $("#content_game .blackBox:eq(1)").attr("id");
					ob = ob1+";"+ob2;
					var ob1s = ob1.split(",");
					var ob2s = ob2.split(",");
					var nb1 = (parseInt(ob1s[0])+1)+","+(parseInt(ob1s[1])-2);
					var nb2 = (parseInt(ob2s[0])+1)+","+(parseInt(ob2s[1])-2);
					nb = nb1+";"+nb2;
					changerShapes(ob,nb);
					shape = 22;
				}else{
					return;
				}
			break;
			case 22:
				//‘﹁‘
				var ob1 = $("#content_game .blackBox:eq(2)").attr("id");
				var ob2 = $("#content_game .blackBox:eq(3)").attr("id");
				ob = ob1+";"+ob2;
				var ob1s = ob1.split(",");
				var ob2s = ob2.split(",");
				var nb1 = (parseInt(ob1s[0])-2)+","+(parseInt(ob1s[1])-1);
				var nb2 = (parseInt(ob2s[0])-2)+","+(parseInt(ob2s[1])-1);
				nb = nb1+";"+nb2;
				changerShapes(ob,nb);
				shape = 23;
			break;
			case 23:
				//‘」’
				if(ifChange){
					var ob1 = $("#content_game .blackBox:eq(2)").attr("id");
					var ob2 = $("#content_game .blackBox:eq(0)").attr("id");
					ob = ob1+";"+ob2;
					var ob1s = ob1.split(",");
					var ob2s = ob2.split(",");
					var nb1 = (parseInt(ob1s[0]))+","+(parseInt(ob1s[1])+2);
					var nb2 = (parseInt(ob2s[0])+2)+","+(parseInt(ob2s[1])+2);
					nb = nb1+";"+nb2;
					changerShapes(ob,nb);
					shape = 2;
				}else{
					return;
				}
			break;
			case 3:
				//‘——’
				var ob1 = $("#content_game .blackBox:eq(0)").attr("id");
				var ob2 = $("#content_game .blackBox:eq(2)").attr("id");
				var ob3 = $("#content_game .blackBox:eq(3)").attr("id");
				ob = ob1+";"+ob2+";"+ob3;
				var ob1s = ob1.split(",");
				var ob2s = ob2.split(",");
				var ob3s = ob3.split(",");
				var nb1 = (parseInt(ob1s[0])-1)+","+(parseInt(ob1s[1])+1);
				var nb2 = (parseInt(ob2s[0])+1)+","+(parseInt(ob2s[1])-1);
				var nb3 = (parseInt(ob3s[0])+2)+","+(parseInt(ob3s[1])-2);
				nb = nb1+";"+nb2+";"+nb3;
				changerShapes(ob,nb);
				shape = 31;
			break;
			case 31:
				//‘|’
				if(ifChange){
					var ob1 = $("#content_game .blackBox:eq(0)").attr("id");
					var ob2 = $("#content_game .blackBox:eq(2)").attr("id");
					var ob3 = $("#content_game .blackBox:eq(3)").attr("id");
					ob = ob1+";"+ob2+";"+ob3;
					var ob1s = ob1.split(",");
					var ob2s = ob2.split(",");
					var ob3s = ob3.split(",");
					var nb1 = (parseInt(ob1s[0])+1)+","+(parseInt(ob1s[1])-1);
					var nb2 = (parseInt(ob2s[0])-1)+","+(parseInt(ob2s[1])+1);
					var nb3 = (parseInt(ob3s[0])-2)+","+(parseInt(ob3s[1])+2);
					nb = nb1+";"+nb2+";"+nb3;
					changerShapes(ob,nb);
					shape = 3;
				}else{
					return;
				}
			break;
		}
	}
	//变形
	function changerShapes(ob,nb){
		var obs = ob.split(";");
		var nbs = nb.split(";");
		$.each(obs, function(i){
			$("#content_game td[id='"+obs[i]+"']").attr("class","whiteBox");
			$("#content_game .whiteBox").css({"background-color":"white","border":"1px solid white"});
		});
		$.each(nbs, function(i){
			$("#content_game td[id='"+nbs[i]+"']").attr("class","blackBox");
			$("#content_game .blackBox").css({"background-color":"gray","border":"1px solid black"});
		});
	}
	//判断是否可以变形
	function ifChangeShape(){
		var ifChange = true;
		var last = $("#content_game .blackBox-fix :eq(0)").attr("id");
		if(last != undefined){
			console.info(last);
			var lastid = last.split(",");
			$("#content_game .blackBox").each(function(){
				var id = $(this).attr("id");
				var ids = id.split(",");
				if((parseInt(ids[0])>=16) || ((parseInt(lastid[0]))-(parseInt(ids[0])) <= 2)){
					ifChange = false;
				}
			});
			if(shape == 31){
				$("#content_game .blackBox").each(function(){
					var id = $(this).attr("id");
					var ids = id.split(",");
					if((parseInt(ids[1])<=0) || (parseInt(ids[1])>=10)){
						ifChange = false;
					}
				});
			}else{
				$("#content_game .blackBox").each(function(){
					var id = $(this).attr("id");
					var ids = id.split(",");
					if((parseInt(ids[1])<=0) || (parseInt(ids[1])>=11)){
						ifChange = false;
					}
				});
			}
		}
		return ifChange;
	}
	//开始入口
	function startgame(){
		if(num == undefined){
			num = Math.round(Math.random() * 3);
		}
		switch(num){
			case 0:
				tianShape(); 
			break;
			case 1:
				tuShape();
			break;
			case 2:
				fuShape();
			break;
			case 3:
				hsShape();
			break;
			default:
			break;
		}
	}
	
	$("#checkScores").click(function(){
		$("#scoreRecodes").dialog({
		    title: '分数排行榜',
		    width: 520,
		    height: 400,
		    closed: false,
		    cache: false,
		    href: '<%=basePath %>jsp/scoreList.jsp',
		    modal: true
			});
	});
</script>