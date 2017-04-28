<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>农村信息管理系统</title>
<link rel="shortout icon" href="<c:url value='/image/logo.ico'/>"  />
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.3.js"/>"></script>
<style>
	.divcenter{  
	   position:absolute;/*层漂浮*/ 
	   top:50%;  
	   left:50%;  
	   width:500px;  
	   height:400px;  
	   margin-top:-200px;/*注意这里必须是DIV高度的一半*/  
	   margin-left:-250px;/*这里是DIV宽度的一半*/  
	   /* border:2px solid black;  */
	   background:#ffffff;
	   /* filter:alpha(opacity:70); */
	   /* opacity:0.5; */
	   background: rgba(255,255,255, 0.5);
	 } 
	 #change{
		width:100%;
		height:100px;
		FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#3797ca,endColorStr=#ffffff); /*IE*/
		background:-moz-linear-gradient(top,#3797ca,#ffffff);/*火狐*/
		background:-webkit-gradient(linear, 100% 0%, 0% 0%,from(#3797ca), to(#ffffff));/*谷歌*/  
	}
	.logan{ 
	 	line-height:35px;
		height:35px;
		width:140px;
		color:#000000;
		background-color:#ededed;
		font-size:16px;
		font-weight:normal;
		font-family:Arial;
		background:-webkit-gradient(linear, left top, left bottom, color-start(0.05, #ffffff), color-stop(1, #c9c7c7));
		background:-moz-linear-gradient(top, #ffffff 5%, #c9c7c7 100%);
		background:-o-linear-gradient(top, #ffffff 5%, #c9c7c7 100%);
		background:-ms-linear-gradient(top, #ffffff 5%, #c9c7c7 100%);
		background:linear-gradient(to bottom, #ffffff 5%, #c9c7c7 100%);
		background:-webkit-linear-gradient(top, #ffffff 5%, #c9c7c7 100%);
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#c9c7c7',GradientType=0);
		border:1px solid #dcdcdc;
		-webkit-border-top-left-radius:10px;
		-moz-border-radius-topleft:10px;
		border-top-left-radius:10px;
		-webkit-border-top-right-radius:10px;
		-moz-border-radius-topright:10px;
		border-top-right-radius:10px;
		-webkit-border-bottom-left-radius:10px;
		-moz-border-radius-bottomleft:10px;
		border-bottom-left-radius:10px;
		-webkit-border-bottom-right-radius:10px;
		-moz-border-radius-bottomright:10px;
		border-bottom-right-radius:10px;
		text-align:center;
		display:inline-block;
		text-decoration:none;
	}
	.logan:hover {
		background-color:#f5f5f5;
		background:-webkit-gradient(linear, left top, left bottom, color-start(0.05, #c9c7c7), color-stop(1, #ffffff));
		background:-moz-linear-gradient(top, #c9c7c7 5%, #ffffff 100%);
		background:-o-linear-gradient(top, #c9c7c7 5%, #ffffff 100%);
		background:-ms-linear-gradient(top, #c9c7c7 5%, #ffffff 100%);
		background:linear-gradient(to bottom, #c9c7c7 5%, #ffffff 100%);
		background:-webkit-linear-gradient(top, #c9c7c7 5%, #ffffff 100%);
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#c9c7c7', endColorstr='#ffffff',GradientType=0);
	}
	
	#sub{
		border-radius:5px;
	}
</style>
</head>
<body>
	<div  id="change" style="position:absolute; left:0; top:0; width:100%; height:100%"></div>
	<div class="divcenter" align="center">
		<form action="<c:url value='/login/findAcc.m'/>" method="post">
			<table><br>
				<tr>
					<td colspan="2">
						<img src="<c:url value='/image/logo.png'/>" align="absmiddle" width="230px">
					</td>
				</tr>
				<tr>
					<td height="35px"></td>
				</tr>
				<tr>
					<td style="font-size: 20px;color: #3897ca">账号：</td>
					<td><input type="text" id="username" name="acc.acccode" style="height: 30px;width: 200px"/></td>
				</tr>
				<tr>
					<td colspan="2" height="30px" id="username_er" style="color:#FF0000;font-size:13px"  align="right"></td>
				</tr>
				<tr>
					<td style="font-size: 20px;color: #3897ca">密码：</td>
					<td><input type="password"  id="password" name="acc.password" style="height: 30px;width: 200px"/></td>
				</tr>
				<tr>
					<td colspan="2" height="30px" id="password_er"style="color:#FF0000;font-size:13px" align="right" >
						${errorMessage}
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input id="sub" class="logan" type="submit" value="登录" style="width:140px;height:35px"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>