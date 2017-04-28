<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="/js/examine.js"/>"></script>
<link href="/umed/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript"> 
	$(document).ready(function(){
		var tabTop = "<c:url value='/json/article.json'/>";
		var rowurl = "<c:url value='/queryExamine.m'/>";
		var posturl = "";
		var newRow = "{\"id\":\"\",\"titles\":\"\",\"riqis\":\"\",\"types\":\"\",\"state\":\"\",\"operator\":\"\",\"operate_time\":\"\",\"remarks\":\"\"}";
		var hidcolumns = "id";//隐藏列字段名
		var id = "id";//主键字段名
		var formartColumns;
		$.post("<c:url value='/Examine/findOption.m'/>",function(optiondata){
			var state = optiondata.state;
			var types = optiondata.types;
			formartColumns = [{	
				field: 'state',
				formatter:function(value, row, index){
					var showTxt="";
					$(state).each(function(){
					 	if(value==this.dicvalue){
					 		showTxt=this.dicname;
					 	}
					});
					return showTxt;
				},
				editor: {  
				    type: 'combobox',  
				 	options: {  
				 		data: state,  
				 		valueField: 'dicvalue',  
				 		textField: 'dicname',  
				 		panelHeight: 'auto'  
				 	}  
				}  
			},
			{
			field: 'types',
			formatter:function(value, row, index){
				var showTxt="";
				$(types).each(function(){
				 	if(value==this.dicvalue){
				 		showTxt=this.dicname;
				 	}
				});
				return showTxt;
			},
			editor: {  
			    type: 'combobox',  
			 	options: {  
			 		data: types,  
			 		valueField: 'dicvalue',  
			 		textField: 'dicname',  
			 		panelHeight: 'auto'  
			 	}  
			}  
		}
			];
		release(tabTop,rowurl,posturl,newRow,hidcolumns,id,"",formartColumns);
	},"json");
	});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',title:'审核'" >
    	<table id="dg" toolbar="#searchtool"></table>
    </div>
</body>
</html>