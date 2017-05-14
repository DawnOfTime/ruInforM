package com.buba.rural.communication.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_communication;

public class CommunicationDaoImp extends SqlSessionDaoSupport implements ICommunicationDao {

	@Override
	public List querycommunication(Country_communication communication) {
		return getSqlSession().selectList("com.buba.rural.mapper.Communication.queryList",communication);
	}
	
	@Override
	public String deleted(Country_communication[] country) {
		int a = getSqlSession().delete("com.buba.rural.mapper.Communication.deletecommunication", country);
		String finall = "no";
		if(a>0){     
			finall="ok";
		}
		return finall;
	}
	@Override
	public String updated(Country_communication[] country){
		int a=getSqlSession().update("com.buba.rural.mapper.Communication.updatecommunication", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public String addcommunicationr(Country_communication communication) {
		int  a = this.getSqlSession().insert("com.buba.rural.mapper.Communication.addcommunication", communication);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("is_ydxh", getSqlSession().selectList("com.buba.rural.mapper.Communication.getOption","communic"));
		map.put("is_ltxh", getSqlSession().selectList("com.buba.rural.mapper.Communication.getOption","communic"));
		map.put("is_dxxh", getSqlSession().selectList("com.buba.rural.mapper.Communication.getOption","communic"));
		map.put("is_qcfg", getSqlSession().selectList("com.buba.rural.mapper.Communication.getOption","communic"));
		return map;
	}

	@Override
	public List seachrecord(Country_communication communication) {
		return getSqlSession().selectList("com.buba.rural.mapper.Communication.querybg",communication);
	}

	@Override
	public PageBean_easyui seachlishi(Country_communication communication,PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("communication", communication);
		map.put("pageBean", pageBean);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.Communication.queryone",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.Communication.querylishi",map));
		return pageBean;
	}
}
