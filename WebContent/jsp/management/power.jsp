<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
	$(document).ready(function(){
		var tabTop = "<c:url value='/json/power.json'/>";
		var rowurl = "<c:url value='/rule/findRule.m'/>";
		var posturl = "<c:url value='/rule/save.m'/>";
		var newRow = "{\"id\":\"\",\"rname\":\"\",\"menucode\":\"\",\"comm\":\"\"}";
		var hidcolumns = "id";//隐藏列字段名
		var id = "id";//主键字段名
		var formattercol = [{'field': "isnull",
					        'title': "操作",
					        'width': 100,
					        'align': 'center',
					        "formatter":function(value, row, index){
					    		return '<a onclick="fenpei(this)" id="btn" href="#" iconCls="icon-add">分配菜单</a>';
					        }}];
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id,formattercol);
		$("#win").window({
			 closed: true
		 });
	});
function pagecomm(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol){
	$.getJSON(tabTop, function(data){
		//表格中添加按钮
		$(formattercol).each(function(){
			data[data.length]=this;
		});
		datagrid = $('#dg').datagrid({ 
	        columns:[data],
	        width: 700, 
	        height: 'auto', 
	        nowrap: false, 
	        striped: true, 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        url:rowurl, 
	        remoteSort:false,  
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
	        checkOnSelect:false,//选中行,不默认选中当前行的复选框
	        idField: id
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
function fenpei(obj){
	var id = $(obj).parent().parent().parent().eq(0).children().eq(0).text();
	var rowindex = $('#dg').datagrid('getRowIndex',id);
	var row = $('#dg').datagrid('getData').rows[rowindex];
	if (row == null){
        $.messager.alert("系统提示", "请选择您要修改的数据！");
        return;
    }
    if (row){
    	$('#tt').tree({  
    		lines: true,
			checkbox: true,
   		    url:"<c:url value='/rule/getTree.m?rule.id='/>"+id
   		});
    	$("#saveid").attr("value",id);
    	$("#win").window("open");
    }
}
function save(){
	var roleid = $("#saveid").val();
	var menus=$('#tt').tree('getChecked');
	var menuIds="";// 定义一个json对象
	for(var i=0;i<menus.length;i++){
		menuIds+=menus[i].id;
		if(i<menus.length-1){
			menuIds+=",";
		}
	}
	if(menus.length<1){
		$.messager.confirm('提示框', '当前角色未选权限,确定继续?',function(r){
			if(r){
				saveRoleMenus(roleid,menuIds);
				$("#win").window("close");
			}
		});
	}else{
		$.messager.confirm('提示框', '新选择的权限将会覆盖原来的权限,确定继续?',function(r){
			if(r){
				saveRoleMenus(roleid,menuIds);
				$("#win").window("close");
				$("#dg").datagrid("reload");
			}
		});
	}

}
//保存
function saveRoleMenus(roleid,menuIds){
	$.ajax({
        type:"POST",
        url:"<c:url value='/rule/saveTreeMenu.m'/>",
        data:{"rule.id":roleid,"rule.menucode":menuIds},
        datatype: "json"
     });
}
</script>
</head>
<body>
	<table id="dg"></table>
	<div id="win" class="easyui-window" title="权限设置" style="width:600px;height:400px;top:50px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">
        <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	        <div data-options="region:'center'" style="width:100%;">
		    	<ul id="tt"></ul>
		    </div> 
	        <div data-options="region:'south'" style="height:40px;width:100%;text-align:center;padding-top:5px">
	        	<input type="hidden" id="saveid" name="saveid"/>
			    <a href="javascript:void(0)" onclick="save()" class="easyui-linkbutton" iconcls="icon-save">保存</a>
		    </div> 
        </div>
    </div>
</body>
</html>