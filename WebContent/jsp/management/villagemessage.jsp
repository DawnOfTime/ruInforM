<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var vildatagrid; //定义全局变量datagrid
var vileditRow = undefined; //定义全局变量：当前编辑的行
$(document).ready(function(){
	$('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 if($('#tt').tree("find",node.id).level==5){
	    		 $("#cid").val(node.id);
	    		 findFlowPerson("");
	    		 $(".datagrid-wrap").attr("style","display:block");
	    	 }else{
	    		 $(".datagrid-wrap").attr("style","display:none");
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
	 $.extend($.fn.validatebox.defaults.rules, {
		name : {
           validator : function(value, param) {  
           	return /^[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value);
           },  
           message : '请输入姓名'  
       }
	 });
});
function findFlowPerson(villageName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/villagemessage.json'/>";
	var rowurl = "<c:url value='/vill/seachvillage.m?cid='/>"+cid+villageName;
	var hidcolumns = "id,cid";//隐藏列字段名s
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	//锁定列
	$.getJSON(tabTop, function(data){
		vildatagrid = $('#village').datagrid({ 
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
	       /*  frozenColumns:[[{field:'ck',checkbox:true}]],  */
	        onAfterEdit: function (rowIndex, rowData, changes) {
	        	vileditRow = undefined;
	        },onBeforeLoad:function(){			//在请求载入数据之前触发
	        	if (vileditRow != undefined) {
	        		vildatagrid.datagrid('endEdit', vileditRow);
	            }
	        },onDblClickRow:function (rowIndex, rowData) {
	        	/* if (vileditRow != undefined) {
	        		vildatagrid.datagrid('endEdit', vileditRow);
	            }
	            if (vileditRow == undefined) {
	            	vileditRow=rowIndex;
	            	vildatagrid.datagrid('beginEdit', rowIndex);
	            	if(rowData.id!=""){
	            		var cellEdit = vildatagrid.datagrid('getEditor', {index:rowIndex,field:'username'});
						var $input = cellEdit.target; // 得到文本框对象
						$input.attr('readonly',true); // 设值只读
	            	}
	            } */
	        },onClickRow:function(rowIndex,rowData){
	            if (vileditRow != undefined) {
	            	vildatagrid.datagrid('endEdit', vileditRow);
	            }
	        },onSelect:function(rowIndex, rowData){
	        	vildatagrid.datagrid('endEdit', vileditRow);
	        	vildatagrid.datagrid('unselectRow',rowIndex);//不选中行
	        },
	        onCheckAll:function(rows){
	        	vildatagrid.datagrid('unselectAll');
	        }
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				vildatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
			}
		}
	    //设置分页控件 
	    var p = $('#village').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
		
	});
}
function addFlowPerson(){
	var rows = $("#village").datagrid("getRows").length;
	if(rows==0){
		$("#win").window('open');
	}else{
		$.messager.alert("提示信息", "信息已存在，不能添加！");
	}
}
function findVillageWhere(){
	var personWhere = "";
	if($("#cdzbsj").val()!=''){
		personWhere += "&cdzbsj="+$("#cdzbsj").val();
	}
	if($("#bpld").val()!=''){
		personWhere += "&bpld="+$("#bpld").val();
	}
	findFlowPerson(personWhere);
}

function saveaddVillage(){
	var cid = $("#cid").val();
	$("#addFlowPerson").form("submit", {
        url: "<c:url value='/vill/addVillage.m?countrymessage.cid='/>"+cid,
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
	    		findFlowPerson("");
                $("#addFlowPerson").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
//保存修改和删除
function saveUpdatedVillage(){
	vildatagrid.datagrid('endEdit', vileditRow);
	var posturl = "<c:url value='/vill/saveVillage.m'/>";
	var updated = vildatagrid.datagrid('getChanges', "updated");
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
			vildatagrid.datagrid("load"); 
		});
	}
}

//开始编辑
function updateVillageWhere(){
	var row = vildatagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要编辑的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要编辑的行！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		var rowindex = vildatagrid.datagrid('getRowIndex',rowid);
		vileditRow = rowindex;
		vildatagrid.datagrid('beginEdit', rowindex);
	}
}




