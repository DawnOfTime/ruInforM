<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/css/index.css'/>">
<link rel="stylesheet" href="<c:url value='/css/bodys.css'/>">
<script src="<c:url value='/js/index.js'/>"></script>
<script src="<c:url value='/js/myfunction (1).js'/>"></script>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/jquery-1.8.3.js'/>"></script>
<style type="text/css">
	.left1_1{
		width:753px;
		margin-top: 335px;
	}
	 .left1_2{
		height:236px;
		width:235px;
		margin-top: 3px;
		/* -moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px; */ 
   		border: 2px solid #e9e7ef;
   		
	} 
	.left1_1_1{
		height:41px;
		width:235px;
		background-color:#5192FA;
		background-size: 100%;
		/* -moz-border-radius: 15px; 
    	-webkit-border-radius: 15px; 
   		border-radius:15px;  */
   		border: 2px solid #e9e7ef;
   		line-height: 43px;
   		font-size: 17px;
		color: white;
		margin-left: -2px;
	}
	.left1_2_1{
		height:41px;
		width:235px;
		background-color:#5192FA;
		background-size: 100%;
		/* -moz-border-radius: 15px; 
    	-webkit-border-radius: 15px;
   		border-radius:15px;  */ 
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
		.Font18White {
		    font-family: "Î¢ÈíÑÅºÚ";
		    font-size: 18px;
		    color: #ffffff;
		}
		.Font9 {
		    font-family: "ËÎÌå";
		    font-size: 9pt;
		    line-height: 20px;
		    color: #000000;
		}
		a.five:link {
		    font-family: "ËÎÌå";
		    font-size: 9pt;
		    line-height: 20px;
		    color: #000000;
		    text-decoration: none;
		}
		.button {
			display: inline-block;
			outline: none;
			cursor: pointer;
			text-align: center;
			text-decoration: none;
			font: 14px/100% Arial, Helvetica, sans-serif;
			padding: .5em 2em .55em;
			text-shadow: 0 1px 1px white(0,0,0,.3);
			-webkit-border-radius: .5em; 
			-moz-border-radius: .5em;
			border-radius: .5em;
			-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
			-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
			box-shadow: 0 1px 2px rgba(0,0,0,.2);
		}
		.button:hover {
			text-decoration: none;
		}
		.button:active {
			position: relative;
			top: 1px;
		}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$.post("<c:url value='/find.m'/>",function(data){
		for (var i = 0; i < 16; i++) {
			if(data[i].types==5){
			$("#body1").append("<table cellspacing='1' bgcolor='#e4e4e4' width='100%'>"+
                 	"<tbody>"+
     		"<tr>"+
               "<td align='center' bgcolor='#FFFFFF' valign='middle'>"+
                " <table cellspacing='0' cellpadding='0' border='0' width='96%'>"+
                   "<tbody>"+
                         "<tr>"+
						   " <td>"+
							     "<table height='29' cellspacing='0' cellpadding='0' border='0' width='100%'>"+
                                	"<tbody>"+
                                		"<tr><td align='left' background='<c:url value='/image/table_bk_04.jpg'/>' valign='middle'><table cellspacing='0' cellpadding='0' border='0' width='100%'>"+
						                    "<tbody><tr>"+
						                    "<td align='center' width='21' valign='middle'><img src='<c:url value='/image/table_bk_05.jpg'/>' height='11' width='11'></td>"+
						                    "<td class='Font9'><a class='five' href='<c:url value='/findarticle.m?id="+data[i].id+"'/>' title='"+data[i].titles+"'>"+data[i].titles+"</a></td>"+
						                    "<td class='Font9' align='right' valign='middle'>["+data[i].riqis+"]</td>"+
						                    "</tr>"+
						                   "</tbody>"+
						                " </table>"+
						                 "</td>"+
						               "</tr>"+
                                 	"</tbody>"+
                                 "</table>"+
               		 	    "</td>"+
						"</tr>"+
					"</tbody>"+
        		"</table>"); 
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
				$("#errorMessage").html(data);
			}s
		},"text");
	}
</script>
</head>
<body>
	<div style="height:655px;width:1009px;margin: auto;">
		<div style="width: 76%;float: left;">
			<div class="body2_1">
					<ul class="box">
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;张家口市万全区开展"八一"慰问驻军活动</h5>
							<img src="<c:url value='/image/lunbo/1.png'/>" alt="" class="img"></a>
						</li>
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;万全区党政军民举行烈士纪念日公祭活动</h5>
							<img src="<c:url value='/image/lunbo/2.png'/>" alt="" class="img"></a>
						</li>
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;万全区组织开展春节慰问驻军活动</h5>
							<img src="<c:url value='/image/lunbo/3.png'/>" alt="" class="img"></a>
						</li>
						<li class="imgbox">
							<a href=""><h5 class="h5">&nbsp;张家口市民宗局党组书记、局长戴贵明深入万全区进行调研</h5>
							<img src="<c:url value='/image/lunbo/4.png'/>" alt="" class="img"></a>
						</li>
						<li class="imgbox">
							<a href=""><h5 class="h5">&nbsp;区政府领导调研老年护养院工程建设情况</h5>
							<img src="<c:url value='/image/lunbo/5.png'/>" alt="" class="img"></a>
						</li>
					 <li>
					 <ul class="btn">
						  <li class="left"></li>
						  <li class="right"></li>
					    </ul>
					  </li>
					 <li>
					 <div class="boxx" style="display:none">
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					 </div>
					 </li>
				</ul>
		  	</div>
		  	<div class="left1_1">
			  	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	                     <tbody>
	                          <tr>
	                             <td>
	                                <table height="40" cellspacing="0" cellpadding="0" border="0" width="100%">
	                                   <tbody>
	                                   		<tr>
	                                          <td align="left" valign="middle">
	                                            <table cellspacing="0" cellpadding="0" border="0" width="100%">
	                                                <tbody><tr>
	                                                      <td background="<c:url value='/image/table_bk_01.jpg'/>" width="35"><img src="<c:url value='/image/table_dian_01.jpg'/>" height="10" width="35"></td>
	                                                          <td align="left" background="<c:url value='/image/table_bk_01.jpg'/>" valign="middle"><span class="Font18White">通知公告</span></td>
	                                                          <td align="left" width="10" valign="middle"><img src="<c:url value='/image/table_bk_06.jpg'/>" height="40" width="10"></td>
	                                                       </tr>
	                                                 </tbody></table>
	                                           </td>
	                                           <td background="<c:url value='/image/table_bk_03.jpg'/>">
		                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
		                                            <tbody><tr>
		                                                <td class="Font12blue" align="center" valign="middle">&gt;&gt;<a class="five" href="<c:url value='/selectlong.m?types=5'/>">更多</a>
		                                                </td>
		                                            </tr>
		                                        </tbody></table>
		                                    </td>
	                                 		</tr>
	                                    </tbody>
	                                </table>
	                              </td>
	                            </tr>
	                         <tr>
	                         	<td id="body1">
	                           </td>
	                        </tr>
	           </tbody>
	        </table>
			</div>
		</div>
	
		<div style="width:18%;float: left">
			<div class="left1_2">
				<div class="left1_2_1">
					&nbsp;<a href="<c:url value='jsp/management/login.jsp'/>" target="_block"><span style="color: white">管理信息平台登陆入口</span></a>
				</div>
				<div>
					<table align="center">
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
								<input type="button" value="登录" onclick="login()" class="button"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="left1_2">
				<div class="left1_2_1">
					&nbsp;天气预报
				</div>
				<div>
					<div class="wtleft">
						<iframe src="http://i.tianqi.com/index.php?c=code&id=9"  frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="margin-top:40px;margin-left:0;width:256px; height:123px;"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>