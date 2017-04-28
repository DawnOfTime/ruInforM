package com.buba.rural.rule.service;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.comm.RuleMenuTreeUtil;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;
import com.buba.rural.rule.dao.IRuleDao;

public class RuleServiceImpl implements IRuleService{
	private IRuleDao iRuleDao;
	@Override
	public PageBean_easyui findMenu(Rule rule, PageBean_easyui pageBean) {
		return iRuleDao.findMenu(rule,pageBean);
	}
	@Override
	public String inserted(Rule[] rule) {
		return iRuleDao.inserted(rule);
	}
	@Override
	public String deleted(Rule[] rule) {
		return iRuleDao.deleted(rule);
	}
	@Override
	public String updated(Rule[] rule) {
		return iRuleDao.updated(rule);
	}
	@Override
	public String getTree(Rule rule) {
		List<Menu> list = iRuleDao.getTree(rule);
		RuleMenuTreeUtil treeUtil = new RuleMenuTreeUtil();
		return treeUtil.backComboTreeTreeRole(list);
	}
	@Override
	public String saveTreeMenu(Rule rule) {
		return iRuleDao.saveTreeMenu(rule);
	}
	//注入
	public void setiRuleDao(IRuleDao iRuleDao) {
		this.iRuleDao = iRuleDao;
	}
}
