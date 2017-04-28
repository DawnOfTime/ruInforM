<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/JavaScript">
        var duration = 10000;
        var timer = null;
        var endTime = new Date().getTime() + duration;
        function interval() {
            var n = (endTime - new Date().getTime()) / 1000;
            if (n < 0) return;
            document.getElementById("timeout").innerHTML = n.toFixed(0);
            setTimeout(interval, 10);
        }
        function stopJump() {
            clearTimeout(timer);
            document.getElementById("jumphint").style.display = "none";
        }
        window.onload = function() {
            timer = setTimeout("window.location.href='<c:url value='/umed/index.html'/>'", duration);
            interval();
        }

      </script>
</head>
<body>
	<h1>提交成功！</h1>
	 <span id="jumphint">系统在 <span id="timeout"></span> 秒后 将自动<a href="<c:url value='/umed/index.html'/>">返回</a></span>
</body>
</html>