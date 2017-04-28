package com.buba.rural.officer.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_officer;
import com.buba.rural.pojo.FamilyMessage;
import com.buba.rural.pojo.Menu;

public class OfficerDaoImp extends SqlSessionDaoSupport implements IOfficerDao{

	@Override
	public List<Menu> showTree() {
			return getSqlSession().selectList("com.buba.rural.pojo.Country.showCountryTree");
	}
	@Override
	public PageBean_easyui queryofficer(Country_officer countryofficer,
			PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("countryofficer", countryofficer);
		map.put("pageBean", pageBean);
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.mapper.OfficerMapper.queryone",map));
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.queryList",map));
		return pageBean;
	}
	
	@Override
	public String deleted(Country_officer[] country) {
		int a = getSqlSession().delete("com.buba.rural.mapper.OfficerMapper.deleteofficer", country);
		String finall = "no";
		if(a>0){     
			finall="ok";
		}
		return finall;
	}
	@Override
	public String updated(Country_officer[] country){
		int a=getSqlSession().update("com.buba.rural.mapper.OfficerMapper.updateofficer", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public String addofficer(Country_officer countryofficer) {
		if(null!=countryofficer.getLztime()){
			if(countryofficer.getLztime().equals("")){
				countryofficer.setLztime(null);
			}
		}
		int  a = this.getSqlSession().insert("com.buba.rural.mapper.OfficerMapper.addofficer", countryofficer);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.getOption","Officerstate"));
		map.put("sex", getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.getOption","sex"));
		map.put("whcd", getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.getOption","whcdState"));
		return map;
	}
	@Override
	public List seachrecord(Country_officer countryofficer) {
		return getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.querybg",countryofficer);
	}
	@Override
	public List seachlishi(Country_officer countryofficer) {
		return getSqlSession().selectList("com.buba.rural.mapper.OfficerMapper.querylishi",countryofficer);
	}
	}
