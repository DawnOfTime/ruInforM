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
	    		 $("#form_cid").val(node.id);
	    		 findFlowPerson("");
	    	 }
		 }
	 });
	$("#win").window({
		closed: true
	});
	//定义验证类型
	 $.extend($.fn.validatebox.defaults.rules, {
		name : {
           validator : function(value, param) {  
           	return /^[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value);
           },  
           message : '请输入姓名'  
		},id_card : {
			validator : function(value, param) {  
				return /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/.test(value);
			},
			message : '请输入身份证号码'  
		},date : {
			validator : function(value, param) {  
				return /((^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(10|12|0?[13578])([-\/\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(11|0?[469])([-\/\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(0?2)([-\/\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([3579][26]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][13579][26])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][13579][26])([-\/\._])(0?2)([-\/\._])(29)$))/.test(value);
			},
			message : '请输入正确格式的日期（YYYY-MM-DD）'
		}
	 });
});
function findFlowPerson(personName){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/flowPerson.json'/>";
	var rowurl = "<c:url value='/flow/findFlowPerson.m?cid='/>"+cid+personName;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	//锁定列
	var frozenColumns = [
							{'field':'ck','checkbox':'true'},
							{'field':'name','title':'姓名','width':100,'align':'center','editor':{'type':'validatebox',
								'options':{
									'required':'true',
									'validType':'name',
									'missingMessage':'该输入项不能为空',
		                            'invalidMessage':'姓名格式不正确'
									}
								}},
							{'field':'id_card','title':'身份证号','width':150,'align':'center','editor':{'type':'validatebox',
								'options':{
									'required':'true',
									'validType':'id_card',
									'missingMessage':'该输入项不能为空',
		                            'invalidMessage':'身份证号格式不正确'
									}
								}},
	                     ];
	var formartColumns;
	$.post("<c:url value='/flow/findOption.m'/>",function(optiondata){
		var state = optiondata.state;
		var sex = optiondata.sex;
		var hyzk = optiondata.hyzk;
		var whcd = optiondata.whcd;
		var zzmm = optiondata.zzmm;
		//下拉框
		formartColumns=[{
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
						},{
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
						},{
							field: 'hyzk',
							formatter:function(value, row, index){
								var showTxt="";
								$(hyzk).each(function(){
								 	if(value==this.dicvalue){
								 		showTxt=this.dicname;
								 	}
								});
								return showTxt;
							},
							editor: {  
							    type: 'combobox',  
							 	options: {  
							 		data: hyzk,  
							 		valueField: 'dicvalue',  
							 		textField: 'dicname',  
							 		panelHeight: 'auto'  
							 	}  
							}  
						},{
							field: 'zzmm',
							formatter:function(value, row, index){
								var showTxt="";
								$(zzmm).each(function(){
								 	if(value==this.dicvalue){
								 		showTxt=this.dicname;
								 	}
								});
								return showTxt;
							},
							editor: {  
							    type: 'combobox',  
							 	options: {  
							 		data: zzmm,  
							 		valueField: 'dicvalue',  
							 		textField: 'dicname',  
							 		panelHeight: 'auto'  
							 	}  
							}  
						},{
							field: 'whcd',
							formatter:function(value, row, index){
								var showTxt="";
								$(whcd).each(function(){
								 	if(value==this.dicvalue){
								 		showTxt=this.dicname;
								 	}
								});
								return showTxt;
							},
							editor: {  
							    type: 'combobox',  
							 	options: {  
							 		data: whcd,  
							 		valueField: 'dicvalue',  
							 		textField: 'dicname',  
							 		panelHeight: 'auto'  
							 	}  
							}  
						}]
		$.getJSON(tabTop, function(data){
			//锁定列
			if(undefined!=frozenColumns){
				frozenColumns = frozenColumns;
			}else{
				frozenColumns = [{field:'ck',checkbox:true}];
			}
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
			datagrid = $('#flowPerson').datagrid({ 
		        columns:[data],
		        nowrap: true, 
		        striped: true, 
		        border: true, 
		        collapsible: false,//是否可折叠的 
		        fit: true,//自动大小 
		        url:rowurl, 
		        remoteSort: false,  
		        singleSelect: false,//是否单选 
		        pagination:true,//分页控件 
		        rownumbers:true,//行号 
		        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
		        checkOnSelect: true,//选中行,不默认选中当前行的复选框
		        idField: id,
		        frozenColumns:[frozenColumns], 
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
		    var p = $('#flowPerson').datagrid('getPager'); 
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
	$("#win").window('open');
}
function findFlowPersonWhere(){
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+$("#name").val();
	}
	if($("#id_card").val()!=''){
		personWhere += "&id_card="+$("#id_card").val();
	}
	findFlowPerson(personWhere);
}
function svaeAddFlowPerson(){
	$("#addFlowPerson").form("submit", {
        url: "<c:url value='/flow/addFlowPerson.m'/>",
        onSubmit: function () {
   		 	$("#form_cid").val($("#cid").val());
        	if(!$(this).form("validate")){
        		$.messager.alert("提示信息", "部分数据验证未通过");
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
function saveUpdatedFlowPerson(){
	if (editRow != undefined) {
    	datagrid.datagrid('endEdit', editRow);
    }
	var posturl = "<c:url value='/flow/saveFlowPerson.m'/>";
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
function updateFlowPerson(){
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
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'流动人口'" style="padding:5px;background:#eee;">
    	<table id="flowPerson" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:updateFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:saveUpdatedFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	        <span>姓名:</span><input type="text" id="name" value="" size=10 />
	        <span>身份证号:</span><input type="text" id="id_card" value="" size=20 />
	        <a href="javascript:findFlowPersonWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> 
	    </div>
    </div>
    <div id="win" class="easyui-window" title="添加流动人口记录" style="width:700px;height:450px;display:none;"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid"><!-- 村id -->
			    <table style="line-height: 55px;width: 100%;">
			    	<tr>
				    	<th>姓名</th>
				    	<td><input type="text" name="country_flow.name" class="easyui-validatebox" data-options="required:true,validType:'name'"/></td>
				    	<th>性别</th>
				    	<td>
				    		<select name="country_flow.sex" class="easyui-validatebox" data-options="required:true">
				    			<option value="">-请选择-</option>
				    			<option value="1">男</option>
				    			<option value="0">女</option>
				    		</select>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>年龄</th>
				    	<td><input type="text" name="country_flow.age" class="easyui-validatebox" data-options="required:true"/></td>
				    	<th>身份证号</th>
				    	<td><input type="text" name="country_flow.id_card" class="easyui-validatebox" data-options="required:true,validType:'id_card'"/></td>
			    	</tr>
			    	<tr>
				    	<th>户籍地</th>
				    	<td><input name="country_flow.hjd" class="easyui-validatebox" data-options="required:true"></input></td>
				    	<th>婚姻状况</th>
				    	<td>
				    		<select name="country_flow.hyzk" class="easyui-validatebox" data-options="required:true">
				    			<option value="">-请选择-</option>
				    			<option value="0">已婚</option>
				    			<option value="1">未婚</option>
				    		</select>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th>政治面貌</th>
				    	<td>
				    		<select name="country_flow.zzmm" class="easyui-validatebox" data-options="required:true">
				    			<option value="">-请选择-</option>
				    			<option value="0">群众</option>
				    			<option value="1">党员</option>
				    		</select>
				    	</td>
			    		<th>流入/流出时间</th>
				    	<td><input type="text" name="country_flow.totime" class="easyui-datebox" data-options="required:true,validType:'date'"/></td>
			    	</tr>
			    	<tr>
			    		<th>文化程度</th>
				    	<td>
				    		<select name="country_flow.whcd" class="easyui-validatebox" data-options="required:true">
				    			<option value="">-请选择-</option>
				    			<option value="0">文盲</option>
				    			<option value="1">小学</option>
				    			<option value="2">初中</option>
				    			<option value="3">高中（中专）</option>
				    			<option value="4">大专及以上</option>
				    		</select>
				    	</td>
				    	<th>流入流出原因</th>
				    	<td><input type="text" name="country_flow.towhy" class="easyui-validatebox" data-options="required:true"/></td>
			    	</tr>
			    	<tr>
			    		<th rowspan="2">暂住地及从事行业</th>
				    	<td rowspan="2"><input  name="country_flow.zzdjcshy" class="easyui-validatebox" data-options="required:true"></input></td>
				    	<th>流动状态</th>
				    	<td>
				    		<select name="country_flow.state" class="easyui-validatebox" data-options="required:true">
				    			<option value="">-请选择-</option>
				    			<option value="0">流入</option>
				    			<option value="1">流出</option>
				    		</select>
				    	</td>
			    	</tr>
			    	
			    	<tr>
			    		<td colspan="4"><a href="javascript:svaeAddFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
			    	</tr>
			    </table>
		    </form>
	    </div>  
	</div>
</body>
</html>