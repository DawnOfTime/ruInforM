package com.buba.rural.population.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country;
import com.buba.rural.pojo.Person_message;

public class PopulationDaoImp extends SqlSessionDaoSupport implements IPopulationDao{

	@Override
	public PageBean_easyui querypopulation(Country country,PageBean_easyui pageBean,Person_message person_message) {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String cid = request.getParameter("cid");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageBean", pageBean);
		map.put("cid",cid);
		map.put("country", country);
		map.put("person_message", person_message);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.Popilation.queryone",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.Popilation.queryList",map));
		return pageBean;
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("xb", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","sex"));
		map.put("yhzgx", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","yhzgx"));
		map.put("zzmm", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","zzmm"));
		map.put("hyzk", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","hyState"));
		map.put("jkzk", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","jkzk"));
		map.put("whcd", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","whcdState"));
		map.put("cyzt", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","cy_state"));
		map.put("zylx", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","zy_type"));
		map.put("gzdw", getSqlSession().selectList("com.buba.rural.mapper.Popilation.getOption","gz_type"));
		return map;
	}
	
}
