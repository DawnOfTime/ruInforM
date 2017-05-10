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
		height:900px;
		width:1009px;
		border :2px solid #e9e7ef;
		margin-top:10px;
	}
	.div1_1{
		font-family: "Î¢ÈíÑÅºÚ", "Arial Narrow", "Times New Roman";
	    font-size: 17px;
	    background-color:#5192FA;
	    line-height: 45px;
	    color: #ffffff; 
	}
	 a:hover{
				color:red;
			} 
	.Font9 {
		    font-family: "ËÎÌå";
		    font-size: 14px;
		    height: 26px; 
		    color: #000000;
		    width:980px;
		    border-bottom: 1px dotted black;
		    margin-left: 6px;
			margin-top: 6px;
		}
		a.five:link {
			font-family: "ËÎÌå";
		    font-size: 14px;
		    line-height: 20px;
		    color: #000000;
		    text-decoration: none;
		   
		}
		#bg{
			background:url(<c:url value='/image/xw_bk_01.jpg'/>) no-repeat 0 0;
			background-size:100% 100%;
		}
</style>
</head>
<body  id="bg">
<jsp:include page="top.jsp"></jsp:include>
<div style="margin:auto;width:1009px">
	<div class="div1">
		<div class="div2">
			<div class="div1_1">
				<c:if test="${types==1}">&nbsp;&nbsp;最新咨询</c:if>	
				<c:if test="${types==2}">&nbsp;&nbsp;政策法规</c:if>
				<c:if test="${types==3}">&nbsp;&nbsp;社会事务 </c:if>
				<c:if test="${types==4}">&nbsp;&nbsp;党群管理</c:if>
			</div>
			<c:forEach items="${pageBean.beanList}" var="art">
					<div style="width:1009px;margin: auto;">
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tbody>
									<tr>
										<td align="center" width="1%" valign="middle"><img src="<c:url value='image/table_bk_05.jpg'/>" height="11" width="11" style="margin-left:5px"></td>
										<td>
											<div class="Font9">
												<a class="five" href="<c:url value='/findarticle.m?id=${art.id}'/>" title="${art.titles}">
												${art.titles}&nbsp;&nbsp;&nbsp;&nbsp;${art.riqis}</a>
											
											</div>
										</td>
									</tr>
								</tbody>
							</table>
					</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="paging.jsp"></jsp:include>
</div>
<jsp:include page="down.jsp"></jsp:include>
</body>
</html>