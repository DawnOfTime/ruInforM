var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行

	function isNullFun(value, row, index){
		return '<a class="shenghe" href="#" iconCls="icon-cut"></a>';
    }

/**
 * 根据参数来确定进入哪个方式,并不是每个表格都要操作列
*/

function release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id){
	release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,[{}],[[{}]],"","",false,false);
}

function release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol){
	release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,[[{}]],"","",false,false);
}

function release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns){
	release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns,"","",false,false);
}

function release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns,isshow){
	release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns,isshow,"",false,false);
};
/**
 * @param tabTop  表头列的json对象
 * @param rowurl  表数据获取的地址(Servlet)
 * @param posturl 表数据修改后提交的地址(增删改的数据提交地址)
 * @param rowtmp  新增一行时的行列名(例如:"{\"zid\":\"\",\"username\":\"\",\"password\":\"\",\"pid\":\"\"}")
 * @param hidcolumns 隐藏/不显示的列
 * @param id 当前表格的数据主键
 * @param formattercol 新增的操作列
 * @param formartColumns 数据列的操作格式(下拉...)
 */
function release(tabTop,rowurl,posturl,rowtmp,hidcolumns,id,formattercol,formartColumns,isshow,frozenColumns,disableadd,disabledel){
		
		$.getJSON(tabTop, function(data){
			if(undefined!=frozenColumns){
				frozenColumns = frozenColumns;
			}else{
				frozenColumns = [{field:'ck',checkbox:true}];
			}
			//表格中添加按钮
			$(formattercol).each(function(){
				data[data.length]=this;
			});
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
		        /*title:'应用系统列表', */
		        //iconCls:'icon-edit',//图标 
		        columns:[data],
		        width: 700, 
		        height: 'auto', 
		        nowrap: false, 
		        striped: true, 
		        border: true, 
		        boolean:true,
		        nowrap:true,
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
		        toolbar: [{ 
		            text: '修改', 
		            iconCls: 'icon-cut',
		            handler: function() {
		            	updatetmp(id);
		            	/*if("1"==isshow){
		            		
		            				            	}else{
		            		updatetmp();
		            	}*/
		            }
		        	}, '-',{ 
		            text: '删除', 
		            iconCls: 'icon-remove', 
		            disabled:disabledel,
		            handler: function(){
		            	deletedata(id);
		            }
		            }, '-', { 
		            text: '保存', 
		            iconCls: 'icon-save', 
		            handler: function() {
		            	saveDataGrid(posturl);
		            }
		        }],
		        onAfterEdit: function (rowIndex, rowData, changes) {
		        	//保存
	            	//saveDataGrid(posturl);
		            editRow = undefined;
		        },onBeforeLoad:function(){			//在请求载入数据之前触发
		        	if (editRow != undefined) {
		            	datagrid.datagrid('endEdit', editRow);
		            }
		        },
		        onDblClickRow:function (rowIndex, rowData) {
		            /*if (editRow != undefined) {
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
		            }*/
		        },onClickRow:function(rowIndex,rowData){
		            if (editRow != undefined) {
		            	var vv = datagrid.datagrid('validateRow',editRow);
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
			$("a.shenghe").linkbutton({
				iconCls:'icon-search'
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
		        /*onBeforeRefresh:function(){
		            $(this).pagination('loading');
		            alert('before refresh');
		            $(this).pagination('loaded');
		        }*/ 
		    });
	});
}
/*function addtmp(rowtmp){
	if (editRow != undefined) {
		datagrid.datagrid('endEdit', editRow);
    }
	var newRow=JSON.parse(rowtmp);
	editRow=datagrid.datagrid('appendRow',newRow).datagrid('getRows').length-1;
	datagrid.datagrid('beginEdit', editRow);
	//alert(datagrid.validateRow(0));
}*/

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
			var delIndex=datagrid.datagrid("getRowIndex",this[id]); 
			var obj= new Object;
			obj.name=this[id];
			obj.state=this["state"];
			if(obj.state==3||obj.state==4){
				var someValue=window.showModalDialog("../../umed/updatew.html",obj,"dialogWidth=1090px;dialogHeight=500px;dialogLeft=270px;dialogTop=220px;status=no;help=no;scrollbars=no;");
	            window.location.reload();
			}else{
				$.messager.alert("提示", "无权操作！", "info");
			}
		});
		
	}
}
function deletedata(id) {
	var count=0;
	var rows=datagrid.datagrid("getChecked");
	if(rows.length!=0){
	$(rows).each(function(){
	//var delIndex=datagrid.datagrid("getRowIndex",this[id]); 
	var obj= new Object;
	obj.state=this["state"];
	 
	if(obj.state==4){
       
			var delIndex=datagrid.datagrid("getRowIndex",this[id]);  
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
		if(obj.state==1||obj.state==2||obj.state==3){
			alert(count);
			count++;
		}
	});
	if(count!=0){
		$.messager.alert("提示", "有"+count+"条数据无权操作！", "info"); 
	}
}
function saveDataGrid(posturl){
	//alert("保存");
	var vv = datagrid.datagrid('validateRow',editRow);
	if(!vv){
		$.messager.alert('警告','有数据未通过验证!','warning');
		return;
	}
	if (editRow != undefined) {
    	datagrid.datagrid('endEdit', editRow);
    }

	var inserted = datagrid.datagrid('getChanges', "inserted");
	var deleted = datagrid.datagrid('getChanges', "deleted");
	var updated = datagrid.datagrid('getChanges', "updated");
	
	//验证数据
	
	var effectRow = new Object();
	
	if(updated.length){
		for (var i = 0; i < updated.length; i++) {
			var updateid = updated[i].id;
			for (var j = 0; j < deleted.length; j++) {
				if(deleted[j].id == updateid){
					updated.splice(i,1);
				};
			}
		}
	}
	if (inserted.length) {
	 	effectRow["inserted"] = JSON.stringify(inserted);
	}
	if (deleted.length) {
		effectRow["deleted"] = JSON.stringify(deleted);
	}
	if (updated.length) {
		effectRow["updated"] = JSON.stringify(updated);
	}
//	alert(JSON.stringify(effectRow));
	if("{}"!=JSON.stringify(effectRow)){
		$.post(posturl,effectRow,function(data){
			if(data=="ok"){
				//$.messager.alert('提示','操作成功');
			}else{
				if(""!=data){
				//$.messager.alert('提示','操作失败');
				}
			}
			datagrid.datagrid("load"); 
		});
	}
} 
