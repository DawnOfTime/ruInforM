<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>农村信息网</title>
<link rel="shortout icon" href="<c:url value='/image/logo.ico'/>"  />
<style type="text/css">

	 a{
		text-decoration:none;
		}
		
		#bg{
			background:url(<c:url value='/image/xw_bk_01.jpg'/>) no-repeat 0 0;
			background-size:100% 100%;
		}
</style>
</head>
<body id="bg">
<div>
<table cellspacing="0" cellpadding="0" border="0" width="100%" >
    	<tr>
    		<td>
    			<jsp:include page="/jsp/release/top.jsp"></jsp:include>
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<jsp:include page="/jsp/release/left.jsp"></jsp:include>
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<jsp:include page="/jsp/release/bodys.jsp"></jsp:include>
    		</td>
    	</tr>
    	<tr><td><jsp:include page="/jsp/release/down.jsp"></jsp:include></td></tr>
   </table>
  </div>
</body>
</html>