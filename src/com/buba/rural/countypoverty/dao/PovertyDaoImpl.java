package com.buba.rural.countypoverty.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.Country_poverty;

public class PovertyDaoImpl  extends SqlSessionDaoSupport implements IPovertyDao{
	
	/*@Override
	public PageBean_easyui seachPoverty(Country_poverty countrypoverty,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countrypoverty", countrypoverty);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.CountyPoverty.queryPoverty",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.CountyPoverty.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}*/
	
	

	@Override
	public List seachPoverty(Country_poverty countrypoverty) {
		return getSqlSession().selectList("com.buba.rural.pojo.CountyPoverty.queryPoverty", countrypoverty);
	}

	@Override
	public String deleted(Country_poverty[] country) {
		 int a = getSqlSession().delete("com.buba.rural.pojo.CountyPoverty.deletePoverty", country);
			String finall = "no";
			if(a>0){
				finall="ok";
			}
			return finall;
	}

	@Override
	public String updated(Country_poverty[] country) {
		int a=getSqlSession().update("com.buba.rural.pojo.CountyPoverty.updatePoverty", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String addPoverty(Country_poverty countrymessage) {
		int  a = this.getSqlSession().insert("com.buba.rural.pojo.CountyPoverty.addPoverty", countrymessage);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public List seachrecord(Country_poverty countrypoverty) {
			return getSqlSession().selectList("com.buba.rural.pojo.CountyPoverty.querybg",countrypoverty);
		}

	@Override
	public PageBean_easyui seachlishi(Country_poverty countrypoverty,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countrypoverty", countrypoverty);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.CountyPoverty.queryls",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.CountyPoverty.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

}
