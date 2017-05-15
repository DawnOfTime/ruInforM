package com.buba.rural.countryBuilding.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_building;

public class BuildingDaoImpl extends SqlSessionDaoSupport implements IBuildingDao{

	@Override
	public List seachbuilding(Country_building countrybuilding) {
		/*Map map = new HashMap();
		map.put("countrybuilding", countrybuilding);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.Building.queryCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.Building.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
*/		return getSqlSession().selectList("com.buba.rural.mapper.Building.querybuilding", countrybuilding);
	}

	@Override
	public String addaddBuilding(Country_building countrybuilding) {
		int  a = this.getSqlSession().insert("com.buba.rural.mapper.Building.addbuilding", countrybuilding);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String updated(Country_building[] country) {
		int a=getSqlSession().update("com.buba.rural.mapper.Building.updatebuilding", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String deleted(Country_building[] country) {
		 int a = getSqlSession().delete("com.buba.rural.mapper.Building.deletebuilding", country);
			String finall = "no";
			if(a>0){
				finall="ok";
			}
			return finall;
	}
	@Override
	public List seachrecord(Country_building countrybuilding) {
		return getSqlSession().selectList("com.buba.rural.mapper.Building.querybg",countrybuilding);
	}

	@Override
	public PageBean_easyui seachlishi(Country_building countrybuilding,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countrybuilding", countrybuilding);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.Building.queryCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.Building.queryList",map));
		return pageBean;
	}
}
