<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	/* 机动车辆添加删除一行 */
	function addCarRow(){
		var rownum = $(".family_vehicle").length;
		var newrow = 
			 "<tr class='family_vehicle'>"
				+"<th colspan='2'>"
					+"经营<input type='radio' value='0' name='family_vehicle["+rownum+"].car_type' style='height:15px;width:10px;'/><br>"
					+"家用<input type='radio' value='1' name='family_vehicle["+rownum+"].car_type' style='height:15px;width:10px;'/>"
				+"</th>"
				+"<td colspan='2'><input type='text' name='family_vehicle["+rownum+"].car_brand'/></td>"
				+"<td colspan='2'><input type='text' name='family_vehicle["+rownum+"].car_price'/></td>"
				+"<td colspan='2'><input t+ype='text' name='family_vehicle["+rownum+"].car_getMode'/></td>"
				+"<td colspan='2'><input type='text' name='family_vehicle["+rownum+"].car_license_plate'/></td>"
				+"<td colspan='3'><input type='button' value='删除' onclick='delCarRow(this)'/></td>"
			+"</tr>";
		$("#jingjishouzhi").before(newrow);
		$("#jdclsyqk").attr("rowspan",rownum+2);
	}
	function delCarRow(obj){
		$(obj).parent().parent().remove();
		var rownum = $(".family_vehicle").length;
		$("#jdclsyqk").attr("rowspan",rownum+1);
	}
	/* 干部入户添加删除一行 */
	function addCadres_homeRow(){
		var rownum = $(".cadres_home").length;
		var newrow = 
			 "<tr class='cadres_home'>"
				+"<td><input type='text' name='cadres_home["+rownum+"].gbname'/></td>"
				+"<td colspan='2'><input type='text' name='cadres_home["+rownum+"].rhtime' style='width:140px'/></td>"
				+"<td colspan='10'><textarea rows='1' cols='100' name='cadres_home["+rownum+"].jjwtqk'></textarea></td>"
				+"<td><input type='button' value='删除' onclick='delCadres_homeRow(this)'/></td>"
			+"</tr>";
		$("#family_othermessage").append(newrow);
		$("#gbrhjjss").attr("rowspan",rownum+2);
	}
	function delCadres_homeRow(obj){
		$(obj).parent().parent().remove();
		var rownum = $(".family_vehicle").length;
		$("#gbrhjjss").attr("rowspan",rownum+1);
	}
	//根据act决定添加还是修改
	function save(act,cid){
		alert(act+"   "+cid);
		if(act=="updated"){
			$("#saveFamilyAllMessage").form("submit", {
		        url: "<c:url value='/message/saveUpdatedMessage.m'/>",
		        onSubmit: function () {
		            return $(this).form("validate");
		        },
		        success: function (result) {
		        	alert(result);
		            if (result == "ok") {
		                $.messager.alert("提示信息", "操作成功");
		                window.close();//关闭当前窗口
		            }
		            else {
		                $.messager.alert("提示信息", "操作失败");
		            }
		        }
		    });
		}else if(act=="inserted"){
			alert("<c:url value='/message/saveFamilAllMessage.m?familyMessage.cid='/>"+cid);
			$("#saveFamilyAllMessage").form("submit", {
		        url: "<c:url value='/message/saveFamilAllMessage.m?familyMessage.cid='/>"+cid,
		        onSubmit: function () {
		            return $(this).form("validate");
		        },
		        success: function (result) {
		            if (result == "ok") {
		                $.messager.alert("提示信息", "操作成功");
		                window.close();//关闭当前窗口
		            }
		            else {
		                $.messager.alert("提示信息", "操作失败");
		            }
		        }
		    });
		}
	}
</script>
<style type="text/css">
	/* #family_othermessage tr:nth-child(2n+1){
		background:#F5FAFF;
	}
	#family_othermessage tr:nth-child(2n){
		background:#FCFCFC;
	} */
	
	#family_othermessage tr{
		background:#DCDCDC;
	}
	#family_othermessage textarea{
		font-size: 12px;
	}
	#family_othermessage td{
		height: 33px;
		width: 70px;
		text-align: center;
	}
	#family_othermessage th{
		height: 33px;
		width: 70px;
	}
	#family_othermessage input{
		height: 33px;
		width: 70px;
	}
