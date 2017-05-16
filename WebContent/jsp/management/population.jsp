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
var selectRow = undefined; //定义全局变量：当前选中的行
$(document).ready(function(){
	 var treeobj = $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 $("#num").attr("value",node.num);
	    	 $("#level").attr("value",node.level);
	    	 if(node.level!='0'){
	    	 	$.post("<c:url value='/population/findOption.m'/>",function(optiondata){
	    		 	var xb = optiondata.xb;
	    			var zzmm = optiondata.zzmm;
	    			var hyzk = optiondata.hyzk;
	    			var whcd = optiondata.whcd;
	    		 	var idarr = ["xb","zzmm","hyzk","whcd"];
	    			for (var i = 0; i < idarr.length; i++) {
	    				$("#"+idarr[i]).html("<option value=''>-请选择-</option>");
	    			}
	    			var idarr2 = ["xm","sfzhm","csrq"];
	    			for (var i = 0; i < idarr2.length; i++) {
	    				$("#"+idarr2[i]).val("");
	    			}
	    			for (var i = 0; i < xb.length; i++) {
	    				$("#xb").append("<option value='"+xb[i].dicvalue+"'>"+xb[i].dicname+"</option>");
	    			}
	    			for (var i = 0; i < zzmm.length; i++) {
	    				$("#zzmm").append("<option value='"+zzmm[i].dicvalue+"'>"+zzmm[i].dicname+"</option>");
	    			}
	    			for (var i = 0; i < hyzk.length; i++) {
	    				$("#hyzk").append("<option value='"+hyzk[i].dicvalue+"'>"+hyzk[i].dicname+"</option>");
	    			}
	    			for (var i = 0; i < whcd.length; i++) {
	    				$("#whcd").append("<option value='"+whcd[i].dicvalue+"'>"+whcd[i].dicname+"</option>");
	    			}
	    		},"json");
	    	 	findFlowPerson(node.num,node.text,node.level,"");
	    	 }
	 	 }
	 });
});

function findFlowPerson(cnum,text,level,personname){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/population.json'/>";
	var rowurl = "<c:url value='/population/queryPopulation.m?country.num='/>"+cnum+"&country.level="+level+personname;
	var hidcolumns = "id,fid,yhzgx";//隐藏列字段名
	var id = "id";//主键字段名
	//var frozenColumns = [[{}]];
	var frozenColumns = [
		{'field':'ck','checkbox':'true'},
		{'field':'xm','title':'姓名','width':'80','align':'center'}
     ];
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
	        frozenColumns:[frozenColumns],
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
		if($("#xb").val()!=''){
			personWhere += "&xb="+encodeURI(encodeURI($("#xb").val()));
		}
		if($("#csrq1").val()!=''){
			personWhere += "&csrq1="+encodeURI(encodeURI($("#csrq1").val()));
		}
		if($("#csrq2").val()!=''){
			personWhere += "&csrq2="+encodeURI(encodeURI($("#csrq2").val()));
		}
		if($("#zzmm").val()!=''){
			personWhere += "&zzmm="+encodeURI(encodeURI($("#zzmm").val()));
		}
		if($("#hyzk").val()!=''){
			personWhere += "&hyzk="+encodeURI(encodeURI($("#hyzk").val()));
		}
		if($("#whcd").val()!=''){
			personWhere += "&whcd="+encodeURI(encodeURI($("#whcd").val()));
		}
		if($("#sfzhm").val()!=''){
			personWhere += "&sfzhm="+$("#sfzhm").val();
		}
		
		var csrq1 = $("#csrq1").val();
		var csrq2 = $("#csrq2").val();
		if(csrq2<csrq1){
			alert("出生日期请按从早到晚填写，如：1992-05-15 - 1997-05-15");
			return;
		}
		findFlowPerson(cnum,"",level,personWhere);
	}
</script>
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
    		<span>&emsp;姓&emsp;&emsp;名:&emsp;</span><input type="text" id="xm" value="" size=10 /> 
    		<span>&emsp;性&emsp;&emsp;别:&emsp;</span>
    		<select id=xb>
    			<option value="">-请选择-</option>
    		</select>
    		<span>&emsp;出生日期:&emsp;</span>
    		<!-- <input type="text" id="csrq1" class="easyui-datebox" style="width:100px;"/>
    		<input type="text" id="csrq2" class="easyui-datebox" style="width:100px;"/> -->
			<input type="text" id="csrq1"  onClick="WdatePicker()" class="Wdate"/>&nbsp;-
			<input type="text" id="csrq2"  onClick="WdatePicker()" class="Wdate"/>
    		<span>&emsp;政治面貌:&emsp;</span>
    		<select id="zzmm">
    			<option value="">-请选择-</option>
    		</select>
    		<br/><br/>
    		<span>&emsp;婚姻状况:&emsp;</span>
    		<select id="hyzk">
    			<option value="">-请选择-</option>
    		</select>
    		<span>&emsp;文化程度:&emsp;</span>
    		<select id="whcd">
    			<option value="">-请选择-</option>
    		</select>
    		<span>&emsp;身份证号:&emsp;</span><input type="text" id="sfzhm" value="" size=10 style="width:140px;"/>   
	        &emsp;&emsp;<a href="javascript:findWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> 
    	</div>
    	
 </div>
</body>
</html>