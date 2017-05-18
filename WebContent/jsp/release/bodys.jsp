<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/css/index.css'/>">
<link rel="stylesheet" href="<c:url value='/css/bodys.css'/>">
<script src="<c:url value='/js/index.js'/>"></script>
<script src="<c:url value='/js/myfunction (1).js'/>"></script>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/jquery-1.8.3.js'/>"></script>
<title>农村信息管理平台</title>
<style type="text/css">
	.cen{
		height:100px;
		width:1009px;
		margin: auto;
	}
	.Font18White {
	    font-family: "Î¢ÈíÑÅºÚ";
	    font-size: 18px;
	    color: #ffffff;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$.post("<c:url value='/selecttype.m?types=1'/>",function(data){
		for(var i=0;i < data.length;i++){
			 $("#bodys").append("<table cellspacing='1' bgcolor='#e4e4e4' width='100%'>"+
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
	},"json");
	$.post("<c:url value='/selecttype.m?types=2'/>",function(datad){
		for (var i = 0; i <datad.length; i++) {
				$("#bodys2").append("<table cellspacing='1' bgcolor='#e4e4e4' width='100%'>"+
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
	        						                    "<td class='Font9'><a class='five' href='<c:url value='/findarticle.m?id="+datad[i].id+"'/>' title='"+datad[i].titles+"'>"+datad[i].titles+"</a></td>"+
	        						                    "<td class='Font9' align='right' valign='middle'>["+datad[i].riqis+"]</td>"+
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
	},"json");
	$.post("<c:url value='/selecttype.m?types=3'/>",function(dataf){
		for (var i = 0; i <dataf.length; i++) {
				$("#bodys3").append("<table cellspacing='1' bgcolor='#e4e4e4' width='100%'>"+
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
	        						                    "<td class='Font9'><a class='five' href='<c:url value='/findarticle.m?id="+dataf[i].id+"'/>' title='"+dataf[i].titles+"'>"+dataf[i].titles+"</a></td>"+
	        						                    "<td class='Font9' align='right' valign='middle'>["+dataf[i].riqis+"]</td>"+
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
	},"json");
	$.post("<c:url value='/selecttype.m?types=4'/>",function(datag){
		for (var i = 0; i <datag.length; i++) {
				$("#bodys4").append("<table cellspacing='1' bgcolor='#e4e4e4' width='100%'>"+
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
	        						                    "<td class='Font9'><a class='five' href='<c:url value='/findarticle.m?id="+datag[i].id+"'/>' title='"+datag[i].titles+"'>"+datag[i].titles+"</a></td>"+
	        						                    "<td class='Font9' align='right' valign='middle'>["+datag[i].riqis+"]</td>"+
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
	},"json");
});
</script>
</head>
<body>
	<div class="cen">
		<img src="<c:url value='/image/gg_01.jpg'/>" height="100px" width="1009px">
	</div>
	<div style="width:1009px;margin: auto;">
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
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" width="35">
                                                    <img src="<c:url value='/image/table_dian_01.jpg'/>" height="10" width="35">
                                                </td>
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" align="left" valign="middle"><span class="Font18White">最新政策</span></td>
                                                <td align="left" width="10" valign="middle"><img src="<c:url value='/image/table_bk_06.jpg'/>" height="40" width="10"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                    <td background="<c:url value='/image/table_bk_03.jpg'/>">
                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                            <tbody><tr>
                                                <td class="Font12blue" align="center" valign="middle">&gt;&gt;<a class="five" href="<c:url value='/selectlong.m?types=1'/>">更多</a>
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
	                        <td id="bodys"></td>
	                     </tr>
	           </tbody>
	        </table>
	</div>
		<div style="width:1009px;margin: auto;margin-top:20px">
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
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" width="35">
                                                    <img src="<c:url value='/image/table_dian_01.jpg'/>" height="10" width="35">
                                                </td>
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" align="left" valign="middle"><span class="Font18White">政策法规</span></td>
                                                <td align="left" width="10" valign="middle"><img src="<c:url value='/image/table_bk_06.jpg'/>" height="40" width="10"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                    <td background="<c:url value='/image/table_bk_03.jpg'/>">
                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                            <tbody><tr>
                                                <td class="Font12blue" align="center" valign="middle">&gt;&gt;<a class="five" href="<c:url value='/selectlong.m?types=2'/>">更多</a>
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
	                        <td id="bodys2"></td>
	                     </tr>
	           </tbody>
	        </table>
	</div>
		<div style="width:1009px;margin: auto;;margin-top:20px">
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
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" width="35">
                                                    <img src="<c:url value='/image/table_dian_01.jpg'/>" height="10" width="35">
                                                </td>
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" align="left" valign="middle"><span class="Font18White">社会事务</span></td>
                                                <td align="left" width="10" valign="middle"><img src="<c:url value='/image/table_bk_06.jpg'/>" height="40" width="10"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                    <td background="<c:url value='/image/table_bk_03.jpg'/>">
                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                            <tbody><tr>
                                                <td class="Font12blue" align="center" valign="middle">&gt;&gt;<a class="five" href="<c:url value='/selectlong.m?types=3'/>">更多</a>
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
	                        <td id="bodys3"></td>
	                     </tr>
	           </tbody>
	        </table>
	</div>
		<div style="width:1009px;margin: auto;;margin-top:20px">
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
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" width="35">
                                                    <img src="<c:url value='/image/table_dian_01.jpg'/>" height="10" width="35">
                                                </td>
                                                <td background="<c:url value='/image/table_bk_01.jpg'/>" align="left" valign="middle"><span class="Font18White">党群管理</span></td>
                                                <td align="left" width="10" valign="middle"><img src="<c:url value='/image/table_bk_06.jpg'/>" height="40" width="10"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                    <td background="<c:url value='/image/table_bk_03.jpg'/>">
                                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                            <tbody><tr>
                                                <td class="Font12blue" align="center" valign="middle">&gt;&gt;<a class="five" href="<c:url value='/selectlong.m?types=4'/>">更多</a>
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
	                        <td id="bodys4"></td>
	                     </tr>
	           </tbody>
	        </table>
	</div>
<div style="height:50px"></div>
</body>
</html>