</style>
</head>
<body>
				<form method="post" id="saveFamilyAllMessage">
					<a href="javascript:save('<%=request.getParameter("act")%>','<%=request.getParameter("cid")%>')" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
					<table id="family_othermessage" width="1300px" border="1" style="font-size: 11px;">
						<tr height="45px">
							<th rowspan="2" width="35px">户信息
								<input type="hidden" name="familyMessage.id" value="${familyMap.family_message.id}"/>
								<input type="hidden" name="familyMessage.cid" value="${familyMap.family_message.cid}"/>
							</th>
							<th>户主姓名</th>
							<td><input type="text"  name="familyMessage.hzxm" value="${familyMap.family_message.hzxm}"/></td>
							<th>家庭人口数</th>
							<td>${familyMap.familyPersonNumber}</td>
							<th colspan="2">户籍地</th>
							<td colspan="2"><textarea rows="1" cols="14" name="familyMessage.hjd">${familyMap.family_message.hjd}</textarea></td>
							<th colspan="2">现居住地</th>
							<td colspan="2"><textarea rows="1" cols="14" name="familyMessage.xjdz">${familyMap.family_message.xjdz}</textarea></td>
							<th>自来水是否入户</th>
							<td>
								是<input type="radio" name="familyMessage.zls" value="0" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_message.zls=='0'}">checked</c:if>/>
								否<input type="radio" name="familyMessage.zls" value="1" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_message.zls=='1'}">checked</c:if>/>
							</td>
						</tr>
						<tr>
							<th colspan="2">家庭获取荣誉情况</th>
							<td colspan="2"><textarea rows="1" cols="14" name="familyMessage.jtry">${familyMap.family_message.jtry}</textarea></td>
							<th colspan="2">违法违纪情况</th>
							<td colspan="2"><textarea rows="1" cols="14" name="familyMessage.wfwj">${familyMap.family_message.wfwj}</textarea></td>
							<th colspan="2">安全生产情况</th>
							<td colspan="2" align="center">
								是否存在安全隐患<br>
								是<input type="radio" name="familyMessage.aqsc" value="0" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_message.aqsc=='0'}">checked</c:if>>
								否<input type="radio" name="familyMessage.aqsc" value="1" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_message.aqsc=='1'}">checked</c:if>>
							</td>
							<th>安全隐患类别</th>
							<td>
								<select name="familyMessage.aqyh">
									<option value="" selected="selected">-请选择-</option>
									<option value="1" <c:if test="${familyMap.family_message.aqyh=='1'}">selected="selected"</c:if> >类型一</option>
									<option value="2" <c:if test="${familyMap.family_message.aqyh=='2'}">selected="selected"</c:if> >类型二</option>
									<option value="3" <c:if test="${familyMap.family_message.aqyh=='3'}">selected="selected"</c:if> >类型三</option>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="5" width="35px">家庭资<br/>产情况
								<input type="hidden" name="family_assets.id" value="${familyMap.family_assets.id}"/>
							</th>
							<th colspan="6">农村自有住房</th>
							<th colspan="8">城镇住房情况</th>
						</tr>
						<tr>
							<th>住房面积</th>
							<th>平房(间)</th>
							<th>窑洞(孔)</th>
							<th>修建时间</th>
							<th>是否常住</th>
							<th>是否危房</th>
							<th>住房面积</th>
							<th>平房(间)</th>
							<th>窑洞(孔)</th>
							<th>楼户(平米)</th>
							<th colspan="3">所有权类型</th>
							<th>是否危房、彩钢房</th>
						</tr>
						<tr>
							<td><input type="text" value="${familyMap.family_assets.nczypf+familyMap.family_assets.nczyyd}"/></td>
							<td><input type="text" name="family_assets.nczypf" value="${familyMap.family_assets.nczypf}"/></td>
							<td><input type="text" name="family_assets.nczyyd" value="${familyMap.family_assets.nczyyd}"/></td>
							<td><input type="text" name="family_assets.nczfxjsj" value="${familyMap.family_assets.nczfxjsj}"/></td>
							<td>
								是<input type="radio" name="family_assets.sfcz" value="0" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_assets.sfcz=='0'}">checked</c:if>/>
								否<input type="radio" name="family_assets.sfcz" value="1" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_assets.sfcz=='1'}">checked</c:if>/>
							</td>
							<td>
								是<input type="radio" name="family_assets.sfwf" value="0" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_assets.sfwf=='0'}">checked</c:if>/>
								否<input type="radio" name="family_assets.sfwf" value="1" style="height: 15px;width: 10px;" <c:if test="${familyMap.family_assets.sfwf=='1'}">checked</c:if>/>
							</td>
							<td><input type="text" value="${familyMap.family_assets.czpf+familyMap.family_assets.czyd+familyMap.family_assets.czlh}"/></td>
							<td><input type="text" name="family_assets.czpf" value="${familyMap.family_assets.czpf}"/></td>
							<td><input type="text" name="family_assets.czyd" value="${familyMap.family_assets.czyd}"/></td>
							<td><input type="text" name="family_assets.czlh" value="${familyMap.family_assets.czlh}"/></td>
							<td>自有<input type="radio" name="family_assets.syqlx" value="1" <c:if test="${familyMap.family_assets.syqlx=='1'}">checked</c:if>/></td>
							<td>保障房<input type="radio" name="family_assets.syqlx" value="2" <c:if test="${familyMap.family_assets.syqlx=='2'}">checked</c:if>/></td>
							<td>租赁<input type="radio" name="family_assets.syqlx" value="3" <c:if test="${familyMap.family_assets.syqlx=='3'}">checked</c:if>/></td>
							<td><input type="text" name="family_assets.sfwfcgf" value="${familyMap.family_assets.sfwfcgf}"/></td>
						</tr>
						<tr>
							<th rowspan="2">土地经营情况</th>
							<th colspan="3">耕地(亩)</th>
							<th>林地(亩)</th>
							<th>草地(亩)</th>
							<th rowspan="2">养殖情况</th>
							<th>牛</th>
							<th>羊</th>
							<th>猪</th>
							<th>鸡</th>
							<th colspan="3">其他</th>
						</tr>
						<tr>
							<th>自有：<input type="text" name="family_assets.zygd" style="width: 35px;" value="${familyMap.family_assets.zygd}"/></th>
							<th>承包：<input type="text" name="family_assets.cbgd" style="width: 35px;" value="${familyMap.family_assets.cbgd}"/></th>
							<th>出租：<input type="text" name="family_assets.czgd" style="width: 35px;" value="${familyMap.family_assets.czgd}"/></th>
							<td><input type="text" name="family_assets.ldmj" value="${familyMap.family_assets.ldmj}"/></td>
							<td><input type="text" name="family_assets.cdmj" value="${familyMap.family_assets.cdmj}"/></td>
							<td><input type="text" name="family_assets.cattle" value="${familyMap.family_assets.cattle}"/></td>
							<td><input type="text" name="family_assets.sheep" value="${familyMap.family_assets.sheep}"/></td>
							<td><input type="text" name="family_assets.pig" value="${familyMap.family_assets.pig}"/></td>
							<td><input type="text" name="family_assets.checken" value="${familyMap.family_assets.checken}"/></td>
							<td colspan="3"><textarea rows="1" cols="28" name="family_assets.other_animal">${familyMap.family_assets.other_animal}</textarea></td>
						</tr>
						<tr>
							<th colspan="2" rowspan="${familyMap.family_vehicle.size()+1}" id="jdclsyqk">机动车辆使用情况</th>
							<th colspan="2">类型</th>
							<th colspan="2">品牌</th>
							<th colspan="2">价值</th>
							<th colspan="2">来源方式</th>
							<th colspan="2">牌照号码</th>
							<th colspan="3"><input type="button" value="添加" onclick="addCarRow()"/></th>
						</tr>
						<c:forEach items="${familyMap.family_vehicle}" var="family_vehicle" varStatus="arr">
							<tr class="family_vehicle">
								<th colspan="2">
									经营<input type="radio" value="0" name="family_vehicle[${arr.index}].car_type" style="height: 15px;width: 10px;" <c:if test="${family_vehicle.car_type=='0'}">checked</c:if>/><br>
									家用<input type="radio" value="1" name="family_vehicle[${arr.index}].car_type" style="height: 15px;width:10px;" <c:if test="${family_vehicle.car_type=='1'}">checked</c:if>/>
								</th>
								<td colspan="2"><input type="text" name="family_vehicle[${arr.index}].car_brand" value="${family_vehicle.car_brand}"/></td>
								<td colspan="2"><input type="text" name="family_vehicle[${arr.index}].car_price" value="${family_vehicle.car_price}"/></td>
								<td colspan="2"><input type="text" name="family_vehicle[${arr.index}].car_getMode" value="${family_vehicle.car_getMode}"/></td>
								<td colspan="2"><input type="text" name="family_vehicle[${arr.index}].car_license_plate" value="${family_vehicle.car_license_plate}"/></td>
								<td colspan="3">
									<input type="button" value="删除" onclick="delCarRow(this)"/>
									<input type="hidden" name="family_vehicle[${arr.index}].id" value="${family_vehicle.id}"/>
								</td>
							</tr>
						</c:forEach>
						<tr id="jingjishouzhi">
							<th rowspan="7">经济收支情况
								<input type="hidden" name="family_income.id" value="${familyMap.family_income.id}"/><!-- 收入id -->
								<input type="hidden" name="family_pay.id" value="${familyMap.family_pay.id}"/><!-- 支出id -->
							</th>
							<th colspan="11">家庭年收入</th>
							<th colspan="2">家庭支出</th>
							<th>净收入</th>
						</tr>
						<tr>
							<th rowspan="6">经营性收入</th>
							<th rowspan="3">种养加产业</th>
							<th>种植年收入</th>
							<td><input type="text" name="family_income.zznsr" value="${familyMap.family_income.zznsr}"/></td>
							<th rowspan="4">财产性收入</th>
							<th>承包地转让收入</th>
							<td><input type="text" name="family_income.cbdzrsr" value="${familyMap.family_income.cbdzrsr}"/></td>
							<th rowspan="6">转移性收入</th>
							<th colspan="2">养老金退休金收入</th>
							<td><input type="text" name="family_income.yltxjsr" value="${familyMap.family_income.yltxjsr}"/></td>
							<th>生活开支</th>
							<td><input type="text" name="family_pay.shkz" value="${familyMap.family_pay.shkz}"/></td>
							<td rowspan="6"></td>
						</tr>
						<tr>
							<th>养殖年收入</th>
							<td><input type="text" name="family_income.yznsr" value="${familyMap.family_income.yznsr}"/></td>
							<th>机械出租收入</th>
							<td><input type="text" name="family_income.jxczsr" value="${familyMap.family_income.jxczsr}"/></td>
							<th colspan="2">社会救济救助收入</th>
							<td><input type="text" name="family_income.shjjjzsr" value="${familyMap.family_income.shjjjzsr}"/></td>
							<th>医疗</th>
							<td><input type="text" name="family_pay.ylkz" value="${familyMap.family_pay.ylkz}"/></td>
						</tr>
						<tr>
							<th>加工年收入</th>
							<td><input type="text" name="family_income.jgnsr" value="${familyMap.family_income.jgnsr}"/></td>
							<th>房屋出租收入</th>
							<td><input type="text" name="family_income.fwczsr" value="${familyMap.family_income.fwczsr}"/></td>
							<th colspan="2">政策性补贴收入</th>
							<td><input type="text" name="family_income.zcxbtsr" value="${familyMap.family_income.zcxbtsr}"/></td>
							<th>教育</th>
							<td><input type="text" name="family_pay.jykz" value="${familyMap.family_pay.jykz}"/></td>
						</tr>
						<tr>
							<th rowspan="3">商业性产业</th>
							<th rowspan="3">经商年收入</th>
							<td rowspan="3"><input type="text" name="family_income.jsnsr" value="${familyMap.family_income.jsnsr}"/></td>
							<th>其他收入</th>
							<td><input type="text" name="family_income.qtccxsr" value="${familyMap.family_income.qtccxsr}"/></td>
							<th colspan="2">赡养收入</th>
							<td><input type="text" name="family_income.sysr" value="${familyMap.family_income.sysr}"/></td>
							<th>住房</th>
							<td><input type="text" name="family_pay.zfkz" value="${familyMap.family_pay.zfkz}"/></td>
						</tr>
						<tr>
							<th rowspan="2">工资性收入</th>
							<th>本镇从业收入</th>
							<td><input type="text" name="family_income.bzcysr" value="${familyMap.family_income.bzcysr}"/></td>
							<th colspan="2">捐款、慰问金收入</th>
							<td><input type="text" name="family_income.jkwwjsr" value="${familyMap.family_income.jkwwjsr}"/></td>
							<th>交通</th>
							<td><input type="text" name="family_pay.jtkz" value="${familyMap.family_pay.jtkz}"/></td>
						</tr>
						<tr>
							<th>外出从业收入</th>
							<td><input type="text" name="family_income.wccysr" value="${familyMap.family_income.wccysr}"/></td>
							<th colspan="2">其他收入</th>
							<td><input type="text" name="family_income.qtzyxsr" value="${familyMap.family_income.qtzyxsr}"/></td>
							<th>其他</th>
							<td><input type="text" name="family_pay.qtkz" value="${familyMap.family_pay.qtkz}"/></td>
						</tr>
						<tr>
							<th rowspan="2">社会保障
								<input type="hidden" name="family_shebao.id" value="${familyMap.family_shebao.id}"/>
							</th>
							<th>医疗保险</th>
							<th>养老保险</th>
							<th>优抚对象</th>
							<th>高龄补贴</th>
							<th>低保</th>
							<th>五保</th>
							<th>孤儿</th>
							<th>残疾人</th>
							<th>特殊人群</th>
							<th>大病救助</th>
							<th>临时救助</th>
							<th>住房保障</th>
							<th>社会捐款</th>
							<th>慰问</th>
						</tr>
						<tr>
							<td><input type="text" name="family_shebao.yiliaobx" value="${familyMap.family_shebao.yiliaobx}"/></td>
							<td><input type="text" name="family_shebao.yanglaobx" value="${familyMap.family_shebao.yanglaobx}"/></td>
							<td><input type="text" name="family_shebao.yfdx" value="${familyMap.family_shebao.yfdx}"/></td>
							<td><input type="text" name="family_shebao.glbt" value="${familyMap.family_shebao.glbt}"/></td>
							<td><input type="text" name="family_shebao.db" value="${familyMap.family_shebao.db}"/></td>
							<td><input type="text" name="family_shebao.wb" value="${familyMap.family_shebao.wb}"/></td>
							<td><input type="text" name="family_shebao.guer" value="${familyMap.family_shebao.guer}"/></td>
							<td><input type="text" name="family_shebao.cjr" value="${familyMap.family_shebao.cjr}"/></td>
							<td><input type="text" name="family_shebao.tsrq" value="${familyMap.family_shebao.tsrq}"/></td>
							<td><input type="text" name="family_shebao.dbjz" value="${familyMap.family_shebao.dbjz}"/></td>
							<td><input type="text" name="family_shebao.lsjz" value="${familyMap.family_shebao.lsjz}"/></td>
							<td><input type="text" name="family_shebao.zfbz" value="${familyMap.family_shebao.zfbz}"/></td>
							<td><input type="text" name="family_shebao.shjk" value="${familyMap.family_shebao.shjk}"/></td>
							<td><input type="text" name="family_shebao.ww" value="${familyMap.family_shebao.ww}"/></td>
						</tr>
						<tr>
							<th>其他
								<input type="hidden" name="family_other.id" value="${familyMap.family_other.id}"/>
							</th>
							<th>治安状况</th>
							<td colspan="2"><textarea rows="1" cols="14" name="family_other.zazk">${familyMap.family_other.zazk}</textarea></td>
							<th>计生状况</th>
							<td colspan="2"><textarea rows="1" cols="14" name="family_other.jszk">${familyMap.family_other.jszk}</textarea></td>
							<th>服兵役状况</th>
							<td colspan="3"><textarea rows="1" cols="21" name="family_other.fbyzt">${familyMap.family_other.fbyzt}</textarea></td>
							<th>志愿服务情况</th>
							<td colspan="3"><textarea rows="1" cols="21" name="family_other.zyfwqk">${familyMap.family_other.zyfwqk}</textarea></td>
						</tr>
						<tr>
							<th colspan="3">家庭存在主要困难</th>
							<td colspan="12"><textarea rows="1" cols="105" name="family_other.jtczzykn">${familyMap.family_other.jtczzykn}</textarea></td>
						</tr>
						<tr>
							<th rowspan="${familyMap.cadres_home.size()+1}" id="gbrhjjss">干部入户解决实际</th>
							<th>干部姓名</th>
							<th colspan="2">入户时间</th>
							<th colspan="10">解决问题情况</th>
							<th><input type="button" value="添加" onclick="addCadres_homeRow()"/></th>
						</tr>
						<c:forEach items="${familyMap.cadres_home}" var="cadres_home" varStatus="_arr">
							<tr class="cadres_home">
								<td><input type="text" name="cadres_home[${_arr.index}].gbname" value="${cadres_home.gbname}"/></td>
								<td colspan="2"><input type="text" name="cadres_home[${_arr.index}].rhtime" value="${cadres_home.rhtime}" style="width:140px"/></td>
								<td colspan="10"><textarea rows="1" cols="100" name="cadres_home[${_arr.index}].jjwtqk">${cadres_home.jjwtqk}</textarea></td>
								<td><input type="button" value="删除" onclick="delCadres_homeRow(this)"/>
									<input type="hidden" name="cadres_home[${_arr.index}].id" value="${cadres_home.id}"/>
								</td>
							</tr>
						</c:forEach>
					</table>
				</form>
</body>
</html>