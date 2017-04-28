package com.buba.rural.floating.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Country_flow;

public class FloatingDaoImp  extends SqlSessionDaoSupport implements IFloatingDao{
	@Override
	public PageBean_easyui findFlowPerson(Country country,Country_flow country_flow,
			PageBean_easyui pageBean) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("country_flow",country_flow);
		map.put("pageBean",pageBean);
		map.put("country",country);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Floating.findCountry_flow_count",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Floating.findCountry_flow_list",map));
		return pageBean;
	}
}
