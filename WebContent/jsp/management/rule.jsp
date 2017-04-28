<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		var tabTop = "<c:url value='/json/rule.json'/>";
		var rowurl = "<c:url value='/rule/findRule.m'/>";
		var posturl = "<c:url value='/rule/save.m'/>";
		var newRow = "{\"id\":\"\",\"rname\":\"\",\"menucode\":\"\",\"comm\":\"\"}";
		var hidcolumns = "id";//隐藏列字段名
		var id = "id";//主键字段名
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id);
	});
</script>
</head>
<body>
	<table id="dg"></table>
</body>
</html>