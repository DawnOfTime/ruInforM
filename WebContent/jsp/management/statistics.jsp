<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var cid = undefined;
var cnum = undefined;
var cname = undefined;
var clevel = undefined;
$(document).ready(function(){
	$('#tt').tree({        
	     url:"<c:url value='/message/showCountryTree.m'/>",
	     onClick: function(node){
	    	 cid = node.id;
	    	 cnum = node.num;
	    	 cname = node.text;
	    	 clevel = node.level;
	    	 if($('#tt').tree("find",node.id).level==5){
	    		 $("#cid").val(node.id);
		    	 $("#cname").val(node.text);
	    		 $("#pie").css("display","none");
	    		 $("#searchtool").css("display","block");
	    	 }else if($('#tt').tree("find",node.id).level>0){
		    	 $("#cid").val(node.id);
		    	 $("#cname").val(node.text);
	    		 $("#searchtool").css("display","none");
	    		 $("#pie").css("display","block");
	    	 }
		 }
	 });
	$('#win').window({
		closed:true
	});
	$('#piewin').window({
		closed:true
	});
});
function countryRoad(){
	$.post("<c:url value='/statistics/getCountrybuilding.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var yl = new Array();
		var sn = new Array();
		var sl = new Array();
		var tl = new Array();
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			yl[i] = data[i].ylyh;
			sn[i] = data[i].snyh;
			sl[i] = data[i].slsyh;
			tl[i] = data[i].cl;
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['油路硬化(公里)','水泥硬化(公里)','砂砾石硬化(公里)','土路(公里)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:yl
				        },
				        {
				            name:legend[1],
				            type:'bar',
				            data:sn
				        },
				        {
				            name:legend[2],
				            type:'bar',
				            data:sl
				        },
				        {
				            name:legend[3],
				            type:'bar',
				            data:tl
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
function countryBuilding(){
	$.post("<c:url value='/statistics/getCountrybuilding.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var ql = new Array();
		var qsb = new Array();
		var ydb = new Array();
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			ql[i] = data[i].ql;
			qsb[i] = data[i].qsb;
			ydb[i] = data[i].ynb;
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['桥梁(座)','清水坝(座)','淤地坝(座)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:ql
				        },
				        {
				            name:legend[1],
				            type:'bar',
				            data:qsb
				        },
				        {
				            name:legend[2],
				            type:'bar',
				            data:ydb
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
function countryPoverty(){
	$.post("<c:url value='/statistics/getCountryPoverty.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var pk_number = new Array();
		var jcrzbqhs = new Array();
		var ytczbqhs = new Array();
		var xjcabqhs = new Array();
		var kqyazbqhs = new Array();
		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			pk_number[i] = data[i].pk_number;
			jcrzbqhs[i] = data[i].jcrzbqhs;
			ytczbqhs[i] = data[i].ytczbqhs;
			xjcabqhs[i] = data[i].xjcabqhs;
			kqyazbqhs[i] = data[i].kqyazbqhs;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['贫困户(户)','进城入镇搬迁(户)','依托村庄搬迁(户)','新建村庄搬迁户数(户)','跨区域安置搬迁户数(户)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:pk_number
				        },
				        {
				            name:legend[1],
				            type:'bar',
				            data:jcrzbqhs
				        },
				        {
				            name:legend[2],
				            type:'bar',
				            data:ytczbqhs
				        },
				        {
				            name:legend[3],
				            type:'bar',
				            data:xjcabqhs
				        },
				        {
				            name:legend[4],
				            type:'bar',
				            data:kqyazbqhs
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
//集体资产
function groupAssets(){
	countryGroupFinance("1");
}
//集体收入
function groupIncome(){
	countryGroupFinance("2");
}
//集体负债
function groupExpend(){
	countryGroupFinance("3");
}
//集体收支
function countryGroupFinance(type){
	$.post("<c:url value='/statistics/getCountryGroupFinance.m?cid='/>"+cid+"&type="+type,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var privce = new Array();
		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			privce[i] = data[i].privce;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['金额'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:privce
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
//土地
function countryLand(){
	$.post("<c:url value='/statistics/getCountryLand_industry.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var ztdmj = new Array();//总土地面积
		var zzmj = new Array();//种植面积
		var xzmj = new Array();//闲置面积
		var ghsymj = new Array();//规划使用面积
		var ldmj = new Array();//林地面积
		var cdmj = new Array();//草地面积
		var zcydmj = new Array();//住宅用地面积
		var tdlcmj = new Array();//土地流转面积
		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			ztdmj[i] = data[i].ztdmj;
			zzmj[i] = data[i].zzmj;
			xzmj[i] = data[i].xzmj;
			ghsymj[i] = data[i].ghsymj;
			ldmj[i] = data[i].ldmj;
			cdmj[i] = data[i].cdmj;
			zcydmj[i] = data[i].zcydmj;
			tdlcmj[i] = data[i].tdlcmj;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['总土地面积(亩)','种植面积(亩)','闲置面积(亩)','规划使用面积(亩)','林地面积(亩)','草地面积(亩)','住宅用地面积(亩)','土地流转面积(亩)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:ztdmj
				        },{
				            name:legend[1],
				            type:'bar',
				            stack: 'land',
				            data:zzmj
				        },{
				            name:legend[2],
				            type:'bar',
				            stack: 'land',
				            data:xzmj
				        },{
				            name:legend[3],
				            type:'bar',
				            stack: 'land',
				            data:ghsymj
				        },{
				            name:legend[4],
				            type:'bar',
				            stack: 'land',
				            data:ldmj
				        },{
				            name:legend[5],
				            type:'bar',
				            stack: 'land',
				            data:cdmj
				        },{
				            name:legend[6],
				            type:'bar',
				            stack: 'land',
				            data:zcydmj
				        },{
				            name:legend[7],
				            type:'bar',
				            stack: 'land',
				            data:tdlcmj
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
//养殖业
function countryAquaculture(){
	$.post("<c:url value='/statistics/getCountryLand_industry.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var yzy = new Array();
		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			yzy[i] = data[i].yzy;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['养殖业(只/头)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:yzy
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
//集体服务业
function countryJService(){
	$.post("<c:url value='/statistics/getCountryLand_industry.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var jnjl = new Array();//集体农家乐(家)
		var jsd = new Array();//集体商店(家)
		var jjgqy = new Array();//集体加工企业(家)
		var jxclg = new Array();//集体乡村旅店(家)
		

		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			jnjl[i] = data[i].jnjl;
			jsd[i] = data[i].jsd;
			jjgqy[i] = data[i].jjgqy;
			jxclg[i] = data[i].jxclg;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['集体农家乐(家)','集体商店(家)','集体加工企业(家)','集体乡村旅店(家)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:jnjl
				        },{
				            name:legend[1],
				            type:'bar',
				            data:jsd
				        },{
				            name:legend[2],
				            type:'bar',
				            data:jjgqy
				        },{
				            name:legend[3],
				            type:'bar',
				            data:jxclg
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
//个人服务业
function countryGService(){
	$.post("<c:url value='/statistics/getCountryLand_industry.m?cid='/>"+cid,function(data){
		if(data==''){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var gnjl = new Array();//个人农家乐(家)
		var gsd = new Array();//个人商店(家)
		var gjgqy = new Array();//个人加工企业(家)
		var gxclg = new Array();//个人乡村旅店(家)
		

		
		var xAxis = new Array();
		for (var i = 0; i < data.length; i++) {
			gnjl[i] = data[i].gnjl;
			gsd[i] = data[i].gsd;
			gjgqy[i] = data[i].gjgqy;
			gxclg[i] = data[i].gxclg;
			
			xAxis[i] = data[i].operate_time;
		}
		var legend = ['个人农家乐(家)','个人商店(家)','个人加工企业(家)','个人乡村旅店(家)'];
		var series = [
				        {
				            name:legend[0],
				            type:'bar',
				            data:gnjl
				        },{
				            name:legend[1],
				            type:'bar',
				            data:gsd
				        },{
				            name:legend[2],
				            type:'bar',
				            data:gjgqy
				        },{
				            name:legend[3],
				            type:'bar',
				            data:gxclg
				        }
				    ];
		generateChart(legend,xAxis,series);
	},"json");
}
/*
 * 
 * 生成柱状图
 * 
 * legend 项目
 * xAxis 横坐标值
 * series 数据
 * 
 */
function generateChart(legend,xAxis,series){
	// 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
	// 指定图表的配置项和数据
	var option = {
	    	    tooltip : {
	    	        trigger: 'axis',
	    	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	    	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	    	        }
	    	    },
	    	    legend: {
	    	        data:legend
	    	    },
	    	    grid: {
	    	        left: '3%',
	    	        right: '4%',
	    	        bottom: '3%',
	    	        containLabel: true
	    	    },
	    	    xAxis : [
	    	        {
	    	            type : 'category',
	    	            data : xAxis
	    	        }
	    	    ],
	    	    yAxis : [
	    	        {
	    	            type : 'value'
	    	        }
	    	    ],
	    	    series : series
	    	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
    $('#win').window('open');
}
/*
 * 
 * 生成饼状图
 * 
 * title	表名称
 * legend	类型
 * seriesname	类型名称
 * series	数据
 */
function pie_chart(title,legend,seriesname,series){
	// 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
	// 指定图表的配置项和数据
	var option = {
		    title : {
		        text: title,
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: legend
		    },
		    series : [
		        {
		            name: seriesname,
		            type: 'pie',
		            radius: '55%',
		            center: ['50%', '60%'],
		            data: series,
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
	$('#win').window('open');
}
//道路硬化【饼图】
function pie_countryRoad(){
	$.post("<c:url value='/statistics/pie_countryBuilding.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'道路硬化情况';
		var legend = ['油路硬化(公里)','水泥硬化(公里)','砂砾石硬化(公里)','土路(公里)'];
		var seriesname = '硬化类型';
		var series = [
						{value:data.ylyh, name:legend[0]},
						{value:data.snyh, name:legend[1]},
						{value:data.slsyh, name:legend[2]},
						{value:data.cl, name:legend[3]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");
}
//建筑物【饼图】
function pie_countryBuilding(){
	$.post("<c:url value='/statistics/pie_countryBuilding.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'桥梁水坝情况';
		var legend = ['桥梁(座)','清水坝(座)','淤地坝(座)'];
		var seriesname = '建筑';
		var series = [
						{value:data.ql, name:legend[0]},
						{value:data.qsb, name:legend[1]},
						{value:data.ynb, name:legend[2]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");
}
//贫困户分配【饼图】
function pie_countryPoverty(){
	$.post("<c:url value='/statistics/pie_countryPoverty.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'贫困户安置情况';
		var legend = ['进城入镇搬迁(户)','依托村庄搬迁(户)','新建村庄搬迁户数(户)','跨区域安置搬迁户数(户)'];
		var seriesname = '安置方式';
		var series = [
						{value:data.jcrzbqhs, name:legend[0]},
						{value:data.ytczbqhs, name:legend[1]},
						{value:data.xjcabqhs, name:legend[2]},
						{value:data.kqyazbqhs, name:legend[3]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");
}
//土地【饼图】
function pie_countryLand(){
	$.post("<c:url value='/statistics/pie_countryLand.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'土地使用情况';
		var legend = ['种植面积(亩)','闲置面积(亩)','规划使用面积(亩)','林地面积(亩)','草地面积(亩)','住宅用地面积(亩)','土地流转面积(亩)'];
		var seriesname = '使用类型';
		var series = [
						{value:data.zzmj, name:legend[0]},
						{value:data.xzmj, name:legend[1]},
						{value:data.ghsymj, name:legend[2]},
						{value:data.ldmj, name:legend[3]},
						{value:data.cdmj, name:legend[4]},
						{value:data.zcydmj, name:legend[5]},
						{value:data.tdlcmj, name:legend[6]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");
}
//集体服务业【饼图】
function pie_countryJService(){
	$.post("<c:url value='/statistics/pie_countryLand.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'集体服务业情况';
		var legend = ['集体农家乐(家)','集体商店(家)','集体加工企业(家)','集体乡村旅店(家)'];
		var seriesname = '产业类型';
		var series = [
						{value:data.jnjl, name:legend[0]},
						{value:data.jsd, name:legend[1]},
						{value:data.jjgqy, name:legend[2]},
						{value:data.jxclg, name:legend[3]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");
}
//个人服务业【饼图】
function pie_countryGService(){
	$.post("<c:url value='/statistics/pie_countryLand.m?country.num='/>"+cnum+"&country.level="+clevel,function(data){
		if(data==null){
			$.messager.alert("提示", "所选区域无数据！");
			return;
		}
		var title = cname+'个人服务业情况';
		var legend = ['个人农家乐(家)','个人商店(家)','个人加工企业(家)','个人乡村旅店(家)'];
		var seriesname = '产业类型';
		var series = [
						{value:data.gnjl, name:legend[0]},
						{value:data.gsd, name:legend[1]},
						{value:data.gjgqy, name:legend[2]},
						{value:data.gxclg, name:legend[3]}
				    ];
		pie_chart(title,legend,seriesname,series);
	},"json");	
}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织机构',split:true" style="width:220px;">
    	<ul id="tt"></ul>
    </div>  
    <div data-options="region:'center',title:'统计项目'" style="padding:5px;">
	        <input type="hidden" id="cid" disabled="disabled"/>
	        <input type="text" id="cname" disabled="disabled"/><br/><br/>
    	<div id="searchtool" style="padding:5px;display:none">
	    	<a href="javascript:countryRoad()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">道路硬化统计</a>
	        <a href="javascript:countryBuilding()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">建筑物统计</a>
	        <a href="javascript:countryPoverty()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">贫困户统计</a>
	        <a href="javascript:groupAssets()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">集体资产统计</a>
	        <a href="javascript:groupIncome()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">集体收入统计</a>
	        <br/><br/>
	        <a href="javascript:groupExpend()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">集体负债统计</a>
	        <a href="javascript:countryLand()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">土地统计</a>
	        <a href="javascript:countryAquaculture()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">养殖业统计</a>
	        <a href="javascript:countryJService()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">集体服务业统计</a>
	        <a href="javascript:countryGService()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">个人服务业统计</a>
	    </div>
	    <div id="pie" style="padding:5px;display:none">
	    	<a href="javascript:pie_countryRoad()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">道路硬化统计</a>
	        <a href="javascript:pie_countryBuilding()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">建筑物统计</a>
	        <a href="javascript:pie_countryPoverty()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">贫困户统计</a>
	        <br/><br/>
	        <a href="javascript:pie_countryLand()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">土地统计</a>
	        <a href="javascript:pie_countryJService()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">集体服务业统计</a>
	        <a href="javascript:pie_countryGService()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">个人服务业统计</a>
	    </div>
    </div>
    <div id="win" class="easyui-window" title="统计" style="width:650px;height:450px"  
         data-options="iconCls:'icon-search',modal:true">
         <div id="main" style="width: 600px;height:400px;"></div>
    </div>
</body>
</html>