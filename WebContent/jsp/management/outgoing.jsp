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
	$('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 if($('#tt').tree("find",node.id).level==5){
	    		 $("#cid").val(node.id);
	    		 findOutgoing("");
	    	 }
		 }
	 });
	$("#win").window({
		closed: true
	});
	$("#historywin").window({
		closed: true,
		maximized: true
	});
	//定义验证类型
	 $.extend($.fn.validatebox.defaults.rules, {
		name : {
           validator : function(value, param) {  
           	return /^[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value);
           },  
           message : '请输入姓名'  
       }
	 });
});
function findOutgoing(OutgoingName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/outgoing.json'/>";
	var rowurl = "<c:url value='/out/seachOutgoing.m?cid='/>"+cid+OutgoingName;
	var hidcolumns = "id,cid";//隐藏列字段名s
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	//锁定列
	$.post("<c:url value='/out/findOption.m'/>",function(optiondata){
		var sex = optiondata.sex;
		formartColumns = [{	
								field: 'sex',
								formatter:function(value, row, index){
									var showTxt="";
									$(sex).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: sex,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							}
							];
	//锁定列
	$.getJSON(tabTop, function(data){
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
		datagrid = $('#outgoing').datagrid({ 
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
	        checkOnSelect:true,//选中行,不默认选中当前行的复选框
	        idField: id,
	        frozenColumns:[[{field:'ck',checkbox:true}]], 
	        onAfterEdit: function (rowIndex, rowData, changes) {
	            editRow = undefined;
	        },onBeforeLoad:function(){			//在请求载入数据之前触发
	        	if (editRow != undefined) {
	            	datagrid.datagrid('endEdit', editRow);
	            }
	        },onDblClickRow:function (rowIndex, rowData) {
	        	if (editRow != undefined) {
	            	datagrid.datagrid('endEdit', editRow);
	            }
	            if (editRow == undefined) {
	            	editRow=rowIndex;
	            	datagrid.datagrid('beginEdit', rowIndex);
	            	if(rowData.id!=""){
	            		var cellEdit = datagrid.datagrid('getEditor', {index:rowIndex,field:'username'});
						var $input = cellEdit.target; // 得到文本框对象
						$input.attr('readonly',true); // 设值只读
	            	}
	                
	            }
	        },onClickRow:function(rowIndex,rowData){
	            if (editRow != undefined) {
	            	datagrid.datagrid('endEdit', editRow);
	            }
	        },onSelect:function(rowIndex, rowData){
	        	datagrid.datagrid('endEdit', editRow);
	        	datagrid.datagrid('unselectRow',rowIndex);//不选中行
	        },
	        onCheckAll:function(rows){
	        	datagrid.datagrid('unselectAll');
	        }
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				datagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
			}
		}
	    //设置分页控件 
	    var p = $('#outgoing').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
	});
	},'json');
}
function addOutgoing(){
		$("#win").window('open');
}
function findOutgoingWhere(){
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+$("#name").val();
	}
	findOutgoing(personWhere);
}

