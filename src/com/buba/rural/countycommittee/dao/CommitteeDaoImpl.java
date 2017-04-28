package com.buba.rural.countycommittee.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_committee;
import com.buba.rural.pojo.Country_message;

public class CommitteeDaoImpl extends SqlSessionDaoSupport implements  ICommitteeDao{
	@Override
	public PageBean_easyui seachCommittee(Country_committee countrycommittee,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countrycommittee", countrycommittee);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.CountyCommittee.queryCommittee",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public String deleted(Country_committee[] country) {
		 int a = getSqlSession().delete("com.buba.rural.pojo.CountyCommittee.deleteCommittee", country);
			String finall = "no";
			if(a>0){
				finall="ok";
			}
			return finall;
	}

	@Override
	public String updated(Country_committee[] country) {
		int a=getSqlSession().update("com.buba.rural.pojo.CountyCommittee.updateCommittee", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String addCommittee(Country_committee countrycommittee) {
		int  a = this.getSqlSession().insert("com.buba.rural.pojo.CountyCommittee.addCommittee", countrycommittee);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sex", getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.getOption","sex"));
		map.put("whcd", getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.getOption","whcdState"));
		map.put("state", getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.getOption","Officerstate"));
		map.put("zw", getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.getOption","zw_type"));
		return map;
	}

	@Override
	public List seachrecord(Country_committee countrycommittee) {
		return getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.querybg",countrycommittee);
	}

	@Override
	public List seachlishi(Country_committee countrycommittee) {
		return getSqlSession().selectList("com.buba.rural.pojo.CountyCommittee.querylishi",countrycommittee);
	}

}
