package com.buba.rural.land_industry.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Land_industry;
import com.buba.rural.pojo.VersionRecord;

public class Land_industryDaoImp extends SqlSessionDaoSupport implements ILand_industryDao{
	@Override
	public PageBean_easyui queryland_industry(Land_industry land_industry,
			PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("land_industry", land_industry);
		map.put("pageBean", pageBean);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.land_industry.queryone",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.land_industry.queryList",map));
		return pageBean;
	}
	
	@Override
	public String deleted(Land_industry[] land) {
		int a = getSqlSession().delete("com.buba.rural.mapper.land_industry.deleteland_industry", land);
		String finall = "no";
		if(a>0){     
			finall="ok";
		}
		return finall;
	}
	@Override
	public String updated(Land_industry[] land){
		int a=getSqlSession().update("com.buba.rural.mapper.land_industry.updateland_industry", land);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public String addland_industry(Land_industry land_industry) {
		int  a = this.getSqlSession().insert("com.buba.rural.mapper.land_industry.addland_industry", land_industry);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public Land_industry searchLand_industry(Land_industry land_industry) {
		return getSqlSession().selectOne("com.buba.rural.mapper.land_industry.searchLand_industry",land_industry);
	}

	@Override
	public List<String> searchHistory(Land_industry land_industry) {
		return getSqlSession().selectList("com.buba.rural.mapper.land_industry.searchHistory",land_industry);
	}
}
