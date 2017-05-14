<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    		 findFiance("");
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
function findFiance(FinanceName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/countygroupfinance.json'/>";
	var rowurl = "<c:url value='/seachFinance.m?groupfinance.cid='/>"+cid;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	var formartColumns;
	$.post("<c:url value='/findOption.m'/>",function(optiondata){
		var type = optiondata.type;
		formartColumns = [{	
								field: 'type',
								formatter:function(value, row, index){
									var showTxt="";
									$(type).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: type,  
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
		datagrid = $('#village').datagrid({ 
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
	    var p = $('#village').datagrid('getPager'); 
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
function addFinance(){
	var p = datagrid.datagrid("getRows"); 
	 if(p.length > 3){
		$.messager.alert("提示信息", "信息已存在，不能进行添加。 ");
	}else{
		$("#win").window('open');
	}  
}
function findFinanceWhere(){
	var personWhere = "";
	if($("#type").val()!=''){
		personWhere += "&type="+$("#type").val();
	}
	findFiance(personWhere);
}

function saveaddFinance(){
	var cid = $("#cid").val();
	$("#addFinance").form("submit", {
        url: "<c:url value='/addFinance.m?groupfinance.cid='/>"+cid,
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
                findFiance("");
                $("#addFinance").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
//保存修改和删除
function saveUpdatedFinance(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/saveFinance.m'/>";
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
	//删除
	function deletedFlowPerson(){
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
	
	//变更
	function savebg(){
		var row = datagrid.datagrid('getChecked');
		if(row.length<1){
			$.messager.alert("提示", "请选择要变更的行！", "info");  
		}else if(row.length>1){
			$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		}else{
			 var rowid = row[0].id;
			 var cid = $("#cid").val(); 
			  $.post("<c:url value='/financebg.m?groupfinance.id='/>"+rowid+"&groupfinance.cid="+cid,function (data){
				
				if(data[0].type=="1"){
					$("#types").append("<option value='1' selected='selected'>集体资产</option><option value='2'>收入</option><option value='3'>负债</option>");
				}else if(data[0].type=="2"){
					$("#types").append("<option value='1'>集体资产</option><option value='2' selected='selected'>收入</option><option value='3'>负债</option>");
				}else if(data[0].type=="3"){
					$("#types").append("<option value='1'>集体资产</option><option value='2'>收入</option><option value='3' selected='selected'>负债</option>");
				}
				
				$("#privce").attr("value",data[0].privce);
				$("#message").attr("value",data[0].message);
			},"json");
			  $("#wins").window('open'); 
		} 
		
	} 
	function addFlowbg(){
		var cid = $("#cid").val();
		$("#addFlowbg").form("submit", {
	        url: "<c:url value='/addFinance.m?groupfinance.cid='/>"+cid,
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
			$.messager.alert("提示", "请选择要查询的信息！", "info");  
			return;
		}else if(row.length>1){
			$.messager.alert("提示", "请选择单个要查询的信息！", "info");  
			return;
		}else{
			var cid = $("#cid").val();
			var rowtype = row[0].type;
			var tabTop = "<c:url value='/json/countygroupfinance.json'/>";
			var rowurl = "<c:url value='/financelishi.m?groupfinance.type='/>"+rowtype+"&groupfinance.cid="+cid;
			var hidcolumns = "cid,id";//隐藏列字段名
			var id = "id";//主键字段
			var formartColumns;
			$.post("<c:url value='/findOption.m'/>",function(optiondata){
				var type = optiondata.type;
				formartColumns = [{	
										field: 'type',
										formatter:function(value, row, index){
											var showTxt="";
											$(type).each(function(){
											 	if(value==this.dicvalue){
											 		showTxt=this.dicname;
											 	}
											});
											return showTxt;
										},
										editor: {  
										    type: 'combobox',  
										 	options: {  
										 		data: type,  
										 		valueField: 'dicvalue',  
										 		textField: 'dicname',  
										 		panelHeight: 'auto'  
										 	}  
										}  
									}
									];
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
		},"json");
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'集体收支          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="village" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFinance()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<!-- <a href="javascript:deletedFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a> -->
    		<!-- <a href="javascript:updateVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a> -->
    		<a href="javascript:savebg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<!-- <a href="javascript:saveUpdatedFinance()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a> -->
    		<input type="hidden" id="cid"><!-- 村id -->
	      	<!-- <span>村党支部书记:</span><input type="text" id="cdzbsj" value="" size=10 /> -->
	      	<!-- <span>类型
		      	<select id="type">
		      		<option value="">-请选择-</option>
		      		<option value="1">集体资产</option>
		      		<option value="2">收入</option>
		      		<option value="3">负债</option>
		      	</select>
	       </span>
	        <a href="javascript:findFinanceWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> -->
	  		<a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    	</div>
    </div>
    
    
    <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="lis" toolbar="#seach"></table>
	    </div>  
	</div>
    
    
    <div id="win" class="easyui-window" title="收支添加" style="width:420px;height:200px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFinance">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			    <table style="line-height: 60px;width: 100%;">
			    	<tr>
				    	<th>类型</th>
				    	<td>
				    		<select name="groupfinance.type" class="easyui-validatebox" data-options="required:true" style="height:40px">
					      		<option value="">-请选择-</option>
					      		<option value="1">集体资产</option>
					      		<option value="2">收入</option>
					      		<option value="3">负债</option>
					      	</select>
				    	</td>
				    	<th>金额</th>
				    	<td>
				    		<input type="text" name="groupfinance.privce" data-options="required:true,validType:'privce'" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>明细</th>
				    	<td>
				    		<input type="text" name="groupfinance.message" data-options="required:true,validType:'message'" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddFinance()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="基本信息变更" style="width:420px;height:200px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<table  style="line-height: 60px;width: 100%;">
			    	<tr>
				    	<th>类型</th>
				    	<td>
				    		<select name="groupfinance.type"  id="types" style="height:40px">
					      		<!-- <option value="">-请选择-</option>
					      		<option value="1">集体资产</option>
					      		<option value="2">收入</option>
					      		<option value="3">负债</option> -->
					      	</select>
				    	</td>
				    	<th>金额</th>
				    	<td>
				    		<input type="text" name="groupfinance.privce" value="" id="privce" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>明细</th>
				    	<td>
				    		<input type="text" name="groupfinance.message" value="" id="message" style="height:40px"/>
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