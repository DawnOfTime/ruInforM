<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="<c:url value='/js/Date/WdatePicker.js'/>"></script>
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


function findFlowPerson(offname){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json//officer.json'/>";
	var rowurl = "<c:url value='/officer/queryofficer.m?cid='/>"+cid+offname;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	var formartColumns;
	$.post("<c:url value='/officer/findOption.m'/>",function(optiondata){
		var state = optiondata.state;
		var sex = optiondata.sex;
		var whcd = optiondata.whcd;
		formartColumns = [{	
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
							},
							{	
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
							},
							{	
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
	$("#win").window('open');
}
function findWhere(){ 
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+$("#name").val();
	}
	findFlowPerson(personWhere);
}
function saveaddOfficer(){
	var cid = $("#cid").val();
	$("#addFlowPerson").form("submit", {
	    url: "<c:url value='/officer/addOfficer.m?countryofficer.cid='/>"+cid,
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
function saveUpdatedOffice(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/officer/saveOfficer.m'/>";
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
function savebgoffice(){
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
		  $.post("<c:url value='/officer/findbg.m?countryofficer.id='/>"+rowid+"&countryofficer.cid="+cid,function (data){
			$("#names").attr("value",data[0].name);
			if(data[0].sex=='1'){
				$("#sexs").append("<option value='1' selected='selected'>男</option><option value='0'>女</option>");
			}else if(data[0].sex=='0'){
				$("#sexs").append("<option value='1'>男</option><option value='0' selected='selected'>女</option>");
			}
			$("#birthday").attr("value",data[0].birthday);
			
			if(data[0].whcd=='0'){
				$("#whcd").append("<option value='0'  selected='selected'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			
			}else if(data[0].whcd=='1'){
				$("#whcd").append("<option value='0'>文盲</option><option value='1' selected='selected'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='2'){
				$("#whcd").append("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2' selected='selected'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='3'){
				$("#whcd").append("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'selected='selected'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='4'){
				$("#whcd").append("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'selected='selected'>大专及以上</option>");
			}
			$("#intime").attr("value",data[0].intime);
			$("#lztime").attr("value",data[0].lztime);
			$("#phonenumber").attr("value",data[0].phonenumber);
			if(data[0].state=='1'){
				$("#state").append("<option value='1' selected='selected'>在职</option><option value='2'>离职</option>");
			}else if(data[0].state=='2'){
				$("#state").append("<option value='1'>在职</option><option value='2' selected='selected'>离职</option>");
			}
		},"json"); 
		  $("#wins").window('open'); 
	} 
	
}
function addFlowbg(){
	var cid = $("#cid").val();
	$("#addFlowbg").form("submit", {
        url: "<c:url value='/officer/addOfficer.m?countryofficer.cid='/>"+cid,
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
	 var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要查看的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要查看的行！", "info");  
		return;
	}else{
		var cid = $("#cid").val();
		var rowid = row[0].id;
		var tabTop = "<c:url value='/json/officer.json'/>";
		var rowurl = "<c:url value='/officer/seachlishi.m?countryofficer.id='/>"+rowid+"&countryofficer.cid="+cid;
		var hidcolumns = "cid,id";//隐藏列字段名
		var id = "id";//主键字段
		var frozenColumns = [];
		var formartColumns;
		$.post("<c:url value='/officer/findOption.m'/>",function(optiondata){
			var state = optiondata.state;
			var sex = optiondata.sex;
			var whcd = optiondata.whcd;
			formartColumns = [{	
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
								},
								{	
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
								},
								{	
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
		        frozenColumns:[frozenColumns], 
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
		});
		  $("#lishi").window('open');
	},"json");
	}
}
</script>
<style type="text/css">
	#tables{
	border:1px;
	margin-top:30px;
	margin-left:60px;
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
    		<a href="javascript:updateVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:savebgoffice()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<a href="javascript:saveUpdatedOffice()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	        <span>村官姓名:</span><input type="text" id="name" value="" size=10 />  
	        <a href="javascript:findWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
	        <a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a> 
	    </div>
 </div>
 <div id="win" class="easyui-window" title="村官信息添加" style="width:600px;height:400px;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<table id="tables">
		    		<tr>
		    			<td>姓名:</td>
		    			<td><input type="text" name="countryofficer.name"  data-options="required:true,validType:'name'" /></td>
		    			<td>性别:</td>
		    			<td>
		    				<select name="countryofficer.sex"  data-options="required:true,validType:'sex'">
		    					<option>--请选择--</option>
		    					<option value="1">男</option>
		    					<option value="0">女</option>
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>出生日期:</td>
		    			<td><input type="text" name="countryofficer.birthday"  data-options="required:true,validType:'birthday'" onClick="WdatePicker()" class="Wdate"/></td>
		    			<td>文化程度:</td>
		    			<td>
		    				<select name="countryofficer.whcd"  data-options="required:true,validType:'whcd'">
		    					<option>--请选择--</option>
		    					<option value="0">文盲</option>
		    					<option value="1">小学</option>
		    					<option value="2">初中</option>
		    					<option value="3">高中(中专)</option>
		    					<option value="4">大专以上</option>
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>入职时间:</td>
		    			<td><input type="text" name="countryofficer.intime"  data-options="required:true,validType:'intime'" onClick="WdatePicker()" class="Wdate"/></td>
		    			<td>状态:</td>
		    			<td>
		    				<select name="countryofficer.state"  data-options="required:true,validType:'state'">
		    					<option>--请选择--</option>
		    					<option value="1">在职</option>
		    					<option value="2">离职</option>
		    				</select>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>联系方式:</td>
		    			<td colspan="3"><input type="text" name="countryofficer.phonenumber"  data-options="required:true,validType:'phonenumber'"/> </td>
		    		</tr>
		    		<tr>
		    			<td colspan="4" class="baocun"><a href="javascript:saveaddOfficer()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>  
	</div>
	 <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="ls" toolbar="#seach"></table>
	    </div>  
	</div>
	<div id="wins" class="easyui-window" title="村官信息变更" style="width:600px;height:400px"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowbg">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			   <table id="tables">
		    		<tr>
		    			<td>姓名:</td>
		    			<td><input type="text" name="countryofficer.name" id="names"/></td>
		    			<td>性别:</td>
		    			<td>
		    				<select name="countryofficer.sex" id="sexs">
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>出生日期:</td>
		    			<td><input type="text" name="countryofficer.birthday" id="birthday"  onClick="WdatePicker()" class="Wdate"/></td>
		    			<td>文化程度:</td>
		    			<td>
		    				<select name="countryofficer.whcd" id="whcd" >
		    					
		    				</select>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>入职时间:</td>
		    			<td><input type="text" name="countryofficer.intime" id="intime"  onClick="WdatePicker()" class="Wdate"/></td>
		    			<td>离职时间:</td>
		    			<td><input type="text" name="countryofficer.lztime" id="lztime"   onClick="WdatePicker()" class="Wdate"/></td>
		    		</tr>
		    		<tr>
		    			<td>联系方式:</td>
		    			<td><input type="text" name="countryofficer.phonenumber" id="phonenumber"  /> </td>
		    			<td>状态:</td>
		    			<td>
		    				<select name="countryofficer.state" id="state">
		    				</select>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="4" class="baocun"><a href="javascript:addFlowbg()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
		    		</tr>
		    	</table>
		    </form>
		</div>
	</div> 
</body>
</html>