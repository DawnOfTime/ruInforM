<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="/js/updatepws.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#win').window('close');
		$('#win').window({
			closed: true,
			onClose: function(){
				top.location.href="<c:url value='/login/exit.m'/>";
			}
		});
		var tabTop = "<c:url value='/json/update.json'/>";
		var rowurl = "<c:url value='/pws/seachpws.m'/>";
		var posturl = "<c:url value='/pws/savepws.m'/>";
		var newRow = "{\"id\":\"\",\"username\":\"\",\"acccode\":\"\",\"password\":\"\"}";
		var hidcolumns = "id,password";//隐藏列字段名
		var id = "id";//主键字段名
		var isable = [
					   	{valueField:'1',textField:'是'},
						{valueField:'0',textField:'否'}
				 	];
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
						 	}]
		pagecomm(tabTop,rowurl,posturl,newRow,hidcolumns,id,"",formartColumns);
	});
	//保存新密码
	function savePassword(){
		var oldpwd = $("#oldPassword").val();
		var newpwd = $("#newPassword").val();
		if(oldpwd=='' || newpwd==''){
			$.messager.alert('警告','请填写完整!','warning');
		}else{
			if(oldpwd==newpwd){
				$.messager.alert('警告','新密码不能与旧密码相同!','warning');
				return;
			}else{
				$.post("<c:url value='/pws/ispwd.m?acc.password='/>"+oldpwd,function(data){
					if(data != "ok"){
						$.messager.alert('警告','旧密码输入错误!','warning');
						return;
					}else{
						$.post("<c:url value='/pws/savepwd.m?acc.password='/>"+newpwd,function(data){
							$('#win').window("close");
							$('#dg').datagrid("load");
						});
					}
				},"text");
			}
		}
	}
</script>
<style type="text/css">
	#pwd tr{
		height: 30px;
	}
</style>
</head>
<body>
	<table id="dg"></table>
	<div id="win" class="easyui-window" title="修改密码" style="width:300px;height:200px;top: 100px"  
         data-options="iconCls:'icon-save',modal:true">
         <table id="pwd" align="center">
         	<tr>
         		<td>
         			旧密码：</span><input type="text" id="oldPassword"/>
         		</td>
         	</tr>
         	<tr>
         		<td>
         			新密码：</span><input type="text" id="newPassword"/>
         		</td>
         	</tr>
         	<tr>
         		<td align="center">
         			<a href="javascript:savePassword()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
         		</td>
         	</tr>
         </table>
    </div>
</body>
</html>