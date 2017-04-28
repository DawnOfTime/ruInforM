<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="/js/acc.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var tabTop = "<c:url value='/json/acc.json'/>";
		var rowurl = "<c:url value='/seachacc.m'/>";
		var posturl = "<c:url value='/saveAcc.m'/>";
		var newRow = "{\"id\":\"\",\"username\":\"\",\"acccode\":\"\",\"password\":\"\",\"isable\":\"\",\"rid\":\"\"}";
		var hidcolumns = "id,password";//隐藏列字段名
		var id = "id";//主键字段名
		var isable = [
					   	{valueField:'1',textField:'是'},
						{valueField:'0',textField:'否'}
				 	];
		//默认窗口为空
		$("#win").window({
			 closed: true,
			 onClose: function(){
				 $("#dg").datagrid("reload");
			 }
		});
		$.post("<c:url value='/getRule.m'/>",function(data){
			for (var i = 0; i < data.length; i++) {
				$("#ruleList").append("<option value='"+data[i].id+"'>"+data[i].rname+"</option>");
			}
			var rid = data;
			var formartColumns=[{
							 		 field: 'isable',
							 		 formatter:function(value, row, index){
							 			 var showTxt="";
							 			 $(isable).each(function(){
							 				 if(value==this.valueField){
							 					 showTxt=this.textField;
							 				 }
							 			 });
							 			 return showTxt;
							 		 },
							 		 editor: {  
							         	type: 'combobox',  
							 		    options: {  
							 		          data: isable,  
							 		          valueField: 'valueField',  
							 		          textField: 'textField',  
							 		          panelHeight: 'auto'  
							 		    }  
							         }  
							 	},{
							 		 field: 'rid',
							 		 formatter:function(value, row, index){
							 			 var showTxt="";
							 			 $(rid).each(function(){
							 				 if(value==this.id){
							 					 showTxt=this.rname;
							 				 }
							 			 });
							 			 return showTxt;
							 		 },
							 		 editor: {  
							         	type: 'combobox',  
							 		    options: {  
							 		          data: rid,  
							 		          valueField: 'id',  
							 		          textField: 'rname',  
							 		          panelHeight: 'auto'  
							 		    }  
							         }  
							 	}]
			
			
			pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id,"",formartColumns);
		},'json');
	});
function saveAcc(){
	$("#addAcc").form("submit", {
        url: "<c:url value='/addAcc.m'/>",
        onSubmit: function () {
        	if(!$(this).form("validate")){
        		$.messager.alert("提示信息", "部分数据验证未通过");
        	}
            return $(this).form("validate");
        },
        success: function (result) {
            if (result == "ok") {
                $.messager.alert("提示信息", "操作成功");
                $("#win").window("close");
                $("#addAcc").form("clear");
                $.post("<c:url value='/getRule.m'/>",function(data){
                	$("#ruleList").html("<option value=''>-请选择-</option>");
        			for (var i = 0; i < data.length; i++) {
        				$("#ruleList").append("<option value='"+data[i].id+"'>"+data[i].rname+"</option>");
        			}
                },"json");
                $("#isable").html("<option value=''>-请选择-</option>"
			                		+"<option value='1'>是</option>"
			                		+"<option value='0'>否</option>");
            }
            else {
                $.messager.alert("提示信息", "操作失败");
            }
        }
    });
}
</script>
</head>
<body>
	<table id="dg"></table>
	<div id="win" class="easyui-window" title="新建账号" style="width:300px;height:250px;top:50px"  
        data-options="iconCls:'icon-save',modal:true">
        <div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	        <div data-options="region:'center'" style="width:100%;">
		        <form method="post" id="addAcc">
			    	<table align="center">
			    		<tr>
			    			<th>用户名</th>
			    			<td><input type="text" name="acc.username" class="easyui-validatebox" data-options="required:true"/></td>
			    		</tr>
			    		<tr>
			    			<th>账号</th>
			    			<td><input type="text" name="acc.acccode" class="easyui-validatebox" data-options="required:true"/></td>
			    		</tr>
			    		<tr>
			    			<th>密码</th>
			    			<td><input type="password" name="acc.password" class="easyui-validatebox" data-options="required:true"/></td>
			    		</tr>
			    		<tr>
			    			<th>是否启用</th>
			    			<td>
			    				<select id="isable" name="acc.isable" class="easyui-validatebox" data-options="required:true">
			    					<option value="">-请选择-</option>
			    					<option value="1">是</option>
			    					<option value="0">否</option>
			    				</select>
			    			</td>
			    		</tr>
			    		<tr>
			    			<th>角色</th>
			    			<td>
			    				<select name="acc.rid" id="ruleList" class="easyui-validatebox" data-options="required:true">
			    					<option value="">-请选择-</option>
			    				</select>
			    			</td>
			    		</tr>
			    	</table>
		        </form>
		    </div> 
	        <div data-options="region:'south'" style="height:40px;width:100%;text-align:center;padding-top:5px">
			    <a href="javascript:void(0)" onclick="saveAcc()" class="easyui-linkbutton" iconcls="icon-save">保存</a>
		    </div> 
        </div>
    </div>
</body>
</html>