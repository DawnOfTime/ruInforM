
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
	.ALink {
	    font-family: "Î¢ÈíÑÅºÚ", "Arial Narrow", "Times New Roman";
	    font-weight: bold;
	    font-size: 15px;
	    line-height: 30px;
	    color: #ffffff;
	    margin-left: 18px;
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
		
	</script>
</head>
<body>
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
  <tbody>
  <tr>
    <td>
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tbody>
        	<tr>
        		<td height="185px" align="center">
        			<img src="<c:url value='/image/timg.png'/>"/>
        		</td>
        	</tr>
          <tr>
            <td style="background-color:#488BF8;height: 39px;"><table cellspacing="0" cellpadding="0" border="0" width="100%">
              <tbody><tr>
                <td align="center" valign="middle"><a class="ALink" href="<c:url value='/'/>">首     页</a> <span style="margin-left: 10px;">|</span>
                    <a class="ALink" href="<c:url value='/selectlong.m?types=1'/>">最新政策</a> <span style="margin-left: 10px;">|</span>
                    <a class="ALink" href="<c:url value='/selectlong.m?types=2'/>">政策法规</a> <span style="margin-left: 10px;">|</span>
                    <a class="ALink" href="<c:url value='/selectlong.m?types=3'/>">社会事务</a> <span style="margin-left: 10px;">|</span>
                    <a class="ALink" href="<c:url value='/selectlong.m?types=4'/>">党群管理</a> <span style="margin-left: 10px;">|</span>
                </td>
              </tr>
            </tbody></table></td>
            </tr>
        </tbody></table></td>
      </tr>
    </tbody>
    </table>
</body>
</html>