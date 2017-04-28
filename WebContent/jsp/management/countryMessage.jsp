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
	 $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 findCountryMessage(node.num,node.text,node.level);
	 	 }
	 });
});
var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
function findCountryMessage(cnum,text,level){
	var tabTop = "<c:url value='/json/villagemessage.json'/>";
	var rowurl = "<c:url value='/countryMessage/findCountryMessage.m?country.num='/>"+cnum+"&country.level="+level;
	var hidcolumns = "id,cid,operate_time,operator";
	var id = "id";
	var frozenColumns = [{field:'ck',checkbox:true}];
	$.getJSON(tabTop, function(data){
		datagrid = $('#dg').datagrid({ 
	        columns:[data],
	        nowrap: false, 
	        striped: true, 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        url: rowurl,
	        remoteSort:false,  
	        singleSelect: true,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
	        checkOnSelect:true,//选中行,不默认选中当前行的复选框
	        idField: id,
	        frozenColumns:[frozenColumns]
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				datagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
			}
		}
		//设置分页控件 
	    var p = $('#dg').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    });
	});
}
function findCountryAllMessage(){
	var rows=datagrid.datagrid("getChecked");
	if(rows.length>1){
		$.messager.alert("提示", "请选择单个要查看的行！", "info");  
	}else if(rows.length<1){
		$.messager.alert("提示", "请选择要查看的行！", "info");  
	}else{
		var cid = rows[0].cid;
		window.open("<c:url value='/countryMessage/findCountryAllMessage.m?country_message.cid='/>"+cid,
				"newwindow",
				"height=700,width=1350,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, "
				+"resizable=no,location=no, status=no, z-look=yes");
	}
}
</script>
<style type="text/css">
	#country_message tr{
		background:#DCDCDC;
	}
	#country_message textarea{
		font-size: 13px;
	}
	#country_message td{
		height: 50px;
		width: 150px;
	}
	#country_message th{
		height: 50px;
		width: 150px;
	}
	#country_message input{
		height: 50px;
		width: 150px;
	}
</style>
</head>
<body class="easyui-layout">
    <div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'信息'" style="padding:5px;background:#eee;">
    	<table id="dg" toolbar="#searchtool"></table>
    	<!-- 工具栏 -->
    	<div id="searchtool" style="padding:5px;display:none;">
	        <a href="javascript:findCountryAllMessage()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">详情</a>
	    <div>
    </div>
</body>
</html>