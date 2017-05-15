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
	    		 findPoverty("");
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
function findPoverty(povertyName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/countypoverty.json'/>";
	var rowurl = "<c:url value='/seachPoverty.m?countrypoverty.cid='/>"+cid;
	var newRow = "{\"id\":\"\",\"is_pkc\":\"\",\"pk_number\":\"\",\"tpcs\":\"\",\"is_ymbq\":\"\",\"jcrzbqhs\":\"\"，\"ytczbqhs\":\"\",\"xjczbqhs\":\"\",\"kqyazbqhs\":\"\",\"zpdysjname\":\"\",\"zpdysjpcdwjzw\":\"\",\"zpdysjphonenumber\":\"\",\"fpdzxm\":\"\",\"fpdzpcdwjzw\":\"\",\"fpdzphonenumber\":\"\",\"cid\":\"\"}";
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var is_ymbq = [
				   	{valueField:'1',textField:'是'},
					{valueField:'2',textField:'否'}
			 	];
	var is_pkc = [
				   	{valueField:'1',textField:'是'},
					{valueField:'2',textField:'否'}
			 	];
	var formartColumns=[{
			 field: 'is_pkc',
			 formatter:function(value, row, index){
				 var showTxt="";
				 $(is_pkc).each(function(){
					 if(value==this.valueField){
						 showTxt=this.textField;
					 }
				 });
				 return showTxt;
			 },
			 editor: {  
	        	type: 'combobox',  
			    options: {  
			          data: is_pkc,  
			          valueField: 'valueField',  
			          textField: 'textField',  
			          panelHeight: 'auto'  
			    }  
	        }  
		},{
			 field: 'is_ymbq',
			 formatter:function(value, row, index){
				 var showTxt="";
				 $(is_ymbq).each(function(){
					 if(value==this.valueField){
						 showTxt=this.textField;
					 }
				 });
				 return showTxt;
			 },
			 editor: {  
	        	type: 'combobox',  
			    options: {  
			          data: is_ymbq,  
			          valueField: 'valueField',  
			          textField: 'textField',  
			          panelHeight: 'auto'  
			    }  
	        }  
	}]
	//锁定列
	$.getJSON(tabTop, function(data){
		$(formartColumns).each(function(){
			var formartItem=this;
			$(data).each(function(){
				if(this.field==formartItem.field){
					this.editor=formartItem.editor;
					this.formatter=formartItem.formatter;
				}
			});
		});
		datagrid = $('#poverty').datagrid({ 
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
	        /* frozenColumns:[[{field:'ck',checkbox:true}]],  */
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
	    var p = $('#poverty').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
	});
}
function addPoverty(){
	var p = datagrid.datagrid("getRows"); 
	if(p.length >= 1){
		$.messager.alert("提示信息", "信息已存在，不能进行添加。 ");
	}else{
		$("#win").window('open');
	} 
}
function saveaddPoverty(){
	var cid = $("#cid").val();
	$("#addPoverty").form("submit", {
        url: "<c:url value='/addPoverty.m?countrypoverty.cid='/>"+cid,
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
                findPoverty("");
                $("#addPoverty").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
//保存修改
function saveUpdatedPoverty(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/savePoverty.m'/>";
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
//删除
function deletedPoverty(){
	var rows=datagrid.datagrid("getChecked");
	if(rows.length<1){
		$.messager.alert("提示", "请选择要删除的行！");  
        return;  
	}else{
		$(rows).each(function(){
			var delIndex=datagrid.datagrid("getRowIndex",this.id);
			datagrid.datagrid("deleteRow",delIndex);
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
	var row = datagrid.datagrid('getRows');
	 if(row < 1){
		$.messager.alert("提示", "无要变更的信息！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		var cid = $("#cid").val();
		  $.post("<c:url value='/povertybg.m?countrypoverty.id='/>"+rowid+"&countrypoverty.cid="+cid,function (data){
			if(data[0].is_pkc=="1"){
				$("#is_pkc").html("<option value='1' selected='selected'>是</option><option value='2'>否</option>");
			}else if(data[0].is_pkc=="2"){
				$("#is_pkc").html("<option value='1'>是</option><option value='2' selected='selected'>否</option>");
			}
			
			if(data[0].is_ymbq=="1"){
				$("#is_ymbq").html("<option value='1' selected='selected'>是</option><option value='2'>否</option>");
			}else if(data[0].is_ymbq=="2"){
				$("#is_ymbq").html("<option value='1'>是</option><option value='2' selected='selected'>否</option>");
			}
			
			var elementids=["pk_number","tpcs","jcrzbqhs","ytczbqhs","xjcabqhs","kqyazbqhs","zpdysjname","zpdysjpcdwjzw","zpdysjphonenumber","fpbzxm","fpdzpcdwjzw","fpdzphonenumber"];
			for(var i=0;i<elementids.length;i++){
				document.getElementById(elementids[i]).value=data[0][elementids[i]];
			}
		},"json"); 
		  $("#wins").window('open'); 
	} 
} 
function addFlowbg(){
	var cid = $("#cid").val();
	$("#addFlowbg").form("submit", {
        url: "<c:url value='/addPoverty.m?countrypoverty.cid='/>"+cid,
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#wins").window("close");
                findPoverty("");
                $("#addPoverty").form("clear");
                }else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
/* 历史记录 */
var commdatagrid;
var commeditRow = undefined;
function savelishi(){
	var row = datagrid.datagrid('getRows');
	 if(row < 1){
		$.messager.alert("提示", "无要变更的信息！", "info");  
		return;
	}else{
		var cid = $("#cid").val();
		var tabTop = "<c:url value='/json/countypoverty.json'/>";
		var rowurl = "<c:url value='/povertylishi.m?countrypoverty.cid='/>"+cid;
		var newRow = "{\"id\":\"\",\"is_pkc\":\"\",\"pk_number\":\"\",\"tpcs\":\"\",\"is_ymbq\":\"\",\"jcrzbqhs\":\"\"，\"ytczbqhs\":\"\",\"xjczbqhs\":\"\",\"kqyazbqhs\":\"\",\"zpdysjname\":\"\",\"zpdysjpcdwjzw\":\"\",\"zpdysjphonenumber\":\"\",\"fpdzxm\":\"\",\"fpdzpcdwjzw\":\"\",\"fpdzphonenumber\":\"\",\"cid\":\"\"}";
		var hidcolumns = "cid,id";//隐藏列字段名
		var id = "id";//主键字段
		var is_ymbq = [
					   	{valueField:'1',textField:'是'},
						{valueField:'2',textField:'否'}
				 	];
		var is_pkc = [
					   	{valueField:'1',textField:'是'},
						{valueField:'2',textField:'否'}
				 	];
		var formartColumns=[{
				 field: 'is_pkc',
				 formatter:function(value, row, index){
					 var showTxt="";
					 $(is_pkc).each(function(){
						 if(value==this.valueField){
							 showTxt=this.textField;
						 }
					 });
					 return showTxt;
				 },
				 editor: {  
		        	type: 'combobox',  
				    options: {  
				          data: is_pkc,  
				          valueField: 'valueField',  
				          textField: 'textField',  
				          panelHeight: 'auto'  
				    }  
		        }  
			},{
				 field: 'is_ymbq',
				 formatter:function(value, row, index){
					 var showTxt="";
					 $(is_ymbq).each(function(){
						 if(value==this.valueField){
							 showTxt=this.textField;
						 }
					 });
					 return showTxt;
				 },
				 editor: {  
		        	type: 'combobox',  
				    options: {  
				          data: is_ymbq,  
				          valueField: 'valueField',  
				          textField: 'textField',  
				          panelHeight: 'auto'  
				    }  
		        }  
		}]
		$.getJSON(tabTop, function(data){
			$(formartColumns).each(function(){
				var formartItem=this;
				$(data).each(function(){
					if(this.field==formartItem.field){
						this.editor=formartItem.editor;
						this.formatter=formartItem.formatter;
					}
				});
			});
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
			//设置分页控件 
		    var p = $('#lis').datagrid('getPager'); 
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
}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'脱贫信息          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="poverty" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addPoverty()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<!-- <a href="javascript:updateWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a> -->
    		<a href="javascript:savebg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<!-- <a href="javascript:saveUpdatedPoverty()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a> -->
    		<a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    		<input type="hidden" id="cid"><!-- 村id -->&nbsp;&nbsp;&nbsp;
	    </div>
    </div>
    
    
     <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="lis" toolbar="#seach"></table>
	    </div>  
	</div>
    
    <div id="win" class="easyui-window" title="基本信息添加" style="width:850px;height:450px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addPoverty">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			    <table style="line-height: 50px;width:100%">
			    	<tr>
				    	<th>是否为贫困村</th>
				    	<td>
				    		<select name="countrypoverty.is_pkc"  class="easyui-validatebox" data-options="required:true" style="height: 39px;width: 147px;text-align: center;">
				    			<option value="0">--请选择--</option>
				    			<option value="1">是</option>
				    			<option value="2">否</option>
				    		</select>
				    	</td>
				    	<th>贫困户数</th>
				    	<td>
				    		<textarea rows="1" cols="14"  class="easyui-validatebox" data-options="required:true"  name="countrypoverty.pk_number"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th>脱贫措施</th>
				    	<td>
				    		<textarea rows="1" cols="14"  class="easyui-validatebox" data-options="required:true" name="countrypoverty.tpcs"></textarea>
				    	</td>
				    	<th>是否移民搬迁</th>
				    	<td>
				    		<select name="countrypoverty.is_ymbq"   class="easyui-validatebox" data-options="required:true" style="height: 39px;width: 147px;text-align: center;">
				    			<option value="0">--请选择--</option>
				    			<option value="1">是</option>
				    			<option value="2">否</option>
				    		</select>
				    		
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>进城入镇搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.jcrzbqhs"  class="easyui-validatebox" data-options="required:true"></textarea></td>
				    	<th>依托村庄搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.ytczbqhs" class="easyui-validatebox" data-options="required:true"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>新建村庄搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.xjcabqhs"  class="easyui-validatebox" data-options="required:true"></textarea></td>
				    	<th>跨区域安置搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.kqyazbqhs"  class="easyui-validatebox" data-options="required:true"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>派驻第一书记姓名</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjname"  class="easyui-validatebox" data-options="required:true"></textarea></td>
				    	<th>派驻第一书记派出单位及职务</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjpcdwjzw"  class="easyui-validatebox" data-options="required:true" ></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>派驻第一书记联系方式</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjphonenumber"  class="easyui-validatebox" data-options="required:true"></textarea></td>
				    	<th>扶贫队长姓名</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpbzxm"  class="easyui-validatebox" data-options="required:true"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>扶贫队长派出单位及职务</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpdzpcdwjzw"  class="easyui-validatebox" data-options="required:true"></textarea></td>
				    	<th>扶贫队长联系方式</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpdzphonenumber"  class="easyui-validatebox" data-options="required:true"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddPoverty()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="基本信息变更" style="width:850px;height:450px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	 <table style="line-height: 50px;width:100%">
			    	<tr>
				    	<th>是否为贫困村</th>
				    	<td>
				    		<select name="countrypoverty.is_pkc" id="is_pkc" style="height: 39px;width: 147px;text-align: center;">
				    			<!-- <option value="0">--请选择--</option>
				    			<option value="1">是</option>
				    			<option value="2">否</option> -->
				    		</select>
				    	</td>
				    	<th>贫困户数</th>
				    	<td>
				    		<textarea rows="1" cols="14"  name="countrypoverty.pk_number"  id="pk_number"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th>脱贫措施</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.tpcs" id="tpcs"></textarea>
				    	</td>
				    	<th>是否移民搬迁</th>
				    	<td>
				    		<select name="countrypoverty.is_ymbq"   id="is_ymbq" style="height: 39px;width: 147px;text-align: center;">
				    			<!-- <option value="0">--请选择--</option>
				    			<option value="1">是</option>
				    			<option value="2">否</option> -->
				    		</select>
				    		
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>进城入镇搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.jcrzbqhs"   id="jcrzbqhs"></textarea></td>
				    	<th>依托村庄搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.ytczbqhs" id="ytczbqhs"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>新建村庄搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.xjcabqhs"  id="xjcabqhs"></textarea></td>
				    	<th>跨区域安置搬迁户数</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.kqyazbqhs" id="kqyazbqhs"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>派驻第一书记姓名</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjname"  id="zpdysjname"></textarea></td>
				    	<th>派驻第一书记派出单位及职务</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjpcdwjzw" id="zpdysjpcdwjzw"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>派驻第一书记联系方式</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.zpdysjphonenumber" id="zpdysjphonenumber"></textarea></td>
				    	<th>扶贫队长姓名</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpbzxm" id="fpbzxm"></textarea>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>扶贫队长派出单位及职务</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpdzpcdwjzw" id="fpdzpcdwjzw"></textarea></td>
				    	<th>扶贫队长联系方式</th>
				    	<td>
				    		<textarea rows="1" cols="14" name="countrypoverty.fpdzphonenumber" id="fpdzphonenumber" ></textarea>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:addFlowbg()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
</body>
</html>