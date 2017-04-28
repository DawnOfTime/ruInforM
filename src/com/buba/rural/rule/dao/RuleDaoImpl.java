package com.buba.rural.rule.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;

public class RuleDaoImpl extends SqlSessionDaoSupport implements IRuleDao{
	public PageBean_easyui findMenu(Rule rule, PageBean_easyui pageBean) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("rule", rule);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Rule.ruleCount",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Rule.ruleList",map));
		return pageBean;
	}
	public String inserted(Rule[] rule) {
		getSqlSession().insert("com.buba.rural.pojo.Rule.insertRule",rule);
		return "ok";
	}
	public String deleted(Rule[] rule) {
		getSqlSession().delete("com.buba.rural.pojo.Rule.deleteRule",rule);
		return "ok";
	}
	public String updated(Rule[] rules) {
		for (Rule rule : rules) {
			getSqlSession().update("com.buba.rural.pojo.Rule.updateRule",rule);
		}
		return "ok";
	}
	@Override
	public List<Menu> getTree(Rule rule) {
		Rule rules = getSqlSession().selectOne("com.buba.rural.pojo.Rule.getRule",rule);
		String menucodeStr = rules.getMenucode();
		String [] menucodeArr = menucodeStr.split(",");
		return getSqlSession().selectList("com.buba.rural.pojo.Rule.getTree",menucodeArr);
	}
	@Override
	public String saveTreeMenu(Rule rule) {
		int a = getSqlSession().update("com.buba.rural.pojo.Rule.saveTreeMenu",rule);
		if(a>0){
			return "ok";
		}
		return null;
	}
}