function savebgVillage(){
	var rows = vildatagrid.datagrid('getRows');
	var row = rows[0];
	if(rows.length<1){
		$.messager.alert("提示", "无要变更的信息！", "info");  
		return;
	}/* else if(row.length>1){
		$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		return;
	} */else{
		var rowid = row.id;
		var cid = $("#cid").val();
		  $.post("<c:url value='/vill/seachbg.m?countrymessage.id='/>"+rowid+"&countrymessage.cid="+cid,function (data){
			$("#cdzbsj").attr("value",data[0].cdzbsj);
			$("#bpld").attr("value",data[0].bpld);
			
			var elementids=["jswmjsqk","cdzzqk","cdzzqk","cjzdqk","qyhzsqk","cztzqk","bcczdzywt"];
			for(var i=0;i<elementids.length;i++){
				document.getElementById(elementids[i]).value=data[0][elementids[i]];
			}
			/* document.getElementById("jswmjsqk").value=data[0].jswmjsqk;
			document.getElementById("cdzzqk").value=data[0].cdzzqk;
			document.getElementById("cjzdqk").value=data[0].cjzdqk;
			document.getElementById("qyhzsqk").value=data[0].qssyhzsqk;
			document.getElementById("cztzqk").value=data[0].cztzqk;
			document.getElementById("bcczdzywt").value=data[0].cztzqk; */
		},"json"); 
		  $("#wins").window('open'); 
	} 
	
} 
function addFlowbg(){
	var cid = $("#cid").val();
	$("#addFlowbg").form("submit", {
        url: "<c:url value='/vill/addVillage.m?countrymessage.cid='/>"+cid,
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#wins").window("close");
	    		findFlowPerson("");
                $("#addFlowbg").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}

var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
function lishiVillage(){
		var cid = $("#cid").val();
		var tabTop = "<c:url value='/json/villagemessage.json'/>";
		var rowurl = "<c:url value='/vill/seachlishi.m?&countrymessage.cid='/>"+cid;
		var hidcolumns = "id,cid";//隐藏列字段名
		var id = "id";//主键字段名
		$.getJSON(tabTop, function(data){
			datagrid = $('#ls').datagrid({ 
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
		        	editRow = undefined;
		        },onBeforeLoad:function(){			//在请求载入数据之前触发
		        	if (editRow != undefined) {
		        		datagrid.datagrid('endEdit', editRow);
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
		    var p = datagrid.datagrid('getPager'); 
		    $(p).pagination({ 
		        pageSize: 10,//每页显示的记录条数，默认为10 
		        pageList: [5,10,15],//可以设置每页记录条数的列表 
		        beforePageText: '第',//页数文本框前显示的汉字 
		        afterPageText: '页    共 {pages} 页', 
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    }); 
		});
		  $("#lishi").window('open');
}
</script>
<style type="text/css">
/*添加*/
	#win input{
		width: 150px;
		border: 1px solid #e0e0e0;
	}
	#win select{
		width:150px;
		border: 1px solid #e0e0e0;
	}
	#win textarea{
		width:150px;
		border: 1px solid #e0e0e0;
	}
	#win{
		background-color: #F4F4F4;
	}
	#win tr{
		height: 45px;
	}
	#win th,td{
		border-bottom: 2px solid #DDDDDD;
	}
	#win .easyui-linkbutton{
		width: 100px;
		height: 30px;
	}
	#win .l-btn-text{
		font-size: 15px;
	}
