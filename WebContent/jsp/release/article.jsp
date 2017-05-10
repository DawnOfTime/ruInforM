<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
	div{
		width:810px;
		margin-top:30px;
		border :2px solid #e9e7ef;
	}
	/* #tupian  img{
		margin-left:268px;
		width:500px;
		height:400px;
	} */
	 a{
		text-decoration:none;
		}
	#bg{
			background:url(<c:url value='/image/xw_bk_01.jpg'/>) no-repeat 0 0;
			background-size:100% 100%;
		}
</style>
<script src="<c:url value='/js/jquery-1.8.3.js'/>"></script>

</head>
<body id="bg">
	<jsp:include page="top.jsp"></jsp:include>
	<div  style="width:1009px;margin: auto;" >
		<table>
				<tr id="tupian">
					<td  style="text-align:center;font-size:24px;color:#1F5781;margin-top:10px;height:95px">${article.titles}</td>
				</tr>
				<tr>
					<td style="text-align:center;font-size:17px;margin-top:30px">发布时间：${article.riqis}</td>
				</tr>
				<tr>
					<td>${article.texts}</td>
				</tr>
		</table>
	</div>
		<jsp:include page="down.jsp"></jsp:include>
		
		
	<script type="text/javascript">
		$(document).ready(function(){
			$("p").each(function(i){
				var str = $(this).html();
				if(str.substring(1,4)=="img"){
					$(this).css("text-align","center");
				}
			});
		});
	</script>
</body>
</html>