function saveaddOutgoing(){
	var cid = $("#cid").val();
	$("#addOutgoing").form("submit", {
        url: "<c:url value='/out/addOutgoing.m?countyoutgoing.cid='/>"+cid,
        onSubmit: function () {
   		 	$("#form_cid").val($("#cid").val());
        	if(!$(this).form("validate")){
        		$.messager.alert("提示信息", "部分数据格式错误");
        	}
            return $(this).form("validate");
        },
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#win").window("close");
                findOutgoing("");
                $("#addOutgoing").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
//保存修改
function saveUpdatedOutgoing(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/out/saveOutgoing.m'/>";
	var updated = datagrid.datagrid('getChanges', "updated");
	var effectRow = new Object();
	if (updated.length) {
		effectRow["updated"] = JSON.stringify(updated);
	}
	if("{}"!=JSON.stringify(effectRow)){
		$.post(posturl,effectRow,function(data){
			if(data=="ok"){
				$.messager.alert('提示','操作成功');
			}else{
				if(""!=data){
					$.messager.alert('提示','操作失败');
				}
			}
			datagrid.datagrid("load"); 
		});
	}
	}
//开始编辑
function updateWhere(){
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要编辑的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要编辑的行！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		var rowindex = datagrid.datagrid('getRowIndex',rowid);
		editRow = rowindex;
		datagrid.datagrid('beginEdit', rowindex);
	}
}
function outGoingPg(){
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要变更的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		$.post("<c:url value='/out/seachOne.m?countyoutgoing.id='/>"+rowid,function(data){
			var namestr = ['name','age'];
			for (var i = 0; i < namestr.length; i++) {
				$("input[name='countyoutgoing."+namestr[i]+"']").val(data[namestr[i]]);
			}
			var opstr = '';
			if(data.sex=='1'){
				opstr = "<option value='1' selectid='selectid'>男</option><option value='2'>女</option>";
			}else if(data.sex=='2'){
				opstr = "<option value='1'>男</option><option value='2' selectid='selectid'>女</option>";
			}
			$("select[name='countyoutgoing.sex']").html(opstr);
			$("#win").window('open');
		},"json");
	}
}
var langdatagrid;
var langeditRow = undefined;
function historyOutgoing(){
	var id = '';
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要查看的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要查看的行！", "info");  
		return;
	}else{
		id=row[0].id;
	}
	var tabTop = "<c:url value='/json/outgoing.json'/>";
	var rowurl = "<c:url value='/out/seachHistory.m?countyoutgoing.id='/>"+id;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	//锁定列
	$.getJSON(tabTop, function(data){
		langdatagrid = $('#history').datagrid({ 
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
	        checkOnSelect:true,//选中行,不默认选中当前行的复选框
	        idField: id,
	        frozenColumns:[[{field:'ck',checkbox:true}]], 
	        onAfterEdit: function (rowIndex, rowData, changes) {
	        	langeditRow = undefined;
	        },onBeforeLoad:function(){			//在请求载入数据之前触发
	        	if (langeditRow != undefined) {
	        		langdatagrid.datagrid('endEdit', langeditRow);
	            }
	        },onDblClickRow:function (rowIndex, rowData) {
	        	/* if (langeditRow != undefined) {
	        		langdatagrid.datagrid('endEdit', langeditRow);
	            }
	            if (langeditRow == undefined) {
	            	langeditRow=rowIndex;
	            	langdatagrid.datagrid('beginEdit', rowIndex);
	            	if(rowData.id!=""){
	            		var cellEdit = langdatagrid.datagrid('getEditor', {index:rowIndex,field:'username'});
						var $input = cellEdit.target; // 得到文本框对象
						$input.attr('readonly',true); // 设值只读
	            	}
	                
	            } */
	        },onClickRow:function(rowIndex,rowData){
	            if (langeditRow != undefined) {
	            	var vv = langdatagrid.datagrid('endEdit',langeditRow);
	            	if(!vv){
	            		$.messager.alert('警告','有数据未通过验证!','warning');
	            		return;
	            	}
	            	langdatagrid.datagrid('endEdit', langeditRow);
	            }
	        },onSelect:function(rowIndex, rowData){
	        	langdatagrid.datagrid('endEdit', langeditRow);
	        	langdatagrid.datagrid('unselectRow',rowIndex);//不选中行
	        },
	        onCheckAll:function(rows){
	        	langdatagrid.datagrid('unselectAll');
	        }
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				langdatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
			}
		}
	    //设置分页控件 
	    var p = $('#history').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
	});
	$("#historywin").window('open');
}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'离任干部查询          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="outgoing" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addOutgoing()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:updateWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:outGoingPg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更</a>
    		<a href="javascript:saveUpdatedOutgoing()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	        <span>干部姓名:</span><input type="text" id="name" value="" size=10 />
	        <a href="javascript:findOutgoingWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
	        <a href="javascript:historyOutgoing()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
	    </div>
    </div>
    <div id="win" class="easyui-window" title="离任干部添加" style="width:410px;height:200px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addOutgoing">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			    <table border="1">
			    	<tr>
				    	<th>姓名</th>
				    	<td>
				    		<input type="text" name="countyoutgoing.name"  class="easyui-validatebox" data-options="required:true,validType:'name'" style="height:40px"/>
				    	</td>
				    	<th>性别</th>
				    	<td>
				    		 <select name="countyoutgoing.sex" class="easyui-validatebox" data-options="required:true" style="height:40px">
						    	<option value="">-请选择-</option>
						    	<option value="1">男</option>
						    	<option value="2">女</option>
						    </select>	
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>年龄</th>
				    	<td>
				    		<input type="text" name="countyoutgoing.age" class="easyui-validatebox" data-options="required:true,validType:'sex'" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddOutgoing()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
	<div id="historywin" class="easyui-window" title="历史记录" style="width:600px;height:450px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">
	   		<table id='history'></table>
	   </div>
	</div>
</body>
</html>