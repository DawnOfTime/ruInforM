<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
<% String path = request.getContextPath(); %>      
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>农村信息管理系统</title>
<link rel="shortout icon" href="<c:url value='/image/logo.ico'/>"  />
<script type="text/javascript">
$(document).ready(function(){
	$.post("<c:url value='/login/showMenu.m'/>",function(data){
		var root=data.root;
		var menulist = "";
		for (var i = 0; i < root.length; i++) {
			var rootcode=root[i].num;
			var itemchild=data[rootcode];
			
            for (var j = 0; j < itemchild.length; j++) {
                menulist += "<div class='twomenu'><a style='text-decoration: none;color:black' target='mainFrame' value='<%= request.getContextPath() %>"+itemchild[j].menuurl+"'>" + itemchild[j].name + "</a></div> ";  
			}
			$(".easyui-accordion").accordion("add", {  
	            title: root[i].name,  
	            content:menulist  
	        })
	        menulist = "";
		}
		$(".twomenu").bind('click',function(){
			var tit=$(this).children().text();
			var url=$(this).children().attr("value");
			addTab(tit,url);
		})
	},"json");
	$('#wsmu').accordion('select',true);  
	$(function() {
	    tabClose();
	    tabCloseEven();
	});
});
function addTab(tit, url) {
	if (!$('#tt').tabs('exists', tit)) {
		$('#tt').tabs('add',{
			title:tit,
			content:createFrame(url),
			closable:true
		});
	} else {
		$('#tt').tabs('select', tit);
	    $('#mm-tabupdate').click();
	}
	tabClose();
}
function createFrame(url) {
    var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
    return s;
}
function tabClose() {
    /* 双击关闭TAB选项卡 */
    $(".tabs-inner").dblclick(function() {
        var subtitle = $(this).children(".tabs-closable").text();
        $('#tt').tabs('close', subtitle);
    });
    /* 为选项卡绑定右键 */
    /* $(".tabs-inner").bind('contextmenu', function(e) {
        $('#mm').menu('show', {
            left: e.pageX,
            top: e.pageY
        });

        var subtitle = $(this).children(".tabs-closable").text();

        $('#mm').data("currtab", subtitle);
        $('#tabs').tabs('select', subtitle);
        return false;
    }); */
}
// 绑定右键菜单事件
function tabCloseEven() {
    // 刷新
    $('#mm-tabupdate').click(function() {
        var currTab = $('#tt').tabs('getSelected');
        var url = $(currTab.panel('options').content).attr('src');
        $('#tt').tabs('update', {
            tab: currTab,
            options: {
                content: createFrame(url)
            }
        });
    });
    // 关闭当前
    $('#mm-tabclose').click(function() {
        var currtab_title = $('#mm').data("currtab");
        $('#tt').tabs('close', currtab_title);
    });
    // 全部关闭
    $('#mm-tabcloseall').click(function() {
        $('.tabs-inner span').each(function(i, n) {
            var t = $(n).text();
            $('#tt').tabs('close', t);
        });
    });
    // 关闭除当前之外的TAB
    $('#mm-tabcloseother').click(function() {
        $('#mm-tabcloseright').click();
        $('#mm-tabcloseleft').click();
    });
    // 关闭当前右侧的TAB
    $('#mm-tabcloseright').click(function() {
        var nextall = $('.tabs-selected').nextAll();
        if (nextall.length == 0) {
            // msgShow('系统提示','后边没有啦~~','error');
            alert('后边没有啦~~');
            return false;
        }
        nextall.each(function(i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tt').tabs('close', t);
        });
        return false;
    });
    // 关闭当前左侧的TAB
    $('#mm-tabcloseleft').click(function() {
        var prevall = $('.tabs-selected').prevAll();
        if (prevall.length == 0) {
            alert('到头了，前边没有啦~~');
            return false;
        }
        prevall.each(function(i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tt').tabs('close', t);
        });
        return false;
    });

}
//退出
function exit(){
	window.location.href="<c:url value='/login/exit.m'/>";
}
  //从服务器上获取初始时间
	var currentDate = new Date(<%=new java.util.Date().getTime()%>);
	function run(){
		currentDate.setSeconds(currentDate.getSeconds()+1);
		var time = "";
		var year = currentDate.getFullYear();
		var month = currentDate.getMonth() + 1;
		var day = currentDate.getDate();
		var hour = currentDate.getHours();
		var minute = currentDate.getMinutes();
		var second = currentDate.getSeconds();
		
		if(hour < 10){
			time += "0" + hour;
		}else{
			time += hour;
		}
		time += ":";
		if(minute < 10){
			time += "0" + minute;
		}else{
			time += minute;
		}
		time += ":";
		if(second < 10){
			time += "0" + second;
		}else{
			time += second;
		}
		document.getElementById("dt").innerHTML = year+"年"+month+"月"+day+"日" + time;
	}
	window.setInterval("run();", 1000);
