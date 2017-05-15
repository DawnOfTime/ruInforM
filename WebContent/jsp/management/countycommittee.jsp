<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="<c:url value='/js/Date/WdatePicker.js'/>"></script>
<script type="text/javascript">
var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
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
	var tabTop = "<c:url value='/json/countycommittee.json'/>";
	var rowurl = "<c:url value='/seachCommittee.m?cid='/>"+cid+villageName;
	var hidcolumns = "cid";//隐藏列字段名
	var id = "id";//主键字段名
	//锁定列
	var frozenColumns = [
							{'field':'ck','checkbox':'true'},
		                	{"field":"name","title":"姓名","width":"100","align":"center","editor":{"type":"text"}},
		                	{"field":"lxfs","title":"联系方式","width":"100","editor": {
		                        "type": "validatebox",
		                  		 "options":{
		       										"required":"true",
		       										"validType":"length[11,11]",
		       										"missingMessage":"不能为空",
		       										"invalidMessage":"请输入正确的数据"
		       					}	
			               },
			               "align":"center"
			               }
	                     ];
	var formartColumns;
	$.post("<c:url value='/findOptio.m'/>",function(optiondata){
		var sex = optiondata.sex;
		var whcd = optiondata.whcd;
		var state = optiondata.state;
		var zw = optiondata.zw;
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
							},
							{	
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
								field: 'zw',
								formatter:function(value, row, index){
									var showTxt="";
									$(zw).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: zw,  
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
		
		datagrid = $('#village').datagrid({ 
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
function addFlowPerson(){
		$("#win").window('open');
}
function findVillageWhere(){
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+encodeURI(encodeURI($("#name").val()));
	}
	findFlowPerson(personWhere);
}

function saveaddVillage(){
	var cid = $("#cid").val();
	$("#addFlowPerson").form("submit", {
        url: "<c:url value='/addCommittee.m?countrycommittee.cid='/>"+cid,
        onSubmit: function () {
   		 	$("#form_cid").val($("#cid").val());
        	if(!$(this).form("validate")){
        		$.messager.alert("提示信息", "部分数据格式错误");
        		return false;
        	}else{
        		$.messager.confirm('提示信息', '新纪录将覆盖旧记录，确定继续?',function(r){
        			if(!r){
        				return false;
        			}
        		});
        	}
        	return true;
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
	var posturl = "<c:url value='/saveCommittee.m'/>";
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

/* 变更 */
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
		  $.post("<c:url value='/findbg.m?countrycommittee.id='/>"+rowid+"&countrycommittee.cid="+cid,function (data){
			$("#names").attr("value",data[0].name);
			if(data[0].sex=='1'){
				$("#sex").append("<option value='1' selected='selected'>男</option><option value='0'>女</option>");
			}else if(data[0].sex=='0'){
				$("#sex").append("<option value='1'>男</option><option value='0' selected='selected'>女</option>");
			}
			$("#birthday").attr("value",data[0].birthday);
			
			if(data[0].whcd=='0'){
				$("#whcd").html("<option value='0'  selected='selected'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			
			}else if(data[0].whcd=='1'){
				$("#whcd").html("<option value='0'>文盲</option><option value='1' selected='selected'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='2'){
				$("#whcd").html("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2' selected='selected'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='3'){
				$("#whcd").html("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'selected='selected'>高中（中专）</option>"
		    			+"<option value='4'>大专及以上</option>");
			}else if(data[0].whcd=='4'){
				$("#whcd").html("<option value='0'>文盲</option><option value='1'>小学</option>"
		    			+"<option value='2'>初中</option>"
		    			+"<option value='3'>高中（中专）</option>"
		    			+"<option value='4'selected='selected'>大专及以上</option>");
			}
			$("#lxfs").attr("value",data[0].lxfs);
			$("#rxzsj").attr("value",data[0].rxzsj);
			$("#rznx").attr("value",data[0].rznx);
			$("#wyxm").attr("value",data[0].wyxm);
			if(data[0].state=='0'){
				$("#state").html("<option value='0' selected='selected'>在职</option><option value='1'>离职</option>");
			}else if(data[0].state=='1'){
				$("#state").html("<option value='1'>在职</option><option value='2' selected='selected'>离职</option>");
			}
			if(data[0].zw=='1'){
				$("#zw").html("<option value='1' selected='selected'>党委</option><option value='2'>村委</option><option value='3'>监委</option>");
			}else if(data[0].zw=='2'){
				$("#zw").append("<option value='1'>党委</option><option value='2' selected='selected'>村委</option><option value='3'>监委</option>");
			}else if(data[0].zw=='3'){
				$("#zw").html("<option value='1'>党委</option><option value='2'>村委</option><option value='3' selected='selected'>监委</option>");
			}
		},"json"); 
		  $("#wins").window('open'); 
	} 
	
}

function addFlowbg(){
	var cid = $("#cid").val();
	$("#addFlowbg").form("submit", {
        url: "<c:url value='/addCommittee.m?countrycommittee.cid='/>"+cid,
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
		var rowzw = row[0].zw;
		var tabTop = "<c:url value='/json/countycommittee.json'/>";
		var rowurl = "<c:url value='/findlishi.m?countrycommittee.zw='/>"+rowzw+"&countrycommittee.cid="+cid;
		var hidcolumns = "cid,id";//隐藏列字段名
		var id = "id";//主键字段
		var frozenColumns = [
								{'field':'ck','checkbox':'true'},
			                	{"field":"name","title":"姓名","width":"100","align":"center","editor":{"type":"text"}},
			                	{"field":"lxfs","title":"联系方式","width":"100","editor": {
			                        "type": "validatebox",
			                  		 "options":{
			       										"required":"true",
			       										"validType":"length[11,11]",
			       										"missingMessage":"不能为空",
			       										"invalidMessage":"请输入正确的数据"
			       					}	
				               },
				               "align":"center"
				               }
		                     ];
		var formartColumns;
		$.post("<c:url value='/findOptio.m'/>",function(optiondata){
			var sex = optiondata.sex;
			var whcd = optiondata.whcd;
			var state = optiondata.state;
			var zw = optiondata.zw;
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
								},
								{	
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
									field: 'zw',
									formatter:function(value, row, index){
										var showTxt="";
										$(zw).each(function(){
										 	if(value==this.dicvalue){
										 		showTxt=this.dicname;
										 	}
										});
										return showTxt;
									},
									editor: {  
									    type: 'combobox',  
									 	options: {  
									 		data: zw,  
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
		        remoteSort: false,  
		        singleSelect: true,//是否单选 
		        pagination: true,//分页控件 
		        rownumbers: true,//行号 
		        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
		        checkOnSelect: true,//选中行,不默认选中当前行的复选框
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
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'委员查询           （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="village" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:updateWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:savebg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更信息</a>
    		<a href="javascript:saveUpdatedCommunication()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	       <span>姓名:</span><input type="text" id="name" value="" size=10 />
	       <a href="javascript:findVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
	       <a href="javascript:savelishi()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    		
	    </div>
    </div>
    
    <div id="lishi" class="easyui-window" title="历史记录" style="width:600px;height:400px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="ls" toolbar="#seach"></table>
	    </div>  
	</div>
    <div id="win" class="easyui-window" title="委员添加" style="width:600px;height:400px"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true" ">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
			    <table border="1" style="margin-top:20px">
			    	<tr>
				    	<th>姓名</th>
				    	<td>
				    		<input type="text" name="countrycommittee.name" data-options="required:true,validType:'name'" style="height:40px"/>
				    	</td>
				    	<th>性别</th>
				    	<td>
						    <select name="countrycommittee.sex">
						    	<option value="">-请选择-</option>
						    	<option value="1">男</option>
						    	<option value="0">女</option>
						    </select>	
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>出生年月日</th>
				    	<td>
				    		<input type="text" name="countrycommittee.birthday" data-options="required:true,validType:'birthday'" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
				    	<th>文化程度</th>
				    	<td>
				    		<select name="countrycommittee.whcd">
				    			<option value="">-请选择-</option>
				    			<option value="0">文盲</option>
				    			<option value="1">小学</option>
				    			<option value="2">初中</option>
				    			<option value="3">高中（中专）</option>
				    			<option value="4">大专及以上</option>
				    		</select>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>联系方式</th>
				    	<td>
				    		<input type="text" name="countrycommittee.lxfs" data-options="required:true,validType:'lxfs'" style="height:40px"/>
				    	</td>
				    	<th>入职时间</th>
				    	<td>
				    		<input type="text" name="countrycommittee.rxzsj" data-options="required:true,validType:'rxzsj'" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>离职时间</th>
				    	<td>
				    		<input type="text" name="countrycommittee.rznx" data-options="required:true,validType:'rznx'" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
				    	<th>村党组织委员姓名</th>
				    	<td>
				    		<input type="text" name="countrycommittee.wyxm" data-options="required:true,validType:'wyxm'" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>状态</th>
			    		<td>
			    			<select name="countrycommittee.state">
			    				<option value="">-请选择-</option>
			    				<option value="1">在职</option>
			    				<option value="2">离职</option>
			    			</select>
			    		</td>
			    		<th>职位</th>
				    	<td>
				    		<!-- <input type="text" name="countrycommittee.zw" data-options="required:true,validType:'zw'" style="height:40px"/> -->
				    		<select name="countrycommittee.zw">
				    			<option value="">-请选择-</option>
				    			<option value="1">党委</option>
				    			<option value="2">村委</option>
				    			<option value="3">监委</option>
				    		</select>
				    	</td>
			    	</tr>
			    	<tr>
			    		<th colspan="4"><a href="javascript:saveaddVillage()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></th>
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
			   <input type="hidden" id="form_cid" name="country_flow.cid">
			    <table border="1" style="margin-top:20px">
			    	<tr>
				    	<th>姓名</th>
				    	<td>
				    		<input type="text" name="countrycommittee.name" value="" id="names" style="height:40px"/>
				    	</td>
				    	<th>性别</th>
				    	<td>
						    <select name="countrycommittee.sex"  id="sex">
						    	<!-- <option value="">-请选择-</option>
						    	<option value="1">男</option>
						    	<option value="2">女</option> -->
						    </select>	
	
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>出生年月日</th>
				    	<td>
				    		<input type="text" name="countrycommittee.birthday" value="" id="birthday" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
				    	<th>文化程度</th>
				    	<td>
				    		<select name="countrycommittee.whcd" id="whcd">
				    			<!-- <option value="">-请选择-</option>
				    			<option value="0">文盲</option>
				    			<option value="1">小学</option>
				    			<option value="2">初中</option>
				    			<option value="3">高中（中专）</option>
				    			<option value="4">大专及以上</option> -->
				    		</select>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>联系方式</th>
				    	<td>
				    		<input type="text" name="countrycommittee.lxfs" value="" id="lxfs"style="height:40px"/>
				    	</td>
				    	<th>入职时间</th>
				    	<td>
				    		<input type="text" name="countrycommittee.rxzsj" value="" id="rxzsj" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>离职时间</th>
				    	<td>
				    		<input type="text" name="countrycommittee.rznx" value="" id="rznx" style="height:40px"  onClick="WdatePicker()" class="Wdate"/>
				    	</td>
				    	<th>村党组织委员姓名</th>
				    	<td>
				    		<input type="text" name="countrycommittee.wyxm" value="" id="wyxm" style="height:40px"/>
				    	</td>
			    	</tr>
			    	<tr>
				    	<th>状态</th>
			    		<td>
			    			<select name="countrycommittee.state" id="state">
			    				<!-- <option value="">-请选择-</option>
			    				<option value="0">在职</option>
			    				<option value="1">离职</option> -->
			    			</select>
			    		</td>
			    		<th>职位</th>
				    	<td>
				    		<!-- <input type="text" name="countrycommittee.zw" value="" id="zw" style="height:40px"/> -->
				    		<select name="countrycommittee.zw" id="zw">
				    		</select>
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