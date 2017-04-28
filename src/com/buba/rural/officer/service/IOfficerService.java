package com.buba.rural.officer.service;

import java.util.List;
import java.util.Map;

import com.buba.rural.comm.PageBean_easyui;
import com.buba.rural.pojo.Country_officer;

public interface IOfficerService {
	public String showTree();
	public PageBean_easyui queryofficer(Country_officer countryofficer,PageBean_easyui pageBean);
	public abstract String deleted(Country_officer[] officer,Country_officer countryofficer);
	public abstract String updated(Country_officer[] officer,Country_officer countryofficer);
	public abstract String addofficer(Country_officer countryofficer);
	public	Map<String, Object> findOption();
	public abstract List seachrecord(Country_officer countryofficer);
	public abstract List seachlishi(Country_officer countryofficer);
	
}
