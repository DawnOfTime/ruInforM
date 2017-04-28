<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var customDatagrid; //定义全局变量datagrid
var customEditRow = undefined; //定义全局变量：当前编辑的行
var selectRow = undefined; //定义全局变量：当前选中的行
$(document).ready(function(){
	 var treeobj = $('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 if($('#tt').tree("find",node.id).level==5){
	    		 $('#add').linkbutton('enable');
	    		 $('#familyFind').linkbutton('enable');
	    		 findFamilyMessageList(node.id,"");
	    		 $("#cid").val(node.id);
	    	 }else{
	    		 $('#add').linkbutton('disable');
	    		 $('#familyFind').linkbutton('disable');
	    	 }
	    	 customDatagrid.datagrid('clearSelections');
		 }
	 });
	//定义验证类型
	 $.extend($.fn.validatebox.defaults.rules, {
		date : {
			validator : function(value, param) {  
				return /((^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(10|12|0?[13578])([-\/\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(11|0?[469])([-\/\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(0?2)([-\/\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([3579][26]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][13579][26])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][13579][26])([-\/\._])(0?2)([-\/\._])(29)$))/.test(value);
			},
			message : '请输入正确格式的日期（YYYY-MM-DD）'
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
//获取该村的户列表
function findFamilyMessageList(id,hzxm){
	var tabTop = "<c:url value='/json/familyMessage.json'/>";
	var rowurl = "<c:url value='/message/findFamilyMessages.m?familyMessage.cid='/>"+id+hzxm;
	var posturl = "";
	var newRow = "";
	var hidcolumns = "id,p_num";//隐藏列字段名
	var id = "id";//主键字段名
	$("#searchtool").css("display","block");//隐藏菜单栏
	//pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id);
	$.getJSON(tabTop, function(data){
		customDatagrid = $('#familylistdg').datagrid({ 
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
	            customEditRow = undefined;
	        },onBeforeLoad:function(){			//在请求载入数据之前触发
	        	if (customEditRow != undefined) {
	        		customDatagrid.datagrid('endEdit', customEditRow);
	            }
	        },onDblClickRow:function (rowIndex, rowData) {
	        	//getFamilyPersonList(rowData.id);//查询户详情
	        },onClickRow:function(rowIndex,rowData){
	            if (customEditRow != undefined) {
	            	customDatagrid.datagrid('endEdit', customEditRow);
	            }
	        },onSelect:function(rowIndex, rowData){
	        	customDatagrid.datagrid('endEdit', customEditRow);
	        	customDatagrid.datagrid('unselectRow',rowIndex);//不选中行
	        },onCheckAll:function(rows){
	        	customDatagrid.datagrid('unselectAll');
	        }
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				customDatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
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
	var hzxm = $("#hzxm").val();
	var cid = $("#cid").val();
	findFamilyMessageList(cid,"&familyMessage.hzxm="+hzxm);
}
//获取家庭成员列表
function getFamilyPersonList(){
	var fid = undefined;
	var checkedrows = customDatagrid.datagrid("getChecked");
	if(checkedrows.length>0){
		fid = checkedrows[0].id;
	}
	if(fid==undefined){
		$.messager.alert("提示", "请选择要编辑的行！");  
        return; 
	}
	var tabTop = "<c:url value='/json/familyPersonList.json'/>";
	var rowurl = "<c:url value='/message/familyPersonList.m?familyMessage.id='/>"+fid;
	var posturl = "<c:url value='/message/savePerson.m?familyMessage.id='/>"+fid;
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
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,pid,"",formartColumns);//使用的是公共方法
		$('#win').window('open');
	},"json");
}
//新建户
function addFamily(){
	var cid = $("#cid").val();
	$("#newcid").val(cid);
	window.open("<c:url value='/jsp/management/familyInfor.jsp?act=inserted&cid='/>"+cid,
			"newwindow",
			"height=700,width=1350,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, "
			+"resizable=no,location=no, status=no, z-look=yes");
	/*$("#addFamily").window('open');*/
}
function saveFamily(){
	$("#newFamily").form("submit", {
        url: "<c:url value='/message/saveNewFamliyMessage.m'/>",
        onSubmit: function () {
            return $(this).form("validate");
        },
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#addFamily").window("close");
                $("#familylistdg").datagrid("load");
                $("#newFamily").form("clear");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
/* 家庭信息 */
function familyInfor(){
	var fid = undefined;
	var checkedrows = customDatagrid.datagrid("getChecked");
	if(checkedrows.length>0){
		fid = checkedrows[0].id;
	}
	if(fid==undefined){
		$.messager.alert("提示信息", "请选择要编辑的行！");
		return;
	}
	window.open("<c:url value='/message/getFamliyMessage.m?act=updated&familyMessage.id='/>"+fid,
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
    		<a href="javascript:addFamily()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" id="add">新建户</a>
	        <a href="javascript:getFamilyPersonList()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑家庭成员</a>
	        <a href="javascript:familyInfor()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑家庭信息</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	        <span>户主姓名:</span><input type="text" id="hzxm" value="" size=10 />  
	        <a href="javascript:FindData()" class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="familyFind">查询</a>
	    <div>
	    <!-- 右键菜单 -->
	    <div id="mm" class="easyui-menu" style="width:120px;">
			<div onclick="getFamilyPersonList()" data-options="iconCls:'icon-edit'">家庭成员</div>
			<div onclick="familyInfor()" data-options="iconCls:'icon-edit'">家庭信息</div>
			<div onclick="delFamilyAllMessage()" data-options="iconCls:'icon-remove'">删除</div>
		</div>
    </div>
    <!-- family详情弹出框 -->
    <div id="win" class="easyui-window" title="My Window" style="width:600px;height:400px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <table id="dg" width="1200px" border="1" style="font-size: 14px;"></table>
	    </div>  
	</div>
	<!-- 添加户弹出框 -->
	<div id="addFamily" class="easyui-window" title="新建户" style="width:600px;height:300px"  
        data-options="iconCls:'icon-save',modal:true">  
	    <div class="easyui-layout" data-options="fit:true">  
		    <div data-options="region:'center'">  
				<form method="post" id="newFamily">
					<table border="1" align="center">
						<tr>
							<th colspan="4" width="60px">户信息
								<input type="hidden" name="familyMessage.cid" id="newcid">
							</th>
						</tr>
						<tr>
							<th>户主姓名</th>
							<td><input type="text" name="familyMessage.hzxm" class="easyui-validatebox"  data-options="required:true,validType:'name'"/></td>
							<th>户籍地</th>
							<td><input type="text" name="familyMessage.hjd" class="easyui-validatebox"  data-options="required:true"/></td>
						</tr>
						<tr>
							<th>现居地址</th>
							<td><input type="text" name="familyMessage.xjdz" class="easyui-validatebox"  data-options="required:true"/></td>
							<th>自来水是否入户</th>
							<td>是<input name="familyMessage.zls" type="radio" value="0">&nbsp;&nbsp;
								否<input name="familyMessage.zls" type="radio" value="1"></td>
						</tr>
						<tr>
							<th>家庭获得荣誉情况</th>
							<td><input type="text" name="familyMessage.jtry" class="easyui-validatebox"  data-options="required:true"/></td>
							<th>违法违纪情况</th>
							<td><input type="text" name="familyMessage.wfwj" class="easyui-validatebox"  data-options="required:true"/></td>
						</tr>
						<tr>
							<th>安全生产情况</th>
							<td>
								是否存在安全隐患<br>
								是<input name="familyMessage.aqsc" type="radio" value="0">&nbsp;&nbsp;
								否<input name="familyMessage.aqsc" type="radio" value="1">
							</td>
							<th>安全隐患类别</th>
							<td><input type="text" name="familyMessage.aqyh" class="easyui-validatebox"  data-options="required:true"/></td>
						</tr>
					</table>
				</form>
			</div>  
		    <div data-options="region:'south',split:true" style="height:32px;text-align: center">
		    	<a href="javascript:saveFamily()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
		    </div>  
	    </div>  
	</div>
</body>
</html>