<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
					<table id="family_othermessage" width="1300px" border="1" style="font-size: 11px;">
						<tr height="45px">
							<th rowspan="2" width="35px">户信息
								<input type="hidden" name="familyMessage.id" value="${familyMap.family_message.id}"/>
								<input type="hidden" name="familyMessage.cid" value="${familyMap.family_message.cid}"/>
							</th>
							<th>户主姓名</th>
							<td>${familyMap.family_message.hzxm}</td>
							<th>家庭人口数</th>
							<td>${familyMap.familyPersonNumber}</td>
							<th colspan="2">户籍地</th>
							<td colspan="2">${familyMap.family_message.hjd}</td>
							<th colspan="2">现居住地</th>
							<td colspan="2">${familyMap.family_message.xjdz}</td>
							<th>自来水是否入户</th>
							<td>
								<c:if test="${familyMap.family_message.zls=='0'}">是</c:if>
								<c:if test="${familyMap.family_message.zls=='1'}">否</c:if>
							</td>
						</tr>
						<tr>
							<th colspan="2">家庭获取荣誉情况</th>
							<td colspan="2">${familyMap.family_message.jtry}</td>
							<th colspan="2">违法违纪情况</th>
							<td colspan="2">${familyMap.family_message.wfwj}</td>
							<th colspan="2">安全生产情况</th>
							<td colspan="2" align="center">
								是否存在安全隐患<br>
								<c:if test="${familyMap.family_message.aqsc=='0'}">是</c:if>
								<c:if test="${familyMap.family_message.aqsc=='1'}">否</c:if>
							</td>
							<th>安全隐患类别</th>
							<td>
								<c:if test="${familyMap.family_message.aqyh=='1'}">类型一</c:if> 
								<c:if test="${familyMap.family_message.aqyh=='2'}">类型二</c:if> 
								<c:if test="${familyMap.family_message.aqyh=='3'}">类型三</c:if> 
								
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
							<td>${familyMap.family_assets.nczypf+familyMap.family_assets.nczyyd}</td>
							<td>${familyMap.family_assets.nczypf}</td>
							<td>${familyMap.family_assets.nczyyd}</td>
							<td>${familyMap.family_assets.nczfxjsj}</td>
							<td>
								<c:if test="${familyMap.family_assets.sfcz=='0'}">是</c:if>
								<c:if test="${familyMap.family_assets.sfcz=='1'}">否</c:if>
							</td>
							<td>
								<c:if test="${familyMap.family_assets.sfwf=='0'}">是</c:if>
								<c:if test="${familyMap.family_assets.sfwf=='1'}">否</c:if>
							</td>
							<td>${familyMap.family_assets.czpf+familyMap.family_assets.czyd+familyMap.family_assets.czlh}</td>
							<td>${familyMap.family_assets.czpf}</td>
							<td>${familyMap.family_assets.czyd}</td>
							<td>${familyMap.family_assets.czlh}</td>
							<td colspan="3">
								<c:if test="${familyMap.family_assets.syqlx=='1'}">自有</c:if>
								<c:if test="${familyMap.family_assets.syqlx=='2'}">保障房</c:if>
								<c:if test="${familyMap.family_assets.syqlx=='3'}">租赁</c:if>
							</td>
							<td>${familyMap.family_assets.sfwfcgf}</td>
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
							<th>自有：${familyMap.family_assets.zygd}</th>
							<th>承包：${familyMap.family_assets.cbgd}</th>
							<th>出租：${familyMap.family_assets.czgd}</th>
							<td>${familyMap.family_assets.ldmj}</td>
							<td>${familyMap.family_assets.cdmj}</td>
							<td>${familyMap.family_assets.cattle}</td>
							<td>${familyMap.family_assets.sheep}</td>
							<td>${familyMap.family_assets.pig}</td>
							<td>${familyMap.family_assets.checken}</td>
							<td colspan="3">${familyMap.family_assets.other_animal}</td>
						</tr>
						<tr>
							<th colspan="2" rowspan="${familyMap.family_vehicle.size()+1}" id="jdclsyqk">机动车辆使用情况</th>
							<th colspan="2">类型</th>
							<th colspan="2">品牌</th>
							<th colspan="2">价值</th>
							<th colspan="3">来源方式</th>
							<th colspan="4">牌照号码</th>
						</tr>
						<c:forEach items="${familyMap.family_vehicle}" var="family_vehicle" varStatus="arr">
							<tr class="family_vehicle">
								<th colspan="2">
									<c:if test="${family_vehicle.car_type=='0'}">经营</c:if>
									<c:if test="${family_vehicle.car_type=='1'}">家用</c:if>
								</th>
								<td colspan="2">${family_vehicle.car_brand}</td>
								<td colspan="2">${family_vehicle.car_price}</td>
								<td colspan="3">${family_vehicle.car_getMode}</td>
								<td colspan="4">${family_vehicle.car_license_plate}</td>
									
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
							<td>${familyMap.family_income.zznsr}</td>
							<th rowspan="4">财产性收入</th>
							<th>承包地转让收入</th>
							<td>${familyMap.family_income.cbdzrsr}</td>
							<th rowspan="6">转移性收入</th>
							<th colspan="2">养老金退休金收入</th>
							<td>${familyMap.family_income.yltxjsr}</td>
							<th>生活开支</th>
							<td>${familyMap.family_pay.shkz}</td>
							<td rowspan="6">${familyMap.family_income.qtzyxsr+familyMap.family_income.wccysr+familyMap.family_income.jkwwjsr+familyMap.family_income.bzcysr+familyMap.family_income.sysr+familyMap.family_income.qtccxsr+familyMap.family_income.jsnsr+familyMap.family_income.zznsr+familyMap.family_income.cbdzrsr+familyMap.family_income.yltxjsr+familyMap.family_income.yznsr+familyMap.family_income.jxczsr+familyMap.family_income.shjjjzsr+familyMap.family_income.jgnsr+familyMap.family_income.fwczsr+familyMap.family_income.zcxbtsr-familyMap.family_pay.shkz-familyMap.family_pay.ylkz-familyMap.family_pay.jykz-familyMap.family_pay.zfkz-familyMap.family_pay.jtkz-familyMap.family_pay.qtkz}</td>
						</tr>
						<tr>
							<th>养殖年收入</th>
							<td>${familyMap.family_income.yznsr}</td>
							<th>机械出租收入</th>
							<td>${familyMap.family_income.jxczsr}</td>
							<th colspan="2">社会救济救助收入</th>
							<td>${familyMap.family_income.shjjjzsr}</td>
							<th>医疗</th>
							<td>${familyMap.family_pay.ylkz}</td>
						</tr>
						<tr>
							<th>加工年收入</th>
							<td>${familyMap.family_income.jgnsr}</td>
							<th>房屋出租收入</th>
							<td>${familyMap.family_income.fwczsr}</td>
							<th colspan="2">政策性补贴收入</th>
							<td>${familyMap.family_income.zcxbtsr}</td>
							<th>教育</th>
							<td>${familyMap.family_pay.jykz}</td>
						</tr>
						<tr>
							<th rowspan="3">商业性产业</th>
							<th rowspan="3">经商年收入</th>
							<td rowspan="3">${familyMap.family_income.jsnsr}</td>
							<th>其他收入</th>
							<td>${familyMap.family_income.qtccxsr}</td>
							<th colspan="2">赡养收入</th>
							<td>${familyMap.family_income.sysr}</td>
							<th>住房</th>
							<td>${familyMap.family_pay.zfkz}</td>
						</tr>
						<tr>
							<th rowspan="2">工资性收入</th>
							<th>本镇从业收入</th>
							<td>${familyMap.family_income.bzcysr}</td>
							<th colspan="2">捐款、慰问金收入</th>
							<td>${familyMap.family_income.jkwwjsr}</td>
							<th>交通</th>
							<td>${familyMap.family_pay.jtkz}</td>
						</tr>
						<tr>
							<th>外出从业收入</th>
							<td>${familyMap.family_income.wccysr}</td>
							<th colspan="2">其他收入</th>
							<td>${familyMap.family_income.qtzyxsr}</td>
							<th>其他</th>
							<td>${familyMap.family_pay.qtkz}</td>
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
							<td>${familyMap.family_shebao.yiliaobx}</td>
							<td>${familyMap.family_shebao.yanglaobx}</td>
							<td>${familyMap.family_shebao.yfdx}</td>
							<td>${familyMap.family_shebao.glbt}</td>
							<td>${familyMap.family_shebao.db}</td>
							<td>${familyMap.family_shebao.wb}</td>
							<td>${familyMap.family_shebao.guer}</td>
							<td>${familyMap.family_shebao.cjr}</td>
							<td>${familyMap.family_shebao.tsrq}</td>
							<td>${familyMap.family_shebao.dbjz}</td>
							<td>${familyMap.family_shebao.lsjz}</td>
							<td>${familyMap.family_shebao.zfbz}</td>
							<td>${familyMap.family_shebao.shjk}</td>
							<td>${familyMap.family_shebao.ww}</td>
						</tr>
						<tr>
							<th>其他
								<input type="hidden" name="family_other.id" value="${familyMap.family_other.id}"/>
							</th>
							<th>治安状况</th>
							<td colspan="2">${familyMap.family_other.zazk}</td>
							<th>计生状况</th>
							<td colspan="2">${familyMap.family_other.jszk}</td>
							<th>服兵役状况</th>
							<td colspan="3">${familyMap.family_other.fbyzt}</td>
							<th>志愿服务情况</th>
							<td colspan="3">${familyMap.family_other.zyfwqk}</td>
						</tr>
						<tr>
							<th colspan="3">家庭存在主要困难</th>
							<td colspan="12">${familyMap.family_other.jtczzykn}</td>
						</tr>
						<tr>
							<th rowspan="${familyMap.cadres_home.size()+1}" id="gbrhjjss">干部入户解决实际</th>
							<th>干部姓名</th>
							<th colspan="2">入户时间</th>
							<th colspan="11">解决问题情况</th>
						</tr>
						<c:forEach items="${familyMap.cadres_home}" var="cadres_home" varStatus="_arr">
							<tr class="cadres_home">
								<td>${cadres_home.gbname}</td>
								<td colspan="2">${cadres_home.rhtime}</td>
								<td colspan="11">${cadres_home.jjwtqk}</td>
							</tr>
						</c:forEach>
					</table>
</body>
</html>