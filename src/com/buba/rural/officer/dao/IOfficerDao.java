package com.buba.rural.officer.dao;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_officer;
import com.buba.rural.pojo.Menu;

public interface IOfficerDao {
	public List<Menu> showTree();
	public PageBean_easyui queryofficer(Country_officer countryofficer,PageBean_easyui pageBean);
	public abstract String deleted(Country_officer[] country);
	public abstract String updated(Country_officer[] country);
	public abstract String addofficer(Country_officer countryofficer);
	public Map<String, Object> findOption();
	List seachrecord(Country_officer countryofficer);
	List seachlishi(Country_officer countryofficer);
}
