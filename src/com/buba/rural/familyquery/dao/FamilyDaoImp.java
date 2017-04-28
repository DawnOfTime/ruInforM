package com.buba.rural.familyquery.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.pojo.FamilyMessage;

public class FamilyDaoImp  extends SqlSessionDaoSupport implements IFamilyqueryDao{
	@Override
	public Map<String,Object> getFamliyMessage(FamilyMessage familyMessage) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("family_message", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_message",familyMessage));
		map.put("family_assets", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_assets",familyMessage));
		map.put("family_vehicle", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getFamily_vehicle",familyMessage));
		map.put("family_income", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_income",familyMessage));
		map.put("family_pay", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_pay",familyMessage));
		map.put("family_shebao", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_shebao",familyMessage));
		map.put("family_other", getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.getFamily_other",familyMessage));
		map.put("cadres_home", getSqlSession().selectList("com.buba.rural.pojo.FamilyMessage.getCadres_home",familyMessage));
		map.put("familyPersonNumber",getSqlSession().selectOne("com.buba.rural.pojo.FamilyMessage.familyPersonNumber",familyMessage));
		return map;
	}
}
