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
	findAcc("","");
});
var username = "";
var acc = "";
function findacc_where(){
	username = $("#username").val();
	acc = $("#acc").val();
	findAcc(username,acc);
}
function findAcc(username,acc){
	var tabTop = "<c:url value='/json/acc.json'/>";
	var rowurl = "<c:url value='/seachacc.m?'/>";
	if(username!=""){
		rowurl+="&username="+username;
	}
	if(acc!=""){
		rowurl+="&acccode="+acc;
	}
	var posturl = "<c:url value='/saveAcc.m'/>";
	var newRow = "{\"id\":\"\",\"username\":\"\",\"acccode\":\"\",\"password\":\"\",\"isable\":\"\",\"rid\":\"\"}";
	var hidcolumns = "id,password";//隐藏列字段名
	var id = "id";//主键字段名
	var isable = [
				   	{valueField:'1',textField:'是'},
					{valueField:'0',textField:'否'}
			 	];
	//默认窗口为空
	$("#win").window({
		 closed: true,
		 onClose: function(){
			 $("#dg").datagrid("reload");
		 }
	});
	$.post("<c:url value='/getRule.m'/>",function(data){
		for (var i = 0; i < data.length; i++) {
			$("#ruleList").append("<option value='"+data[i].id+"'>"+data[i].rname+"</option>");
		}
		var rid = data;
		var formartColumns=[{
						 		 field: 'isable',
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
						 	},{
						 		 field: 'rid',
						 		 formatter:function(value, row, index){
						 			 var showTxt="";
						 			 $(rid).each(function(){
						 				 if(value==this.id){
						 					 showTxt=this.rname;
						 				 }
						 			 });
						 			 return showTxt;
						 		 },
						 		 editor: {  
						         	type: 'combobox',  
						 		    options: {  
						 		          data: rid,  
						 		          valueField: 'id',  
						 		          textField: 'rname',  
						 		          panelHeight: 'auto'  
						 		    }  
						         }  
						 	}]
		var formattercol = [{'field': "isnull",
					        'title': "操作",
					        'width': 100,
					        'align': 'center',
					        "formatter":function(value, row, index){
					    		return '<a onclick="fenpei(this)" id="btn" href="#" iconCls="icon-add">分配辖区</a>';
					        }}];
		
		pagecommCustom(tabTop,rowurl,posturl,newRow,hidcolumns,id,formattercol,formartColumns);
	},'json');
}
function pagecommCustom(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns){
	$.getJSON(tabTop, function(data){
		//表格中添加按钮
		$(formattercol).each(function(){
			data[data.length]=this;
		});
		//下拉框
		$(formartColumns).each(function(){
			var formartItem=this;
			$(data).each(function(){
				if(this.field==formartItem.field){
					this.editor=formartItem.editor;
					this.formatter=formartItem.formatter;
				}
			});
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
	        singleSelect: true,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
	        checkOnSelect: true,//选中行,不默认选中当前行的复选框
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
//分配辖区（显示组织机构树）
function fenpei(obj){
	var id = $(obj).parent().parent().parent().eq(0).children().eq(0).text();
	var rowindex = $('#dg').datagrid('getRowIndex',id);
	var row = $('#dg').datagrid('getData').rows[rowindex];
	if (row == null){
        $.messager.alert("系统提示", "请选择您要分配的账号！");
        return;
    }
    if (row){
    	$('#tt').tree({  
    		lines: true,
			checkbox: true,
   		    url:"<c:url value='/getCountryTree.m?acc.id='/>"+id
   		});
    	$("#saveid").attr("value",id);
    	$("#win").window("open");
    }
}
function save(){
	var id = $("#saveid").val();
	var countryAll=$('#tt').tree('getChecked',['checked','indeterminate']);
	var country=$('#tt').tree('getChecked');
	var countryAllCode="";// 定义一个json对象
	for(var i=0;i<countryAll.length;i++){
		countryAllCode+=countryAll[i].num;
		if(i<countryAll.length-1){
			countryAllCode+=",";
		}
	}
	countryAllCode+=";";
	for(var i=0;i<country.length;i++){
		countryAllCode+=country[i].num;
		if(i<country.length-1){
			countryAllCode+=",";
		}
	}
	if(countryAllCode.length<1){
		$.messager.confirm('提示框', '当前账号未分配辖区,确定继续?',function(r){
			if(r){
				alert(countryAllCode);
				saveRoleMenus(id,countryAllCode);
				$("#win").window("close");
			}
		});
	}else{
		$.messager.confirm('提示框', '新选择的辖区将会覆盖原来的辖区,确定继续?',function(r){
			if(r){
				alert(countryAllCode);
				saveRoleMenus(id,countryAllCode);
				$("#win").window("close");
				$("#dg").datagrid("reload");
			}
		});
	}

}
//保存
function saveRoleMenus(id,countryCode){
	$.ajax({
        type:"POST",
        url:"<c:url value='/saveAcc_Country.m'/>",
        data:{"acc.id":id,"acc.countryCode":countryCode},
        datatype: "json"
     });
}
</script>
</head>
<body>
	<table id="dg" toolbar="#searchtool"></table>
	<div id="searchtool" style="padding:5px;display:none;">
	    <span>用户名:</span><input type="text" id="username" value="" size=10 />
	    <span>账号:</span><input type="text" id="acc" value="" size=10 />
	    <a href="javascript:findacc_where()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> 
	</div>
	<div id="win" class="easyui-window" title="辖区分配" style="width:600px;height:400px;top:50px"  
        data-options="iconCls:'icon-save',modal:true">
        <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	        <div data-options="region:'center'" style="width:100%;">
		    	<ul id="tt"></ul>
		    </div> 
	        <div data-options="region:'south'" style="height:40px;width:100%;text-align:center;padding-top:5px">
	        	<input type="text" id="saveid" name="saveid"/>
			    <a href="javascript:void(0)" onclick="save()" class="easyui-linkbutton" iconcls="icon-save">保存</a>
		    </div> 
        </div>
    </div>
</body>
</html>