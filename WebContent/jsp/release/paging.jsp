<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>   
    <%@ page  import="java.net.URLEncoder"  %>
   	<% String path=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
	.a a{
		color:bule;
	}
</style>
</head>
<body>		
				<table align="center" border="0" class="a">
					<tr>
						<td colspan="4">
							共:${pageBean.totalrecord}篇文章&nbsp;&nbsp;
							<a href="#" onclick="sumitPage(1)">首页</a>
							<c:if test="${pageBean.pagecode>1 }">
							<a href="#" onclick = "sumitPage(${pageBean.pagecode-1})">上一页</a>
							</c:if>
						<!-- </td>
						<td> -->
						<c:choose>
						<c:when test="${pageBean.totalpage<=3}">
							<c:set var="begin" value="1"/>
							<c:set var="end" value="${pageBean.totalpage}"/>
						</c:when>
						<c:otherwise>
							<%--当总页数大于3，通过公式计算出begin和end --%>
							<c:set var="begin" value="${pageBean.pagecode-1}"/>
							<c:set var="end" value="${pageBean.pagecode+1}"/>
							<%--头溢出 --%>
							<c:if test="${begin<1}">
								<c:set var="begin" value="1"/>
								<c:set var="end" value="3"/>
							</c:if>
							<%--尾溢出 --%>
							<c:if test="${end>pageBean.totalpage}">
								<c:set var="begin" value="${pageBean.totalpage-2}"/>
								<c:set var="end" value="${pageBean.totalpage}"/>
							</c:if>
						</c:otherwise>
					</c:choose>					
						<%--循环遍历页码列表 --%>
						<c:if test="${pageBean.totalpage==0}">
							<c:set var="end" value="1"/>
						</c:if>
						<c:forEach var="i" begin="${begin}" end="${end}">
							<c:choose>
								<c:when test="${i eq pageBean.pagecode}">
									[${i}]
								</c:when>
								<c:otherwise>
									<font color="red">
										<a href="#" onclick = "sumitPage(${i})">[${i}]</a>
									</font>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageBean.pagecode<pageBean.totalpage }">
						<a href="#" onclick = "sumitPage(${pageBean.pagecode+1})">下一页</a>
						</c:if>
						<a href="#" onclick="sumitPage(${pageBean.totalpage})">尾页</a>
						&nbsp;&nbsp;
						页次:${pageBean.totalpage}/${pageBean.pagecode}
						&nbsp;&nbsp;
						${pageBean.pagesize}篇文章/页
					</td>
				</tr>
			</table>
			<%-- ${pageBean.pagecode-1} --%>
		<form action="${pageBean.url}" method="post" id="pageform">
		</form>
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.3.js"/>"></script>
<script type="text/javascript">
	function sumitPage(pagecode){
		var formval = $("#pageform").attr(".m");
		//formval=encodeURI(encodeURI(formval));
		formval+="&pagecode="+pagecode;
		$("#pageform").attr(".m",formval);
		$("#pageform").submit();
		
		
	}
</script>
</body>
</html>