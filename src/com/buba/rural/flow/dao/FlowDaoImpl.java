package com.buba.rural.flow.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_flow;

public class FlowDaoImpl extends SqlSessionDaoSupport implements IFlowDao{
	@Override
	public PageBean_easyui findFlowPerson(Country_flow country_flow,
			PageBean_easyui pageBean) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("country_flow",country_flow);
		map.put("pageBean",pageBean);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Country_flow.findCountry_flow_count",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Country_flow.findCountry_flow_list",map));
		return pageBean;
	}

	@Override
	public String addFlowPerson(Country_flow country_flow) {
		int a = getSqlSession().insert("com.buba.rural.pojo.Country_flow.addFlowPerson",country_flow);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String savedeleted(Country_flow[] flow) {
		int a = getSqlSession().delete("com.buba.rural.pojo.Country_flow.savedeleted",flow);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String saveupdated(Country_flow[] flow) {
		int a = getSqlSession().update("com.buba.rural.pojo.Country_flow.saveupdated",flow);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", getSqlSession().selectList("com.buba.rural.pojo.Country_flow.getOption","flowState"));
		map.put("sex", getSqlSession().selectList("com.buba.rural.pojo.Country_flow.getOption","sex"));
		map.put("hyzk", getSqlSession().selectList("com.buba.rural.pojo.Country_flow.getOption","hyState"));
		map.put("whcd", getSqlSession().selectList("com.buba.rural.pojo.Country_flow.getOption","whcdState"));
		map.put("zzmm", getSqlSession().selectList("com.buba.rural.pojo.Country_flow.getOption","zzmm"));
		return map;
	}

}
