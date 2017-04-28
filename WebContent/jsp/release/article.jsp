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
	img{
		margin-left:164px;
		width:500px;
		height:400px;
	}
</style>
</head>
<body>
	<div>
		<table>
				<tr>
					<td style="text-align:center;font-size:24px;color:#1F5781;margin-top:10px;height:95px">${article.titles}</td>
				</tr>
				<tr>
					<td style="text-align:center;font-size:17px;margin-top:30px">发布时间：${article.riqis}</td>
				</tr>
				<tr>
					<td>${article.texts}</td>
				</tr>
		</table>
	</div>
</body>
</html>