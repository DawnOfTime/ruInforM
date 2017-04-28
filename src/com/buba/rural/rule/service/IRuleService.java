package com.buba.rural.rule.service;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Rule;

public interface IRuleService {

	PageBean_easyui findMenu(Rule rule, PageBean_easyui pageBean);

	String inserted(Rule[] rule);

	String deleted(Rule[] rule);

	String updated(Rule[] rule);

	String getTree(Rule rule);

	String saveTreeMenu(Rule rule);

}
