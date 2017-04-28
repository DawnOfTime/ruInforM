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
	    		 findBuilding("");
	    	 }
		 }
	 });
	$("#win").window({
		closed: true
	});
	$("#wins").window({
		closed: true
	});
	$("#lishi").window({
		maximized: true,
		 closed: true
	});
	//定义验证类型
	 $.extend($.fn.valssidatebox.defaults.rules, {
		name : {
           validator : function(value, param) {
           	return /^[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value);
           },  
           message : '请输入姓名'  
       }
	 });
});
function findBuilding(buildingName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/countrybuilding.json'/>";
	var rowurl = "<c:url value='/findbuilding.m?countrybuilding.cid='/>"+cid;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	//锁定列
	$.getJSON(tabTop, function(data){
		datagrid = $('#building').datagrid({ 
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
	    var p = $('#building').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
	});
}
function addBuilding(){
		$("#win").window('open');
}
function saveaddBuliding(){
	$("#addBuilding").form("submit", {
        url: "<c:url value='/addbuilding.m'/>",
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
                findBuilding("");
                $("#addBuilding").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
//保存修改和删除
function saveUpdatedBilding(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/savebuilding.m'/>";
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
//变更
function savebg(){
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要变更的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		var cid = $("#cid").val();
		  $.post("<c:url value='/buildingbg.m?countrybuilding.id='/>"+rowid+"&countrybuilding.cid="+cid,function (data){
			$("#ylyh").attr("value",data[0].ylyh);
			$("#snyh").attr("value",data[0].snyh);
			$("#slsyh").attr("value",data[0].slsyh);
			$("#cl").attr("value",data[0].cl);
			$("#ql").attr("value",data[0].ql);
			$("#qsb").attr("value",data[0].qsb);
			$("#ynb").attr("value",data[0].ynb);
		},"json"); 
		  $("#wins").window('open'); 
	} 
} 
//变更保存
function addFlowbg(){
	var cid = $("#cid").val();
	$("#addFlowbg").form("submit", {
        url: "<c:url value='/addbuilding.m'/>",
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#wins").window("close");
	    		findFlowPerson("");
                $("#addFlowbgs").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}

/* 历史记录 */
var commdatagrid;
var commeditRow = undefined;
function savelishi(){
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要变更的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		return;
	}else{
		var cid = $("#cid").val();
		var rowid = row[0].id;
		var tabTop = "<c:url value='/json/countrybuilding.json'/>";
		var rowurl = "<c:url value='/buildinglishi.m?countrybuilding.id='/>"+rowid+"&countrybuilding.cid="+cid;
		var hidcolumns = "cid,id";//隐藏列字段名
		var id = "id";//主键字段
		$.getJSON(tabTop, function(data){
			commdatagrid = $('#lis').datagrid({ 
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
		        onAfterEdit: function (rowIndex, rowData, changes) {
		        	commeditRow = undefined;
		        },onBeforeLoad:function(){			//在请求载入数据之前触发
		        	if (commeditRow != undefined) {
		        		commdatagrid.datagrid('endEdit', commeditRow);
		            }
		        },onClickRow:function(rowIndex,rowData){
		            if (commeditRow != undefined) {
		            	commdatagrid.datagrid('endEdit', commeditRow);
		            }
		        },onSelect:function(rowIndex, rowData){
		        	commdatagrid.datagrid('endEdit', commeditRow);
		        	commdatagrid.datagrid('unselectRow',rowIndex);//不选中行
		        },
		        onCheckAll:function(rows){
		        	commdatagrid.datagrid('unselectAll');
		        }
			});
			if(hidcolumns!=""){
				var columns=new Array()
				columns=hidcolumns.split(",");
				for(var i=0;i<columns.length;i++){
					commdatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
				}
			}
		});
		  $("#lishi").window('open');
	}
}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'建筑信息          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="building" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addBuilding()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:updateWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:savebg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<a href="javascript:saveUpdatedBilding()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	    </div>
    </div>
    
     <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="lis" toolbar="#seach"></table>
	    </div>  
	</div>
    
    
    <div id="win" class="easyui-window" title="建筑信息添加" style="width:600px;height:400px"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true" ">  
		    <form method="post" id="addBuilding">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			    <table border="1" style="margin-top: 54px;">
			    	<tr>
				    	<th>油路硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ylyh" class="easyui-validatebox"  data-options="required:true,validType:'cdzbsj'" style="height:50px"/>
				    	</td>
				    	<th>水泥硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.snyh" class="easyui-validatebox"  data-options="required:true,validType:'bpld'" style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>砂砾石硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.slsyh" class="easyui-validatebox"  data-options="required:true,validType:'slsyh'" style="height:50px"/>
				    	</td>
				    	<th>土路（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.cl" class="easyui-validatebox"  data-options="required:true,validType:'cl'" style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>桥梁（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ql" class="easyui-validatebox"  data-options="required:true,validType:'ql'" style="height:50px"/>
				    	</td>
				    	<th>清水坝（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.qsb" class="easyui-validatebox"  data-options="required:true,validType:'qsb'" style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>淤地坝（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ynb" class="easyui-validatebox"  data-options="required:true,validType:'ynb'" style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddBuliding()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="基本信息变更" style="width:600px;height:400px"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			     <table border="1" style="margin-top: 54px;">
			    	<tr>
				    	<th>油路硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ylyh" value="" id="ylyh" style="height:50px"/>
				    	</td>
				    	<th>水泥硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.snyh" value="" id="snyh"  style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>砂砾石硬化（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.slsyh" value="" id="slsyh"  style="height:50px"/>
				    	</td>
				    	<th>土路（公里）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.cl" value="" id="cl"   style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>桥梁（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ql" value="" id="ql"   style="height:50px"/>
				    	</td>
				    	<th>清水坝（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.qsb" value="" id="qsb"   style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>淤地坝（座）</th>
				    	<td>
				    		<input type="text" name="countrybuilding.ynb" value="" id="ynb"   style="height:50px"/>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddBuliding()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
</body>
</html>