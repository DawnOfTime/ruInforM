package com.buba.rural.villageMessage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_message;
import com.buba.rural.pojo.VersionRecord;

public class VillageDaoImpl extends SqlSessionDaoSupport implements IVillageDao {
	@Override
	public PageBean_easyui seachvillage(Country_message countrymessage,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("countrymessage", countrymessage);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Village.queryvillage",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Village.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public String deleted(Country_message[] country) {
		 int a = getSqlSession().delete("com.buba.rural.pojo.Village.deletevillage", country);
			String finall = "no";
			if(a>0){
				finall="ok";
			}
			return finall;
	}

	@Override
	public String updated(Country_message[] country) {
		int a=getSqlSession().update("com.buba.rural.pojo.Village.updatevillage", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String addVillage(Country_message countrymessage) {
		int  a = this.getSqlSession().insert("com.buba.rural.pojo.Village.addVillage", countrymessage);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public List seachrecord(Country_message countrymessage) {
		return getSqlSession().selectList("com.buba.rural.pojo.Village.querybg",countrymessage);
	}

	@Override
	public List seachlishi(Country_message countrymessage) {
		List list = getSqlSession().selectList("com.buba.rural.pojo.Village.querylishi",countrymessage);
		return getSqlSession().selectList("com.buba.rural.pojo.Village.querylishi",countrymessage);
	}
}
