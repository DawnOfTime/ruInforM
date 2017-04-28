package com.buba.rural.rule.dao;

import java.util.List;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Menu;
import com.buba.rural.pojo.Rule;

public interface IRuleDao {

	PageBean_easyui findMenu(Rule rule, PageBean_easyui pageBean);

	String inserted(Rule[] rule);

	String deleted(Rule[] rule);

	String updated(Rule[] rule);

	List<Menu> getTree(Rule rule);

	String saveTreeMenu(Rule rule);

}
