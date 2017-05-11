<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="<c:url value='/js/Date/WdatePicker.js'/>"></script>
<link href="/umed/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript"> 
var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
	$(document).ready(function(){
		findFlowPerson("");
	});	
	function findFlowPerson(findseach){
		var tabTop = "<c:url value='/json/article.json'/>";
		var rowurl = "<c:url value='/findquery.m'/>"+findseach;
		var hidcolumns = "id";//隐藏列字段名
		var id = "id";//主键字段名
		var frozenColumns = [[{}]];
		var formartColumns;
		$.post("<c:url value='/Examine/findOption.m'/>",function(optiondata){
			var state = optiondata.state;
			var types = optiondata.types;
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
			}
			,
			{
			field: 'types',
			formatter:function(value, row, index){
				var showTxt="";
				$(types).each(function(){
				 	if(value==this.dicvalue){
				 		showTxt=this.dicname;
				 	}
				});
				return showTxt;
			},
			editor: {  
			    type: 'combobox',  
			 	options: {  
			 		data: types,  
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
			        pageList: [10],//可以设置每页记录条数的列表 
			        beforePageText: '第',//页数文本框前显示的汉字 
			        afterPageText: '页    共 {pages} 页', 
			        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
			    }); 
			});
		},'json');
	}
	function findWhere(){ 
		var personWhere = "";
		if($("#types").val()!=''){
			personWhere += "?types="+$("#types").val();
		} 
		else if ($("#state").val()!=''){
			personWhere += "?state="+$("#state").val();
		} else if($("#starttime").val()!=''&&($("#overtime").val()!='')){
			personWhere += "?starttime="+$("#starttime").val();
			personWhere += "&overtime="+$("#overtime").val();
		}
		
		if($("#state").val()!=''){
			personWhere += "&state="+$("#state").val();
		}
		if($("#starttime").val()!=''&&($("#overtime").val()!='')){
			personWhere += "&starttime="+$("#starttime").val();
			personWhere += "&overtime="+$("#overtime").val();
		}
		
		findFlowPerson(personWhere);
	}		
	//修改弹框
	function updatetmp(id){ 
		var rows=datagrid.datagrid("getChecked");
		if(rows.length<1){
		$.messager.alert("提示", "请选择要修改的行！", "info");
		}
		if(rows.length>1){
			$.messager.alert("提示", "请选择一行进行修改！", "info");
		}
		if(rows.length==1){
			$(rows).each(function(){
				var delIndex=datagrid.datagrid("getRowIndex",this.id); 
				var obj= new Object;
				obj.name=this.id;
				obj.state=this["state"];
				if(obj.state==3||obj.state==4||obj.state==1){
					var someValue=window.showModalDialog("../../umed/updatew.html",obj,"dialogWidth=1090px;dialogHeight=500px;dialogLeft=270px;dialogTop=220px;status=no;help=no;scrollbars=no;");
		            window.location.reload();
				}else{
					$.messager.alert("提示", "无权操作！", "info");
				}
			});
			
		}
	}
	//删除
	function deletedata() {
		var count=0;
		var rows=datagrid.datagrid("getChecked");
		if(rows.length!=0){
		$(rows).each(function(){
		//var delIndex=datagrid.datagrid("getRowIndex",this[id]); 
		var obj= new Object;
		obj.state=this["state"];
		 alert(obj.state);
		if(obj.state==4){
				var delIndex=datagrid.datagrid("getRowIndex",this.id);  
				datagrid.datagrid("deleteRow",delIndex);
		
		} /*else{ 
			$.messager.alert("提示", "无权操作！", "info"); 
			
		}*/
		
		});
		}else if(rows.length==0){
			$.messager.alert("提示", "请选择要删除的行！", "info");   
		}
		$(rows).each(function(){
			var obj= new Object;
			obj.state=this["state"];
			if(obj.state==1||obj.state==2||obj.state==3||obj.state==5){
				alert(count);
				count++;
			}
		});
		if(count!=0){
			$.messager.alert("提示", "有"+count+"条数据无权操作！", "info"); 
		}
	}
	//保存删除
	function saveUpdated(){
		datagrid.datagrid('endEdit', editRow);
		var posturl = "<c:url value='/findSave.m'/>";
		var deleted = datagrid.datagrid('getChanges', "deleted");
		var effectRow = new Object();
		if (deleted.length) {
			effectRow["deleted"] = JSON.stringify(deleted);
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
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',title:'发布'" >
    	<table id="dg" toolbar="#searchtool"></table>
    	<div id="searchtool" style="padding:5px;display:none;">
    	<a href="javascript:updatetmp()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    	<a href="javascript:deletedata()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
    	<a href="javascript:saveUpdated()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    	<span>类别:</span>
    	<select id="types">
    		<option value="">--请选择--</option>
    	 	<option value="1">最新咨询</option>
    	 	<option value="2">政策法规</option>
    	 	<option value="3">社会事务</option>
    	 	<option value="4">党群管理</option>
    	 	<option value="5">通知公告</option>
    	 </select>
    	 <span>状态:</span>
    	 	<select id="state">
    	 	<option value="">--请选择--</option>
    	 	<option value="1">待审核</option>
    	 	<option value="2">通过</option>
    	 	<option value="3">未通过</option>
    	 	<option value="4">草稿</option>
    	 </select>
    	 <span>发布时间段</span>
    	 <input type="text" id="starttime"  onClick="WdatePicker()" class="Wdate"/> 至
    	 <input type="text" id="overtime"  onClick="WdatePicker()" class="Wdate"/>
		 <a href="javascript:findWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    	</div>
    </div>
</body>
</html>