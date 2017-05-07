<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>农村信息网</title>
<link rel="shortout icon" href="<c:url value='/image/logo.ico'/>"  />
<link rel="stylesheet" href="<c:url value="/css/normalize.css"/>">
<style type="text/css">
	 .table{
		margin-left: -10px;
	} 
	/* body{
	background:-moz-linear-gradient(top,#66B3FF, #ECFFFF);	
	}  */
	.div1{
		width:1103px;
		margin:0 auto;
	}
	div,a,span{
		font-family:"微软雅黑";
	}
</style>
</head>
<body>
	<div class="div1">
		<div>
			<jsp:include page="/jsp/release/top.jsp"></jsp:include>
		</div>
		<div>
			<table class="table">
				<tr>
					<td>
						<iframe src="<c:url value='/jsp/release/bodys.jsp'/>" height="1175px" width="855px" marginwidth="pixels" frameborder="0" name="body"></iframe>
					</td>
					<td><jsp:include page="/jsp/release/left.jsp"></jsp:include></td>
				</tr>
			</table>
		</div>
		<div>
			<jsp:include page="/jsp/release/down.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>