<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.left1{
		height:800px;
		width:250px;
		/* background:black; */
		margin-top:-310px;
		margin-left:2px;
	}
	.left1_1{
		height:310px;
		width:250px;
		-moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px; 
   		border: 2px solid #e9e7ef;
	}
	.left1_2{
		height:300px;
		width:250px;
		margin-top: 20px;
		-moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px; 
   		border: 2px solid #e9e7ef;
   		
	}
	.left1_1_1{
		height:41px;
		width:250px;
		background:url(<c:url value='/image/jianbs.png'/>);
		background-size: 100%;
		-moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px; 
   		border: 2px solid #e9e7ef;
   		line-height: 43px;
   		font-size: 17px;
		color: white;
		margin-left: -2px;
	}
	.left1_2_1{
		height:41px;
		width:250px;
		background:url(<c:url value='/image/jianbs.png'/>);
		background-size: 100%;
		-moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px; 
   		border: 2px solid #e9e7ef;
   		line-height: 43px;
   		font-size: 17px;
		color: white;
		margin-left: -2px;
	}
	 .wtleft {
		    width: 70px;
		    float: left;
		    height: 140px;
		}
		.tr{
			height:55px;
		}
		 a{
		text-decoration:none;
		}
		.hover-element:hover{
				color:red;
			}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$.post("<c:url value='/find.m'/>",function(data){
		for (var i = 0; i < data.length; i++) {
			if(data[i].types==5){
			$("#bodys").append("<a href='<c:url value='/findarticle.m?id="+data[i].id+"'/>' class='hover-element'><span style='font-size:13px;' >&nbsp;&nbsp;&nbsp;&nbsp;"+data[i].titles+"("+data[i].riqis+")</span></a><br><br>"); 
			}
		}
	},"json");
});
	function login(){
		var acccode = $("#acccode").val();
		var password = $("#password").val();
		$.post("<c:url value='/login/ajaxlogin.m?acc.acccode='/>"+acccode+"&acc.password="+password,
				function(data){
			if(data=="success"){
				window.open("<c:url value='/login/gotoindex.m'/>");
			}else{
				$("#errorMessage").append(data);
			}
		},"text");
	}
</script>
</head>
<body>
	<div class="left1">
		<div class="left1_1">
			<div class="left1_1_1">
				&nbsp;通知公告
			</div>
			<div>
				<marquee onmouseover=this.stop(); onmouseout=this.start();  scrollAmount=1 scrollDelay=35 direction=up style="width:247px;height:258px" id="bodys">
				</marquee>
			</div>
		</div>
		<div class="left1_2">
			<div class="left1_2_1">
				&nbsp;天气预报
			</div>
			<div>
				<div class="wtleft">
					<iframe src="http://i.tianqi.com/index.php?c=code&id=9"  frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="margin-top:57px;margin-left:0;width:256px; height:123px;"></iframe>
				</div>
			</div>
		</div>
		<div class="left1_2">
			<div class="left1_2_1">
				&nbsp;<a href="<c:url value='jsp/management/login.jsp'/>" target="_block">管理信息平台登陆入口</a>
			</div>
			<div>
				<table align="center" style="margin-top:35px">
					<tr class="tr">
						<td>账号：</td>
						<td><input type="text" name="acccode" id="acccode"/></td>
					</tr>
					<tr class="tr">
						<td>密码：</td>
						<td><input type="password" name="password" id="password"/></td>
					</tr>
					<tr>
						<td colspan="2" align="right" style="color: red;width:10px" id="errorMessage">
						</td>
					</tr>
					<tr class="tr">
						<td colspan="2" align="center">
							<input type="button" value="登录" onclick="login()"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>