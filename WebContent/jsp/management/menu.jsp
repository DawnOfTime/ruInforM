<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var treegrid;
	var rowid = undefined;//当前编辑的行
	$(document).ready(function(){
		var tabTop = "<c:url value='/json/menu.json'/>";
		var url = "<c:url value='/menu/findMenuTree.m'/>";
		var hidcolumns = 'id,num,father_num,level';
		$.getJSON(tabTop, function(data){
			treegrid = $('#dg').treegrid({   
			    url:url,   
			    idField:'id',   
			    treeField:'name', 
			    columns:[data],
			    fit:true,//表头置顶
			    width: 'auto', 
		        height: 'auto',
			    rownumbers:true,
			    singleSelect:true,
			    onContextMenu:function(e, row){
					e.preventDefault();//不显示浏览器的右键菜单
					$('#dg').treegrid("select",row.id);//选中当前右击的节点
					var gen = $('#dg').treegrid('getRoot').id;//获取根节点的id属性
					var node = $('#dg').treegrid('getSelected').id;//获取当前所选择节点的id属性
					if(treegrid.treegrid("getLevel",node)==2){/*根据所选节点的id获取该节点的层级*/
						$("#mm").children().eq(1).attr("style","display:none");
						$("#mm").children().eq(4).attr("style","display:none");
						//$("#mm").children().eq(5).attr("style","display:none");
					}else if(treegrid.treegrid("getLevel",node)==1){
						$("#mm").children().eq(1).attr("style","display:block");
						$("#mm").children().eq(4).attr("style","display:block");
						//$("#mm").children().eq(5).attr("style","display:block");
					}
			 		// 显示上下文菜单
			 		$('#mm').menu('show', {
			 			left: e.pageX,
			 			top: e.pageY
			 		});
			    },
			    onClickRow:function(row){
		            if (rowid != undefined) {
		            	treegrid.treegrid('endEdit', rowid);
		            }
		        },
		        onDblClickRow:function(row){
		        	if(treegrid.treegrid("getLevel",row.id)==1){
		        		var edi = treegrid.treegrid("getEditors",row.id);
		        	}
			        rowid = row.id;
			        treegrid.treegrid('beginEdit', row.id);
		        },onAfterEdit:function(row,changes){
		        	save(row,changes);
		        }
			});
			if(hidcolumns!=""){
				var columns=new Array()
				columns=hidcolumns.split(",");
				for(var i=0;i<columns.length;i++){
					treegrid.treegrid("hideColumn",columns[i]);//隐藏指定的列
				}
			}
		});
	});
	/*添加子节点*/
	function appenderji(){
		var node = treegrid.treegrid('getSelected');
		var data = treegrid.treegrid('getData');
		var childleng;
		for (var i = 0; i < data.length; i++) {
			if(node.id == data[i].id){
				childleng = data[i].num+"0"+(data[i].children.length+1);
			}
		}
		treegrid.treegrid('append',{
			parent: node.id,
			data: [{
				id: '',
				num: childleng,
				name: '',
				father_num: node.num,
				level: 2,
				menuurl: ''
			}]
		});
		var insertedobj = new Object();
		insertedobj["inserted"] = JSON.stringify({num:childleng,name:"",father_num:node.num,level:"2",menuurl:""});
		$.post("<c:url value='/menu/insertMenu.m'/>",insertedobj,function(data){
			if(data=="ok"){
				$.messager.alert('提示','操作成功');
			}else{
				if(""!=data){
					$.messager.alert('提示','操作失败');
				}
			}
			treegrid.treegrid("reload");
		});
	}
	/*删除当前节点*/
	function removenode(){
		$.messager.confirm('警告！', '删除当前节点,确定继续?',function(r){
			if(r){
				var node = treegrid.treegrid('getSelected').id;
				treegrid.treegrid('remove', node);
				var delobj = new Object();
				delobj.id=node;
				delobj.num='';
				delobj.name='';
				delobj.father_num='';
				delobj.level='';
				delobj.menuurl='';
				var deletedobj = new Object();
				deletedobj["deleted"] = JSON.stringify(delobj);
				$.post("<c:url value='/menu/deleteMenu.m'/>",deletedobj,function(data){
					if(data=="ok"){
						$.messager.alert('提示','操作成功');
					}else{
						if(""!=data){
							$.messager.alert('提示','操作失败');
						}
					}
					treegrid.treegrid("reload");
				});
			}
		});
	}
	/*修改当前节点*/
	function updatenode(){
		var node = treegrid.treegrid('getSelected').id;
		rowid = node;
		treegrid.treegrid('beginEdit', node);
	}
	/*刷新*/
	function refulsh(){
		treegrid.treegrid('reload');
	}
	/*保存修改*/
	function save(row,changes){
		var posturl = "<c:url value='/menu/save.m'/>";
		var updated = treegrid.treegrid('getChanges', "updated");
		var effectRow = new Object();
		if (updated.length) {
			effectRow["updated"] = JSON.stringify(updated[updated.length-1]);
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
				treegrid.treegrid("reload");
			});
		}
	} 
</script>
</head>
<body>
		<table id="dg" class="easyui-treegrid"></table>
		<div id="mm" class="easyui-menu" style="width:120px;">
			<div onclick="appenderji()" data-options="iconCls:'icon-add'">添加子节点</div>
			<div onclick="removenode()" data-options="iconCls:'icon-remove'">删除当前节点</div>
			<div onclick="updatenode()" data-options="iconCls:'icon-edit'">修改当前节点</div>
			<div onclick="refulsh()" data-options="iconCls:'icon-reload'">刷新</div>
		</div>
</body>
</html>