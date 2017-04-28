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
		var tabTop = "<c:url value='/json/dictionary.json'/>";
		var rowurl = "<c:url value='/querydic.m'/>";
		var posturl = "<c:url value='/savePerson.m'/>";
		var newRow = "{\"dicid\":\"\",\"dictypecode\":\"\",\"dictypename\":\"\",\"dicname\":\"\",\"dicvalue\":\"\",\"isenabled\":\"\",\"comm\":\"\"}";
		var hidcolumns = "dicid";//隐藏列字段名
		var id = "dicid";//主键字段名
		var isable = [
					   	{valueField:'1',textField:'是'},
						{valueField:'0',textField:'否'}
				 	];
		var formartColumns=[{
						 		 field: 'isenabled',
						 		 formatter:function(value, row, index){
						 			 var showTxt="";
						 			 $(isable).each(function(){
						 				 if(value==this.valueField){
						 					 showTxt=this.textField;
						 				 }
						 			 });
						 			 return showTxt;
						 		 },
						 		 editor: {  
						         	type: 'combobox',  
						 		    options: {  
						 		          data: isable,  
						 		          valueField: 'valueField',  
						 		          textField: 'textField',  
						 		          panelHeight: 'auto'  
						 		    }  
						         }  
						 	}]
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id,"",formartColumns);
		
	});
</script>
</head>
<body>
<table id="dg"></table>
</body>
</html>