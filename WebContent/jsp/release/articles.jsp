<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	 a{
		text-decoration:none;
	}
	.div1{
		 height:1000px;
		width:810px;
		margin-top:30px;
		border :2px solid #e9e7ef;
	}
	.div1_1{
		height:41px;
		width:800px;
		line-height:43px;
		font-size:17px;
		background-image:url(image/zhuye.jpg); 
	}
	.div2{
		height:900px;
		width:800px;
		margin:0 auto;
		margin-top:10px;
		text-overflow: ellipsis;
		white-space: nowrap;
		overflow: hidden;
	}
	.div3{
		height:35px;
		width:800px;
		line-height: 43px;
		border-bottom: 1px dotted black;
		margin-top:10px;
	}
	 a:hover{
				color:red;
			} 
</style>
</head>
<body>
	<div class="div1">
		<div class="div2">
			<div class="div1_1">
				<c:if test="${types==1}">&nbsp;&nbsp;最新咨询</c:if>	
				<c:if test="${types==2}">&nbsp;&nbsp;政策法规</c:if>
				<c:if test="${types==3}">&nbsp;&nbsp;社会事务 </c:if>
				<c:if test="${types==4}">&nbsp;&nbsp;党群管理</c:if>
			</div>
			<c:forEach items="${pageBean.beanList}" var="art">
				<a href='<c:url value='/findarticle.m?id=${art.id}'/>'>
					<div class="div3">&nbsp;&nbsp;
						${art.titles}
						${art.riqis}
					</div>
				</a>
			</c:forEach>
		</div>
	</div>
<jsp:include page="paging.jsp"></jsp:include>
</body>
</html>