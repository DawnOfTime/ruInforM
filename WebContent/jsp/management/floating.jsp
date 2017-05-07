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
	    	 $("#num").attr("value",node.num);
	    	 $("#level").attr("value",node.level);
	    	 findFlowPerson(node.num,node.text,node.level,"");
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
function findFlowPerson(cnum,text,level,personName){
	var tabTop = "<c:url value='/json/flowPerson.json'/>";
	var rowurl = "<c:url value='/floating/findFlowPerson.m?country.num='/>"+cnum+"&country.level="+level+personName;
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

function findFlowPersonWhere(){
	var cnum= $("#num").val();
	var level= $("#level").val();
	var personWhere = "";
	if($("#name").val()!=''){
		personWhere += "&name="+encodeURI(encodeURI($("#name").val()));
	}
	if($("#id_card").val()!=''){
		personWhere += "&id_card="+$("#id_card").val();
	}
	if($("#state").val()!=''){
		personWhere += "&state="+$("#state").val();
	}
	findFlowPerson(cnum,"",level,personWhere);
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
    		<input type="hidden" id="cid"><!-- 村id -->
    		<input type="hidden" id="num">
    		<input type="hidden" id="level">
	        <span>姓名:</span><input type="text" id="name" value="" size=10 />
	        <span>身份证号:</span><input type="text" id="id_card" value="" size=20 />
	        <span>状态：</span>
	        <select id="state">
	        	<option value="">--请选择--</option>
	        	<option value="0">流入</option>
	        	<option value="1">流出</option>
	        </select>
	        <a href="javascript:findFlowPersonWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> 
	    </div>
    </div>
    
</body>
</html>