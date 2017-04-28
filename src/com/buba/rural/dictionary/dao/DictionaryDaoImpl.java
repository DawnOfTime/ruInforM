package com.buba.rural.dictionary.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Dictionary;
import com.buba.rural.pojo.Person_message;

public class DictionaryDaoImpl extends SqlSessionDaoSupport implements IDictionaryDao{
	
	@Override
	public PageBean_easyui seachDic(Dictionary dictionary,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("dictionary", dictionary);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Dictionary.queryCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Dictionary.queryList",map));
		//getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.findFamilyMessage",familyMessage)
		return pageBean;
	}

	@Override
	public String inserted(Dictionary[] diction) {
		getSqlSession().insert("com.buba.rural.pojo.Dictionary.insertdictionary",diction);
		return "ok";
	}
	@Override
	public String deleted(Dictionary[] diction) {
		getSqlSession().insert("com.buba.rural.pojo.Dictionary.deletedictionary",diction);
		return "ok";
	}
	@Override
	public String updated(Dictionary[] diction) {
		for (int i = 0; i < diction.length; i++) {
			getSqlSession().insert("com.buba.rural.pojo.Dictionary.updatedictionary",diction[i]);
		}
		return "ok";
	}
}
