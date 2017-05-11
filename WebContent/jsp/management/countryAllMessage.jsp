<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/jsp/comm/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#countryAllMessage tr{
		background:#DCDCDC;
		font-size: 13px;
	}
	#countryAllMessage textarea{
		font-size: 12px;
	}
	#countryAllMessage td{
		height: 33px;
		width: 80px;
		text-align:center;
	}
	#countryAllMessage th{
		height: 33px;
		width: 80px;
	}
	#countryAllMessage input{
		height: 33px;
		width: 80px;
	}
</style>
</head>
<body>
<form method="post" id="saveMessageForm">
</form>
	<table border="1" id="countryAllMessage" align="center">
		<tr>
			<th rowspan="5">人口情况</th>
			<th>总户数</th>
			<td>${countryAllMessageMap.family_message}</td>
			<th>总人口</th>
			<td>${countryAllMessageMap.person_message}</td>
			<th>男性人口</th>
			<td>${countryAllMessageMap.person_messagesexs}</td>
			<th>女性人口</th>
			<td>${countryAllMessageMap.person_messagesexa}</td>
			<th>常住人口</th>
			<td>${countryAllMessageMap.family_assets}</td>
			<th>流动人口</th>
			<td>${countryAllMessageMap.county_flow}</td>
			<th>少数民族人口</th>
			<td>${countryAllMessageMap.person_messagemz}</td>
		</tr>
		<tr>
			<th>文盲</th>
			<td>${countryAllMessageMap.person_messagewhcdw}</td>
			<th>小学</th>
			<td>${countryAllMessageMap.person_messagewhcdx}</td>
			<th>初中</th>
			<td>${countryAllMessageMap.person_messagewhcdc}</td>
			<th>高中（中专）</th>
			<td>${countryAllMessageMap.person_messagewhcdg}</td>
			<th>大专以上</th>
			<td colspan="5">${countryAllMessageMap.person_messagewhcdd}</td>
		</tr>
		<tr>
			<th colspan="2">劳动力人口</th>
			<td>${countryAllMessageMap.person_messageldl}</td>
			<th>务农人数</th>
			<td>${countryAllMessageMap.person_messagecyztw}</td>
			<th colspan="2">外出务工人数</th>
			<td>${countryAllMessageMap.person_messagecyztwc}</td>
			<th>剩余劳动力</th>
			<td colspan="5">${countryAllMessageMap.person_messagecyztw}</td>
		</tr>
		<tr>
			<th>大学毕业生就业情况</th>
			<th colspan="2">总数</th>
			<td>${countryAllMessageMap.person_messagewhcdd}</td>
			<th>国企工作</th>
			<td>${countryAllMessageMap.person_messagebyjygq}</td>
			<th>行政事业单位</th>
			<td>${countryAllMessageMap.person_messagebyjyxz}</td>
			<th>民企工作</th>
			<td>${countryAllMessageMap.person_messagebyjymq}</td>
			<th>自主创业</th>
			<td>${countryAllMessageMap.person_messagebyjyzz}</td>
			<th>未就业人数</th>
			<td>${countryAllMessageMap.person_messagebyjywjy}</td>
		</tr>
		<tr>
			<th>在校学生情况</th>
			<th colspan="2">总数</th>
			<td colspan="2">${countryAllMessageMap.person_messagezxxs}</td>
			<th colspan="2">小学</th>
			<td>${countryAllMessageMap.person_messagezxxsx}</td>
			<th>初中</th>
			<td>${countryAllMessageMap.person_messagezxxsc}</td>
			<th>高中</th>
			<td>${countryAllMessageMap.person_messagezxxsg}</td>
			<th>大专以上</th>
			<td>${countryAllMessageMap.person_messagezxxsd}</td>
		</tr>
		<tr>
			<th rowspan="2">党员情况</th>
			<th>党员总数</th>
			<td colspan="2">${countryAllMessageMap.person_messagezzmm}</td>
			<th>女党员数</th>
			<td>${countryAllMessageMap.person_messagendy}</td>
			<th>党员平均年龄</th>
			<td>${countryAllMessageMap.person_messagendynl}</td>
			<th>35岁以下党员数量</th>
			<td>${countryAllMessageMap.person_messagendyyx}</td>
			<th>70岁以上老党员数</th>
			<td>${countryAllMessageMap.person_messagendyys}</td>
			<th colspan="2">建国前老党员数量</th>
			<td>${countryAllMessageMap.person_messagendyldy}</td>
		</tr>
		<tr>
			<th>流出党员数</th>
			<td colspan="2">${countryAllMessageMap.person_messagenlcdy}</td>
			<th colspan="2">流入党员数</th>
			<td>${countryAllMessageMap.person_messagenlrdy}</td>
			<th colspan="3">大专以上学历党员数量</th>
			<td>${countryAllMessageMap.person_messagedxsdy}</td>
			<th colspan="3">近三年发展党员数量</th>
			<td>${countryAllMessageMap.person_messagejsndy}</td>
		</tr>
		<tr>
			<!-- 根据职位判断部门 -->
			<c:forEach items="${countryAllMessageMap.country_committee}" var="country_committee">
				<c:if test="${country_committee.zw=='1'}">
					<c:set value="${country_committee}" var="dangzuzhi"/>
				</c:if>
				<c:if test="${country_committee.zw=='2'}">
					<c:set value="${country_committee}" var="cunweihui"/>
				</c:if>
				<c:if test="${country_committee.zw=='3'}">
					<c:set value="${country_committee}" var="jianweihui"/>
				</c:if>
			</c:forEach>
			<th rowspan="2">村党组织情况</th>
			<th>书记姓名</th>
			<td colspan="2">${dangzuzhi.name}</td>
			<th>性别</th>
			<td>
				<c:if test="${dangzuzhi.sex==0}">女</c:if>
				<c:if test="${dangzuzhi.sex==1}">男</c:if>
			</td>
			<th>出生年月</th>
			<td>${dangzuzhi.birthday}</td>
			<th>文化程度</th>
			<td>
				<c:if test="${dangzuzhi.whcd==0}">文盲</c:if>
				<c:if test="${dangzuzhi.whcd==1}">小学</c:if>
				<c:if test="${dangzuzhi.whcd==2}">初中</c:if>
				<c:if test="${dangzuzhi.whcd==3}">高中（中专）</c:if>
				<c:if test="${dangzuzhi.whcd==4}">大专以上</c:if>
			</td>
			<th colspan="2">联系方式</th>
			<td colspan="3">${dangzuzhi.lxfs}</td>
		</tr>
		<tr>
			<th>任现职时间</th>
			<td colspan="2">${dangzuzhi.rxzsj}</td>
			<th colspan="2">任职年限</th>
			<td>${dangzuzhi.rznx}</td>
			<th colspan="2">村党组织委员姓名</th>
			<td colspan="6">${dangzuzhi.wyxm}</td>
		</tr>
		<tr>
			<th rowspan="2">村委会情况</th>
			<th>村委会主任姓名</th>
			<td colspan="2">${cunweihui.name}</td>
			<th>性别</th>
			<td>
				<c:if test="${cunweihui.sex==0}">女</c:if>
				<c:if test="${cunweihui.sex==1}">男</c:if>
			
			</td>
			<th>出生年月</th>
			<td>${cunweihui.birthday}</td>
			<th>文化程度</th>
			<td>
				<c:if test="${cunweihui.whcd==0}">文盲</c:if>
				<c:if test="${cunweihui.whcd==1}">小学</c:if>
				<c:if test="${cunweihui.whcd==2}">初中</c:if>
				<c:if test="${cunweihui.whcd==3}">高中（中专）</c:if>
				<c:if test="${cunweihui.whcd==4}">大专以上</c:if>
			</td>
			<th colspan="2">联系方式</th>
			<td colspan="3">${cunweihui.lxfs}</td>
		</tr>
		<tr>
			<th>任现职时间</th>
			<td colspan="2">${cunweihui.rxzsj}</td>
			<th colspan="2">任职年限</th>
			<td>${cunweihui.rznx}</td>
			<th colspan="2">村委会委员姓名</th>
			<td colspan="6">${cunweihui.wyxm}</td>
		</tr>
		<tr>
			<th rowspan="2">监委会情况</th>
			<th>监委会主任姓名</th>
			<td colspan="2">${jianweihui.name}</td>
			<th>性别</th>
			<td>
				<c:if test="${jianweihui.sex==0}">女</c:if>
				<c:if test="${jianweihui.sex==1}">男</c:if>
			</td>
			<th>出生年月</th>
			<td>${jianweihui.birthday}</td>
			<th>文化程度</th>
			<td>
				<c:if test="${jianweihui.whcd==0}">文盲</c:if>
				<c:if test="${jianweihui.whcd==1}">小学</c:if>
				<c:if test="${jianweihui.whcd==2}">初中</c:if>
				<c:if test="${jianweihui.whcd==3}">高中（中专）</c:if>
				<c:if test="${jianweihui.whcd==4}">大专以上</c:if>
			</td>
			<th colspan="2">联系方式</th>
			<td colspan="3">${jianweihui.lxfs}</td>
		</tr>
		<tr>
			<th>任现职时间</th>
			<td colspan="2">${jianweihui.rxzsj}</td>
			<th colspan="2">任职年限</th>
			<td>${jianweihui.rznx}</td>
			<th colspan="2">监委会委员姓名</th>
			<td colspan="6">${jianweihui.wyxm}</td>
		</tr>
		<tr>
			<th>大学生村官情况</th>
			<th colspan="2">村官姓名</th>
			<td>${countryAllMessageMap.country_officer.name}</td>
			<th>性别</th>
			<td>
				<c:if test="${countryAllMessageMap.country_officer.sex==0}">女</c:if>
				<c:if test="${countryAllMessageMap.country_officer.sex==1}">男</c:if>
			</td>
			<th>出生年月</th>
			<td>${countryAllMessageMap.country_officer.birthday}</td>
			<th>文化程度</th>
			<td>
				<c:if test="${countryAllMessageMap.country_officer.whcd==0}">文盲</c:if>
				<c:if test="${countryAllMessageMap.country_officer.whcd==1}">小学</c:if>
				<c:if test="${countryAllMessageMap.country_officer.whcd==2}">初中</c:if>
				<c:if test="${countryAllMessageMap.country_officer.whcd==3}">高中（中专）</c:if>
				<c:if test="${countryAllMessageMap.country_officer.whcd==4}">大专以上</c:if>
			</td>
			<th colspan="2">联系方式</th>
			<td colspan="3">${countryAllMessageMap.country_officer.phonenumber}</td>
		</tr>
		<tr>
			<th>享受离任村干部补贴人员姓名</th>
			<td colspan="14">
				<c:forEach items="${countryAllMessageMap.county_outgoing}" var="county_outgoing">
					${county_outgoing.name}
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>村级阵地情况</th>
			<td colspan="14">${countryAllMessageMap.country_message.cjzdqk}</td>
		</tr>
		<tr>
			<th>村党组织情况</th>
			<td colspan="14">是否为软弱涣散村级党组织（如是，请说明原因）</td>
		</tr>
		<tr>
			<th>精神文明建设情况</th>
			<td colspan="14">${countryAllMessageMap.country_message.jswmjsqk}</td>
		</tr>
		<tr>
			<th>计划生育</th>
			<th>双女户数</th>
			<td colspan="2">${countryAllMessageMap.family_messagesnh}</td>
			<th>独生子女户数</th>
			<td>${countryAllMessageMap.family_messagedszn}</td>
			<th colspan="2">享受计划生育家庭扶助户数</th>
			<td colspan="2">${countryAllMessageMap.family_otherfz}</td>
			<th colspan="3">计划生育家庭创业工程奖励扶助户数</th>
			<td colspan="2">${countryAllMessageMap.family_otherjl}</td>
		</tr>
		<tr>
			<th rowspan="2">土地经营情况(亩)</th>
			<th rowspan="2">总土地面积</th>
			<td rowspan="2" colspan="2">${countryAllMessageMap.Land_industry.ztdmj}</td>
			<th>耕地面积</th>
			<th colspan="5">
				种植面积：&nbsp;${countryAllMessageMap.Land_industry.zzmj}
				闲置面积：&nbsp;${countryAllMessageMap.Land_industry.xzmj}
				规划使用面积：&nbsp;${countryAllMessageMap.Land_industry.ghsymj}
			</th>
			<th>林地面积</th>
			<td colspan="2">${countryAllMessageMap.Land_industry.ldmj}</td>
			<th>草地面积</th>
			<td>${countryAllMessageMap.Land_industry.cdmj}</td>
		</tr>
		<tr>
			<th colspan="2">住宅用地面积</th>
			<td colspan="2">${countryAllMessageMap.Land_industry.zcydmj}</td>
			<th colspan="2">土地流转面积</th>
			<td colspan="5">${countryAllMessageMap.Land_industry.tdlcmj}</td>
		</tr>
		<tr>
			<th rowspan="4">产业发展情况</th>
			<th>种植业</th>
			<td colspan="8">${countryAllMessageMap.Land_industry.zzy}</td>
			<th rowspan="4">现代农业奖补情况</th>
			<td colspan="4" rowspan="4">${countryAllMessageMap.Land_industry.xdny}</td>
		</tr>
		<tr>
			<th>养殖业</th>
			<td colspan="8">${countryAllMessageMap.Land_industry.yzy}</td>
		</tr>
		<tr>
			<th>服务业</th>
			<th>集体经营</th>
			<td colspan="3">农家乐&nbsp;${countryAllMessageMap.Land_industry.jnjl}&nbsp;家，商店家&nbsp;${countryAllMessageMap.Land_industry.jsd}&nbsp;，加工企业&nbsp;${countryAllMessageMap.Land_industry.jjgqy}&nbsp;家，乡村旅游&nbsp;${countryAllMessageMap.Land_industry.jxclg}&nbsp;家</td>
			<th>个体经营</th>
			<td colspan="3">农家乐&nbsp;${countryAllMessageMap.Land_industry.gnjl}&nbsp;家，商店家&nbsp;${countryAllMessageMap.Land_industry.gsd}&nbsp;，加工企业&nbsp;${countryAllMessageMap.Land_industry.gjgqy}&nbsp;家，乡村旅游&nbsp;${countryAllMessageMap.Land_industry.gxclg}&nbsp;家</td>
		</tr>
		<tr>
			<th>其他产业</th>
			<td colspan="8">${countryAllMessageMap.Land_industry.qtcy}</td>
		</tr>
		<tr>
			<th>企业、专业合作社情况</th>
			<td colspan="14">${countryAllMessageMap.country_message.qyhzsqk}</td>
		</tr>
		<tr>
			<th>住房情况</th>
			<td colspan="14">农村自有住房&nbsp;${countryAllMessageMap.family_assetsnc}&nbsp;间；城镇自有住房&nbsp;${countryAllMessageMap.family_assetscz}&nbsp;间&nbsp;${countryAllMessageMap.family_assetsczpm}&nbsp;平米；城镇租赁户&nbsp;${countryAllMessageMap.family_assetsczzl}&nbsp;家。</td>
		</tr>
		<tr>
			<th>道路桥梁情况</th>
			<td colspan="14">
				总公里数&nbsp;${countryAllMessageMap.country_building.ylyh + countryAllMessageMap.country_building.snyh + countryAllMessageMap.country_building.slsyh + countryAllMessageMap.country_building.cl}&nbsp;公里，
				其中油路硬化&nbsp;${countryAllMessageMap.country_building.ylyh}&nbsp;公里，
				水泥硬化&nbsp;${countryAllMessageMap.country_building.snyh}&nbsp;公里，
				砂砾石硬化&nbsp;${countryAllMessageMap.country_building.slsyh}&nbsp;公里，
				土路&nbsp;${countryAllMessageMap.country_building.cl}&nbsp;公里，
				桥梁&nbsp;${countryAllMessageMap.country_building.ql}&nbsp;座。
			</td>
		</tr>
		<tr>
			<th>库坝情况</th>
			<td colspan="14">
				清水坝&nbsp;${countryAllMessageMap.country_building.qsb}&nbsp;座，
				淤地坝&nbsp;${countryAllMessageMap.country_building.ynb}&nbsp;座。
			</td>
		</tr>
		<tr>
			<th>人畜饮水情况</th>
			<td colspan="14">自来水接入&nbsp;${countryAllMessageMap.family_messagezls}&nbsp;户，占全村总户数&nbsp;${countryAllMessageMap.family_messagezls/countryAllMessageMap.family_messagezhu*100}&nbsp;%</td>
		</tr>
		<tr>
			<th>通讯情况</th>
			<td colspan="14">
				村内手机信号覆盖情况（
				<c:choose>
					<c:when test="${countryAllMessageMap.country_communication.is_ydxh + countryAllMessageMap.country_communication.is_ltxh + countryAllMessageMap.country_communication.is_dxxh > 0}">有</c:when>
					<c:when test="${countryAllMessageMap.country_communication.is_ydxh + countryAllMessageMap.country_communication.is_ltxh + countryAllMessageMap.country_communication.is_dxxh == 0}">无</c:when>
				</c:choose>
				），
				具体为（
				<c:if test="${countryAllMessageMap.country_communication.is_ydxh == '1'}">移动、</c:if>
				<c:if test="${countryAllMessageMap.country_communication.is_ltxh == '1'}">联通、</c:if>
				<c:if test="${countryAllMessageMap.country_communication.is_dxxh == '1'}">电信</c:if>
				）信号；
				是否全村覆盖：
				<c:if test="${countryAllMessageMap.country_communication.is_qcfg == '1'}">是</c:if>
				<c:if test="${countryAllMessageMap.country_communication.is_qcfg == '0'}">否</c:if>
			</td>
		</tr>
		<tr>
			<th>车辆及机械拥有情况</th>
			<th colspan="2">运输大型车辆数量</th>
			<td>${countryAllMessageMap.family_vehicledx}</td>
			<th colspan="2">私家小轿车数量</th>
			<td>${countryAllMessageMap.family_vehiclesj}</td>
			<th>工程机械数量</th>
			<td>${countryAllMessageMap.family_vehiclegc}</td>
			<th colspan="2">农机具数量</th>
			<td>${countryAllMessageMap.family_vehiclenj}</td>
			<th colspan="2">其他机器数量</th>
			<td>${countryAllMessageMap.family_vehicleqt}</td>
		</tr>
		<c:forEach items="${countryAllMessageMap.country_group_finance}" var="country_group_finance">
			<c:if test="${country_group_finance.type=='1'}">
				<c:set value="${country_group_finance}" var="jitizichan"/>
			</c:if>
			<c:if test="${country_group_finance.type=='2'}">
				<c:set value="${country_group_finance}" var="jitishouru"/>
			</c:if>
			<c:if test="${country_group_finance.type=='3'}">
				<c:set value="${country_group_finance}" var="jitifuzhai"/>
			</c:if>
		</c:forEach>
		<tr>
			<th>集体资产</th>
			<td colspan="14">&nbsp;${jitizichan.privce}&nbsp;万元，明细：${jitizichan.message}</td>
		</tr>
		<tr>
			<th>集体收入</th>
			<td colspan="2">&nbsp;${jitishouru.privce}&nbsp;万元</td>
			<th colspan="2">集体收入主要来源</th>
			<td colspan="10">${jitishouru.message}</td>
		</tr>
		<tr>
			<th>集体负债</th>
			<td colspan="14">&nbsp;${jitifuzhai.privce}&nbsp;万元，负债原因：${jitifuzhai.message}</td>
		</tr>
		<tr>
			<th>财政投资情况</th>
			<td colspan="14">${countryAllMessageMap.country_message.cztzqk}</td>
		</tr>
		<tr>
			<th rowspan="4">社会保障情况</th>
			<th>低保户</th>
			<th><u>&nbsp;${countryAllMessageMap.family_shebaodb}&nbsp;</u>户</th>
			<th>五保户</th>
			<th><u>&nbsp;${countryAllMessageMap.family_shebaowb}&nbsp;</u>户</th>
			<th>残疾人</th>
			<th colspan="3">共<u>&nbsp;${countryAllMessageMap.family_shebaocjr}&nbsp;</u>人，特殊人群<u>&nbsp;${countryAllMessageMap.family_shebaotsrq}&nbsp;</u>人</th>
			<th>退伍军人</th>
			<td>${countryAllMessageMap.family_othertw}</td>
			<th>遗属补助</th>
			<td>${countryAllMessageMap.family_shebaoyz}</td>
			<th>孤儿人数</th>
			<td>${countryAllMessageMap.family_shebaoguer}</td>
		</tr>
		<tr>
			<th colspan="2">临时救助人数</th>
			<td>${countryAllMessageMap.family_shebaolsjz}</td>
			<th colspan="2">大病救助人数</th>
			<td>${countryAllMessageMap.family_shebaodbjz}</td>
			<th colspan="2">合作医疗参保人数</th>
			<td colspan="2">${countryAllMessageMap.family_shebaohzylbx}</td>
			<th colspan="2">农村养老保险参保人数</th>
			<td colspan="2">${countryAllMessageMap.family_shebaoylbx}</td>
		</tr>
		<tr>
			<th rowspan="2">60岁以上老年人总数</th>
			<th colspan="2">60至69周岁人数</th>
			<th colspan="2">70至79周岁人数</th>
			<th colspan="2">80至89周岁人数</th>
			<th colspan="2">90至99周岁人数</th>
			<th colspan="2">100周岁以上人数</th>
			<th rowspan="2">享受社会保障资金总额</th>
			<td colspan="2" rowspan="2">${countryAllMessageMap.family_shebaozje}</td>
		</tr>
		<tr>
			<td colspan="2">${countryAllMessageMap.person_messagels}</td>
			<td colspan="2">${countryAllMessageMap.person_messageqs}</td>
			<td colspan="2">${countryAllMessageMap.person_messagebs}</td>
			<td colspan="2">${countryAllMessageMap.person_messagejs}</td>
			<td colspan="2">${countryAllMessageMap.person_messageyb}</td>
		</tr>
		<tr>
			<th rowspan="4">扶贫攻坚情况</th>
			<th>是否为贫困村</th>
			<td>
			<c:if test="${countryAllMessageMap.country_poverty.is_pkc == '1'}">是</c:if>
			<c:if test="${countryAllMessageMap.country_poverty.is_pkc == '2'}">否</c:if>
			</td>
			<th>贫困户数</th>
			<td>${countryAllMessageMap.country_poverty.pk_number}</td>
			<th rowspan="2">脱贫措施</th>
			<td rowspan="2" colspan="4">${countryAllMessageMap.country_poverty.tpcs}</td>
			<th rowspan="2">移民安置方式</th>
			<th>进城入镇</th>
			<th>依托村庄</th>
			<th>新建社区</th>
			<th>跨区域安置</th>
		</tr>
		<tr>
			<th>是否移民搬迁</th>
			<td>
			<c:if test="${countryAllMessageMap.country_poverty.is_ymbq == '1'}">是</c:if>
			<c:if test="${countryAllMessageMap.country_poverty.is_ymbq == '2'}">否</c:if>
			</td>
			<th>搬迁户数</th>
			<td>
				${countryAllMessageMap.country_poverty.jcrzbqhs+countryAllMessageMap.country_poverty.ytczbqhs+countryAllMessageMap.country_poverty.xjcabqhs+countryAllMessageMap.country_poverty.kqyazbqhs}
			</td>
			<td>${countryAllMessageMap.country_poverty.jcrzbqhs}</td>
			<td>${countryAllMessageMap.country_poverty.ytczbqhs}</td>
			<td>${countryAllMessageMap.country_poverty.xjcabqhs}</td>
			<td>${countryAllMessageMap.country_poverty.kqyazbqhs}</td>
		</tr>
		<tr>
			<th colspan="2">派驻第一书记情况</th>
			<th>姓名</th>
			<td>${countryAllMessageMap.country_poverty.zpdysjname}</td>
			<th colspan="2">派出单位及职务</th>
			<td>${countryAllMessageMap.country_poverty.zpdysjpcdwjzw}</td>
			<th colspan="3">联系方式</th>
			<td colspan="4">${countryAllMessageMap.country_poverty.zpdysjphonenumber}</td>
		</tr>
		<tr>
			<th colspan="2">派驻干部 驻村联户扶贫工作队情况</th>
			<th>队长姓名</th>
			<td>${countryAllMessageMap.country_poverty.fpbzxm}</td>
			<th colspan="2">派出单位及职务</th>
			<td>${countryAllMessageMap.country_poverty.fpdzpcdwjzw}</td>
			<th colspan="3">联系方式</th>
			<td colspan="4">${countryAllMessageMap.country_poverty.fpdzphonenumber}</td>
		</tr>
		<tr>
			<th colspan="2">本村存在的主要问题</th>
			<td colspan="13">${countryAllMessageMap.country_message.bcczdzywt}</td>
		</tr>
	</table>
</body>
</html>