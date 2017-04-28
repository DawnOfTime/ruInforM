<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/css/index.css'/>">
<link rel="stylesheet" href="<c:url value='/css/bodys.css'/>">
<script src="<c:url value='/js/index.js'/>"></script>
<script src="<c:url value='/js/myfunction (1).js'/>"></script>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/jquery-1.8.3.js'/>"></script>
<title>农村信息管理平台</title>
<script type="text/javascript">
$(document).ready(function(){
	$.post("<c:url value='/selecttype.m?types=1'/>",function(data){
		for(var i=0;i < 7;i++){
			 $("#bodys").append("<div class='body3_2_1'id='text-hide'>"+
					"<a href='<c:url value='/findarticle.m?id="+data[i].id+"'/>' class='hover-element'>"+data[i].titles+"</a>"+
					"</div>"); 
		}
	},"json");
	$.post("<c:url value='/selecttype.m?types=2'/>",function(datad){
		for (var i = 0; i <7; i++) {
				$("#bodys2").append("<div class='body3_2_1'id='text-hide'>"+
						"<a href='<c:url value='/findarticle.m?id="+datad[i].id+"'/>' class='hover-element'>"+datad[i].titles+"</a>"+
						"</div>"); 
		}
	},"json");
	$.post("<c:url value='/selecttype.m?types=3'/>",function(dataf){
		for (var i = 0; i <7; i++) {
				$("#bodys3").append("<div class='body3_2_1'id='text-hide'>"+
						"<a href='<c:url value='/findarticle.m?id="+dataf[i].id+"'/>' class='hover-element'>"+dataf[i].titles+"</a>"+
						"</div>");
		}
	},"json");
	$.post("<c:url value='/selecttype.m?types=4'/>",function(datag){
		for (var i = 0; i <7; i++) {
				$("#bodys4").append("<div class='body3_2_1'id='text-hide'>"+
						"<a href='<c:url value='/findarticle.m?id="+datag[i].id+"'/>' class='hover-element'>"+datag[i].titles+"</a>"+
						"</div>"); 
		}
	},"json");
});
</script>
</head>
<body>
	<div class="bodyone">
	 <div id="wowslider-container1">
	 </div>	
		<div class="body2">
			<div class="body2_1">
					<ul class="box">
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;张家口市万全区开展"八一"慰问驻军活动</h5>
							<img src="<c:url value='/image/lunbo/1.png'/>" alt=""></a>
						</li>
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;万全区党政军民举行烈士纪念日公祭活动</h5>
							<img src="<c:url value='/image/lunbo/2.png'/>" alt=""></a>
						</li>
						<li class=imgbox>
							<a href=""><h5 class="h5">&nbsp;万全区组织开展春节慰问驻军活动</h5>
							<img src="<c:url value='/image/lunbo/3.png'/>" alt=""></a>
						</li>
						<li class="imgbox">
							<a href=""><h5 class="h5">&nbsp;张家口市民宗局党组书记、局长戴贵明深入万全区进行调研</h5>
							<img src="<c:url value='/image/lunbo/4.png'/>" alt=""></a>
						</li>
						<li class="imgbox">
							<a href=""><h5 class="h5">&nbsp;区政府领导调研老年护养院工程建设情况</h5>
							<img src="<c:url value='/image/lunbo/5.png'/>" alt=""></a>
						</li>
					 <li>
					 <ul class="btn">
						  <li class="left"></li>
						  <li class="right"></li>
					    </ul>
					  </li>
					 <li>
					 <div class="boxx" style="display:none">
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					    	<div class="dj"></div>
					 </div>
					 </li>
				</ul>
		  	</div>
		</div>
		<div class="bodytwo">
			<div class="bodytwo_1">
				<div class="body3">
					<div class="body3_1">&nbsp;最新咨询
						<a href="<c:url value='/selectlong.m?types=1'/>" style="font-size:17px;color:white;margin-left:260px;">更多&nbsp;>></a>
					</div>
					<div class="body3_2" id="bodys">
					</div>
				</div>
				<div class="body4">
					<div class="body4_1">&nbsp;政策法规
						<a href="<c:url value='/selectlong.m?types=2'/>" style="font-size:17px;color:white;margin-left:260px;">更多&nbsp;>></a>
					</div>
					<div class="body4_2" id="bodys2">
					</div>
				</div>
			</div>
			<div class="bodytwo_2">
				<div class="body5">
					<div class="body5_1">&nbsp;社会事务
						<a href="<c:url value='/selectlong.m?types=3'/>" style="font-size:17px;color:white;margin-left:260px;">更多&nbsp;>></a>
					</div>
					<div class="body5_2"  id="bodys3">
					</div>
				</div>
				<div class="body6">
					<div class="body6_1">&nbsp;党群管理
						<a href="<c:url value='/selectlong.m?types=4'/>" style="font-size:17px;color:white;margin-left:260px;">更多&nbsp;>></a>
					</div>
					<div class="body6_2"  id="bodys4">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>