/*变更*/
	#wins input{
		width: 150px;
		border: 1px solid #e0e0e0;
	}
	#wins select{
		width:150px;
		border: 1px solid #e0e0e0;
	}
	#wins textarea{
		width:150px;
		border: 1px solid #e0e0e0;
	}
	#wins{
		background-color: #F4F4F4;
	}
	#wins tr{
		height: 45px;
	}
	#wins th,td{
		border-bottom: 2px solid #DDDDDD;
	}
	#wins .easyui-linkbutton{
		width: 100px;
		height: 30px;
	}
	#wins .l-btn-text{
		font-size: 15px;
	}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'基本信息          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="village" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<!-- <a href="javascript:updateVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a> -->
    		<a href="javascript:savebgVillage()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<!-- <a href="javascript:saveUpdatedVillage()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a> -->
    		<a href="javascript:lishiVillage()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    		
    		<input type="hidden" id="cid"><!-- 村id -->
    		
	       <!--  <span>村党支部书记:</span><input type="text" id="cdzbsj" value="" size=10 />
	        <span>包片领导:</span><input type="text" id="bpld" value="" size=20 />
	        <a href="javascript:findVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
	        --> 
	    </div>
    </div>
    
    <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="ls" toolbar="#seach"></table>
	    </div>  
	</div>
	
    <div id="win" class="easyui-window" title="基本信息添加" style="width:800px;height:300px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true" style="text-align:center;">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<div style="heigth:20px;display:block;line-height:20px;">&nbsp;</div>
			    <table style="line-heigth:45px;width:90%" align="center" cellpadding="0" cellspacing="0">
			    	<tr>
				    	<td>村党支部书记</td>
				    	<td>
				    		<input type="text" name="countrymessage.cdzbsj"  class="easyui-validatebox" data-options="validType:'cdzbsj'"/>
				    	</td>
				    	<td>包片领导</td>
				    	<td>
				    		<input type="text" name="countrymessage.bpld" class="easyui-validatebox" data-options="validType:'bpld'"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>精神文明建设情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.jswmjsqk"  class="easyui-validatebox"></textarea></td>
				    	<td>村党组织情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cdzzqk"  class="easyui-validatebox"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>村级阵地情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cjzdqk"  class="easyui-validatebox"></textarea></td>
				    	<td>企业，专业合作社情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.qyhzsqk"  class="easyui-validatebox"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>财政投资情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cztzqk"  class="easyui-validatebox"></textarea></td>
				    	<td>本村存在的主要问题</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.bcczdzywt"  class="easyui-validatebox"></textarea>
				    	</td>
			    	</tr>
			    	<!-- <tr>
			    		<td colspan="4"><a href="javascript:saveaddVillage()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
			    	</tr> -->
			    </table>
			    <br>
			    <div onclick="saveaddVillage()" style="background:#EDF4FF;margin:auto;cursor:pointer;width:75px;height:30px;display:block;border:1px solid #95B8E7;line-height:30px;text-align:center;">保存</div>
		    </form>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="基本信息变更" style="width:800px;height:300px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true" style="text-align:center;">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<div style="heigth:20px;display:block;line-height:20px;">&nbsp;</div>
			    <table style="line-heigth:45px;width:90%" align="center" cellpadding="0" cellspacing="0">
			    	<tr>
				    	<td>村党支部书记</td>
				    	<td>
				    		<input type="text" name="countrymessage.cdzbsj" value="" id="cdzbsj"/>
				    	</td>
				    	<td>包片领导</td>
				    	<td>
				    		<input type="text" name="countrymessage.bpld" value="" id="bpld"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>精神文明建设情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.jswmjsqk" id="jswmjsqk"  ></textarea>
				    	</td>
				    	<td>村党组织情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cdzzqk"  id="cdzzqk" ></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>村级阵地情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cjzdqk" id="cjzdqk" ></textarea>
				    	</td>
				    	<td>企业，专业合作社情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.qyhzsqk" id="qyhzsqk"  ></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<td>财政投资情况</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.cztzqk" id="cztzqk"  ></textarea>
				    	</td>
				    	<td>本村存在的主要问题</td>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrymessage.bcczdzywt" id="bcczdzywt"></textarea>
				    	</td>
			    	</tr>
			    	<!-- <tr>
			    		<td colspan="4"><a href="javascript:addFlowbg()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
			    	</tr> -->
			    </table>
			    <br>
			    <div onclick="addFlowbg()" style="background:#EDF4FF;margin:auto;cursor:pointer;width:75px;height:30px;display:block;border:1px solid #95B8E7;line-height:30px;text-align:center;">保存</div>
		    </form>
		</div>
	</div>
</body>
</html>