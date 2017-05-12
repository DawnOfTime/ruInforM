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
var selectRow = undefined; //定义全局变量：当前选中的行
$(document).ready(function(){
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
	 var treeobj = $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 if($('#tt').tree("find",node.id).level==5){ 
	    		 $("#cid").val(node.id);
	    		 findFlowPerson("");
	    		
	    	 }
		 }
	 });
});


function findFlowPerson(){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/communication.json'/>";
	var rowurl = "<c:url value='/communication/queryCommunication.m?communication.cid='/>"+cid;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	var formartColumns;
	$.post("<c:url value='/communication/findOption.m'/>",function(optiondata){
		var is_ydxh = optiondata.is_ydxh;
		var is_ltxh = optiondata.is_ltxh;
		var is_dxxh = optiondata.is_dxxh;
		var is_qcfg = optiondata.is_qcfg;
		formartColumns = [{	
								field: 'is_ydxh',
								formatter:function(value, row, index){
									var showTxt="";
									$(is_ydxh).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: is_ydxh,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'is_ltxh',
								formatter:function(value, row, index){
									var showTxt="";
									$(is_ltxh).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: is_ltxh,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'is_dxxh',
								formatter:function(value, row, index){
									var showTxt="";
									$(is_dxxh).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: is_dxxh,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'is_qcfg',
								formatter:function(value, row, index){
									var showTxt="";
									$(is_qcfg).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: is_qcfg,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							}
							];
	//锁定列
	$.getJSON(tabTop, function(data){
		/* if(undefined!=frozenColumns){
			frozenColumns = frozenColumns;
		}else{
			frozenColumns = [{field:'ck',checkbox:true}];
		} */
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
	            	var vv = datagrid.datagrid('endEdit',editRow);
	            	if(!vv){
	            		$.messager.alert('警告','有数据未通过验证!','warning');
	            		return;
	            	}
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
	    var p = $('#dg').datagrid('getPager'); 
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
	function addFlowPerson(){
		var p = $("#dg").datagrid("getRows").length;
		if(p >=1){
			$.messager.alert("提示信息", "信息已存在，不能进行添加。 ");
		}else{
			$("#win").window('open');
		} 
		
	}
	function findWhere(){ 
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+$("#name").val();
	}
	findFlowPerson(personWhere);
	}
	function saveaddCommunication(){
	var cid = $("#cid").val();
	$("#addFlowPerson").form("submit", {
	    url: "<c:url value='/communication/addCommunication.m?communication.cid='/>"+cid,
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
	function saveUpdatedCommunication(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/communication/saveCommunication.m'/>";
	var deleted = datagrid.datagrid('getChanges', "deleted");
	var updated = datagrid.datagrid('getChanges', "updated");
	var effectRow = new Object();
	if (deleted.length) {
		effectRow["deleted"] = JSON.stringify(deleted);
	}
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
	function updateVillageWhere(){
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
	/* 变更 */
	function savebgCommunication(){
		var row = datagrid.datagrid('getRows');
		 if(row < 1){
			$.messager.alert("提示", "无要变更的信息！", "info");  
			return;
		}else{
			var rowid = row[0].id;
			var cid = $("#cid").val();
			  $.post("<c:url value='/communication/findbg.m?communication.id='/>"+rowid+"&communication.cid="+cid,function (data){				
				if(data[0].is_ydxh=='1'){
					$("#is_ydxh").append("<option value='1' selected='selected'>是</option><option value='0'>否</option>");
				}else if(data[0].is_ydxh=='0'){
					$("#is_ydxh").append("<option value='1'>是</option><option value='0' selected='selected'>否</option>");
				}
				if(data[0].is_ltxh=='1'){
					$("#is_ltxh").append("<option value='1' selected='selected'>是</option><option value='0'>否</option>");
				}else if(data[0].is_ltxh=='0'){
					$("#is_ltxh").append("<option value='1'>是</option><option value='0' selected='selected'>否</option>");
				}
				if(data[0].is_dxxh=='1'){
					$("#is_dxxh").append("<option value='1' selected='selected'>是</option><option value='0'>否</option>");
				}else if(data[0].is_dxxh=='0'){
					$("#is_dxxh").append("<option value='1'>是</option><option value='0' selected='selected'>否</option>");
				}
				if(data[0].is_qcfg=='1'){
					$("#is_qcfg").append("<option value='1' selected='selected'>是</option><option value='0'>否</option>");
				}else if(data[0].is_qcfg=='0'){
					$("#is_qcfg").append("<option value='1'>是</option><option value='0' selected='selected'>否</option>");
				}
				
			},"json"); 
			  $("#wins").window('open'); 
		} 
		
	}
	function saveadd(){
		var cid = $("#cid").val();
		$("#addFlowbg").form("submit", {
	        url: "<c:url value='/communication/addCommunication.m?communication.cid='/>"+cid,
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
var commseditRow = undefined;
function savelishi(){
	var row = datagrid.datagrid('getRows');
	if(row<1){
		$.messager.alert("提示", "无要查看的信息！", "info");  
		return;
	}else{
		var cid = $("#cid").val();
		var rowid = row[0].id;
		var tabTop = "<c:url value='/json/communication.json'/>";
		var rowurl = "<c:url value='/communication/seachlishi.m?communication.id='/>"+rowid+"&communication.cid="+cid;
		var hidcolumns = "cid,id";//隐藏列字段名
		var id = "id";//主键字段
		var frozenColumns = [];
		var formartColumns;
		$.post("<c:url value='/communication/findOption.m'/>",function(optiondata){
			var is_ydxh = optiondata.is_ydxh;
			var is_ltxh = optiondata.is_ltxh;
			var is_dxxh = optiondata.is_dxxh;
			var is_qcfg = optiondata.is_qcfg;
			formartColumns = [{	
									field: 'is_ydxh',
									formatter:function(value, row, index){
										var showTxt="";
										$(is_ydxh).each(function(){
										 	if(value==this.dicvalue){
										 		showTxt=this.dicname;
										 	}
										});
										return showTxt;
									},
									editor: {  
									    type: 'combobox',  
									 	options: {  
									 		data: is_ydxh,  
									 		valueField: 'dicvalue',  
									 		textField: 'dicname',  
									 		panelHeight: 'auto'  
									 	}  
									}  
								},
								{	
									field: 'is_ltxh',
									formatter:function(value, row, index){
										var showTxt="";
										$(is_ltxh).each(function(){
										 	if(value==this.dicvalue){
										 		showTxt=this.dicname;
										 	}
										});
										return showTxt;
									},
									editor: {  
									    type: 'combobox',  
									 	options: {  
									 		data: is_ltxh,  
									 		valueField: 'dicvalue',  
									 		textField: 'dicname',  
									 		panelHeight: 'auto'  
									 	}  
									}  
								},
								{	
									field: 'is_dxxh',
									formatter:function(value, row, index){
										var showTxt="";
										$(is_dxxh).each(function(){
										 	if(value==this.dicvalue){
										 		showTxt=this.dicname;
										 	}
										});
										return showTxt;
									},
									editor: {  
									    type: 'combobox',  
									 	options: {  
									 		data: is_dxxh,  
									 		valueField: 'dicvalue',  
									 		textField: 'dicname',  
									 		panelHeight: 'auto'  
									 	}  
									}  
								},
								{	
									field: 'is_qcfg',
									formatter:function(value, row, index){
										var showTxt="";
										$(is_qcfg).each(function(){
										 	if(value==this.dicvalue){
										 		showTxt=this.dicname;
										 	}
										});
										return showTxt;
									},
									editor: {  
									    type: 'combobox',  
									 	options: {  
									 		data: is_qcfg,  
									 		valueField: 'dicvalue',  
									 		textField: 'dicname',  
									 		panelHeight: 'auto'  
									 	}  
									}  
								}
								];
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
			
			commdatagrid = $('#ls').datagrid({ 
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
		        	commseditRow = undefined;
		        },onBeforeLoad:function(){			//在请求载入数据之前触发
		        	if (commseditRow != undefined) {
		        		commdatagrid.datagrid('endEdit', commseditRow);
		            }
		        },onClickRow:function(rowIndex,rowData){
		            if (commseditRow != undefined) {
		            	commdatagrid.datagrid('endEdit', commseditRow);
		            }
		        },onSelect:function(rowIndex, rowData){
		        	commdatagrid.datagrid('endEdit', commseditRow);
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
		    var p = $('#ls').datagrid('getPager'); 
		    $(p).pagination({ 
		        pageSize: 10,//每页显示的记录条数，默认为10 
		        pageList: [5,10,15],//可以设置每页记录条数的列表 
		        beforePageText: '第',//页数文本框前显示的汉字 
		        afterPageText: '页    共 {pages} 页', 
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    }); 
		});
		  $("#lishi").window('open');
	},"json");
	}
}
</script>
<style type="text/css">
	#tables{
	margin-top:30px;
	width:100%;
	}
	#tabless{
	margin-top:30px;
	width:100%;
	}
	td{
	margin-top:30px;
	}
	.baocun{
		height:100px;
		text-align:center;
	}
	.juzhong{
		height:80px;
	}
	
</style>
</head>
<body class="easyui-layout">
 <div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
 </div>
 <div data-options="region:'center',title:'信息          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="dg" toolbar="#searchtool"></table>
    	<!-- 表头 -->
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:savebgCommunication()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a> 
    		<input type="hidden" id="cid"><!-- 村id -->
	    </div>
 </div>
 <div id="win" class="easyui-window" title="通讯添加" style="width:500px;height:250px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<table id="tables">
		    		<tr>
		    			<td>是否有移动信号:</td>
		    			<td>
		    				<select name="communication.is_ydxh">
		    					<option value="1">是</option>
		    					<option value="0">否</option>
		    				</select>
		    			</td>
		    			<td>是否有联通信号:</td>
		    			<td>
		    				<select name="communication.is_ltxh">
		    					<option value="1">是</option>
		    					<option value="0">否</option>
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>是否有电信信号:</td>
		    			<td>
		    				<select name="communication.is_dxxh">
		    					<option value="1">是</option>
		    					<option value="0">否</option>
		    				</select>
		    			</td>
		    			<td>是否全村覆盖:</td>
		    			<td>
		    				<select name="communication.is_qcfg">
		    					<option value="1">是</option>
		    					<option value="0">否</option>
		    				</select>
		    			</td>
		    		</tr>
		    		
		    		<tr>
		    			<td colspan="4" class="baocun"><a href="javascript:saveaddCommunication()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>  
	</div>
	<div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="ls" toolbar="#seach"></table>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="通讯信息变更" style="width:500px;height:250px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<table id="tabless">
		    		<tr>
		    			<td>是否有移动信号:</td>
		    			<td>
		    				<select name="communication.is_ydxh" id="is_ydxh">
		    					
		    				</select>
		    			</td>
		    			<td>是否有联通信号:</td>
		    			<td>
		    				<select name="communication.is_ltxh" id="is_ltxh">
		    					
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>是否有电信信号:</td>
		    			<td>
		    				<select name="communication.is_dxxh" id="is_dxxh">
		    					
		    				</select>
		    			</td>
		    			<td>是否全村覆盖:</td>
		    			<td>
		    				<select name="communication.is_qcfg" id="is_qcfg">
		    					
		    				</select>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="4" class="baocun"><a href="javascript:saveadd()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>  
	</div>
</body>
</html>