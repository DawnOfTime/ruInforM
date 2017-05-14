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
	 var treeobj = $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 $("#num").attr("value",node.num);
	    	 $("#level").attr("value",node.level);
	    	 findFlowPerson(node.num,node.text,node.level,"");
	 	 }
	 });
	
});

function findFlowPerson(cnum,text,level,personname){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/person_message.json'/>";
	var rowurl = "<c:url value='/population/queryPopulation.m?country.num='/>"+cnum+"&country.level="+level+personname;
	var hidcolumns = "id,fid,yhzgx";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	var formartColumns;
	$.post("<c:url value='/population/findOption.m'/>",function(optiondata){
		var xb = optiondata.xb;
		var yhzgx = optiondata.yhzgx;
		var zzmm = optiondata.zzmm;
		var hyzk = optiondata.hyzk;
		var jkzk = optiondata.jkzk;
		var whcd = optiondata.whcd;
		var cyzt = optiondata.cyzt;
		var zylx = optiondata.zylx;
		var gzdw = optiondata.gzdw;
		
		formartColumns = [{	
								field: 'xb',
								formatter:function(value, row, index){
									var showTxt="";
									$(xb).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: xb,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'yhzgx',
								formatter:function(value, row, index){
									var showTxt="";
									$(yhzgx).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: yhzgx,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
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
							},
							{	
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
							},
							{	
								field: 'jkzk',
								formatter:function(value, row, index){
									var showTxt="";
									$(jkzk).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: jkzk,  
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
								field: 'cyzt',
								formatter:function(value, row, index){
									var showTxt="";
									$(cyzt).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: cyzt,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'zylx',
								formatter:function(value, row, index){
									var showTxt="";
									$(zylx).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: zylx,  
								 		valueField: 'dicvalue',  
								 		textField: 'dicname',  
								 		panelHeight: 'auto'  
								 	}  
								}  
							},
							{	
								field: 'gzdw',
								formatter:function(value, row, index){
									var showTxt="";
									$(gzdw).each(function(){
									 	if(value==this.dicvalue){
									 		showTxt=this.dicname;
									 	}
									});
									return showTxt;
								},
								editor: {  
								    type: 'combobox',  
								 	options: {  
								 		data: gzdw,  
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
	        frozenColumns:[[]], 
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
	
function findWhere(){ 
	var cnum= $("#num").val();
	var level= $("#level").val();
	var personWhere = "";	
		if($("#xm").val()!=''){
			personWhere += "&xm="+encodeURI(encodeURI($("#xm").val()));
		}
		if($("#sfzhm").val()!=''){
			personWhere += "&sfzhm="+$("#sfzhm").val();
		}
		findFlowPerson(cnum,"",level,personWhere);
	}
	
</script>
<style type="text/css">

</style>
</head>
<body class="easyui-layout">
 <div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
 </div>
 <div data-options="region:'center',title:'信息'" style="padding:5px;background:#eee;">
    	<table id="dg" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    		<input type="hidden" id="cid"><!-- 村id -->
    		<input type="hidden" id="num">
    		<input type="hidden" id="level">
    		<!-- 表头 -->
    		<span>姓名:</span><input type="text" id="xm" value="" size=10 /> 
    		<span>性别:</span><input type="text" id="xm" value="" size=10 /> 
    		<span>身份证号:</span><input type="text" id="sfzhm" value="" size=10 />   
	        <a href="javascript:findWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> 
    	</div>
    	
 </div>
</body>
</html>