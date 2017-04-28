package com.buba.rural.countryMessage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_message;

public class CountryMessageDaoImpl extends SqlSessionDaoSupport implements ICountryMessageDao {

	@Override
	public Map<String, Object> findCountryAllMessage(
			Country_message country_message) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("country_message", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_Message_One",country_message));
		map.put("country_committee", getSqlSession().selectList("com.buba.rural.pojo.Country_message.findCountry_committee",country_message));
		map.put("country_officer", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_officer",country_message));
		map.put("country_building", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_building",country_message));
		map.put("country_poverty", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_poverty",country_message));
		map.put("country_communication", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_communication",country_message));
		map.put("country_group_finance", getSqlSession().selectList("com.buba.rural.pojo.Country_message.findCountry_group_finance",country_message));
		map.put("country_flow", getSqlSession().selectList("com.buba.rural.pojo.Country_message.findCountry_flow",country_message));
		map.put("county_outgoing", getSqlSession().selectList("com.buba.rural.pojo.Country_message.findCounty_outgoing",country_message));
		//总户数
		map.put("family_message", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.familyMessage",country_message));
		//总人数
		map.put("person_message", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_message",country_message));
		//男性女性
	    map.put("person_messagesexs", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagesexs",country_message));
		map.put("person_messagesexa", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagesexa",country_message));
		//常住人口
		map.put("family_assets", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_assets",country_message));
		//流动人口
		map.put("county_flow", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.county_flow",country_message));
		//少数民族
		map.put("person_messagemz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagemz",country_message));
		//文化程度
		map.put("person_messagewhcdw", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagewhcdw",country_message));
		map.put("person_messagewhcdx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagewhcdx",country_message));
		map.put("person_messagewhcdc", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagewhcdc",country_message));
		map.put("person_messagewhcdg", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagewhcdg",country_message));
		map.put("person_messagewhcdd", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagewhcdd",country_message));
		//劳动力人口
		map.put("person_messageldl", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messageldl",country_message));
		//职业状态
		map.put("person_messagecyztw", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagecyztw",country_message));
		map.put("person_messagecyztwc", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagecyztwc",country_message));
		//大学生毕业就业情况
		map.put("person_messagebyjygq", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebyjygq",country_message));
		map.put("person_messagebyjyxz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebyjyxz",country_message));
		map.put("person_messagebyjymq", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebyjymq",country_message));
		map.put("person_messagebyjyzz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebyjyzz",country_message));
		map.put("person_messagebyjywjy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebyjywjy",country_message));
		//在校情况
		map.put("person_messagezxxs", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezxxs",country_message));
		map.put("person_messagezxxsx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezxxsx",country_message));
		map.put("person_messagezxxsc", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezxxsc",country_message));
		map.put("person_messagezxxsg", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezxxsg",country_message));
		map.put("person_messagezxxsd", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezxxsd",country_message));
		//党员总数
		map.put("person_messagezzmm", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagezzmm",country_message));
		//女党员
		map.put("person_messagendy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagendy",country_message));
		//党员平均年龄
		map.put("person_messagendynl", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagendynl",country_message));
		//35岁以下党员
		map.put("person_messagendyyx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagendyyx",country_message));
		//70岁以上党员
		map.put("person_messagendyys", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagendyys",country_message));
		//老党员
		map.put("person_messagendyldy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagendyldy",country_message));
		//流入党员
		map.put("person_messagenlcdy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagenlcdy",country_message));
		//流出党员
		map.put("person_messagenlrdy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagenlrdy",country_message));
		//大专以上党员
		map.put("person_messagedxsdy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagedxsdy",country_message));
		//近3年发展党员情况
		map.put("person_messagejsndy", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagejsndy",country_message));
		//双女户
		map.put("family_messagesnh", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_messagesnh",country_message));
		//独生子女
		map.put("family_messagedszn", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_messagedszn",country_message));
		//低保户
		map.put("family_shebaodb", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaodb",country_message));
		//五保户
		map.put("family_shebaowb", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaowb",country_message));
		//残疾人
		map.put("family_shebaocjr", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaocjr",country_message));
		//特殊人群
		map.put("family_shebaotsrq", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaotsrq",country_message));
		//退伍军人
		map.put("family_othertw", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_othertw",country_message));
		//遗嘱补助
		map.put("family_shebaoyz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaoyz",country_message));
		//孤儿人数
		map.put("family_shebaoguer", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaoguer",country_message));
		//临时救助人数
		map.put("family_shebaolsjz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaolsjz",country_message));
		//大病救助人数
		map.put("family_shebaodbjz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaodbjz",country_message));
		//合作医疗参保人数
		map.put("family_shebaohzylbx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaohzylbx",country_message));
		//养老保险参保人数
		map.put("family_shebaoylbx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaoylbx",country_message));
		//60-69周岁人数
		map.put("person_messagels", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagels",country_message));
		//70-79周岁人数
		map.put("person_messageqs", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messageqs",country_message));
		//80-89周岁人数
		map.put("person_messagebs", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagebs",country_message));
		//90-99周岁人数
		map.put("person_messagejs", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messagejs",country_message));
		//100周岁以上人数
		map.put("person_messageyb", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.person_messageyb",country_message));
		//大型车辆数量
		map.put("family_vehicledx", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_vehicledx",country_message));
		//私家小轿车
		map.put("family_vehiclesj", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_vehiclesj",country_message));
		//工程机械
		map.put("family_vehiclegc", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_vehiclegc",country_message));
		//农机具
		map.put("family_vehiclenj", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_vehiclenj",country_message));
		//其他机械
		map.put("family_vehicleqt", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_vehicleqt",country_message));
		//享受社会保障总金额
		map.put("family_shebaozje", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_shebaozje",country_message));
		//土地与产业
		map.put("Land_industry", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.Land_industry",country_message));
		//计划生育
		map.put("family_otherfz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_otherfz",country_message));
		map.put("family_otherjl", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_otherjl",country_message));
		map.put("family_otherfzjl", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_otherfzjl",country_message));
		//自来用户
		map.put("family_messagezls", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_messagezls",country_message));
		map.put("family_messagezhu", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_messagezhu",country_message));
		//农村自有房
		map.put("family_assetsnc", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_assetsnc",country_message));
		//城镇住房情况
		map.put("family_assetscz", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_assetscz",country_message));
		map.put("family_assetsczpm", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_assetsczpm",country_message));
		map.put("family_assetsczzl", getSqlSession().selectOne("com.buba.rural.pojo.Country_message.family_assetsczzl",country_message));
		
		return map;
	}

	@Override
	public PageBean_easyui findCountryMessage(Country country,PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("country", country);
		map.put("pageBean", pageBean);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Country_message.findCountry_Message_Count",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Country_message.findCountry_Message",map));
		return pageBean;
	}
	
}
