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
	$("#win").window({
		closed: true
	}); 
	$("#historywin").window({
		closed: true,
		maximized: true
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


function findFlowPerson(){
	var cid = $("#cid").val();
	var tabTop = "<c:url value='/json/land_industry.json'/>";
	var rowurl = "<c:url value='/land_industry/queryland_industry.m?land_industry.cid='/>"+cid;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	var frozenColumns = [[{}]];
	//锁定列
	$.getJSON(tabTop, function(data){
		/* if(undefined!=frozenColumns){
			frozenColumns = frozenColumns;
		}else{
			frozenColumns = [{field:'ck',checkbox:true}];
		} */
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
	function saveaddCommunication(){
	var cid = $("#cid").val();
	$("#addFlowPerson").form("submit", {
	    url: "<c:url value='/land_industry/addland_industry.m?land_industry.cid='/>"+cid,
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
	function saveUpdatedland_industry(){
	datagrid.datagrid('endEdit', editRow);
	var posturl = "<c:url value='/land_industry/saveland_industry.m'/>";
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
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要变更的行！", "info");  
		return;
	}else{
		var rowid = row[0].id;
		$.post("<c:url value='/land_industry/searchLand_industry.m?land_industry.id='/>"+rowid,function(data){
			var namestr = ['ztdmj','zzmj','xzmj','ghsymj','ldmj','cdmj','zcydmj','tdlcmj','zzy','yzy','qtcy','xdny','jnjl','jsd','jjgqy','jxclg','gnjl','gsd','gjgqy','gxclg'];
			for (var i = 0; i < namestr.length; i++) {
				$("input[name='land_industry."+namestr[i]+"']").val(data[namestr[i]]);
			}
			$("#win").window('open');
		},"json");
	}
}
//历史记录
var langdatagrid;
var langeditRow = undefined;
function searchHistory(){
	var id = '';
	var row = datagrid.datagrid('getChecked');
	if(row.length<1){
		$.messager.alert("提示", "请选择要查看的行！", "info");  
		return;
	}else if(row.length>1){
		$.messager.alert("提示", "请选择单个要查看的行！", "info");  
		return;
	}else{
		id=row[0].id;
	}
	var tabTop = "<c:url value='/json/land_industry.json'/>";
	var rowurl = "<c:url value='/land_industry/searchHistory.m?land_industry.id='/>"+id;
	var hidcolumns = "id,cid";//隐藏列字段名
	var id = "id";//主键字段名
	//锁定列
	$.getJSON(tabTop, function(data){
		langdatagrid = $('#history').datagrid({ 
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
	        	langeditRow = undefined;
	        },onBeforeLoad:function(){			//在请求载入数据之前触发
	        	if (langeditRow != undefined) {
	        		langdatagrid.datagrid('endEdit', langeditRow);
	            }
	        },onDblClickRow:function (rowIndex, rowData) {
	        	/* if (langeditRow != undefined) {
	        		langdatagrid.datagrid('endEdit', langeditRow);
	            }
	            if (langeditRow == undefined) {
	            	langeditRow=rowIndex;
	            	langdatagrid.datagrid('beginEdit', rowIndex);
	            	if(rowData.id!=""){
	            		var cellEdit = langdatagrid.datagrid('getEditor', {index:rowIndex,field:'username'});
						var $input = cellEdit.target; // 得到文本框对象
						$input.attr('readonly',true); // 设值只读
	            	}
	                
	            } */
	        },onClickRow:function(rowIndex,rowData){
	            if (langeditRow != undefined) {
	            	var vv = langdatagrid.datagrid('endEdit',langeditRow);
	            	if(!vv){
	            		$.messager.alert('警告','有数据未通过验证!','warning');
	            		return;
	            	}
	            	langdatagrid.datagrid('endEdit', langeditRow);
	            }
	        },onSelect:function(rowIndex, rowData){
	        	langdatagrid.datagrid('endEdit', langeditRow);
	        	langdatagrid.datagrid('unselectRow',rowIndex);//不选中行
	        },
	        onCheckAll:function(rows){
	        	langdatagrid.datagrid('unselectAll');
	        }
	    }); 
		if(hidcolumns!=""){
			var columns=new Array()
			columns=hidcolumns.split(",");
			for(var i=0;i<columns.length;i++){
				langdatagrid.datagrid("hideColumn",columns[i]);//隐藏指定的列
			}
		}
	    //设置分页控件 
	    var p = $('#history').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	    }); 
	});
	$("#historywin").window('open');
}
</script>
<style type="text/css">
	#tables tr{
		height: 35px;
	}
	.baocun{
		text-align: center;
	}
</style>
</head>
<body class="easyui-layout">
 <div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
 </div>
 <div data-options="region:'center',title:'土地产业信息          （注：只能操作村级信息）'" style="padding:5px;background:#eee;">
    	<table id="dg" toolbar="#searchtool"></table>
    	<!-- 表头 -->
    	<div id="searchtool" style="padding:5px;display:none;">
    		<a href="javascript:addFlowPerson()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    		<a href="javascript:updateVillageWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
    		<a href="javascript:savebg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">变更</a>
    		<a href="javascript:saveUpdatedland_industry()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    		<a href="javascript:searchHistory()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">历史记录查询</a>
    		<input type="hidden" id="cid"><!-- 村id -->
	    </div>
 </div>
 <div id="win" class="easyui-window" title="土地产业添加" style="width:600px;height:400px;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">  
		    <form method="post" id="addFlowPerson">
		    	<input type="hidden" id="form_cid" name="country_flow.cid">
		    	<table id="tables">
		    		<tr>
		    			<td>总土地面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.ztdmj" data-options="required:true,validType:'ztdmj'"/>
		    			</td>
		    			<td>种植面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.zzmj" data-options="required:true,validType:'zzmj'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>闲置面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.xzmj" data-options="required:true,validType:'xzmj'"/>
		    			</td>
		    			<td>规划使用面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.ghsymj" data-options="required:true,validType:'ghsymj'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>林地面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.ldmj" data-options="required:true,validType:'ldmj'"/>
		    			</td>
		    			<td>草地面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.cdmj" data-options="required:true,validType:'cdmj'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>住宅用地面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.zcydmj" data-options="required:true,validType:'zcydmj'"/>
		    			</td>
		    			<td>土地流转面积(亩):</td>
		    			<td>
		    				<input type="text" name="land_industry.tdlcmj" data-options="required:true,validType:'tdlcmj'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>种植业:</td>
		    			<td>
		    				<input type="text" name="land_industry.zzy" data-options="required:true,validType:'zzy'"/>
		    			</td>
		    			<td>养殖业:</td>
		    			<td>
		    				<input type="text" name="land_industry.yzy" data-options="required:true,validType:'yzy'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>其他产业:</td>
		    			<td>
		    				<input type="text" name="land_industry.qtcy" data-options="required:true,validType:'qtcy'"/>
		    			</td>
		    			<td>现代农业:</td>
		    			<td>
		    				<input type="text" name="land_industry.xdny" data-options="required:true,validType:'xdny'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>集体农家乐:</td>
		    			<td>
		    				<input type="text" name="land_industry.jnjl" data-options="required:true,validType:'jnjl'"/>
		    			</td>
		    			<td>集体商店:</td>
		    			<td>
		    				<input type="text" name="land_industry.jsd" data-options="required:true,validType:'jsd'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>集体加工企业:</td>
		    			<td>
		    				<input type="text" name="land_industry.jjgqy" data-options="required:true,validType:'jjgqy'"/>
		    			</td>
		    			<td>集体乡村旅店:</td>
		    			<td>
		    				<input type="text" name="land_industry.jxclg" data-options="required:true,validType:'jxclg'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>个体农家乐:</td>
		    			<td>
		    				<input type="text" name="land_industry.gnjl" data-options="required:true,validType:'gnjl'"/>
		    			</td>
		    			<td>个体商店:</td>
		    			<td>
		    				<input type="text" name="land_industry.gsd" data-options="required:true,validType:'gsd'"/>
		    			</td>
		    		</tr>
		    		<tr class="juzhong">
		    			<td>个体加工企业:</td>
		    			<td>
		    				<input type="text" name="land_industry.gjgqy" data-options="required:true,validType:'gjgqy'"/>
		    			</td>
		    			<td>个体乡村旅店:</td>
		    			<td>
		    				<input type="text" name="land_industry.gxclg" data-options="required:true,validType:'gxclg'"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="4" class="baocun"><a href="javascript:saveaddCommunication()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
		    		</tr>
		    	</table>
		    </form>
	    </div>  
	</div> 
	<div id="historywin" class="easyui-window" title="历史记录" style="width:600px;height:450px;display:none;display:none;"  
         data-options="iconCls:'icon-save',modal:true">  
	   <div class="easyui-layout" data-options="fit:true">
	   		<table id='history'></table>
	   </div>
	</div>
</body>
</html>  