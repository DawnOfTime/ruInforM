package com.buba.rural.groupfinance.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_group_finance;

public class FinanceDaoImpl extends SqlSessionDaoSupport implements IFinanceDao{

	@Override
	public PageBean_easyui seachFinance(Country_group_finance groupfinance,PageBean_easyui pageBean) {
		Map map = new HashMap();
		map.put("groupfinance", groupfinance);
		map.put("pageBean", pageBean);
		//获取总记录数，
		pageBean.setTotalrecord(getSqlSession().selectOne("com.buba.rural.pojo.Finance.queryFinance",map));
		//查询记录
		pageBean.setBeanList(getSqlSession().selectList("com.buba.rural.pojo.Finance.queryList",map));
		return pageBean;
	}

	@Override
	public String deleted(Country_group_finance[] country) {
		int a = getSqlSession().delete("com.buba.rural.pojo.Finance.deleteFinance", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String updated(Country_group_finance[] country) {
		int a=getSqlSession().update("com.buba.rural.pojo.Finance.updateFinance", country);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}

	@Override
	public String addFinance(Country_group_finance groupfinance) {
		int  a = this.getSqlSession().insert("com.buba.rural.pojo.Finance.addFinance", groupfinance);
		String finall = "no";
		if(a>0){
			finall="ok";
		}
		return finall;
	}
	
	@Override
	public Map<String, Object> findOption() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", getSqlSession().selectList("com.buba.rural.pojo.Finance.getOption","types"));
		return map;
	}

	@Override
	public List seachrecord(Country_group_finance groupfinance) {
		return getSqlSession().selectList("com.buba.rural.pojo.Finance.querybg",groupfinance);
	}

	@Override
	public List seachlishi(Country_group_finance groupfinance) {
		return getSqlSession().selectList("com.buba.rural.pojo.Finance.querylishi",groupfinance);
	}
}
