package com.buba.rural.groupfinance.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_group_finance;

public interface IFinanceDao {

	/*PageBean_easyui seachFinance(Country_group_finance groupfinance,PageBean_easyui pageBean);*/

	String deleted(Country_group_finance[] country);

	String updated(Country_group_finance[] country);

	String addFinance(Country_group_finance groupfinance);
	
	public Map<String, Object> findOption();

	List seachrecord(Country_group_finance groupfinance);

	List seachFinance(Country_group_finance groupfinance);

	PageBean_easyui seachlishi(Country_group_finance groupfinance,PageBean_easyui pageBean);

}
