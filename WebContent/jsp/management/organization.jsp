<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#win').window('close');
			$('#tree').tree({
				url : "<c:url value='/findTree.m'/>",
				  onContextMenu : function(e, node) {
					  //alert(node.name);
					e.preventDefault();
					// 选择节点
					$('#tt').tree('select', node.target);
					if(node.level==5){
						$("#mm").children().eq(1).attr("style","display:none");
					}else{
						$("#mm").children().eq(1).attr("style","display:block");
					}
					// 显示上下文菜单
					$('#mm').menu('show', {
						left : e.pageX,
						top : e.pageY
					});  
				}
			});
		});

		 function append() {
		 	var node = $('#tree').tree('getSelected');
		 	$("#inputone").attr("value", node.num);
		 	$("#inputfour").attr("value",parseInt(node.level)+1);
			$('#win').window('open');

		} 

	 
		function saveuser() {
		var father = $("#inputone").val();
		var name = $("#inputthree").val();
			$("#ff").form('submit',{
				url:"<c:url value='/addcountry.m'/>",
				onSubmit: function(){
					var isValid = $(this).form('validate');
					if(!isValid){
						$.messager.progress('close');
					}
					return isValid;
				},
				success: function(){
					$.messager.progress('close');
					$.messager.alert('提示','已保存');
					$("#tree").tree("reload");
					
				}
			})
			$('#win').window('close'); 
			$("#inputtwo").val("");
			$("#inputthree").val("");
		}
		
		  function  removeNode(){

		         var node = $('#tree').tree('getSelected');

		         // alert(node.id); 
		         
		         $.messager.confirm('提示', '是否删除', function(r) {
		                 if (r) {
		                	 $.post("<c:url value='/deletecounty.m?country.id='/>"+node.id,function(data){
		     					$("#tree").tree("reload");
		                	 });
		                 }
		             });
		         } 	        
		     function update(){
		        var node = $('#tree').tree('getSelected');
		        editText(node);
		      
		    	 };
		   	 function editText(node){
		    	$("#inp1").attr('value',node.num);
		    	$("#inp3").attr('value',node.id);
		    	$('#win1').window('open');

		    	}
		     function editText1(){
		    	 $.post("<c:url value='/updatecounty.m?country.num="+$("#inp1").val()+"&country.name="+$("#inp2").val()+"&country.id="+$("#inp3").val()+"'/>",function(data){
		    		 cancle();
		          });
		    	 }
		     function cancle(){
		    	 $('#win1').window('close');
		    	 $("#tree").tree("reload");
		    	 $("#inp2").val("");
		    	 }		
	</script>
</head>
<body class="easyui-layout">
       	<div data-options="region:'west'" style="width:30%;">
		<ul id="tree">
		</ul>
		<div id="mm" class="easyui-menu" style="width: 120px;">
			<div onclick="append()" data-options="iconCls:'icon-add'" id="add">添加节点</div>
			<div onclick="update()" data-options="iconCls:'icon-remove'">修改节点</div>
			<div onclick="removeNode()" data-options="iconCls:'icon-remove'">删除节点</div>
		</div>

		<div id="win" class="easyui-window" title="添加" style="width: 450px; height: 200px" data-options="iconCls:'icon-save',modal:true">
			<div data-options="region:'center'">
				内容
				<div style="padding: 10px 60px 20px 60px">
					<form id="ff" method="post">
						<table cellpadding="5">
							 <tr style="display: none">
								<td>父编码:</td>
								<td><input class=" easyui-validatebox" type="text"
								id="inputone" name="country.father_num" data-options="required:true"></input>
								<input class=" easyui-validatebox" type="text" 
								id="inputfour" name="country.level" data-options="required:true"></input></td>
							</tr>
							<tr>
								<td>编码:</td>
								<td><input class=" easyui-validatebox" id="inputtwo" type="text" data-options="required:true" name="country.num"></input></td>
							</tr>
							<tr>
								<td>名称:</td>
								<td><input class=" easyui-validatebox" type="text"
									 name="country.name" data-options="required:true" id="inputthree"></input></td>
							</tr>
						</table>
					</form>
					<div style="text-align: center; padding: 5px">
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveuser()">保存</a> 
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clear()">取消</a>
					</div>
				</div>
			</div>
		</div>
		<div id="win1" closed="true" draggable="true" class="easyui-window" title="修改"  style="width:300px;height:180px;">  
	    <form style="padding:10px 20px 10px 40px;" >  
	        <p>编号: <input type="text" id = "inp1"></p>  
	        <p>名称: <input type="text" id="inp2"></p>  
	        <p style="display: none">id: <input type="text" id = "inp3"></p>
	        <div style="padding:5px;text-align:center;">  
	            <a href="javascript:void(0);" onclick="editText1()"class="easyui-linkbutton" icon="icon-ok">保存</a>  
	            <a href="javascript:void(0);" onclick="cancle()" class="easyui-linkbutton" icon="icon-cancel">关闭</a>  
	        </div>  
	    </form>  
	</div>  
	</div>
</body>
</html>