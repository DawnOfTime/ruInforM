package com.buba.rural.groupfinance.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_group_finance;
import com.buba.rural.pojo.Country_message;

public interface IFinanceService {
	/*public abstract PageBean_easyui seachFinance(Country_group_finance groupfinance,PageBean_easyui pageBean);*/
	public abstract String deleted(Country_group_finance[] country,Country_group_finance groupfinance);

	public abstract String updated(Country_group_finance[] country,Country_group_finance groupfinance);

	public abstract String addFinance(Country_group_finance groupfinance);
	
	public	Map<String, Object> findOption();
	public abstract List seachrecord(Country_group_finance groupfinance);
	public abstract List seachFinance(Country_group_finance groupfinance);

	public abstract PageBean_easyui seachlishi(Country_group_finance groupfinance, PageBean_easyui pageBean);

}