</script>
<style type="text/css">
	#wsmu .panel-title{
		height:30px;
		font-size:16px;
		line-height:30px;
		text-align:center;
	}
	.twomenu{
		height:30px;
		border-bottom:1px solid #95b8e7;
	}
	.twomenu a{
		display:block;
		height:30px;
		line-height:30px;
		font-size:13px;
		text-align:center;
	}
	#change{
		background:url(<c:url value='/image/4.png'/>) no-repeat 0 0;
	}
	
	.box{
			width: 130px;
			height: 25px;
			/* background: red; */
			position: relative;
		}
		.box1{
			width: 90px;
			height: 40px;
			text-align: center;
			line-height: 30px;
			padding: 0 20px;
			border-top: 1px dashed #e0e0e0;
			/* background: white; */
			display: none;
			position: absolute;
			top: 25px;
			left: 0px;
		}
		.box:hover .box1{
			display: block;
		}
	#change{
		/* width:100%;
		height:100px;
		FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#3797ca,endColorStr=#ffffff); */ /*IE*/
		/* background:-moz-linear-gradient(left,#ffffff,#3797ca); *//*火狐*/
		/* background:-webkit-gradient(linear, 100% 0%, 0% 0%,from(#3797ca), to(#ffffff)); *//*谷歌*/
	}
</style>
</head>
<body class="easyui-layout">
<%
	if(null==session||null==session.getAttribute("resultacc")){
		response.sendRedirect("/ruInforM/jsp/management/login.jsp");
	}
%>
<%
	Calendar rightNow = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	%>
	<div region="north" style="height:80px;" id="ba"> <!-- 上  -->
		<div title="" class="layout-body panel-body panel-body-noheader panel-body-noborder" id="change" region="north" split="true" border="false" style="overflow: hidden; height: 100%;  line-height: 30px; width: 100%;">
	        <span style="float: right; padding-right: 20px; font-size: 15px;height:30px;line-height:30px" class="head">
	        	欢迎&nbsp;${resultacc.rulename}&nbsp;${resultacc.username}&nbsp;(${resultacc.acccode})&nbsp;&nbsp;&nbsp;
	        	<a href="#" onclick="exit()" style="color: black">
	        		[退出]
		        	<%-- <input type="image" src="<c:url value='/images/close.png'/>" style="width:30px;"/> --%>
	        	</a>
	        </span> 
	        <span style="float: right;margin-right:-250px; margin-top: 50px;font-size: 15px">
	        	<span style="color: blue">当前时间：</span><span id="dt"></span>
	        </span>
	        <span style="padding-left: 10px;font-size: 40px;font-family:楷体; float: left;">
	            <%-- <img src="<c:url value='/image/logo.png'/>" align="absmiddle" width="180px"> --%>
	        </span>
    	</div>
    </div>
    <div region="south" style="height:40px;font-size: 18px;text-align: center;color: #3797ca"><!-- 下 -->
    
    </div>  
    <div data-options="region:'west',title:'导航菜单',split:true"  style="width:250px;"><!-- 左 -->
    	<div id="wsmu" class="easyui-accordion"></div>
    </div>
    <div region="center" style="background:#eee;">
    	<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
    		<div title="welcome" id="welcome">
    			<img alt="<c:url value="/image/zhuye.jpg"/>" src="<c:url value="/image/zhuye.jpg"/>" width="100%">
    		</div>
    	</div>
    </div>
    
    <div id="mm" class="easyui-menu" style="width: 150px;">
        <div id="mm-tabupdate">
           	 刷新
        </div>
        <div class="menu-sep">
        </div>
        <div id="mm-tabclose">
          	  关闭
        </div>
        <div id="mm-tabcloseall">
          	  全部关闭
        </div>
        <div id="mm-tabcloseother">
			  除此之外全部关闭
		</div>
        <div class="menu-sep">
        </div>
        <div id="mm-tabcloseright">
           	 当前页右侧全部关闭
        </div>
        <div id="mm-tabcloseleft">
            	当前页左侧全部关闭
        </div>
        <div class="menu-sep">
        </div>
        <div id="mm-exit">
           	 退出
        </div>
    </div>
</body>
</html>