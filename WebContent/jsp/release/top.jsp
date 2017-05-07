
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<base target="body"/>
<style type="text/css">
	.topone{
		height:223px;
		width:100;
	}
	.toptwo{
		height: 166px;
		width: 73%;
		/* margin-left: 130px; */
		margin-top: -8px;
	}
	.topthree{
		height:46px;
		width:100%;
	}
</style>
<link href="<c:url value='/css/lanrenzhijia.css'/>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.3.js"/>"></script>
<script type="text/javascript"language="javascript">
	
		$(document).ready(function() {
			 $("#menu1 li a").wrapInner( '<span class="out"></span>' ).append( '<span class="bg"></span>' );
			$("#menu1 li a").each(function() {
				$( '<span class="over">' +  $(this).text() + '</span>' ).appendTo( this );
			});
			$("#menu1 li a").hover(function() {
				$(".out",	this).stop().animate({'top':	'40px'},	250);
				$(".over",	this).stop().animate({'top':	'0px'},		250);
				$(".bg",	this).stop().animate({'top':	'0px'},		120);
			}, function() {
				$(".out",	this).stop().animate({'top':	'0px'},		250);
				$(".over",	this).stop().animate({'top':	'-40px'},	250);
				$(".bg",	this).stop().animate({'top':	'-40px'},	120);
			});
		});
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
</head>
<body>
	<div class="topone">
		<div class="toptwo">
			<img src="<c:url value='/image/timg.png'/>" style="height:148px;width:1103px;"/>
		</div>
		<div class="topthree">
				<div id="menu1" class="menu">
				<ul>
					<li><a href="<c:url value='/jsp/release/bodys.jsp'/>">首       页</a></li>
					<li><a href="<c:url value='/selectlong.m?types=1'/>">最新咨询</a></li>
					<li><a href="<c:url value='/selectlong.m?types=2'/>">政策法规</a></li>
					<li><a href="<c:url value='/selectlong.m?types=3'/>">社会事务</a></li>
					<li><a href="<c:url value='/selectlong.m?types=4'/>">党群管理</a></li>
					<li><span style="margin-left:130px;">当前时间：</span><span id="dt"></span></li>
				</ul>
				<div class="cls"></div>
			</div>
		</div>
	</div>
</body>
</html>