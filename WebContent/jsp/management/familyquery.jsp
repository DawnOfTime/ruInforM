<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value="/js/famliy.js"/>"></script>
<title>Insert title here</title>
<script type="text/javascript">
var familydatagrid; //定义全局变量datagrid
var familyeditRow = undefined; //定义全局变量：当前编辑的行
var selectRow = undefined; //定义全局变量：当前选中的行
$(document).ready(function(){
	 var treeobj = $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 $("#num").attr("value",node.num);
	    	 $("#level").attr("value",node.level);
	    	 findFamilyMessageListAll(node.num,node.text,node.level,"");
	    	 }
	 });
	
	 $("#win").window({
		 maximized: true,
		 closed: true
	 });
	 $("#addFamily").window({
		 closed: true,
		 onClose: function(){
             $("#newFamily").form("clear");
		 }
	 });
});
//该乡的所有户列表
function findFamilyMessageListAll(cnum,text,level,names){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/familyMessage.json'/>";
	var rowurl = "<c:url value='/message/findFamilyMessage.m?countrys.num='/>"+cnum+"&countrys.level="+level+names;
	var hidcolumns = "id,p_num";//隐藏列字段名
	var id = "id";//主键字段名
	$("#searchtool").css("display","block");//隐藏菜单栏
		$.getJSON(tabTop, function(data){
			familydatagrid = $('#familylistdg').datagrid({ 
		        columns:[data],
		        nowrap: false, 
		        striped: true, 
		        border: true, 
		        collapsible: false,//是否可折叠的 
		        fit: true,//自动大小 
		        url:rowurl, 
		        remoteSort: false,  
		        singleSelect: true,//是否单选 
		        pagination:true,//分页控件 
		        rownumbers:true,//行号 
		        selectOnCheck: true,//true勾选会选择行，false勾选不选择行, 1.3以后有此选项。重点在这里
		        checkOnSelect: true,//选中行,不默认选中当前行的复选框
		        idField: id,
		        frozenColumns:[[{field:'ck',checkbox: true}]], 
		        onAfterEdit: function (rowIndex, rowData, changes) {
		        	//保存
	            	//saveDataGrid(posturl);
		            familyeditRow = undefined;
		        },onBeforeLoad:function(){			//在请求载入数据之前触发
		        	if (familyeditRow != undefined) {
		        		familydatagrid.datagrid('endEdit', familyeditRow);
		            }
		        },onDblClickRow:function (rowIndex, rowData) {
		        	//getFamilyPersonList(rowData.id);//查询户详情
		        },onClickRow:function(rowIndex,rowData){
		            if (familyeditRow != undefined) {
		            	familydatagrid.datagrid('endEdit', familyeditRow);
		            }
		        },onSelect:function(rowIndex, rowData){
		        	familydatagrid.datagrid('endEdit', familyeditRow);
		        	familydatagrid.datagrid('unselectRow',rowIndex);//不选中行
		        },
		        onCheckAll:function(rows){
		        	familydatagrid.datagrid('unselectAll');
		        },onRowContextMenu:function(e, rowIndex, rowData){
		        	e.preventDefault();//不显示浏览器的右键菜单
		        	/* selectRow = rowData;
		        	familydatagrid.datagrid("selectRecord",rowData.id);//用id选中当前右击的节点
		        	// 显示上下文菜单
			 		$('#mm').menu('show', {
			 			left: e.pageX,
			 			top: e.pageY
			 		}); */
		        }
		    }); 
			if(hidcolumns!=""){
				var columns=new Array()
				columns=hidcolumns.split(",");
				for(var i=0;i<columns.length;i++){
					familydatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
				}
			}
		    //设置分页控件 
		    var p = $('#familylistdg').datagrid('getPager'); 
		    $(p).pagination({ 
		        pageSize: 10,//每页显示的记录条数，默认为10 
		        pageList: [5,10,15],//可以设置每页记录条数的列表 
		        beforePageText: '第',//页数文本框前显示的汉字 
		        afterPageText: '页    共 {pages} 页', 
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    }); 
		});
}
//条件查询
function FindData(){
	var cnum= $("#num").val();
	var level= $("#level").val();
	var personWhere = "";
	if($("#hzxm").val()!=''){
		personWhere += "&hzxm="+encodeURI(encodeURI($("#hzxm").val()));
	}
	if($("#hjd").val()!=''){
		personWhere += "&hjd="+encodeURI(encodeURI($("#hjd").val()));
	}
	if($("#xjdz").val()!=''){
		personWhere += "&xjdz="+encodeURI(encodeURI($("#xjdz").val()));
	}
	/* var hzxm = "&familyMessage.hzxm="+encodeURI(encodeURI($("#hzxm").val()));
	var hjd = "&familyMessage.hjd="+encodeURI(encodeURI($("#hjd").val()));
	var xjdz = "&familyMessage.xjdz="+encodeURI(encodeURI($("#xjdz").val())); */
	findFamilyMessageListAll(cnum,"",level,personWhere);
}
//获取家庭成员列表
function getFamilyPersonList(){
	var fid = undefined;
	var checkedrows = familydatagrid.datagrid("getChecked");
	if(checkedrows.length>0){
		fid = checkedrows[0].id;
	}
	if(fid==undefined){
		$.messager.alert("提示", "请选择要编辑的行！");  
        return; 
	}
	var tabTop = "<c:url value='/json/familyqury.json'/>";
	var rowurl = "<c:url value='/message/familyPersonList.m?familyMessage.id='/>"+fid;
	var posturl = "";
	var newRow = "{\"id\":\"\",\"yhzgx\":\"\",\"xm\":\"\",\"xb\":\"\",\"mz\":\"\",\"csrq\":\"\",\"zzmm\":\"\","+
		"\"rdsj\":\"\",\"szdzb\":\"\",\"hyzk\":\"\",\"jkzk\":\"\",\"whcd\":\"\",\"cyzt\":\"\",\"zylx\":\"\","+
		"\"gzdw\":\"\",\"sfzhm\":\"\",\"sjh\":\"\"}";
	var hidcolumns = "id";//隐藏列字段名
	var pid = "id";//主键字段名
	var formartColumns;
	$.post("<c:url value='/message/findOption.m'/>",function(optiondata){
		var yhzgx = optiondata.yhzgx;
		var xb = optiondata.xb;
		var zzmm = optiondata.zzmm;
		var hyzk = optiondata.hyzk;
		var jkzk = optiondata.jkzk;
		var whcd = optiondata.whcd;
		var cyzt = optiondata.cyzt;
		var zylx = optiondata.zylx;
		var gzdw = optiondata.gzdw;
			formartColumns = [{	
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
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,pid,"",formartColumns);
		$('#win').window('open');
	},"json");
}
/* 家庭信息 */
function familyInfor(){
	var fid = undefined;
	var checkedrows = familydatagrid.datagrid("getChecked");
	if(checkedrows.length>0){
		fid = checkedrows[0].id;
	}
	if(fid==undefined){
		$.messager.alert("提示", "请选择要编辑的行！");  
        return; 
	}
	window.open("<c:url value='/familyquery/getFamliyMessage.m?act=updated&familyMessage.id='/>"+fid,
			"newwindow",
			"height=700,width=1350,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, "
			+"resizable=no,location=no, status=no, z-look=yes");
}
</script>
</head>
<body class="easyui-layout">
    <div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'信息'" style="padding:5px;background:#eee;">
    	<table id="familylistdg" toolbar="#searchtool"></table>
    	<!-- 表头 -->
    	<div id="searchtool" style="padding:5px;display:none;">
    		<input type="hidden" id="cid"><!-- 村id -->
    		<input type="hidden" id="num">
    		<input type="hidden" id="level">
	        <span>户主姓名:</span><input type="text" id="hzxm" value="" size=10 />  
	        <span>户籍地:</span><input type="text" id="hjd" value="" size=10 />  
	        <span>现居地址:</span><input type="text" id="xjdz" value="" size=10 />  
	        <a href="javascript:FindData()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
	        <a href="javascript:getFamilyPersonList()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">家庭成员</a>
	        <a href="javascript:familyInfor()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">家庭信息</a> 
	    <div>
	    <!-- 右键菜单 -->
	    <!-- <div id="mm" class="easyui-menu" style="width:120px;">
			<div onclick="getFamilyPersonList()" data-options="iconCls:'icon-edit'">家庭成员</div>
			<div onclick="familyInfor()" data-options="iconCls:'icon-edit'">家庭信息</div>
		</div> -->
    </div>
    <!-- family详情弹出框 -->
    <div id="win" class="easyui-window" title="My Window" style="width:600px;height:400px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="dg" width="1200px" border="1" style="font-size: 14px;"></table>
	    </div>  
	</div>
</body>
</html>